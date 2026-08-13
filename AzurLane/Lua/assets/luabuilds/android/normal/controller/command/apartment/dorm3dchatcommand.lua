class = var_0_10000

local var_0_0 = "Dorm3dChatCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1
	local var_1_1 = arg_1_1.getBody(var_1_0)

	getProxy = var_1_0
	Dorm3dChatProxy = var_1_10004

	local var_1_2 = var_1_0(var_1_10004)
	local var_1_3 = var_1_1.operation

	Dorm3dChatProxy = var_1_10005

	local var_1_4

	if var_1_3 == var_1_10005.APARTMENT_CHAT_REPLY then
		pg = var_1_3
		var_1_4 = var_1_3.ConnectionMgr.GetInstance()

		var_4.Send(var_1_4, 28028, {
			type = 1,
			ship_id = var_1_1.characterId,
			id = var_1_1.topicId,
			chat_id = var_1_1.wordId,
			value = var_1_1.replyId
		}, 28029, function(arg_2_0)
			local var_2_2

			if arg_2_0.result == 0 then
				local var_2_0 = var_1_2

				var_2_2.SetTopicReaded(var_2_0, var_1_1.topicId, 0)

				local var_2_1 = var_1_2

				var_2_2.UpdateTopicDisplayWordList(var_2_1, var_1_1.topicId, var_1_1.wordId, var_1_1.replyId)

				if var_1_1.isRedPacket then
					PlayerConst = var_2_2
					var_2_2 = var_2_2.addTranDrop(arg_2_0.drop_list)
					var_2_10003 = arg_1_0

					local var_2_3 = var_2.sendNotification

					GAME = var_4

					var_2_3(var_2_10003, var_4.APARTMENT_CHAT_OP_DONE, {
						operation = var_1_1.operation,
						awards = var_2_2,
						redPacketId = var_1_1.replyId
					})
				else
					local var_2_4 = arg_1_0

					var_2_2 = var_2_2.sendNotification
					GAME = var_2_10003

					var_2_2(var_2_4, var_2_10003.APARTMENT_CHAT_OP_DONE, {
						operation = var_1_1.operation
					})
				end

				if var_1_1.callback then
					var_1_1.callback()
				end
			else
				pg = var_2_2

				local var_2_5 = var_2_2.TipsMgr.GetInstance()
				local var_2_6 = var_1.ShowTips

				ERROR_MESSAGE = var_2_10003

				var_2_6(var_2_5, var_2_10003[arg_2_0.result] .. arg_2_0.result)
			end

			return
		end)
	else
		local var_1_5 = var_1_1.operation

		Dorm3dChatProxy = var_1_4

		local var_1_6

		if var_1_5 == var_1_4.APARTMENT_CHAT_SET_SKIN then
			pg = var_1_5
			var_1_6 = var_1_5.ConnectionMgr.GetInstance()

			var_4.Send(var_1_6, 28030, {
				ship_id = var_1_1.characterId,
				back_id = var_1_1.skinId
			}, 28031, function(arg_3_0)
				local var_3_2

				if arg_3_0.result == 0 then
					local var_3_0 = var_1_2

					var_3_2.SetChatSkin(var_3_0, var_1_1.characterId, var_1_1.skinId)

					local var_3_1 = arg_1_0

					var_3_2 = var_3_2.sendNotification
					GAME = var_2_10003

					var_3_2(var_3_1, var_2_10003.APARTMENT_CHAT_OP_DONE, {
						operation = var_1_1.operation
					})

					if var_1_1.callback then
						var_1_1.callback()
					end
				else
					pg = var_3_2

					local var_3_3 = var_3_2.TipsMgr.GetInstance()
					local var_3_4 = var_1.ShowTips

					ERROR_MESSAGE = var_2_10003

					var_3_4(var_3_3, var_2_10003[arg_3_0.result] .. arg_3_0.result)
				end

				return
			end)
		else
			local var_1_7 = var_1_1.operation

			Dorm3dChatProxy = var_1_6

			local var_1_8

			if var_1_7 == var_1_6.APARTMENT_CHAT_SET_CARE then
				pg = var_1_7
				var_1_8 = var_1_7.ConnectionMgr.GetInstance()

				var_4.Send(var_1_8, 28032, {
					ship_id = var_1_1.characterId,
					value = var_1_1.care
				}, 28033, function(arg_4_0)
					local var_4_3

					if arg_4_0.result == 0 then
						local var_4_0 = var_1_2
						local var_4_1 = var_4_3.GetCharacterChatById(var_4_0, var_1_1.characterId)

						var_4_3.SetCare(var_4_1, var_1_1.care)

						local var_4_2 = arg_1_0

						var_4_3 = var_4_3.sendNotification
						GAME = var_2_10003

						var_4_3(var_4_2, var_2_10003.APARTMENT_CHAT_OP_DONE, {
							operation = var_1_1.operation
						})

						if var_1_1.callback then
							var_1_1.callback()
						end
					else
						pg = var_4_3

						local var_4_4 = var_4_3.TipsMgr.GetInstance()
						local var_4_5 = var_1.ShowTips

						ERROR_MESSAGE = var_2_10003

						var_4_5(var_4_4, var_2_10003[arg_4_0.result] .. arg_4_0.result)
					end

					return
				end)
			else
				local var_1_9 = var_1_1.operation

				Dorm3dChatProxy = var_1_8

				local var_1_10

				if var_1_9 == var_1_8.APARTMENT_CHAT_SET_TOPIC then
					pg = var_1_9
					var_1_10 = var_1_9.ConnectionMgr.GetInstance()

					var_4.Send(var_1_10, 28034, {
						ship_id = var_1_1.characterId,
						comm_id = var_1_1.topicId
					}, 28035, function(arg_5_0)
						local var_5_2

						if arg_5_0.result == 0 then
							local var_5_0 = var_1_2

							var_5_2.SetCurrentTopic(var_5_0, var_1_1.topicId)

							local var_5_1 = arg_1_0

							var_5_2 = var_5_2.sendNotification
							GAME = var_2_10003

							var_5_2(var_5_1, var_2_10003.APARTMENT_CHAT_OP_DONE, {
								operation = var_1_1.operation
							})

							if var_1_1.callback then
								var_1_1.callback()
							end
						else
							pg = var_5_2

							local var_5_3 = var_5_2.TipsMgr.GetInstance()
							local var_5_4 = var_1.ShowTips

							ERROR_MESSAGE = var_2_10003

							var_5_4(var_5_3, var_2_10003[arg_5_0.result] .. arg_5_0.result)
						end

						return
					end)
				else
					local var_1_11 = var_1_1.operation

					Dorm3dChatProxy = var_1_10

					local var_1_12

					if var_1_11 == var_1_10.APARTMENT_CHAT_SET_READTIP then
						pg = var_1_11
						var_1_12 = var_1_11.ConnectionMgr.GetInstance()

						var_4.Send(var_1_12, 28026, {
							type = 1,
							ship_id = var_1_1.characterId,
							id_list = var_1_1.topicIdList
						}, 28027, function(arg_6_0)
							local var_6_2

							if arg_6_0.result == 0 then
								if var_1_1.topicIdList and #var_1_1.topicIdList > 0 then
									ipairs = var_6_2

									for iter_6_0, iter_6_1 in var_6_2(var_1_1.topicIdList) do
										local var_6_0 = var_1_2

										var_6.SetTopicReaded(var_6_0, iter_6_1, 1)
									end
								end

								local var_6_1 = arg_1_0

								var_6_2 = var_6_2.sendNotification
								GAME = var_2_10003

								var_6_2(var_6_1, var_2_10003.APARTMENT_CHAT_OP_DONE, {
									operation = var_1_1.operation
								})

								if var_1_1.callback then
									var_1_1.callback()
								end
							else
								pg = var_6_2

								local var_6_3 = var_6_2.TipsMgr.GetInstance()
								local var_6_4 = var_1.ShowTips

								ERROR_MESSAGE = var_2_10003

								var_6_4(var_6_3, var_2_10003[arg_6_0.result] .. arg_6_0.result)
							end

							return
						end)
					else
						local var_1_13 = var_1_1.operation

						Dorm3dChatProxy = var_1_12

						if var_1_13 == var_1_12.APARTMENT_CHAT_TRIGGER_EVENT then
							pg = var_1_13

							local var_1_14 = var_1_13.ConnectionMgr.GetInstance()

							var_4.Send(var_1_14, 28023, {
								event_list = var_1_1.eventList
							}, 28024, function(arg_7_0)
								if arg_7_0.result == 0 then
									if var_1_1.callback then
										var_1_1.callback()
									end
								else
									pg = var_1

									local var_7_0 = var_1.TipsMgr.GetInstance()
									local var_7_1 = var_1.ShowTips

									ERROR_MESSAGE = var_2_10003

									var_7_1(var_7_0, var_2_10003[arg_7_0.result] .. arg_7_0.result)
								end

								return
							end)
						end
					end
				end
			end
		end
	end

	return
end

return var_0_1
