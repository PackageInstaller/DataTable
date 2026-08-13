ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle

class = var_0_10002
var_0_1.BattleBuffBulletPierce = var_0_10002("BattleBuffBulletPierce", var_0.Battle.BattleBuffEffect)
var_0.Battle.BattleBuffBulletPierce.__name = "BattleBuffBulletPierce"

function var_0.Battle.BattleBuffBulletPierce.Ctor(arg_1_0, arg_1_1)
	var_0.Battle.BattleBuffBulletPierce.super.Ctor(arg_1_0, arg_1_1)

	return
end

function var_0.Battle.BattleBuffBulletPierce.SetArgs(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0._number = arg_2_0._tempData.arg_list.number
	arg_2_0._rate = arg_2_0._tempData.arg_list.rate

	local var_2_0

	if not arg_2_0._tempData.arg_list.bulletType then
		var_2_0 = 0
	end

	arg_2_0._bulletType = var_2_0

	return
end

function var_0.Battle.BattleBuffBulletPierce.onBulletCreate(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	local var_3_0 = arg_3_3._bullet
	local var_3_1 = arg_3_0
	local var_3_2 = arg_3_0.IsHappen

	tonumber = var_1_10008

	if var_3_2(var_3_1, var_1_10008(arg_3_0._rate)) and (arg_3_0._bulletType == var_3_0._tempData.type or arg_3_0._bulletType == 0) then
		var_3_0._pierceCount = arg_3_0._number
	end

	return
end

return
