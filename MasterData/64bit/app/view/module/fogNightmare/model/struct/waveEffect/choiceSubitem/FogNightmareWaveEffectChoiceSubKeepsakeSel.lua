local var_0_0 = g.core.model.User.fogNightmareData
local FogNightmareWaveEffectChoiceSubKeepsakeSel = class("FogNightmareWaveEffectChoiceSubKeepsakeSel", (require("app.view.module.fogNightmare.model.struct.waveEffect.FogNightmareWaveEffectBaseStruct")))

function FogNightmareWaveEffectChoiceSubKeepsakeSel:ctor(arg_1_1, arg_1_2)
	self._randSeals = nil
	self._id = arg_1_1.id
	self._executeInfo = nil

	FogNightmareWaveEffectChoiceSubKeepsakeSel.super.ctor(self, arg_1_1)
end

function FogNightmareWaveEffectChoiceSubKeepsakeSel:_init(arg_2_1)
	self._upLevel = arg_2_1.parameter_1

	local var_2_0 = {}

	for iter_2_0 = 1, 3 do
		if arg_2_1["parameter_" .. iter_2_0] and arg_2_1["parameter_" .. iter_2_0] ~= 0 then
			var_2_0["parameter" .. iter_2_0] = arg_2_1["parameter_" .. iter_2_0]
		end
	end

	self._des = next(var_2_0) and g.core.lang:getByString(arg_2_1.des, var_2_0) or arg_2_1.des
end

function FogNightmareWaveEffectChoiceSubKeepsakeSel:getTarget()
	return self._target
end

function FogNightmareWaveEffectChoiceSubKeepsakeSel:canChoice()
	return true
end

function FogNightmareWaveEffectChoiceSubKeepsakeSel:getDes()
	return self._des
end

function FogNightmareWaveEffectChoiceSubKeepsakeSel:onChoice(arg_6_1)
	local var_6_0 = {
		netParam = {}
	}

	if arg_6_1.floor then
		self._executeInfo = {
			floor = arg_6_1.floor:getFloorId(),
			stage = arg_6_1.stage:getStageId()
		}

		return false, var_6_0
	elseif self._randSeals then
		function var_6_0.call()
			g.core.module.ModuleManager:pushPopup(require("app.view.module.fogNightmare.view.keepsake.FogNightmareKeepsakeSelectPop").new(), {
				touchDisappear = false
			})
		end

		self:_onFinish()
		g.core.model.User.fogNightmareData:getTowerData():executeWave(self._executeInfo.floor, self._executeInfo.stage, {
			wave = 1,
			choice_id = self._id
		}, true)

		self._executeInfo = nil
	end

	return false, var_6_0
end

function FogNightmareWaveEffectChoiceSubKeepsakeSel:doing(arg_8_1)
	if arg_8_1.choice_id ~= self._id then
		return
	end

	self._randSeals = arg_8_1.rand_seals

	if self._randSeals then
		var_0_0:getTalentData():setRandSealData(arg_8_1)
	end
end

return FogNightmareWaveEffectChoiceSubKeepsakeSel
