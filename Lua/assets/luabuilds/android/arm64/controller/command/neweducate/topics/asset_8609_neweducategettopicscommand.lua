local NewEducateGetTopicsCommand = class("NewEducateGetTopicsCommand", pm.SimpleCommand)

function NewEducateGetTopicsCommand:execute(arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = var_1_0 and var_1_0.callback

	pg.ConnectionMgr.GetInstance():Send(29015, {
		id = var_1_0.id
	}, 29016, function(arg_2_0)
		if arg_2_0.result == 0 then
			local var_2_0 = getProxy(NewEducateProxy):GetCurChar():GetFSM()

			var_2_0:SetSystemNo(NewEducateFSM.SYSTEM.TOPIC)
			var_2_0:SetState(NewEducateFSM.SYSTEM.TOPIC, (NewEducateTopicState.New({
				finished = #arg_2_0.chats == 0 and 1 or 0,
				chats = arg_2_0.chats
			})))
			existCall(var_1_1)
		else
			pg.TipsMgr.GetInstance():ShowTips("NewEducate_GetTopics: " .. arg_2_0.result)
		end

		return
	end)

	return
end

return NewEducateGetTopicsCommand
