local BPMSub = require("app.view.module.fogNightmare.model.struct.bpm.BPMSub")
local FogNightmareWaveEffectChoiceNormalItem = require("app.view.module.fogNightmare.model.struct.waveEffect.FogNightmareWaveEffectChoiceNormalItem")
local FogNightmareWaveEffectChoice = class("FogNightmareWaveEffectChoice", (require("app.view.module.fogNightmare.model.struct.waveEffect.FogNightmareWaveEffectBaseStruct")))

function FogNightmareWaveEffectChoice:ctor(arg_1_1)
	self._subEffectBPM = BPMSub.new(1)

	FogNightmareWaveEffectChoice.super.ctor(self, arg_1_1)

	self._effectType = arg_1_1.type
end

function FogNightmareWaveEffectChoice:_init(arg_2_1)
	return
end

function FogNightmareWaveEffectChoice:reset()
	require("app.view.module.fogNightmare.model.struct.bpm.BPMAction").reset(self)
	self._subEffectBPM:removeAllAction()
end

function FogNightmareWaveEffectChoice:updateEffectByNetInfo(arg_4_1)
	self:_initSubEffects(arg_4_1.rand_choice_ids)
end

function FogNightmareWaveEffectChoice:_initSubEffects(arg_5_1)
	for iter_5_0, iter_5_1 in ipairs(arg_5_1) do
		self._subEffectBPM:addAction(FogNightmareWaveEffectChoiceNormalItem.new({
			id = iter_5_1
		}), iter_5_0)
	end
end

function FogNightmareWaveEffectChoice:getCompName()
	local var_6_0 = self._subEffectBPM:getAllActions()[1]

	return (var_6_0 or nil) and var_6_0:getCompName()
end

function FogNightmareWaveEffectChoice:getSubEffects()
	return self._subEffectBPM:getAllActions()
end

function FogNightmareWaveEffectChoice:doing(arg_8_1)
	self._subEffectBPM:doAction(arg_8_1)

	if self._subEffectBPM:isDone() then
		self:_onFinish()
	end
end

return FogNightmareWaveEffectChoice
