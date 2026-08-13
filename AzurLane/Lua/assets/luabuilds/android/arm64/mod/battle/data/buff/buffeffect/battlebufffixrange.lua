ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle

class = var_0_10002
var_0_1.BattleBuffFixRange = var_0_10002("BattleBuffFixRange", var_0.Battle.BattleBuffEffect)
var_0.Battle.BattleBuffFixRange.__name = "BattleBuffFixRange"

local var_0_2 = var_0.Battle.BattleBuffFixRange

function var_0_2.Ctor(arg_1_0, arg_1_1)
	var_0_2.super.Ctor(arg_1_0, arg_1_1)

	return
end

function var_0_2.SetArgs(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0._weaponRange = arg_2_0._tempData.arg_list.weaponRange
	arg_2_0._bulletRange = arg_2_0._tempData.arg_list.bulletRange
	arg_2_0._minRange = arg_2_0._tempData.arg_list.minRange
	arg_2_0._bulletRangeOffset = arg_2_0._tempData.arg_list.bulletRangeOffset

	return
end

function var_0_2.onAttach(arg_3_0, arg_3_1)
	if arg_3_0._weaponRange or arg_3_0._bulletRange or arg_3_0._bulletRangeOffset then
		arg_3_0:updateBulletRange(arg_3_1, arg_3_0._weaponRange, arg_3_0._bulletRange, arg_3_0._minRange, arg_3_0._bulletRangeOffset)
	end

	return
end

function var_0_2.onRemove(arg_4_0, arg_4_1)
	arg_4_0:updateBulletRange(arg_4_1)

	return
end

function var_0_2.updateBulletRange(arg_5_0, arg_5_1, arg_5_2, arg_5_3, arg_5_4, arg_5_5)
	local var_5_0 = arg_5_1:GetAllWeapon()

	ipairs = var_1_10007

	for iter_5_0, iter_5_1 in var_1_10007(var_5_0) do
		local var_5_1 = iter_5_1:GetEquipmentIndex()

		if arg_5_0._indexRequire ~= nil then
			table = var_13

			if var_13.contains(arg_5_0._indexRequire, var_5_1) then
				iter_5_1:FixWeaponRange(arg_5_2, arg_5_3, arg_5_4, arg_5_5)
			end
		end
	end

	return
end

return
