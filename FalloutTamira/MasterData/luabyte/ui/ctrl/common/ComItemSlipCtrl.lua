local M = BaseClass("ComItemSlipCtrl")

function M:__init(view)
    self._view = view
    self.m_itemId = 0
    self.m_showNum = 0
    self.lastItemId = 0 -- 上一个id
    self.m_itemTag = nil
    self.m_changeState = false
    self.m_changedCallback = nil
    self.m_stateHandler = Bind(self, self.OnUpdateNumState)
    --self._view.img_icon:onClick(Bind(self, self.OnClickIcon))
end

function M:OnDispose()
    ItemDataMgr:GetInstance():RemoveItemChangeByTag(self.m_itemTag)
    self.m_itemId = nil
    self.m_itemTag = nil
    self.m_showNum = nil
    self.m_changeState = nil
    self.m_stateHandler = nil
    self.m_changedCallback = nil
    if self._view then
        self._view:OnDispose()
        self._view = nil
    end
end

function M:SetItemById(itemId, itemNum, index, isActive)
    if not itemId or (index and (itemId ~= 1)) then
        -- 不是金币不显示 By DuSir 9/1
        self:SetActive(false)
        return index
    else
        index = (index or 0) + 1
    end
    if isActive == nil then isActive = true end
    self.lastItemId = self.m_itemId
    self.m_itemId = itemId or 0
    self.m_showNum = itemNum
    self._view.img_icon:SetItemIcon(itemId)
    self._view.txt_value:SetText(tostring(itemNum))
    self:_SetItemChangedEvent()
    self:_UpdateState()
    if isActive then self:SetActive(true) end
    return index
end

-- leftNum:左边，已有数量
-- rightNum:右边，消耗数量
function M:SetItemNum(itemId, numType, rightNum, leftNum)
    self.m_itemId = itemId or 0
    self.m_showNum = rightNum or 0
    self._view.img_icon:SetItemIcon(itemId)
    if numType == ItemNumberType.NONE then
        self._view.txt_value:SetActive(false)
    elseif numType == ItemNumberType.TOTLE then
        self._view.uiState:SetState(1)
        self._view.txt_value:SetText(tostring(rightNum))
    elseif numType == ItemNumberType.BALANCE then
        local itemNum = ItemDataMgr:GetInstance():GetItemNumById(itemId)
        self._view.uiState:SetState((itemNum >= rightNum) and 1 or 2)
        self._view.txt_value:SetText(string.format("%d/%d", itemNum, rightNum))
    elseif numType == ItemNumberType.FRACTION then
        self._view.uiState:SetState(1)
        self._view.txt_value:SetText(string.format("%d/%d", leftNum, rightNum))
    elseif numType == ItemNumberType.SPACE then

    end
end

function M:SetNumber(num, enough, active)
    self.m_showNum = num or 0
    self:SetActive(active)
    if active then
        self._view.txt_value:SetText(tostring(num))
        self._view.uiState:SetState(enough and 1 or 2)
    else
        self._view.uiState:SetState(1)
    end
end

function M:SetActive(value)
    self._view:SetActive(value)
end

function M:SetChangeState(value, callback)
    self.m_changeState = value
    self.m_changedCallback = callback
end

function M:OnClickIcon()
    if self.m_itemId == 0 then return end
    GameHelper.PopItem(self.m_itemId, self.m_showNum, self._view, function() end)
end

function M:_UpdateState()
    if self.m_itemId == 6 then
        --钻石不设置颜色
        return
    end
    local itemNum = ItemDataMgr:GetInstance():GetItemNumById(self.m_itemId)
    local isEnough = itemNum >= self.m_showNum
    self._view.uiState:SetState(isEnough and 1 or 2)
end

function M:OnUpdateNumState()
    self:_UpdateState()
    if self.m_changedCallback then
        self.m_changedCallback()
    end
end

function M:_SetItemChangedEvent()
    if not self.m_changeState then return end

    if self.m_itemId ~= self.lastItemId then
        ItemDataMgr:GetInstance():RemoveItemChangeByTag(self.m_itemTag)
        if self.m_itemId > 0 then
            self.m_itemTag = ItemDataMgr:GetInstance():AddItemChange(self.m_itemId, self.m_stateHandler)
        end
    end
end

return M
