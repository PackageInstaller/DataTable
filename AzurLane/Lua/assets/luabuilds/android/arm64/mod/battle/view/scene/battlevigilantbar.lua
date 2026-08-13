ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle

class = var_0_10002
var_0_1.BattleVigilantBar = var_0_10002("BattleVigilantBar")
var_0.Battle.BattleVigilantBar.__name = "BattleVigilantBar"

local var_0_2 = var_0.Battle.BattleVigilantBar

var_0_2.MIN = 0.267
var_0_2.MAX = 0.7335
var_0_2.METER_LENGTH = var_0_2.MAX - var_0_2.MIN
var_0_2.STATE_CALM = 0
var_0_2.STATE_SUSPICIOUS = 1
var_0_2.STATE_VIGILANT = 2
var_0_2.STATE_ENGAGE = 3

function var_0_2.Ctor(arg_1_0, arg_1_1)
	arg_1_0._vigilantBar = arg_1_1
	arg_1_0._vigilantBarGO = arg_1_0._vigilantBar.gameObject

	local var_1_0 = arg_1_0._vigilantBar
	local var_1_1 = var_2.Find(var_1_0, "progress")
	local var_1_2 = var_2.GetComponent

	typeof = var_5
	Image = var_1_10007
	arg_1_0._progress = var_1_2(var_1_1, var_5(var_1_10007))
	arg_1_0._markList = {}

	local var_1_3 = arg_1_0._markList
	local var_1_4 = var_0_2.STATE_CALM
	local var_1_5 = arg_1_0._vigilantBar

	var_1_3[var_1_4] = var_4.Find(var_1_5, "mark/" .. var_0_2.STATE_CALM)

	local var_1_6 = arg_1_0._markList
	local var_1_7 = var_0_2.STATE_SUSPICIOUS
	local var_1_8 = arg_1_0._vigilantBar

	var_1_6[var_1_7] = var_4.Find(var_1_8, "mark/" .. var_0_2.STATE_SUSPICIOUS)

	local var_1_9 = arg_1_0._markList
	local var_1_10 = var_0_2.STATE_VIGILANT
	local var_1_11 = arg_1_0._vigilantBar

	var_1_9[var_1_10] = var_4.Find(var_1_11, "mark/" .. var_0_2.STATE_VIGILANT)

	local var_1_12 = arg_1_0._markList
	local var_1_13 = var_0_2.STATE_ENGAGE
	local var_1_14 = arg_1_0._vigilantBar

	var_1_12[var_1_13] = var_4.Find(var_1_14, "mark/" .. var_0_2.STATE_ENGAGE)

	return
end

function var_0_2.ConfigVigilant(arg_2_0, arg_2_1)
	arg_2_0._vigilantState = arg_2_1

	return
end

function var_0_2.UpdateVigilantProgress(arg_3_0)
	local var_3_0 = arg_3_0._vigilantState
	local var_3_1 = var_1.GetVigilantRate(var_3_0)

	arg_3_0._progress.fillAmount = arg_3_0.meterConvert(var_3_1)

	return
end

function var_0_2.UpdateVigilantMark(arg_4_0)
	local var_4_0 = arg_4_0._vigilantState
	local var_4_1 = var_1.GetVigilantMark(var_4_0)

	ipairs = var_1_10002

	for iter_4_0, iter_4_1 in var_1_10002(arg_4_0._markList) do
		SetActive = var_1_10007

		var_1_10007(iter_4_1, var_4_1 == iter_4_0)
	end

	return
end

function var_0_2.UpdateVigilantBarPosition(arg_5_0, arg_5_1)
	arg_5_0._vigilantBar.position = arg_5_1

	return
end

function var_0_2.meterConvert(arg_6_0)
	return var_0_2.METER_LENGTH * arg_6_0 + var_0_2.MIN
end

function var_0_2.Dispose(arg_7_0)
	arg_7_0._vigilantState = nil
	Object = var_1

	var_1.Destroy(arg_7_0._vigilantBarGO)

	arg_7_0._vigilantBar = nil
	arg_7_0._vigilantBarGO = nil
	arg_7_0._markList = nil
	arg_7_0._progress = nil

	return
end

return
