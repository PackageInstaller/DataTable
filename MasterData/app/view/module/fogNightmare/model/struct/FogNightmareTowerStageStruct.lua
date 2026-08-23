local FogNightmareStageWaveStruct = require("app.view.module.fogNightmare.model.struct.FogNightmareStageWaveStruct")
local BPMOutOfOrder = require("app.view.module.fogNightmare.model.struct.bpm.BPMOutOfOrder")
local var_0_2 = g.core.const.ConstMgr.FogNightmareConst
local FogNightmareTowerStageStruct = class("FogNightmareTowerStageStruct")

function FogNightmareTowerStageStruct:ctor(arg_1_1, arg_1_2, arg_1_3)
	self._id = arg_1_1
	self._replaceId = 0
	self._state = var_0_2.STAGE_STATE.NONE
	self._waveSequenceNormal = BPMOutOfOrder.new()
	self._waveSequenceSpecial = BPMOutOfOrder.new()
	self._storyId = arg_1_2
	self._frontTextsId = arg_1_3 .. "_front_texts"
	self._storyKey = arg_1_3
	self._tempSelectWave = -1
	self._selectWave = -1
	self._storyRead = false

	self:_initStructByTabConfig()
end

function FogNightmareTowerStageStruct:reset()
	self._replaceId = 0
	self._state = var_0_2.STAGE_STATE.NONE

	self._waveSequenceNormal:reset()
	self._waveSequenceSpecial:removeAllAction()

	self._tempSelectWave = -1
end

function FogNightmareTowerStageStruct:revertToStartState()
	self._state = var_0_2.STAGE_STATE.NONE

	self._waveSequenceNormal:reset()
	self._waveSequenceSpecial:reset()
end

function FogNightmareTowerStageStruct:clearInfo()
	self._state = var_0_2.STAGE_STATE.NONE

	self._waveSequenceNormal:reset()
	self._waveSequenceSpecial:removeAllAction()
end

function FogNightmareTowerStageStruct:_initStructByTabConfig()
	self:_initSubWave(self._waveSequenceNormal, self._id)
end

function FogNightmareTowerStageStruct:_initSubWave(arg_6_1, arg_6_2)
	self._frontTexts = {}

	for iter_6_0, iter_6_1 in ipairs((g.core.config.fog_stage_info.match(function(arg_7_0)
		return arg_7_0.stage_id == arg_6_2
	end))) do
		arg_6_1:addAction(FogNightmareStageWaveStruct.new(iter_6_1.id), iter_6_0)

		if iter_6_0 == 1 then
			local var_6_0 = 1

			while g.core.config.fog_stage_info.hasKey("text_" .. 1) do
				if iter_6_1["text_" .. 1] and #iter_6_1["text_" .. 1] > 1 then
					table.insert(self._frontTexts, iter_6_1["text_" .. 1])
				end

				var_6_0 = var_6_0 + 1
			end
		end
	end
end

function FogNightmareTowerStageStruct:getStageId()
	return (self._replaceId > 0 or nil) and self._replaceId
end

function FogNightmareTowerStageStruct:_getCurBPM()
	return (self._waveSequenceSpecial:isEmpty() or nil) and self._waveSequenceNormal
end

function FogNightmareTowerStageStruct:setStageState(arg_10_1)
	self._state = arg_10_1
end

function FogNightmareTowerStageStruct:getState()
	return self._state
end

function FogNightmareTowerStageStruct:getAllWave()
	return self:_getCurBPM():getAllActions()
end

function FogNightmareTowerStageStruct:getCurWaves()
	return self:_getCurBPM():getCurActions()
end

function FogNightmareTowerStageStruct:getPower()
	local var_14_0 = self:getAllWave()[1]

	return (var_0_2.WAVE_EFFECT_TYPE.MONSTER_BOSS >= var_14_0:getType() or nil) and var_14_0:getCfg().power
end

function FogNightmareTowerStageStruct:setTempSelectWave(arg_15_1)
	self._tempSelectWave = arg_15_1
end

function FogNightmareTowerStageStruct:getTempSelectWave()
	return self._tempSelectWave
end

function FogNightmareTowerStageStruct:setSelectWave(arg_17_1)
	self._selectWave = arg_17_1
end

function FogNightmareTowerStageStruct:getSelectWave()
	return self._selectWave
end

function FogNightmareTowerStageStruct:executeWave(arg_19_1, arg_19_2)
	self:_getCurBPM():doAction(arg_19_1)
end

function FogNightmareTowerStageStruct:resetWave(arg_20_1, arg_20_2)
	self:_getCurBPM():getAllActions()[arg_20_2]:reset()
end

function FogNightmareTowerStageStruct:resetAllWave(arg_21_1, arg_21_2)
	for iter_21_0, iter_21_1 in pairs((self:_getCurBPM():getAllActions())) do
		iter_21_1:reset()
	end
end

function FogNightmareTowerStageStruct:forceExecuteWave(arg_22_1)
	self:_getCurBPM():getAllActions()[arg_22_1]:_onFinish()
end

function FogNightmareTowerStageStruct:isFinishAllWave()
	self:checkIsPass()

	return self._state == var_0_2.STAGE_STATE.PASS
end

function FogNightmareTowerStageStruct:updateWaveByNetInfo(arg_24_1)
	for iter_24_0, iter_24_1 in pairs((self:getAllWave())) do
		iter_24_1:updateWaveByNetInfo(arg_24_1)
	end
end

function FogNightmareTowerStageStruct:checkIsPass()
	self._state = self:_getCurBPM():isDone() and var_0_2.STAGE_STATE.PASS or var_0_2.STAGE_STATE.WAIT_PASS
end

function FogNightmareTowerStageStruct:getStoryId()
	return self._storyId
end

function FogNightmareTowerStageStruct:getStoryKey()
	return self._storyKey
end

function FogNightmareTowerStageStruct:setStoryIsRead(arg_28_1)
	self._storyRead = arg_28_1
end

function FogNightmareTowerStageStruct:isStoryIsRead()
	return g.core.model.User.fogNightmareData:getTowerData():isStoryFinish(self._storyKey)
end

function FogNightmareTowerStageStruct:getFrontTexts()
	return clone(self._frontTexts)
end

function FogNightmareTowerStageStruct:readAllFrontTexts()
	g.core.model.User.fogNightmareData:getTowerData():onFrontTextFinish(self._frontTextsId)
end

function FogNightmareTowerStageStruct:isReadAllFrontTexts()
	return g.core.model.User.fogNightmareData:getTowerData():isFrontTextFinish(self._frontTextsId)
end

function FogNightmareTowerStageStruct:checkCanSelectRandomKeepsake()
	local var_33_0 = false

	for iter_33_0, iter_33_1 in pairs((self:_getCurBPM():getAllActions())) do
		if iter_33_1:canKeepsake() then
			var_33_0 = true

			break
		end
	end

	return var_33_0
end

function FogNightmareTowerStageStruct:updateStageReplaceInfo(arg_34_1)
	self._replaceId = 0

	self._waveSequenceSpecial:removeAllAction()

	if arg_34_1.replace_stage then
		self._replaceId = arg_34_1.replace_stage

		self:_initSubWave(self._waveSequenceSpecial, self._replaceId)

		if self._storyKey then
			local var_34_0 = {
				floor = tonumber(string.split(self._storyKey, "_")[1]),
				stage = self._replaceId
			}

			self._storyKey = var_34_0.floor .. "_" .. var_34_0.stage
		end
	end
end

return FogNightmareTowerStageStruct
