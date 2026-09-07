local NewDuelResultStatisticsPage = class("NewDuelResultStatisticsPage", import("..NewBattleResultStatisticsPage"))

function NewDuelResultStatisticsPage:UpdatePlayer()
	self.playerName.text = getProxy(PlayerProxy):getRawData():GetName()

	local var_1_0 = getProxy(MilitaryExerciseProxy):getSeasonInfo()
	local var_1_1, var_1_2 = SeasonInfo.getNextMilitaryRank(var_1_0.score, var_1_0.rank)

	self.playerLv.text = SeasonInfo.getMilitaryRank(var_1_0.score, var_1_0.rank).name
	self.playerExpLabel.text = i18n("word_rankScore")

	local function var_1_3()
		self.playerExp.text = "+" .. NewBattleResultUtil.GetSeasonScoreOffset(self.contextData.oldRank, var_1_0)
		self.playerExpBar.fillAmount = var_1_0.score / var_1_2

		return
	end

	if not self.contextData.autoSkipFlag then
		self.duelAniamtion = NewBattleResultDuelAniamtion.New(self.playerExp, self.playerExpBar, var_1_2, self.contextData.oldRank, var_1_0)

		self.duelAniamtion:SetUp(var_1_3)
	else
		var_1_3()
	end

	return
end

function NewDuelResultStatisticsPage:UpdateChapterName()
	local var_3_1 = getProxy(MilitaryExerciseProxy):getPreRivalById(self.contextData.rivalId or 0)

	if var_3_1 then
		self.chapterName.text = var_3_1.name or ""
	end

	setActive(self.opBonus, false)

	return
end

function NewDuelResultStatisticsPage:OnDestroy()
	NewDuelResultStatisticsPage.super.OnDestroy(self)

	if self.duelAniamtion then
		self.duelAniamtion:Dispose()

		self.duelAniamtion = nil
	end

	return
end

return NewDuelResultStatisticsPage
