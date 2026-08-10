local var_0_0 = import("game.views.heroTeamInfo.NewHeroTeamInfoBaseView")
local var_0_1 = class("ActivityRaceHeroTeamInfoView", var_0_0)

function var_0_1.OnEnter(arg_1_0)
	manager.ui:SetMainCamera("hero")

	if arg_1_0.params_.isEnter then
		if arg_1_0.filterView_ then
			arg_1_0.filterView_:Reset()
		end

		arg_1_0.params_.isEnter = false
	end

	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
	SetActive(arg_1_0.infoBtn_.gameObject, true)

	if arg_1_0.heroAvatarView_ then
		arg_1_0.heroAvatarView_:OnEnter()
	end

	arg_1_0:GetHeroTeam()

	arg_1_0.trialHeroList_ = GetTrialHeroList(arg_1_0.params_.stageType, arg_1_0.params_.stageID, arg_1_0.params_.activityID)

	local var_1_0 = {}
	local var_1_1 = ActivityRaceCfg[arg_1_0.params_.activityID].race_id

	for iter_1_0, iter_1_1 in pairs(arg_1_0:GetHeroList()) do
		if HeroCfg[iter_1_1].race == var_1_1 then
			table.insert(var_1_0, {
				trialID = 0,
				id = iter_1_1,
				type = HeroConst.HERO_DATA_TYPE.DEFAULT
			})
		end
	end

	local var_1_2 = {}
	local var_1_3 = BattleStageTools.GetRestrictHeroList(arg_1_0.params_.stageType, arg_1_0.params_.stageID)

	if type(var_1_3) == "table" then
		if var_1_3[arg_1_0.params_.selectHeroPos][1] then
			var_1_0 = {}
		end

		for iter_1_2, iter_1_3 in pairs(var_1_3) do
			if iter_1_3[1] ~= 0 and HeroCfg[iter_1_3[1]] and table.keyof(HeroCfg.get_id_list_by_private[0], iter_1_3[1]) then
				table.insert(var_1_0, {
					id = iter_1_3[1],
					trialID = iter_1_3[2],
					type = HeroConst.HERO_DATA_TYPE.CUSTOM
				})
				table.insert(var_1_2, iter_1_3[2])
			end
		end
	end

	arg_1_0.filterView_:SetHeroDataList(var_1_0)

	arg_1_0.selectID_, arg_1_0.selectTrialID_ = arg_1_0:GetDefaultHeroData()

	arg_1_0:SelectHero(arg_1_0.selectID_, arg_1_0.selectTrialID_)
	arg_1_0.heroHeadList_:StartScroll(#arg_1_0.heroDataList_, table.keyof(arg_1_0.heroDataList_, arg_1_0.selectID_))
end

return var_0_1
