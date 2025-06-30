-- @FileName:   LinklinkSceneUI.lua
-- @Description:   描述
-- @Author: ZDH
-- @Date:   2024-07-03 17:48:19
-- @Copyright:   (LY) 2024 锚点降临

module('game.linklink.view.LinklinkSceneUI', Class.impl(View))

--对应的ui文件
UIRes = UrlManager:getUIPrefabPath("linklink/LinklinkSceneUI.prefab")

destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = 1 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗
isScreensave = 0 -- 是否使用黑屏过渡(仅1全屏UI有效，默认开启，0关闭)
isBlur = 0
escapeClose = 0 -- 是否能通过esc关闭窗口
isShowCloseAll = false

--构造函数
function ctor(self)
    super.ctor(self)
    -- self:setSize(750, 600)
    -- self:setBg("")
    -- self:setTxtTitle(_TT(138601))
    self:setUICode(LinkCode.Linklink)
end

function initData(self)
    self.m_MaxCol, self.m_MaxRow = 6, 11
    self.m_CardSize = 86
end

-- 初始化
function configUI(self)
    self.m_startView = fightUI.FightStartView.new()
    self.m_startView:initData(self:getChildGO('StartGroup'))

    self.mImgBg = self:getChildGO("mImgBg"):GetComponent(ty.AutoRefImage)

    self.mStarProgress = self:getChildGO("mStarProgress"):GetComponent(ty.RectTransform)
    self.mStarProgressHeight = self.mStarProgress.rect.height
    self.mStarLineGroup = self:getChildGO("mStarLineGroup")

    self.mStarLine_1 = self:getChildGO("mStarLine_1")
    self.mStarLine_2 = self:getChildGO("mStarLine_2")
    self.mStarLine_3 = self:getChildGO("mStarLine_3")

    self.mStar_3 = self:getChildGO("mStar_3")
    self.mStar_2 = self:getChildGO("mStar_2")
    self.mStar_1 = self:getChildGO("mStarLine_1")
    self.mTextTime = self:getChildGO("mTextTime"):GetComponent(ty.Text)

    self.mBtnPause = self:getChildGO("mBtnPause")

    self.mCardLayer = self:getChildTrans("mCardLayer")
    self.mCardItem = self:getChildGO("mCardItem")

    self.mGroupPause = self:getChildGO("mGroupPause")
    self.mGroupStar = self:getChildTrans("mGroupStar")

    self.mBtnReplay = self:getChildGO("mBtnReplay")
    self.mBtnPlay = self:getChildGO("mBtnPlay")
    self.mBtnExit = self:getChildGO("mBtnExit")

    self.mImgStart = self:getChildGO("mImgStart")
    self.mImgPause = self:getChildGO("mImgPause")

    self.mLineder = self:getChildGO("mLineder")
    self.mLinederComponent = self.mLineder:GetComponent(ty.LineRenderer)

    self.mImgTween = self:getChildGO("mImgTween")
    self.mSceneLayer = self:getChildTrans("mSceneLayer")
end

function initViewText(self)

end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)
    self:addUIEvent(self.mBtnPause, self.onPauseClick)

    self:addUIEvent(self.mBtnReplay, self.onReplayClick)
    self:addUIEvent(self.mBtnPlay, self.onPlayClick)
    self:addUIEvent(self.mBtnExit, self.onExitClick)
end

--激活
function active(self, args)
    super.active(self)

    self:AddEventListener()

    self.mLineder:SetActive(false)

    self:createSceneCard()
    self:refreshView(args)

    self:refreshPauseState(false)

    self.mGroupPause:SetActive(false)
end

--反激活（销毁工作）
function deActive(self)
    super.deActive(self)

    self:RemoveEventListener()

    self:clearData(true)

    self.m_MaxCol = nil
    self.m_MaxRow = nil
    self.m_CardSize = nil
end

function clearData(self, deActive)
    self:clearCard(deActive)
    self:clearStarItem()

    self:clearTimerSn()

    self.m_LateSelectCard = nil
    self.m_ResetCardTween = nil
    self.m_CurTime = nil
    self.m_DupConfigVo = nil
end

function AddEventListener(self)
    GameDispatcher:addEventListener(EventName.LINKLINK_UPDATE_PAUSESTATE, self.refreshPauseState, self)
end

function RemoveEventListener(self)
    GameDispatcher:removeEventListener(EventName.LINKLINK_UPDATE_PAUSESTATE, self.refreshPauseState, self)
end

function refreshView(self, args)
    self:clearData()

    self.m_DupConfigVo = args

    local function _finishCall()
        self.m_startView:setActive(false)

        self:onStartGame()
    end
    self.m_startView:setActive(true)
    self.m_startView:start(_finishCall)

    self.mTextTime.text = "--:--"
    self.mLineder:SetActive(false)
    self.mStarLineGroup:SetActive(false)
end

-- 暂停
function onPauseClick(self)
    if self.m_ResetCardTween then
        return
    end

    GameDispatcher:dispatchEvent(EventName.LINKLINK_UPDATE_PAUSESTATE, true)
    self.mGroupPause:SetActive(true)
    self:updateStarInfo()

    self:checkResetCardPos()
end

-- 继续
function onPlayClick(self)
    GameDispatcher:dispatchEvent(EventName.LINKLINK_UPDATE_PAUSESTATE, false)

    self.mGroupPause:SetActive(false)
end

-- 重新开始
function onReplayClick(self)
    GameDispatcher:dispatchEvent(EventName.LINKLINK_UPDATE_PAUSESTATE, false)

    self.mGroupPause:SetActive(false)
    self:refreshView(self.m_DupConfigVo)
end

-- 退出
function onExitClick(self)
    self:close()
end

function refreshPauseState(self, pauseState)
    self.mImgStart:SetActive(pauseState)
    self.mImgPause:SetActive(not pauseState)

    linklink.LinklinkManager:setIsPause(pauseState)
end

--创建所有卡牌
function createSceneCard(self)
    if not self.m_GridDic then
        self.m_GridDic = {}

        if gs.Application.isEditor then
            linklink.LinklinkCardItem = require("game/linklink/view/item/LinklinkCardItem")
        end

        for row = 0, self.m_MaxRow + 1 do
            self.m_GridDic[row] = {}

            for col = 0, self.m_MaxCol + 1 do
                local pos = {x = self.m_CardSize / 2 + (self.m_CardSize * (row - 1)), y = (self.m_CardSize / 2 + (self.m_CardSize * (col - 1))) *- 1}
                local item = linklink.LinklinkCardItem:create(self.mCardItem, self.mCardLayer, "LinklinkSceneUI_CardItem")

                item:setData(col, row)
                item:setPos(pos.x, pos.y)

                self.m_GridDic[row][col] =
                {
                    item = item,
                    isEmpty = true;
                }
            end
        end
    end
end

function createThing(self)
    local cardTypeList = {}
    for _, create in pairs(self.m_DupConfigVo.create_list) do
        local creat_count = create[2]
        local type = create[1]
        for i = 1, creat_count do
            table.insert(cardTypeList, type)
        end
    end

    for id, config in pairs(self.m_DupConfigVo.thing_list) do
        local col, row = config.pos[1], config.pos[2]
        if self.m_GridDic[row] ~= nil then
            if self.m_GridDic[row][col] ~= nil then
                local item = self.m_GridDic[row][col].item
                if item ~= nil then
                    if config.grid_id == 1 then
                        item:setType(0)
                        self.m_GridDic[row][col].isEmpty = false

                    else
                        if not table.empty(cardTypeList) then
                            local random_index = math.random(1, #cardTypeList)
                            local type = cardTypeList[random_index]
                            table.remove(cardTypeList, random_index)

                            item:setType(type, self, self.onCardClick)

                            self.m_GridDic[row][col].isEmpty = false
                            -- else
                            --     logError(string.format("卡片生成数量不够了！！！[%s][%s]  ", col, row))
                        end
                    end
                end
            end
        end
    end
end

function deleteCard(self, row, col, showEffect)
    if self.m_GridDic[row] then
        if self.m_GridDic[row][col] then
            self.m_GridDic[row][col].item:onHitGroupInfo(showEffect)
            self.m_GridDic[row][col].isEmpty = true
        end
    end
end

function clearCard(self, deActive)
    if not self.m_GridDic then
        return
    end

    for row, col_dic in pairs(self.m_GridDic) do
        for col, info in pairs(col_dic) do
            if deActive then
                if info.item then
                    info.item:poolRecover()
                end
            else
                if info.isEmpty == false then
                    self:deleteCard(row, col)
                end
            end
        end
    end

    if deActive then
        self.m_GridDic = nil
    end
end

function onCardClick(self, card)
    -- AudioManager:playSoundEffect("arts/audio/UI/minigames/mng_linklink_1.prefab")

    if self.m_LateSelectCard == nil then
        self.m_LateSelectCard = card
    else
        local data_1 = self.m_LateSelectCard:getData()
        local data_2 = card:getData()

        if data_1.type ~= data_2.type then
            self.m_LateSelectCard:recoverSelect()
            self.m_LateSelectCard = card
            return
        elseif data_1.col == data_2.col and data_1.row == data_2.row then
            self.m_LateSelectCard = nil
            return
        end

        local point = self:getLinkPoints(data_1.col, data_1.row, data_2.col, data_2.row)
        local pointNum = table.nums(point)
        if pointNum > 0 then
            self:setTimeout(0.2, function ()
                AudioManager:playSoundEffect("arts/audio/UI/minigames/mng_linklink_2.prefab")
            end)

            self.mLineder:SetActive(false)
            self.mLineder:SetActive(true)
            self.mLinederComponent.positionCount = pointNum + 1

            local item = self.m_GridDic[data_1.row][data_1.col].item
            local position = item:getPosition()

            self.mLinederComponent:SetPosition(0, gs.Vector3(position.x, position.y, 0))

            for i = 1, pointNum do
                local p = point[i]
                if self.m_GridDic[p.row][p.col] then
                    item = self.m_GridDic[p.row][p.col].item
                    position = item:getPosition()
                    self.mLinederComponent:SetPosition(i, gs.Vector3(position.x, position.y, 0))
                end
            end

            self:deleteCard(data_1.row, data_1.col, true)
            self:deleteCard(data_2.row, data_2.col, true)

            local isOver = true
            for row, col_dic in pairs(self.m_GridDic) do
                for col, info in pairs(col_dic) do
                    if info.isEmpty == false then
                        local data = info.item:getData()
                        if data.type ~= 0 then
                            isOver = false
                            break
                        end
                    end
                end
            end

            if isOver then
                self:setTimeout(0.5, function ()
                    local time_limit = self.m_DupConfigVo.time_limit
                    for i = 1, #time_limit do
                        if self.m_CurTime <= time_limit[i] then
                            GameDispatcher:dispatchEvent(EventName.ONREQ_LINKLINK_PASS_DUP, {dup_id = self.m_DupConfigVo.tid, star = i})
                            break
                        end
                    end
                end)
                return
            end

            self:setTimeout(0.5, function ()
                self:checkResetCardPos()
            end)
        else
            AudioManager:playSoundEffect("arts/audio/UI/minigames/mng_linklink_3.prefab")
        end

        self.m_LateSelectCard:recoverSelect()
        self.m_LateSelectCard = nil

        card:recoverSelect()
    end
end

function checkResetCardPos(self)
    ---把相同类型的放到一个列表里面方便操作
    local tab = {}
    for row, col_dic in pairs(self.m_GridDic) do
        for col, info in pairs(col_dic) do
            if info.isEmpty == false then
                local data = info.item:getData()
                if data.type ~= nil and data.type ~= 0 then
                    if tab[data.type] == nil then
                        tab[data.type] = {}
                    end
                    table.insert(tab[data.type], data)
                end
            end
        end
    end

    --相同类型的检测能否连线
    for type, list in pairs(tab) do
        for i = 1, #list do
            local data_1 = list[i]
            for j = 1, #list do
                if i ~= j then
                    local data_2 = list[j]
                    local canLink = self:canLink(data_1.col, data_1.row, data_2.col, data_2.row)
                    if canLink then --存在可以连线的卡牌，不执行洗牌
                        return
                    end
                end
            end
        end
    end

    --随机获取一个可以摆放的位置
    local function getRandomPos (old_row, old_col)
        local col, row = math.random(1, self.m_MaxCol), math.random(1, self.m_MaxRow)
        if (old_row == row and old_col == col) or self.m_GridDic[row][col].isEmpty == false then
            return getRandomPos(old_row,old_col)
        else
            return {row, col}
        end
    end

    --随机获取两个可以连线的位置
    local function getCanLinkPoint ()
        local pos_1 = getRandomPos()
        local pos_2 = getRandomPos(pos_1[1], pos_1[2])
        if self:canLink(pos_1[2], pos_1[1], pos_2[2], pos_2[1]) then
            return pos_1, pos_2
        else
            return getCanLinkPoint()
        end
    end

    --拿到动画位置信息
    local tween_pos = {}
    for type, list in pairs(tab) do
        for i = 1, #list, 2 do
            local pos_1, pos_2 = getCanLinkPoint()

            local info_1 = {start_row = list[i].row, start_col = list[i].col, end_row = pos_1[1], end_col = pos_1[2], type = list[i].type}
            local info_2 = {start_row = list[i + 1].row, start_col = list[i + 1].col, end_row = pos_2[1], end_col = pos_2[2], type = list[i + 1].type}

            self.m_GridDic[info_1.end_row][info_1.end_col].isEmpty = false
            self.m_GridDic[info_2.end_row][info_2.end_col].isEmpty = false

            table.insert(tween_pos, info_1)
            table.insert(tween_pos, info_2)
        end

        for i = 1, #list do
            self:deleteCard(list[i].row, list[i].col)
        end
    end

    --动画卡牌
    self.m_ResetCardTween = true
    for i = 1, #tween_pos do
        self:doCardTween(tween_pos[i])
    end

    self:setTimeout(1.2, function ()
        self.m_ResetCardTween = nil
    end)
end

function doCardTween(self, info)
    local item = SimpleInsItem:create(self.mImgTween, self.mSceneLayer, "LinklinkSceneUI_TweenImage")

    item:getGo():GetComponent(ty.AutoRefImage):SetImg(string.format("arts/ui/pack/linklink/icon (%s).png", info.type))

    local start_pos = self.m_GridDic[info.start_row][info.start_col].item:getUIPos()
    local end_pos = self.m_GridDic[info.end_row][info.end_col].item:getUIPos()

    item:setPos(start_pos.x, start_pos.y)

    local rectTrans = item:getGo():GetComponent(ty.RectTransform)
    local tweener = rectTrans:DOMoveUI(gs.Vector2(478, -261), 0.6)
    tweener:OnComplete(function ()
        tweener:Kill()
        tweener = nil

        tweener = rectTrans:DOMoveUI(end_pos, 0.6)
        tweener:OnComplete(function ()
            tweener:Kill()
            tweener = nil

            self.m_GridDic[info.end_row][info.end_col].item:setType(info.type, self, self.onCardClick)

            item:poolRecover()
        end)
    end)
end

function onStartGame(self)
    local time_limit = self.m_DupConfigVo.time_limit
    for i = #time_limit, 2, -1 do
        local line = self:getChildGO("mStarLine_" .. i):GetComponent(ty.RectTransform)
        line.anchoredPosition = gs.Vector2(line.anchoredPosition.x, (time_limit[i] - time_limit[i - 1]) / time_limit[3] * self.mStarProgressHeight)
    end

    local line_1 = self.mStarLine_1:GetComponent(ty.RectTransform)
    line_1.anchoredPosition = gs.Vector2(line_1.anchoredPosition.x, 0)
    self.mStarLineGroup:SetActive(true)

    for i = 1, 3 do
        self:getChildGO("line_" .. i):SetActive(true)
    end

    local maxTime = self.m_DupConfigVo.time_limit[3]
    self.m_CurTime = maxTime

    self:refreshTime(0)
    -- self.m_TimerFrameSn = LoopManager:addFrame(1, 0, self, self.refreshTime)

    self:createThing()
end

function clearTimerSn(self)
    if self.m_TimerFrameSn then
        LoopManager:removeFrameByIndex(self.m_TimerFrameSn)
        self.m_TimerFrameSn = nil
    end
end

function refreshTime(self, deltaTime)
    if gs.Time.timeScale == 0 or linklink.LinklinkManager:getIsPause() then
        return
    end

    self.m_CurTime = self.m_CurTime - deltaTime
    self.mTextTime.text = TimeUtil.getHMSByTime_1(self.m_CurTime)

    if self.m_CurTime < 1 then
        self:clearTimerSn()

        for row, col_dic in pairs(self.m_GridDic) do
            for col, info in pairs(col_dic) do
                if info.isEmpty == false then
                    GameDispatcher:dispatchEvent(EventName.ONREQ_LINKLINK_PASS_DUP, {dup_id = self.m_DupConfigVo.tid, star = 0})
                    break
                end
            end
        end

        self:getChildGO("line_1"):SetActive(false)
        gs.TransQuick:SizeDelta02(self.mStarProgress, 0)
    else
        local time_limit = self.m_DupConfigVo.time_limit
        for i = 2, #time_limit do
            if self.m_CurTime <= time_limit[i - 1] then
                self:getChildGO("line_" .. i):SetActive(false)
            end
        end

        local height = self.m_CurTime / time_limit[3] * self.mStarProgressHeight
        gs.TransQuick:SizeDelta02(self.mStarProgress, height)
    end
end

-------------------暂停界面

-- 更新星级
function updateStarInfo(self)
    self:clearStarItem()
    for i = 1, #self.m_DupConfigVo.time_limit do
        local item = SimpleInsItem:create(self:getChildGO("GroupTaskItem"), self.mGroupStar, "LinklinkScenePanelStarItem")

        local param = 0
        if i > 1 then
            param = self.m_DupConfigVo.time_limit[#self.m_DupConfigVo.time_limit] - self.m_DupConfigVo.time_limit[i - 1]
        else
            param = self.m_DupConfigVo.time_limit[#self.m_DupConfigVo.time_limit]
        end
        item:setText("mTextDesc", nil, _TT(139002, param))

        table.insert(self.mStarItemList, item)
    end
end

function clearStarItem(self)
    if self.mStarItemList then
        for k, v in pairs(self.mStarItemList) do
            v:poolRecover()
        end
    end
    self.mStarItemList = {}
end

--检测两个点是否能连线
function canLink(self, col_1, row_1, col_2, row_2)
    local point = self:getLinkPoints(col_1, row_1, col_2, row_2)
    return not table.empty(point)
end

function getLinkPoints(self, col_1, row_1, col_2, row_2)
    local point = {}
    local connecte_points = self:isStraightConnected(col_1, row_1, col_2, row_2)
    if connecte_points ~= nil then
        table.insert(point, connecte_points)
    else
        connecte_points = self:isOneCornerConnected(col_1, row_1, col_2, row_2)
        if connecte_points ~= nil then
            for i = 1, #connecte_points do
                table.insert(point, connecte_points[i])
            end
        else
            connecte_points = self:isTwoCornerConnected(col_1, row_1, col_2, row_2)
            if connecte_points ~= nil then
                for i = 1, #connecte_points do
                    table.insert(point, connecte_points[i])
                end
            end
        end
    end

    return point
end

--判断是否可以直连
function isStraightConnected(self, col_1, row_1, col_2, row_2)
    if col_1 == col_2 then --同行
        local min_row = math.min(row_1, row_2)
        local max_row = math.max(row_1, row_2)
        for row = min_row + 1, max_row - 1 do
            if self.m_GridDic[row][col_1].isEmpty ~= true then
                return
            end
        end
        return{col = col_2, row = row_2}
    elseif row_1 == row_2 then --同列
        local min_col = math.min(col_1, col_2)
        local max_col = math.max(col_1, col_2)
        for col = min_col + 1, max_col - 1 do
            if self.m_GridDic[row_1][col].isEmpty ~= true then
                return
            end
        end
        return {col = col_2, row = row_2}
    end
end

--判断是否一个转弯
function isOneCornerConnected(self, col_1, row_1, col_2, row_2)
    -- 尝试两个折点位置
    if self.m_GridDic[row_1][col_2].isEmpty then
        if self:isStraightConnected(col_1, row_1, col_2, row_1) ~= nil and self:isStraightConnected(col_2, row_1, col_2, row_2) ~= nil then
            return {{col = col_2, row = row_1}, {col = col_2, row = row_2}}
        end
    end

    if self.m_GridDic[row_2][col_1].isEmpty then
        if self:isStraightConnected(col_1, row_1, col_1, row_2) ~= nil and self:isStraightConnected(col_1, row_2, col_2, row_2) ~= nil then
            return {{col = col_1, row = row_2}, {col = col_2, row = row_2}}
        end
    end
end

--两个转弯
function isTwoCornerConnected(self, col_1, row_1, col_2, row_2)
    -- 纵向扫描
    --往上
    local max_col = math.max(col_1, col_2)
    for col = max_col, 0, -1 do
        if self.m_GridDic[row_1][col].isEmpty and self.m_GridDic[row_2][col].isEmpty then
            if self:isStraightConnected(col_1, row_1, col, row_1) ~= nil and self:isStraightConnected(col, row_1, col, row_2) ~= nil and self:isStraightConnected(col, row_2, col_2, row_2) ~= nil then
                return {{col = col, row = row_1}, {col = col, row = row_2}, {col = col_2, row = row_2}}
            end
        end
    end

    --往下
    local min_col = math.min(col_1, col_2)
    for col = min_col, self.m_MaxCol + 1 do
        if self.m_GridDic[row_1][col].isEmpty and self.m_GridDic[row_2][col].isEmpty then
            if self:isStraightConnected(col_1, row_1, col, row_1) ~= nil and self:isStraightConnected(col, row_1, col, row_2) ~= nil and self:isStraightConnected(col, row_2, col_2, row_2) ~= nil then
                return {{col = col, row = row_1}, {col = col, row = row_2}, {col = col_2, row = row_2}}
            end
        end
    end

    -- 横向扫描
    --往左
    local max_row = math.max(row_1, row_2)
    for row = max_row, 0, -1 do
        if self.m_GridDic[row][col_1].isEmpty and self.m_GridDic[row][col_2].isEmpty then
            if self:isStraightConnected(col_1, row_1, col_1, row) ~= nil and self:isStraightConnected(col_1, row, col_2, row) ~= nil and self:isStraightConnected(col_2, row, col_2, row_2) ~= nil then
                return {{col = col_1, row = row}, {col = col_2, row = row}, {col = col_2, row = row_2}}
            end
        end
    end
    --往右
    local min_row = math.min(row_1, row_2)
    for row = min_row, self.m_MaxRow + 1 do
        if self.m_GridDic[row][col_1].isEmpty and self.m_GridDic[row][col_2].isEmpty then
            if self:isStraightConnected(col_1, row_1, col_1, row) ~= nil and self:isStraightConnected(col_1, row, col_2, row) ~= nil and self:isStraightConnected(col_2, row, col_2, row_2) ~= nil then
                return {{col = col_1, row = row}, {col = col_2, row = row}, {col = col_2, row = row_2}}
            end
        end
    end
end

return _M
