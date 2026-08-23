local BPMSequence = require("app.view.module.fogNightmare.model.struct.bpm.BPMSequence")
local BPMAction = require("app.view.module.fogNightmare.model.struct.bpm.BPMAction")
local var_0_2 = g.core.const.ConstMgr.FogNightmareConst
local FogNightmareStageWaveStruct = class("FogNightmareStageWaveStruct", BPMAction)

function FogNightmareStageWaveStruct:ctor(arg_1_1)
	FogNightmareStageWaveStruct.super.ctor(self)

	self._id = arg_1_1
	self._waveId = -1
	self._effectSequence = BPMSequence.new()
	self._canRecall = false
	self._hasKeepsake = false
	self._showRes = nil
	self._btnStr = nil
	self._sceneRes = nil

	self:_initStructByTabConfig()
end

function FogNightmareStageWaveStruct:getWaveId()
	return self._waveId
end

function FogNightmareStageWaveStruct:reset()
	BPMAction.reset(self)
	self._effectSequence:reset()
end

function FogNightmareStageWaveStruct:_initWaveEffectStruct()
	local var_4_0

	if self._cfg.type == var_0_2.WAVE_EFFECT_TYPE.MONSTER_NORMAL then
		var_4_0 = require("app.view.module.fogNightmare.model.struct.waveEffect.FogNightmareWaveEffectMonsterStruct").new(self._cfg)
	elseif self._cfg.type == var_0_2.WAVE_EFFECT_TYPE.MONSTER_HARD then
		var_4_0 = require("app.view.module.fogNightmare.model.struct.waveEffect.FogNightmareWaveEffectMonsterStruct").new(self._cfg)
	elseif self._cfg.type == var_0_2.WAVE_EFFECT_TYPE.MONSTER_BOSS then
		var_4_0 = require("app.view.module.fogNightmare.model.struct.waveEffect.FogNightmareWaveEffectMonsterStruct").new(self._cfg)
	elseif self._cfg.type == var_0_2.WAVE_EFFECT_TYPE.EFFECT_RECOVER then
		var_4_0 = require("app.view.module.fogNightmare.model.struct.waveEffect.FogNightmareWaveEffectRecoverStruct").new(self._cfg)
	elseif self._cfg.type == var_0_2.WAVE_EFFECT_TYPE.EFFECT_REVIVAL then
		var_4_0 = require("app.view.module.fogNightmare.model.struct.waveEffect.FogNightmareWaveEffectRevivalStruct").new(self._cfg)
	elseif self._cfg.type == var_0_2.WAVE_EFFECT_TYPE.EFFECT_CHOICE then
		var_4_0 = require("app.view.module.fogNightmare.model.struct.waveEffect.FogNightmareWaveEffectChoice").new(self._cfg)
	elseif self._cfg.type == var_0_2.WAVE_EFFECT_TYPE.EFFECT_SACRIFICE then
		var_4_0 = require("app.view.module.fogNightmare.model.struct.waveEffect.FogNightmareWaveEffectSacrifice").new(self._cfg)
	end

	self._effectSequence:addAction(var_4_0)
end

function FogNightmareStageWaveStruct:getCfg()
	return self._cfg
end

function FogNightmareStageWaveStruct:_initStructByTabConfig()
	self._cfg = g.core.config.fog_stage_info.get(self._id)
	self._showRes = self._cfg.res
	self._waveId = self._cfg.wave

	local var_6_0 = g.core.config.fog_stage_type_info.get(self._cfg.type)

	self._name = var_6_0.stage_name
	self._canRecall = var_6_0.can_recall == 1
	self._hasKeepsake = var_6_0.if_seal == 1
	self._btnStr = var_6_0.btn_str
	self._sceneRes = var_6_0.scene
	self._stageTypeCfg = var_6_0
end

function FogNightmareStageWaveStruct:_checkAndGetEffects()
	local var_7_0 = self._effectSequence:getAllActions()

	if #var_7_0 < 1 then
		self:_initWaveEffectStruct()

		var_7_0 = self._effectSequence:getAllActions()
	end

	return var_7_0
end

function FogNightmareStageWaveStruct:getCurEffects()
	return self:_checkAndGetEffects()
end

function FogNightmareStageWaveStruct:updateWaveByNetInfo(arg_9_1)
	for iter_9_0, iter_9_1 in pairs((self:_checkAndGetEffects())) do
		iter_9_1:updateEffectByNetInfo(arg_9_1)
	end
end

function FogNightmareStageWaveStruct:getWaveName()
	return self._name
end

function FogNightmareStageWaveStruct:getStageTypeCfg()
	return self._stageTypeCfg
end

function FogNightmareStageWaveStruct:canKeepsake()
	return self._hasKeepsake
end

function FogNightmareStageWaveStruct:canRecall()
	return self._canRecall
end

function FogNightmareStageWaveStruct:getType()
	return self._cfg.type
end

function FogNightmareStageWaveStruct:getShowRes()
	return self._showRes
end

function FogNightmareStageWaveStruct:doing(arg_16_1)
	if arg_16_1.wave ~= self._waveId then
		return
	end

	FogNightmareStageWaveStruct.super.doing(self, arg_16_1)
	self._effectSequence:doAction(arg_16_1)

	if self._effectSequence:isDone() then
		self:_onFinish()
	end
end

return FogNightmareStageWaveStruct
