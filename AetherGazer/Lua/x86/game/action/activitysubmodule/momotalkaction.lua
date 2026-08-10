local var_0_0 = {}

manager.net:Bind(91001, function(arg_1_0)
	MomoTalkData:InitData(arg_1_0)
	manager.notify:Invoke(MOMOTALK_UPDATE)
end)
manager.net:Bind(91021, function(arg_2_0)
	MomoTalkData:UpdateData(arg_2_0)
	manager.notify:Invoke(MOMOTALK_UPDATE)
end)

function var_0_0.AddMomoTalkBreak(arg_3_0, arg_3_1, arg_3_2)
	local var_3_0 = {
		session_id = arg_3_0,
		content_id = arg_3_1
	}

	manager.net:SendWithLoadingNew(91014, var_3_0, 91015, function(arg_4_0)
		if isSuccess(arg_4_0.result) then
			local var_4_0 = ChatMessageCfg[arg_3_0]
			local var_4_1 = MomoTalkData:GetData3(var_4_0.type, var_4_0.sender, arg_3_0)
			local var_4_2 = false

			for iter_4_0, iter_4_1 in ipairs(var_4_1.save_list or {}) do
				if iter_4_1.content_id == arg_3_1 then
					var_4_2 = true

					break
				end
			end

			if not var_4_2 then
				table.insert(var_4_1.save_list, {
					state = 0,
					content_id = arg_3_1
				})
			end

			var_4_1.current_content_id = arg_3_1

			MomoTalkData:UpdateData(var_4_1)
			manager.notify:Invoke(MOMOTALK_CHAT_UPDATE)

			if arg_3_2 then
				arg_3_2(true)
			end
		else
			if arg_3_2 then
				arg_3_2(false)
			end

			ShowTips(arg_4_0.result)
		end
	end)
end

function var_0_0.FinishMomoTalkBreak(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	local var_5_0 = {
		session_id = arg_5_0,
		content_id = arg_5_1,
		state = arg_5_2
	}

	manager.net:SendWithLoadingNew(91002, var_5_0, 91003, function(arg_6_0)
		if isSuccess(arg_6_0.result) then
			local var_6_0 = ChatMessageCfg[arg_5_0]
			local var_6_1 = MomoTalkData:GetData3(var_6_0.type, var_6_0.sender, arg_5_0)

			for iter_6_0, iter_6_1 in ipairs(var_6_1.save_list) do
				if iter_6_1.content_id == arg_5_1 then
					var_6_1.save_list[iter_6_0].state = arg_5_2
				end
			end

			MomoTalkData:UpdateData(var_6_1)
			manager.notify:Invoke(MOMOTALK_CHAT_UPDATE)

			if arg_5_3 then
				arg_5_3()
			end
		else
			ShowTips(arg_6_0.result)
		end
	end)
end

function var_0_0.SetRead(arg_7_0, arg_7_1)
	local var_7_0 = {
		session_id = arg_7_0
	}

	manager.net:SendWithLoadingNew(91006, var_7_0, 91007, function(arg_8_0)
		if isSuccess(arg_8_0.result) then
			local var_8_0 = ChatMessageCfg[arg_7_0]
			local var_8_1 = MomoTalkData:GetData3(var_8_0.type, var_8_0.sender, arg_7_0)

			var_8_1.is_view = 1

			MomoTalkData:UpdateData(var_8_1)
			manager.notify:Invoke(MOMOTALK_CHAT_LIST_UPDATE)
		else
			ShowTips(arg_8_0.result)
		end
	end)
end

function var_0_0.SetMomoFrame(arg_9_0, arg_9_1)
	local var_9_0 = {
		icon = arg_9_0
	}

	manager.net:SendWithLoadingNew(91016, var_9_0, 91017, function(arg_10_0)
		if isSuccess(arg_10_0.result) then
			if arg_9_1 then
				arg_9_1()
			end
		else
			ShowTips(arg_10_0.result)
		end
	end)
end

return var_0_0
