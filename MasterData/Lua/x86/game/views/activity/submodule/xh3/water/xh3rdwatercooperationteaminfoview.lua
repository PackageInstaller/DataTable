local XH3rdWaterCooperationTeamInfoView = class("XH3rdWaterCooperationTeamInfoView", (import("game.views.cooperation.HeroTeamInfoCooperationView")))

function XH3rdWaterCooperationTeamInfoView:OnEnter()
	XH3rdWaterCooperationTeamInfoView.super.OnEnter(self)
	SetActive(self.filterGo_, false)
end

return XH3rdWaterCooperationTeamInfoView
