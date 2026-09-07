ys = ys or {}
ys.Battle.BattleBuffPointAirStrike = class("BattleBuffPointAirStrike", ys.Battle.BattleBuffEffect)
ys.Battle.BattleBuffPointAirStrike.__name = "BattleBuffPointAirStrike"

local var_0_0 = ys.Battle.BattleBuffPointAirStrike

function ys.Battle.BattleBuffPointAirStrike.Ctor(arg_1_0, arg_1_1)
	var_0_0.super.Ctor(arg_1_0, arg_1_1)

	return
end

function ys.Battle.BattleBuffPointAirStrike:SetArgs(arg_2_1, arg_2_2)
	self._hiveIDList = self._tempData.arg_list.aircraft_id_list
	self._initCD = self._tempData.arg_list.initial_over_heat
	self._stackCount = self._tempData.arg_list.stack_count
	self._strikeWeapon = self._tempData.arg_list.weapon_id

	return
end

function ys.Battle.BattleBuffPointAirStrike:onAttach(arg_3_1, arg_3_2)
	self:addManualWeapon(arg_3_1)

	return
end

function ys.Battle.BattleBuffPointAirStrike:addManualWeapon(arg_4_1)
	for iter_4_0 = 1, self._stackCount do
		arg_4_1:AddPointAirStrike(self._strikeWeapon, self._coolDownDuration, self._initCD):SetAirUnit(self._hiveIDList)
	end

	return
end

return
