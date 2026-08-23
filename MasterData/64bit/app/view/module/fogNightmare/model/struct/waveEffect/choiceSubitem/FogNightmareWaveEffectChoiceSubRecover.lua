local FogNightmareWaveEffectChoiceSubRecover = class("FogNightmareWaveEffectChoiceSubRecover", (require("app.view.module.fogNightmare.model.struct.waveEffect.FogNightmareWaveEffectBaseStruct")))

function FogNightmareWaveEffectChoiceSubRecover:ctor(arg_1_1, arg_1_2)
	self._recoverHpPercent = 0
	self._recoverKnights = nil
	self._id = arg_1_1.id
	self._executeInfo = nil

	FogNightmareWaveEffectChoiceSubRecover.super.ctor(self, arg_1_1)
end

function FogNightmareWaveEffectChoiceSubRecover:_init(arg_2_1)
	self._recoverHpPercent = arg_2_1.parameter_1 / 10
	self._param = arg_2_1

	local var_2_0 = {
		parameter1 = self._recoverHpPercent
	}

	for iter_2_0 = 2, 3 do
		if arg_2_1["parameter_" .. iter_2_0] and arg_2_1["parameter_" .. iter_2_0] ~= 0 then
			var_2_0["parameter" .. iter_2_0] = arg_2_1["parameter_" .. iter_2_0]
		end
	end

	self._des = next(var_2_0) and g.core.lang:getByString(arg_2_1.des, var_2_0) or arg_2_1.des
end

function FogNightmareWaveEffectChoiceSubRecover:_updateDes()
	local var_3_0 = {
		parameter1 = self._recoverHpPercent
	}

	for iter_3_0 = 2, 3 do
		if self._param["parameter_" .. iter_3_0] and self._param["parameter_" .. iter_3_0] ~= 0 then
			var_3_0["parameter" .. iter_3_0] = self._param["parameter_" .. iter_3_0]
		end
	end

	self._des = next(var_3_0) and g.core.lang:getByString(self._param.des, var_3_0) or self._param.des
end

function FogNightmareWaveEffectChoiceSubRecover:canChoice()
	return true
end

function FogNightmareWaveEffectChoiceSubRecover:getDes()
	self:_updateDes()

	return self._des
end

function FogNightmareWaveEffectChoiceSubRecover:onChoice(arg_6_1)
	local var_6_0 = {
		netParam = {}
	}

	if arg_6_1.floor then
		self._executeInfo = {
			floor = arg_6_1.floor:getFloorId(),
			stage = arg_6_1.stage:getStageId()
		}
	else
		function var_6_0.call(arg_7_0)
			local var_7_0 = {
				desc = self._des
			}

			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_ADD_POP_SHOW, false, {
				showNow = true,
				frontShow = {
					{
						flag = "recover",
						func = function()
							return g.core.module.ModuleManager:pushPopup(require("app.view.module.fogNightmare.view.explore.pop.FogNightmareExploreBlessPop").new(var_7_0), {
								touchDisappear = true
							})
						end
					}
				}
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

function FogNightmareWaveEffectChoiceSubRecover:doing(arg_9_1)
	if arg_9_1.choice_id ~= self._id then
		return
	end

	self._recoverKnights = {}

	if arg_9_1.fog_knights then
		local var_9_0 = g.core.model.User.fogNightmareData:getFormationData()

		for iter_9_0, iter_9_1 in ipairs(arg_9_1.fog_knights) do
			table.insert(self._recoverKnights, (var_9_0:getKnightByServerId(iter_9_1.id)))
		end
	end
end

return FogNightmareWaveEffectChoiceSubRecover
