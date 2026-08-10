local var_0_0 = class("RogueCardGameChallengeSettleView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Activity_JokerCard/Activity_JokerCard_ChallengeSettle"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:BindCfgUI()
	arg_3_0:AddUIListener()
end

function var_0_0.AddUIListener(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.bgBtn_, nil, function()
		arg_4_0:Back()
	end)
	arg_4_0:AddBtnListener(arg_4_0.okBtn_, nil, function()
		arg_4_0:Back()
	end)
end

function var_0_0.OnEnter(arg_7_0)
	arg_7_0.deck = arg_7_0.params_.deck
	arg_7_0.diff = arg_7_0.params_.diff
	arg_7_0.settle_data = RogueCardGameData:GetSettleData()

	arg_7_0:Refresh()

	if arg_7_0.params_.enterAction then
		arg_7_0.params_.enterAction()
	end
end

function var_0_0.Refresh(arg_8_0)
	arg_8_0.topTitleText_.text = GetTips("ROGUE_CARD_COMMUNICATION_LOCK_TITLE")
	arg_8_0.titleText_.text = GetTips("ROGUE_CARD_LOSE_TITLE_EX")
	arg_8_0.diffText_.text = System.String.Format(GetTips("ROGUE_CARD_DIFFICULT"), arg_8_0.diff)
	arg_8_0.cardIcon_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Activity_JokerCard/itembg/rogue_card_back_" .. arg_8_0.diff)

	local var_8_0 = RogueCardDeckCfg[arg_8_0.deck].score_rate * RogueCardDifficultyCfg[arg_8_0.diff].score_rate / 100

	arg_8_0.multText_.text = System.String.Format(GetTips("ROGUE_CARD_CALCULATION_POINT_RANK"), var_8_0)
	arg_8_0.scoreText_.text = arg_8_0.settle_data.score

	local var_8_1 = arg_8_0.settle_data.most_hand_type
	local var_8_2 = 0

	if var_8_1 > 0 then
		local var_8_3 = GetI18NText(RogueCardHandTypeCfg[var_8_1].name)
		local var_8_4 = #arg_8_0.settle_data.hand_type_use_num - var_8_1 + 1
		local var_8_5 = arg_8_0.settle_data.hand_type_use_num[var_8_4]

		arg_8_0.cardTypeText_.text = var_8_3 .. "(" .. var_8_5 .. ")"
	else
		arg_8_0.cardTypeText_.text = 0
	end

	arg_8_0.roundText_.text = arg_8_0.settle_data.round
	arg_8_0.roundScoreText_.text = arg_8_0.settle_data.max_score
	arg_8_0.useCardText_.text = arg_8_0.settle_data.use_card_num
	arg_8_0.depCardText_.text = arg_8_0.settle_data.discard_num
	arg_8_0.blackChangeText_.text = arg_8_0.settle_data.black_wu_chang_num
	arg_8_0.whiteChangeText_.text = arg_8_0.settle_data.white_wu_chang_num
	arg_8_0.goldText_.text = arg_8_0.settle_data.gain_gold_num
end

function var_0_0.OnExit(arg_9_0)
	return
end

function var_0_0.Dispose(arg_10_0)
	var_0_0.super.Dispose(arg_10_0)
end

return var_0_0
