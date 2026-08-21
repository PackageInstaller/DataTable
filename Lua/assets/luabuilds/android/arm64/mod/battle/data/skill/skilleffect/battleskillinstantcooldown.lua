ys = ys or {}

local var_0_0 = class("BattleSkillInstantCoolDown", ys.Battle.BattleSkillEffect)

ys.Battle.BattleSkillInstantCoolDown = var_0_0
var_0_0.__name = "BattleSkillInstantCoolDown"

function var_0_0.Ctor(arg_1_0, arg_1_1)
	var_0_0.super.Ctor(arg_1_0, arg_1_1, lv)

	arg_1_0._weaponType = arg_1_0._tempData.arg_list.weaponType

	return
end

function var_0_0.DoDataEffect(arg_2_0, arg_2_1, arg_2_2)
	local var_2_0 = arg_2_0:_GetWeapon(arg_2_1)

	if var_2_0 then
		var_2_0:QuickCoolDown()
	end

	return
end

function var_0_0.DoDataEffectWithoutTarget(arg_3_0, arg_3_1)
	arg_3_0:DoDataEffect(arg_3_1, nil)

	return
end

function var_0_0._GetWeapon(arg_4_0, arg_4_1)
	local var_4_0

	if arg_4_0._weaponType == "AirAssist" then
		var_4_0 = arg_4_1:GetAirAssistQueue():GetQueueHead()
	end

	return var_4_0
end

return
