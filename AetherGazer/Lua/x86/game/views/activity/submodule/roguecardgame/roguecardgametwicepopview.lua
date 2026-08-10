local var_0_0 = class("RogueCardGameTwicePopView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Activity_JokerCard/Activity_JokerCard_TwicePopUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListener()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.tipsCon_ = arg_4_0.controllerEx_:GetController("tips")
	arg_4_0.singleCon_ = arg_4_0.controllerEx_:GetController("single")
	arg_4_0.typeCon_ = arg_4_0.controllerEx_:GetController("type")
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.maskBtn_, nil, function()
		arg_5_0:Back()
	end)
	arg_5_0:AddBtnListener(arg_5_0.okBtn_, nil, function()
		arg_5_0:Back()

		if RogueCard.RogueCardGameMain.Instance:CheckShowPause() then
			local var_7_0 = RogueCardGameTools.GetCurPostingId()

			RogueCardGameAction.InGameInterruptPost(var_7_0)
		else
			RogueCard.RogueCardGameMain.Instance:ConfirmGame()
		end
	end)
	arg_5_0:AddBtnListener(arg_5_0.cancelBtn_, nil, function()
		arg_5_0:Back()
	end)
	arg_5_0:AddBtnListener(arg_5_0.interruptBtn_, nil, function()
		local var_9_0 = RogueCardGameTools.GetCurPostingId()

		if RogueCardPostingCfg[var_9_0].type == 1 then
			RogueCardGameBridge.FinishRogueCardGame(function()
				OpenPageUntilLoaded("/rogueCardGameForumView", {
					isTips = true
				})
			end)
		else
			RogueCardGameBridge.FinishRogueCardGame(function()
				OpenPageUntilLoaded("/rogueCardGameChallengeSelectView")
			end)
		end
	end)
end

function var_0_0.OnEnter(arg_12_0)
	arg_12_0.tipContent_.text = GetTips("ROGUE_CARD_TERMINATE_INVESTIGATION")

	if RogueCardGameBridge.InGame() and RogueCard.RogueCardGameMain.Instance:CheckShowPause() then
		arg_12_0.singleCon_:SetSelectedIndex(0)
	else
		arg_12_0.singleCon_:SetSelectedIndex(1)
	end
end

function var_0_0.OnExit(arg_13_0)
	arg_13_0:RemoveAllEventListener()
end

function var_0_0.Dispose(arg_14_0)
	arg_14_0:RemoveAllEventListener()
	var_0_0.super.Dispose(arg_14_0)
end

return var_0_0
