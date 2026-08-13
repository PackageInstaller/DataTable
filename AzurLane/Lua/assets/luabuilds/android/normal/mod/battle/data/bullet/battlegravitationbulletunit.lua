ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle.BattleFormulas

class = var_0_10002

local var_0_2 = var_0_10002("BattleGravitationBulletUnit", var_0.Battle.BattleBulletUnit)

var_0.Battle.BattleGravitationBulletUnit = var_0_2
var_0_2.__name = "BattleGravitationBulletUnit"

function var_0_2.Ctor(arg_1_0, arg_1_1, arg_1_2)
	var_0_2.super.Ctor(arg_1_0, arg_1_1, arg_1_2)

	return
end

function var_0_2.Update(arg_2_0, arg_2_1)
	if arg_2_0._pierceCount > 0 then
		var_0_2.super.Update(arg_2_0, arg_2_1)
	end

	return
end

function var_0_2.SetTemplateData(arg_3_0, arg_3_1)
	var_0_2.super.SetTemplateData(arg_3_0, arg_3_1)

	local var_3_0

	if not arg_3_1.hit_type.interval then
		var_3_0 = 0.2
	end

	arg_3_0._hitInterval = var_3_0

	return
end

function var_0_2.GetExplodePostion(arg_4_0)
	return arg_4_0._explodePos
end

function var_0_2.SetExplodePosition(arg_5_0, arg_5_1)
	arg_5_0._explodePos = arg_5_1

	return
end

function var_0_2.DealDamage(arg_6_0)
	pg = var_1_10001

	local var_6_0 = var_1_10001.TimeMgr.GetInstance()

	arg_6_0._nextDamageTime = var_1.GetCombatTime(var_6_0) + arg_6_0._hitInterval

	return
end

function var_0_2.CanDealDamage(arg_7_0)
	if not arg_7_0._nextDamageTime then
		pg = var_1
		var_1_10002 = var_1.TimeMgr.GetInstance()
		arg_7_0._nextDamageTime = var_1.GetCombatTime(var_1_10002) + arg_7_0._tempData.extra_param.alert_duration

		return false
	else
		local var_7_0 = arg_7_0._nextDamageTime

		pg = var_1_10002

		local var_7_1 = var_1_10002.TimeMgr.GetInstance()

		return var_7_0 < var_2.GetCombatTime(var_7_1)
	end

	return
end

function var_0_2.Hit(arg_8_0, arg_8_1, arg_8_2)
	var_0_2.super.Hit(arg_8_0, arg_8_1, arg_8_2)

	arg_8_0._pierceCount = arg_8_0._pierceCount - 1
	arg_8_0._position.y = 100

	return
end

return
