ys = ys or {}
ys.Battle.BattleDamageRateView = class("BattleDamageRateView")
ys.Battle.BattleDamageRateView.__name = "BattleDamageRateView"

function ys.Battle.BattleDamageRateView.Ctor(arg_1_0, arg_1_1)
	arg_1_0._go = arg_1_1
	arg_1_0.tick_bar = arg_1_1.transform:Find("tick_bar"):GetComponent(typeof(Image))
	arg_1_0.tickBarOb = arg_1_0.tick_bar.gameObject
	arg_1_0.tick_bar.fillAmount = 0

	return
end

function ys.Battle.BattleDamageRateView.UpdateScore(arg_2_0, arg_2_1, arg_2_2)
	LeanTween.cancel(arg_2_0.tickBarOb)
	LeanTween.value(arg_2_0.tickBarOb, arg_2_0.tick_bar.fillAmount, arg_2_0:CalScore(arg_2_1, arg_2_2), 0.5):setOnUpdate(System.Action_float(function(arg_3_0)
		arg_2_0.tick_bar.fillAmount = arg_3_0

		return
	end))

	return
end

function ys.Battle.BattleDamageRateView.CalScore(arg_4_0, arg_4_1, arg_4_2)
	local var_4_0 = 0

	for iter_4_0, iter_4_1 in ipairs({
		"c_score_point",
		"b_score_point",
		"a_score_point",
		"s_score_point",
		"score_max"
	}) do
		if arg_4_1 < pg.expedition_data_template[arg_4_2][iter_4_1] then
			break
		end

		var_4_0 = iter_4_0
	end

	local var_4_1 = 0

	if var_4_0 < #{
		"c_score_point",
		"b_score_point",
		"a_score_point",
		"s_score_point",
		"score_max"
	} then
		local var_4_2 = pg.expedition_data_template[arg_4_2][({
			"c_score_point",
			"b_score_point",
			"a_score_point",
			"s_score_point",
			"score_max"
		})[var_4_0]]

		if pg.expedition_data_template[arg_4_2][({
			"c_score_point",
			"b_score_point",
			"a_score_point",
			"s_score_point",
			"score_max"
		})[var_4_0]] < 0 then
			var_4_2 = 0
		end

		var_4_1 = (({
			0,
			0.445,
			0.7,
			0.88,
			1
		})[var_4_0 + 1] - ({
			0,
			0.445,
			0.7,
			0.88,
			1
		})[var_4_0]) * ((arg_4_1 - var_4_2) / (pg.expedition_data_template[arg_4_2][({
			"c_score_point",
			"b_score_point",
			"a_score_point",
			"s_score_point",
			"score_max"
		})[var_4_0 + 1]] - var_4_2)) + ({
			0,
			0.445,
			0.7,
			0.88,
			1
		})[var_4_0]
	else
		var_4_1 = 1
	end

	return var_4_1
end

function ys.Battle.BattleDamageRateView.Dispose(arg_5_0)
	LeanTween.cancel(arg_5_0.tickBarOb)

	return
end

return
