ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle

class = var_0_10002
var_0_1.BattleBuffHPLink = var_0_10002("BattleBuffHPLink", var_0.Battle.BattleBuffEffect)
var_0.Battle.BattleBuffHPLink.__name = "BattleBuffHPLink"

local var_0_2 = var_0.Battle.BattleBuffHPLink

var_0_2.FX_TYPE = var_0.Battle.BattleBuffEffect.FX_TYPE_LINK

function var_0_2.Ctor(arg_1_0, arg_1_1)
	var_0_2.super.Ctor(arg_1_0, arg_1_1)

	return
end

function var_0_2.SetArgs(arg_2_0, arg_2_1, arg_2_2)
	local var_2_0

	if not arg_2_0._tempData.arg_list.number then
		var_2_0 = 0
	end

	arg_2_0._number = var_2_0

	local var_2_1

	if not var_3.absorb then
		var_2_1 = 0
	end

	arg_2_0._absorbRate = var_2_1
	arg_2_0._restoreRate = 0
	arg_2_0._sumDMG = 0

	if var_3.restoreRatio then
		arg_2_0._restoreRate = var_3.restoreRatio * 0.0001
	end

	return
end

function var_0_2.onTakeDamage(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	if arg_3_3.isShare then
		return
	end

	local var_3_0 = arg_3_3.damage

	if arg_3_2:GetCaster() and var_5:IsAlive() and var_5 ~= arg_3_1 then
		math = var_6
		arg_3_3.damage = var_6.ceil(var_3_0 * arg_3_0._number)
		math = var_6

		if var_6.ceil((var_3_0 - arg_3_3.damage) * (1 - arg_3_0._absorbRate)) > 0 then
			arg_3_0._sumDMG = arg_3_0._sumDMG + var_4

			local var_3_1 = {
				isMiss = false,
				isCri = false,
				isShare = true,
				isHeal = false
			}

			var_5:UpdateHP(-var_4, var_3_1)

			if arg_3_3.damageSrc then
				local var_3_2 = arg_3_3.damageSrc
				local var_3_3 = var_0.Battle.BattleDataProxy.GetInstance()

				var_8.DamageStatistics(var_3_3, var_3_2, arg_3_1:GetAttrByName("id"), -var_4)

				local var_3_4 = var_0.Battle.BattleDataProxy.GetInstance()

				var_8.DamageStatistics(var_3_4, var_3_2, var_5:GetAttrByName("id"), var_4)
			end
		end
	end

	return
end

function var_0_2.onRemove(arg_4_0, arg_4_1, arg_4_2)
	if arg_4_2:GetCaster() and var_3:IsAlive() and arg_4_0._restoreRate > 0 and var_3 ~= arg_4_1 then
		local var_4_0 = var_3
		local var_4_1 = var_3.GetAttrByName(var_4_0, "healingRate")

		math = var_4_0

		if var_4_0.floor(arg_4_0._sumDMG * arg_4_0._restoreRate * var_4_1) ~= 0 then
			local var_4_2 = {
				isMiss = false,
				isCri = false,
				isHeal = true
			}

			var_3:UpdateHP(var_5, var_4_2)
		end
	end

	return
end

return
