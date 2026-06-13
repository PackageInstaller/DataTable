local M = BaseClass("EnergyItemCtrl", require("UI.Ctrl.Common.CommonItemCtrl"))

function M:Init()
    self.m_data = nil
    self.m_callback = nil
    self:SetClickCallback(Bind(self, self.OnItemClick))
end

function M:UpdateItem(data)
    self.m_data = data
    if not self.m_data then return end

    self:SetInfo(self.m_data.Id, ItemNumberType.TOTLE, self.m_data.TotalNum)
    self:Select(self.m_data.IsSelect)
end

function M:OnDispose()
    self.m_data = nil
    self.m_callback = nil
    M.super.OnDispose(self)
end

function M:OnItemClick()
    if not self.m_data then return end
    if self.m_callback then
        self.m_callback(self.m_data)
    end
end

function M:SetItemClickCallback(action)
    self.m_callback = action
end

return M
