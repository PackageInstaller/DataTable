local MomoTalkCharactorListView = class("MomoTalkCharactorListView", ReduxView)

function MomoTalkCharactorListView:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:InitList()
	self:AddEventListener()
end

function MomoTalkCharactorListView:InitList()
	self.luaList_ = LuaList.New(handler(self, self.IndexItem), self.gameObject_, MomoTalkCharactorListItem)
end

function MomoTalkCharactorListView:AddEventListener()
	self:RegistEventListener(MOMOTALK_OPEN_CHAT, handler(self, self.OnOpenChat))
	self:RegistEventListener(MOMOTALK_BACK_TO_LIST, handler(self, self.OnBackToList))
	self:RegistEventListener(MOMOTALK_UPDATE, handler(self, self.OnMomoTalkUpdate))
	self:RegistEventListener(MOMOTALK_CHAT_UPDATE, handler(self, self.OnMomoTalkUpdate))
	self:RegistEventListener(MOMOTALK_CHAT_LIST_UPDATE, handler(self, self.OnMomoTalkUpdate))
end

function MomoTalkCharactorListView:Refresh()
	self.dataList_ = self:BuildSortedList()

	self.luaList_:StartScroll(#self.dataList_)
end

function MomoTalkCharactorListView:BuildSortedList()
	local var_5_0 = MomoTalkTools.GetCharactorLitsByType(MomoTalkConst.DATA_TYPE.CHAT)

	table.sort(var_5_0, function(arg_6_0, arg_6_1)
		local var_6_0 = self:GetSortInfo(arg_6_0.chat_Data)
		local var_6_1 = self:GetSortInfo(arg_6_1.chat_Data)

		if var_6_0.weight ~= var_6_1.weight then
			return var_6_0.weight > var_6_1.weight
		end

		if var_6_0.sendTime ~= var_6_1.sendTime then
			return var_6_0.sendTime > var_6_1.sendTime
		end

		if var_6_0.sessionID ~= var_6_1.sessionID then
			return var_6_0.sessionID > var_6_1.sessionID
		end

		return arg_6_0.sender_id > arg_6_1.sender_id
	end)

	return var_5_0
end

function MomoTalkCharactorListView:GetSortInfo(arg_7_1)
	local var_7_0 = {
		sendTime = 0,
		sessionID = 0,
		weight = MomoTalkConst.CONTACT_SORT.FINISHED
	}

	local function var_7_1(arg_8_0, arg_8_1, arg_8_2)
		if arg_8_1 then
			local var_8_0 = arg_8_1.id or arg_8_2 or 0

			if arg_8_1 then
				local var_8_1 = arg_8_1.send_time or 0

				if arg_8_0 > var_7_0.weight then
					var_7_0.weight = arg_8_0
					var_7_0.sendTime = var_8_1
					var_7_0.sessionID = var_8_0

					return
				end

				if arg_8_0 == var_7_0.weight and (var_8_1 > var_7_0.sendTime or var_8_1 == var_7_0.sendTime and var_8_0 > var_7_0.sessionID) then
					var_7_0.sendTime = var_8_1
					var_7_0.sessionID = var_8_0
				end
			end
		end
	end

	for iter_7_0, iter_7_1 in pairs(arg_7_1 or {}) do
		if MomoTalkData:IsActiveUnreadSession(iter_7_1, iter_7_0) then
			var_7_1(MomoTalkConst.CONTACT_SORT.UNFINISHED, iter_7_1, iter_7_0)
		elseif MomoTalkData:IsNoRemindSession(iter_7_1, iter_7_0) then
			var_7_1(MomoTalkConst.CONTACT_SORT.NO_REMIND, iter_7_1, iter_7_0)
		elseif iter_7_1 then
			var_7_1(MomoTalkConst.CONTACT_SORT.FINISHED, iter_7_1, iter_7_0)
		end
	end

	return var_7_0
end

function MomoTalkCharactorListView:IndexItem(arg_9_1, arg_9_2)
	if not self.dataList_[arg_9_1] then
		return
	end

	arg_9_2:SetData(self.dataList_[arg_9_1], self.selectedSenderID_)
end

function MomoTalkCharactorListView:OnOpenChat(arg_10_1, arg_10_2)
	self.selectedSenderID_ = arg_10_1
	self.selectedSessionID_ = arg_10_2

	if self.luaList_ and self.dataList_ then
		self.luaList_:Refresh()
	end
end

function MomoTalkCharactorListView:OnBackToList()
	self.selectedSenderID_ = nil
	self.selectedSessionID_ = nil

	if self.luaList_ and self.dataList_ then
		self.luaList_:Refresh()
	end
end

function MomoTalkCharactorListView:OnMomoTalkUpdate()
	self:Refresh()
end

function MomoTalkCharactorListView:Dispose()
	if self.luaList_ then
		self.luaList_:Dispose()

		self.luaList_ = nil
	end

	MomoTalkCharactorListView.super.Dispose(self)
end

return MomoTalkCharactorListView
