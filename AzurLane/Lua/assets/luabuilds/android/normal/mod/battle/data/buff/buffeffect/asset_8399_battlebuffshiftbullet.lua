ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle

class = var_0_10002
var_0_1.BattleBuffShiftBullet = var_0_10002("BattleBuffShiftBullet", var_0.Battle.BattleBuffEffect)
var_0.Battle.BattleBuffShiftBullet.__name = "BattleBuffShiftBullet"

local var_0_2 = var_0.Battle.BattleBuffShiftBullet

function var_0_2.Ctor(arg_1_0, arg_1_1)
	var_0_2.super.Ctor(arg_1_0, arg_1_1)

	return
end

function var_0_2.SetArgs(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0._bulletID = arg_2_0._tempData.arg_list.bullet_id

	return
end

function var_0_2.onAttach(arg_3_0, arg_3_1, arg_3_2)
	arg_3_0:shiftBullet(arg_3_1, arg_3_0._bulletID)

	return
end

function var_0_2.onRemove(arg_4_0, arg_4_1, arg_4_2)
	arg_4_0:shiftBullet(arg_4_1)

	return
end

function var_0_2.shiftBullet(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = arg_5_1
	local var_5_1 = arg_5_1.GetAllWeapon(var_5_0)

	ipairs = var_5_0

	for iter_5_0, iter_5_1 in var_5_0(arg_5_0._indexRequire) do
		ipairs = var_1_10009

		for iter_5_2, iter_5_3 in var_1_10009(var_5_1) do
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
