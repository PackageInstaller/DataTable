ys = ys or {}

local var_0_5 = ys.Battle.BattleUnitEvent
local var_0_6 = class("BattleBossUnit", ys.Battle.BattleEnemyUnit)

ys.Battle.BattleBossUnit = var_0_6
var_0_6.__name = "BattleBossUnit"

function var_0_6.Ctor(arg_1_0, arg_1_1, arg_1_2)
	var_0_6.super.Ctor(arg_1_0, arg_1_1, arg_1_2)

	arg_1_0._isBoss = true

	return
end

function var_0_6.IsBoss(arg_2_0)
	return true
end

function var_0_6.BarrierStateChange(arg_3_0, arg_3_1, arg_3_2)
	arg_3_0:DispatchEvent(var_0.Event.New(var_0_5.BARRIER_STATE_CHANGE, {
		barrierDurability = arg_3_1,
		barrierDuration = arg_3_2
	}))

	return
end

function var_0_6.UpdateHP(arg_4_0, arg_4_1, arg_4_2, arg_4_3, arg_4_4)
	local var_4_0 = var_0_6.super.UpdateHP(arg_4_0, arg_4_1, arg_4_2, arg_4_3, arg_4_4) or 0

	if var_4_0 < 0 then
		for iter_4_0, iter_4_1 in ipairs(arg_4_0._autoWeaponList) do
			iter_4_1:UpdatePrecastArmor(var_4_0)
		end
	end

	return var_4_0
end

return
