ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle

class = var_0_10002
var_0_1.BattleDamageRateView = var_0_10002("BattleDamageRateView")
var_0.Battle.BattleDamageRateView.__name = "BattleDamageRateView"

function var_0.Battle.BattleDamageRateView.Ctor(arg_1_0, arg_1_1)
	arg_1_0._go = arg_1_1

	local var_1_0 = arg_1_1.transform
	local var_1_1 = var_2.Find(var_1_0, "tick_bar")
	local var_1_2 = var_2.GetComponent

	typeof = var_4
	Image = var_1_10005
	arg_1_0.tick_bar = var_1_2(var_1_1, var_4(var_1_10005))
	arg_1_0.tickBarOb = arg_1_0.tick_bar.gameObject
	arg_1_0.tick_bar.fillAmount = 0

	return
end

function var_0.Battle.BattleDamageRateView.UpdateScore(arg_2_0, arg_2_1, arg_2_2)
	local var_2_0 = arg_2_0
	local var_2_1 = arg_2_0.CalScore(var_2_0, arg_2_1, arg_2_2)

	LeanTween = var_2_0

	var_2_0.cancel(arg_2_0.tickBarOb)

	LeanTween = var_4

	local var_2_2 = var_4.value(arg_2_0.tickBarOb, arg_2_0.tick_bar.fillAmount, var_2_1, 0.5)
	local var_2_3 = var_4.setOnUpdate

	System = var_6

	var_2_3(var_2_2, var_6.Action_float(function(arg_3_0)
		arg_2_0.tick_bar.fillAmount = arg_3_0

		return
	end))

	return
end

function var_0.Battle.BattleDamageRateView.CalScore(arg_4_0, arg_4_1, arg_4_2)
	pg = var_1_10003

	local var_4_0 = var_1_10003.expedition_data_template[arg_4_2]
	local var_4_1 = {
		"c_score_point",
		"b_score_point",
		"a_score_point",
		"s_score_point",
		"score_max"
	}
	local var_4_2 = {
		0,
		0.445,
		0.7,
		0.88,
		1
	}
	local var_4_3 = 0

	ipairs = var_1_10007

	for iter_4_0, iter_4_1 in var_1_10007(var_4_1) do
		if arg_4_1 < var_4_0[iter_4_1] then
			break
		end

		var_4_3 = iter_4_0
	end

	local var_4_4 = 0

	if var_4_3 < #var_4_1 then
		local var_4_5

		if var_4_0[var_4_1[var_4_3]] < 0 then
			var_4_5 = 0
		end

		local var_4_6 = (arg_4_1 - var_4_5) / (var_4_0[var_4_1[var_4_3 + 1]] - var_4_5)

		var_4_4 = (var_4_2[var_4_3 + 1] - var_4_2[var_4_3]) * var_4_6 + var_4_2[var_4_3]
	else
		var_4_4 = 1
	end

	return var_4_4
end

function var_0.Battle.BattleDamageRateView.Dispose(arg_5_0)
	LeanTween = var_1_10001

	var_1_10001.cancel(arg_5_0.tickBarOb)

	return
end

return
