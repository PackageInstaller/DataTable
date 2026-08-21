local var_0_0 = import("game.views.heroTeamInfo.SectionHeroTeamHeadItem")
local var_0_1 = class("NewMythicHeroTeamHeadItem", var_0_0)
local var_0_2 = {
	Team_3 = 3,
	Team_2 = 2,
	CurTeam = 4,
	Team_1 = 1,
	None = 0
}

function var_0_1.RefreshTeamTag(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = var_0_2.None

	for iter_1_0 = 1, arg_1_2 do
		local var_1_1 = ReserveParams.New(ReserveConst.RESERVE_TYPE.MYTHIC_FINAL_CACHE, ReserveConst.MYTHIC_CONT_ID.FINAL_MULTI, iter_1_0)
		local var_1_2 = ReserveTools.GetHeroList(var_1_1)

		for iter_1_1, iter_1_2 in ipairs(var_1_2) do
			if arg_1_0.heroId_ == iter_1_2 then
				if iter_1_0 == arg_1_1 then
					var_1_0 = var_0_2.CurTeam
				else
					var_1_0 = iter_1_0
				end
			end
		end
	end

	if var_1_0 == var_0_2.Team_1 then
		SetActive(arg_1_0.sectionTeamMarkGo_, true)
		arg_1_0.sectionTeamMarkBgStyleController_:SetSelectedState("purple")

		arg_1_0.sectionTeamMarkText_.text = GetTips("TEAM_" .. var_1_0)
	elseif var_1_0 == var_0_2.Team_2 then
		SetActive(arg_1_0.sectionTeamMarkGo_, true)
		arg_1_0.sectionTeamMarkBgStyleController_:SetSelectedState("purple")

		arg_1_0.sectionTeamMarkText_.text = GetTips("TEAM_" .. var_1_0)
	elseif var_1_0 == var_0_2.Team_3 then
		SetActive(arg_1_0.sectionTeamMarkGo_, true)
		arg_1_0.sectionTeamMarkBgStyleController_:SetSelectedState("purple")

		arg_1_0.sectionTeamMarkText_.text = GetTips("TEAM_" .. var_1_0)
	elseif var_1_0 == var_0_2.CurTeam then
		SetActive(arg_1_0.sectionTeamMarkGo_, true)
		arg_1_0.sectionTeamMarkBgStyleController_:SetSelectedState("green")

		arg_1_0.sectionTeamMarkText_.text = GetTips("IN_TEAM")
	else
		SetActive(arg_1_0.sectionTeamMarkGo_, false)
	end
end

return var_0_1
