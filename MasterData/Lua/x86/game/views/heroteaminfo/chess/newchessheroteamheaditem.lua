local NewChessHeroTeamHeadItem = class("NewChessHeroTeamHeadItem", (import("game.views.heroTeamInfo.SectionHeroTeamHeadItem")))
local var_0_1 = {
	Team_3 = 3,
	Team_2 = 2,
	CurTeam = 4,
	Team_1 = 1,
	None = 0
}

function NewChessHeroTeamHeadItem:RefreshTeamTag(arg_1_1, arg_1_2, arg_1_3)
	local var_1_0 = var_0_1.None

	for iter_1_0 = 1, arg_1_3 do
		for iter_1_1, iter_1_2 in ipairs((ReserveTools.GetHeroList((ReserveParams.New(ReserveConst.RESERVE_TYPE.MULTI_CHESS, arg_1_1, iter_1_0, {
			stageType = BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_CHESS
		}))))) do
			if self.heroId_ == iter_1_2 then
				var_1_0 = iter_1_0 == arg_1_2 and var_0_1.CurTeam or iter_1_0
			end
		end
	end

	if var_1_0 == var_0_1.Team_1 then
		SetActive(self.sectionTeamMarkGo_, true)
		self.sectionTeamMarkBgStyleController_:SetSelectedState("purple")

		self.sectionTeamMarkText_.text = GetTips("TEAM_" .. var_1_0)
	elseif var_1_0 == var_0_1.Team_2 then
		SetActive(self.sectionTeamMarkGo_, true)
		self.sectionTeamMarkBgStyleController_:SetSelectedState("purple")

		self.sectionTeamMarkText_.text = GetTips("TEAM_" .. var_1_0)
	elseif var_1_0 == var_0_1.Team_3 then
		SetActive(self.sectionTeamMarkGo_, true)
		self.sectionTeamMarkBgStyleController_:SetSelectedState("purple")

		self.sectionTeamMarkText_.text = GetTips("TEAM_" .. var_1_0)
	elseif var_1_0 == var_0_1.CurTeam then
		SetActive(self.sectionTeamMarkGo_, true)
		self.sectionTeamMarkBgStyleController_:SetSelectedState("green")

		self.sectionTeamMarkText_.text = GetTips("IN_TEAM")
	else
		SetActive(self.sectionTeamMarkGo_, false)
	end
end

return NewChessHeroTeamHeadItem
