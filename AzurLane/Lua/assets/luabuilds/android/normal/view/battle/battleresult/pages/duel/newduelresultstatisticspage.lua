class = var_0_10000

local var_0_0 = "NewDuelResultStatisticsPage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("..NewBattleResultStatisticsPage"))

function var_0_1.UpdatePlayer(arg_1_0)
	getProxy = var_1_10001
	PlayerProxy = var_1_10002

	local var_1_0 = var_1_10001(var_1_10002)
	local var_1_1 = var_1.getRawData(var_1_0)
	local var_1_2 = arg_1_0.playerName

	var_1_2.text = var_1_1:GetName()
	getProxy = var_1_2
	MilitaryExerciseProxy = var_3

	local var_1_3 = var_1_2(var_3)
	local var_1_4 = var_2.getSeasonInfo(var_1_3)

	SeasonInfo = var_1_3

	local var_1_5 = var_1_3.getMilitaryRank(var_1_4.score, var_1_4.rank)

	SeasonInfo = var_4

	local var_1_6, var_1_7 = var_4.getNextMilitaryRank(var_1_4.score, var_1_4.rank)

	arg_1_0.playerLv.text = var_1_5.name

	local var_1_8 = arg_1_0.playerExpLabel

	i18n = var_7
	var_1_8.text = var_7("word_rankScore")

	local function var_1_9()
		local var_2_0 = arg_1_0.playerExp
		local var_2_1 = "+"

		NewBattleResultUtil = var_2_10002
		var_2_0.text = var_2_1 .. var_2_10002.GetSeasonScoreOffset(arg_1_0.contextData.oldRank, var_1_4)
		arg_1_0.playerExpBar.fillAmount = var_1_4.score / var_1_7

		return
	end

	if not arg_1_0.contextData.autoSkipFlag then
		NewBattleResultDuelAniamtion = var_7
		arg_1_0.duelAniamtion = var_7.New(arg_1_0.playerExp, arg_1_0.playerExpBar, var_1_7, arg_1_0.contextData.oldRank, var_1_4)

		local var_1_10 = arg_1_0.duelAniamtion

		var_7.SetUp(var_1_10, var_1_9)
	else
		var_1_9()
	end

	return
end

function var_0_1.UpdateChapterName(arg_3_0)
	local var_3_0 = arg_3_0.contextData

	getProxy = var_1_10002
	MilitaryExerciseProxy = var_1_10003

	local var_3_1 = var_1_10002(var_1_10003)
	local var_3_2 = var_2.getPreRivalById
	local var_3_3

	if not var_3_0.rivalId then
		var_3_3 = 0
	end

	local var_3_4

	if not var_3_2(var_3_1, var_3_3) or not var_2.name then
		var_3_4 = ""
	end

	local var_3_5 = arg_3_0.chapterName

	var_3_5.text = var_3_4
	setActive = var_3_5

	var_3_5(arg_3_0.opBonus, false)

	return
end

function var_0_1.OnDestroy(arg_4_0)
	var_0_1.super.OnDestroy(arg_4_0)

	if arg_4_0.duelAniamtion then
		local var_4_0 = arg_4_0.duelAniamtion

		var_1.Dispose(var_4_0)

		arg_4_0.duelAniamtion = nil
	end

	return
end

return var_0_1
