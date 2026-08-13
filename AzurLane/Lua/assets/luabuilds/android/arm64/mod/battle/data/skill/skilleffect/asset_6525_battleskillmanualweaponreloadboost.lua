ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys
class = var_0_10001

local var_0_1 = var_0_10001("BattleSkillManualWeaponReloadBoost", var_0.Battle.BattleSkillEffect)

var_0.Battle.BattleSkillManualWeaponReloadBoost = var_0_1
var_0_1.__name = "BattleSkillManualWeaponReloadBoost"

function var_0_1.Ctor(arg_1_0, arg_1_1)
	local var_1_0 = var_0_1.super.Ctor
	local var_1_1 = arg_1_0
	local var_1_2 = arg_1_1

	lv = var_1_10006

	var_1_0(var_1_1, var_1_2, var_1_10006)

	arg_1_0._weaponType = arg_1_0._tempData.arg_list.weaponType
	arg_1_0._boostValue = arg_1_0._tempData.arg_list.value
	arg_1_0._boostRate = arg_1_0._tempData.arg_list.rate

	return
end

function var_0_1.DoDataEffect(arg_2_0, arg_2_1, arg_2_2)
	if arg_2_0.getWeaponQueueByType(arg_2_1, arg_2_0._weaponType) then
		local var_2_0 = var_3
		local var_2_1 = var_3.GetCoolDownList(var_2_0)

		if arg_2_0._boostValue then
			local var_2_2 = arg_2_0._boostValue * -1

			ipairs = var_2_0

			for iter_2_0, iter_2_1 in var_2_0(var_2_1) do
				iter_2_1:AppendReloadBoost(var_2_2)
			end
		elseif arg_2_0._boostRate then
			ipairs = var_5

			for iter_2_2, iter_2_3 in var_5(var_2_1) do
				local var_2_3 = iter_2_3:GetReloadTimeByRate(arg_2_0._boostRate) * -1
				local var_2_4 = boostValue
				local var_2_5 = iter_2_3
				local var_2_6 = iter_2_3.AppendReloadBoost

				boostValue = var_13

				var_2_6(var_2_5, var_13)
			end
		end
	end

	return
end

function var_0_1.DoDataEffectWithoutTarget(arg_3_0, arg_3_1)
	arg_3_0:DoDataEffect(arg_3_1, nil)

	return
end

function var_0_1.getWeaponQueueByType(arg_4_0, arg_4_1)
	local var_4_0

	if arg_4_1 == "ChargeWeapon" then
		var_4_0 = arg_4_0:GetChargeQueue()
	elseif arg_4_1 == "TorpedoWeapon" then
		var_4_0 = arg_4_0:GetTorpedoQueue()
	elseif arg_4_1 == "AirAssist" then
		var_4_0 = arg_4_0:GetAirAssistQueue()
	end

	return var_4_0
end

return
