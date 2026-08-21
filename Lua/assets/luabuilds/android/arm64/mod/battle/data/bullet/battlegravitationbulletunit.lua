ys = ys or {}

local var_0_1 = class("BattleGravitationBulletUnit", ys.Battle.BattleBulletUnit)

ys.Battle.BattleGravitationBulletUnit = var_0_1
var_0_1.__name = "BattleGravitationBulletUnit"

function var_0_1.Ctor(arg_1_0, arg_1_1, arg_1_2)
	var_0_1.super.Ctor(arg_1_0, arg_1_1, arg_1_2)

	return
end

function var_0_1.Update(arg_2_0, arg_2_1)
	if arg_2_0._pierceCount > 0 then
		var_0_1.super.Update(arg_2_0, arg_2_1)
	end

	return
end

function var_0_1.SetTemplateData(arg_3_0, arg_3_1)
	var_0_1.super.SetTemplateData(arg_3_0, arg_3_1)

	arg_3_0._hitInterval = arg_3_1.hit_type.interval or 0.2

	return
end

function var_0_1.GetExplodePostion(arg_4_0)
	return arg_4_0._explodePos
end

function var_0_1.SetExplodePosition(arg_5_0, arg_5_1)
	arg_5_0._explodePos = arg_5_1

	return
end

function var_0_1.DealDamage(arg_6_0)
	arg_6_0._nextDamageTime = pg.TimeMgr.GetInstance():GetCombatTime() + arg_6_0._hitInterval

	return
end

function var_0_1.CanDealDamage(arg_7_0)
	local var_7_0

	if not arg_7_0._nextDamageTime then
		arg_7_0._nextDamageTime = pg.TimeMgr.GetInstance():GetCombatTime() + arg_7_0._tempData.extra_param.alert_duration

		do return false end

		goto label_7_0

		var_7_0 = pg.TimeMgr.GetInstance()
	end

	do return arg_7_0._nextDamageTime < var_7_0:GetCombatTime() end

	::label_7_0::

	return
end

function var_0_1.Hit(arg_8_0, arg_8_1, arg_8_2)
	var_0_1.super.Hit(arg_8_0, arg_8_1, arg_8_2)

	arg_8_0._pierceCount = arg_8_0._pierceCount - 1
	arg_8_0._position.y = 100

	return
end

return
