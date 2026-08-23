local var_0_0 = "fogNightmareTower.json"
local var_0_1 = g.core.const.ConstMgr.FogNightmareConst
local FogNightmareTowerFloorStruct = require("app.view.module.fogNightmare.model.struct.FogNightmareTowerFloorStruct")
local FogNightmareTowerData = class("FogNightmareTowerData")

function FogNightmareTowerData:ctor()
	self._foreverMaxFloor = 0
	self._historyMaxFloor = 0
	self._maxFloor = 0
	self._floorCount = 0
	self._floorMap = {}
	self._buffs = {}
	self._floorStructs = {}
	self._floorPhaseData = {}
	self._storyJson = {}
	self._curFloor = 0
	self._curStageId = 0
	self._challengeCostHp = 0
	self._isPassWave = false
	self._isPassCurFloor = false
	self._needShowKeep = false
	self._structInited = false
	self._passExtraNum = 0
	self._extraKeepsakes = nil
end

function FogNightmareTowerData:initData()
	self._jsonConfig = nil
	self._buffs = {}
	self._curFloor = 0
	self._maxFloor = 0
	self._curStageId = 0
	self._passExtraNum = 0

	self:initFloorStructs()

	self._structInited = true
	self._extraKeepsakes = nil
	self._historyMaxFloor = 0
	self._foreverMaxFloor = 0
end

function FogNightmareTowerData:resetData()
	for iter_3_0 = 1, self._curFloor do
		if self._floorStructs[iter_3_0] then
			local var_3_0 = self._floorStructs[iter_3_0]:clearInfo()
		end
	end

	self._buffs = {}
	self._curFloor = 0
	self._curStageId = 0
	self._passExtraNum = 0
	self._extraKeepsakes = nil
end

function FogNightmareTowerData:saveResultData()
	local var_4_0 = self:getFloorStruct(self._curFloor):getSelectedStage()[1]
	local var_4_1 = {
		historyMaxFloor = self._historyMaxFloor
	}

	if var_4_0 and var_4_0:isFinishAllWave() or false then
		var_4_1.curFloor = self._curFloor or self._curFloor - 1
	end

	self._resultData = var_4_1
end

function FogNightmareTowerData:getResultData()
	return self._resultData
end

function FogNightmareTowerData:initFloorStructs()
	self._floorStructs = {}
	self._floorPhaseData = {}
	self._tempFloorPhaseData = {}
	self._floorCount = g.core.config.fog_floor_info.getLength()
end

function FogNightmareTowerData:updateData(arg_7_1, arg_7_2)
	self:updateBuffDatas(arg_7_1)

	self._curFloor = arg_7_1.floor or 0
	self._maxFloor = arg_7_1.max_floor or 0
	self._historyMaxFloor = arg_7_1.history_max_floor or 0
	self._foreverMaxFloor = arg_7_1.forever_max_floor or 0

	self:replaceFloorStage(arg_7_1)

	if not arg_7_1.rand_seals then
		self:updateExtraKeepsake(arg_7_1)
	end

	self._isPassCurFloor = arg_7_1.pass_stage
	self._isPassWave = false
	self._needShowKeep = false
	self._passExtraNum = arg_7_1.extra_seal_times

	if self._curFloor > 0 then
		local var_7_0 = self:getCurFloorStruct()

		var_7_0:checkAndFixFloorState()

		if arg_7_1.stage and arg_7_1.stage > 0 then
			var_7_0:selectStage(arg_7_1.stage)

			local var_7_1 = var_7_0:getSelectedStage()[1]

			var_7_1:updateWaveByNetInfo(arg_7_1)

			if arg_7_2 then
				self:resetAllWave(self._curFloor, arg_7_1.stage)
			end

			if arg_7_1.fog_waves then
				for iter_7_0, iter_7_1 in ipairs(arg_7_1.fog_waves) do
					self:executeWave(self._curFloor, arg_7_1.stage, iter_7_1)
				end
			elseif arg_7_1.pass_waves then
				for iter_7_2, iter_7_3 in ipairs(arg_7_1.pass_waves) do
					self:forceExecuteWave(self._curFloor, arg_7_1.stage, iter_7_3)
				end
			elseif arg_7_1.rand_choice_ids and arg_7_1.rand_seals then
				self:forceExecuteWave(self._curFloor, arg_7_1.stage, 1)

				self._needShowKeep = true
			elseif arg_7_1.fog_wave then
				self:resetWave(self._curFloor, arg_7_1.stage, arg_7_1.fog_wave)
			end

			local var_7_2 = var_7_1:getAllWave()[1]

			if not self._isPassCurFloor and (var_7_2:getCfg().type == var_0_1.WAVE_EFFECT_TYPE.EFFECT_CHOICE or var_7_2:getCfg().type == var_0_1.WAVE_EFFECT_TYPE.EFFECT_SACRIFICE) then
				if g.core.model.User.fogNightmareData:getTalentData():getRandSealData() then
					self._needShowKeep = true
				end
			end

			self._isPassWave = var_7_1:isFinishAllWave()
		end
	end
end

function FogNightmareTowerData:executeWave(arg_8_1, arg_8_2, arg_8_3, arg_8_4)
	local var_8_0 = self:getCurFloorStruct():getStage(arg_8_2)

	var_8_0:executeWave(arg_8_3, arg_8_3.wave)

	if arg_8_4 then
		self._isPassWave = var_8_0:isFinishAllWave()
	end
end

function FogNightmareTowerData:resetWave(arg_9_1, arg_9_2, arg_9_3, arg_9_4)
	local var_9_0 = self:getCurFloorStruct():getStage(arg_9_2)

	var_9_0:resetWave(arg_9_3, arg_9_3.wave)

	if arg_9_4 then
		self._isPassWave = var_9_0:isFinishAllWave()
	end
end

function FogNightmareTowerData:resetAllWave(arg_10_1, arg_10_2)
	local var_10_0 = self:getCurFloorStruct():getStage(arg_10_2)

	var_10_0:revertToStartState()

	self._isPassWave = var_10_0:isFinishAllWave()
end

function FogNightmareTowerData:resetOneWave(arg_11_1, arg_11_2, arg_11_3)
	self:getCurFloorStruct():getStage(arg_11_2):getAllWave()[arg_11_3]:reset()

	self._isPassWave = false
end

function FogNightmareTowerData:forceExecuteWave(arg_12_1, arg_12_2, arg_12_3, arg_12_4)
	local var_12_0 = self:getCurFloorStruct():getStage(arg_12_2)

	var_12_0:forceExecuteWave(arg_12_3)

	if arg_12_4 then
		self._isPassWave = var_12_0:isFinishAllWave()
	end
end

function FogNightmareTowerData:updateOneFloorData(arg_13_1)
	local var_13_0 = self:getFloorStruct(arg_13_1.floor)

	var_13_0:selectStage(arg_13_1.stage)
	var_13_0:getStage(arg_13_1.stage):updateWaveByNetInfo(arg_13_1)
end

function FogNightmareTowerData:replaceFloorStage(arg_14_1)
	if arg_14_1.replace_stage and arg_14_1.replace_stage ~= 0 then
		local var_14_0 = self:getFloorStruct(self._curFloor)

		if not var_14_0 then
			return
		end

		local var_14_1 = var_14_0:getStage(arg_14_1.origin_stage)

		if var_14_1 then
			var_14_1:updateStageReplaceInfo(arg_14_1)
		end
	end
end

function FogNightmareTowerData:updateFloorDataByChallengeFinishInfo(arg_15_1)
	self:executeWave(arg_15_1.floor, arg_15_1.stage, arg_15_1, arg_15_1.is_win)

	local var_15_0 = 0

	for iter_15_0, iter_15_1 in ipairs(arg_15_1.kn_hps_after) do
		var_15_0 = var_15_0 + arg_15_1.kn_hps_before[iter_15_0] - iter_15_1
	end

	self._challengeCostHp = var_15_0 / #arg_15_1.kn_hps_after
end

function FogNightmareTowerData:getCostHp()
	return self._challengeCostHp
end

function FogNightmareTowerData:enterNextFloor()
	self._maxFloor = math.max(self._curFloor, self._maxFloor)
	self._curFloor = self._curFloor + 1
	self._isPassWave = false
	self._isPassCurFloor = false

	self:getCurFloorStruct():checkAndFixFloorState()
	self:_updateBuffProValue()
end

function FogNightmareTowerData:setCurFloor(arg_18_1)
	self._curFloor = math.min(arg_18_1, self._floorCount)

	self:getCurFloorStruct():checkAndFixFloorState()
end

function FogNightmareTowerData:getCurrentFloorNum()
	return self._curFloor
end

function FogNightmareTowerData:getCurrentMaxFloorNum()
	return self._maxFloor
end

function FogNightmareTowerData:getHistoryMaxFloorNum()
	return self._historyMaxFloor
end

function FogNightmareTowerData:getForeverMaxFloorNum()
	return self._foreverMaxFloor
end

function FogNightmareTowerData:getCurFloorStruct()
	return self:getFloorStruct(self._curFloor)
end

function FogNightmareTowerData:getFloorStruct(arg_24_1)
	local var_24_0 = self._floorStructs[arg_24_1]

	if arg_24_1 > 0 then
		var_24_0 = var_24_0 or self:_createFloorStruct(nil, arg_24_1)
	end

	return var_24_0
end

function FogNightmareTowerData:_createFloorStruct(arg_25_1, arg_25_2)
	local var_25_0

	if arg_25_1 then
		var_25_0 = g.core.config.fog_floor_info.get(arg_25_1)
		arg_25_2 = arg_25_1
	else
		var_25_0 = g.core.config.fog_floor_info.indexOf(arg_25_2)
	end

	local var_25_1 = FogNightmareTowerFloorStruct.new(var_25_0.id)

	self._floorStructs[arg_25_2] = var_25_1

	local var_25_2 = var_25_1:getPhaseAwards()

	if var_25_2 and #var_25_2 > 0 then
		local var_25_3 = var_25_1:getPhaseAwardInfo()
		local var_25_4 = #self._floorPhaseData + 1

		for iter_25_0 = 1, #self._floorPhaseData do
			if self._floorPhaseData[iter_25_0].floor > var_25_3.floor then
				var_25_4 = iter_25_0

				break
			end
		end

		table.insert(self._floorPhaseData, var_25_4, var_25_3)
	end

	return var_25_1
end

function FogNightmareTowerData:getAllFloorStruct()
	return self._floorStructs
end

function FogNightmareTowerData:updatePhaseAward(arg_27_1)
	arg_27_1 = arg_27_1 or {}

	for iter_27_0, iter_27_1 in ipairs(arg_27_1) do
		self:_receivedOnePhaseAward(iter_27_1)
	end
end

function FogNightmareTowerData:_receivedOnePhaseAward(arg_28_1)
	local var_28_0 = self:getFloorStruct(arg_28_1)

	if var_28_0 then
		var_28_0:setReceivedPhaseAwards()
	end
end

function FogNightmareTowerData:getPhaseAward(arg_29_1)
	self:_receivedOnePhaseAward(arg_29_1 and arg_29_1.floor)
end

function FogNightmareTowerData:isUnlockFastLevel()
	return g.core.config.parameter_info.get(20053).parameter <= self._historyMaxFloor
end

function FogNightmareTowerData:updateBuffDatas(arg_31_1)
	for iter_31_0, iter_31_1 in ipairs(arg_31_1.buffs or {}) do
		if iter_31_1.tp == 1 then
			local var_31_1 = g.core.config.skill_info.get(g.core.config.passive_skill_info.get(iter_31_1.buff_id).passive_skill_value)
			local var_31_2 = {}

			while g.core.config.skill_info.hasKey("buff_" .. 1) do
				if var_31_1["buff_" .. 1] ~= 0 then
					table.insert(var_31_2, var_31_1["buff_" .. 1])
				end
			end

			if iter_31_1.source == 1 then
				var_31_2[#var_31_2 + 1] = iter_31_1.buff_id
			end

			self._buffs[iter_31_1.buff_id] = iter_31_1
			self._buffs[iter_31_1.buff_id].buffIds = var_31_2

			if iter_31_1.rest_floor == 0 then
				self._buffs[iter_31_1.buff_id] = nil
			end
		end
	end
end

function FogNightmareTowerData:_updateBuffProValue()
	for iter_32_0, iter_32_1 in pairs(self._buffs) do
		iter_32_1.rest_floor = iter_32_1.rest_floor - 1

		if iter_32_1.rest_floor == 0 then
			self._buffs[iter_32_0] = nil
		end
	end
end

function FogNightmareTowerData:getFastFloors()
	local var_33_0 = {}

	if self:isUnlockFastLevel() then
		for iter_33_0 = 0, 4 do
			local var_33_1 = (math.floor(self._historyMaxFloor / 5) - iter_33_0) * 5

			if var_33_1 < 1 then
				break
			end

			var_33_0[#var_33_0 + 1] = var_33_1
		end
	end

	return var_33_0
end

function FogNightmareTowerData:_initTempPhaseData()
	for iter_34_0 = 1, g.core.config.fog_floor_info.getLength() do
		local var_34_0 = g.core.config.fog_floor_info.indexOf(iter_34_0)

		if var_34_0.phase_bonus > 0 then
			local var_34_1 = {
				received = false,
				awards = g.core.common.Drops:getGoodsArray(var_34_0.phase_bonus),
				floor = var_34_0.id,
				index = iter_34_0
			}

			var_34_1.showInfo = var_34_0.show_type > 0 and {
				type = var_34_0.show_type,
				value = var_34_0.show_value
			}
			self._tempFloorPhaseData[#self._tempFloorPhaseData + 1] = var_34_1
		end
	end
end

function FogNightmareTowerData:_checkAndFixPhaseData()
	if #self._tempFloorPhaseData == 0 then
		self:_initTempPhaseData()
	end

	local var_35_0 = {}

	for iter_35_0 = 1, #self._tempFloorPhaseData do
		var_35_0[self._tempFloorPhaseData[iter_35_0].floor] = iter_35_0
	end

	for iter_35_1, iter_35_2 in ipairs(self._floorPhaseData) do
		self._tempFloorPhaseData[var_35_0[iter_35_2.floor]].received = iter_35_2.received
	end
end

function FogNightmareTowerData:getPhaseRewardData()
	self:_checkAndFixPhaseData()

	return self._tempFloorPhaseData
end

function FogNightmareTowerData:isHasPhaseRewardCanGet()
	local var_37_0 = math.max(self:getCurrentFloorNum() - 1, (math.max(self:getCurrentMaxFloorNum(), self:getHistoryMaxFloorNum())))

	for iter_37_0, iter_37_1 in ipairs((self:getPhaseRewardData())) do
		if not iter_37_1.received then
			local var_37_1 = self:getFloorStruct(iter_37_1.floor):getLockInfo()

			if not var_37_1.time and not var_37_1.level and iter_37_1.floor <= var_37_0 then
				return true
			end
		end
	end

	return false
end

function FogNightmareTowerData:isNeedPhaseRewardGuide()
	for iter_38_0, iter_38_1 in ipairs(self._floorPhaseData) do
		if iter_38_1.floor > 10 then
			return false
		end

		if iter_38_1.floor == 10 then
			if not iter_38_1.received then
				local var_38_0 = self:getFloorStruct(iter_38_1.floor):getLockInfo()

				if not var_38_0.time and not var_38_0.level and iter_38_1.floor <= math.max(self:getCurrentFloorNum() - 1, (math.max(self:getCurrentMaxFloorNum(), self:getHistoryMaxFloorNum()))) then
					return true
				end
			end

			return false
		end
	end

	return false
end

function FogNightmareTowerData:_checkAndInitJsonConfig()
	if not self._jsonConfig then
		self._jsonConfig = self:_loadJsonConfig(var_0_0, true)

		if not next(self._jsonConfig) then
			self._jsonConfig = {
				story = {
					["1"] = false
				},
				frontText = {
					["1"] = false
				}
			}
		end

		self._jsonConfig.frontText = self._jsonConfig.frontText or {
			["1"] = false
		}
	end
end

function FogNightmareTowerData:isStoryFinish(arg_40_1)
	self:_checkAndInitJsonConfig()

	return self._jsonConfig.story[arg_40_1]
end

function FogNightmareTowerData:theFloorStoryIsFinish(arg_41_1)
	self:onStoryFinish(arg_41_1)
	self:getFloorStruct(tonumber(arg_41_1)):setStoryIsOver()
end

function FogNightmareTowerData:theStoryIsFinish(arg_42_1)
	self:onStoryFinish(arg_42_1)

	local var_42_0 = self:_paraseStoryKeyAndGetFloorInfo(arg_42_1)

	self:getFloorStruct(var_42_0.floor):getStage(var_42_0.stage):setStoryIsRead(true)
end

function FogNightmareTowerData:onStoryFinish(arg_43_1)
	self._jsonConfig.story[arg_43_1] = true

	self:_saveJsonConfig(var_0_0, self._jsonConfig, true)
end

function FogNightmareTowerData:_paraseStoryKeyAndGetFloorInfo(arg_44_1)
	local var_44_0 = string.split(arg_44_1, "_")

	return {
		floor = tonumber(var_44_0[1]),
		stage = tonumber(var_44_0[2])
	}
end

function FogNightmareTowerData:isFrontTextFinish(arg_45_1)
	self:_checkAndInitJsonConfig()

	return self._jsonConfig.frontText[arg_45_1]
end

function FogNightmareTowerData:onFrontTextFinish(arg_46_1)
	self._jsonConfig.frontText[arg_46_1] = true

	self:_saveJsonConfig(var_0_0, self._jsonConfig, true)
end

function FogNightmareTowerData:clearFrontText()
	self:_checkAndInitJsonConfig()

	self._jsonConfig.frontText = {
		["1"] = false
	}

	self:_saveJsonConfig(var_0_0, self._jsonConfig, true)
end

function FogNightmareTowerData:_saveJsonConfig(arg_48_1)
	if not self._jsonConfig then
		return
	end

	g.core.common.Storage:save(arg_48_1, ...)
end

function FogNightmareTowerData:_loadJsonConfig(arg_49_1)
	return g.core.common.Storage:load(arg_49_1, ...) or {}
end

function FogNightmareTowerData:setPassWaved(arg_50_1)
	self._isPassWave = arg_50_1
end

function FogNightmareTowerData:setPassCurFloor(arg_51_1)
	self._isPassCurFloor = arg_51_1
end

function FogNightmareTowerData:checkCurFloorState(arg_52_1)
	if self._curFloor == 0 then
		return var_0_1.FLOOR_STATE.PASS
	end

	local var_52_0 = var_0_1.FLOOR_STATE.WAIT_SELECT
	local var_52_1 = self:getCurFloorStruct():getSelectedStage()

	if var_52_1 and next(var_52_1) then
		var_52_0 = var_0_1.FLOOR_STATE.SELECTED

		if self._isPassWave then
			var_52_0 = var_0_1.FLOOR_STATE.PASS

			if not self._isPassCurFloor and var_52_1[1]:checkCanSelectRandomKeepsake() or self._needShowKeep then
				var_52_0 = var_0_1.FLOOR_STATE.WAIT_SELECT_KEEPSAKE

				if not arg_52_1 then
					self._needShowKeep = false
				end
			end
		end
	end

	return var_52_0
end

function FogNightmareTowerData:getAllBuffs()
	return self._buffs
end

function FogNightmareTowerData:isMaxFloor(arg_54_1)
	arg_54_1 = arg_54_1 or self._curFloor

	return arg_54_1 > self._floorCount
end

function FogNightmareTowerData:getMaxFloor()
	return self._floorCount
end

function FogNightmareTowerData:isFirstPassWave(arg_56_1)
	return arg_56_1 > self._maxFloor and arg_56_1 > self._historyMaxFloor
end

function FogNightmareTowerData:hasNewFloor(arg_57_1)
	if self._curFloor == 0 then
		return false
	end

	local var_57_0 = self:getCurFloorStruct()

	if next(var_57_0:getLockInfo()) == nil then
		return false
	end

	var_57_0:checkAndFixFloorState()

	return next(var_57_0:getLockInfo()) == nil
end

function FogNightmareTowerData:getPassedExtraNum()
	return self._passExtraNum
end

function FogNightmareTowerData:getTotalExtraNum()
	return g.core.model.User.fogNightmareData:getFogExtraSealTimes()
end

function FogNightmareTowerData:isNeedReqExtra()
	return self._passExtraNum < g.core.model.User.fogNightmareData:getFogExtraSealTimes() and not g.core.model.User.fogNightmareData:getFogExtraSealState()
end

function FogNightmareTowerData:onOneExtraPassed()
	self._passExtraNum = self._passExtraNum + 1
	self._extraKeepsakes = nil

	g.core.model.User.fogNightmareData:getTalentData():setRandSealDataDirectly(self._extraKeepsakes)

	if self._passExtraNum >= g.core.model.User.fogNightmareData:getFogExtraSealTimes() then
		g.core.model.User.fogNightmareData:setFogExtraSealState(true)
	end
end

function FogNightmareTowerData:getExtraKeepsake()
	return self._extraKeepsakes
end

function FogNightmareTowerData:updateExtraKeepsake(arg_63_1)
	self._extraKeepsakes = arg_63_1.extra_seals

	g.core.model.User.fogNightmareData:getTalentData():setRandSealDataDirectly(self._extraKeepsakes)
end

return FogNightmareTowerData
