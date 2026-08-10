local var_0_0 = class("AutoChessOpenCardMainView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Activity_AutoChess_Main/Unpack/Activity_Unpack_MainUI"
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

	arg_4_0.ultraRareItem = AutoChessCardCollectInfoItem.New(arg_4_0.ultraRareGo_, AutoChessCardConst.CARD_TYPE.UR)
	arg_4_0.supRareItem = AutoChessCardCollectInfoItem.New(arg_4_0.superRareGo_, AutoChessCardConst.CARD_TYPE.SR)
	arg_4_0.normRareItem = AutoChessCardCollectInfoItem.New(arg_4_0.RareGo_, AutoChessCardConst.CARD_TYPE.R)
	arg_4_0.item1_ = AutoChessOpenCardItem.New(arg_4_0.itemGo1_)
	arg_4_0.item2_ = AutoChessOpenCardItem.New(arg_4_0.itemGo2_)
	arg_4_0.tipsController_ = arg_4_0.controller_:GetController("obtainTips")
end

function var_0_0.AddListeners(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.lookDetailBtn_, nil, function()
		arg_5_0.tipsController_:SetSelectedState("hide")
		JumpTools.OpenPageByJump("autoChessOpenCardInfoPopView")
		OperationRecorder.RecordButtonTouch({
			button_name = "activity_autochess_gacha_rules",
			activity_id = AutoChessData:GetActivityID()
		})
	end)
	arg_5_0:AddBtnListener(arg_5_0.openOneBtn_, nil, function()
		if ItemTools.getItemNum(CurrencyConst.CURRENCY_TYPE_AUTO_CHESS_CARD_ITEM) < 1 then
			ShowTips(GetTips("AUTO_CHESS_2_INSUFFICIENT_PACK"))

			return
		end

		if arg_5_0.IsOpen then
			return
		end

		arg_5_0.IsOpen = true

		arg_5_0:OnPlayAnimBack(AutoChessCardConst.OPEN_CARD_MODE_SINGLE)
	end)
	arg_5_0:AddBtnListener(arg_5_0.opemMoreBtn_, nil, function()
		if ItemTools.getItemNum(CurrencyConst.CURRENCY_TYPE_AUTO_CHESS_CARD_ITEM) < 5 then
			ShowTips(GetTips("AUTO_CHESS_2_INSUFFICIENT_PACK"))

			return
		end

		if arg_5_0.IsOpen then
			return
		end

		arg_5_0.IsOpen = true

		arg_5_0:OnPlayAnimBack(AutoChessCardConst.OPEN_CARD_MODE_MULTI)
	end)
	arg_5_0:AddBtnListener(arg_5_0.collectBtn_, nil, function()
		JumpTools.OpenPageByJump("/autoChessCardCollectView")
	end)
	arg_5_0:AddBtnListener(arg_5_0.btn1_, nil, function()
		arg_5_0.tipsController_:SetSelectedState("show")

		arg_5_0.txtTips_.text = GetTips("AUTO_CHESS_2_SOURCE_EXCHANGE_TIP")
	end)
	arg_5_0:AddBtnListener(arg_5_0.btn2_, nil, function()
		arg_5_0.tipsController_:SetSelectedState("show")

		arg_5_0.txtTips_.text = GetTips("AUTO_CHESS_2_SOURCE_BATTLE_TIP")
	end)
	arg_5_0:AddBtnListener(arg_5_0.maskBtn_, nil, function()
		arg_5_0.tipsController_:SetSelectedState("hide")
	end)
end

function var_0_0.OnPlayAnimBack(arg_13_0, arg_13_1)
	arg_13_0:StopTimer()
	manager.windowBar:HideBar()
	arg_13_0.tipsController_:SetSelectedState("hide")
	AutoChessCardAction.OpenCard(arg_13_1, function(arg_14_0, arg_14_1)
		AnimatorTools.PlayAnimatorWithCallback(arg_13_0.anim_, "UI_Activity_Unpack_MainUI_out", function()
			JumpTools.OpenPageByJump("/autoChessOpenCardView", {
				mode = arg_14_0,
				cardList = arg_14_1
			})

			arg_13_0.IsOpen = false
		end, false, 0, 0)
	end)
end

function var_0_0.StopTimer(arg_16_0)
	AnimatorTools.Stop()
end

function var_0_0.OnEnter(arg_17_0)
	arg_17_0.IsOpen = false

	arg_17_0.tipsController_:SetSelectedState("hide")
	arg_17_0:RefreshCardCollection()
	arg_17_0:RefreshOpenCardItem()
	arg_17_0:BindRedPoint()
end

function var_0_0.RefreshCardCollection(arg_18_0)
	arg_18_0.ultraRareItem:RefreshUI()
	arg_18_0.supRareItem:RefreshUI()
	arg_18_0.normRareItem:RefreshUI()
end

function var_0_0.RefreshOpenCardItem(arg_19_0)
	if ActivityData:GetActivityIsOpen(ActivityConst.ACTIVITY_AUTO_CHESS_EXCHANGE_CARD) then
		arg_19_0.item2_:SetData(ActivityConst.ACTIVITY_AUTO_CHESS_EXCHANGE_CARD)
		arg_19_0.item2_:SetActive(true)
	else
		arg_19_0.item2_:SetActive(false)
	end

	arg_19_0.item1_:SetData(ActivityConst.ACTIVITY_AUTO_CHESS_PVP_4_8)
	arg_19_0.item1_:SetActive(true)
end

function var_0_0.OnTop(arg_20_0)
	manager.windowBar:SwitchBar({
		HOME_BAR,
		BACK_BAR,
		CurrencyConst.CURRENCY_TYPE_AUTO_CHESS_CARD_ITEM
	})
	manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_AUTO_CHESS_CARD_ITEM, false)
end

function var_0_0.OnExit(arg_21_0)
	arg_21_0.tipsController_:SetSelectedState("hide")

	if AutoChessCardData:GetCardBagPower() >= GameSetting.auto_chess_2_pack_energy_max.value[1] then
		saveData("auto_chess_4_8", "card_power_is_show", 0)
	end

	manager.redPoint:setTip(RedPointConst.AUTO_CHESS_4_8_OPEN_CARD_VIEW, 0)
	manager.windowBar:HideBar()
	arg_21_0.anim_:Rebind()
	arg_21_0:UnBindRedPoint()
end

function var_0_0.BindRedPoint(arg_22_0)
	manager.redPoint:bindUIandKey(arg_22_0.item1_:GetBtnTransform(), RedPointConst.AUTO_CHESS_4_8_OPEN_CARD_VIEW)
end

function var_0_0.UnBindRedPoint(arg_23_0)
	manager.redPoint:unbindUIandKey(arg_23_0.item1_:GetBtnTransform(), RedPointConst.AUTO_CHESS_4_8_OPEN_CARD_VIEW)
end

function var_0_0.Dispose(arg_24_0)
	arg_24_0:StopTimer()
	arg_24_0.ultraRareItem:Dispose()
	arg_24_0.supRareItem:Dispose()
	arg_24_0.normRareItem:Dispose()
	arg_24_0.item1_:Dispose()
	arg_24_0.item2_:Dispose()
	var_0_0.super.Dispose(arg_24_0)
end

return var_0_0
