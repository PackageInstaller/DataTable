local M = BaseClass("PlotStoryUnlockItemCtrl", require("Framework.UI.Component.CircularScrollViewItem"))

function M:Init()
    self._view.btn_select:onClick(Bind(self, self.OnClickItem))
end

function M:UpdateItem(data, idx)
    if data == nil then return end

    self.m_data = data
    local cfg = data.Config
    self._view.txt_name:SetText(cfg.storyTitle)
    self._view.img_icon:SetPic(cfg.personalSmallPicture)
    self._view.txt_index:SetText(string.format("%02d", idx))
    self._view.uiState:SetState(data.IsSelect and 1 or (data:IsUnlock() and 2 or 3))
    self._view.itemSlip:SetItemNum(cfg.cost[1], ItemNumberType.BALANCE, cfg.cost[2])
end

function M:OnClickItem(go)
    if self.m_callback then
        self.m_callback(self.m_data)
    end
end

function M:SetCallback(callback)
    self.m_callback = callback
end

function M:OnDispose()
    self.m_data = nil
    self.m_callback = nil
    M.super.OnDispose(self)
end

return M
