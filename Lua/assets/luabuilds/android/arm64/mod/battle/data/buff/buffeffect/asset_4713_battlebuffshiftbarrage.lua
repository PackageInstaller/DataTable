ys = ys or {}
ys.Battle.BattleBuffShiftBarrage = class("BattleBuffShiftBarrage", ys.Battle.BattleBuffEffect)
ys.Battle.BattleBuffShiftBarrage.__name = "BattleBuffShiftBarrage"

local var_0_0 = ys.Battle.BattleBuffShiftBarrage

function ys.Battle.BattleBuffShiftBarrage.Ctor(arg_1_0, arg_1_1)
	var_0_0.super.Ctor(arg_1_0, arg_1_1)

	return
end

function ys.Battle.BattleBuffShiftBarrage:SetArgs(arg_2_1, arg_2_2)
	self._barrageID = self._tempData.arg_list.barrage_id

	return
end

function ys.Battle.BattleBuffShiftBarrage:onAttach(arg_3_1, arg_3_2)
	self:shiftBarrage(arg_3_1, self._barrageID)

	return
end

function ys.Battle.BattleBuffShiftBarrage:onRemove(arg_4_1, arg_4_2)
	self:shiftBarrage(arg_4_1)

	return
end

function ys.Battle.BattleBuffShiftBarrage:shiftBarrage(arg_5_1, arg_5_2)
	local var_5_0 = arg_5_1:GetAllWeapon()

	for iter_5_0, iter_5_1 in ipairs(self._indexRequire) do
		for iter_5_2, iter_5_3 in ipairs(var_5_0) do
			if iter_5_3:GetEquipmentIndex() == iter_5_1 then
				if arg_5_2 then
					iter_5_3:ShiftBarrage(arg_5_2)
				else
					iter_5_3:RevertBarrage()
				end
			end
		end
	end

	return
end

return
