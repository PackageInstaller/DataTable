local var_0_0 = import("game.views.sectionSelectHero.SelectHeroProxy.SelectHeroBaseProxy")
local var_0_1 = class("GuildActivitySelectHeroProxy", var_0_0)

function var_0_1.InitCustomParams(arg_1_0, arg_1_1)
	arg_1_0.activityClubCfg = ActivityClubCfg[arg_1_1.nodeId]
	arg_1_0.nodeId = arg_1_1.nodeId
	arg_1_0.pathList = arg_1_1.pathList
	arg_1_0.needPresetReservePanel = false
	arg_1_0.needHeroEnergy = true
end

function var_0_1.UpdateBar(arg_2_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		NAVI_BAR
	})
	manager.windowBar:RegistHomeCallBack(function()
		local var_3_0 = GuildActivityData:GetCurrentGrid()
		local var_3_1

		if var_3_0 ~= nil and var_3_0 > 0 then
			local var_3_2 = ActivityClubCfg[var_3_0].map_id

			var_3_1 = table.indexof(ActivityClubMapCfg.all, var_3_2)
		else
			var_3_1 = 1
		end

		gameContext:Go("/guildActivityWarField", {
			level = var_3_1,
			activityID = ActivityConst.GUILD_ACTIVITY_START
		})

		local var_3_3 = GuildActivityData:GetSelfNodeData(arg_2_0.nodeId)

		if var_3_3 and var_3_3.processing_type ~= 3 then
			GuildActivityAction.UnlockNode(arg_2_0.nodeId)
		end
	end)
	manager.windowBar:RegistBackCallBack(function()
		JumpTools.Back()

		local var_4_0 = GuildActivityData:GetSelfNodeData(arg_2_0.nodeId)

		if var_4_0 and var_4_0.processing_type ~= 3 then
			GuildActivityAction.UnlockNode(arg_2_0.nodeId)
		end
	end)
end

function var_0_1.CustomGetHeroEnergy(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	local var_5_0 = arg_5_0.activityClubCfg.vitality_cost
	local var_5_1 = arg_5_0:GetHeroIDList()
	local var_5_2 = 0

	for iter_5_0, iter_5_1 in pairs(var_5_1) do
		if iter_5_1 and iter_5_1 > 0 then
			var_5_2 = var_5_2 + 1
		end
	end

	local var_5_3 = math.floor(var_5_0 / var_5_2)

	return string.format("%d(-%d)", GuildActivityData:GetHeroFatigue(arg_5_2), var_5_3)
end

function var_0_1.CustomCheckBeforeGotoHeroInfoUI(arg_6_0, arg_6_1)
	if #GuildActivityData:GetFightHeroList() <= 0 then
		return false, "ACTIVITY_CLUB_NO_FIGHT_HERO_TIP"
	end

	return true
end

function var_0_1.GetHeroTeamInfoRoute(arg_7_0)
	return "/guildActivityTeamInfo"
end

function var_0_1.CustomCheckBeforeBattle(arg_8_0)
	local var_8_0 = arg_8_0:GetHeroIDList()
	local var_8_1 = arg_8_0.activityClubCfg.vitality_cost
	local var_8_2 = 0

	for iter_8_0, iter_8_1 in pairs(var_8_0) do
		if iter_8_1 and iter_8_1 > 0 then
			var_8_2 = var_8_2 + 1
		end
	end

	local var_8_3 = math.floor(var_8_1 / var_8_2)

	if not GuildActivityTools:IsLastBossDefeated(arg_8_0.activityClubCfg.id) then
		for iter_8_2, iter_8_3 in pairs(var_8_0) do
			if iter_8_3 and iter_8_3 > 0 then
				local var_8_4 = GuildActivityData:GetFightHeroById(iter_8_3)

				if var_8_3 > GuildActivityData:GetHeroFatigue(iter_8_3) then
					return false, "ACTIVITY_CLUB_HERO_VITALITY_NOT_ENOUGH_TIP"
				end
			end
		end
	end

	return true
end

function var_0_1.GetStageData(arg_9_0)
	local var_9_0 = BattleStageFactory.Produce(arg_9_0.stageType, arg_9_0.stageID, arg_9_0.activityID)

	var_9_0:SetNodeId(arg_9_0.activityClubCfg.id)
	var_9_0:SetPathList(arg_9_0.pathList)

	return var_9_0
end

return var_0_1
