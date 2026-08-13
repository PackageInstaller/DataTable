ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle

class = var_0_10002
var_0_1.BattleBuffFixAmmo = var_0_10002("BattleBuffFixAmmo", var_0.Battle.BattleBuffEffect)
var_0.Battle.BattleBuffFixAmmo.__name = "BattleBuffFixAmmo"

local var_0_2 = var_0.Battle.BattleBuffFixAmmo

function var_0_2.Ctor(arg_1_0, arg_1_1)
	var_0_2.super.Ctor(arg_1_0, arg_1_1)

	return
end

function var_0_2.SetArgs(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0._damageRate = arg_2_0._tempData.arg_list.damage_rate

	return
end

function var_0_2.onAttach(arg_3_0, arg_3_1, arg_3_2)
	arg_3_0:updateAmmo(arg_3_1, arg_3_0._damageRate)

	return
end

function var_0_2.onRemove(arg_4_0, arg_4_1, arg_4_2)
	arg_4_0:updateAmmo(arg_4_1)

	return
end

function var_0_2.updateAmmo(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = arg_5_1:GetAllWeapon()

	ipairs = var_1_10004

	for iter_5_0, iter_5_1 in var_1_10004(arg_5_0._indexRequire) do
		ipairs = var_1_10009

		for iter_5_2, iter_5_3 in var_1_10009(var_5_0) do
			if iter_5_3:GetEquipmentIndex() == iter_5_1 then
				iter_5_3:FixAmmo(arg_5_2)
			end
		end
	end

	return
end

return
