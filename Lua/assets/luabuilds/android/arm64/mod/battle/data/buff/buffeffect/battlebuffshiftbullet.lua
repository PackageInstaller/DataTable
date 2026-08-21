ys = ys or {}
ys.Battle.BattleBuffShiftBullet = class("BattleBuffShiftBullet", ys.Battle.BattleBuffEffect)
ys.Battle.BattleBuffShiftBullet.__name = "BattleBuffShiftBullet"

local var_0_0 = ys.Battle.BattleBuffShiftBullet

function ys.Battle.BattleBuffShiftBullet.Ctor(arg_1_0, arg_1_1)
	var_0_0.super.Ctor(arg_1_0, arg_1_1)

	return
end

function ys.Battle.BattleBuffShiftBullet.SetArgs(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0._bulletID = arg_2_0._tempData.arg_list.bullet_id

	return
end

function ys.Battle.BattleBuffShiftBullet.onAttach(arg_3_0, arg_3_1, arg_3_2)
	arg_3_0:shiftBullet(arg_3_1, arg_3_0._bulletID)

	return
end

function ys.Battle.BattleBuffShiftBullet.onRemove(arg_4_0, arg_4_1, arg_4_2)
	arg_4_0:shiftBullet(arg_4_1)

	return
end

function ys.Battle.BattleBuffShiftBullet.shiftBullet(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = arg_5_1:GetAllWeapon()

	for iter_5_0, iter_5_1 in ipairs(arg_5_0._indexRequire) do
		for iter_5_2, iter_5_3 in ipairs(var_5_0) do
			if iter_5_3:GetEquipmentIndex() == iter_5_1 then
				if arg_5_2 then
					iter_5_3:ShiftBullet(arg_5_2)
				else
					iter_5_3:RevertBullet()
				end
			end
		end
	end

	return
end

return
