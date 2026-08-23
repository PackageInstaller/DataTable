local var_0_0 = g.core.config.function_info
local var_0_1 = g.core.const.ConstMgr
local var_0_2 = g.core.const.ConstMgr.FUNCTION_TYPE
local var_0_3 = g.core.event.EventManager
local ModuleUnlock = class("ModuleUnlock")

function ModuleUnlock:ctor()
	self:reset()
	self:_init()
end

function ModuleUnlock:reset()
	self._currentLevel = 0
	self._lastLevel = 0
	self._realLastLevel = 0
	self._upgradeLevelArr = {}
	self._upgradeFlag = false
end

function ModuleUnlock:_init()
	local var_3_0 = g.core.model.User:getLevel()

	self._currentLevel = var_3_0
	self._lastLevel = var_3_0
	self._realLastLevel = var_3_0
	self._blockList = {}

	var_0_3:addEventListener(g.core.event.enum.EVENT_RECV_ROLE_INFO, self._onRoleInfoChange, self)
	var_0_3:addEventListener(g.core.event.enum.EVENT_NET_S2C_BLOCKED_ACTIVITY_GETLIST, self._updateBlockedList, self)
	var_0_3:addEventListener(g.core.event.enum.EVENT_NET_S2C_BLOCKED_ACTIVITY_CHANGENOTIFY, self._updateBlockedList, self)
end

function ModuleUnlock:_onRoleInfoChange()
	local var_4_0 = g.core.model.User:getLevel()

	if self._currentLevel < 1 then
		self._currentLevel = var_4_0
		self._lastLevel = var_4_0

		return
	end

	self._lastLevel = self._lastLevel < 1 and var_4_0 or self._currentLevel
	self._currentLevel = var_4_0

	if self._lastLevel < self._currentLevel then
		self:_onLevelUpgrade()
	elseif self._lastLevel > self._currentLevel then
		print("level upgrade error:%d, %d", self._lastLevel, self._currentLevel)
	end
end

function ModuleUnlock:_updateBlockedList(arg_5_1, arg_5_2, arg_5_3)
	self._blockList = arg_5_3.ids or {}
end

function ModuleUnlock:unInit()
	if var_0_3 then
		var_0_3:removeListenerWithTarget(self)
	end
end

function ModuleUnlock:_onLevelUpgrade()
	print("--------------------Level update---------------------")
	print("current level is:%d", self._currentLevel)
	print("-----------------------------------------------------")
	var_0_3:dispatchEvent(g.core.event.enum.EVENT_GUIDE_CHECK, false, {
		tickType = 2,
		level = self._currentLevel
	})

	self._realLastLevel = self._lastLevel

	table.insert(self._upgradeLevelArr, #self._upgradeLevelArr + 1, {
		self._lastLevel,
		self._currentLevel
	})
	g.core.model.User.dungeonData:updateLastChapterAndLand()
	var_0_3:dispatchEvent(g.core.event.enum.EVENT_USER_LEVELUP, true, {
		lastLevel = self._lastLevel,
		curLevel = self._currentLevel
	})

	self._upgradeFlag = true
end

function ModuleUnlock:getLevelUpgradeFlag()
	self._upgradeFlag = false

	return self._upgradeFlag
end

function ModuleUnlock:getRealLastLevel()
	return self._realLastLevel
end

function ModuleUnlock:setRealLastLevel(arg_10_1)
	if arg_10_1 and type(arg_10_1) == "number" then
		self._realLastLevel = arg_10_1
	end
end

function ModuleUnlock:getModuleUnlockLevel(arg_11_1)
	if not arg_11_1 then
		return -1
	end

	local var_11_0 = var_0_0.fetch(arg_11_1)

	if not var_11_0 then
		print("error moduleId:%d", arg_11_1 or 0)

		return -1
	end

	return var_11_0.level
end

function ModuleUnlock:getModuleUnlockLevelAndComment(arg_12_1)
	if not arg_12_1 then
		return -1
	end

	local var_12_0 = var_0_0.get(arg_12_1)

	if not var_12_0 then
		print("error moduleId:%d", arg_12_1 or 0)

		return -1
	end

	return var_12_0.level, self:getModuleLockMSG(arg_12_1)
end

function ModuleUnlock:getModuleUnlockVip(arg_13_1)
	return 0
end

function ModuleUnlock:isFunctionUnlockByUserInfo(arg_14_1, arg_14_2)
	if arg_14_1.level < 0 then
		return false
	end

	local var_14_0 = var_0_0.fetch(arg_14_2)

	if var_14_0.level_type == 1 then
		return var_14_0.show_level <= arg_14_1.level
	end

	return true
end

function ModuleUnlock:isFunctionUnlock(arg_15_1, arg_15_2, arg_15_3)
	if g.core.model.User.homeData:isCensorFunction(arg_15_1) then
		return false
	end

	if arg_15_1 == var_0_2.ALLIANCE and g.core.model.User.allianceData:hasAlliance() then
		return true
	end

	local var_15_0 = self:getModuleUnlockLevel(arg_15_1)

	if var_15_0 < 0 then
		return false
	end

	local var_15_1 = var_0_0.fetch(arg_15_1)

	if not arg_15_3 and var_15_1.preset_ID ~= 0 and not self:isModuleUnlock(var_15_1.preset_ID) then
		return false
	end

	local var_15_2 = var_15_1.unlock_type

	if var_15_1.privilege_type ~= 0 and g.core.model.User.privilegeData:isActiveByType(var_15_1.privilege_type, true) then
		return true
	end

	local var_15_3 = self:_isModuleLevelReach(var_15_1.level_type, var_15_0, arg_15_2)
	local var_15_4 = self:getModuleUnlockVip(arg_15_1)
	local var_15_5 = self:_isModuleRechargeReach(arg_15_1)
	local var_15_6 = false

	if var_15_4 > 0 then
		var_15_6 = var_15_4 <= g.core.model.User:getVipLevel()
	end

	return (var_15_0 == 0 and var_15_6 or var_15_4 == 0 and var_15_3 or var_15_2 == 0 and (var_15_3 or var_15_6) or var_15_3 and var_15_6) and var_15_5
end

function ModuleUnlock:_isModuleRechargeReach(arg_16_1)
	if arg_16_1 == var_0_2.PERMANENT_RECHARGE then
		return g.core.model.User.rechargeData:getTotalRecharge() > 0
	end

	return true
end

function ModuleUnlock:isModuleUnlock(arg_17_1, arg_17_2, arg_17_3)
	if not arg_17_1 then
		return false
	end

	if arg_17_1 == g.core.const.ConstMgr.FUNCTION_TYPE.OUTPOST and config.START_NEW_GUIDE then
		return true
	end

	for iter_17_0, iter_17_1 in ipairs(self._blockList) do
		if iter_17_1 == arg_17_1 then
			return false, (g.core.lang:get(1035))
		end
	end

	local var_17_0 = self:isFunctionUnlock(arg_17_1, arg_17_2, arg_17_3)
	local var_17_1 = var_17_0

	if not var_17_0 then
		if arg_17_1 == var_0_2.SUMMER_ACTIVITY then
			var_17_1 = g.core.model.User.themeData:isMetUnlockAdditionalConditions()
		end

		return var_17_1
	end

	if arg_17_1 == var_0_2.FIGHT_ACTIVITY then
		var_17_1 = g.core.model.User.fightActivityData:isShowEntrance()
	elseif arg_17_1 == var_0_2.GUILD_ACTIVITY then
		var_17_1 = g.core.model.User.guildActivityData:isShowEntrance()
	elseif arg_17_1 == var_0_2.RECHARGE_GUIDE then
		var_17_1 = self:isUnlockDuringCreateTime(var_0_1.PARAMETER_CONST.RECHARGE_GUIDE_START, var_0_1.PARAMETER_CONST.RECHARGE_GUIDE_END)
	elseif arg_17_1 == var_0_2.HANDBOOK_ACTIVITY then
		var_17_1 = g.core.model.User.handBookActivityData:isShowEntrance()
	elseif arg_17_1 == var_0_2.OPEN_PURCHASE_NPC then
		var_17_1 = g.core.model.User.openPurchaseData:isAllProcess() or g.core.model.User.openPurchaseData:isCustomProcess()
	elseif arg_17_1 == var_0_2.MINE then
		var_17_1 = self:isModuleShow(arg_17_1)
	elseif arg_17_1 == var_0_2.REDPACKET_RAIN then
		var_17_1 = g.core.model.User.redPacketRainData:isProcess()
	elseif arg_17_1 == var_0_2.CELEBRATE_HOLIDAY then
		var_17_1 = g.core.model.User.holidayData:isProcess()
	elseif arg_17_1 == var_0_2.COMMANDER_WORLD then
		var_17_1 = g.core.model.User.commanderWorldData:isProcess() or true
	elseif arg_17_1 == var_0_2.BIND_PHONE_ACTIVITY then
		var_17_1 = self:isBindPhoneOpidShow((g.core.platform.PlatformProxy:getOpId()))
	elseif arg_17_1 == var_0_2.GUILD_WAR then
		var_17_1 = self:isModuleUnlock(var_0_2.GUILD_WAR_GUILD_LV)
	elseif arg_17_1 == var_0_2.GVE then
		var_17_1 = g.core.model.User.gveDataMgr:isGveModuleOpen()
	elseif arg_17_1 == var_0_2.FORMATION_PRE then
		var_17_1 = g.core.model.User.formationData:isOpenPreFormation()
	elseif arg_17_1 == var_0_2.GUILD_BOSS then
		var_17_1 = self:isModuleShow(arg_17_1)
	elseif arg_17_1 == var_0_2.CROSS_SERVER_ARENA then
		local var_17_2 = g.core.model.User.crossServerArenaData:getSeasonInfo()

		var_17_1 = self:_isModuleLevelReach(8, (var_17_2 or nil) and (var_17_2.open_day or 1))
	else
		var_17_1 = arg_17_1 == var_0_2.TEAM_PVP and g.core.model.User.teamPvpData:isOpenDaysSatisfy() or arg_17_1 == var_0_2.EXPLORATION and g.core.model.User.explorationData:isOpenDaySatisfy() or arg_17_1 == var_0_2.RED_CLIFF and g.core.model.User.redCliffData:isOpenDaysSatisfy() or arg_17_1 == var_0_2.RECYCLE_CULTIVATE and #g.core.model.User.recycleCultivateData:getRecycleInfo() > 0 or arg_17_1 == var_0_2.PUBG and g.core.model.User.pubgData:isOpenDaysAvailable() or arg_17_1 == var_0_2.SUCCUBA and #(g.core.model.User.succubaData:getSuccubaList() or {}) >= 0 or arg_17_1 == var_0_2.BLAZING_ARENA and g.core.model.User.blazingArenaData:isInActivityTime() or arg_17_1 == var_0_2.SUCCUBA_LAUNCH and g.core.model.User.succubaLaunchData:isActOpen() or arg_17_1 == var_0_2.ANNIVERSARY and g.core.model.User.anniversaryData:isInActivityTime() or arg_17_1 == var_0_2.SPIRE and g.core.model.User.spireData:isInActivityTime() or arg_17_1 == var_0_2.RELEASE_ACTIVITY and g.core.model.User.releaseActivityData:isActivityOpen() or true
	end

	if var_17_1 and var_0_0.get(arg_17_1).refund_shutdown == 1 then
		var_17_1 = not g.core.model.User.refundData:isClosed()
	end

	return var_17_1
end

function ModuleUnlock:isBindPhoneOpidShow(arg_18_1)
	return true
end

function ModuleUnlock:_isModuleLevelReach(arg_19_1, arg_19_2, arg_19_3)
	local var_19_0 = false

	if arg_19_1 == 1 then
		var_19_0 = arg_19_3 and (self._upgradeFlag and arg_19_2 < self._currentLevel or arg_19_2 <= self._currentLevel) or arg_19_2 <= self._currentLevel
	elseif arg_19_1 == 2 then
		var_19_0 = arg_19_2 <= g.core.model.User.dungeonData:getLastPassedChapter()
	elseif arg_19_1 == 3 then
		if not g.core.model.User.guildData:hasGuild() then
			return false
		end

		var_19_0 = arg_19_2 <= g.core.model.User.guildData:getGuildLevel()
	elseif arg_19_1 == 4 then
		var_19_0 = arg_19_2 <= g.core.model.User.dungeonData:getLastPassedStageId()
	elseif arg_19_1 == 5 then
		var_19_0 = arg_19_2 <= g.core.model.User.recruitData:getAdvanceTotalNum()
	elseif arg_19_1 == 6 then
		var_19_0 = arg_19_2 <= g.core.model.User.handBookData:getTotalKnightBookScore()
	elseif arg_19_1 == 7 then
		local var_19_1 = g.core.model.User.bioData:getChapter(arg_19_2)

		var_19_0 = var_19_1 and var_19_1.finish
	elseif arg_19_1 == 8 then
		var_19_0 = arg_19_2 <= g.core.common.ServerTime:getOpenDays()
	elseif arg_19_1 == 9 then
		local var_19_3 = g.core.model.User.recruitData:getDrawInfo(100007)

		var_19_0 = arg_19_2 <= ((var_19_3 or nil) and var_19_3:getTotalCount())
	elseif arg_19_1 == 10 then
		var_19_0 = arg_19_2 <= #g.core.model.User.knightsData:getAllFullStarKnights(2) + #g.core.model.User.artifactData:getAllFullStarArtifacts(3) + #g.core.model.User.petsData:getOwnPetArrByFilter(function(arg_20_0)
			return arg_20_0:isMaxStar() and arg_20_0:getQuality() == 3
		end) + #g.core.model.User.uniteTokenData:getFullUniteTokenArr(2)
	elseif arg_19_1 == 11 then
		var_19_0 = arg_19_2 <= math.max(g.core.model.User.fogNightmareData:getTowerData():getCurrentMaxFloorNum(), (g.core.model.User.fogNightmareData:getTowerData():getForeverMaxFloorNum()))
	elseif arg_19_1 == 12 then
		return g.core.model.User.firstRechargeData:isGetFirstAward()
	elseif arg_19_1 == 13 then
		return arg_19_2 <= g.core.model.User.recruitData:getKnightSoulTotalTime()
	elseif arg_19_1 == 14 then
		local var_19_5 = g.core.model.User.recruitData:getDrawInfo(100301)

		var_19_0 = arg_19_2 <= ((var_19_5 or nil) and var_19_5:getTotalCount())
	elseif arg_19_1 == 15 then
		var_19_0 = arg_19_2 <= g.core.model.User.mysteryData:getLastPassChapterId()
	elseif arg_19_1 == 16 then
		var_19_0 = arg_19_2 <= g.core.model.User.allianceData:getAllianceLevel()
	elseif arg_19_1 == 20 then
		var_19_0 = arg_19_2 <= math.max(g.core.model.User.wushData:getOldMaxFloor(), (g.core.model.User.wushData:getCurFloorId()))
	elseif arg_19_1 == 5000001 then
		return g.core.model.User.bioData:getCampaign(arg_19_2).finish
	elseif arg_19_1 == 5000002 then
		return arg_19_2 <= g.core.model.User.spireData:getHistoryPassTower()
	end

	return var_19_0
end

function ModuleUnlock:getUnlockTxt(arg_21_1)
	local var_21_0 = var_0_0.get(arg_21_1)

	if g.core.model.User.refundData:isClosed() then
		return g.core.lang:get(102409)
	end

	local var_21_1 = var_21_0.level_type
	local var_21_2 = self:getModuleUnlockLevel(arg_21_1)

	if var_21_0.level_type == 4 then
		return g.core.lang:get(1270 + tonumber(var_21_1), {
			level = g.core.config.dungeon_stage_info.get(var_21_2).chapter_id,
			level2 = g.core.model.User.dungeonData:getStageIndex(var_21_2)
		})
	elseif var_21_1 == 5000001 then
		return g.core.lang:get(302102, {
			name = g.core.model.User.bioData:getCampaign(var_21_2).name
		})
	else
		return g.core.lang:get(1270 + tonumber(var_21_1), {
			level = var_21_2
		})
	end
end

function ModuleUnlock:isModuleShow(arg_22_1, arg_22_2)
	if not arg_22_1 then
		return false
	end

	if g.core.model.User.homeData:isCensorFunction(arg_22_1) then
		return false
	end

	if arg_22_1 == var_0_2.ALLIANCE and g.core.model.User.allianceData:hasAlliance() then
		return true
	end

	for iter_22_0, iter_22_1 in ipairs(self._blockList) do
		if iter_22_1 == arg_22_1 then
			return false
		end
	end

	local var_22_0 = var_0_0.fetch(arg_22_1)

	if not var_22_0 then
		return false
	end

	if var_22_0.preset_ID ~= 0 and not self:isModuleUnlock(var_22_0.preset_ID) then
		return false
	end

	local var_22_1 = g.core.model.User
	local var_22_2 = self:_isModuleLevelReach(var_22_0.show_level_type, var_22_0.show_level, arg_22_2)
	local var_22_3 = false

	if var_22_0.show_vip_level > 0 then
		var_22_3 = var_22_0.show_vip_level <= var_22_1:getVipLevel()
	end

	if not (var_22_0.show_level == 0 and var_22_3 or var_22_0.show_vip_level == 0 and var_22_2 or var_22_0.show_unlock_type == 0 and (var_22_2 or var_22_3) or var_22_2 and var_22_3) then
		return false
	end

	if arg_22_1 == var_0_2.FIGHT_ACTIVITY then
		return var_22_1.fightActivityData:isShowEntrance()
	elseif arg_22_1 == var_0_2.GUILD_ACTIVITY then
		return var_22_1.guildActivityData:isShowEntrance()
	elseif arg_22_1 == var_0_2.RECHARGE_GUIDE then
		return self:isUnlockDuringCreateTime(var_0_1.PARAMETER_CONST.RECHARGE_GUIDE_START, var_0_1.PARAMETER_CONST.RECHARGE_GUIDE_END)
	elseif arg_22_1 == var_0_2.HANDBOOK_ACTIVITY then
		return var_22_1.handBookActivityData:isShowEntrance()
	elseif arg_22_1 == var_0_2.OPEN_PURCHASE_NPC then
		return var_22_1.openPurchaseData:isAllProcess() or var_22_1.openPurchaseData:isCustomProcess()
	elseif arg_22_1 == var_0_2.REDPACKET_RAIN then
		return var_22_1.redPacketRainData:isProcess()
	elseif arg_22_1 == var_0_2.CELEBRATE_HOLIDAY then
		return var_22_1.holidayData:isProcess()
	elseif arg_22_1 == var_0_2.COMMANDER_WORLD then
		return var_22_1.commanderWorldData:isProcess()
	elseif arg_22_1 == var_0_2.BIND_PHONE_ACTIVITY then
		return self:isBindPhoneOpidShow((g.core.platform.PlatformProxy:getOpId()))
	elseif arg_22_1 == var_0_2.FORMATION_PRE then
		return var_22_1.formationData:isOpenPreFormation()
	elseif arg_22_1 == var_0_2.BIRTHDAY_CARD then
		return var_22_1.userFestivalData:isShowEntrance()
	elseif arg_22_1 == var_0_2.RECYCLE_CULTIVATE then
		return #g.core.model.User.recycleCultivateData:getRecycleInfo() > 0
	else
		return true
	end
end

function ModuleUnlock:isModuleForeShow(arg_23_1)
	if not arg_23_1 then
		return false
	end

	local var_23_0 = g.core.config.function_foreshow_info.get(arg_23_1)
	local var_23_1 = var_0_0.get(var_23_0.function_id)
	local var_23_2 = self:_isModuleLevelReach(var_23_0.show_type, var_23_0.show_level, false)

	if var_23_0.function_id == var_0_2.FIGHT_ACTIVITY then
		return var_23_2 and g.core.model.User.fightActivityData:isShowEntrance()
	elseif var_23_0.function_id == var_0_2.GUILD_ACTIVITY then
		return var_23_2 and g.core.model.User.guildActivityData:isShowEntrance()
	elseif var_23_0.function_id == var_0_2.HANDBOOK_ACTIVITY then
		return var_23_2 and g.core.model.User.handBookActivityData:isShowEntrance()
	end

	local var_23_3 = var_23_1.show_vip_level
	local var_23_4 = false

	if var_23_1.show_vip_level > 0 then
		var_23_4 = var_23_3 <= g.core.model.User:getVipLevel()
	end

	if var_23_0.show_level == 0 then
		return var_23_4
	elseif var_23_3 == 0 then
		return var_23_2
	elseif var_23_1.show_unlock_type == 0 then
		return var_23_2 or var_23_4
	else
		return var_23_2 and var_23_4
	end
end

function ModuleUnlock:canPreviewModule(arg_24_1)
	local var_24_0 = self:getModuleUnlockLevel(arg_24_1) - 5
	local var_24_1 = self:getModuleUnlockVip(arg_24_1) - 2

	return var_24_0 > 0 and var_24_0 <= self._currentLevel or var_24_1 > 0 and var_24_1 <= g.core.model.User:getVipLevel()
end

function ModuleUnlock:checkModuleUnlockStatus(arg_25_1, arg_25_2)
	if not self:isModuleUnlock(arg_25_1, arg_25_2) then
		g.core.module.ModuleManager:tip(self:getModuleLockMSG(arg_25_1))

		return false
	end

	return true
end

function ModuleUnlock:getModuleLockMSG(arg_26_1)
	local var_26_0 = ""

	for iter_26_0, iter_26_1 in ipairs(self._blockList) do
		if iter_26_1 == arg_26_1 then
			var_26_0 = g.core.lang:get(1035)

			return var_26_0
		end
	end

	if g.core.model.User.refundData:isClosed() then
		var_26_0 = g.core.lang:get(102409)
	else
		local var_26_1 = var_0_0.get(arg_26_1)

		var_26_0 = var_26_1 and var_26_1.lock_direction or ""
	end

	return var_26_0
end

function ModuleUnlock:getUnlockComment(arg_27_1, arg_27_2)
	local var_27_0 = self:isModuleUnlock(arg_27_1, arg_27_2)

	if not var_27_0 then
		return self:getModuleLockMSG(arg_27_1), var_27_0
	end

	return "", var_27_0
end

function ModuleUnlock:isUnlockDuringCreateTime(arg_28_1, arg_28_2)
	local var_28_0 = g.core.config.parameter_info.get(arg_28_2).parameter
	local var_28_1 = g.core.common.ServerTime:getCreateRoleDays()

	return g.core.config.parameter_info.get(arg_28_1).parameter <= var_28_1 and var_28_1 < var_28_0
end

function ModuleUnlock:isModuleLevelShow(arg_29_1)
	local var_29_0 = var_0_0.get(arg_29_1)

	if var_29_0 then
		return self._currentLevel >= var_29_0.show_level
	end

	return false
end

function ModuleUnlock:isModuleUnlockWithCustomData(arg_30_1)
	if type(arg_30_1) == "table" then
		local var_30_0 = arg_30_1.functionId or 0

		if var_30_0 > 0 then
			return self:isModuleUnlock(var_30_0)
		else
			return true
		end
	end
end

return ModuleUnlock
