local XH3rdWaterTeamInfoView = class("XH3rdWaterTeamInfoView", (import("game.views.heroTeamInfo.NewHeroTeamInfoBaseView")))

function XH3rdWaterTeamInfoView:Init()
	XH3rdWaterTeamInfoView.super.Init(self)
	self.filterView_:SetExtraSorter(handler(self, self.WaterSorter))
end

function XH3rdWaterTeamInfoView:OnEnter()
	XH3rdWaterTeamInfoView.super.OnEnter(self)
	SetActive(self.filterGo_, false)
end

function XH3rdWaterTeamInfoView:RefreshInfoBtn()
	XH3rdWaterTeamInfoView.super.RefreshInfoBtn(self)
	SetActive(self.infoBtn_.gameObject, false)
end

function XH3rdWaterTeamInfoView:WaterSorter(arg_4_1, arg_4_2, arg_4_3, arg_4_4)
	return true, arg_4_1.id < arg_4_2.id
end

function XH3rdWaterTeamInfoView:ChangeTeam(arg_5_1, arg_5_2)
	SetHeroTeam(self.params_.stageType, self.params_.stageID, self.params_.activityID, arg_5_1, arg_5_2, (ReserveTools.GetCharChipBaseID(self.params_.reserveParams)))
	ActivityWaterData:SetHeroTeam(ActivityWaterData:GetCurrentSchedule(self.params_.mainActivityID).selected_contestant_id, arg_5_2)
end

function XH3rdWaterTeamInfoView:GetHeroList()
	return {}
end

return XH3rdWaterTeamInfoView
