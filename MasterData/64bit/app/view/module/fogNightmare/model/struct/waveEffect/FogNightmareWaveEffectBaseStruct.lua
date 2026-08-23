local FogNightmareWaveEffectBaseStruct = class("FogNightmareWaveEffectBaseStruct", (require("app.view.module.fogNightmare.model.struct.bpm.BPMAction")))

function FogNightmareWaveEffectBaseStruct:ctor(arg_1_1)
	FogNightmareWaveEffectBaseStruct.super.ctor(self, arg_1_1)
	self:_init(arg_1_1)
end

function FogNightmareWaveEffectBaseStruct:_init(arg_2_1)
	return
end

function FogNightmareWaveEffectBaseStruct:updateEffectByNetInfo(arg_3_1)
	return
end

function FogNightmareWaveEffectBaseStruct:getCompName()
	return
end

function FogNightmareWaveEffectBaseStruct:resetData()
	return
end

function FogNightmareWaveEffectBaseStruct:getEffectType()
	return self._effectType
end

return FogNightmareWaveEffectBaseStruct
