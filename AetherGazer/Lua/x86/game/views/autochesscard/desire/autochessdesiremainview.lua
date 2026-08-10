local var_0_0 = class("AutoChessDesireMainView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Activity_AutoChess_Main/TradingCard/Activity_AutoChess_TradingUI"
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

	arg_4_0.list_ = LuaList.New(handler(arg_4_0, arg_4_0.IndexItem), arg_4_0.uiList_, AutoChessDesireCardItem)
	arg_4_0.selectController_ = arg_4_0.controller_:GetController("select")
	arg_4_0.bubbleController_ = arg_4_0.wishController_:GetController("bubble")
	arg_4_0.URFactoryItem_ = AutoChessURFactoryItem.New(arg_4_0.URItemGo_)
end

function var_0_0.IndexItem(arg_5_0, arg_5_1, arg_5_2)
	arg_5_2:SetData(arg_5_1, arg_5_0.mode_, arg_5_0.URFactoryItem_)
end

function var_0_0.AddListeners(arg_6_0)
	arg_6_0:AddBtnListener(arg_6_0.friendBtn_, nil, function()
		arg_6_0:RefreshDesireList(AutoChessCardConst.DESIRE_TYPE.FRIEND)
	end)
	arg_6_0:AddBtnListener(arg_6_0.otherBtn_, nil, function()
		arg_6_0:RefreshDesireList(AutoChessCardConst.DESIRE_TYPE.OTHER)
	end)
	arg_6_0:AddBtnListener(arg_6_0.myBtn_, nil, function()
		local var_9_0 = AutoChessCardData:GetDesireInfo()

		if var_9_0.State == AutoChessCardConst.DESIRE_STATE.NO then
			if var_9_0.CardID == 0 then
				JumpTools.OpenPageByJump("autoChessEditDesireDatailPopView")
			else
				JumpTools.OpenPageByJump("autoChessDesireDatailPopView", {
					mode = AutoChessCardConst.DESIRE_TYPE.MY
				})
			end
		else
			JumpTools.OpenPageByJump("autoChessDesireCurSceceView", {
				mode = AutoChessCardConst.DESIRE_TYPE.MY
			})
		end
	end)
	arg_6_0:AddBtnListener(arg_6_0.refreshBtn_, nil, function()
		AutoChessCardAction.GetCardDesireList(arg_6_0.mode_, function()
			arg_6_0:RefreshDesireList(arg_6_0.mode_)
		end)
	end)
end

function var_0_0.OnEnter(arg_12_0)
	arg_12_0:RefreshTime()
	arg_12_0:RefreshWish()

	if AutoChessCardData:GetFriendDesireNum() > 0 then
		arg_12_0:RefreshDesireList(AutoChessCardConst.DESIRE_TYPE.FRIEND)
	else
		arg_12_0:RefreshDesireList(AutoChessCardConst.DESIRE_TYPE.OTHER)
	end

	arg_12_0:BindRedPoint()
end

function var_0_0.RefreshWish(arg_13_0)
	if AutoChessCardData:GetDesireNum() >= GameSetting.auto_chess_2_exchange_self_times.value[1] then
		arg_13_0.bubbleController_:SetSelectedState("hide")
		SetActive(arg_13_0.myBtn_.gameObject, false)

		return
	end

	local var_13_0 = AutoChessCardData:GetDesireInfo()

	if var_13_0.CardID > 0 then
		arg_13_0.bubbleController_:SetSelectedState("fulfill")

		if var_13_0.State == AutoChessCardConst.DESIRE_STATE.NO then
			arg_13_0.txtWishEmpty_.text = GetTips("AUTO_CHESS_2_WISHING")
		else
			arg_13_0.txtWishEmpty_.text = GetTips("AUTO_CHESS_2_WISH_GRANTED")
		end
	else
		arg_13_0.bubbleController_:SetSelectedState("wish")

		arg_13_0.txtWish_.text = GetTips("AUTO_CHESS_2_WISH_AVAILABLE")
	end
end

function var_0_0.RefreshTime(arg_14_0)
	local var_14_0 = ActivityData:GetActivityData(ActivityConst.ACTIVITY_AUTO_CHESS_EXCHANGE_CARD)

	if ActivityData:GetActivityIsOpen(ActivityConst.ACTIVITY_AUTO_CHESS_EXCHANGE_CARD) then
		arg_14_0.txtTime_.text = manager.time:GetLostTimeStr2(var_14_0.stopTime)
	elseif manager.time:GetServerTime() < var_14_0.startTime then
		arg_14_0.txtTime_.text = string.format(GetTips("AFTER_TIME"), manager.time:GetLostTimeStr2(var_14_0.startTime))
	elseif manager.time:GetServerTime() > var_14_0.stopTime then
		arg_14_0.txtTime_.text = GetTips("TIME_OVER")
	end

	if arg_14_0.limittimer_ == nil then
		arg_14_0.limittimer_ = Timer.New(function()
			if ActivityData:GetActivityIsOpen(ActivityConst.ACTIVITY_AUTO_CHESS_EXCHANGE_CARD) then
				if arg_14_0.limittimer_ == nil then
					arg_14_0.txtTime_.text = manager.time:GetLostTimeStr2(var_14_0.stopTime)
				end
			elseif manager.time:GetServerTime() < var_14_0.startTime then
				arg_14_0.txtTime_.text = string.format(GetTips("AFTER_TIME"), manager.time:GetLostTimeStr2(var_14_0.startTime))
			elseif manager.time:GetServerTime() > var_14_0.stopTime then
				arg_14_0.txtTime_.text = GetTips("TIME_OVER")
			end
		end, 1, -1)
	end

	arg_14_0.limittimer_:Start()
end

function var_0_0.OnTop(arg_16_0)
	arg_16_0:RefreshWish()
	arg_16_0:RefreshDesireList(arg_16_0.mode_)
	manager.windowBar:SwitchBar({
		HOME_BAR,
		BACK_BAR,
		INFO_BAR
	})
	manager.windowBar:RegistInfoCallBack(function()
		OperationRecorder.RecordButtonTouch({
			button_name = "activity_autochess_item_exchange_homepage_rules",
			activity_id = AutoChessData:GetActivityID()
		})
		JumpTools.OpenPageByJump("gameHelp", {
			key = "AUTO_CHESS_2_EXCHANGE_TIP",
			content = GetTips("AUTO_CHESS_2_EXCHANGE_TIP")
		})
	end)
end

function var_0_0.RefreshDesireList(arg_18_0, arg_18_1)
	arg_18_0:SetTabSelectState(arg_18_1)

	local var_18_0
	local var_18_1

	if arg_18_1 == AutoChessCardConst.DESIRE_TYPE.FRIEND then
		local var_18_2 = GameSetting.auto_chess_2_exchange_friend_times.value[1]
		local var_18_3 = AutoChessCardData:GetFriendExchangeCardNum()

		arg_18_0.txtChange_.text = GetTipsF("AUTO_CHESS_2_DAILY_EXCHANGE_LEFT", var_18_2 - var_18_3 .. "/" .. var_18_2)

		arg_18_0.list_:StartScroll(AutoChessCardData:GetFriendDesireNum())
	else
		local var_18_4 = GameSetting.auto_chess_2_exchange_stranger_times.value[1]
		local var_18_5 = AutoChessCardData:GetOtherExchangeCardNum()

		arg_18_0.txtChange_.text = GetTipsF("AUTO_CHESS_2_DAILY_EXCHANGE_LEFT", var_18_4 - var_18_5 .. "/" .. var_18_4)

		arg_18_0.list_:StartScroll(AutoChessCardData:GetOtherDesireNum())
	end
end

function var_0_0.SetTabSelectState(arg_19_0, arg_19_1)
	arg_19_0.selectController_:SetSelectedIndex(arg_19_1)

	arg_19_0.mode_ = arg_19_1
end

function var_0_0.OnExit(arg_20_0)
	manager.windowBar:HideBar()
	arg_20_0:UnBindRedPoint()
end

function var_0_0.BindRedPoint(arg_21_0)
	return
end

function var_0_0.UnBindRedPoint(arg_22_0)
	return
end

function var_0_0.Dispose(arg_23_0)
	if arg_23_0.limittimer_ then
		arg_23_0.limittimer_:Stop()

		arg_23_0.limittimer_ = nil
	end

	if arg_23_0.list_ then
		arg_23_0.list_:Dispose()

		arg_23_0.list_ = nil
	end

	arg_23_0.URFactoryItem_:Dispose()
	var_0_0.super.Dispose(arg_23_0)
end

return var_0_0
