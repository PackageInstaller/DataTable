local var_0_0 = class("AutoChessShowCardView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Activity_AutoChess_Main/Unpack/Activity_Unpack_SingleDrawUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddListeners()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.choiceController = arg_4_0.controller_:GetController("choice")
	arg_4_0.cardItemList = {}
end

function var_0_0.AddListeners(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.skipBtn_, nil, function()
		arg_5_0:StopTimer()
		JumpTools.OpenPageByJump("autoChessShowCardListPop", {
			mode = arg_5_0.mode_,
			cardList = arg_5_0.cardList_
		})
		OperationRecorder.RecordButtonTouch({
			button_name = "activity_autochess_gacha_skip",
			activity_id = AutoChessData:GetActivityID()
		})
	end)
end

function var_0_0.OnEnter(arg_7_0)
	gameContext:SetUrlAndParams("/autoChessOpenCardMainView")

	arg_7_0.mode_ = arg_7_0.params_.mode
	arg_7_0.cardList_ = arg_7_0.params_.cardList

	if arg_7_0.mode_ == AutoChessCardConst.OPEN_CARD_MODE_SINGLE then
		arg_7_0.choiceController:SetSelectedState("CardPanelSingle")
		arg_7_0:RefreshOneUI()
	else
		arg_7_0.choiceController:SetSelectedState("CardPanelEven")
		arg_7_0:RefreshMoreUI()
	end

	arg_7_0:StopTimer()

	arg_7_0.timer_ = Timer.New(function()
		JumpTools.OpenPageByJump("autoChessShowCardListPop", {
			mode = arg_7_0.mode_,
			cardList = arg_7_0.cardList_
		})
	end, 2, 1)

	arg_7_0.timer_:Start()
end

function var_0_0.RefreshOneUI(arg_9_0)
	for iter_9_0, iter_9_1 in ipairs(arg_9_0.cardList_) do
		if arg_9_0.cardItemList[iter_9_0] then
			arg_9_0.cardItemList[iter_9_0]:SetData(iter_9_1)
		else
			local var_9_0 = AutoChessCardItem.New(arg_9_0.onePanelTrans_:GetChild(iter_9_0 - 1).gameObject)

			var_9_0:SetData(iter_9_1)

			arg_9_0.cardItemList[iter_9_0] = var_9_0
		end
	end
end

function var_0_0.RefreshMoreUI(arg_10_0)
	for iter_10_0, iter_10_1 in ipairs(arg_10_0.cardList_) do
		local var_10_0 = iter_10_0 % 5

		if arg_10_0.cardItemList[iter_10_0] then
			arg_10_0.cardItemList[iter_10_0]:SetData(iter_10_1)
		else
			local var_10_1 = arg_10_0["morePanelTrans" .. var_10_0 + 1 .. "_"]
			local var_10_2 = AutoChessCardItem.New(var_10_1:GetChild(var_10_0).gameObject)

			var_10_2:SetData(iter_10_1)

			arg_10_0.cardItemList[iter_10_0] = var_10_2
		end
	end
end

function var_0_0.OnExit(arg_11_0)
	arg_11_0.anim_:Rebind()
end

function var_0_0.StopTimer(arg_12_0)
	if arg_12_0.timer_ then
		arg_12_0.timer_:Stop()

		arg_12_0.timer_ = nil
	end
end

function var_0_0.Dispose(arg_13_0)
	arg_13_0:StopTimer()

	for iter_13_0, iter_13_1 in ipairs(arg_13_0.cardItemList) do
		iter_13_1:Dispose()
	end

	var_0_0.super.Dispose(arg_13_0)
end

return var_0_0
