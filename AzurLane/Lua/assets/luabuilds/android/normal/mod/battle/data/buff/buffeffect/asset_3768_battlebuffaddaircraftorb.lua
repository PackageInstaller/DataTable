ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle

class = var_0_10002
var_0_1.BattleBuffAddAircraftOrb = var_0_10002("BattleBuffAddAircraftOrb", var_0.Battle.BattleBuffEffect)
var_0.Battle.BattleBuffAddAircraftOrb.__name = "BattleBuffAddAircraftOrb"

local var_0_2 = var_0.Battle.BattleBuffAddAircraftOrb

function var_0_2.Ctor(arg_1_0, arg_1_1)
	var_0_2.super.Ctor(arg_1_0, arg_1_1)

	return
end

function var_0_2.SetArgs(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0._buffID = arg_2_0._tempData.arg_list.buff_id

	local var_2_0

	if not var_3.rant then
		var_2_0 = 10000
	end

	arg_2_0._rant = var_2_0

	local var_2_1

	if not var_3.level then
		var_2_1 = 1
	end

	arg_2_0._level = var_2_1

	local var_2_2

	if not var_3.buff_level then
		var_2_2 = 1
	end

	arg_2_0._buffLevel = var_2_2

	return
end

function var_0_2.onAircraftCreate(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	if not arg_3_0:equipIndexRequire(arg_3_3.equipIndex) then
		return
	end

	local var_3_0 = {
		buffID = arg_3_0._buffID,
		rant = arg_3_0._rant,
		level = arg_3_0._level,
		buff_level = arg_3_0._buffLevel
	}
	local var_3_1 = arg_3_3.aircraft
	local var_3_2 = var_5.GetWeapon(var_3_1)

	ipairs = var_3_1

	for iter_3_0, iter_3_1 in var_3_1(var_3_2) do
		iter_3_1:SetBulletOrbData(var_3_0)
	end

	return
end

return
