local M = BaseClass("OtakuSettleExchangeItemCtrl")

function M:__init(view)
    self._view = view
end

function M:UpdataData(data)
    self._view.Head:SetAvatarIcon(data.HeroId, RoleType.ERT_Hero)
    self._view.OldText:SetText(data.otherRoomName)
end

function M:OnDispose()
    if self._view then
        self._view:OnDispose()
        self._view = nil
    end
end

return M
