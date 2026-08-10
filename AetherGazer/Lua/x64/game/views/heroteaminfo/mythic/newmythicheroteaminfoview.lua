local var_0_0 = import("game.views.heroTeamInfo.NewHeroTeamInfoBaseView")
local var_0_1 = class("NewMythicHeroTeamInfoView", var_0_0)

function var_0_1.OnEnter(arg_1_0)
	arg_1_0.teamLength_ = arg_1_0.params_.teamLength

	var_0_1.super.OnEnter(arg_1_0)
end

function var_0_1.GetHeroHeadClass(arg_2_0)
	return NewMythicHeroTeamHeadItem
end

function var_0_1.HeadRenderer(arg_3_0, arg_3_1, arg_3_2)
	var_0_1.super.HeadRenderer(arg_3_0, arg_3_1, arg_3_2)
	arg_3_2:RefreshTeamTag(arg_3_0.params_.reserveParams.teamIndex, arg_3_0.teamLength_)
end

function var_0_1.ChangeTeam(arg_4_0, arg_4_1, arg_4_2)
	local var_4_0 = {}

	for iter_4_0 = 1, 3 do
		if arg_4_1[iter_4_0] ~= 0 then
			var_4_0[#var_4_0 + 1] = arg_4_1[iter_4_0]
		end
	end

	for iter_4_1 = #var_4_0 + 1, 3 do
		var_4_0[iter_4_1] = 0
	end

	local var_4_1 = ComboSkillTools.GetRecommendSkillID(var_4_0, true)
	local var_4_2, var_4_3 = ReserveTools.GetMimirData(arg_4_0.params_.reserveParams)
	local var_4_4 = ReserveTools.GetCharChipBaseID(arg_4_0.params_.reserveParams)

	ReserveTools.SetTeam(arg_4_0.params_.reserveParams, var_4_0, arg_4_2 or {}, var_4_1, var_4_2, var_4_3, var_4_4)
end

return var_0_1
