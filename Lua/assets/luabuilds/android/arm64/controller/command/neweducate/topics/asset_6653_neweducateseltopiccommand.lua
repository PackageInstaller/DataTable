local NewEducateSelTopicCommand = class("NewEducateSelTopicCommand", pm.SimpleCommand)

function NewEducateSelTopicCommand:execute(arg_1_1)
	local var_1_0 = arg_1_1:getBody()

	pg.ConnectionMgr.GetInstance():Send(29017, {
		id = var_1_0.id,
		chat_id = var_1_0.topicId
	}, 29018, function(arg_2_0)
		if arg_2_0.result == 0 then
			local var_2_0 = getProxy(NewEducateProxy):GetCurChar():GetFSM()

			var_2_0:SetSystemNo(NewEducateFSM.SYSTEM.TOPIC)
			var_2_0:GetState(NewEducateFSM.SYSTEM.TOPIC):MarkFinish()
			var_2_0:SetCurNode(arg_2_0.first_node)
			self:sendNotification(GAME.NEW_EDUCATE_SEL_TOPIC_DONE, {
				drops = NewEducateDropHelper.HandleDrops(arg_2_0.drop),
				node = arg_2_0.first_node
			})
		else
			pg.TipsMgr.GetInstance():ShowTips("NewEducate_SelTopic: " .. arg_2_0.result)
		end

		return
	end)

	return
end

return NewEducateSelTopicCommand
