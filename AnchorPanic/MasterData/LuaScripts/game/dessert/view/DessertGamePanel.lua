--[[
    DessertGamePanel.lua
    甜点小游戏主面板
    ====================================
    游戏核心玩法说明：
    - 玩家在屏幕中心发射甜点物品
    - 物品沿指定角度飞向圆盘边缘
    - 相同等级的甜点会合并成更高级的甜点
    - 目标：达到目标分数或填满圆盘
    ====================================
]]

module("dessert.DessertGamePanel", Class.impl(View))

-- UI资源配置路径
UIRes = UrlManager:getUIPrefabPath("dessert/DessertGamePanel.prefab")

-- 面板配置参数
destroyTime = 0         -- 自动销毁时间：0立即销毁，1默认，999不销毁
panelType = 1            -- 窗口类型：1全屏，2弹窗，-1无底图弹窗
isScreensave = 0         -- 是否使用黑屏过渡：1全屏UI有效，默认开启，0关闭
isBlur = 0               -- 是否开启模糊背景
escapeClose = 0          -- 是否能通过ESC键关闭窗口
isShowCloseAll = false   -- 是否显示关闭所有按钮

--[[
    构造函数
    @param self 自身引用
]]
function ctor(self)
    super.ctor(self)
    -- 以下为预留配置接口，可根据需要取消注释使用
    -- self:setTxtTitle(_TT(149186))           -- 设置标题文本
    -- self:setSize(0, 0)                       -- 设置界面尺寸
    -- self:setBg("guild_bg.jpg", false, "guild") -- 设置背景图
    -- self:setUICode(LinkCode.GuildWar)        -- 设置UI关联码
end

--[[
    初始化数据
    创建游戏所需的数据结构
    @param self 自身引用
]]
function initData(self)
    super.initData(self)
    
    -- 游戏物品列表，存储当前圆盘上的所有甜点
    self.mGameItemList = {}
    
    -- 是否需要重新排列物品位置（合并后触发）
    self.needReArrange = false
end

--[[
    配置UI组件
    获取并缓存所有UI元素的引用
    @param self 自身引用
]]
function configUI(self)
    super.configUI(self)

    -- 创建开始视图（游戏开场动画）
    self.m_startView = dessert.DessertStartView.new()
    self.m_startView:initData(self:getChildGO('StartGroup'))

    -- 暂停相关按钮
    self.mBtnPause = self:getChildGO("mBtnPause")      -- 暂停按钮

    -- 暂停菜单组
    self.mGroupPause = self:getChildGO("mGroupPause")   -- 暂停面板
    self.mBtnExit = self:getChildGO("mBtnExit")         -- 退出按钮
    self.mBtnFinish = self:getChildGO("mBtnFinish")      -- 完成按钮（达成目标时显示）
    self.mBtnReplay = self:getChildGO("mBtnReplay")      -- 重玩按钮
    self.mBtnPlay = self:getChildGO("mBtnPlay")          -- 继续按钮

    -- 分数显示
    self.mTxtCurrentScore = self:getChildGO("mTxtCurrentScore"):GetComponent(ty.Text)  -- 当前分数文本
    self.mTxtTargetScore = self:getChildGO("mTxtTargetScore"):GetComponent(ty.Text)     -- 目标分数文本
    self.mIsTarget = self:getChildGO("mIsTarget")         -- 达成目标提示（显示）
    self.mIsTargetNot = self:getChildGO("mIsTargetNot")   -- 未达成目标提示（隐藏）

    -- 游戏核心组件
    self.mLauncher = self:getChildGO("mLauncher")         -- 发射器（显示发射角度的指示器）
    self.mLineRenderer = self:getChildGO("mLineRenderer"):GetComponent(ty.LineRenderer) -- 发射轨迹线
    self.mGameItem = self:getChildGO("mGameItem")         -- 游戏物品预制体
    self.mCreatePos = self:getChildGO("mCreatePos"):GetComponent(ty.RectTransform)       -- 发射位置/圆盘中心

    -- 待发射物品预览
    self.mImgCreateItem = self:getChildGO("mCreateItemContent"):GetComponent(ty.AutoRefImage)

    -- 底部分数栏
    self.mTxtScoreCur = self:getChildGO("mTxtScoreCur"):GetComponent(ty.Text)       -- 当前分数
    self.mTxtScoreTarget = self:getChildGO("mTxtScoreTarget"):GetComponent(ty.Text)  -- 目标分数

end

--[[
    初始化界面文本
    用于多语言切换时更新界面文本
    @param self 自身引用
]]
function initViewText(self)

end

--[[
    激活界面
    界面打开时调用，初始化游戏数据
    @param self 自身引用
    @param args 参数，包含dupId（副本ID）
]]
function active(self, args)
    super.active(self, args)
    
    -- 保存副本ID
    self.dupId = args.dupId
    
    -- 清空货币显示
    MoneyManager:setMoneyTidList({})
    
    -- 开始视图完成回调：隐藏开始视图，显示游戏面板
    local function _finishCall()
        self.m_startView:setActive(false)
        self:showPanel()
    end
    
    -- 显示开始视图并播放开场动画
    self.m_startView:setActive(true)
    self.m_startView:start(_finishCall)
    
    -- 初始化游戏数据
    self:initGameData()
end

--[[
    反激活（销毁工作）
    界面关闭时调用，清理游戏资源
    @param self 自身引用
]]
function deActive(self)
    super.deActive(self)
    self:clearAll()
end

--[[
    清理所有游戏资源
    停止游戏循环，销毁所有游戏物品
    @param self 自身引用
]]
function clearAll(self)
    -- 停止游戏帧循环
    if self.gameSn ~= nil then
        LoopManager:removeFrameByIndex(self.gameSn)
        self.gameSn = nil
    end

    -- 停止补间动画计时器
    if self.tweenSn ~= nil then
        LoopManager:removeTimerByIndex(self.tweenSn)
        self.tweenSn = nil
    end

    -- 清理所有游戏物品
    self:clearGameItems()
end

--[[
    UI事件绑定
    为所有按钮添加点击事件监听
    @param self 自身引用
]]
function addAllUIEvent(self)
    self:addUIEvent(self.mBtnPause, self.onClickPause)      -- 暂停按钮
    self:addUIEvent(self.mBtnExit, self.onClickExit)        -- 退出按钮
    self:addUIEvent(self.mBtnFinish, self.onClickFinish)    -- 完成按钮
    self:addUIEvent(self.mBtnReplay, self.onClickReplay)     -- 重玩按钮
    self:addUIEvent(self.mBtnPlay, self.onClickPlay)         -- 继续按钮
end

--[[
    点击完成按钮
    玩家点击"完成"表示接受当前分数，结束游戏
    @param self 自身引用
]]
function onClickFinish(self)
    self.mGroupPause:SetActive(false)
    self:onGameEnd()
end

--[[
    点击退出按钮
    玩家选择退出游戏
    @param self 自身引用
]]
function onClickExit(self)
    self:close()
end

--[[
    点击重玩按钮
    重新开始游戏
    @param self 自身引用
]]
function onClickReplay(self)
    self.isPasue = false
    self.mGroupPause:SetActive(false)
    
    -- 重新播放开场动画
    local function _finishCall()
        self.m_startView:setActive(false)
        self:showPanel()
    end
    self.m_startView:setActive(true)
    self.m_startView:start(_finishCall)
    
    -- 清理并重新初始化游戏数据
    self:clearAll()
    self:initGameData()
end

--[[
    点击继续按钮
    关闭暂停菜单，继续游戏
    @param self 自身引用
]]
function onClickPlay(self)
    self.isPasue = false
    self.mGroupPause:SetActive(false)
end

--[[
    点击暂停按钮
    显示暂停菜单，根据游戏状态显示不同按钮
    @param self 自身引用
]]
function onClickPause(self)
    -- 根据是否达成目标显示不同按钮
    if self.gameData.targetScore <= self.mScore then
        -- 已达成目标：显示"完成"按钮
        self.mBtnFinish:SetActive(true)
        self.mBtnExit:SetActive(false)
    else
        -- 未达成目标：显示"退出"按钮
        self.mBtnFinish:SetActive(false)
        self.mBtnExit:SetActive(true)
    end

    -- 设置暂停状态并显示暂停面板
    self.isPasue = true
    self.mGroupPause:SetActive(true)

    -- 更新暂停面板上的分数显示
    self.mTxtCurrentScore.text = _TT(151209) .. self.mScore           -- "当前分数：" + 分数
    self.mTxtTargetScore.text = _TT(151208) .. self.gameData.targetScore  -- "目标分数：" + 目标分数
    
    -- 显示是否达成目标的提示
    self.mIsTarget:SetActive(self.gameData.targetScore <= self.mScore)
    self.mIsTargetNot:SetActive(self.gameData.targetScore > self.mScore)
end

--[[
    清理所有游戏物品
    将物品回收到对象池
    @param self 自身引用
]]
function clearGameItems(self)
    for i = 1, #self.mGameItemList do
        local item = self.mGameItemList[i]
        item.item:poolRecover()  -- 回收物品到对象池
    end
    self.mGameItemList = {}
end

--[[
    初始化游戏数据
    设置游戏参数、获取配置数据、创建初始物品
    @param self 自身引用
]]
function initGameData(self)
    -- 获取UI相机
    self.uiCamera = gs.CameraMgr:GetUICamera()
    
    -- 发射轨迹线配置
    self.mLineRenderer.positionCount = 2     -- 轨迹线由两个点组成
    
    -- 游戏参数配置
    self.lineLength = 200                    -- 发射轨迹线长度
    self.launcherDistance = 200              -- 圆盘半径（发射距离）
    self.imgDefSize = 200                    -- 物品默认尺寸
    self.moveTime = 0.2                      -- 物品移动动画时长（秒）
    
    -- 状态标志
    self.tweenEnd = true                     -- 补间动画是否结束
    self.needReArrange = false                -- 是否需要重新排列
    self.isEnd = false                       -- 游戏是否结束
    self.isPasue = false                     -- 游戏是否暂停
    self.isFirstFinish = false               -- 是否首次达成目标

    -- 发射角度
    self.createAngle = 0

    -- 获取游戏配置数据
    self.gameData = dessert.DessertManager:getDessertDataById(self.dupId)
    self.eventList = self.gameData.eventList                   -- 事件列表（物品生成规则）
    self.maxRound = table.nums(self.eventList)                  -- 最大回合数
    self.eventId = 1                                           -- 当前回合ID

    -- 分数初始化
    self.mScore = 0
    self.mTxtScoreCur.text = self.mScore
    self.mTxtScoreTarget.text = self.gameData.targetScore

    -- 创建预览物品
    self:createPreItem()
    
    -- 清空游戏物品列表
    self:clearGameItems()
end

--[[
    显示游戏面板
    启动游戏主循环
    @param self 自身引用
]]
function showPanel(self)
    -- 先移除旧的游戏循环
    if self.gameSn ~= nil then
        LoopManager:removeFrameByIndex(self.gameSn)
        self.gameSn = nil
    end
    -- 启动新的游戏循环
    self.gameSn = LoopManager:addFrame(0, 0, self, self.updateGame)
end

--[[
    计算二维向量的点积
    @param self 自身引用
    @param lhs 左向量
    @param rhs 右向量
    @return 点积结果
]]
function dot(self, lhs, rhs)
    return lhs.x * rhs.x + lhs.y * rhs.y
end

--[[
    计算两个向量之间的夹角（度数）
    @param self 自身引用
    @param from 起始向量
    @param to 目标向量
    @return 夹角度数
]]
function angle(self, from, to)
    local num = gs.Mathf.Sqrt(from.sqrMagnitude * to.sqrMagnitude)
    if num < 0.00000000001 then
        return 0
    end
    local num2 = gs.Mathf.Clamp(self:dot(from, to) / num, -1, 1)
    return gs.Mathf.Acos(num2) * 57.29578  -- 弧度转度数
end

--[[
    计算带符号的夹角（有方向的旋转角度）
    @param self 自身引用
    @param from 起始向量
    @param to 目标向量
    @return 带符号的夹角
]]
function singleAngle(self, from, to)
    local num = self:angle(from, to)
    local num2 = gs.Mathf.Sign(from.x * to.y - from.y * to.x)  -- 叉积判断方向
    return num * num2
end

--[[
    根据回合ID获取随机物品ID
    @param self 自身引用
    @param id 回合ID
    @return 物品配置ID
]]
function randomValue(self, id)
    if id > self.maxRound then
        id = self.maxRound
    end
    -- 从该回合的物品列表中随机选一个
    local random = math.random(#self.eventList[id].iconList)
    return self.eventList[id].iconList[random]
end

--[[
    创建预览物品
    显示即将发射的物品
    @param self 自身引用
]]
function createPreItem(self)
    -- 获取随机物品ID
    self.curEventId = self:randomValue(self.eventId)
    -- 获取物品配置数据
    self.curCreateVo = dessert.DessertManager:getDessertItemData(self.curEventId)
    -- 设置预览图片
    self.mImgCreateItem:SetImg(UrlManager:getIconPath("dessert/" .. self.curCreateVo.icon), false)
    -- 设置预览尺寸
    gs.TransQuick:Scale(self.mImgCreateItem:GetComponent(ty.RectTransform), 
        self.curCreateVo.size / 100, 
        self.curCreateVo.size / 100, 
        self.curCreateVo.size / 100)
end

--[[
    游戏主循环（每帧调用）
    处理鼠标输入、发射物品、更新发射角度指示器
    @param self 自身引用
]]
function updateGame(self)
    -- 暂停或游戏结束时隐藏轨迹线
    if self.isPasue or self.isEnd then
        self.mLineRenderer.gameObject:SetActive(false)
        return
    end

    -- 检测鼠标按下
    if gs.Input.GetMouseButtonDown(0) then
        self.canCreate = true
    end

    -- 检测鼠标释放：发射物品
    if gs.Input.GetMouseButtonUp(0) and self.canCreate == true and self.createAngle and self.tweenEnd then
        self.canCreate = false
        self.tweenEnd = false

        local angle = self.createAngle or 0

        -- 回合递增
        self.eventId = self.eventId + 1
        
        -- 计算新物品半径
        local newRadius = self.curCreateVo.size / 100 * self.imgDefSize / 2
        -- 计算插入位置
        local insertIndex = self:getInsertIndex(newRadius, self.createAngle)

        -- 创建新的游戏物品
        local ballItem = SimpleInsItem:create(self.mGameItem, self.mCreatePos, "mDessertItem")
        local newItem = {
            item = ballItem,
            radius = newRadius,
            level = self.curCreateVo.id
        }
        ballItem:getChildGO("Effect01"):SetActive(false)
        AudioManager:playSoundEffect("arts/audio/UI/minigames/mng_dessert_1.prefab")
        -- 设置初始位置为发射点
        ballItem:getGo():GetComponent(ty.RectTransform).anchoredPosition = self.mCreatePos.anchoredPosition
        --ballItem:getChildGO("Effect02"):SetActive(false)

        -- 插入到列表指定位置
        table.insert(self.mGameItemList, insertIndex, newItem)
        
        -- 设置物品尺寸
        local scale = self.curCreateVo.size / 100
        gs.TransQuick:Scale(ballItem:getGo():GetComponent(ty.RectTransform), scale, scale, scale)
        
        -- 计算目标位置（沿发射角度移动到圆盘边缘）
        local endPos = gs.Vector2(
            gs.Mathf.Cos(self.createAngle) * self.launcherDistance,
            gs.Mathf.Sin(self.createAngle) * self.launcherDistance
        )

        -- 设置物品图片
        ballItem:getGo():GetComponent(ty.AutoRefImage):SetImg(
            UrlManager:getIconPath("dessert/" .. self.curCreateVo.icon), false)

        -- 移动到目标位置
        local v3Pos = gs.Vector3(
            self.mCreatePos.anchoredPosition.x + endPos.x, 
            self.mCreatePos.anchoredPosition.y + endPos.y, 
            0
        )
        TweenFactory:move2Lpos(ballItem:getGo():GetComponent(ty.RectTransform), v3Pos, self.moveTime,nil)

        -- 创建下一个预览物品
        self:createPreItem()
        
        -- 移动完成后更新位置并检查合并
        self:setTimeout(self.moveTime, function()
            self:updateMove()
        end)
        
    end

    -- 更新发射角度指示器
    if self.canCreate and self.tweenEnd then
        -- 获取鼠标世界坐标
        local mousePos = self.uiCamera:ScreenToWorldPoint(gs.Input.mousePosition)
        -- 计算相对于发射点的方向
        local v2 = gs.Vector2(
            mousePos.x - self.mCreatePos.position.x, 
            mousePos.y - self.mCreatePos.position.y
        )
        self.createAngle = gs.Mathf.Atan2(v2.y, v2.x)
        
        -- 计算发射器朝向
        local direction = (mousePos - gs.Vector3(
            self.mLauncher.transform.position.x, 
            self.mLauncher.transform.position.y, 
            0
        )).normalized
        local dirV2 = gs.Vector2(direction.x, direction.y)
        local angle = self:singleAngle(gs.VEC2_UP, dirV2)

        -- 旋转发射器
        local euler = gs.Quaternion.Euler(0, 0, angle)
        euler = euler * gs.Vector3.up
        euler = gs.Vector3(euler.x, euler.y, 0)
        self.mLauncher.transform.rotation = gs.Quaternion.LookRotation(gs.Vector3.forward, euler)

        -- 绘制发射轨迹线
        self.mLineRenderer:SetPosition(0, self.mLauncher.transform.position)
        local lineDir = self.mLauncher.transform.up
        self.mLineRenderer.positionCount = 2
        self.mLineRenderer:SetPosition(1, self.mLauncher.transform.position + lineDir * self.lineLength)
        self.mLineRenderer.gameObject:SetActive(false)
    else
        self.mLineRenderer.gameObject:SetActive(false)
    end
end

--[[
    校验参数是否合理
    检查所有物品是否能容纳在圆盘内
    @param self 自身引用
    @return true 合理，false 不合理（游戏失败）
]]
function validateParameters(self)
    local items = self.mGameItemList
    local n = #items
    if n == 0 then
        return true
    end
    local R = self.launcherDistance
    local totalCoverage = 0
    
    -- 计算每个物品的覆盖弧度
    for i = 1, #items do
        local halfAngle = gs.Mathf.Asin(gs.Mathf.Min(items[i].radius / R, 1))
        totalCoverage = totalCoverage + 2 * halfAngle
    end
    
    -- 总覆盖弧度不能超过圆周
    return totalCoverage <= 2 * gs.Mathf.PI
end

--[[
    检查是否可以添加指定半径的物品
    考虑物品插入后的合并情况
    @param self 自身引用
    @param newRadius 新物品半径
    @param insertIndex 插入位置
    @return true 可以添加，false 不能添加
]]
-- function canAddWithRadius(self, newRadius, insertIndex)
--     -- 创建临时半径数组
--     local tempRadii = {}
--     local n = #self.mGameItemList
--     for i = 1, n + 1 do
--         if i < insertIndex then
--             tempRadii[i] = self.mGameItemList[i].radius
--         elseif i == insertIndex then
--             tempRadii[i] = newRadius
--         else
--             tempRadii[i] = self.mGameItemList[i - 1].radius
--         end
--     end

--     -- 递归合并所有可能合并的物品
--     local function mergeAll(radii)
--         local changed = false
--         local i = 1
--         while i < #radii do
--             -- 检查相邻物品是否可以合并（相同大小）
--             if math.abs(radii[i] - radii[i + 1]) < 0 then
--                 local newR = radii[i] * 1.2  -- 合并后半径增大
--                 table.remove(radii, i + 1)
--                 table.remove(radii, i)
--                 table.insert(radii, i, newR)
--                 changed = true
--                 i = gs.Mathf.Max(1, i - 1)  -- 回退检查
--             else
--                 i = i + 1
--             end
--         end
--         if changed then
--             mergeAll(radii) -- 递归直到稳定
--         end
--     end

--     mergeAll(tempRadii)

--     -- 检查相邻物品是否会重叠
--     local R = self.launcherDistance
--     for i = 1, #tempRadii - 1 do
--         if tempRadii[i] + tempRadii[i + 1] > 2 * R then
--             return false
--         end
--     end
    
--     -- 检查总覆盖弧度
--     local totalCoverage = 0
--     for i = 1, #tempRadii do
--         local halfAngle = gs.Mathf.Asin(gs.Mathf.Min(tempRadii[i] / R, 1))
--         totalCoverage = totalCoverage + 2 * halfAngle
--     end
--     return totalCoverage <= 2 * gs.Mathf.PI
-- end

--[[
    计算所有物品的目标角度
    @param self 自身引用
    @return 角度数组
]]
function calcuateTargetAngles(self)
    local radii = {}
    for i = 1, #self.mGameItemList do
        table.insert(radii, self.mGameItemList[i].radius)
    end
    return self:calculateAnglesForRadii(radii)
end

--[[
    计算角度差（带符号）
    @param self 自身引用
    @param from 起始角度
    @param to 目标角度
    @return 角度差（-180到180之间）
]]
function deltaAngle(self, from, to)
    local diff = (to - from) % 360
    if diff > 180 then
        diff = diff - 360
    end
    return diff
end

--[[
    根据半径计算每个物品的目标角度
    使用弦长公式计算物品在圆盘上的位置
    @param self 自身引用
    @param radii 半径数组
    @return 角度数组（弧度）
]]
function calculateAnglesForRadii(self, radii)
    local n = #radii
    if n == 0 then
        return {}
    end
    
    -- 相邻物品之间的角度增量
    local deltaAngles = {}
    for i = 1, n - 1 do
        local r1 = radii[i]
        local r2 = radii[i + 1]
        local chord = r1 + r2  -- 弦长
        
        -- 限制弦长不超过直径
        if chord > 2 * self.launcherDistance then
            chord = 2 * self.launcherDistance - 0.01
        end
        
        -- 计算角度
        local halfChord = math.min(1, chord / (2 * self.launcherDistance))
        local delta = 2 * gs.Mathf.Asin(halfChord)
        table.insert(deltaAngles, delta)
    end
    
    -- 累积角度
    local angles = {0}
    for i = 2, n do
        angles[i] = angles[i - 1] + deltaAngles[i - 1]
    end

    -- 计算起始角度，使物品居中
    local totalSpan = angles[n] - angles[1]
    local startAngle = -gs.Mathf.PI / 2 - totalSpan / 2
    local result = {}
    for i = 1, n do
        result[i] = startAngle + angles[i]
    end
    return result
end

--[[
    获取插入索引
    根据发射角度计算物品应该插入的位置
    @param self 自身引用
    @param newRadius 新物品半径
    @param currentAngle 当前发射角度（弧度）
    @return 最佳插入位置索引
]]
function getInsertIndex(self, newRadius, currentAngle)
    local n = #self.mGameItemList
    if n == 0 then
        return 1
    end

    local bestIndex = 1
    local bestDiff = math.huge

    -- 遍历所有可能的插入位置
    for pos = 1, n + 1 do
        local tempRadii = {}
        for i = 1, n + 1 do
            if i < pos then
                tempRadii[i] = self.mGameItemList[i].radius
            elseif i == pos then
                tempRadii[i] = newRadius
            else
                tempRadii[i] = self.mGameItemList[i - 1].radius
            end
        end
        
        -- 计算该位置的目标角度
        local angles = self:calculateAnglesForRadii(tempRadii)
        local targetAngle = angles[pos]
        
        -- 计算与发射角度的差异
        local diff = math.abs(self:deltaAngle(currentAngle * gs.Mathf.Rad2Deg, targetAngle * gs.Mathf.Rad2Deg))
        
        if diff < bestDiff then
            bestDiff = diff
            bestIndex = pos
        end
    end
    return bestIndex
end

--[[
    清除无效物品
    移除已被销毁或为空的物品引用
    @param self 自身引用
]]
function clearInvalidItems(self)
    local i = 1
    while i <= #self.mGameItemList do
        local item = self.mGameItemList[i]
        if not item or not item.item then
            table.remove(self.mGameItemList, i)
        else
            local go = item.item:getGo()
            if not go then
                table.remove(self.mGameItemList, i)
            else
                i = i + 1
            end
        end
    end
end

--[[
    移动物品到对应位置
    执行动画将物品移动到计算出的目标位置
    并检查游戏状态
    @param self 自身引用
]]
function updateMove(self)
    -- 先清除无效物品
    self:clearInvalidItems()

    -- -- 检查游戏是否还能继续
    -- local isValid = self:validateParameters()
    -- if not isValid then
    --     self:onGameEnd()
    --     return
    -- end

    -- 计算所有物品的目标角度
    local moveAngleList = self:calcuateTargetAngles()
    local startAngles = {}
    local deltaAngles = {}
    local elapsed = 0

    -- 准备移动数据
    for i = 1, #self.mGameItemList do
        local item = self.mGameItemList[i]
        if not item or not item.item then
            -- 数据异常，重新检查
            self:clearInvalidItems()
            self:updateMove()
            return
        end

        -- 获取当前位置
        local curPos = self.mGameItemList[i].item:getGo():GetComponent(ty.RectTransform).position
        local formCenter = curPos - self.mCreatePos.position
        
        -- 计算当前角度和目标角度
        local currentAngle = gs.Mathf.Atan2(formCenter.y, formCenter.x)
        local targetAngle = moveAngleList[i]
        local deltaAngle = self:deltaAngle(currentAngle * gs.Mathf.Rad2Deg, targetAngle * gs.Mathf.Rad2Deg) * gs.Mathf.Deg2Rad

        startAngles[i] = currentAngle
        deltaAngles[i] = deltaAngle
    end

    -- 移除旧的计时器
    if self.tweenSn then
        LoopManager:removeTimerByIndex(self.tweenSn)
        self.tweenSn = nil
    end

    -- 启动移动动画
    self.tweenSn = LoopManager:addTimer(0.01, 0, self, function()
        if elapsed < self.moveTime then
            -- 动画进行中：插值移动
            elapsed = elapsed + gs.Time.deltaTime
            local t = elapsed / self.moveTime
            
            for i = 1, #self.mGameItemList do
                -- 检查数据是否有效
                if not startAngles[i] or not deltaAngles[i] then
                    LoopManager:removeTimerByIndex(self.tweenSn)
                    self.tweenSn = nil
                    self:updateMove()
                    return
                end
                
                -- 计算插值角度
                local currentAngle = startAngles[i] + deltaAngles[i] * t
                local endPos = gs.Vector2(
                    gs.Mathf.Cos(currentAngle) * self.launcherDistance,
                    gs.Mathf.Sin(currentAngle) * self.launcherDistance
                )
                local rect = self.mGameItemList[i].item:getGo():GetComponent(ty.RectTransform)
                gs.TransQuick:UIPos(rect, 
                    self.mCreatePos.anchoredPosition.x + endPos.x,
                    self.mCreatePos.anchoredPosition.y + endPos.y)
            end
            self.tweenEnd = false
        else
            -- 动画结束：精确放置到目标位置
            for i = 1, #self.mGameItemList do
                local finalAngle = startAngles[i] + deltaAngles[i]
                local endPos = gs.Vector2(
                    gs.Mathf.Cos(finalAngle) * self.launcherDistance,
                    gs.Mathf.Sin(finalAngle) * self.launcherDistance
                )
                local rect = self.mGameItemList[i].item:getGo():GetComponent(ty.RectTransform)
                gs.TransQuick:UIPos(rect,
                    self.mCreatePos.anchoredPosition.x + endPos.x,
                    self.mCreatePos.anchoredPosition.y + endPos.y)
            end
            
            -- 停止计时器
            LoopManager:removeTimerByIndex(self.tweenSn)
            self.tweenSn = nil
            self.tweenEnd = true

            -- 检查并处理合并 修改成合并一对
            local hasMerge = self:checkAndMerge()
            if hasMerge then
                self:updateMove()
                return
            end

            -- 最终检查游戏状态
            if not self:validateParameters() then
                self:onGameEnd()
            end
        end
    end)

end

--[[
    检查并合并相同的物品
    遍历列表，将相邻的同等级物品合并成更高级的物品
    @param self 自身引用
]]
function checkAndMerge(self)
    local i = 1
    
    while i < #self.mGameItemList do
        local curr = self.mGameItemList[i]
        local next = self.mGameItemList[i + 1]
        
        -- 检查是否相同等级且未达到最高等级
        if curr.level == next.level and curr.level < 6 then
            local newLevel = curr.level + 1
            local newVo = dessert.DessertManager:getDessertItemData(newLevel)
            AudioManager:playSoundEffect("arts/audio/UI/minigames/mng_dessert_2.prefab")
            
            -- 增加分数
            self.mScore = self.mScore + newVo.score
            self.mTxtScoreCur.text = self.mScore

            -- 检查是否首次达成目标
            if self.mScore >= self.gameData.targetScore and self.isFirstFinish == false then
                self.isFirstFinish = true
                self:onClickPause()
            end

            -- 计算新物品属性
            local newRadius = newVo.size / 100 * self.imgDefSize / 2
            
            -- 创建新物品
            local newItemGo = SimpleInsItem:create(self.mGameItem, self.mCreatePos, "mDessertItem")
            local newItem = {
                item = newItemGo,
                radius = newRadius,
                level = newLevel
            }

            -- 设置新物品图片
            newItemGo:getGo():GetComponent(ty.AutoRefImage):SetImg(
                UrlManager:getIconPath("dessert/" .. newVo.icon), false)
            newItemGo:getChildGO("Effect01"):SetActive(true)
            self:setTimeout(1, function()
                if newItemGo and newItemGo:getChildGO("Effect01") then
                   newItemGo:getChildGO("Effect01"):SetActive(false)
                end
            end)
            -- 设置新物品尺寸
            gs.TransQuick:Scale(newItem.item:getGo():GetComponent(ty.RectTransform), 
                newVo.size / 100, newVo.size / 100, newVo.size / 100)

            -- 计算合并后新物品的位置
            -- 两个旧物品中心连线的中点，映射到圆盘边缘
            local pos1 = curr.item:getGo():GetComponent(ty.RectTransform).anchoredPosition
            local pos2 = next.item:getGo():GetComponent(ty.RectTransform).anchoredPosition
            local midPosLocal = gs.Vector2((pos1.x + pos2.x) / 2, (pos1.y + pos2.y) / 2)
            local dirAngle = gs.Mathf.Atan2(midPosLocal.y, midPosLocal.x)
            local onCirclePos = self.mCreatePos.anchoredPosition +
                                gs.Vector2(
                                    gs.Mathf.Cos(dirAngle) * self.launcherDistance,
                                    gs.Mathf.Sin(dirAngle) * self.launcherDistance
                                )
            gs.TransQuick:UIPos(newItem.item:getGo():GetComponent(ty.RectTransform), 
                onCirclePos.x, onCirclePos.y)

            -- 回收旧物品
            curr.item:poolRecover()
            next.item:poolRecover()

            -- 从列表中移除旧物品
            table.remove(self.mGameItemList, i + 1)
            table.remove(self.mGameItemList, i)

            -- 插入新物品
            table.insert(self.mGameItemList, i, newItem)

            self.needReArrange = true
            return true
        else
            i = i + 1
        end
    end

    -- 如果有合并发生，递归检查是否还有更多合并
    return false
end

--[[
    请求事件
    向服务器发送事件请求
    @param self 自身引用
    @param level 等级
]]
function onReqEvent(self, level)
    GameDispatcher:dispatchEvent(EventName.REQ_DESSERT_EVENT, level)
end

--[[
    游戏结束
    处理游戏结束逻辑，显示结算面板
    @param self 自身引用
]]
function onGameEnd(self)
    cusLog("游戏结束")
    self.isEnd = true

    -- 获取历史记录
    local his = dessert.DessertManager:getDupPassStar(self.dupId)
    local isPass = dessert.DessertManager:getDupPassState(self.dupId)
    local isFirst = false
    
    -- 判断是否首次通关
    if self.mScore >= self.gameData.targetScore and isPass == false then
        isFirst = true
    end
    
    -- 打开结算面板
    GameDispatcher:dispatchEvent(EventName.OPEN_DESSERT_SETTLE_PANEL, {
        dupId = self.dupId,      -- 副本ID
        score = self.mScore,     -- 得分
        first = isFirst          -- 是否首次通关
    })
end

return _M
