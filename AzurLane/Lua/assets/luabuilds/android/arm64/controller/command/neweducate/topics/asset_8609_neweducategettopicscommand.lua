class = var_0_10000

local var_0_0 = "NewEducateGetTopicsCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody() and var_2.callback
	local var_1_1 = var_2.id

	pg = var_1_10005

	local var_1_2 = var_1_10005.ConnectionMgr.GetInstance()

	var_5.Send(var_1_2, 29015, {
		id = var_1_1
	}, 29016, function(arg_2_0)
		if arg_2_0.result == 0 then
			getProxy = var_1
			NewEducateProxy = var_2_10003

			local var_2_0 = var_1(var_2_10003)
			local var_2_1 = var_1.GetCurChar(var_2_0)
			local var_2_2 = var_1.GetFSM(var_2_1)
			local var_2_3 = var_1.SetSystemNo

			NewEducateFSM = var_2_10005

			var_2_3(var_2_2, var_2_10005.SYSTEM.TOPIC)

			NewEducateTopicState = var_2_3

			local var_2_4 = var_2_3.New({
				finished = #arg_2_0.chats == 0 and 1 or 0,
				chats = arg_2_0.chats
			})
			local var_2_5 = var_1
			local var_2_6 = var_1.SetState

			NewEducateFSM = var_2_10006

			var_2_6(var_2_5, var_2_10006.SYSTEM.TOPIC, var_2_4)

			existCall = var_2_6

			var_2_6(var_1_0)
		else
			pg = var_1

			local var_2_7 = var_1.TipsMgr.GetInstance()

			var_1.ShowTips(var_2_7, "NewEducate_GetTopics: " .. arg_2_0.result)
		end

		return
	end)

	return
end

return var_0_1
