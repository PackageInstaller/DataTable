local var_0_0 = g.core.config.fog_level_info
local var_0_1 = g.core.config.fog_seal_info
local var_0_2 = g.core.const.ConstMgr.FogNightmareConst
local FogNightmareData = class("FogNightmareData")

function FogNightmareData:ctor()
	self._formationData = require("app.view.module.fogNightmare.model.data.FogNightmareFormationData").new()
	self._talentData = require("app.view.module.fogNightmare.model.data.FogNightmareTalentData").new()
	self._keepsakeData = require("app.view.module.fogNightmare.model.data.FogNightmareKeepsakeData").new()
	self._towerData = require("app.view.module.fogNightmare.model.data.FogNightmareTowerData").new()
	self._idleData = require("app.view.module.fogNightmare.model.data.FogNightmareIdleData").new()
	self._assistaneData = require("app.view.module.fogNightmare.model.data.FogNightmareAssistantData").new()
	self._autoPlayData = require("app.view.module.fogNightmare.model.data.FogNightmareAutoPlayData").new()
	self._forbidCnt = 0

	self:initData()
end

function FogNightmareData:initData()
	self._activitySubId = 0
	self._previewTime = 0
	self._startTime = 0
	self._endTime = 0
	self._expireTime = 0
	self._seasonId = 0
	self._serverOpenDaysLimit = 0
	self._userLevelLimitMin = 0
	self._userLevelLimitMax = 0
	self._isNewSeasonId = false
	self._fogLevel = 1
	self._fogMaxLevel = 1
	self._fogLevelUnlockSealCount = {}
	self._fogSealLevel = 0
	self._fogTalentMaxLevel = 0
	self._sealUnlockLevelList = {}
	self._backWave = 1
	self._seasonRankList = nil
	self._mySeasonRank = 0
	self._weeklyBuff = nil
	self._weeklyBuffCfgMap = {}
	self._weeklyBuffHistory = {}
	self._isEnterFormation = false
	self._notPopViewList = {}
	self._oldNotPopViewList = {}
	self._isInitJson = false
	self._unlockSealData = {}
	self._unlockSealTabData = {}
	self._formationChangeFloor = {}
	self._helperKnightsConnectTime = 0

	self._formationData:initData()
	self._talentData:initData()
	self._keepsakeData:initData()
	self._towerData:initData()
	self._assistaneData:initData()

	self._awardsPopIsShowOver = true

	self._autoPlayData:initData()
	self._autoPlayData:setVisualPlayer((require("app.view.module.fogNightmare.model.struct.player.FogNightmarePlayerWaiter").new()))
	self._autoPlayData:setAutoInterval(g.core.config.parameter_info.get(20059).parameter / 1000)

	self._serverList = {}
	self._serverSid = nil

	self:_initCfg()
end

function FogNightmareData:_initCfg()
	local var_3_0 = {}

	for iter_3_0, iter_3_1 in var_0_1.ipairs() do
		var_3_0[iter_3_1.unlock_level] = var_3_0[iter_3_1.unlock_level] or {}

		table.insert(var_3_0[iter_3_1.unlock_level], iter_3_1)
	end

	self._sealUnlockLevelList = var_3_0

	for iter_3_2, iter_3_3 in var_0_0.ipairs() do
		local var_3_1 = 0

		for iter_3_4, iter_3_5 in pairs(var_3_0) do
			if iter_3_3.level < iter_3_4 then
				break
			end

			var_3_1 = var_3_1 + #iter_3_5
		end

		self._fogLevelUnlockSealCount[iter_3_3.level] = var_3_1

		if iter_3_3.level > self._fogMaxLevel then
			self._fogMaxLevel = iter_3_3.level
		end
	end

	for iter_3_6, iter_3_7 in g.core.config.fog_weekly_buff_info.ipairs() do
		self._weeklyBuffCfgMap[iter_3_7.id] = {
			cfg = iter_3_7,
			next = iter_3_7.next_id
		}
	end

	for iter_3_8, iter_3_9 in pairs(self._weeklyBuffCfgMap) do
		self._weeklyBuffCfgMap[iter_3_9.next].pre = self._weeklyBuffCfgMap[iter_3_9.next].pre or iter_3_9
	end
end

function FogNightmareData:loadJson()
	local var_4_0 = g.core.common.Storage:load(var_0_2.NOT_POP_JSON_NAME, true) or {}

	self._notPopViewList = {}

	table.merge(self._notPopViewList, var_4_0)
	table.merge(self._oldNotPopViewList, var_4_0)

	self._hasNewFloor = var_4_0.hasNewFloorParam == true
end

function FogNightmareData:onS2CGetInfo(arg_5_1)
	self._seasonId = arg_5_1.activity_id or 0
	self._activitySubId = arg_5_1.activity_sub_id or 0
	self._isNewSeasonId = false
	self._startTime = arg_5_1.start_time or 0
	self._endTime = arg_5_1.end_time or 0
	self._expireTime = arg_5_1.expire_time or 0
	self._serverOpenDaysLimit = arg_5_1.open_day or 0
	self._userLevelLimitMin = arg_5_1.min_level or 0
	self._userLevelLimitMax = arg_5_1.max_level or 0
	self._sealResetTimes = arg_5_1.seal_reset_times or 0
	self._weeklyBuff = nil

	if arg_5_1.weekly_buff and arg_5_1.weekly_buff ~= 0 then
		self._weeklyBuff = g.core.config.fog_weekly_buff_info.get(arg_5_1.weekly_buff)

		self:_updateWeeklyBuffHistory()
	end

	if not self._notPopViewList["fognightmare" .. self._seasonId] then
		self._notPopViewList = {}
		self._notPopViewList["fognightmare" .. self._seasonId] = true
		self._oldNotPopViewList = clone(self._notPopViewList)
	end

	self._fogLevel = arg_5_1.level or 1
	self._fogSealLevel = var_0_0.get(self._fogLevel).seal_level
	self._fogTalentMaxLevel = var_0_0.get(self._fogLevel).talent_addition_level
	self._fogExtraSealTimes = var_0_0.get(self._fogLevel).seal_times
	self._fogExtraSealState = arg_5_1.extra_state

	self._talentData:setRandSealData(arg_5_1)
	self._talentData:setRandSealDataMap(arg_5_1.onekey_seals)
	self._towerData:updatePhaseAward(arg_5_1.phase_awards)
	self._towerData:updateData(arg_5_1)

	if arg_5_1.fog_knights then
		self._formationData:updateMemberPoolData(arg_5_1)
	else
		self._formationData:clearPoolMember()
	end

	self._formationData:updateUsedKnight(arg_5_1.use_knight_ids)
	self:_updateWaveInFormation()
	self._formationData:updateUsedArtifact(arg_5_1.use_artifact_ids)
end

function FogNightmareData:onS2CNextFloor(arg_6_1)
	self._towerData:enterNextFloor()
	self._towerData:replaceFloorStage(arg_6_1)
	self._talentData:setRandSealData({})
	self._formationData:updateUsedKnight({})

	for iter_6_0 = 1, var_0_2.FORMATION_MAX_COUNT do
		self._formationData:setUseFormation(iter_6_0, false)
	end

	self._formationData:updateUsedArtifact({})
end

function FogNightmareData:onS2CChooseStage(arg_7_1)
	self._towerData:updateOneFloorData(arg_7_1)
end

function FogNightmareData:onS2CUpgradeLevel(arg_8_1)
	if arg_8_1.level then
		self._fogLevel = arg_8_1.level
	end

	self:hasNewFloor()
end

function FogNightmareData:onS2CFriendHelperGetKnights(arg_9_1)
	self._assistaneData:onS2CFriendHelperGetKnights(arg_9_1)
end

function FogNightmareData:checkErrorCode(arg_10_1)
	if arg_10_1.ret == 980 or arg_10_1.ret == 981 then
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_FRIEND_ASSISTANT_ERROR)
	end
end

function FogNightmareData:onS2CFriendHelperSetKnights(arg_11_1)
	self._assistaneData:onS2CFriendHelperSetKnights(arg_11_1)
end

function FogNightmareData:onS2CFriendHelperShowKnights(arg_12_1)
	self._assistaneData:onS2CFriendHelperSetKnights(arg_12_1)
	self._assistaneData:setIsInitProto()
end

function FogNightmareData:onS2CFlushRedPoint(arg_13_1)
	self._seasonId = arg_13_1.activity_id or 0
	self._activitySubId = arg_13_1.activity_sub_id or 0
	self._serverOpenDaysLimit = arg_13_1.open_day or 0
	self._startTime = arg_13_1.start_time or 0
	self._endTime = arg_13_1.end_time or 0
	self._expireTime = arg_13_1.expire_time or 0
	self._userLevelLimitMin = arg_13_1.min_level or 0
	self._userLevelLimitMax = arg_13_1.max_level or 0

	if arg_13_1.fog_knights then
		self._formationData:updateMemberPoolData(arg_13_1)
	end

	if arg_13_1.idle_infos then
		self._idleData:updateData({
			idle_info = arg_13_1.idle_infos
		}, arg_13_1.level)
	end

	self._fogLevel = arg_13_1.level or 1
	self._hasPhaseAwardByRedPoint = arg_13_1.has_phase_award or false
	self._canAddKnightByRedPoint = arg_13_1.can_add_knight or false

	if not self._isInitJson then
		self._isInitJson = true

		self:loadJson()
	end
end

function FogNightmareData:onS2CUpdateAcitivty(arg_14_1)
	self._seasonId = arg_14_1.activity_id or 0
	self._serverOpenDaysLimit = arg_14_1.open_day or 0
	self._startTime = arg_14_1.start_time or 0
	self._endTime = arg_14_1.end_time or 0
	self._expireTime = arg_14_1.expire_time or 0
	self._userLevelLimitMin = arg_14_1.min_level or 0
	self._userLevelLimitMax = arg_14_1.max_level or 0

	self._towerData:resetData()

	self._isNewSeasonId = true
end

function FogNightmareData:onS2CCommonRankList(arg_15_1)
	if self:getFogStageType() == var_0_2.ACTIVITY_STATE.END then
		self._seasonRankList = arg_15_1.rank_units or {}
		self._mySeasonRank = arg_15_1.self_rank or 0
	end
end

function FogNightmareData:onS2CFogTalentAttr(arg_16_1)
	self._formationData:setTalentData(arg_16_1.attr or {})
end

function FogNightmareData:onS2CFogChallengeFinish(arg_17_1)
	self._towerData:updateFloorDataByChallengeFinishInfo(arg_17_1)
	self._formationData:updateUsedKnight(arg_17_1.use_knight_ids)
	self:_updateWaveInFormation()
	self._formationData:updateKnightHps(arg_17_1.kn_hps_after)
	self._formationData:updateUsedArtifact(arg_17_1.use_artifact_ids)
	self:saveKnightPoolInfo()
end

function FogNightmareData:_updateWaveInFormation()
	local var_18_0 = self._towerData:getCurFloorStruct()

	if var_18_0 then
		local var_18_1 = var_18_0:getSelectedStage()

		if var_18_1 and var_18_1[1] then
			for iter_18_0, iter_18_1 in pairs((var_18_1[1]:getAllWave())) do
				self._formationData:setUseFormation(iter_18_0, iter_18_1:isFinish())
			end
		end
	end
end

function FogNightmareData:onS2CFogBack(arg_19_1)
	if arg_19_1.type == 1 then
		self._towerData:resetAllWave(arg_19_1.floor, arg_19_1.stage)
	else
		self._towerData:resetOneWave(arg_19_1.floor, arg_19_1.stage, arg_19_1.wave)

		self._backWave = arg_19_1.wave
	end

	self._formationData:updateUsedKnight(arg_19_1.use_knight_ids)
	self:_updateWaveInFormation()
	self._formationData:updateUsedArtifact(arg_19_1.use_artifact_ids)
	self._formationData:updateMemberPoolData(arg_19_1)
end

function FogNightmareData:onS2CFogGiveUp(arg_20_1)
	self._formationData:saveResultData()
	self._formationData:clearPoolMember(arg_20_1)
	self._formationData:updateUsedKnight({})
	self:_updateWaveInFormation()
	self._formationData:updateUsedArtifact({})
	self._formationData:clearUseFormation()
	self._towerData:saveResultData()
	self._towerData:resetData()
	self._keepsakeData:clearSuitMap()

	self._notPopViewList = {}
	self._notPopViewList["fognightmare" .. self._seasonId] = true

	self:saveNotPopParamJson()
end

function FogNightmareData:onS2CUpdateKnight(arg_21_1)
	self._formationData:updateKnightList(arg_21_1.knights)
end

function FogNightmareData:onS2CFogRecover(arg_22_1)
	self._towerData:executeWave(arg_22_1.floor, arg_22_1.stage, arg_22_1, true)
	self._formationData:updateKnightList(arg_22_1.fog_knights)
end

function FogNightmareData:onS2CFogMakeChoice(arg_23_1)
	self._formationData:updateMemberPoolData(arg_23_1)

	local var_23_0 = clone(arg_23_1)
	local var_23_1 = self._towerData:getCurrentFloorNum()

	var_23_0.floor = var_23_1
	var_23_0.stage = self._towerData:getFloorStruct(var_23_1):getSelectedStage()[1]:getStageId()
	var_23_0.wave = 1

	self._towerData:executeWave(var_23_0.floor, var_23_0.stage, var_23_0, true)
end

function FogNightmareData:onS2CDemonConvert(arg_24_1)
	self._talentData:setRandSealData(arg_24_1)

	local var_24_0 = clone(arg_24_1)
	local var_24_1 = self._towerData:getCurrentFloorNum()

	var_24_0.floor = var_24_1
	var_24_0.stage = self._towerData:getFloorStruct(var_24_1):getSelectedStage()[1]:getStageId()
	var_24_0.wave = 1

	self._towerData:executeWave(var_24_0.floor, var_24_0.stage, var_24_0, true)
end

function FogNightmareData:onS2CFogChooseSeal(arg_25_1)
	self._towerData:setPassCurFloor(true)
	self._formationData:updateKnightKeepsake(arg_25_1)
end

function FogNightmareData:onS2CFogFast(arg_26_1)
	self._formationData:updateMemberPoolData(arg_26_1)
	self._towerData:setCurFloor(arg_26_1.floor)
end

function FogNightmareData:onS2CFogChooseExtraSeal(arg_27_1)
	self._formationData:updateKnightKeepsake(arg_27_1)
end

function FogNightmareData:onS2CFogGetServerInfos(arg_28_1)
	self._serverList = arg_28_1.server_infos
	self._serverSid = arg_28_1.sid
end

function FogNightmareData:onS2CFogOneKeySweep(arg_29_1)
	self._talentData:setRandSealDataMap(arg_29_1.seals)
	self._towerData:setCurFloor(arg_29_1.cur_floor)
end

function FogNightmareData:onS2CFogOneKeyChooseSeal(arg_30_1)
	if arg_30_1.fog_knights then
		self._formationData:updateKnightKeepsake({
			fog_knight = arg_30_1.fog_knights
		})
	end
end

function FogNightmareData:onS2CFogStageSkip(arg_31_1)
	self._towerData:setPassWaved(true)
end

function FogNightmareData:isOpen()
	if not g.core.common.ModuleUnlock:isModuleUnlock(g.core.const.ConstMgr.FUNCTION_TYPE.FOG_NIGHTMARE) then
		return false, false
	end

	if self._userLevelLimitMax ~= self._userLevelLimitMin then
		local var_32_0 = g.core.model.User:getLevel()

		if var_32_0 < self._userLevelLimitMin or var_32_0 > self._userLevelLimitMax then
			return false, false
		end
	end

	local var_32_1 = g.core.common.ServerTime

	if g.core.common.ServerTime:getOpenDays() < self._serverOpenDaysLimit then
		return false, false
	end

	local var_32_2 = var_32_1:getTime()

	return var_32_2 >= self._startTime and var_32_2 <= self._expireTime, var_32_2 >= self._startTime and var_32_2 <= self._endTime
end

function FogNightmareData:isGuideOpen()
	if not g.core.common.ModuleUnlock:isModuleUnlock(g.core.const.ConstMgr.FUNCTION_TYPE.FOG_NIGHTMARE) then
		return false
	end

	if self._userLevelLimitMax ~= self._userLevelLimitMin then
		local var_33_0 = g.core.model.User:getLevel()

		if var_33_0 < self._userLevelLimitMin or var_33_0 > self._userLevelLimitMax then
			return false
		end
	end

	local var_33_1 = g.core.common.ServerTime

	if g.core.common.ServerTime:getOpenDays() < self._serverOpenDaysLimit then
		return false
	end

	local var_33_2 = var_33_1:getTime()

	if var_33_2 < self._startTime or var_33_2 > self._endTime then
		return false
	end

	return true
end

function FogNightmareData:isShowEntrance()
	if self._userLevelLimitMax ~= self._userLevelLimitMin then
		local var_34_0 = g.core.model.User:getLevel()

		if var_34_0 < self._userLevelLimitMin or var_34_0 > self._userLevelLimitMax then
			return false
		end
	end

	local var_34_1 = g.core.common.ServerTime

	if g.core.common.ServerTime:getOpenDays() < self._serverOpenDaysLimit then
		return false
	end

	local var_34_2 = var_34_1:getTime()

	if var_34_2 < self._startTime or var_34_2 > self._expireTime then
		return false
	end

	return true
end

function FogNightmareData:resetRankList()
	self._seasonRankList = nil
	self._mySeasonRank = 0
end

function FogNightmareData:getFogStageType(arg_36_1)
	local var_36_0 = arg_36_1 or g.core.common.ServerTime:getTime()
	local var_36_1 = var_0_2.ACTIVITY_STATE.NONE

	if var_36_0 > self._expireTime then
		var_36_1 = var_0_2.ACTIVITY_STATE.NONE
	elseif var_36_0 > self._endTime then
		var_36_1 = var_0_2.ACTIVITY_STATE.END
	elseif var_36_0 > self._startTime then
		var_36_1 = var_0_2.ACTIVITY_STATE.OPEN
	end

	return var_36_1
end

function FogNightmareData:getSeasonOpenDays()
	local var_37_0 = -g.core.common.ServerTime:secondsFromToday(self._startTime)
	local var_37_1 = g.core.common.ServerTime:getTime() - (self._startTime + var_37_0)

	return math.ceil((var_37_0 + var_37_1) / 86400), (var_37_0 + var_37_1) / 86400
end

function FogNightmareData:getFogLevel()
	return self._fogLevel
end

function FogNightmareData:setFogTempLevel(arg_39_1)
	self._fogTempLevel = arg_39_1
end

function FogNightmareData:getFogTempLevel()
	return self._fogTempLevel
end

function FogNightmareData:getMaxKnightNum()
	local var_41_0 = var_0_0.fetch(self._fogLevel)

	return (var_41_0 or nil) and (var_41_0.knight_num or 0)
end

function FogNightmareData:getFogMaxLevel()
	return self._fogMaxLevel
end

function FogNightmareData:getFogSealLevel()
	return self._fogSealLevel
end

function FogNightmareData:getBackWave()
	return self._backWave
end

function FogNightmareData:getFogTalentMaxLevel()
	return self._fogTalentMaxLevel
end

function FogNightmareData:getFogExtraSealTimes()
	return self._fogExtraSealTimes
end

function FogNightmareData:setFogExtraSealState(arg_47_1)
	self._fogExtraSealState = arg_47_1
end

function FogNightmareData:getFogExtraSealState()
	return self._fogExtraSealState
end

function FogNightmareData:getFogSeasonRankList()
	return self._seasonRankList
end

function FogNightmareData:getMySeasonRank()
	return self._mySeasonRank
end

function FogNightmareData:getMaxIdleTimeDHByLevel(arg_51_1)
	return self._idleData:getMaxIdleTimeDHByLevel(arg_51_1)
end

function FogNightmareData:getFogLevelUnlockMaxSealCount(arg_52_1)
	return self._fogLevelUnlockSealCount[arg_52_1] or 0
end

function FogNightmareData:getFogLevelExp()
	return (g.core.model.User.resourceData:getResourceById(g.core.common.Goods.RESOURCE.TYPE_FOG_NIGHTMARE_EXP))
end

function FogNightmareData:getEndTime()
	return self._endTime
end

function FogNightmareData:getEntranceTime()
	local var_55_0 = self:getFogStageType()

	if var_55_0 == var_0_2.ACTIVITY_STATE.OPEN then
		return self._endTime
	elseif var_55_0 == var_0_2.ACTIVITY_STATE.END then
		return self._expireTime
	end

	return 0
end

function FogNightmareData:updateFormationData(arg_56_1)
	self._formationData:updateData(arg_56_1)
end

function FogNightmareData:getFormationData()
	return self._formationData
end

function FogNightmareData:updateTalentData(arg_58_1)
	self._talentData:updateData(arg_58_1)
end

function FogNightmareData:resetTalentData(arg_59_1)
	self._talentData:resetData(arg_59_1)
end

function FogNightmareData:getTalentData()
	return self._talentData
end

function FogNightmareData:updateKeepsakeData(arg_61_1)
	self._keepsakeData:updateData(arg_61_1)
end

function FogNightmareData:getKeepsakeData()
	return self._keepsakeData
end

function FogNightmareData:updateTowerData(arg_63_1)
	self._towerData:updateData(arg_63_1)
end

function FogNightmareData:getTowerData()
	return self._towerData
end

function FogNightmareData:getCurActivityState()
	return
end

function FogNightmareData:updateIdleData(arg_66_1)
	self._idleData:updateData(arg_66_1)
end

function FogNightmareData:updateIdleGuildData(arg_67_1)
	self._idleData:updateIdleGuildData(arg_67_1)
end

function FogNightmareData:getIdleData()
	return self._idleData
end

function FogNightmareData:getAssistantData()
	return self._assistaneData
end

function FogNightmareData:getSealListByLevel(arg_70_1)
	return self._sealUnlockLevelList[arg_70_1] or {}
end

function FogNightmareData:isNewSeason()
	return self._isNewSeasonId
end

function FogNightmareData:getFormationKnightList()
	local var_72_0 = {}

	for iter_72_0, iter_72_1 in pairs((self._formationData:getAllLineUpFormations())) do
		for iter_72_2, iter_72_3 in pairs((iter_72_1:getKnightPosList())) do
			table.insert(var_72_0, iter_72_3)
		end
	end

	return var_72_0
end

function FogNightmareData:setIsEnterFormation(arg_73_1)
	if not self:getFormationData():getStageSkipChallenge() then
		self._isEnterFormation = arg_73_1 == true
	end
end

function FogNightmareData:getIsEnterFormation()
	self._isEnterFormation = false

	return self._isEnterFormation
end

function FogNightmareData:getFightValueShowCount(arg_75_1)
	if table.nums(self._formationChangeFloor) == 0 then
		for iter_75_0, iter_75_1 in g.core.config.fog_stage_info:ipairs() do
			local var_75_0

			if 0 < iter_75_1.wave then
				self._formationChangeFloor[iter_75_1.wave] = math.floor(iter_75_1.stage_id / 100)
				var_75_0 = 0 + 1
			end
		end
	end

	for iter_75_2, iter_75_3 in pairs(self._formationChangeFloor) do
		if arg_75_1 < iter_75_3 then
			return iter_75_2 - 1
		end
	end

	return table.nums(self._formationChangeFloor)
end

function FogNightmareData:hasChallengeCount(arg_76_1)
	local var_76_0, var_76_1 = self:isOpen()

	if not var_76_1 then
		return false
	end

	if self._formationData:hasPoolMember() then
		return false
	end

	if g.core.model.User.shopData:getLeftCount(g.core.const.ConstMgr.ShopConst.PLAY_TYPE.FOG_NIGHTMARE_EXPLORE) <= 0 then
		return false
	end

	return true
end

function FogNightmareData:hasIdleAward(arg_77_1)
	local var_77_0, var_77_1 = self:isOpen()

	if not var_77_1 then
		return false
	end

	return self._idleData:getCurIdleTime() >= 43200 and next((self._idleData:getNowReward()))
end

function FogNightmareData:hasTalentPoint(arg_78_1)
	local var_78_0, var_78_1 = self:isOpen()

	if not var_78_1 then
		return false
	end

	local var_78_2 = g.core.model.User.bagData

	if g.core.model.User.bagData:getCountById(g.core.common.Goods.TYPE_RESOURCE, g.core.common.Goods.RESOURCE.TYPE_FOG_NIGHTMARE_TALENT_POINT) < var_0_2.SHOW_RED_TALENT_COUNT then
		return false
	end

	for iter_78_0, iter_78_1 in ipairs((self._talentData:getCanUpgradeNodes())) do
		if iter_78_1:getCurLevelCfg().cost_type > 0 and var_78_2:getCountById(iter_78_1:getCurLevelCfg().cost_type, iter_78_1:getCurLevelCfg().cost_value) >= iter_78_1:getCurLevelCfg().cost_num then
			return true
		end
	end
end

function FogNightmareData:hasStageAward(arg_79_1)
	local var_79_0, var_79_1 = self:isOpen()

	if not var_79_1 then
		return false
	end

	if self._hasPhaseAwardByRedPoint then
		return true
	end

	return self._towerData:isHasPhaseRewardCanGet()
end

function FogNightmareData:hasNewFloor(arg_80_1)
	local var_80_0, var_80_1 = self:isOpen()

	if not var_80_1 then
		return false
	end

	if self._hasNewFloor then
		return true
	else
		self:setHasNewFloor((self._towerData:hasNewFloor(arg_80_1)))
	end

	return self._hasNewFloor
end

function FogNightmareData:resetServerRedPoint()
	self._canAddKnightByRedPoint = false
	self._hasPhaseAwardByRedPoint = false
end

function FogNightmareData:hasPlaceFormation(arg_82_1)
	local var_82_0, var_82_1 = self:isOpen()

	if not var_82_1 then
		return false
	end

	if self._canAddKnightByRedPoint then
		return true
	end

	local var_82_2, var_82_3

	if not self._formationData:hasPoolMember() then
		do return false end

		var_82_2 = g.core.model.User:getId()
		var_82_3 = 0
	end

	for iter_82_0, iter_82_1 in pairs(self._formationData:getPoolMember().knights) do
		if iter_82_1:getOwner().id == var_82_2 then
			var_82_3 = var_82_3 + 1
		end
	end

	local var_82_4

	if var_82_3 >= self:getMaxKnightNum() - var_0_2.MAX_HELPER_LINE_UP_COUNT then
		do return false end

		var_82_4 = 0
	end

	for iter_82_2, iter_82_3 in ipairs((g.core.model.User.knightsData:getOwnerAllList())) do
		local var_82_5 = iter_82_3:getInfo()

		if var_82_5.source_type and var_82_5.source_type == 0 then
			var_82_4 = var_82_4 + 1
		end
	end

	if var_82_4 <= var_82_3 then
		return false
	end

	return true
end

function FogNightmareData:getCurKeepsakePowerDelta(arg_83_1, arg_83_2)
	local var_83_0 = self:getFormationData():getKnightByServerId(arg_83_1):getDevelopStruct("keepsake")
	local var_83_1 = self:getKeepsakeData():getKeepsakeStructById(arg_83_2)
	local var_83_2 = var_83_1:getCfg().power
	local var_83_3 = var_83_1:getBaseInfo().suit_id
	local var_83_4 = self:getKeepsakeData():getSuitInfo(var_83_3)

	if var_83_4 then
		local var_83_5 = 1

		if var_83_0 then
			if self:getKeepsakeData():getKeepsakeStructById(var_83_0.id):getBaseInfo().suit_id == var_83_3 then
				var_83_5 = 0
			end
		end

		local var_83_6 = var_83_4:getActiveInfo(var_83_4:getActiveKeepsakeNum() + var_83_5)

		if var_83_6 then
			var_83_2 = var_83_2 + var_83_6.totalPower
		end
	end

	local var_83_7 = 0

	if var_83_0 then
		local var_83_8 = self:getKeepsakeData():getKeepsakeStructById(var_83_0.id)
		local var_83_9 = self:getKeepsakeData():getSuitInfo(var_83_8:getBaseInfo().suit_id)

		var_83_7 = var_83_8:getCfg().power

		if var_83_9 then
			var_83_7 = var_83_7 + var_83_9:getPower()
		end

		local var_83_10 = self:getKeepsakeData():getKeepsakeStructById(arg_83_2)
	end

	return var_83_2 - var_83_7
end

function FogNightmareData:getSealResetTimes()
	return self._sealResetTimes
end

function FogNightmareData:setSealResetTimes(arg_85_1)
	self._sealResetTimes = arg_85_1
end

function FogNightmareData:getNotPopParam(arg_86_1)
	return self._notPopViewList[arg_86_1]
end

function FogNightmareData:setNotPopParam(arg_87_1, arg_87_2)
	self._notPopViewList[arg_87_1] = arg_87_2 == true
end

function FogNightmareData:saveNotPopParamJson()
	if table.nums(self._oldNotPopViewList) ~= table.nums(self._notPopViewList) then
		self._oldNotPopViewList = clone(self._notPopViewList)

		g.core.common.Storage:save(var_0_2.NOT_POP_JSON_NAME, self._notPopViewList, true)
	else
		for iter_88_0, iter_88_1 in pairs(self._notPopViewList) do
			if iter_88_1 ~= self._oldNotPopViewList[iter_88_0] then
				self._oldNotPopViewList = clone(self._notPopViewList)

				g.core.common.Storage:save(var_0_2.NOT_POP_JSON_NAME, self._notPopViewList, true)

				return
			end
		end
	end
end

function FogNightmareData:setTempSelectSakeId(arg_89_1)
	self._selSakeId = arg_89_1
end

function FogNightmareData:getTempSelectSakeId()
	return self._selSakeId or 0
end

function FogNightmareData:saveKnightPoolInfo()
	local var_91_0 = {}
	local var_91_1 = {}
	local var_91_2 = 2

	for iter_91_0, iter_91_1 in ipairs(self:getFormationData():getPoolMember().knights) do
		if iter_91_1:getOwner().id == g.core.model.User:getId() then
			local var_91_3 = iter_91_1:getAdvanceId()

			if not var_91_0["k" .. var_91_3] then
				local var_91_4 = iter_91_1:getDevelopStruct(var_0_2.KNIGHT_DEVELOP_KEY.KEEPSAKE)
				local var_91_5 = var_91_4 and var_91_4:getBaseInfo().seal_id or 0

				var_91_2 = var_91_2 + 1

				table.insert(var_91_1, {
					knightAdvId = var_91_3,
					keepsakeSealId = var_91_5,
					pos = var_91_2
				})

				var_91_0["k" .. var_91_3] = true
			end
		end
	end

	g.core.common.Storage:save("fog_pool_info.json", {
		pool = var_91_1,
		seasonId = self._seasonId
	}, true)
end

function FogNightmareData:getSavedKnightPoolInfo()
	local var_92_0 = g.core.common.Storage:load("fog_pool_info.json", true)

	if var_92_0 and var_92_0.seasonId and var_92_0.seasonId == self._seasonId then
		return var_92_0.pool or {}
	else
		return {}
	end
end

function FogNightmareData:setHasNewFloor(arg_93_1)
	self._hasNewFloor = arg_93_1 == true

	if self._hasNewFloor ~= self._hasNewFloor then
		self:setNotPopParam("hasNewFloorParam", self._hasNewFloor)
		self:saveNotPopParamJson()
	end
end

function FogNightmareData:getTimeData()
	return self._startTime, self._endTime, self._expireTime
end

function FogNightmareData:getKeepsakeNewData()
	if not self._keepsakeNewList then
		local var_95_0 = g.core.common.Storage:load("fogNightmare_keepsake_new.json", true) or {}

		self._keepsakeNewList = {}

		if var_95_0.seasonId == self._seasonId then
			self._keepsakeNewList = var_95_0.list
		end

		self._unlockSealData = {}
		self._unlockSealTabData = {}

		for iter_95_0, iter_95_1 in ipairs(self._keepsakeNewList) do
			self._unlockSealData[iter_95_1.seal_id] = 1
			self._unlockSealTabData[iter_95_1.type] = self._unlockSealTabData[iter_95_1.type] and self._unlockSealTabData[iter_95_1.type] + 1 or 1
		end
	end

	return self._keepsakeNewList
end

function FogNightmareData:setKeepsakeNewData(arg_96_1)
	self._keepsakeNewList = arg_96_1
	self._unlockSealData = {}
	self._unlockSealTabData = {}

	for iter_96_0, iter_96_1 in ipairs(self._keepsakeNewList) do
		self._unlockSealData[iter_96_1.seal_id] = 1
		self._unlockSealTabData[iter_96_1.type] = self._unlockSealTabData[iter_96_1.type] and self._unlockSealTabData[iter_96_1.type] + 1 or 1
	end
end

function FogNightmareData:getKeepsakeNewIconData()
	return self._unlockSealData
end

function FogNightmareData:getKeepsakeNewTabData()
	return self._unlockSealTabData
end

function FogNightmareData:isKeepsakeNew(arg_99_1)
	self:getKeepsakeNewData()

	if arg_99_1.seal_id then
		if self._unlockSealData[arg_99_1.seal_id] == 1 then
			return true
		end
	elseif arg_99_1.type then
		if self._unlockSealTabData[arg_99_1.type] then
			return true
		end
	elseif arg_99_1.suitId then
		for iter_99_0, iter_99_1 in ipairs((self._keepsakeData:getKeepsakeStructsBySuitId(arg_99_1.suitId))) do
			if self._unlockSealData[iter_99_1:getBaseInfo().seal_id] == 1 then
				return true
			end
		end
	elseif #self._keepsakeNewList > 0 then
		return true
	end

	return false
end

function FogNightmareData:getSeasonId()
	return self._seasonId
end

function FogNightmareData:getActivitySubId()
	return self._activitySubId
end

function FogNightmareData:getWeeklyBuff()
	return self._weeklyBuff
end

function FogNightmareData:isAutoPopWeekBuff()
	return not ((g.core.common.Storage:load(var_0_2.WEEK_BUFF_POP_JSON_NAME, true) or {}).weeklyPop or {})[self._seasonId .. "_" .. g.core.common.ServerTime:getMondayTime()]
end

function FogNightmareData:setAutoPopWeekBuffEnd()
	local var_104_0 = g.core.common.Storage:load(var_0_2.WEEK_BUFF_POP_JSON_NAME, true) or {}
	local var_104_1 = var_104_0.weeklyPop

	if not var_104_0.weeklyPop then
		var_104_1 = {}
		var_104_0.weeklyPop = var_104_1
	end

	var_104_1[self._seasonId .. "_" .. g.core.common.ServerTime:getMondayTime()] = 1

	g.core.common.Storage:save(var_0_2.WEEK_BUFF_POP_JSON_NAME, var_104_0, true)
end

function FogNightmareData:_updateWeeklyBuffHistory()
	local var_105_0 = g.core.common.ServerTime:getMondayTime()

	self._weeklyBuffHistory = {
		{
			buff = self._weeklyBuff,
			id = self._weeklyBuff.id,
			mondayTime = var_105_0,
			sundayTime = math.min(var_105_0 + 604800 - 1, self._endTime)
		}
	}

	local var_105_1 = g.core.common.ServerTime:getMondayTime(var_105_0 - 1000)

	while var_105_1 > self._startTime do
		table.insert(self._weeklyBuffHistory, 1, {
			buff = self._weeklyBuffCfgMap[self._weeklyBuff.id].pre.cfg,
			id = self._weeklyBuffCfgMap[self._weeklyBuff.id].pre.cfg.id,
			mondayTime = var_105_1,
			sundayTime = var_105_1 + 604800 - 1
		})

		var_105_1 = g.core.common.ServerTime:getMondayTime(var_105_1 - 1000)
	end
end

function FogNightmareData:getWeeklyBuffHistory()
	return self._weeklyBuffHistoryIds
end

function FogNightmareData:getIdleUpTime()
	local var_107_0 = {}

	for iter_107_0, iter_107_1 in ipairs(self._weeklyBuffHistory) do
		local var_107_1 = self._idleData:getIdleProductsUpValue(iter_107_1.buff)

		if var_107_1 > 0 then
			var_107_0[#var_107_0 + 1] = {
				historyInfo = iter_107_1,
				upValue = var_107_1
			}
		end
	end

	return var_107_0
end

function FogNightmareData:getAwardsPopIsShowOver()
	return self._awardsPopIsShowOver
end

function FogNightmareData:onForbidAwardPop()
	self._forbidCnt = self._forbidCnt + 1

	self:setAwardsPopIsShowOver(false)
end

function FogNightmareData:onEnableAwardPop()
	self._forbidCnt = self._forbidCnt - 1

	if self._forbidCnt <= 0 then
		self:setAwardsPopIsShowOver(true)

		self._forbidCnt = 0
	end
end

function FogNightmareData:setAwardsPopIsShowOver(arg_111_1)
	self._awardsPopIsShowOver = arg_111_1
end

function FogNightmareData:getAutoPlay()
	return self._autoPlayData
end

function FogNightmareData:getBattleServerList()
	return self._serverList
end

function FogNightmareData:getRankSid()
	return self._serverSid
end

function FogNightmareData:setHelperKnightsConnectTime(arg_115_1)
	self._helperKnightsConnectTime = arg_115_1
end

function FogNightmareData:getHelperKnightsConnectTime()
	return self._helperKnightsConnectTime
end

function FogNightmareData:isMonsterStage(arg_117_1, arg_117_2)
	return ({
		[var_0_2.WAVE_EFFECT_TYPE.MONSTER_NORMAL] = true,
		[var_0_2.WAVE_EFFECT_TYPE.MONSTER_HARD] = true,
		[var_0_2.WAVE_EFFECT_TYPE.MONSTER_BOSS] = true
	})[self._towerData:getFloorStruct(arg_117_1):getStage(arg_117_2):getAllWave()[1]:getCfg().type]
end

function FogNightmareData:isNeedSyncPoolMemberFight(arg_118_1, arg_118_2)
	return self:isMonsterStage(arg_118_1, arg_118_2) and self:getFormationData():isNeedSyncPoolMemberFight(arg_118_2)
end

function FogNightmareData:checkSkipBattle(arg_119_1, arg_119_2)
	if not self:isMonsterStage(arg_119_1, arg_119_2:getStageId()) then
		return false
	end

	local var_119_0 = 0
	local var_119_1 = {}

	for iter_119_0, iter_119_1 in ipairs(self:getFormationData():getPoolMember().knights) do
		var_119_1[iter_119_0] = iter_119_1
	end

	table.sort(var_119_1, function(arg_120_0, arg_120_1)
		return arg_120_0:getKnightFight() > arg_120_1:getKnightFight()
	end)

	for iter_119_2 = 1, 6 do
		var_119_0 = var_119_0 + var_119_1[iter_119_2]:getKnightFight()
	end

	local var_119_2 = 0

	for iter_119_3, iter_119_4 in ipairs((arg_119_2:getAllWave())) do
		for iter_119_5, iter_119_6 in ipairs((iter_119_4:getCurEffects())) do
			var_119_2 = var_119_2 + iter_119_6:getPower()
		end
	end

	return g.core.model.User:checkUserSkipBattle(var_119_0, var_119_2, 3, arg_119_1)
end

return FogNightmareData
