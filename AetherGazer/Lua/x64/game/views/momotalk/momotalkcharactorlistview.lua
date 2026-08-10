local var_0_0 = class("MomoTalkCharactorListView", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:InitList()
	arg_1_0:AddEventListener()
end

function var_0_0.InitList(arg_2_0)
	arg_2_0.luaList_ = LuaList.New(handler(arg_2_0, arg_2_0.IndexItem), arg_2_0.gameObject_, MomoTalkCharactorListItem)
end

function var_0_0.AddEventListener(arg_3_0)
	arg_3_0:RegistEventListener(MOMOTALK_OPEN_CHAT, handler(arg_3_0, arg_3_0.OnOpenChat))
	arg_3_0:RegistEventListener(MOMOTALK_BACK_TO_LIST, handler(arg_3_0, arg_3_0.OnBackToList))
	arg_3_0:RegistEventListener(MOMOTALK_UPDATE, handler(arg_3_0, arg_3_0.OnMomoTalkUpdate))
	arg_3_0:RegistEventListener(MOMOTALK_CHAT_UPDATE, handler(arg_3_0, arg_3_0.OnMomoTalkUpdate))
	arg_3_0:RegistEventListener(MOMOTALK_CHAT_LIST_UPDATE, handler(arg_3_0, arg_3_0.OnMomoTalkUpdate))
end

function var_0_0.Refresh(arg_4_0)
	arg_4_0.dataList_ = arg_4_0:BuildSortedList()

	arg_4_0.luaList_:StartScroll(#arg_4_0.dataList_)
end

function var_0_0.BuildSortedList(arg_5_0)
	local var_5_0 = MomoTalkTools.GetCharactorLitsByType(MomoTalkConst.DATA_TYPE.CHAT)

	table.sort(var_5_0, function(arg_6_0, arg_6_1)
		local var_6_0 = arg_5_0:GetSortInfo(arg_6_0.chat_Data)
		local var_6_1 = arg_5_0:GetSortInfo(arg_6_1.chat_Data)

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

function var_0_0.GetSortInfo(arg_7_0, arg_7_1)
	local var_7_0 = {
		sendTime = 0,
		sessionID = 0,
		weight = MomoTalkConst.CONTACT_SORT.FINISHED
	}

	local function var_7_1(arg_8_0, arg_8_1, arg_8_2)
		local var_8_0 = arg_8_1 and arg_8_1.id or arg_8_2 or 0
		local var_8_1 = arg_8_1 and arg_8_1.send_time or 0

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

function var_0_0.IndexItem(arg_9_0, arg_9_1, arg_9_2)
	local var_9_0 = arg_9_0.dataList_[arg_9_1]

	if not var_9_0 then
		return
	end

	arg_9_2:SetData(var_9_0, arg_9_0.selectedSenderID_)
end

function var_0_0.OnOpenChat(arg_10_0, arg_10_1, arg_10_2)
	arg_10_0.selectedSenderID_ = arg_10_1
	arg_10_0.selectedSessionID_ = arg_10_2

	if arg_10_0.luaList_ and arg_10_0.dataList_ then
		arg_10_0.luaList_:Refresh()
	end
end

function var_0_0.OnBackToList(arg_11_0)
	arg_11_0.selectedSenderID_ = nil
	arg_11_0.selectedSessionID_ = nil

	if arg_11_0.luaList_ and arg_11_0.dataList_ then
		arg_11_0.luaList_:Refresh()
	end
end

function var_0_0.OnMomoTalkUpdate(arg_12_0)
	arg_12_0:Refresh()
end

function var_0_0.Dispose(arg_13_0)
	if arg_13_0.luaList_ then
		arg_13_0.luaList_:Dispose()

		arg_13_0.luaList_ = nil
	end

	var_0_0.super.Dispose(arg_13_0)
end

return var_0_0
