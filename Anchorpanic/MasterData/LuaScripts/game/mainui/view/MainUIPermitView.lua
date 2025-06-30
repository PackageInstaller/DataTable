--[[ 
-----------------------------------------------------
@filename       : MainUIPermitView
@Description    : 主UI通行证轮播
@date           : 2024-08-30 17:52:00
@Author         : Jacob
@copyright      : (LY) 2020 雷焰网络
-----------------------------------------------------
]]
module('game.mainui.view.MainUIPermitView', Class.impl("lib.component.BaseContainer"))

--对应的ui文件
UIRes = ""

--构造函数
function ctor(self)
    -- super.ctor(self)
    self.m_sn = SnMgr:getSn()
    self:initData()
end
--析构  
function dtor(self)
end

function initData(self)
    self.autoTimes = 5
    self.mSelectItemList = {}
    self.mInfoItemList = {}
    self.posList = {}
    self.mSelectItem = nil
    self.currentChildIndex = 0
    self.mTimes = 0

    self.itemW = nil

    self.indexDic = {}
end

function setUIGo(self, go)
    self.UIObject = go
    self.m_childGos, self.m_childTrans = GoUtil.GetChildHash(self.UIObject)
    self:configUI()
end

-- 初始化
function configUI(self)
    self.mScrollView = self:getChildTrans("mScrollView")
    self.mScrollContent = self:getChildTrans("Content")
    self.mGroupLocal = self:getChildTrans("mGroupLocal")
    self.scrollRect = self.mScrollView:GetComponent(ty.ScrollRect)

    self.mEventTrigger = self.mScrollView:GetComponent(ty.LongPressOrClickEventTrigger)
end

function setGMTimeHanlder(self, time)
    self.autoTimes = time
end

--激活
function active(self)
    super.active(self)
    GameDispatcher:addEventListener(EventName.FUNC_OPEN_DATA_INIT, self.onFuncOpenUpdateHandler, self)
    GameDispatcher:addEventListener(EventName.FUNC_OPEN_UPDATE, self.onFuncOpenUpdateHandler, self)
    GameDispatcher:addEventListener(EventName.GM_SETLOOP_TIMES, self.setGMTimeHanlder, self)


    GameManager:addEventListener(GameManager.GET_PING_SUCCESS, self.onGetPingSuccessHandler, self)

    local function _onBeginDrag()
        self:__onBeginDragHandler()
    end
    self.mEventTrigger.onBeginDrag:AddListener(_onBeginDrag)

    local function _onEndDrag()
        self:__onEndDragHandler()
    end
    self.mEventTrigger.onEndDrag:AddListener(_onEndDrag)

    if not self.mTimeId2 then
        self.mTimeId2 = self:addTimer(5, 0, self.checkStateChange)
    end

    if GameManager.isInitSuccess == true then
        self:updateView()
    end
end

--反激活（销毁工作）
function deActive(self)
    super.deActive(self)
    GameDispatcher:removeEventListener(EventName.FUNC_OPEN_DATA_INIT, self.onFuncOpenUpdateHandler, self)
    GameDispatcher:removeEventListener(EventName.FUNC_OPEN_UPDATE, self.onFuncOpenUpdateHandler, self)
    GameManager:removeEventListener(GameManager.GET_PING_SUCCESS, self.onGetPingSuccessHandler, self)

    GameDispatcher:removeEventListener(EventName.GM_SETLOOP_TIMES, self.setGMTimeHanlder, self)

    self.mEventTrigger.onBeginDrag:RemoveAllListeners()
    self.mEventTrigger.onEndDrag:RemoveAllListeners()

    self:removeTimerByIndex(self.mTimeId)
    self.mTimeId = nil
    self:removeTimerByIndex(self.mTimeId2)
    self.mTimeId2 = nil
    LoopManager:removeFrameByIndex(self.frameId)
    LoopManager:removeFrame(self, self.onUpdate)

    self:recover()
end

function removeAllTimer(self)
    super.removeAllTimer(self)
end

function onGetPingSuccessHandler(self)
    if self.mScrollContent then
        self:updateView()
    end
end

function onFuncOpenUpdateHandler(self)
    self:onActivityUpdate()
end

function onActivityUpdate(self)
    self:recover()
    self:updateView()
end

function checkStateChange(self)
    local list = activity.ActivityManager:getPermitBillboardList()
    for i, billboardVo in ipairs(list) do
        if billboardVo.isOpen ~= billboardVo:isOpenTime() then
            self:recover()
            self:updateView()
            break
        end
    end
end

-- 创建内容
function updateView(self)
    self.indexDic = {}
    local list = activity.ActivityManager:getPermitBillboardList()
    local page = 1
    for i, billboardVo in ipairs(list) do
        billboardVo.isOpen = billboardVo:isOpenTime()  -- 缓存自己的开放状态
        if funcopen.FuncOpenManager:isOpen(billboardVo.funcOpenId) then
            if billboardVo.isOpen then
                local selectItem = mainui.MainUIActivitySelectItem:poolGet()
                selectItem:setParentTrans(self.mGroupLocal)
                if page == 1 then
                    selectItem:setSelect(true)
                    self.mSelectItem = selectItem
                else
                    selectItem:setSelect(false)
                end
                -- self:addOnClick(selectItem.UIObject, function()
                --     self:pageTo(i)
                -- end)
                table.insert(self.mSelectItemList, selectItem)
                page = page + 1
            end
        end
    end
    local index = 0
    for i = 1, #list do
        local billboardVo = list[i]
        if funcopen.FuncOpenManager:isOpen(billboardVo.funcOpenId) then
            if billboardVo.isOpen then
                local infoItem = mainui.MainUIActivityInfoItem:poolGet()
                infoItem:setData(self.mScrollContent, billboardVo)
                table.insert(self.mInfoItemList, infoItem)
                if self.itemW == nil then
                    self.itemW = infoItem:getWidth()
                end

                self.indexDic[index] = index + 1
                index = index + 1
            end
        end
    end
    if self.mTimeId == nil then
        self.mTimeId = self:addTimer(1, 0, self.onTimer)
    end

    self.scrollRect.horizontalNormalizedPosition = 0

    self:getChildGO("Content"):GetComponent(ty.ContentSizeFitter).enabled = true
    self:getChildGO("Content"):GetComponent(ty.HorizontalLayoutGroup).enabled = true

    -- 小于一条不显示下面滚动条
    self.mGroupLocal.gameObject:SetActive(#self.mSelectItemList > 1)

    -- 第一次创建2秒左右就滚到下一个
    self.mTimes = 4
end

function getChildPosX(self, childIndex)
    local r = self.mScrollContent:GetChild(childIndex).localPosition.x / (self.mScrollContent.rect.width - self.mScrollView.rect.width)
    return r
end

-- 开始拖动
function __onBeginDragHandler(self)
    if #self.mSelectItemList <= 0 then
        return
    end
    self.isDrag = true
    self.mTimes = 0
    self.startHorizontal = self.scrollRect.horizontalNormalizedPosition
    LoopManager:addFrame(1, 0, self, self.onUpdate)
    self:removeTimerByIndex(self.mTimeId)
    self.mTimeId = nil

    self:getChildGO("Content"):GetComponent(ty.ContentSizeFitter).enabled = false
    self:getChildGO("Content"):GetComponent(ty.HorizontalLayoutGroup).enabled = false
end
-- 拖动结束
function __onEndDragHandler(self)
    if #self.mSelectItemList <= 0 then
        return
    end

    local posX = self.scrollRect.horizontalNormalizedPosition--记录放手时的滚动量

    posX = posX + ((posX - self.startHorizontal) * 0.66)

    posX = posX < 1 and posX or 1
    posX = posX > 0 and posX or 0

    local childIndex = 0

    local offset = math.abs(self.mScrollView:InverseTransformPoint(self.mScrollContent:GetChild(0).position).x + self.itemW / 2)
    for i = 0, self.mScrollContent.childCount - 1 do
        local temp = math.abs(self.mScrollView:InverseTransformPoint(self.mScrollContent:GetChild(i).position).x + self.itemW / 2)

        if temp < offset then
            childIndex = i
            offset = temp
        end
    end

    self:setPageIndex(childIndex)
    self.tergetHorizontal = self:getChildPosX(childIndex)
    self.isDrag = false
    self.startTime = 0
    self.stopMOVE = false

    self.mTimeId = self:addTimer(1, 0, self.onTimer)
end
-- 跳转到某一页
function pageTo(self, childIndex, noTween)
    if childIndex >= 0 and childIndex < self.mScrollContent.childCount then
        if noTween then
            self.scrollRect.horizontalNormalizedPosition = self:getChildPosX(childIndex)
        else
            self.tergetHorizontal = self:getChildPosX(childIndex)
            self.startTime = 0
            self.isDrag = false
            self.stopMOVE = false
            LoopManager:addFrame(1, 0, self, self.onUpdate)
        end
        self:setPageIndex(childIndex)
    end
end
-- 设置当前页
function setPageIndex(self, childIndex)

    if (self.currentChildIndex ~= childIndex) then
        self.currentChildIndex = childIndex
    end

    if self.mSelectItem then
        self.mSelectItem:setSelect(false)
    end

    local page = self.indexDic[childIndex]

    local selectItem = self.mSelectItemList[page]
    if selectItem then
        selectItem:setSelect(true)
        self.mSelectItem = selectItem
    end
end
-- 插值缓动
function onUpdate(self)
    if #table.values(self.indexDic) <= 1 then
        self.scrollRect.horizontalNormalizedPosition = 0
        return
    end
    if not self.isDrag and not self.stopMOVE then
        self.startTime = self.startTime + LoopManager:getDeltaTime()
        local t = self.startTime * 3
        self.scrollRect.horizontalNormalizedPosition = gs.Mathf.Lerp(self.scrollRect.horizontalNormalizedPosition, self.tergetHorizontal, t)
        if t >= 1 then
            self.stopMOVE = true
            LoopManager:removeFrame(self, self.onUpdate)
        end
    else

        local childCount = self.mScrollContent.childCount
        -- 往左拉，左边的向右补
        local itemX = self.mScrollView:InverseTransformPoint(self.mScrollContent:GetChild(0).position).x
        if itemX + self.itemW <= -self.itemW / 2 then
            local pos = self.mScrollContent:GetChild(0).localPosition
            pos.x = pos.x + self.itemW * childCount
            self.mScrollContent:GetChild(0).localPosition = pos
            self.mScrollContent:GetChild(0):SetAsLastSibling()

            for i = 0, childCount - 1 do
                self.indexDic[i] = self.indexDic[i] + 1 > childCount and 1 or self.indexDic[i] + 1
            end
        end
        -- 往右拉，右边的向左补
        itemX = self.mScrollView:InverseTransformPoint(self.mScrollContent:GetChild(childCount - 1).position).x
        if itemX >= self.itemW / 2 then
            local pos = self.mScrollContent:GetChild(childCount - 1).localPosition
            pos.x = pos.x - self.itemW * childCount
            self.mScrollContent:GetChild(childCount - 1).localPosition = pos
            self.mScrollContent:GetChild(childCount - 1):SetAsFirstSibling()

            for i = 0, childCount - 1 do
                self.indexDic[i] = self.indexDic[i] - 1 <= 0 and childCount or self.indexDic[i] - 1
            end
        end
    end

end
-- 计时器自动滚动
function onTimer(self)
    if #self.mSelectItemList <= 0 then
        self:removeTimerByIndex(self.mTimeId)
        self.mTimeId = nil
        return
    end

    self.mTimes = self.mTimes + 1
    if self.mTimes > self.autoTimes then
        self.mTimes = 0
        local childIndex = self.currentChildIndex + 1
        childIndex = childIndex > self.mScrollContent.childCount - 1 and 0 or childIndex
        if self.currentChildIndex ~= childIndex then
            self:pageTo(childIndex)
        end
    end
end
-- 更新红点
function updateBubble(self, funcId, state)
    if self.mInfoItemList then
        for i, item in ipairs(self.mInfoItemList) do
            if item.billboardData and funcId == item.billboardData.funcOpenId then
                item:updateBubble(state)
            end
        end
    end
end

-- 重置
function recover(self)
    for i, v in ipairs(self.mInfoItemList) do
        v:poolRecover(v)
    end
    for i, v in ipairs(self.mSelectItemList) do
        self:removeOnClick(v.UIObject)
        v:poolRecover(v)
    end
    self:removeTimerByIndex(self.mTimeId)
    self.mTimeId = nil
    LoopManager:removeFrameByIndex(self.frameId)
    LoopManager:removeFrame(self, self.onUpdate)

    self.mInfoItemList = {}
    self.mSelectItemList = {}
    self.posList = {}
    self.mSelectItem = nil
    self.currentChildIndex = 0
    self.mTimes = 0
    self.tergetHorizontal = 0
    self.startTime = 0
    self.isDrag = false
    self.stopMOVE = false
end

function destroy(self)
    self:recover()
    super.destroy(self)
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]