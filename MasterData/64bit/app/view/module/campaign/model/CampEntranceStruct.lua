local var_0_0 = g.core.const.ConstMgr
local var_0_1 = g.core.const.ConstMgr.FUNCTION_TYPE
local var_0_2 = g.core.common.ModuleUnlock
local var_0_3 = g.core.model.User
local CampEntranceStruct = class("CampEntranceStruct")

function CampEntranceStruct:ctor(arg_1_1)
	self.info = arg_1_1
	self.functionId = arg_1_1.id
	self.show = false
	self.unlocked = false
	self.limitTime = self:_isLimitTime()
	self.containLimitTimeMode = self:_containLimitTimeMode()

	self:updateValue()
end

function CampEntranceStruct:updateValue()
	self.show = self:isShowFuncEntrance(self.functionId)
	self.unlocked = self.functionId == var_0_1.GUILD_WAR and var_0_3.guildWarData:isOpen() or var_0_2:isModuleUnlock(self.functionId)
end

function CampEntranceStruct:_isLimitTime()
	return self.info.limit == 1
end

function CampEntranceStruct:_containLimitTimeMode()
	return self.functionId == var_0_1.STORM
end

function CampEntranceStruct:isOpenLimitTimeMode()
	if self.functionId == var_0_1.STORM then
		return var_0_3.stormCityData:isProcess()
	elseif self.functionId == var_0_1.CROSS_SERVER_ARENA then
		return var_0_3.crossServerArenaData:getSeasonStatus() == g.core.const.ConstMgr.CrossServerArenaConst.CTRL_ON_SEASON and g.core.common.ModuleUnlock:isModuleUnlock(var_0_0.FUNCTION_TYPE.CROSS_SERVER_ARENA)
	else
		return false
	end
end

function CampEntranceStruct:getLimitTimeTipStr()
	if self.functionId == var_0_1.STORM then
		return g.core.lang:get(304539)
	elseif self.functionId == var_0_1.GUILD_WAR then
		return var_0_3.guildWarData:getCurStageTypeDesc()
	elseif self.functionId == var_0_1.GVE then
		return var_0_3.gveDataMgr:getCampaignEntranceStr()
	elseif self.functionId == var_0_1.CROSS_SERVER_ARENA then
		return var_0_3.crossServerArenaData:getCampaignStr()
	elseif self.functionId == var_0_1.TEAM_PVP then
		return g.core.model.User.teamPvpData:getCampaignStr()
	elseif self.functionId == var_0_1.EXPLORATION then
		return var_0_3.explorationData:getExplorationStr()
	elseif self.functionId == var_0_1.BOUNTY then
		return var_0_3.bountyData:getBountyStr()
	elseif self.functionId == var_0_1.TEAM_BATTLE then
		return var_0_3.teamBattleData:getTimeStr()
	elseif self.functionId == var_0_1.RED_CLIFF then
		return g.core.model.User.redCliffData:getCampaignStr()
	elseif self.functionId == var_0_1.NEW_SLG then
		return g.core.model.User.newSlgData:getCampaignStr()
	elseif self.functionId == var_0_1.PUBG then
		return g.core.model.User.pubgData:getCampaignStr()
	elseif self.functionId == var_0_1.BLAZING_ARENA then
		return g.core.model.User.blazingArenaData:getCampaignStr()
	elseif self.functionId == var_0_1.ANNIVERSARY then
		return g.core.model.User.anniversaryData:getCampaignStr()
	elseif self.functionId == var_0_1.SPIRE then
		return var_0_3.spireData:getCampaignStr()
	elseif self.functionId == var_0_1.ELDER_BOSS then
		return var_0_3.elderBossData:getCampaignStr()
	elseif self.functionId == var_0_1.ANCIENTS then
		return var_0_3.ancientsData:getCampaignStr()
	else
		return g.core.lang:get(100539)
	end
end

function CampEntranceStruct:getCDEndTimeStamp()
	if self.functionId == var_0_1.PEAK_ARENA then
		return var_0_3.peakArenaData:getFinishTime()
	elseif self.functionId == var_0_1.MINE then
		return var_0_3.mineData:getCloseTime()
	elseif self.functionId == var_0_1.STORM then
		return var_0_3.stormCityData:getFinishTime()
	elseif self.functionId == var_0_1.GUILD_WAR then
		local var_7_0, var_7_1 = var_0_3.guildWarData:getStartEndTime(var_0_0.GuildWarConst.StageType.SEASON_RESULT)

		return var_7_1
	elseif self.functionId == var_0_1.FOG_NIGHTMARE then
		return (var_0_3.fogNightmareData:getEntranceTime())
	elseif self.functionId == var_0_1.GVE then
		return var_0_3.gveDataMgr:getCampaignEntranceCDTime()
	elseif self.functionId == var_0_1.CROSS_SERVER_ARENA then
		return var_0_3.crossServerArenaData:getCampaignEntranceCDTime()
	elseif self.functionId == var_0_1.TEAM_PVP then
		return g.core.model.User.teamPvpData:getCampaignEntranceCDTime()
	elseif self.functionId == var_0_1.EXPLORATION then
		return var_0_3.explorationData:getFinishTime()
	elseif self.functionId == var_0_1.BOUNTY then
		return var_0_3.bountyData:getFinishTime()
	elseif self.functionId == var_0_1.TEAM_BATTLE then
		return var_0_3.teamBattleData:getFinishTime()
	elseif self.functionId == var_0_1.RED_CLIFF then
		return var_0_3.redCliffData:getActExpireTime()
	elseif self.functionId == var_0_1.NEW_SLG then
		return var_0_3.newSlgData:getActShowTime()
	elseif self.functionId == var_0_1.PUBG then
		return g.core.model.User.pubgData:getCurStageFinishTime()
	elseif self.functionId == var_0_1.BLAZING_ARENA then
		return g.core.model.User.blazingArenaData:getCampaignEntranceCDTime()
	elseif self.functionId == var_0_1.ANNIVERSARY then
		return g.core.model.User.anniversaryData:getCurStageFinishTime()
	elseif self.functionId == var_0_1.SPIRE then
		return var_0_3.spireData:getCurStageFinishTime()
	elseif self.functionId == var_0_1.ELDER_BOSS then
		return var_0_3.elderBossData:getCurStageFinishTime()
	elseif self.functionId == var_0_1.ANCIENTS then
		return var_0_3.ancientsData:getCurStageFinishTime()
	end

	return 0
end

function CampEntranceStruct:isShowFuncEntrance(arg_8_1)
	if not var_0_2:isModuleShow(arg_8_1) then
		return false
	end

	if arg_8_1 == var_0_1.PEAK_ARENA then
		return var_0_3.peakArenaData:isShowEntrance()
	elseif arg_8_1 == var_0_1.MINE then
		return var_0_3.mineData:isInOpenTime()
	elseif arg_8_1 == var_0_1.GUILD_WAR then
		return var_0_3.guildWarData:isShowEntrance()
	elseif arg_8_1 == var_0_1.FOG_NIGHTMARE then
		return var_0_3.fogNightmareData:isShowEntrance()
	elseif arg_8_1 == var_0_1.GVE then
		return var_0_3.gveDataMgr:isGveModuleOpen()
	elseif arg_8_1 == var_0_1.CROSS_SERVER_ARENA then
		return var_0_3.crossServerArenaData:isShowEntrance()
	elseif arg_8_1 == var_0_1.TEAM_PVP then
		return var_0_3.teamPvpData:isActivityOpen()
	elseif arg_8_1 == var_0_1.EXPLORATION then
		return var_0_3.explorationData:isActivityOpen()
	elseif arg_8_1 == var_0_1.RED_CLIFF then
		return var_0_3.redCliffData:isActivityOpen()
	elseif arg_8_1 == var_0_1.BOUNTY then
		return var_0_3.bountyData:isActivityOpen()
	elseif arg_8_1 == var_0_1.TEAM_BATTLE then
		return var_0_3.teamBattleData:isActivityOpen()
	elseif arg_8_1 == var_0_1.NEW_SLG then
		return var_0_3.newSlgData:isOpen()
	elseif arg_8_1 == var_0_1.PUBG then
		return var_0_3.pubgData:isActivityOpen()
	elseif arg_8_1 == var_0_1.BLAZING_ARENA then
		return var_0_3.blazingArenaData:isShowEntrance()
	elseif arg_8_1 == var_0_1.ANNIVERSARY then
		return var_0_3.anniversaryData:isActivityOpen()
	elseif arg_8_1 == var_0_1.SPIRE then
		return var_0_3.spireData:isActivityOpen()
	elseif arg_8_1 == var_0_1.ELDER_BOSS then
		return var_0_3.elderBossData:isShowEntrance()
	elseif arg_8_1 == var_0_1.ANCIENTS then
		return var_0_3.ancientsData:isShowEntrance()
	else
		return true
	end
end

return CampEntranceStruct
