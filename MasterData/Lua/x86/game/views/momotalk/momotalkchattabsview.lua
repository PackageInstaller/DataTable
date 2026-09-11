local MomoTalkChatTabsView = class("MomoTalkChatTabsView", ReduxView)

function MomoTalkChatTabsView:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:InitUI()
end

function MomoTalkChatTabsView:InitUI()
	self:BindCfgUI()

	self.staticContext = {
		page = {
			chat = {
				opened = false,
				state = "chatInfo",
				script = MomoTalkChatContentView,
				go = self.chatInfoGo_
			},
			record = {
				opened = false,
				state = "history",
				script = MomoTalkChatRecordView,
				go = self.historyGo_
			}
		},
		viewCon = self.viewController_:GetController("viewState")
	}

	self:AddEventListener()

	self.chatCharacterListView_ = MomoTalkCharactorListView.New(self.chatListGo_)
end

function MomoTalkChatTabsView:AddEventListener()
	self:RegistEventListener(MOMOTALK_OPEN_CHAT, handler(self, self.OnOpenChat))
	self:RegistEventListener(MOMOTALK_OPEN_RECORD, handler(self, self.OnOpenRecord))
	self:RegistEventListener(MOMOTALK_BACK_TO_LIST, handler(self, self.OnBackToList))
	self:RegistEventListener(MOMOTALK_UPDATE, handler(self, self.OnMomoTalkUpdate))
end

function MomoTalkChatTabsView:OnEnter()
	self.chatCharacterListView_:Refresh()

	if self.selectedSenderID_ and self.selectedSessionID_ then
		self:OpenChat(self.selectedSenderID_, self.selectedSessionID_)
	else
		self:EnterEmpty()
	end
end

function MomoTalkChatTabsView:OnExit()
	for iter_5_0, iter_5_1 in pairs(self.staticContext.page) do
		if iter_5_1.opened then
			iter_5_1.entity:OnExit()

			iter_5_1.opened = false
		end
	end
end

function MomoTalkChatTabsView:InstOrCreatePage(arg_6_1)
	if arg_6_1.entity == nil then
		arg_6_1.entity = arg_6_1.script.New(arg_6_1.go)
	end
end

function MomoTalkChatTabsView:EnterPage(arg_7_1)
	for iter_7_0, iter_7_1 in pairs(self.staticContext.page) do
		if iter_7_0 == arg_7_1 then
			if not iter_7_1.opened then
				self:InstOrCreatePage(iter_7_1)
				iter_7_1.entity:OnEnter()

				iter_7_1.opened = true

				self.staticContext.viewCon:SetSelectedState(iter_7_1.state)
			end
		elseif iter_7_1.opened then
			iter_7_1.entity:OnExit()

			iter_7_1.opened = false
		end
	end
end

function MomoTalkChatTabsView:EnterEmpty()
	for iter_8_0, iter_8_1 in pairs(self.staticContext.page) do
		if iter_8_1.opened then
			iter_8_1.entity:OnExit()

			iter_8_1.opened = false
		end
	end

	self.staticContext.viewCon:SetSelectedState("empty")
end

function MomoTalkChatTabsView:OpenChat(arg_9_1, arg_9_2, arg_9_3)
	if not arg_9_1 or not arg_9_2 or not ChatMessageCfg[arg_9_2] then
		return
	end

	self.selectedSenderID_ = arg_9_1
	self.selectedSessionID_ = arg_9_2

	self:EnterPage("chat")
	self.staticContext.page.chat.entity:SetData(arg_9_1, arg_9_2, arg_9_3)
end

function MomoTalkChatTabsView:OpenRecord(arg_10_1)
	self:EnterPage("record")
	self.staticContext.page.record.entity:SetData(arg_10_1)
end

function MomoTalkChatTabsView:BackToList()
	self.selectedSenderID_ = nil
	self.selectedSessionID_ = nil

	self:EnterEmpty()
end

function MomoTalkChatTabsView:RefreshCurrentPanel()
	if self.staticContext.page.chat.opened and self.staticContext.page.chat.entity then
		self.staticContext.page.chat.entity:Refresh()
	end
end

function MomoTalkChatTabsView:SyncSelectedChatSession()
	if not self.selectedSenderID_ or self.staticContext.page.record.opened then
		return
	end

	local var_13_0 = MomoTalkTools.GetPendingSession(MomoTalkData:GetData2(MomoTalkConst.DATA_TYPE.CHAT, self.selectedSenderID_))

	if var_13_0 then
		local var_13_1 = var_13_0.id or 0

		if var_13_1 ~= 0 and var_13_1 ~= self.selectedSessionID_ then
			self:OpenChat(self.selectedSenderID_, var_13_1)
		end
	end
end

function MomoTalkChatTabsView:OnOpenChat(arg_14_1, arg_14_2, arg_14_3)
	self:OpenChat(arg_14_1, arg_14_2, arg_14_3)
end

function MomoTalkChatTabsView:OnOpenRecord(arg_15_1)
	self:OpenRecord(arg_15_1)
end

function MomoTalkChatTabsView:OnBackToList()
	self:BackToList()
end

function MomoTalkChatTabsView:OnMomoTalkUpdate()
	self:SyncSelectedChatSession()
end

function MomoTalkChatTabsView:Dispose()
	for iter_18_0, iter_18_1 in pairs(self.staticContext.page) do
		if iter_18_1.entity then
			iter_18_1.entity:Dispose()

			iter_18_1.entity = nil
		end
	end

	if self.chatCharacterListView_ then
		self.chatCharacterListView_:Dispose()

		self.chatCharacterListView_ = nil
	end

	MomoTalkChatTabsView.super.Dispose(self)
end

return MomoTalkChatTabsView
