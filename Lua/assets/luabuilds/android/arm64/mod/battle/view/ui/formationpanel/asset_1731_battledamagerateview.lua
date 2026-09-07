ys = ys or {}
ys.Battle.BattleDamageRateView = class("BattleDamageRateView")
ys.Battle.BattleDamageRateView.__name = "BattleDamageRateView"

function ys.Battle.BattleDamageRateView:Ctor(arg_1_1)
	self._go = arg_1_1
	self.tick_bar = arg_1_1.transform:Find("tick_bar"):GetComponent(typeof(Image))
	self.tickBarOb = self.tick_bar.gameObject
	self.tick_bar.fillAmount = 0

	return
end

function ys.Battle.BattleDamageRateView:UpdateScore(arg_2_1, arg_2_2)
	LeanTween.cancel(self.tickBarOb)
	LeanTween.value(self.tickBarOb, self.tick_bar.fillAmount, self:CalScore(arg_2_1, arg_2_2), 0.5):setOnUpdate(System.Action_float(function(arg_3_0)
		self.tick_bar.fillAmount = arg_3_0

		return
	end))

	return
end

function ys.Battle.BattleDamageRateView.CalScore(arg_4_0, arg_4_1, arg_4_2)
	local var_4_0 = {
		"c_score_point",
		"b_score_point",
		"a_score_point",
		"s_score_point",
		"score_max"
	}
	local var_4_1 = {
		0,
		0.445,
		0.7,
		0.88,
		1
	}
	local var_4_2 = 0

	for iter_4_0, iter_4_1 in ipairs(var_4_0) do
		if arg_4_1 < pg.expedition_data_template[arg_4_2][iter_4_1] then
			break
		end

		var_4_2 = iter_4_0
	end

	local var_4_3 = 0

	if var_4_2 < #var_4_0 then
		local var_4_4 = pg.expedition_data_template[arg_4_2][var_4_0[var_4_2]]

		if pg.expedition_data_template[arg_4_2][var_4_0[var_4_2]] < 0 then
			var_4_4 = 0
		end

		var_4_3 = (var_4_1[var_4_2 + 1] - var_4_1[var_4_2]) * ((arg_4_1 - var_4_4) / (pg.expedition_data_template[arg_4_2][var_4_0[var_4_2 + 1]] - var_4_4)) + var_4_1[var_4_2]
	else
		var_4_3 = 1
	end

	return var_4_3
end

function ys.Battle.BattleDamageRateView:Dispose()
	LeanTween.cancel(self.tickBarOb)

	return
end

return
