local var_0_0 = class("InstagramChatCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = getProxy(InstagramChatProxy)

	if var_1_0.operation == ActivityConst.INSTAGRAM_CHAT_GET_DATA then
		pg.ConnectionMgr.GetInstance():Send(11710, {
			type = 0
		}, 11711, function(arg_2_0)
			for iter_2_0, iter_2_1 in ipairs(arg_2_0.groups) do
				table.insert({}, (InstagramChat.New(iter_2_1)))
			end

			var_1_1:SetChatList({})
			arg_1_0:sendNotification(GAME.ACT_INSTAGRAM_CHAT_DONE, {
				operation = var_1_0.operation
			})

			if var_1_0.callback then
				var_1_0.callback()
			end

			return
		end)
	elseif var_1_0.operation == ActivityConst.INSTAGRAM_CHAT_REPLY then
		pg.ConnectionMgr.GetInstance():Send(11712, {
			chat_group_id = var_1_0.topicId,
			chat_id = var_1_0.wordId,
			value = var_1_0.replyId
		}, 11713, function(arg_3_0)
			if arg_3_0.result == 0 then
				var_1_1:SetTopicOperationTime(var_1_0.topicId, arg_3_0.op_time)
				var_1_1:SetTopicReaded(var_1_0.topicId, 0)
				var_1_1:UpdateTopicDisplayWordList(var_1_0.topicId, var_1_0.wordId, var_1_0.replyId)

				if var_1_0.isRedPacket then
					arg_1_0:sendNotification(GAME.ACT_INSTAGRAM_CHAT_DONE, {
						operation = var_1_0.operation,
						awards = PlayerConst.addTranDrop(arg_3_0.drop_list),
						redPacketId = var_1_0.replyId
					})
				else
					arg_1_0:sendNotification(GAME.ACT_INSTAGRAM_CHAT_DONE, {
						operation = var_1_0.operation
					})
				end

				if var_1_0.callback then
					var_1_0.callback()
				end
			else
				pg.TipsMgr.GetInstance():ShowTips(ERROR_MESSAGE[arg_3_0.result] .. arg_3_0.result)
			end

			return
		end)
	elseif var_1_0.operation == ActivityConst.INSTAGRAM_CHAT_SET_SKIN then
		pg.ConnectionMgr.GetInstance():Send(11714, {
			group_id = var_1_0.characterId,
			skin_id = var_1_0.skinId
		}, 11715, function(arg_4_0)
			if arg_4_0.result == 0 then
				var_1_1:SetChatSkin(var_1_0.characterId, var_1_0.skinId)
				arg_1_0:sendNotification(GAME.ACT_INSTAGRAM_CHAT_DONE, {
					operation = var_1_0.operation
				})

				if var_1_0.callback then
					var_1_0.callback()
				end
			else
				pg.TipsMgr.GetInstance():ShowTips(ERROR_MESSAGE[arg_4_0.result] .. arg_4_0.result)
			end

			return
		end)
	elseif var_1_0.operation == ActivityConst.INSTAGRAM_CHAT_SET_CARE then
		pg.ConnectionMgr.GetInstance():Send(11716, {
			group_id = var_1_0.characterId,
			value = var_1_0.care
		}, 11717, function(arg_5_0)
			if arg_5_0.result == 0 then
				var_1_1:GetCharacterChatById(var_1_0.characterId):SetCare(var_1_0.care)
				var_1_1:SortChatList()
				arg_1_0:sendNotification(GAME.ACT_INSTAGRAM_CHAT_DONE, {
					operation = var_1_0.operation
				})

				if var_1_0.callback then
					var_1_0.callback()
				end
			else
				pg.TipsMgr.GetInstance():ShowTips(ERROR_MESSAGE[arg_5_0.result] .. arg_5_0.result)
			end

			return
		end)
	elseif var_1_0.operation == ActivityConst.INSTAGRAM_CHAT_SET_TOPIC then
		pg.ConnectionMgr.GetInstance():Send(11718, {
			chat_group_id = var_1_0.topicId
		}, 11719, function(arg_6_0)
			if arg_6_0.result == 0 then
				var_1_1:SetCurrentTopic(var_1_0.topicId)
				arg_1_0:sendNotification(GAME.ACT_INSTAGRAM_CHAT_DONE, {
					operation = var_1_0.operation
				})

				if var_1_0.callback then
					var_1_0.callback()
				end
			else
				pg.TipsMgr.GetInstance():ShowTips(ERROR_MESSAGE[arg_6_0.result] .. arg_6_0.result)
			end

			return
		end)
	elseif var_1_0.operation == ActivityConst.INSTAGRAM_CHAT_SET_READTIP then
		pg.ConnectionMgr.GetInstance():Send(11720, {
			chat_group_id_list = var_1_0.topicIdList
		}, 11721, function(arg_7_0)
			if arg_7_0.result == 0 then
				if var_1_0.topicIdList and #var_1_0.topicIdList > 0 then
					for iter_7_0, iter_7_1 in ipairs(var_1_0.topicIdList) do
						var_1_1:SetTopicReaded(iter_7_1, 1)
					end
				else
					var_1_1:SetAllTopicsReaded()
				end

				arg_1_0:sendNotification(GAME.ACT_INSTAGRAM_CHAT_DONE, {
					operation = var_1_0.operation
				})

				if var_1_0.callback then
					var_1_0.callback()
				end
			else
				pg.TipsMgr.GetInstance():ShowTips(ERROR_MESSAGE[arg_7_0.result] .. arg_7_0.result)
			end

			return
		end)
	elseif var_1_0.operation == ActivityConst.INSTAGRAM_CHAT_ACTIVATE_TOPIC then
		pg.ConnectionMgr.GetInstance():Send(11722, {
			chat_group_id_list = var_1_0.topicIdList
		}, 11723, function(arg_8_0)
			for iter_8_0, iter_8_1 in ipairs(arg_8_0.result_list) do
				if iter_8_1 == 0 then
					if var_1_1:GetCharacterChatByTopicId(var_1_0.topicIdList[iter_8_0]) then
						var_1_1:GetTopicById(var_1_0.topicIdList[iter_8_0]):Activate(arg_8_0.op_time)
					else
						var_1_1:CreateNewChat(var_1_0.topicIdList[iter_8_0], arg_8_0.op_time)
					end

					var_1_1:RemoveNotActiveTopicId(var_1_0.topicIdList[iter_8_0])
				else
					pg.TipsMgr.GetInstance():ShowTips(ERROR_MESSAGE[iter_8_1] .. iter_8_1)
				end
			end

			var_1_1:SortChatList()
			arg_1_0:sendNotification(GAME.ACT_INSTAGRAM_CHAT_DONE, {
				operation = var_1_0.operation
			})

			if var_1_0.callback then
				var_1_0.callback()
			end

			return
		end)
	end

	return
end

return var_0_0
