ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle.BattleDataFunction
local var_0_2 = var_0.Battle.BattleConfig
local var_0_3 = var_0.Battle.BattleAttr
local var_0_4 = var_0.Battle

class = var_0_10005
var_0_4.BattleBuffSmokeAimBias = var_0_10005("BattleBuffSmokeAimBias", var_0.Battle.BattleBuffEffect)
var_0.Battle.BattleBuffSmokeAimBias.__name = "BattleBuffSmokeAimBias"

local var_0_5 = var_0.Battle.BattleBuffSmokeAimBias
local var_0_6 = var_0.Battle.BattleAttr

var_0_5.ATTR_SMOKE = "smoke_aim_bias"

function var_0_5.Ctor(arg_1_0, arg_1_1)
	var_0_5.super.Ctor(arg_1_0, arg_1_1)

	return
end

function var_0_5.SetArgs(arg_2_0, arg_2_1, arg_2_2)
	return
end

function var_0_5.onAttach(arg_3_0, arg_3_1, arg_3_2)
	var_0_6.SetCurrent(arg_3_1, var_0_5.ATTR_SMOKE, 1)
	var_0_1.AttachSmoke(arg_3_1)

	BATTLE_ENEMY_AIMBIAS_RANGE = var_3

	if var_3 then
		local var_3_0 = var_0.Battle.BattleDataProxy.GetInstance()

		var_3.DispatchEvent(var_3_0, var_0.Event.New(var_0.Battle.BattleEvent.ADD_AIM_BIAS, {
			aimBias = arg_3_1:GetAimBias()
		}))
	end

	return
end

function var_0_5.onUpdate(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	local var_4_0 = {
		[var_0_2.FRIENDLY_CODE] = 0,
		[var_0_2.FOE_CODE] = 0
	}
	local var_4_1 = {
		[var_0_2.FRIENDLY_CODE] = 0,
		[var_0_2.FOE_CODE] = 0
	}
	local var_4_2 = var_0.Battle.BattleDataProxy.GetInstance()
	local var_4_3 = var_6.GetUnitList(var_4_2)

	pairs = var_4_2

	for iter_4_0, iter_4_1 in var_4_2(var_4_3) do
		local var_4_4 = var_4_0[iter_4_1:GetIFF()]
		local var_4_5 = var_0_3.GetCurrent(iter_4_1, "attackRating")
		local var_4_6 = var_0_3.GetCurrent(iter_4_1, "aimBiasExtraACC")

		math = var_16
		var_4_0[var_12] = var_16.max(var_4_4, var_4_5)
		var_4_1[var_12] = var_4_1[var_12] + var_4_6
	end

	local var_4_7 = arg_4_1:GetAimBias()

	var_7.SetDecayFactor(var_4_7, var_4_0[var_0_2.FRIENDLY_CODE], var_4_1[var_0_2.FRIENDLY_CODE])

	local var_4_8 = arg_4_3.timeStamp

	var_7:Update(var_4_8)

	return
end

function var_0_5.onRemove(arg_5_0, arg_5_1, arg_5_2)
	BATTLE_ENEMY_AIMBIAS_RANGE = var_1_10003

	if var_1_10003 then
		local var_5_0 = var_0.Battle.BattleDataProxy.GetInstance()

		var_3.DispatchEvent(var_5_0, var_0.Event.New(var_0.Battle.BattleEvent.REMOVE_AIM_BIAS, {
			aimBias = arg_5_1:GetAimBias()
		}))
	end

	var_0_6.SetCurrent(arg_5_1, var_0_5.ATTR_SMOKE, 0)
	arg_5_1:ExitSmokeArea()

	return
end

return
