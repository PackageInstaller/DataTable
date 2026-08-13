class = var_0_10000

local var_0_0 = var_0_10000("NewBattleResultDuelAniamtion")

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4, arg_1_5)
	arg_1_0.playerExp = arg_1_1
	arg_1_0.playerExpBar = arg_1_2
	arg_1_0.nextPoint = arg_1_3
	arg_1_0.oldRank = arg_1_4
	arg_1_0.season = arg_1_5

	return
end

function var_0_0.SetUp(arg_2_0, arg_2_1)
	parallelAsync = var_1_10002

	var_1_10002({
		function(arg_3_0)
			local var_3_0 = arg_2_0

			var_1.ScoreAnimation(var_3_0, arg_3_0)

			return
		end,
		function(arg_4_0)
			local var_4_0 = arg_2_0

			var_1.ScoreBarAnimation(var_4_0, arg_4_0)

			return
		end
	}, arg_2_1)

	return
end

function var_0_0.ScoreAnimation(arg_5_0, arg_5_1)
	NewBattleResultUtil = var_1_10002

	local var_5_0 = var_1_10002.GetSeasonScoreOffset(arg_5_0.oldRank, arg_5_0.season)

	LeanTween = var_3

	local var_5_1 = var_3.value(arg_5_0.playerExp.gameObject, 0, var_5_0, 1.5)
	local var_5_2 = var_3.setOnUpdate

	System = var_5

	local var_5_3 = var_5_2(var_5_1, var_5.Action_float(function(arg_6_0)
		local var_6_0 = arg_5_0.playerExp
		local var_6_1 = "+"

		math = var_2_10003
		var_6_0.text = var_6_1 .. var_2_10003.ceil(arg_6_0)

		return
	end))
	local var_5_4 = var_3.setOnComplete

	System = var_5

	var_5_4(var_5_3, var_5.Action(arg_5_1))

	return
end

function var_0_0.ScoreBarAnimation(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_0.season.score / arg_7_0.nextPoint

	LeanTween = var_3

	local var_7_1 = var_3.value(arg_7_0.playerExpBar.gameObject, 0, var_7_0, 1.5)
	local var_7_2 = var_3.setOnUpdate

	System = var_5

	local var_7_3 = var_7_2(var_7_1, var_5.Action_float(function(arg_8_0)
		arg_7_0.playerExpBar.fillAmount = arg_8_0

		return
	end))
	local var_7_4 = var_3.setOnComplete

	System = var_5

	var_7_4(var_7_3, var_5.Action(arg_7_1))

	return
end

function var_0_0.Dispose(arg_9_0)
	LeanTween = var_1_10001

	if var_1_10001.isTweening(arg_9_0.playerExp.gameObject) then
		LeanTween = var_1

		var_1.cancel(arg_9_0.playerExp.gameObject)
	end

	LeanTween = var_1

	if var_1.isTweening(arg_9_0.playerExpBar.gameObject) then
		LeanTween = var_1

		var_1.cancel(arg_9_0.playerExpBar.gameObject)
	end

	return
end

return var_0_0
