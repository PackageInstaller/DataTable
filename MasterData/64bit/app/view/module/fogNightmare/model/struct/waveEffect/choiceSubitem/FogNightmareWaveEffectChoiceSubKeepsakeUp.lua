local var_0_0 = g.core.const.ConstMgr.FogNightmareConst
local FogNightmareWaveEffectChoiceSubKeepsakeUp = class("FogNightmareWaveEffectChoiceSubKeepsakeUp", (require("app.view.module.fogNightmare.model.struct.waveEffect.FogNightmareWaveEffectBaseStruct")))

function FogNightmareWaveEffectChoiceSubKeepsakeUp:ctor(arg_1_1, arg_1_2)
	self._orginSealStruct = nil
	self._upSealStruct = nil
	self._canUpStructs = nil
	self._upLevel = -1
	self._id = arg_1_1.id
	self._executeInfo = nil

	FogNightmareWaveEffectChoiceSubKeepsakeUp.super.ctor(self, arg_1_1)
end

function FogNightmareWaveEffectChoiceSubKeepsakeUp:_init(arg_2_1)
	self._upLevel = arg_2_1.parameter_1
	self._param = arg_2_1

	local var_2_0 = {}

	for iter_2_0 = 1, 3 do
		if arg_2_1["parameter_" .. iter_2_0] and arg_2_1["parameter_" .. iter_2_0] ~= 0 then
			var_2_0["parameter" .. iter_2_0] = arg_2_1["parameter_" .. iter_2_0]
		end
	end

	self._des = next(var_2_0) and g.core.lang:getByString(arg_2_1.des, var_2_0) or arg_2_1.des
end

function FogNightmareWaveEffectChoiceSubKeepsakeUp:_updateDes()
	local var_3_0 = 0

	for iter_3_0 = 1, 1 do
		var_3_0 = var_3_0 + g.core.model.User.fogNightmareData:getTalentData():getEffectByTypeValueAndIndex(2, 8, iter_3_0)
	end

	if var_3_0 > 0 then
		-- block empty
	end

	local var_3_2 = {}

	for iter_3_1 = 1, 3 do
		if self._param["parameter_" .. iter_3_1] and self._param["parameter_" .. iter_3_1] ~= 0 then
			var_3_2["parameter" .. iter_3_1] = self._param["parameter_" .. iter_3_1]
		end
	end

	self._des = next(var_3_2) and g.core.lang:getByString(self._param.des, var_3_2) or self._param.des
end

function FogNightmareWaveEffectChoiceSubKeepsakeUp:getCompName()
	return (self._orginSealStruct or nil) and ""
end

function FogNightmareWaveEffectChoiceSubKeepsakeUp:getCanUpKnights()
	return self._canUpStructs
end

function FogNightmareWaveEffectChoiceSubKeepsakeUp:resetCanUpKnights(arg_6_1)
	self._canUpStructs = nil
end

function FogNightmareWaveEffectChoiceSubKeepsakeUp:setUpKnight(arg_7_1)
	self._knightStruct = arg_7_1

	if arg_7_1 then
		self._originSealStruct = arg_7_1:getDevelopStruct(var_0_0.KNIGHT_DEVELOP_KEY.KEEPSAKE)
	end
end

function FogNightmareWaveEffectChoiceSubKeepsakeUp:getUpSealStruct()
	return self._upSealStruct
end

function FogNightmareWaveEffectChoiceSubKeepsakeUp:getOriginSealStruct()
	return self._originSealStruct
end

function FogNightmareWaveEffectChoiceSubKeepsakeUp:canChoice()
	return #g.core.model.User.fogNightmareData:getFormationData():getAllHasKeepsakeKnight(self._upLevel) > 0
end

function FogNightmareWaveEffectChoiceSubKeepsakeUp:getNotChoiceTip()
	return g.core.lang:get(500220)
end

function FogNightmareWaveEffectChoiceSubKeepsakeUp:getDes()
	self:_updateDes()

	return self._des
end

function FogNightmareWaveEffectChoiceSubKeepsakeUp:onChoice(arg_13_1)
	local var_13_0 = {
		netParam = {}
	}

	if arg_13_1.floor then
		self._executeInfo = {
			floor = arg_13_1.floor:getFloorId(),
			stage = arg_13_1.stage:getStageId()
		}

		if not self._canUpStructs or not self._knightStruct then
			self._canUpStructs = g.core.model.User.fogNightmareData:getFormationData():getAllHasKeepsakeKnight(self._upLevel)
		else
			var_13_0.netParam.knight_id = self._knightStruct:getServerId()
			self._orginSealStruct = self._knightStruct:getDevelopStruct(var_0_0.KNIGHT_DEVELOP_KEY.KEEPSAKE)
		end
	else
		function var_13_0.call(arg_14_0)
			local var_14_0 = {
				curStruct = self._originSealStruct,
				nextStruct = self._upSealStruct
			}

			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_ADD_POP_SHOW, false, {
				showNow = true,
				frontShow = {
					{
						flag = "keepsakeLevelUp",
						func = function()
							return g.core.module.ModuleManager:pushPopup(require("app.view.module.fogNightmare.view.keepsake.FogNightmareKeepsakeLevelUpPop").new(var_14_0), {
								touchDisappear = true
							})
						end
					}
				}
			})
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_CHECK_FLOOR_STATE, false)
		end

		self:_onFinish()
		g.core.model.User.fogNightmareData:getTowerData():executeWave(self._executeInfo.floor, self._executeInfo.stage, {
			wave = 1,
			choice_id = self._id
		}, true)

		self._executeInfo = nil
	end

	return false, var_13_0
end

function FogNightmareWaveEffectChoiceSubKeepsakeUp:resetData()
	self:resetCanUpKnights()
	self:setUpKnight(nil)

	self._upSealStruct = nil
end

function FogNightmareWaveEffectChoiceSubKeepsakeUp:doing(arg_17_1)
	if arg_17_1.choice_id ~= self._id or not arg_17_1.knight_id then
		return
	end

	self._upSealStruct = g.core.model.User.fogNightmareData:getFormationData():getKnightByServerId(arg_17_1.knight_id):getDevelopStruct(var_0_0.KNIGHT_DEVELOP_KEY.KEEPSAKE)
end

return FogNightmareWaveEffectChoiceSubKeepsakeUp
