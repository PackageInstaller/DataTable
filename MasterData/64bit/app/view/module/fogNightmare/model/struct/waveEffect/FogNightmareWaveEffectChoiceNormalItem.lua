local var_0_0 = g.core.config.fog_choice_info
local var_0_1 = g.core.const.ConstMgr.FogNightmareConst
local FogNightmareWaveEffectChoiceNormalItem = class("FogNightmareWaveEffectChoiceNormalItem", (require("app.view.module.fogNightmare.model.struct.waveEffect.FogNightmareWaveEffectBaseStruct")))

function FogNightmareWaveEffectChoiceNormalItem:ctor(arg_1_1)
	self._id = arg_1_1.id
	self._cfg = nil
	self._realEffect = nil

	FogNightmareWaveEffectChoiceNormalItem.super.ctor(self, arg_1_1)
end

function FogNightmareWaveEffectChoiceNormalItem:_init(arg_2_1)
	self._cfg = var_0_0.get(self._id)

	self:_initRealEffectStruct()
end

function FogNightmareWaveEffectChoiceNormalItem:_initRealEffectStruct()
	local var_3_0

	if var_0_1.EFFECT_CHOICE_SUB_TYPE.RECOVER == self._id then
		var_3_0 = require("app.view.module.fogNightmare.model.struct.waveEffect.choiceSubitem.FogNightmareWaveEffectChoiceSubRecover").new(self._cfg, self)
	elseif var_0_1.EFFECT_CHOICE_SUB_TYPE.REVIVAL == self._id then
		var_3_0 = require("app.view.module.fogNightmare.model.struct.waveEffect.choiceSubitem.FogNightmareWaveEffectChoiceSubRevival").new(self._cfg, self)
	elseif var_0_1.EFFECT_CHOICE_SUB_TYPE.KEEPSAKE_LEVELUP == self._id then
		var_3_0 = require("app.view.module.fogNightmare.model.struct.waveEffect.choiceSubitem.FogNightmareWaveEffectChoiceSubKeepsakeUp").new(self._cfg, self)
	elseif var_0_1.EFFECT_CHOICE_SUB_TYPE.PASSIVE == self._id then
		var_3_0 = require("app.view.module.fogNightmare.model.struct.waveEffect.choiceSubitem.FogNightmareWaveEffectChoiceSubPassive").new(self._cfg, self)
	elseif var_0_1.EFFECT_CHOICE_SUB_TYPE.KEEPSAKE_RANDOM == self._id then
		var_3_0 = require("app.view.module.fogNightmare.model.struct.waveEffect.choiceSubitem.FogNightmareWaveEffectChoiceSubKeepsakeSel").new(self._cfg, self)
	end

	self._realEffect = var_3_0
end

function FogNightmareWaveEffectChoiceNormalItem:getCompName()
	return "FogNightmareChoiceWaveTextItem"
end

function FogNightmareWaveEffectChoiceNormalItem:getRealEffect()
	return self._realEffect
end

function FogNightmareWaveEffectChoiceNormalItem:getCfg()
	return self._cfg
end

function FogNightmareWaveEffectChoiceNormalItem:doing(arg_7_1)
	if arg_7_1.choice_id == self._id then
		self._realEffect:doing(arg_7_1)

		if self._realEffect:isFinish() then
			self:_onFinish()
		end
	end
end

return FogNightmareWaveEffectChoiceNormalItem
