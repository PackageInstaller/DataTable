local var_0_0 = class("Dorm3dChatCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = getProxy(Dorm3dChatProxy)

	if var_1_0.operation == Dorm3dChatProxy.APARTMENT_CHAT_REPLY then
		pg.ConnectionMgr.GetInstance():Send(28028, {
			type = 1,
			ship_id = var_1_0.characterId,
			id = var_1_0.topicId,
			chat_id = var_1_0.wordId,
			value = var_1_0.replyId
		}, 28029, function(arg_2_0)
			if arg_2_0.result == 0 then
				var_1_1:SetTopicReaded(var_1_0.topicId, 0)
				var_1_1:UpdateTopicDisplayWordList(var_1_0.topicId, var_1_0.wordId, var_1_0.replyId)

				if var_1_0.isRedPacket then
					arg_1_0:sendNotification(GAME.APARTMENT_CHAT_OP_DONE, {
						operation = var_1_0.operation,
						awards = PlayerConst.addTranDrop(arg_2_0.drop_list),
						redPacketId = var_1_0.replyId
					})
				else
					arg_1_0:sendNotification(GAME.APARTMENT_CHAT_OP_DONE, {
						operation = var_1_0.operation
					})
				end

				if var_1_0.callback then
					var_1_0.callback()
				end
			else
				pg.TipsMgr.GetInstance():ShowTips(ERROR_MESSAGE[arg_2_0.result] .. arg_2_0.result)
			end

			return
		end)
	elseif var_1_0.operation == Dorm3dChatProxy.APARTMENT_CHAT_SET_SKIN then
		pg.ConnectionMgr.GetInstance():Send(28030, {
			ship_id = var_1_0.characterId,
			back_id = var_1_0.skinId
		}, 28031, function(arg_3_0)
			if arg_3_0.result == 0 then
				var_1_1:SetChatSkin(var_1_0.characterId, var_1_0.skinId)
				arg_1_0:sendNotification(GAME.APARTMENT_CHAT_OP_DONE, {
					operation = var_1_0.operation
				})

				if var_1_0.callback then
					var_1_0.callback()
				end
			else
				pg.TipsMgr.GetInstance():ShowTips(ERROR_MESSAGE[arg_3_0.result] .. arg_3_0.result)
			end

			return
		end)
	elseif var_1_0.operation == Dorm3dChatProxy.APARTMENT_CHAT_SET_CARE then
		pg.ConnectionMgr.GetInstance():Send(28032, {
			ship_id = var_1_0.characterId,
			value = var_1_0.care
		}, 28033, function(arg_4_0)
			if arg_4_0.result == 0 then
				var_1_1:GetCharacterChatById(var_1_0.characterId):SetCare(var_1_0.care)
				arg_1_0:sendNotification(GAME.APARTMENT_CHAT_OP_DONE, {
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
	elseif var_1_0.operation == Dorm3dChatProxy.APARTMENT_CHAT_SET_TOPIC then
		pg.ConnectionMgr.GetInstance():Send(28034, {
			ship_id = var_1_0.characterId,
			comm_id = var_1_0.topicId
		}, 28035, function(arg_5_0)
			if arg_5_0.result == 0 then
				var_1_1:SetCurrentTopic(var_1_0.topicId)
				arg_1_0:sendNotification(GAME.APARTMENT_CHAT_OP_DONE, {
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
	elseif var_1_0.operation == Dorm3dChatProxy.APARTMENT_CHAT_SET_READTIP then
		pg.ConnectionMgr.GetInstance():Send(28026, {
			type = 1,
			ship_id = var_1_0.characterId,
			id_list = var_1_0.topicIdList
		}, 28027, function(arg_6_0)
			if arg_6_0.result == 0 then
				if var_1_0.topicIdList and #var_1_0.topicIdList > 0 then
					for iter_6_0, iter_6_1 in ipairs(var_1_0.topicIdList) do
						var_1_1:SetTopicReaded(iter_6_1, 1)
					end
				end

				arg_1_0:sendNotification(GAME.APARTMENT_CHAT_OP_DONE, {
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
	elseif var_1_0.operation == Dorm3dChatProxy.APARTMENT_CHAT_TRIGGER_EVENT then
		pg.ConnectionMgr.GetInstance():Send(28023, {
			event_list = var_1_0.eventList
		}, 28024, function(arg_7_0)
			if arg_7_0.result == 0 then
				if var_1_0.callback then
					var_1_0.callback()
				end
			else
				pg.TipsMgr.GetInstance():ShowTips(ERROR_MESSAGE[arg_7_0.result] .. arg_7_0.result)
			end

			return
		end)
	end

	return
end

return var_0_0
