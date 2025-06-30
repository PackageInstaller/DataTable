--[[ 
-----------------------------------------------------
@filename       : PuzzleGameView
@Description    : 剧情游戏——拼图游戏
@date           : 2020-12-14 14:42:24
@Author         : Jacob
@copyright      : (LY) 2020 雷焰网络
-----------------------------------------------------
]]
module('game.storyGame.view.PuzzleGameView', Class.impl(View))

--对应的ui文件
UIRes = UrlManager:getUIPrefabPath("storyGame/PuzzleGameView.prefab")

destroyTime = 0 -- 自动销毁时间-1默认
panelType = -1 -- 窗口类型 1 全屏 2 弹窗

--构造函数
function ctor(self)
    super.ctor(self)
    -- self:setInnerOffset(0, 0, 0, 0)
    -- self:setTxtTitle('')
    -- self:setContentBg("")
end
--析构  
function dtor(self)
end

function initData(self)
    self.mPosList = {}
    self.mImgList = {}
    self.mTargetList = {}
    self.mRightList = {}
end

-- 初始化
function configUI(self)
    self.mGroup = self:getChildTrans("mGroup")
    for i = 1, 6 do
        local pos = self:getChildTrans("mGroupPos" .. i)
        table.insert(self.mPosList, pos)
    end

    for i = 1, 6 do
        local img = self:getChildGO("mImg" .. i):GetComponent(ty.LongPressOrClickEventTrigger)
        table.insert(self.mImgList, img)
        self.mRightList[i] = false
    end

    for i = 1, 6 do
        local area = self:getChildTrans("mGroupEnd" .. i)
        table.insert(self.mTargetList, area)
    end


end

--激活
function active(self)
    super.active(self)

    for i, triger in ipairs(self.mImgList) do
        local function _onBeginDrag()
            self:onBeginDragHandler(i)
        end
        triger.onBeginDrag:AddListener(_onBeginDrag)

        local function _onEndDrag()
            self:onEndDragHandler(i)
        end
        triger.onEndDrag:AddListener(_onEndDrag)
    end

end

--反激活（销毁工作）
function deActive(self)
    super.deActive(self)
    for i, triger in ipairs(self.mImgList) do
        triger.onBeginDrag:RemoveAllListeners()
        triger.onEndDrag:RemoveAllListeners()
    end

    for i, v in ipairs(self.mImgList) do
        gs.TransQuick:LPosXY(v.transform, self.mPosList[i].localPosition.x, self.mPosList[i].localPosition.y)
    end

    for i = 1, #self.mRightList do
        self.mRightList[i] = false
    end
end

--[[ 
    初始化界面的静态文本，图片字
    每次打开界面都会重新读取，多语言切换时可以及时更新
]]
function initViewText(self)
    -- self:setBtnLabel(self.aa, 10001, "按钮")
end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)
    -- self:addUIEvent(self.aa,self.onClick)
end

function onBeginDragHandler(self, index)
    self.mIdx = index
    self.mImgList[self.mIdx].transform:SetSiblingIndex(18)
    LoopManager:addFrame(1, 0, self, self.frameUpdate)
end

function onEndDragHandler(self)
    LoopManager:removeFrame(self, self.frameUpdate)
    self.mMousePos = gs.Input.mousePosition
    local mouseWorldPos = gs.CameraMgr:ScreenToWorldByUICamera2(self.mMousePos)
    local parentPos = self.mGroup:InverseTransformPoint(mouseWorldPos)
    local isRight = false

    local targetTrans = self.mTargetList[self.mIdx]
    if parentPos.x > targetTrans.localPosition.x and parentPos.x < (targetTrans.localPosition.x + targetTrans.sizeDelta.x) and
    parentPos.y > targetTrans.localPosition.y and parentPos.y < (targetTrans.localPosition.y + targetTrans.sizeDelta.y)
    then
        local localPos = targetTrans:InverseTransformPoint(mouseWorldPos)
        local texture2D = targetTrans:GetComponent(ty.Image).sprite.texture
        local spriteRect = targetTrans:GetComponent(ty.Image).sprite.textureRect
        local imgRect = targetTrans.rect
        -- 转换为统一UV空间
        local x = spriteRect.x + spriteRect.width * localPos.x / imgRect.width
        local y = spriteRect.y + spriteRect.height * localPos.y / imgRect.height
        local a = texture2D:GetPixel(x, y).a

        if a > 0 then
            isRight = true
            self.mRightList[self.mIdx] = true
            gs.TransQuick:LPosXY(self.mImgList[self.mIdx].transform, targetTrans.localPosition.x + targetTrans.sizeDelta.x / 2, targetTrans.localPosition.y + targetTrans.sizeDelta.y / 2)
            self:removeEventByIndex(self.mIdx)
        end
    end
    if not isRight then
        gs.TransQuick:LPosXY(self.mImgList[self.mIdx].transform, self.mPosList[self.mIdx].localPosition.x, self.mPosList[self.mIdx].localPosition.y)
    end

    local complete = true
    for i, v in ipairs(self.mRightList) do
        if self.mRightList[i] == false then
            -- 结算完成
            complete = false
            break
        end
    end
    if complete then
        self:setTimeout(1.5, function()
            self:close()
            UIFactory:alertMessge("完成啦，好开心啊！恭喜恭喜啊~ 你好棒棒啊~", true)
        end)
    end

end

function frameUpdate(self)
    self.mMousePos = gs.Input.mousePosition
    local mouseWorldPos = gs.CameraMgr:ScreenToWorldByUICamera2(self.mMousePos)
    gs.TransQuick:PosXY(self.mImgList[self.mIdx].transform, mouseWorldPos.x, mouseWorldPos.y)
end


function removeEventByIndex(self, index)
    local triger = self.mImgList[index]
    triger.onBeginDrag:RemoveAllListeners()
    triger.onEndDrag:RemoveAllListeners()
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
