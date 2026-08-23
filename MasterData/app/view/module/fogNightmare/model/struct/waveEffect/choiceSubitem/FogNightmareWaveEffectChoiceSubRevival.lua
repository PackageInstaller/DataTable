local FogNightmareWaveEffectChoiceSubRevival = class("FogNightmareWaveEffectChoiceSubRevival", (require("app.view.module.fogNightmare.model.struct.waveEffect.FogNightmareWaveEffectBaseStruct")))

function FogNightmareWaveEffectChoiceSubRevival:ctor(arg_1_1, arg_1_2)
	self._revivalNum = 0
	self._recoverHpPercent = 0
	self._revivalKnights = nil
	self._id = arg_1_1.id
	self._executeInfo = nil

	FogNightmareWaveEffectChoiceSubRevival.super.ctor(self, arg_1_1)
end

function FogNightmareWaveEffectChoiceSubRevival:_init(arg_2_1)
	self._revivalNum = arg_2_1.parameter_1
	self._recoverHpPercent = arg_2_1.parameter_2 / 10
	self._param = arg_2_1

	local var_2_0 = {
		parameter1 = self._revivalNum,
		parameter2 = self._recoverHpPercent
	}

	for iter_2_0 = 3, 3 do
		if arg_2_1["parameter_" .. iter_2_0] and arg_2_1["parameter_" .. iter_2_0] ~= 0 then
			var_2_0["parameter" .. iter_2_0] = arg_2_1["parameter_" .. iter_2_0]
		end
	end

	self._des = next(var_2_0) and g.core.lang:getByString(arg_2_1.des, var_2_0) or arg_2_1.des
end

function FogNightmareWaveEffectChoiceSubRevival:_updateDes()
	local var_3_0 = {
		parameter1 = self._revivalNum,
		parameter2 = self._recoverHpPercent
	}

	for iter_3_0 = 3, 3 do
		if self._param["parameter_" .. iter_3_0] and self._param["parameter_" .. iter_3_0] ~= 0 then
			var_3_0["parameter" .. iter_3_0] = self._param["parameter_" .. iter_3_0]
		end
	end

	self._des = next(var_3_0) and g.core.lang:getByString(self._param.des, var_3_0) or self._param.des
end

function FogNightmareWaveEffectChoiceSubRevival:getCompName()
	return ""
end

function FogNightmareWaveEffectChoiceSubRevival:getRecoverHp()
	return self._recoverHpPercent
end

function FogNightmareWaveEffectChoiceSubRevival:getRecoverKnights()
	return self._recoverKnights
end

function FogNightmareWaveEffectChoiceSubRevival:canChoice()
	return #g.core.model.User.fogNightmareData:getFormationData():getAllKnightsByStates({
		[g.core.const.ConstMgr.KNIGHT_CONST.SPECIAL_KNIGHT_STATE.DEFEATED] = true
	}) > 0
end

function FogNightmareWaveEffectChoiceSubRevival:getNotChoiceTip()
	return g.core.lang:get(500221)
end

function FogNightmareWaveEffectChoiceSubRevival:getDes()
	self:_updateDes()

	return self._des
end

function FogNightmareWaveEffectChoiceSubRevival:onChoice(arg_10_1)
	local var_10_0 = {
		netParam = {}
	}

	if arg_10_1.floor then
		self._executeInfo = {
			floor = arg_10_1.floor:getFloorId(),
			stage = arg_10_1.stage:getStageId()
		}
	else
		function var_10_0.call(arg_11_0)
			if self._revivalKnights then
				local var_11_0 = {
					title = g.core.lang:get(500208),
					knightStruct = self._revivalKnights,
					style = g.core.const.ConstMgr.KNIGHT_CONST.SPECIAL_KNIGHT_STATE.REVIVAL
				}

				g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_ADD_POP_SHOW, false, {
					showNow = true,
					frontShow = {
						{
							flag = "revival",
							func = function()
								return g.core.module.ModuleManager:pushPopup(require("app.view.module.fogNightmare.view.explore.pop.FogNightmareKnightStatePop").new(var_11_0), {
									touchDisappear = true
								})
							end
						}
					}
				})
			else
				g.core.module.ModuleManager:tip(g.core.lang:get(500180))
				g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_CHECK_FLOOR_STATE, false)
			end
		end

		self:_onFinish()
		g.core.model.User.fogNightmareData:getTowerData():executeWave(self._executeInfo.floor, self._executeInfo.stage, {
			wave = 1,
			choice_id = self._id
		}, true)

		self._executeInfo = nil
	end

	return false, var_10_0
end

function FogNightmareWaveEffectChoiceSubRevival:doing(arg_13_1)
	if arg_13_1.choice_id ~= self._id then
		return
	end

	if arg_13_1.fog_knights then
		self._revivalKnights = {}

		local var_13_0 = g.core.model.User.fogNightmareData:getFormationData()

		for iter_13_0, iter_13_1 in ipairs(arg_13_1.fog_knights) do
			table.insert(self._revivalKnights, (var_13_0:getKnightByServerId(iter_13_1.id)))
		end
	end
end

return FogNightmareWaveEffectChoiceSubRevival
