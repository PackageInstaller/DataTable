local FogNightmareWaveEffectRevivalStruct = class("FogNightmareWaveEffectRevivalStruct", (require("app.view.module.fogNightmare.model.struct.waveEffect.FogNightmareWaveEffectBaseStruct")))

function FogNightmareWaveEffectRevivalStruct:ctor(arg_1_1)
	self._revivalNum = 0
	self._recoverHpPercent = 0
	self._revivalKnights = nil

	FogNightmareWaveEffectRevivalStruct.super.ctor(self, arg_1_1)

	self._effectType = arg_1_1.type
end

function FogNightmareWaveEffectRevivalStruct:_init(arg_2_1)
	self._revivalNum = arg_2_1.parameter_1
	self._recoverHpPercent = arg_2_1.parameter_2 / 10
end

function FogNightmareWaveEffectRevivalStruct:updateEffectByNetInfo(arg_3_1)
	return
end

function FogNightmareWaveEffectRevivalStruct:getCompName()
	return "FogNightmareRevivalWaveComp"
end

function FogNightmareWaveEffectRevivalStruct:getRecoverHp()
	return self._recoverHpPercent
end

function FogNightmareWaveEffectRevivalStruct:getRevivalNum()
	local var_6_0 = self._revivalNum
	local var_6_1 = 0

	for iter_6_0 = 1, 1 do
		var_6_1 = var_6_1 + g.core.model.User.fogNightmareData:getTalentData():getEffectByTypeValueAndIndex(2, 9, iter_6_0)
	end

	if var_6_1 > 0 then
		var_6_0 = var_6_0 + var_6_1
	end

	return var_6_0
end

function FogNightmareWaveEffectRevivalStruct:getRevivalKnights()
	return self._revivalKnights
end

function FogNightmareWaveEffectRevivalStruct:doing(arg_8_1)
	self._revivalKnights = arg_8_1.fog_knights

	if arg_8_1.ret == 1 then
		self:_onFinish()
	end
end

return FogNightmareWaveEffectRevivalStruct
