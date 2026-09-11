local ChatSubTabItem = class("ChatSubTabItem", ReduxView)

function ChatSubTabItem:Ctor(arg_1_1, arg_1_2, arg_1_3, arg_1_4)
	self.gameObject_ = Object.Instantiate(arg_1_1, arg_1_2.transform)
	self.transform_ = self.gameObject_.transform
	self.chatToggleID_ = arg_1_3
	self.click_ = arg_1_4

	self:InitUI()
	self:AddListeners()
end

function ChatSubTabItem:InitUI()
	self:BindCfgUI()

	self.tabController_ = self.tabControllerEx_:GetController("state")
	self.titleText_.text = ChatToggleCfg[self.chatToggleID_].name
end

function ChatSubTabItem:AddListeners()
	self:AddBtnListener(self.tabBtn_, nil, function()
		if self:IsLock() then
			ShowTips("ACTIVITY_CLUB_NOT_JOIN")

			return
		end

		if self.click_ then
			self.click_()
		end

		if self.chatToggleID_ == ChatConst.CHAT_CHANNEL_AUTO_CHESS then
			OperationRecorder.RecordButtonTouch({
				source = 2,
				button_name = "activity_autochess_item_exchange_channel_homepage_touch",
				activity_id = AutoChessData:GetActivityID()
			})
		end
	end)
end

function ChatSubTabItem:IsLock()
	if self.chatToggleID_ == ChatConst.CHAT_CHANNEL_GUILD_ACTIVITY then
		return not GuildActivityData:HaveRegister()
	end

	if self.chatToggleID_ == ChatConst.CHAT_CHANNEL_GUILD_ACTIVITY_SP_2_4 or self.chatToggleID_ == ChatConst.CHAT_CHANNEL_GUILD_ACTIVITY_SP_2_8 then
		return not GuildActivitySPData:HaveRegister()
	end

	if self.chatToggleID_ == ChatConst.CHAT_CHANNEL_AUTO_CHESS then
		return not ActivityData:GetActivityIsOpen(ActivityConst.ACTIVITY_AUTO_CHESS_EXCHANGE_CARD)
	end

	return false
end

function ChatSubTabItem:SetTabState(arg_6_1)
	if arg_6_1 then
		self.tabController_:SetSelectedState("select")
	else
		self.tabController_:SetSelectedState(self:IsLock() and "lock" or "unlock")
	end
end

function ChatSubTabItem:Show(arg_7_1)
	SetActive(self.gameObject_, arg_7_1)
end

function ChatSubTabItem:Dispose()
	ChatSubTabItem.super.Dispose(self)
	Object.Destroy(self.gameObject_)

	self.transform_ = nil
	self.gameObject_ = nil
end

return ChatSubTabItem
