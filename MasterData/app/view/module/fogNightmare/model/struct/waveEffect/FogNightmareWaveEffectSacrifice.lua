local FogNightmareWaveEffectSacrifice = class("FogNightmareWaveEffectSacrifice", (require("app.view.module.fogNightmare.model.struct.waveEffect.FogNightmareWaveEffectBaseStruct")))

function FogNightmareWaveEffectSacrifice:ctor(arg_1_1)
	self._effectFloorNum = 0
	self._effectId = 0
	self._effectStartFloor = nil
	self._randSeals = nil

	FogNightmareWaveEffectSacrifice.super.ctor(self, arg_1_1)

	self._effectType = arg_1_1.type
end

function FogNightmareWaveEffectSacrifice:_init(arg_2_1)
	self._effectFloorNum = arg_2_1.parameter_1
	self._effectId = arg_2_1.parameter_2
end

function FogNightmareWaveEffectSacrifice:getEffectFloorNum()
	return self._effectFloorNum
end

function FogNightmareWaveEffectSacrifice:getEffectCfg()
	local var_4_0 = 0

	for iter_4_0 = 1, 1 do
		var_4_0 = g.core.model.User.fogNightmareData:getTalentData():getEffectByTypeValueAndIndex(2, 2, iter_4_0)
	end

	if var_4_0 == 0 then
		var_4_0 = self._effectId
	end

	return (g.core.config.passive_skill_info.get(var_4_0))
end

function FogNightmareWaveEffectSacrifice:getRandSeals()
	return self._randSeals
end

function FogNightmareWaveEffectSacrifice:getCompName()
	return "FogNightmareSacrificeWaveComp"
end

function FogNightmareWaveEffectSacrifice:doing(arg_7_1)
	if arg_7_1.ret == 1 then
		self._randSeals = arg_7_1.rand_seals

		if self._randSeals then
			g.core.model.User.fogNightmareData:getTalentData():setRandSealData(arg_7_1)
		end

		self:_onFinish()
	end
end

return FogNightmareWaveEffectSacrifice
