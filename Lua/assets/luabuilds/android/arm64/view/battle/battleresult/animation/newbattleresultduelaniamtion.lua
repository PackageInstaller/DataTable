local var_0_0 = class("NewBattleResultDuelAniamtion")

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4, arg_1_5)
	arg_1_0.playerExp = arg_1_1
	arg_1_0.playerExpBar = arg_1_2
	arg_1_0.nextPoint = arg_1_3
	arg_1_0.oldRank = arg_1_4
	arg_1_0.season = arg_1_5

	return
end

function var_0_0.SetUp(arg_2_0, arg_2_1)
	parallelAsync({
		function(arg_3_0)
			arg_2_0:ScoreAnimation(arg_3_0)

			return
		end,
		function(arg_4_0)
			arg_2_0:ScoreBarAnimation(arg_4_0)

			return
		end
	}, arg_2_1)

	return
end

function var_0_0.ScoreAnimation(arg_5_0, arg_5_1)
	LeanTween.value(arg_5_0.playerExp.gameObject, 0, NewBattleResultUtil.GetSeasonScoreOffset(arg_5_0.oldRank, arg_5_0.season), 1.5):setOnUpdate(System.Action_float(function(arg_6_0)
		arg_5_0.playerExp.text = "+" .. math.ceil(arg_6_0)

		return
	end)):setOnComplete(System.Action(arg_5_1))

	return
end

function var_0_0.ScoreBarAnimation(arg_7_0, arg_7_1)
	LeanTween.value(arg_7_0.playerExpBar.gameObject, 0, arg_7_0.season.score / arg_7_0.nextPoint, 1.5):setOnUpdate(System.Action_float(function(arg_8_0)
		arg_7_0.playerExpBar.fillAmount = arg_8_0

		return
	end)):setOnComplete(System.Action(arg_7_1))

	return
end

function var_0_0.Dispose(arg_9_0)
	if LeanTween.isTweening(arg_9_0.playerExp.gameObject) then
		LeanTween.cancel(arg_9_0.playerExp.gameObject)
	end

	if LeanTween.isTweening(arg_9_0.playerExpBar.gameObject) then
		LeanTween.cancel(arg_9_0.playerExpBar.gameObject)
	end

	return
end

return var_0_0
