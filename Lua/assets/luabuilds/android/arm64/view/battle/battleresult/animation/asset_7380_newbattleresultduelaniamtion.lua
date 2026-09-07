local NewBattleResultDuelAniamtion = class("NewBattleResultDuelAniamtion")

function NewBattleResultDuelAniamtion:Ctor(arg_1_1, arg_1_2, arg_1_3, arg_1_4, arg_1_5)
	self.playerExp = arg_1_1
	self.playerExpBar = arg_1_2
	self.nextPoint = arg_1_3
	self.oldRank = arg_1_4
	self.season = arg_1_5

	return
end

function NewBattleResultDuelAniamtion:SetUp(arg_2_1)
	parallelAsync({
		function(arg_3_0)
			self:ScoreAnimation(arg_3_0)

			return
		end,
		function(arg_4_0)
			self:ScoreBarAnimation(arg_4_0)

			return
		end
	}, arg_2_1)

	return
end

function NewBattleResultDuelAniamtion:ScoreAnimation(arg_5_1)
	LeanTween.value(self.playerExp.gameObject, 0, NewBattleResultUtil.GetSeasonScoreOffset(self.oldRank, self.season), 1.5):setOnUpdate(System.Action_float(function(arg_6_0)
		self.playerExp.text = "+" .. math.ceil(arg_6_0)

		return
	end)):setOnComplete(System.Action(arg_5_1))

	return
end

function NewBattleResultDuelAniamtion:ScoreBarAnimation(arg_7_1)
	LeanTween.value(self.playerExpBar.gameObject, 0, self.season.score / self.nextPoint, 1.5):setOnUpdate(System.Action_float(function(arg_8_0)
		self.playerExpBar.fillAmount = arg_8_0

		return
	end)):setOnComplete(System.Action(arg_7_1))

	return
end

function NewBattleResultDuelAniamtion:Dispose()
	if LeanTween.isTweening(self.playerExp.gameObject) then
		LeanTween.cancel(self.playerExp.gameObject)
	end

	if LeanTween.isTweening(self.playerExpBar.gameObject) then
		LeanTween.cancel(self.playerExpBar.gameObject)
	end

	return
end

return NewBattleResultDuelAniamtion
