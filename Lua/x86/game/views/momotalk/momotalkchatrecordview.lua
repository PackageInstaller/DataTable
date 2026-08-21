local var_0_0 = class("MomoTalkChatRecordView", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:BindCfgUI()
	arg_1_0:InitList()
	arg_1_0:AddListeners()
end

function var_0_0.InitList(arg_2_0)
	if arg_2_0.historylistGo_ then
		arg_2_0.luaList_ = LuaList.New(handler(arg_2_0, arg_2_0.IndexItem), arg_2_0.historylistGo_, MomoTalkRecordItem)
	end
end

function var_0_0.AddListeners(arg_3_0)
	arg_3_0:AddBtnListener(arg_3_0.backBtn_, nil, function()
		arg_3_0.currentSessionID_ = arg_3_0.currentSessionID_ or arg_3_0:GetDefaultSessionID()

		if not arg_3_0.currentSessionID_ then
			return
		end

		manager.notify:Invoke(MOMOTALK_OPEN_CHAT, arg_3_0.senderID_, arg_3_0.currentSessionID_)
	end)
end

function var_0_0.OnEnter(arg_5_0)
	return
end

function var_0_0.OnExit(arg_6_0)
	return
end

function var_0_0.SetData(arg_7_0, arg_7_1)
	arg_7_0.senderID_ = arg_7_1
	arg_7_0.currentSessionID_ = nil
	arg_7_0.recordList_ = arg_7_0:BuildRecordList()
	arg_7_0.currentSessionID_ = arg_7_0:GetDefaultSessionID()

	arg_7_0:RefreshHeader()

	if arg_7_0.luaList_ then
		arg_7_0.luaList_:StartScroll(#arg_7_0.recordList_)
	end
end

function var_0_0.RefreshHeader(arg_8_0)
	if not arg_8_0.nameText_ then
		return
	end

	local var_8_0 = MomoTalkTools.GetSessionDisplayName(arg_8_0.currentSessionID_, arg_8_0.senderID_)

	if var_8_0 == "" and arg_8_0.senderID_ and ChatHeroCfg[arg_8_0.senderID_] then
		var_8_0 = GetI18NText(ChatHeroCfg[arg_8_0.senderID_].name or "")
	end

	arg_8_0.nameText_.text = var_8_0
end

function var_0_0.BuildRecordList(arg_9_0)
	local var_9_0 = {}
	local var_9_1 = MomoTalkData:GetData2(MomoTalkConst.DATA_TYPE.CHAT, arg_9_0.senderID_)

	for iter_9_0, iter_9_1 in pairs(var_9_1 or {}) do
		if iter_9_1 and (#(iter_9_1.save_list or {}) > 0 or iter_9_1.is_view ~= nil) then
			table.insert(var_9_0, {
				sessionID = iter_9_0,
				session = iter_9_1,
				preview = MomoTalkTools.GetSessionFirstPreviewContent(iter_9_1)
			})
		end
	end

	table.sort(var_9_0, function(arg_10_0, arg_10_1)
		return arg_10_0.sessionID < arg_10_1.sessionID
	end)

	return var_9_0
end

function var_0_0.IndexItem(arg_11_0, arg_11_1, arg_11_2)
	local var_11_0 = arg_11_0.recordList_[arg_11_1]

	if not var_11_0 then
		return
	end

	arg_11_2:SetData(var_11_0, function(arg_12_0)
		if not arg_12_0 then
			return
		end

		arg_11_0.currentSessionID_ = arg_12_0

		manager.notify:Invoke(MOMOTALK_OPEN_CHAT, arg_11_0.senderID_, arg_12_0, "top")
	end)
end

function var_0_0.GetDefaultSessionID(arg_13_0)
	if arg_13_0.recordList_ and #arg_13_0.recordList_ > 0 then
		return arg_13_0.recordList_[#arg_13_0.recordList_].sessionID
	end

	local var_13_0 = MomoTalkData:GetData2(MomoTalkConst.DATA_TYPE.CHAT, arg_13_0.senderID_)
	local var_13_1

	for iter_13_0, iter_13_1 in pairs(var_13_0 or {}) do
		local var_13_2 = iter_13_1 and iter_13_1.id or iter_13_0

		if var_13_2 and (not var_13_1 or var_13_1 < var_13_2) then
			var_13_1 = var_13_2
		end
	end

	return var_13_1
end

function var_0_0.Dispose(arg_14_0)
	if arg_14_0.luaList_ then
		arg_14_0.luaList_:Dispose()

		arg_14_0.luaList_ = nil
	end

	var_0_0.super.Dispose(arg_14_0)
end

return var_0_0
