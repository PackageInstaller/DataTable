ys = ys or {}

local var_0_0 = ys

ys.Battle.BattleBuffWorldVariable = class("BattleBuffWorldVariable", ys.Battle.BattleBuffEffect)
ys.Battle.BattleBuffWorldVariable.__name = "BattleBuffWorldVariable"

local var_0_1 = ys.Battle.BattleBuffWorldVariable

function ys.Battle.BattleBuffWorldVariable.Ctor(arg_1_0, arg_1_1)
	var_0_1.super.Ctor(arg_1_0, arg_1_1)

	return
end

function ys.Battle.BattleBuffWorldVariable:SetArgs(arg_2_1, arg_2_2)
	self._variable = self._tempData.arg_list.variable
	self._key = self._tempData.arg_list.key
	self._number = self._tempData.arg_list.number
	self._resetNumber = self._tempData.arg_list.resetNumber
	self._speedFactorName = "buff_" .. self._tempData.id

	return
end

function ys.Battle.BattleBuffWorldVariable:onAttach(arg_3_1, arg_3_2)
	if self._key then
		var_0_0.Battle.BattleVariable.AppendIFFFactor(self._key, self._speedFactorName, self._number)
	else
		var_0_0.Battle.BattleVariable.AppendMapFactor(self._speedFactorName, self._number)
	end

	return
end

function ys.Battle.BattleBuffWorldVariable:onRemove(arg_4_1, arg_4_2)
	if self._key then
		var_0_0.Battle.BattleVariable.RemoveIFFFactor(self._key, self._speedFactorName)
	else
		var_0_0.Battle.BattleVariable.RemoveMapFactor(self._speedFactorName)
	end

	return
end

return
