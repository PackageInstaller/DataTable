local var_0_0 = class("MomoTalkChatTabsView", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:InitUI()
end

function var_0_0.InitUI(arg_2_0)
	arg_2_0:BindCfgUI()

	arg_2_0.staticContext = {
		page = {
			chat = {
				opened = false,
				state = "chatInfo",
				script = MomoTalkChatContentView,
				go = arg_2_0.chatInfoGo_
			},
			record = {
				opened = false,
				state = "history",
				script = MomoTalkChatRecordView,
				go = arg_2_0.historyGo_
			}
		},
		viewCon = arg_2_0.viewController_:GetController("viewState")
	}

	arg_2_0:AddEventListener()

	arg_2_0.chatCharacterListView_ = MomoTalkCharactorListView.New(arg_2_0.chatListGo_)
end

function var_0_0.AddEventListener(arg_3_0)
	arg_3_0:RegistEventListener(MOMOTALK_OPEN_CHAT, handler(arg_3_0, arg_3_0.OnOpenChat))
	arg_3_0:RegistEventListener(MOMOTALK_OPEN_RECORD, handler(arg_3_0, arg_3_0.OnOpenRecord))
	arg_3_0:RegistEventListener(MOMOTALK_BACK_TO_LIST, handler(arg_3_0, arg_3_0.OnBackToList))
	arg_3_0:RegistEventListener(MOMOTALK_UPDATE, handler(arg_3_0, arg_3_0.OnMomoTalkUpdate))
end

function var_0_0.OnEnter(arg_4_0)
	arg_4_0.chatCharacterListView_:Refresh()

	if arg_4_0.selectedSenderID_ and arg_4_0.selectedSessionID_ then
		arg_4_0:OpenChat(arg_4_0.selectedSenderID_, arg_4_0.selectedSessionID_)
	else
		arg_4_0:EnterEmpty()
	end
end

function var_0_0.OnExit(arg_5_0)
	for iter_5_0, iter_5_1 in pairs(arg_5_0.staticContext.page) do
		if iter_5_1.opened then
			iter_5_1.entity:OnExit()

			iter_5_1.opened = false
		end
	end
end

function var_0_0.InstOrCreatePage(arg_6_0, arg_6_1)
	if arg_6_1.entity == nil then
		arg_6_1.entity = arg_6_1.script.New(arg_6_1.go)
	end
end

function var_0_0.EnterPage(arg_7_0, arg_7_1)
	for iter_7_0, iter_7_1 in pairs(arg_7_0.staticContext.page) do
		if iter_7_0 == arg_7_1 then
			if not iter_7_1.opened then
				arg_7_0:InstOrCreatePage(iter_7_1)
				iter_7_1.entity:OnEnter()

				iter_7_1.opened = true

				arg_7_0.staticContext.viewCon:SetSelectedState(iter_7_1.state)
			end
		elseif iter_7_1.opened then
			iter_7_1.entity:OnExit()

			iter_7_1.opened = false
		end
	end
end

function var_0_0.EnterEmpty(arg_8_0)
	for iter_8_0, iter_8_1 in pairs(arg_8_0.staticContext.page) do
		if iter_8_1.opened then
			iter_8_1.entity:OnExit()

			iter_8_1.opened = false
		end
	end

	arg_8_0.staticContext.viewCon:SetSelectedState("empty")
end

function var_0_0.OpenChat(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
	if not arg_9_1 or not arg_9_2 or not ChatMessageCfg[arg_9_2] then
		return
	end

	arg_9_0.selectedSenderID_ = arg_9_1
	arg_9_0.selectedSessionID_ = arg_9_2

	arg_9_0:EnterPage("chat")
	arg_9_0.staticContext.page.chat.entity:SetData(arg_9_1, arg_9_2, arg_9_3)
end

function var_0_0.OpenRecord(arg_10_0, arg_10_1)
	arg_10_0:EnterPage("record")
	arg_10_0.staticContext.page.record.entity:SetData(arg_10_1)
end

function var_0_0.BackToList(arg_11_0)
	arg_11_0.selectedSenderID_ = nil
	arg_11_0.selectedSessionID_ = nil

	arg_11_0:EnterEmpty()
end

function var_0_0.RefreshCurrentPanel(arg_12_0)
	local var_12_0 = arg_12_0.staticContext

	if var_12_0.page.chat.opened and var_12_0.page.chat.entity then
		var_12_0.page.chat.entity:Refresh()
	end
end

function var_0_0.SyncSelectedChatSession(arg_13_0)
	if not arg_13_0.selectedSenderID_ or arg_13_0.staticContext.page.record.opened then
		return
	end

	local var_13_0 = MomoTalkTools.GetPendingSession(MomoTalkData:GetData2(MomoTalkConst.DATA_TYPE.CHAT, arg_13_0.selectedSenderID_))
	local var_13_1 = var_13_0 and var_13_0.id or 0

	if var_13_1 ~= 0 and var_13_1 ~= arg_13_0.selectedSessionID_ then
		arg_13_0:OpenChat(arg_13_0.selectedSenderID_, var_13_1)
	end
end

function var_0_0.OnOpenChat(arg_14_0, arg_14_1, arg_14_2, arg_14_3)
	arg_14_0:OpenChat(arg_14_1, arg_14_2, arg_14_3)
end

function var_0_0.OnOpenRecord(arg_15_0, arg_15_1)
	arg_15_0:OpenRecord(arg_15_1)
end

function var_0_0.OnBackToList(arg_16_0)
	arg_16_0:BackToList()
end

function var_0_0.OnMomoTalkUpdate(arg_17_0)
	arg_17_0:SyncSelectedChatSession()
end

function var_0_0.Dispose(arg_18_0)
	for iter_18_0, iter_18_1 in pairs(arg_18_0.staticContext.page) do
		if iter_18_1.entity then
			iter_18_1.entity:Dispose()

			iter_18_1.entity = nil
		end
	end

	if arg_18_0.chatCharacterListView_ then
		arg_18_0.chatCharacterListView_:Dispose()

		arg_18_0.chatCharacterListView_ = nil
	end

	var_0_0.super.Dispose(arg_18_0)
end

return var_0_0
