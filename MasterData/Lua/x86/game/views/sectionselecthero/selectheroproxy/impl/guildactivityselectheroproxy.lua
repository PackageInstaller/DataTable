local GuildActivitySelectHeroProxy = class("GuildActivitySelectHeroProxy", (import("game.views.sectionSelectHero.SelectHeroProxy.SelectHeroBaseProxy")))

function GuildActivitySelectHeroProxy:InitCustomParams(arg_1_1)
	self.activityClubCfg = ActivityClubCfg[arg_1_1.nodeId]
	self.nodeId = arg_1_1.nodeId
	self.pathList = arg_1_1.pathList
	self.needPresetReservePanel = false
	self.needHeroEnergy = true
end

function GuildActivitySelectHeroProxy:UpdateBar()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		NAVI_BAR
	})
	manager.windowBar:RegistHomeCallBack(function()
		local var_3_0 = GuildActivityData:GetCurrentGrid()
		local var_3_1 = var_3_0 ~= nil and var_3_0 > 0 and table.indexof(ActivityClubMapCfg.all, ActivityClubCfg[var_3_0].map_id) or 1

		gameContext:Go("/guildActivityWarField", {
			level = var_3_1,
			activityID = ActivityConst.GUILD_ACTIVITY_START
		})

		local var_3_2 = GuildActivityData:GetSelfNodeData(self.nodeId)

		if var_3_2 and var_3_2.processing_type ~= 3 then
			GuildActivityAction.UnlockNode(self.nodeId)
		end
	end)
	manager.windowBar:RegistBackCallBack(function()
		JumpTools.Back()

		local var_4_0 = GuildActivityData:GetSelfNodeData(self.nodeId)

		if var_4_0 and var_4_0.processing_type ~= 3 then
			GuildActivityAction.UnlockNode(self.nodeId)
		end
	end)
end

function GuildActivitySelectHeroProxy:CustomGetHeroEnergy(arg_5_1, arg_5_2, arg_5_3)
	local var_5_0 = 0

	for iter_5_0, iter_5_1 in pairs((self:GetHeroIDList())) do
		if iter_5_1 and iter_5_1 > 0 then
			var_5_0 = var_5_0 + 1
		end
	end

	return string.format("%d(-%d)", GuildActivityData:GetHeroFatigue(arg_5_2), (math.floor(self.activityClubCfg.vitality_cost / var_5_0)))
end

function GuildActivitySelectHeroProxy:CustomCheckBeforeGotoHeroInfoUI(arg_6_1)
	if #GuildActivityData:GetFightHeroList() <= 0 then
		return false, "ACTIVITY_CLUB_NO_FIGHT_HERO_TIP"
	end

	return true
end

function GuildActivitySelectHeroProxy:GetHeroTeamInfoRoute()
	return "/guildActivityTeamInfo"
end

function GuildActivitySelectHeroProxy:CustomCheckBeforeBattle()
	local var_8_0 = self:GetHeroIDList()
	local var_8_1 = 0

	for iter_8_0, iter_8_1 in pairs(var_8_0) do
		if iter_8_1 and iter_8_1 > 0 then
			var_8_1 = var_8_1 + 1
		end
	end

	local var_8_2 = math.floor(self.activityClubCfg.vitality_cost / var_8_1)

	if not GuildActivityTools:IsLastBossDefeated(self.activityClubCfg.id) then
		for iter_8_2, iter_8_3 in pairs(var_8_0) do
			if iter_8_3 and iter_8_3 > 0 then
				local var_8_3 = GuildActivityData:GetFightHeroById(iter_8_3)

				if var_8_2 > GuildActivityData:GetHeroFatigue(iter_8_3) then
					return false, "ACTIVITY_CLUB_HERO_VITALITY_NOT_ENOUGH_TIP"
				end
			end
		end
	end

	return true
end

function GuildActivitySelectHeroProxy:GetStageData()
	local var_9_0 = BattleStageFactory.Produce(self.stageType, self.stageID, self.activityID)

	var_9_0:SetNodeId(self.activityClubCfg.id)
	var_9_0:SetPathList(self.pathList)

	return var_9_0
end

return GuildActivitySelectHeroProxy
