local NewMythicHeroTeamInfoView = class("NewMythicHeroTeamInfoView", (import("game.views.heroTeamInfo.NewHeroTeamInfoBaseView")))

function NewMythicHeroTeamInfoView:OnEnter()
	self.teamLength_ = self.params_.teamLength

	NewMythicHeroTeamInfoView.super.OnEnter(self)
end

function NewMythicHeroTeamInfoView:GetHeroHeadClass()
	return NewMythicHeroTeamHeadItem
end

function NewMythicHeroTeamInfoView:HeadRenderer(arg_3_1, arg_3_2)
	NewMythicHeroTeamInfoView.super.HeadRenderer(self, arg_3_1, arg_3_2)
	arg_3_2:RefreshTeamTag(self.params_.reserveParams.teamIndex, self.teamLength_)
end

function NewMythicHeroTeamInfoView:ChangeTeam(arg_4_1, arg_4_2)
	local var_4_0 = {}

	for iter_4_0 = 1, 3 do
		if arg_4_1[iter_4_0] ~= 0 then
			var_4_0[#var_4_0 + 1] = arg_4_1[iter_4_0]
		end
	end

	for iter_4_1 = #var_4_0 + 1, 3 do
		var_4_0[iter_4_1] = 0
	end

	local var_4_1, var_4_2 = ReserveTools.GetMimirData(self.params_.reserveParams)

	ReserveTools.SetTeam(self.params_.reserveParams, var_4_0, arg_4_2 or {}, ComboSkillTools.GetRecommendSkillID(var_4_0, true), var_4_1, var_4_2, (ReserveTools.GetCharChipBaseID(self.params_.reserveParams)))
end

return NewMythicHeroTeamInfoView
