local var_0_0 = class("AutoChessDesireCurSceceView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Activity_AutoChess_Main/TradingCard/Activity_AutoChess_WishCutsceneUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddListeners()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.getCard_ = AutoChessCardItem.New(arg_4_0.getCardGo_)
	arg_4_0.loseCard_ = AutoChessCardItem.New(arg_4_0.loseCardGo_)
	arg_4_0.URFactoryItem_ = AutoChessURFactoryItem.New(arg_4_0.URItemGo_)
end

function var_0_0.AddListeners(arg_5_0)
	return
end

function var_0_0.OnEnter(arg_6_0)
	arg_6_0.index_ = arg_6_0.params_.index
	arg_6_0.mode_ = arg_6_0.params_.mode

	if arg_6_0.mode_ == AutoChessCardConst.DESIRE_TYPE.FRIEND then
		local var_6_0 = AutoChessCardData:GetFriendDesire(arg_6_0.index_)
		local var_6_1 = var_6_0.CompleteDesireUser.SelectCardId

		arg_6_0.getCard_:SetData(var_6_1, arg_6_0.URFactoryItem_:GetItem(var_6_1))
		arg_6_0.loseCard_:SetData(var_6_0.CardID, arg_6_0.URFactoryItem_:GetItem(var_6_0.CardID))
	elseif arg_6_0.mode_ == AutoChessCardConst.DESIRE_TYPE.CHAT then
		local var_6_2 = AutoChessCardData:GetChatDesire()
		local var_6_3 = var_6_2.CompleteDesireUser.SelectCardId

		arg_6_0.getCard_:SetData(var_6_3, arg_6_0.URFactoryItem_:GetItem(var_6_3))
		arg_6_0.loseCard_:SetData(var_6_2.CardID, arg_6_0.URFactoryItem_:GetItem(var_6_2.CardID))
	elseif arg_6_0.mode_ == AutoChessCardConst.DESIRE_TYPE.MY then
		local var_6_4 = AutoChessCardData:GetDesireInfo()
		local var_6_5 = var_6_4.CompleteDesireUser.SelectCardId

		arg_6_0.getCard_:SetData(var_6_4.CardID, arg_6_0.URFactoryItem_:GetItem(var_6_4.CardID))
		arg_6_0.loseCard_:SetData(var_6_5, arg_6_0.URFactoryItem_:GetItem(var_6_5))
	else
		local var_6_6 = AutoChessCardData:GetOtherDesire(arg_6_0.index_)
		local var_6_7 = var_6_6.CompleteDesireUser.SelectCardId

		arg_6_0.getCard_:SetData(var_6_7, arg_6_0.URFactoryItem_:GetItem(var_6_7))
		arg_6_0.loseCard_:SetData(var_6_6.CardID, arg_6_0.URFactoryItem_:GetItem(var_6_6.CardID))
	end

	arg_6_0:StopTimer()

	arg_6_0.timer_ = Timer.New(function()
		arg_6_0:Back()
		JumpTools.OpenPageByJump("autoChessDesireCompletePop", {
			mode = arg_6_0.mode_,
			index = arg_6_0.index_,
			rewardList = arg_6_0.params_.rewardList
		})
	end, 2, 1)

	arg_6_0.timer_:Start()
end

function var_0_0.StopTimer(arg_8_0)
	if arg_8_0.timer_ then
		arg_8_0.timer_:Stop()

		arg_8_0.timer_ = nil
	end
end

function var_0_0.OnTop(arg_9_0)
	manager.windowBar:HideBar()
end

function var_0_0.Dispose(arg_10_0)
	if arg_10_0.timer_ then
		arg_10_0.timer_:Stop()

		arg_10_0.timer_ = nil
	end

	arg_10_0.getCard_:Dispose()
	arg_10_0.loseCard_:Dispose()
	arg_10_0.URFactoryItem_:Dispose()
	var_0_0.super.Dispose(arg_10_0)
end

return var_0_0
