class = var_0_10000

local var_0_0 = "NewEducateSelTopicCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().id
	local var_1_1 = var_2.topicId

	pg = var_1_10005

	local var_1_2 = var_1_10005.ConnectionMgr.GetInstance()

	var_5.Send(var_1_2, 29017, {
		id = var_1_0,
		chat_id = var_1_1
	}, 29018, function(arg_2_0)
		if arg_2_0.result == 0 then
			getProxy = var_1
			NewEducateProxy = var_2_10003

			local var_2_0 = var_1(var_2_10003)
			local var_2_1 = var_1.GetCurChar(var_2_0)
			local var_2_2 = var_1.GetFSM(var_2_1)
			local var_2_3 = var_1.SetSystemNo

			NewEducateFSM = var_2_10005

			var_2_3(var_2_2, var_2_10005.SYSTEM.TOPIC)

			local var_2_4 = var_1
			local var_2_5 = var_1.GetState

			NewEducateFSM = var_5

			local var_2_6 = var_2_5(var_2_4, var_5.SYSTEM.TOPIC)

			var_2.MarkFinish(var_2_6)
			var_1:SetCurNode(arg_2_0.first_node)

			NewEducateDropHelper = var_2

			local var_2_7 = var_2.HandleDrops(arg_2_0.drop)
			local var_2_8 = arg_1_0
			local var_2_9 = var_3.sendNotification

			GAME = var_2_10006

			var_2_9(var_2_8, var_2_10006.NEW_EDUCATE_SEL_TOPIC_DONE, {
				drops = var_2_7,
				node = arg_2_0.first_node
			})
		else
			pg = var_1

			local var_2_10 = var_1.TipsMgr.GetInstance()

			var_1.ShowTips(var_2_10, "NewEducate_SelTopic: " .. arg_2_0.result)
		end

		return
	end)

	return
end

return var_0_1
