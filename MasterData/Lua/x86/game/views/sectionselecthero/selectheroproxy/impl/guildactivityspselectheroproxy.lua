local GuildActivitySPSelectHeroProxy = class("GuildActivitySPSelectHeroProxy", (import("game.views.sectionSelectHero.SelectHeroProxy.SelectHeroBaseProxy")))

function GuildActivitySPSelectHeroProxy:InitCustomParams(arg_1_1)
	self.activityClubCfg = ActivityClubSPCfg[arg_1_1.nodeId]
	self.nodeId = arg_1_1.nodeId
	self.pathList = arg_1_1.pathList
	self.needPresetReservePanel = false
	self.needHeroEnergy = true
end

function GuildActivitySPSelectHeroProxy:UpdateBar()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		NAVI_BAR
	})
	manager.windowBar:RegistHomeCallBack(function()
		local var_3_0 = GuildActivitySPData:GetCurrentGrid()
		local var_3_1 = var_3_0 ~= nil and var_3_0 > 0 and table.indexof(ActivityClubSPMapCfg.get_id_list_by_activity[GuildActivitySPData:GetCurRunActivityID()], ActivityClubSPCfg[var_3_0].map_id) or 1
		local var_3_2 = GuildActivitySPData:GetCurRunActivityID()

		gameContext:Go("/guildActivitySPWarField", {
			level = var_3_1,
			activityID = var_3_2,
			totalActivityID = var_3_2
		})
	end)
	manager.windowBar:RegistBackCallBack(function()
		JumpTools.Back()
	end)
end

function GuildActivitySPSelectHeroProxy:CustomGetHeroEnergy(arg_5_1, arg_5_2, arg_5_3)
	local var_5_0 = 0

	for iter_5_0, iter_5_1 in pairs((self:GetHeroIDList())) do
		if iter_5_1 and iter_5_1 > 0 then
			var_5_0 = var_5_0 + 1
		end
	end

	return string.format("%d(-%d)", GuildActivitySPData:GetHeroFatigue(arg_5_2), (math.floor(self.activityClubCfg.vitality_cost / var_5_0)))
end

function GuildActivitySPSelectHeroProxy:CustomCheckBeforeGotoHeroInfoUI()
	if #GuildActivitySPData:GetFightHeroList() <= 0 then
		return false, "ACTIVITY_CLUB_NO_FIGHT_HERO_TIP"
	end

	return true
end

function GuildActivitySPSelectHeroProxy:GetHeroTeamInfoRoute()
	return "/guildActivitySPTeamInfo"
end

function GuildActivitySPSelectHeroProxy:CustomCheckBeforeBattle()
	local var_8_0 = self:GetHeroIDList()
	local var_8_1 = 0

	for iter_8_0, iter_8_1 in pairs(var_8_0) do
		if iter_8_1 and iter_8_1 > 0 then
			var_8_1 = var_8_1 + 1
		end
	end

	local var_8_2 = math.floor(self.activityClubCfg.vitality_cost / var_8_1)

	for iter_8_2, iter_8_3 in pairs(var_8_0) do
		if iter_8_3 and iter_8_3 > 0 then
			local var_8_3 = GuildActivitySPData:GetFightHeroById(iter_8_3)

			if var_8_2 > GuildActivitySPData:GetHeroFatigue(iter_8_3) then
				return false, "ACTIVITY_CLUB_HERO_VITALITY_NOT_ENOUGH_TIP"
			end
		end
	end

	return true
end

function GuildActivitySPSelectHeroProxy:GetStageData()
	local var_9_0 = BattleStageFactory.Produce(self.stageType, self.stageID, self.activityID)

	var_9_0:SetNodeId(self.activityClubCfg.id)
	var_9_0:SetPathList(self.pathList)

	return var_9_0
end

return GuildActivitySPSelectHeroProxy
