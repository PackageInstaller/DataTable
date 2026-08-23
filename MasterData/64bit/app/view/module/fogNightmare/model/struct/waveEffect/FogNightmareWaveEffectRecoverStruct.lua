local FogNightmareWaveEffectRecoverStruct = class("FogNightmareWaveEffectRecoverStruct", (require("app.view.module.fogNightmare.model.struct.waveEffect.FogNightmareWaveEffectBaseStruct")))

function FogNightmareWaveEffectRecoverStruct:ctor(arg_1_1)
	self._recoverHpPercent = 0
	self._recoverKnights = nil

	FogNightmareWaveEffectRecoverStruct.super.ctor(self, arg_1_1)

	self._effectType = arg_1_1.type
end

function FogNightmareWaveEffectRecoverStruct:_init(arg_2_1)
	self._recoverHpPercent = arg_2_1.parameter_1 / 10
end

function FogNightmareWaveEffectRecoverStruct:updateEffectByNetInfo(arg_3_1)
	return
end

function FogNightmareWaveEffectRecoverStruct:getCompName()
	return "FogNightmareCureWaveComp"
end

function FogNightmareWaveEffectRecoverStruct:getRecoverHp()
	local var_5_0 = self._recoverHpPercent
	local var_5_1 = 0

	for iter_5_0 = 1, 1 do
		var_5_1 = var_5_1 + g.core.model.User.fogNightmareData:getTalentData():getEffectByTypeValueAndIndex(2, 1, iter_5_0)
	end

	if var_5_1 > 0 then
		var_5_0 = var_5_0 + var_5_1 / 10
	end

	return var_5_0
end

function FogNightmareWaveEffectRecoverStruct:getRecoverKnights()
	return self._recoverKnights
end

function FogNightmareWaveEffectRecoverStruct:doing(arg_7_1)
	self._recoverKnights = arg_7_1.fog_knights

	if arg_7_1.ret == 1 then
		self:_onFinish()
	end
end

return FogNightmareWaveEffectRecoverStruct
