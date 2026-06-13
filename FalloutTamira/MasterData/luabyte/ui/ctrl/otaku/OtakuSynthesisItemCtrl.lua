local M = BaseClass("OtakuSynthesisItemCtrl", require("UI.Ctrl.Common.CommonItemCtrl"))
local DataMgr = ItemDataMgr:GetInstance()

function M:Init()
    self.m_data = nil
    self.m_itemId = 0
    self.m_itemTag = 0
    self.m_callback = nil
    self:EnableClick(true)
    self.m_fmtStr = ConfigHelper.GetLocalString(5549) --%d级解锁
    self:SetClickCallback(Bind(self, self.OnClickItem))
    self:EnablePress(true, Bind(self, self.OnPressItem))
    self.m_numHandler = Bind(self, self.OnItemNumChanged)
end

function M:OnDispose()
    DataMgr:RemoveItemChangeByTag(self.m_itemTag)
    self.m_data = nil
    self.m_itemId = nil
    self.m_fmtStr = nil
    self.m_itemTag = nil
    self.m_callback = nil
    self.m_numHandler = nil
    M.super.OnDispose(self)
end

function M:UpdateItem(data)
    if not data then return end

    self.m_data = data
    self:Select(self.m_data.IsSelect)
    local makeItem = self.m_data.Config
    local oldId = self.m_itemId
    self.m_itemId = makeItem.item
    if self.m_data.IsUnlock then -- 已解锁
        self._view.uiState:SetState(1)
        local num = DataMgr:GetItemNumById(self.m_itemId)
        self:SetInfo(self.m_itemId, ItemNumberType.TOTLE, num)
        if oldId ~= self.m_itemId then
            DataMgr:RemoveItemChangeByTag(self.m_itemTag)
            self.m_itemTag = DataMgr:AddItemChange(self.m_itemId, self.m_numHandler)
        end
    else -- 锁定
        self._view.txt_lockTip:SetText(string.format(self.m_fmtStr, makeItem.houseLimit))
        if self.m_itemTag > 0 then DataMgr:RemoveItemChangeByTag(self.m_itemTag) end
        self:SetInfo(self.m_itemId, ItemNumberType.NONE, 0)
        self._view.uiState:SetState(2)
        self.m_itemTag = 0
    end
end

function M:OnClickItem(go)
    if not self.m_data.IsUnlock then return end

    if self.m_callback then self.m_callback(self.m_data) end
end

function M:OnPressItem(go)
    GameHelper.PopItem(self.m_data.Config.item, 0, self._view)
end

function M:OnItemNumChanged(itemId, _, newNum)
    self:SetInfo(itemId, ItemNumberType.TOTLE, newNum)
end

function M:SetCallback(action)
    self.m_callback = action
end

return M
