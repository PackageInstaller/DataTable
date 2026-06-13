local M = BaseClass("MissionOfferAwardDetailsItemCtrl", require("Framework.UI.Component.CircularScrollViewItem"))

function M:Init()
    self.m_callback = nil
    self._view.itemPfb:EnablePopItem(true)
    self._view.btn_award:onClick(Bind(self, self.OnClickAward))
end

function M:UpdateItem(data)
    if data == nil then return end

    local id, num = data.Reward[1], data.Reward[2]
    self._view.doneRect:SetActive(data:IsAward())
    self._view.txt_level:SetText(tostring(data.Level))
    self._view.uiState:SetState(data:CanAward() and 2 or 1)
    self._view.itemPfb:SetInfo(id, ItemNumberType.TOTLE, num)
end

function M:SetAwardCallback(callback)
    self.m_callback = callback
end

function M:OnClickAward(go)
    if self.m_callback then
        self.m_callback(go)
    end
end

function M:OnDispose()
    self.m_callback = nil
    M.super.OnDispose(self)
end

return M
