ys = ys or {}

local var_0_0 = ys
local var_0_1 = ys.Battle.BattleConst
local BattleBuffAddFleetBuff = class("BattleBuffAddFleetBuff", ys.Battle.BattleBuffEffect)

ys.Battle.BattleBuffAddFleetBuff = BattleBuffAddFleetBuff
BattleBuffAddFleetBuff.__name = "BattleBuffAddFleetBuff"

function BattleBuffAddFleetBuff:Ctor(arg_1_1)
	BattleBuffAddFleetBuff.super.Ctor(self, arg_1_1)

	return
end

function BattleBuffAddFleetBuff:SetArgs(arg_2_1, arg_2_2)
	self._level = arg_2_2:GetLv()
	self._fleetBuffID = self._tempData.arg_list.fleet_buff_id

	return
end

function BattleBuffAddFleetBuff:onAttach(arg_3_1, arg_3_2)
	if arg_3_1:GetUnitType() ~= var_0_1.UnitType.PLAYER_UNIT then
		return
	end

	arg_3_1:GetFleetVO():AttachFleetBuff((var_0_0.Battle.BattleFleetBuffUnit.New(self._fleetBuffID)))

	return
end

function BattleBuffAddFleetBuff:onRemove(arg_4_1, arg_4_2)
	if arg_4_1:GetUnitType() ~= var_0_1.UnitType.PLAYER_UNIT then
		return
	end

	arg_4_1:GetFleetVO():RemoveFleetBuff(self._fleetBuffID)

	return
end

return
