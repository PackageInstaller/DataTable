local var_0_0 = class("NewDuelResultStatisticsPage", import("..NewBattleResultStatisticsPage"))

function var_0_0.UpdatePlayer(arg_1_0)
	arg_1_0.playerName.text = getProxy(PlayerProxy):getRawData():GetName()

	local var_1_0 = getProxy(MilitaryExerciseProxy):getSeasonInfo()
	local var_1_1, var_1_2 = SeasonInfo.getNextMilitaryRank(var_1_0.score, var_1_0.rank)

	arg_1_0.playerLv.text = SeasonInfo.getMilitaryRank(var_1_0.score, var_1_0.rank).name
	arg_1_0.playerExpLabel.text = i18n("word_rankScore")

	if not arg_1_0.contextData.autoSkipFlag then
		arg_1_0.duelAniamtion = NewBattleResultDuelAniamtion.New(arg_1_0.playerExp, arg_1_0.playerExpBar, var_1_2, arg_1_0.contextData.oldRank, var_1_0)

		arg_1_0.duelAniamtion:SetUp(function()
			arg_1_0.playerExp.text = "+" .. NewBattleResultUtil.GetSeasonScoreOffset(arg_1_0.contextData.oldRank, var_1_0)
			arg_1_0.playerExpBar.fillAmount = var_1_0.score / var_1_2

			return
		end)
	else
		(function()
			arg_1_0.playerExp.text = "+" .. NewBattleResultUtil.GetSeasonScoreOffset(arg_1_0.contextData.oldRank, var_1_0)
			arg_1_0.playerExpBar.fillAmount = var_1_0.score / var_1_2

			return
		end)()
	end

	return
end

function var_0_0.UpdateChapterName(arg_3_0)
	local var_3_0 = arg_3_0.contextData.rivalId or 0
	local var_3_1 = getProxy(MilitaryExerciseProxy):getPreRivalById(var_3_0)

	if var_3_1 then
		arg_3_0.chapterName.text = var_3_1.name or ""

		setActive(arg_3_0.opBonus, false)

		return
	end
end

function var_0_0.OnDestroy(arg_4_0)
	var_0_0.super.OnDestroy(arg_4_0)

	if arg_4_0.duelAniamtion then
		arg_4_0.duelAniamtion:Dispose()

		arg_4_0.duelAniamtion = nil
	end

	return
end

return var_0_0
