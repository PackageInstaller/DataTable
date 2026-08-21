ys = ys or {}
ys.Battle.BattleBuffHealingSteal = class("BattleBuffHealingSteal", ys.Battle.BattleBuffEffect)
ys.Battle.BattleBuffHealingSteal.__name = "BattleBuffHealingSteal"

local var_0_0 = ys.Battle.BattleBuffHealingSteal

ys.Battle.BattleBuffHealingSteal.FX_TYPE = ys.Battle.BattleBuffEffect.FX_TYPE_LINK

function ys.Battle.BattleBuffHealingSteal.Ctor(arg_1_0, arg_1_1)
	var_0_0.super.Ctor(arg_1_0, arg_1_1)

	return
end

function ys.Battle.BattleBuffHealingSteal.SetArgs(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0._stealRate = arg_2_0._tempData.arg_list.stealingRate or 1
	arg_2_0._absorbRate = arg_2_0._tempData.arg_list.arsorbRate or 1

	return
end

function ys.Battle.BattleBuffHealingSteal.onTakeHealing(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	local var_3_0 = arg_3_2:GetCaster()

	if var_3_0 and var_3_0:IsAlive() and var_3_0 ~= arg_3_1 then
		local var_3_1 = math.ceil(arg_3_3.damage * arg_3_0._stealRate)

		arg_3_3.damage = arg_3_3.damage - var_3_1

		var_3_0:UpdateHP(math.ceil(var_3_0:GetAttrByName("healingRate") * (var_3_1 * arg_3_0._absorbRate)), {
			isMiss = false,
			isCri = false,
			isShare = false,
			isHeal = true
		})
	end

	return
end

return
