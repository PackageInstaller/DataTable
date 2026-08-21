local var_0_0 = import("game.views.heroTeamInfo.NewHeroTeamInfoBaseView")
local var_0_1 = class("XH3rdWaterTeamInfoView", var_0_0)

function var_0_1.Init(arg_1_0)
	var_0_1.super.Init(arg_1_0)
	arg_1_0.filterView_:SetExtraSorter(handler(arg_1_0, arg_1_0.WaterSorter))
end

function var_0_1.OnEnter(arg_2_0)
	var_0_1.super.OnEnter(arg_2_0)
	SetActive(arg_2_0.filterGo_, false)
end

function var_0_1.RefreshInfoBtn(arg_3_0)
	var_0_1.super.RefreshInfoBtn(arg_3_0)
	SetActive(arg_3_0.infoBtn_.gameObject, false)
end

function var_0_1.WaterSorter(arg_4_0, arg_4_1, arg_4_2, arg_4_3, arg_4_4)
	return true, arg_4_1.id < arg_4_2.id
end

function var_0_1.ChangeTeam(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = ReserveTools.GetCharChipBaseID(arg_5_0.params_.reserveParams)

	SetHeroTeam(arg_5_0.params_.stageType, arg_5_0.params_.stageID, arg_5_0.params_.activityID, arg_5_1, arg_5_2, var_5_0)

	local var_5_1 = ActivityWaterData:GetCurrentSchedule(arg_5_0.params_.mainActivityID).selected_contestant_id

	ActivityWaterData:SetHeroTeam(var_5_1, arg_5_2)
end

function var_0_1.GetHeroList(arg_6_0)
	return {}
end

return var_0_1
