ys = ys or {}

local var_0_0 = ys

ys.Battle.BattleBuffBulletPierce = class("BattleBuffBulletPierce", ys.Battle.BattleBuffEffect)
ys.Battle.BattleBuffBulletPierce.__name = "BattleBuffBulletPierce"

function ys.Battle.BattleBuffBulletPierce.Ctor(arg_1_0, arg_1_1)
	var_0_0.Battle.BattleBuffBulletPierce.super.Ctor(arg_1_0, arg_1_1)

	return
end

function ys.Battle.BattleBuffBulletPierce.SetArgs(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0._number = arg_2_0._tempData.arg_list.number
	arg_2_0._rate = arg_2_0._tempData.arg_list.rate
	arg_2_0._bulletType = arg_2_0._tempData.arg_list.bulletType or 0

	return
end

function ys.Battle.BattleBuffBulletPierce.onBulletCreate(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	if arg_3_0:IsHappen(tonumber(arg_3_0._rate)) and (arg_3_0._bulletType == arg_3_3._bullet._tempData.type or arg_3_0._bulletType == 0) then
		arg_3_3._bullet._pierceCount = arg_3_0._number
	end

	return
end

return
