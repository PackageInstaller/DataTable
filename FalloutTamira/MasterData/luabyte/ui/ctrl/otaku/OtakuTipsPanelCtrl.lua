local M = BaseClass("OtakuTipsPanelCtrl")
local OtakuRoomType = OtakuType.OtakuRoomType

function M:__init(view)
    self._view = view
end

function M:UpdataData(data)
    self._view.UIState:SetState(data.state)
    self._view.Text:SetText(data.text)
    local heroName = IHeroDataMgr:GetMyHeroDataById(data.heroId):GetHeroName()
    self._view.Name:SetText(heroName)
    self._view.Head:SetAvatarIcon(data.heroId, RoleType.ERT_Hero)
end

function M:OnDispose()
    if self._view then
        self._view:OnDispose()
        self._view = nil
    end
end

return M
