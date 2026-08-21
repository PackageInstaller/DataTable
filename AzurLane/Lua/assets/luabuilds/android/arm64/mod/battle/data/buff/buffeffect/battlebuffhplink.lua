ys = ys or {}

local var_0_0 = ys

ys.Battle.BattleBuffHPLink = class("BattleBuffHPLink", ys.Battle.BattleBuffEffect)
ys.Battle.BattleBuffHPLink.__name = "BattleBuffHPLink"

local var_0_1 = ys.Battle.BattleBuffHPLink

ys.Battle.BattleBuffHPLink.FX_TYPE = ys.Battle.BattleBuffEffect.FX_TYPE_LINK

function ys.Battle.BattleBuffHPLink.Ctor(arg_1_0, arg_1_1)
	var_0_1.super.Ctor(arg_1_0, arg_1_1)

	return
end

function ys.Battle.BattleBuffHPLink.SetArgs(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0._number = arg_2_0._tempData.arg_list.number or 0
	arg_2_0._absorbRate = arg_2_0._tempData.arg_list.absorb or 0
	arg_2_0._restoreRate = 0
	arg_2_0._sumDMG = 0

	if arg_2_0._tempData.arg_list.restoreRatio then
		arg_2_0._restoreRate = arg_2_0._tempData.arg_list.restoreRatio * 0.0001
	end

	return
end

function ys.Battle.BattleBuffHPLink.onTakeDamage(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	if arg_3_3.isShare then
		return
	end

	local var_3_0 = arg_3_3.damage
	local var_3_1 = arg_3_2:GetCaster()

	if var_3_1 and var_3_1:IsAlive() and var_3_1 ~= arg_3_1 then
		arg_3_3.damage = math.ceil(var_3_0 * arg_3_0._number)

		local var_3_2 = math.ceil((var_3_0 - arg_3_3.damage) * (1 - arg_3_0._absorbRate))

		if var_3_2 > 0 then
			arg_3_0._sumDMG = arg_3_0._sumDMG + var_3_2

			var_3_1:UpdateHP(-var_3_2, {
				isMiss = false,
				isCri = false,
				isShare = true,
				isHeal = false
			})

			if arg_3_3.damageSrc then
				var_0_0.Battle.BattleDataProxy.GetInstance():DamageStatistics(arg_3_3.damageSrc, arg_3_1:GetAttrByName("id"), -var_3_2)
				var_0_0.Battle.BattleDataProxy.GetInstance():DamageStatistics(arg_3_3.damageSrc, var_3_1:GetAttrByName("id"), var_3_2)
			end
		end
	end

	return
end

function ys.Battle.BattleBuffHPLink.onRemove(arg_4_0, arg_4_1, arg_4_2)
	local var_4_0 = arg_4_2:GetCaster()

	if var_4_0 and var_4_0:IsAlive() and arg_4_0._restoreRate > 0 and var_4_0 ~= arg_4_1 then
		local var_4_1 = math.floor(arg_4_0._sumDMG * arg_4_0._restoreRate * var_4_0:GetAttrByName("healingRate"))

		if var_4_1 ~= 0 then
			var_4_0:UpdateHP(var_4_1, {
				isMiss = false,
				isCri = false,
				isHeal = true
			})
		end
	end

	return
end

return
