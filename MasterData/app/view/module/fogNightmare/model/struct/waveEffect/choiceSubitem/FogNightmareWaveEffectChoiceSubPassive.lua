local FogNightmareWaveEffectChoiceSubPassive = class("FogNightmareWaveEffectChoiceSubPassive", (require("app.view.module.fogNightmare.model.struct.waveEffect.FogNightmareWaveEffectBaseStruct")))

function FogNightmareWaveEffectChoiceSubPassive:ctor(arg_1_1, arg_1_2)
	self._effectFloorNum = 0
	self._effectId = -1
	self._effectCfg = nil
	self._id = arg_1_1.id
	self._executeInfo = nil

	FogNightmareWaveEffectChoiceSubPassive.super.ctor(self, arg_1_1)
end

function FogNightmareWaveEffectChoiceSubPassive:_init(arg_2_1)
	self._effectFloorNum = arg_2_1.parameter_1
	self._effectId = arg_2_1.parameter_2
	self._effectCfg = g.core.config.passive_skill_info.get(self._effectId)

	local var_2_0 = {}

	for iter_2_0 = 1, 3 do
		if arg_2_1["parameter_" .. iter_2_0] and arg_2_1["parameter_" .. iter_2_0] ~= 0 then
			var_2_0["parameter" .. iter_2_0] = arg_2_1["parameter_" .. iter_2_0]
		end
	end

	self._des = next(var_2_0) and g.core.lang:getByString(arg_2_1.des, var_2_0) or arg_2_1.des
end

function FogNightmareWaveEffectChoiceSubPassive:getCfg()
	return self._effectCfg
end

function FogNightmareWaveEffectChoiceSubPassive:getRecoverKnights()
	return self._recoverKnights
end

function FogNightmareWaveEffectChoiceSubPassive:canChoice()
	return true
end

function FogNightmareWaveEffectChoiceSubPassive:getDes()
	return self._des
end

function FogNightmareWaveEffectChoiceSubPassive:onChoice(arg_7_1)
	local var_7_0 = {
		netParam = {}
	}

	if arg_7_1.floor then
		self._executeInfo = {
			floor = arg_7_1.floor:getFloorId(),
			stage = arg_7_1.stage:getStageId()
		}
	else
		function var_7_0.call(arg_8_0)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_CHECK_FLOOR_STATE, false)
		end

		self:_onFinish()
		g.core.model.User.fogNightmareData:getTowerData():executeWave(self._executeInfo.floor, self._executeInfo.stage, {
			wave = 1,
			choice_id = self._id
		}, true)

		self._executeInfo = nil
	end

	return false, var_7_0
end

function FogNightmareWaveEffectChoiceSubPassive:doing(arg_9_1)
	if arg_9_1.choice_id ~= self._id then
		return
	end

	self._recoverKnights = arg_9_1.fog_knights
end

return FogNightmareWaveEffectChoiceSubPassive
