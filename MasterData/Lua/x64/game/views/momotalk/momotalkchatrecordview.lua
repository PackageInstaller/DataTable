local MomoTalkChatRecordView = class("MomoTalkChatRecordView", ReduxView)

function MomoTalkChatRecordView:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:BindCfgUI()
	self:InitList()
	self:AddListeners()
end

function MomoTalkChatRecordView:InitList()
	if self.historylistGo_ then
		self.luaList_ = LuaList.New(handler(self, self.IndexItem), self.historylistGo_, MomoTalkRecordItem)
	end
end

function MomoTalkChatRecordView:AddListeners()
	self:AddBtnListener(self.backBtn_, nil, function()
		self.currentSessionID_ = self.currentSessionID_ or self:GetDefaultSessionID()

		if not self.currentSessionID_ then
			return
		end

		manager.notify:Invoke(MOMOTALK_OPEN_CHAT, self.senderID_, self.currentSessionID_)
	end)
end

function MomoTalkChatRecordView:OnEnter()
	return
end

function MomoTalkChatRecordView:OnExit()
	return
end

function MomoTalkChatRecordView:SetData(arg_7_1)
	self.senderID_ = arg_7_1
	self.currentSessionID_ = nil
	self.recordList_ = self:BuildRecordList()
	self.currentSessionID_ = self:GetDefaultSessionID()

	self:RefreshHeader()

	if self.luaList_ then
		self.luaList_:StartScroll(#self.recordList_)
	end
end

function MomoTalkChatRecordView:RefreshHeader()
	if not self.nameText_ then
		return
	end

	local var_8_0 = MomoTalkTools.GetSessionDisplayName(self.currentSessionID_, self.senderID_)

	if var_8_0 == "" and self.senderID_ and ChatHeroCfg[self.senderID_] then
		var_8_0 = GetI18NText(ChatHeroCfg[self.senderID_].name or "")
	end

	self.nameText_.text = var_8_0
end

function MomoTalkChatRecordView:BuildRecordList()
	local var_9_0 = {}

	for iter_9_0, iter_9_1 in pairs(MomoTalkData:GetData2(MomoTalkConst.DATA_TYPE.CHAT, self.senderID_) or {}) do
		if iter_9_1 then
			if #(iter_9_1.save_list or {}) > 0 or iter_9_1.is_view ~= nil then
				table.insert(var_9_0, {
					sessionID = iter_9_0,
					session = iter_9_1,
					preview = MomoTalkTools.GetSessionFirstPreviewContent(iter_9_1)
				})
			end
		end
	end

	table.sort(var_9_0, function(arg_10_0, arg_10_1)
		return arg_10_0.sessionID < arg_10_1.sessionID
	end)

	return var_9_0
end

function MomoTalkChatRecordView:IndexItem(arg_11_1, arg_11_2)
	if not self.recordList_[arg_11_1] then
		return
	end

	arg_11_2:SetData(self.recordList_[arg_11_1], function(arg_12_0)
		if not arg_12_0 then
			return
		end

		self.currentSessionID_ = arg_12_0

		manager.notify:Invoke(MOMOTALK_OPEN_CHAT, self.senderID_, arg_12_0, "top")
	end)
end

function MomoTalkChatRecordView:GetDefaultSessionID()
	local var_13_0

	if self.recordList_ and #self.recordList_ > 0 then
		return self.recordList_[#self.recordList_].sessionID
	end

	for iter_13_0, iter_13_1 in pairs(MomoTalkData:GetData2(MomoTalkConst.DATA_TYPE.CHAT, self.senderID_) or {}) do
		if iter_13_1 then
			local var_13_1 = iter_13_1.id or iter_13_0

			if var_13_1 and (not var_13_0 or var_13_0 < var_13_1) then
				var_13_0 = var_13_1
			end
		end
	end

	return var_13_0
end

function MomoTalkChatRecordView:Dispose()
	if self.luaList_ then
		self.luaList_:Dispose()

		self.luaList_ = nil
	end

	MomoTalkChatRecordView.super.Dispose(self)
end

return MomoTalkChatRecordView
