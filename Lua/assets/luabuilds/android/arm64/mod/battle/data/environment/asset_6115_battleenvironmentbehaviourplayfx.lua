ys = ys or {}

local var_0_0 = ys
local var_0_1 = ys.Battle.BattleConst
local BattleEnvironmentBehaviourPlayFX = class("BattleEnvironmentBehaviourPlayFX", ys.Battle.BattleEnvironmentBehaviour)

ys.Battle.BattleEnvironmentBehaviourPlayFX = BattleEnvironmentBehaviourPlayFX
BattleEnvironmentBehaviourPlayFX.__name = "BattleEnvironmentBehaviourPlayFX"

function BattleEnvironmentBehaviourPlayFX:Ctor()
	BattleEnvironmentBehaviourPlayFX.super.Ctor(self)

	return
end

function BattleEnvironmentBehaviourPlayFX:SetTemplate(arg_2_1)
	BattleEnvironmentBehaviourPlayFX.super.SetTemplate(self, arg_2_1)

	self._FXID = self._tmpData.FX_ID
	self._offset = self._tmpData.offset and Vector3(unpack(self._tmpData.offset)) or Vector3.zero

	return
end

function BattleEnvironmentBehaviourPlayFX:doBehaviour()
	local var_3_0 = 1

	if self._tmpData.scaleRate then
		local var_3_1 = self._unit:GetAOEData()
		local var_3_2 = var_3_1:GetAreaType()
		local var_3_3

		if var_3_2 == var_0_1.AreaType.CUBE then
			var_3_3 = var_3_1:GetWidth()
		elseif var_3_2 == var_0_1.AreaType.COLUMN then
			var_3_3 = var_3_1:GetRange()
		end

		var_3_0 = self._tmpData.scaleRate * var_3_3
	elseif self._tmpData.scale then
		var_3_0 = self._tmpData.scale
	end

	var_0_0.Battle.BattleDataProxy.GetInstance():SpawnEffect(self._FXID, self._unit:GetAOEData():GetPosition() + self._offset, var_3_0)
	BattleEnvironmentBehaviourPlayFX.super.doBehaviour(self)

	return
end

return
