module("cycle.CycleMapItem", Class.impl(BaseReuseItem))
UIRes = UrlManager:getUIPrefabPath("cycle/item/CycleMapItem.prefab")

-- 构造函数
function ctor(self)
    super.ctor(self)
end

function initData(self)
    self.isCanClick = false
    self.mMoveSn = nil
end

function configUI(self)
    super.configUI(self)
    self.mClick = self.UIObject
    self.mEventNormal = self:getChildGO("mEventNormal")
    self.mEventLock = self:getChildGO("mEventLock")
    -- self.mEventCurrent = self:getChildGO("mEventCurrent")
    self.mEventComplete = self:getChildGO("mEventComplete")
    self.mLineContent = self:getChildTrans("mLineContent")
    self.mEventSelect = self:getChildGO("mEventSelect")
    self.mBuffName = self:getChildGO("mBuffName"):GetComponent(ty.Text)
    self.mBuffNameUnlock = self:getChildGO("mBuffNameUnlock"):GetComponent(ty.Text)
    self.mImgEventColor = self:getChildGO("mImgEventColor"):GetComponent(ty.Image)
    self.mLineItem = {}
    for i=1, 17 do
        local lineGo = self:getChildGO("mLine" .. i)
        if lineGo then 
            self.mLineItem[i] = lineGo
            -- table.insert(self.mLineItem, lineGo)
        end
    end

    self.mImgIcon = self:getChildGO("mImgIcon"):GetComponent(ty.AutoRefImage)
    self.mImgLockColor = self:getChildGO("mImgLockColor"):GetComponent(ty.Image)
    self.mImgIconUnlock = self:getChildGO("mImgIconUnlock"):GetComponent(ty.AutoRefImage)
end

function active(self)
    super.active(self)
    GameDispatcher:addEventListener(EventName.CHOOSE_EVENT, self.setSelect, self)
end

function deActive(self)
    super.deActive(self)
    GameDispatcher:removeEventListener(EventName.CHOOSE_EVENT, self.setSelect, self)
end

function poolRecover(self)
    if self.mMoveSn then 
        LoopManager:removeFrameByIndex(self.mMoveSn)
        self.mMoveSn = nil
    end
    self.mLineContent:SetParent(self.UITrans, true)
    super.poolRecover(self)
end

--[[ 
    初始化界面的静态文本，图片字
    每次打开界面都会重新读取，多语言切换时可以及时更新
]]
function initViewText(self)
end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)
    self:addUIEvent(self.mClick, self.onBtnClickHandler)
end

function onBtnClickHandler(self)
    if not self.isCanClick or cycle.CycleManager:getCellIsPass(self.mData.id) then 
        return
    end
    GameDispatcher:dispatchEvent(EventName.OPEN_CYCLE_PREVIEW_PANEL, {
        id = self.mData.id,
        isCanClick = self.isCanClick,
        rootTrans = self.mParentTrans.parent
    })
    GameDispatcher:dispatchEvent(EventName.CHOOSE_EVENT, self.mData.id)
end

function setData(self, cusParent, cusData, rootLua)
    self:setParentTrans(cusParent)
    self.mParentTrans = cusParent
    self.mData = cusData
    self.mRootLua = rootLua
    self:updateView()

    self:setGuideTrans("guide_CycleMapItem_" .. self.mData.id, self.mClick.transform)
end

function updateView(self)
    local serverData = cycle.CycleManager:getCellDataById(self.mData.id)
    
    local eventDataVo = cycle.CycleManager:getCycleEventData(serverData.originalId)
    if eventDataVo.eventType == EVENT_TYPE.FIGHT then
        local dupId =  serverData.normalArgs[1]
        local dupVo = cycle.CycleManager:getCycleDupData(dupId)
        self.mBuffName.text = _TT(dupVo.name)
        self.mBuffNameUnlock.text = _TT(dupVo.name)
    else
        self.mBuffName.text = _TT(eventDataVo.eventTitle)
        self.mBuffNameUnlock.text = _TT(eventDataVo.eventTitle)
    end
    for k,v in pairs(self.mLineItem) do
        v:SetActive(table.indexof(self.mData.lineList, k))
    end
    local color = "000000ff"
    if eventDataVo.eventColor ~= "" then 
        color = eventDataVo.eventColor
    end
    self.mImgIcon:SetImg(UrlManager:getIconPath(eventDataVo.eventIcon))
    self.mImgIconUnlock:SetImg(UrlManager:getIconPath(eventDataVo.eventIcon))
    self.mImgEventColor.color = gs.ColorUtil.GetColor(color)
    self.mImgLockColor.color = gs.ColorUtil.GetColor(color)
    local isComplete = cycle.CycleManager:getCellIsPass(self.mData.id)
    self.mEventComplete:SetActive(isComplete)
    for k,v in pairs(self.mLineItem) do
        if v then
            v:GetComponent(ty.Image).color = gs.ColorUtil.GetColor("ffffffff")
        end
    end
    
    if isComplete then 
        self.mEventNormal:SetActive(true)
        self.mEventLock:SetActive(false)
        local passIndexes = {}
        for k, v in pairs(self.mData.nextIds) do 
            if cycle.CycleManager:getCellIsPass(v) then 
                table.insert(passIndexes, self.mData.lineList[k])
            end
        end
        if #passIndexes > 0 then 
            for k,v in pairs(self.mLineItem) do
                if not table.indexof(passIndexes, k) then
                    if v then 
                        v:GetComponent(ty.Image).color = gs.ColorUtil.GetColor("ffffff4c")
                        v.transform:SetAsFirstSibling()
                    end
                end
            end
            -- for i=1, 7 do
            --     if not table.indexof(passIndexes, i) then 
            --         self.mLineItem[i]:GetComponent(ty.Image).color = gs.ColorUtil.GetColor("ffffff4c")
            --         self.mLineItem[i].transform:SetAsFirstSibling()
            --     end
            -- end
        end
    else
        local lastCellId = cycle.CycleManager:getLastCellId()
        if lastCellId > 0 then
            local mapVo = cycle.CycleManager:getCurrentCycleSingleMapData(lastCellId)
            self.isCanClick = table.indexof01(mapVo.nextIds, self.mData.id) > 0
            if mapVo.nextIds[1] == self.mData.id then 
                cycle.CycleManager:setNowEventTrans(self.mParentTrans.parent)
            end
        else
            cycle.CycleManager:setNowEventTrans(nil)
            self.isCanClick = self.mData.row == 1
        end
        self.mEventNormal:SetActive(self.isCanClick)
        self.mEventLock:SetActive(not self.isCanClick)

        for k,v in pairs(self.mLineItem) do
            if v then 
                v:GetComponent(ty.Image).color = gs.ColorUtil.GetColor("ffffff4c")
                v.transform:SetAsFirstSibling()
            end
        end 
        -- for i=1, 7 do
        --     self.mLineItem[i]:GetComponent(ty.Image).color = gs.ColorUtil.GetColor("303e5aff")
        --     self.mLineItem[i].transform:SetAsFirstSibling()
        -- end
        -- end
    end
    self.mMoveSn = LoopManager:addFrame(2, 1, self, function()
        self.mLineContent:SetParent(self.mRootLua.UITrans, true)
        if not isComplete then 
            self.mLineContent:SetAsFirstSibling()
        else
            self.mLineContent:SetAsLastSibling()
        end
    end)
end

function setSelect(self, id)
    self.mEventSelect:SetActive(id == self.mData.id)
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
