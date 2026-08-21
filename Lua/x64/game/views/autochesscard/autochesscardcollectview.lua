local var_0_0 = class("AutoChessCardCollectView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Activity_AutoChess_Main/Illustrated/Activity_collect_IllustratedDetailUI"
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

	arg_4_0.tabStateController_ = arg_4_0.controller_:GetController("tabState")
	arg_4_0.cardUiList_ = LuaList.New(handler(arg_4_0, arg_4_0.IndexItem), arg_4_0.uiList_, AutoChessCardCollectItem)
	arg_4_0.URFactoryItem_ = AutoChessURFactoryItem.New(arg_4_0.URItemGo_)
end

function var_0_0.IndexItem(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = arg_5_0.cardIdList_[arg_5_1]

	arg_5_2:SetData(var_5_0, arg_5_1, arg_5_0.URFactoryItem_:GetItem(var_5_0))
	arg_5_2:SetSelectHandler(handler(arg_5_0, arg_5_0.OnSelectCard))
end

function var_0_0.AddListeners(arg_6_0)
	arg_6_0:AddBtnListener(arg_6_0.rBtn_, nil, function()
		if arg_6_0.cardType_ == AutoChessCardConst.CARD_TYPE.R then
			return
		end

		arg_6_0.cardType_ = AutoChessCardConst.CARD_TYPE.R

		arg_6_0:RefreshUI()
	end)
	arg_6_0:AddBtnListener(arg_6_0.sRBtn_, nil, function()
		if arg_6_0.cardType_ == AutoChessCardConst.CARD_TYPE.SR then
			return
		end

		arg_6_0.cardType_ = AutoChessCardConst.CARD_TYPE.SR

		arg_6_0:RefreshUI()
	end)
	arg_6_0:AddBtnListener(arg_6_0.uRBtn_, nil, function()
		if arg_6_0.cardType_ == AutoChessCardConst.CARD_TYPE.UR then
			return
		end

		arg_6_0.cardType_ = AutoChessCardConst.CARD_TYPE.UR

		arg_6_0:RefreshUI()
	end)
end

function var_0_0.OnEnter(arg_10_0)
	arg_10_0.cardType_ = getData("autoChessCard", "collectPage") or AutoChessCardConst.CARD_TYPE.UR

	arg_10_0:RefreshUI()

	local var_10_0 = #AutoChessCardCfg.get_id_list_by_is_card_pool[1]
	local var_10_1 = AutoChessCardData:GetCardList()
	local var_10_2 = 0

	for iter_10_0, iter_10_1 in pairs(var_10_1) do
		if iter_10_1 > 0 then
			var_10_2 = var_10_2 + 1
		end
	end

	arg_10_0.txtCollect_.text = string.format("%d/%d", var_10_2, var_10_0)
end

function var_0_0.OnTop(arg_11_0)
	manager.windowBar:SwitchBar({
		HOME_BAR,
		BACK_BAR
	})
end

function var_0_0.OnExit(arg_12_0)
	manager.windowBar:HideBar()
end

function var_0_0.RefreshUI(arg_13_0)
	saveData("autoChessCard", "collectPage", arg_13_0.cardType_)

	arg_13_0.txtUR_.text = GetTips(AutoChessCardConst.CARD_TYPE_TIPS[AutoChessCardConst.CARD_TYPE.UR])
	arg_13_0.txtSR_.text = GetTips(AutoChessCardConst.CARD_TYPE_TIPS[AutoChessCardConst.CARD_TYPE.SR])
	arg_13_0.txtR_.text = GetTips(AutoChessCardConst.CARD_TYPE_TIPS[AutoChessCardConst.CARD_TYPE.R])

	arg_13_0.tabStateController_:SetSelectedIndex(tostring(arg_13_0.cardType_ - 1))

	arg_13_0.cardIdList_ = AutoChessCardCfg.get_id_list_by_type_is_card_pool[arg_13_0.cardType_][1]

	local var_13_0 = getData("autoChessCard", "collectCard_" .. arg_13_0.cardType_) or 0

	arg_13_0.cardUiList_:StartScroll(#arg_13_0.cardIdList_, var_13_0)
end

function var_0_0.OnSelectCard(arg_14_0, arg_14_1, arg_14_2)
	saveData("autoChessCard", "collectCard_" .. arg_14_0.cardType_, arg_14_2)
	JumpTools.OpenPageByJump("/autoChessCardDetailView", {
		cardId = arg_14_1
	})
	OperationRecorder.RecordButtonTouch({
		button_name = "activity_autochess_collect_item_touch",
		type = 4,
		activity_id = AutoChessData:GetActivityID(),
		item_id = arg_14_1
	})
	OperationRecorder.RecordButtonTouch({
		source = 2,
		button_name = "activity_autochess_item_homepage_touch",
		activity_id = AutoChessData:GetActivityID(),
		item_id = arg_14_1
	})
end

function var_0_0.Dispose(arg_15_0)
	if arg_15_0.cardUiList_ then
		arg_15_0.cardUiList_:Dispose()

		arg_15_0.cardUiList_ = nil
	end

	arg_15_0.URFactoryItem_:Dispose()
	var_0_0.super.Dispose(arg_15_0)
end

return var_0_0
