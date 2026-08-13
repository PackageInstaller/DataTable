ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle

class = var_0_10002
var_0_1.BattleBuffOverrideBullet = var_0_10002("BattleBuffOverrideBullet", var_0.Battle.BattleBuffEffect)
var_0.Battle.BattleBuffOverrideBullet.__name = "BattleBuffOverrideBullet"

local var_0_2 = var_0.Battle.BattleBuffOverrideBullet

function var_0_2.Ctor(arg_1_0, arg_1_1)
	var_0_2.super.Ctor(arg_1_0, arg_1_1)

	return
end

function var_0_2.SetArgs(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0._bulletType = arg_2_0._tempData.arg_list.bullet_type
	arg_2_0._override = arg_2_0._tempData.arg_list.override

	return
end

function var_0_2.onBulletCreate(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	if not arg_3_0:equipIndexRequire(arg_3_3.equipIndex) then
		return
	end

	local var_3_0 = arg_3_3._bullet

	if var_4.GetType(var_3_0) == arg_3_0._bulletType then
		arg_3_0:overrideBullet(var_4)
	end

	return
end

function var_0_2.overrideBullet(arg_4_0, arg_4_1)
	pairs = var_1_10002

	for iter_4_0, iter_4_1 in var_1_10002(arg_4_0._override) do
		if iter_4_0 == "diverFilter" then
			arg_4_1:SetDiverFilter(iter_4_1)
			arg_4_1:ResetCldSurface()
		elseif iter_4_0 == "ignoreShield" then
			arg_4_1:SetIgnoreShield(iter_4_1)
		end
	end

	return
end

return
