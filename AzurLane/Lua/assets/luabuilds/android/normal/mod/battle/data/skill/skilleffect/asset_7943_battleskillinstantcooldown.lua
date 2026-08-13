ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys
class = var_0_10001

local var_0_1 = var_0_10001("BattleSkillInstantCoolDown", var_0.Battle.BattleSkillEffect)

var_0.Battle.BattleSkillInstantCoolDown = var_0_1
var_0_1.__name = "BattleSkillInstantCoolDown"

function var_0_1.Ctor(arg_1_0, arg_1_1)
	local var_1_0 = var_0_1.super.Ctor
	local var_1_1 = arg_1_0
	local var_1_2 = arg_1_1

	lv = var_1_10005

	var_1_0(var_1_1, var_1_2, var_1_10005)

	arg_1_0._weaponType = arg_1_0._tempData.arg_list.weaponType

	return
end

function var_0_1.DoDataEffect(arg_2_0, arg_2_1, arg_2_2)
	if arg_2_0:_GetWeapon(arg_2_1) then
		var_3:QuickCoolDown()
	end

	return
end

function var_0_1.DoDataEffectWithoutTarget(arg_3_0, arg_3_1)
	arg_3_0:DoDataEffect(arg_3_1, nil)

	return
end

function var_0_1._GetWeapon(arg_4_0, arg_4_1)
	local var_4_0

	if arg_4_0._weaponType == "AirAssist" then
		local var_4_1 = arg_4_1:GetAirAssistQueue()

		var_4_0 = var_3.GetQueueHead(var_4_1)
	end

	return var_4_0
end

return
