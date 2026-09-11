local AutoChessDesireMainView = class("AutoChessDesireMainView", ReduxView)

function AutoChessDesireMainView:UIName()
	return "Widget/System/Activity_AutoChess_Main/TradingCard/Activity_AutoChess_TradingUI"
end

function AutoChessDesireMainView:UIParent()
	return manager.ui.uiMain.transform
end

function AutoChessDesireMainView:Init()
	self:InitUI()
	self:AddListeners()
end

function AutoChessDesireMainView:InitUI()
	self:BindCfgUI()

	self.list_ = LuaList.New(handler(self, self.IndexItem), self.uiList_, AutoChessDesireCardItem)
	self.selectController_ = self.controller_:GetController("select")
	self.bubbleController_ = self.wishController_:GetController("bubble")
	self.URFactoryItem_ = AutoChessURFactoryItem.New(self.URItemGo_)
end

function AutoChessDesireMainView:IndexItem(arg_5_1, arg_5_2)
	arg_5_2:SetData(arg_5_1, self.mode_, self.URFactoryItem_)
end

function AutoChessDesireMainView:AddListeners()
	self:AddBtnListener(self.friendBtn_, nil, function()
		self:RefreshDesireList(AutoChessCardConst.DESIRE_TYPE.FRIEND)
	end)
	self:AddBtnListener(self.otherBtn_, nil, function()
		self:RefreshDesireList(AutoChessCardConst.DESIRE_TYPE.OTHER)
	end)
	self:AddBtnListener(self.myBtn_, nil, function()
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
	self:AddBtnListener(self.refreshBtn_, nil, function()
		AutoChessCardAction.GetCardDesireList(self.mode_, function()
			self:RefreshDesireList(self.mode_)
		end)
	end)
end

function AutoChessDesireMainView:OnEnter()
	self:RefreshTime()
	self:RefreshWish()

	if AutoChessCardData:GetFriendDesireNum() > 0 then
		self:RefreshDesireList(AutoChessCardConst.DESIRE_TYPE.FRIEND)
	else
		self:RefreshDesireList(AutoChessCardConst.DESIRE_TYPE.OTHER)
	end

	self:BindRedPoint()
end

function AutoChessDesireMainView:RefreshWish()
	if AutoChessCardData:GetDesireNum() >= GameSetting.auto_chess_2_exchange_self_times.value[1] then
		self.bubbleController_:SetSelectedState("hide")
		SetActive(self.myBtn_.gameObject, false)

		return
	end

	local var_13_0 = AutoChessCardData:GetDesireInfo()

	if var_13_0.CardID > 0 then
		self.bubbleController_:SetSelectedState("fulfill")

		self.txtWishEmpty_.text = var_13_0.State == AutoChessCardConst.DESIRE_STATE.NO and GetTips("AUTO_CHESS_2_WISHING") or GetTips("AUTO_CHESS_2_WISH_GRANTED")
	else
		self.bubbleController_:SetSelectedState("wish")

		self.txtWish_.text = GetTips("AUTO_CHESS_2_WISH_AVAILABLE")
	end
end

function AutoChessDesireMainView:RefreshTime()
	local var_14_0 = ActivityData:GetActivityData(ActivityConst.ACTIVITY_AUTO_CHESS_EXCHANGE_CARD)

	if ActivityData:GetActivityIsOpen(ActivityConst.ACTIVITY_AUTO_CHESS_EXCHANGE_CARD) then
		self.txtTime_.text = manager.time:GetLostTimeStr2(var_14_0.stopTime)
	elseif manager.time:GetServerTime() < var_14_0.startTime then
		self.txtTime_.text = string.format(GetTips("AFTER_TIME"), manager.time:GetLostTimeStr2(var_14_0.startTime))
	elseif manager.time:GetServerTime() > var_14_0.stopTime then
		self.txtTime_.text = GetTips("TIME_OVER")
	end

	if self.limittimer_ == nil then
		self.limittimer_ = Timer.New(function()
			if ActivityData:GetActivityIsOpen(ActivityConst.ACTIVITY_AUTO_CHESS_EXCHANGE_CARD) then
				if self.limittimer_ == nil then
					self.txtTime_.text = manager.time:GetLostTimeStr2(var_14_0.stopTime)
				end
			elseif manager.time:GetServerTime() < var_14_0.startTime then
				self.txtTime_.text = string.format(GetTips("AFTER_TIME"), manager.time:GetLostTimeStr2(var_14_0.startTime))
			elseif manager.time:GetServerTime() > var_14_0.stopTime then
				self.txtTime_.text = GetTips("TIME_OVER")
			end
		end, 1, -1)
	end

	self.limittimer_:Start()
end

function AutoChessDesireMainView:OnTop()
	self:RefreshWish()
	self:RefreshDesireList(self.mode_)
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

function AutoChessDesireMainView:RefreshDesireList(arg_18_1)
	self:SetTabSelectState(arg_18_1)

	if arg_18_1 == AutoChessCardConst.DESIRE_TYPE.FRIEND then
		self.txtChange_.text = GetTipsF("AUTO_CHESS_2_DAILY_EXCHANGE_LEFT", GameSetting.auto_chess_2_exchange_friend_times.value[1] - AutoChessCardData:GetFriendExchangeCardNum() .. "/" .. GameSetting.auto_chess_2_exchange_friend_times.value[1])

		self.list_:StartScroll(AutoChessCardData:GetFriendDesireNum())
	else
		self.txtChange_.text = GetTipsF("AUTO_CHESS_2_DAILY_EXCHANGE_LEFT", GameSetting.auto_chess_2_exchange_stranger_times.value[1] - AutoChessCardData:GetOtherExchangeCardNum() .. "/" .. GameSetting.auto_chess_2_exchange_stranger_times.value[1])

		self.list_:StartScroll(AutoChessCardData:GetOtherDesireNum())
	end
end

function AutoChessDesireMainView:SetTabSelectState(arg_19_1)
	self.selectController_:SetSelectedIndex(arg_19_1)

	self.mode_ = arg_19_1
end

function AutoChessDesireMainView:OnExit()
	manager.windowBar:HideBar()
	self:UnBindRedPoint()
end

function AutoChessDesireMainView:BindRedPoint()
	return
end

function AutoChessDesireMainView:UnBindRedPoint()
	return
end

function AutoChessDesireMainView:Dispose()
	if self.limittimer_ then
		self.limittimer_:Stop()

		self.limittimer_ = nil
	end

	if self.list_ then
		self.list_:Dispose()

		self.list_ = nil
	end

	self.URFactoryItem_:Dispose()
	AutoChessDesireMainView.super.Dispose(self)
end

return AutoChessDesireMainView
