local AreaBattleHeroProxy = class("AreaBattleHeroProxy", (import("game.views.sectionSelectHero.SelectHeroProxy.SelectHeroBaseProxy")))

function AreaBattleHeroProxy:IsSameTeam(arg_1_1, arg_1_2, arg_1_3)
	local var_1_0 = 0

	for iter_1_0, iter_1_1 in pairs(arg_1_1) do
		for iter_1_2, iter_1_3 in ipairs(arg_1_2) do
			if iter_1_1 == iter_1_3 then
				var_1_0 = var_1_0 + 1
			end
		end
	end

	for iter_1_4, iter_1_5 in pairs(arg_1_3) do
		for iter_1_6, iter_1_7 in ipairs(arg_1_2) do
			if iter_1_5 == iter_1_7 then
				var_1_0 = var_1_0 + 1
			end
		end
	end

	return var_1_0 == #arg_1_2
end

function AreaBattleHeroProxy:InitCustomParams(arg_2_1)
	self.reserveParams = AreaBattleHeroProxy.GetCustomReserveParams(self.reserveParams.stageType, self.reserveParams.stageID, self.reserveParams.customData.activityID)
end

function AreaBattleHeroProxy:GotoHeroInfoUI(arg_3_1)
	local var_3_0, var_3_1 = self:CheckBeforeGotoHeroInfoUI(arg_3_1)

	if not var_3_0 then
		if var_3_1 then
			ShowTips(var_3_1)
		end

		return
	end

	local var_3_2 = self:GetDefaultTeamInfoParams(arg_3_1)

	for iter_3_0, iter_3_1 in pairs((self:GetCustomeTeamInfoParams(arg_3_1))) do
		var_3_2[iter_3_0] = iter_3_1
	end

	local var_3_3 = ActivityAreaBattleData:GetDataByActivityID(ActivityCfg.get_id_list_by_sub_activity_list[self.activityID][1])[self.activityID]
	local var_3_4 = 1

	for iter_3_2, iter_3_3 in pairs(ActivityAreaBattleCfg[self.activityID].stage_id) do
		for iter_3_4, iter_3_5 in pairs(iter_3_3) do
			if iter_3_5 == self.reserveParams.stageID then
				var_3_4 = iter_3_2
			end
		end
	end

	if var_3_3.difficultList[var_3_4] and var_3_3.difficultList[var_3_4][self.stageID] and #var_3_3.difficultList[var_3_4][self.stageID].usedHeroList ~= 0 then
		ShowTips("ACTIVITY_AREA_BATTLE_RESETTING_TIP")

		return
	end

	JumpTools.OpenPageByJump(self:GetHeroTeamInfoRoute(), var_3_2)
end

function AreaBattleHeroProxy:GetCustomReserveParams(arg_4_1, arg_4_2)
	local var_4_0 = 1

	for iter_4_0, iter_4_1 in pairs(ActivityAreaBattleCfg[arg_4_2].stage_id) do
		for iter_4_2, iter_4_3 in pairs(iter_4_1) do
			if iter_4_3 == arg_4_1 then
				var_4_0 = iter_4_0
			end
		end
	end

	return ReserveParams.New(ReserveTools.GetReserveType(self, arg_4_1), ReserveTools.GetContID(self, arg_4_1), nil, {
		stageType = self,
		stageID = arg_4_1,
		activityID = arg_4_2 or 0,
		data = ActivityAreaBattleData:GetDataByActivityID(ActivityCfg.get_id_list_by_sub_activity_list[arg_4_2][1])[arg_4_2],
		difficult = var_4_0
	})
end

function AreaBattleHeroProxy:GotoReservesProposalUI()
	local var_5_0 = ActivityAreaBattleData:GetDataByActivityID(ActivityCfg.get_id_list_by_sub_activity_list[self.activityID][1])[self.activityID]
	local var_5_1 = 1

	for iter_5_0, iter_5_1 in pairs(ActivityAreaBattleCfg[self.activityID].stage_id) do
		for iter_5_2, iter_5_3 in pairs(iter_5_1) do
			if iter_5_3 == self.reserveParams.stageID then
				var_5_1 = iter_5_0
			end
		end
	end

	if var_5_0.difficultList[var_5_1] and var_5_0.difficultList[var_5_1][self.stageID] and #var_5_0.difficultList[var_5_1][self.stageID].usedHeroList ~= 0 then
		ShowTips("ACTIVITY_AREA_BATTLE_RESETTING_TIP")

		return
	end

	AreaBattleHeroProxy.super.GotoReservesProposalUI(self)
end

return AreaBattleHeroProxy
