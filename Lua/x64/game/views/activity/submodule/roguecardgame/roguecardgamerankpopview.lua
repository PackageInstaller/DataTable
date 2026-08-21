local var_0_0 = class("RogueCardGameRankPopView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Activity_JokerCard/Activity_JokerCard_RankPopUI"
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
end

function var_0_0.OnEnter(arg_6_0)
	arg_6_0.list = arg_6_0.params_.dataList or {}
	arg_6_0.extraInfo = arg_6_0.list.extraInfo

	arg_6_0:Refresh()
end

function var_0_0.Refresh(arg_7_0)
	arg_7_0.diffText_.text = arg_7_0.extraInfo[11]
	arg_7_0.cardIcon_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Activity_JokerCard/itembg/rogue_card_back_" .. arg_7_0.extraInfo[10])

	local var_7_0 = arg_7_0.extraInfo[9] / 100

	arg_7_0.multText_.text = System.String.Format(GetTips("ROGUE_CARD_CALCULATION_POINT_RANK"), var_7_0)
	arg_7_0.scoreText_.text = arg_7_0.list.score

	local var_7_1 = GetI18NText(RogueCardHandTypeCfg[arg_7_0.extraInfo[1]].name)

	arg_7_0.cardTypeText_.text = var_7_1 .. "(" .. arg_7_0.extraInfo[12] .. ")"
	arg_7_0.roundText_.text = arg_7_0.extraInfo[2]
	arg_7_0.roundScoreText_.text = arg_7_0.extraInfo[3]
	arg_7_0.useCardText_.text = arg_7_0.extraInfo[4]
	arg_7_0.depCardText_.text = arg_7_0.extraInfo[5]
	arg_7_0.blackChangeText_.text = arg_7_0.extraInfo[6]
	arg_7_0.whiteChangeText_.text = arg_7_0.extraInfo[7]
	arg_7_0.goldText_.text = arg_7_0.extraInfo[8]
end

function var_0_0.OnExit(arg_8_0)
	return
end

function var_0_0.Dispose(arg_9_0)
	var_0_0.super.Dispose(arg_9_0)
end

return var_0_0
