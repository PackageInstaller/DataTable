ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle.BattleDataFunction
local var_0_2 = var_0.Battle.BattleConst
local var_0_3 = var_0.Battle.BattleFormulas
local var_0_4 = var_0.Battle.BattleAttr
local var_0_5 = var_0.Battle.BattleConfig
local var_0_6 = var_0.Battle.BattleUnitEvent

class = var_0_10007

local var_0_7 = var_0_10007("BattleBossUnit", var_0.Battle.BattleEnemyUnit)

var_0.Battle.BattleBossUnit = var_0_7
var_0_7.__name = "BattleBossUnit"

function var_0_7.Ctor(arg_1_0, arg_1_1, arg_1_2)
	var_0_7.super.Ctor(arg_1_0, arg_1_1, arg_1_2)

	arg_1_0._isBoss = true

	return
end

function var_0_7.IsBoss(arg_2_0)
	return true
end

function var_0_7.BarrierStateChange(arg_3_0, arg_3_1, arg_3_2)
	local var_3_0 = {
		barrierDurability = arg_3_1,
		barrierDuration = arg_3_2
	}

	arg_3_0:DispatchEvent(var_0.Event.New(var_0_6.BARRIER_STATE_CHANGE, var_3_0))

	return
end

function var_0_7.UpdateHP(arg_4_0, arg_4_1, arg_4_2, arg_4_3, arg_4_4)
	local var_4_0

	if not var_0_7.super.UpdateHP(arg_4_0, arg_4_1, arg_4_2, arg_4_3, arg_4_4) then
		var_4_0 = 0
	end

	if var_4_0 < 0 then
		ipairs = var_6

		for iter_4_0, iter_4_1 in var_6(arg_4_0._autoWeaponList) do
			iter_4_1:UpdatePrecastArmor(var_4_0)
		end
	end

	return var_4_0
end

return
