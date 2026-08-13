class = var_0_10000

local var_0_0 = "InstagramChatCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1
	local var_1_1 = arg_1_1.getBody(var_1_0)

	getProxy = var_1_0
	InstagramChatProxy = var_1_10004

	local var_1_2 = var_1_0(var_1_10004)
	local var_1_3 = var_1_1.operation

	ActivityConst = var_1_10005

	local var_1_4

	if var_1_3 == var_1_10005.INSTAGRAM_CHAT_GET_DATA then
		pg = var_1_3
		var_1_4 = var_1_3.ConnectionMgr.GetInstance()

		var_4.Send(var_1_4, 11710, {
			type = 0
		}, 11711, function(arg_2_0)
			local var_2_0 = {}

			ipairs = var_2_10002

			for iter_2_0, iter_2_1 in var_2_10002(arg_2_0.groups) do
				InstagramChat = var_2_10007
				var_2_10007 = var_2_10007.New(iter_2_1)
				table = var_8

				var_8.insert(var_2_0, var_2_10007)
			end

			local var_2_1 = var_1_2

			var_2.SetChatList(var_2_1, var_2_0)

			local var_2_2 = arg_1_0
			local var_2_3 = var_2.sendNotification

			GAME = var_4

			var_2_3(var_2_2, var_4.ACT_INSTAGRAM_CHAT_DONE, {
				operation = var_1_1.operation
			})

			if var_1_1.callback then
				var_1_1.callback()
			end

			return
		end)
	else
		local var_1_5 = var_1_1.operation

		ActivityConst = var_1_4

		local var_1_6

		if var_1_5 == var_1_4.INSTAGRAM_CHAT_REPLY then
			pg = var_1_5
			var_1_6 = var_1_5.ConnectionMgr.GetInstance()

			var_4.Send(var_1_6, 11712, {
				chat_group_id = var_1_1.topicId,
				chat_id = var_1_1.wordId,
				value = var_1_1.replyId
			}, 11713, function(arg_3_0)
				local var_3_3

				if arg_3_0.result == 0 then
					local var_3_0 = var_1_2

					var_3_3.SetTopicOperationTime(var_3_0, var_1_1.topicId, arg_3_0.op_time)

					local var_3_1 = var_1_2

					var_3_3.SetTopicReaded(var_3_1, var_1_1.topicId, 0)

					local var_3_2 = var_1_2

					var_3_3.UpdateTopicDisplayWordList(var_3_2, var_1_1.topicId, var_1_1.wordId, var_1_1.replyId)

					if var_1_1.isRedPacket then
						PlayerConst = var_3_3
						var_3_3 = var_3_3.addTranDrop(arg_3_0.drop_list)
						var_2_10003 = arg_1_0

						local var_3_4 = var_2.sendNotification

						GAME = var_4

						var_3_4(var_2_10003, var_4.ACT_INSTAGRAM_CHAT_DONE, {
							operation = var_1_1.operation,
							awards = var_3_3,
							redPacketId = var_1_1.replyId
						})
					else
						local var_3_5 = arg_1_0

						var_3_3 = var_3_3.sendNotification
						GAME = var_2_10003

						var_3_3(var_3_5, var_2_10003.ACT_INSTAGRAM_CHAT_DONE, {
							operation = var_1_1.operation
						})
					end

					if var_1_1.callback then
						var_1_1.callback()
					end
				else
					pg = var_3_3

					local var_3_6 = var_3_3.TipsMgr.GetInstance()
					local var_3_7 = var_1.ShowTips

					ERROR_MESSAGE = var_2_10003

					var_3_7(var_3_6, var_2_10003[arg_3_0.result] .. arg_3_0.result)
				end

				return
			end)
		else
			local var_1_7 = var_1_1.operation

			ActivityConst = var_1_6

			local var_1_8

			if var_1_7 == var_1_6.INSTAGRAM_CHAT_SET_SKIN then
				pg = var_1_7
				var_1_8 = var_1_7.ConnectionMgr.GetInstance()

				var_4.Send(var_1_8, 11714, {
					group_id = var_1_1.characterId,
					skin_id = var_1_1.skinId
				}, 11715, function(arg_4_0)
					local var_4_2

					if arg_4_0.result == 0 then
						local var_4_0 = var_1_2

						var_4_2.SetChatSkin(var_4_0, var_1_1.characterId, var_1_1.skinId)

						local var_4_1 = arg_1_0

						var_4_2 = var_4_2.sendNotification
						GAME = var_2_10003

						var_4_2(var_4_1, var_2_10003.ACT_INSTAGRAM_CHAT_DONE, {
							operation = var_1_1.operation
						})

						if var_1_1.callback then
							var_1_1.callback()
						end
					else
						pg = var_4_2

						local var_4_3 = var_4_2.TipsMgr.GetInstance()
						local var_4_4 = var_1.ShowTips

						ERROR_MESSAGE = var_2_10003

						var_4_4(var_4_3, var_2_10003[arg_4_0.result] .. arg_4_0.result)
					end

					return
				end)
			else
				local var_1_9 = var_1_1.operation

				ActivityConst = var_1_8

				local var_1_10

				if var_1_9 == var_1_8.INSTAGRAM_CHAT_SET_CARE then
					pg = var_1_9
					var_1_10 = var_1_9.ConnectionMgr.GetInstance()

					var_4.Send(var_1_10, 11716, {
						group_id = var_1_1.characterId,
						value = var_1_1.care
					}, 11717, function(arg_5_0)
						local var_5_4

						if arg_5_0.result == 0 then
							local var_5_0 = var_1_2
							local var_5_1 = var_5_4.GetCharacterChatById(var_5_0, var_1_1.characterId)

							var_5_4.SetCare(var_5_1, var_1_1.care)

							local var_5_2 = var_1_2

							var_5_4.SortChatList(var_5_2)

							local var_5_3 = arg_1_0

							var_5_4 = var_5_4.sendNotification
							GAME = var_2_10003

							var_5_4(var_5_3, var_2_10003.ACT_INSTAGRAM_CHAT_DONE, {
								operation = var_1_1.operation
							})

							if var_1_1.callback then
								var_1_1.callback()
							end
						else
							pg = var_5_4

							local var_5_5 = var_5_4.TipsMgr.GetInstance()
							local var_5_6 = var_1.ShowTips

							ERROR_MESSAGE = var_2_10003

							var_5_6(var_5_5, var_2_10003[arg_5_0.result] .. arg_5_0.result)
						end

						return
					end)
				else
					local var_1_11 = var_1_1.operation

					ActivityConst = var_1_10

					local var_1_12

					if var_1_11 == var_1_10.INSTAGRAM_CHAT_SET_TOPIC then
						pg = var_1_11
						var_1_12 = var_1_11.ConnectionMgr.GetInstance()

						var_4.Send(var_1_12, 11718, {
							chat_group_id = var_1_1.topicId
						}, 11719, function(arg_6_0)
							local var_6_2

							if arg_6_0.result == 0 then
								local var_6_0 = var_1_2

								var_6_2.SetCurrentTopic(var_6_0, var_1_1.topicId)

								local var_6_1 = arg_1_0

								var_6_2 = var_6_2.sendNotification
								GAME = var_2_10003

								var_6_2(var_6_1, var_2_10003.ACT_INSTAGRAM_CHAT_DONE, {
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

						ActivityConst = var_1_12

						local var_1_14

						if var_1_13 == var_1_12.INSTAGRAM_CHAT_SET_READTIP then
							pg = var_1_13
							var_1_14 = var_1_13.ConnectionMgr.GetInstance()

							var_4.Send(var_1_14, 11720, {
								chat_group_id_list = var_1_1.topicIdList
							}, 11721, function(arg_7_0)
								local var_7_3

								if arg_7_0.result == 0 then
									if var_1_1.topicIdList and #var_1_1.topicIdList > 0 then
										ipairs = var_7_3

										for iter_7_0, iter_7_1 in var_7_3(var_1_1.topicIdList) do
											local var_7_0 = var_1_2

											var_6.SetTopicReaded(var_7_0, iter_7_1, 1)
										end
									else
										local var_7_1 = var_1_2

										var_7_3.SetAllTopicsReaded(var_7_1)
									end

									local var_7_2 = arg_1_0

									var_7_3 = var_7_3.sendNotification
									GAME = var_2_10003

									var_7_3(var_7_2, var_2_10003.ACT_INSTAGRAM_CHAT_DONE, {
										operation = var_1_1.operation
									})

									if var_1_1.callback then
										var_1_1.callback()
									end
								else
									pg = var_7_3

									local var_7_4 = var_7_3.TipsMgr.GetInstance()
									local var_7_5 = var_1.ShowTips

									ERROR_MESSAGE = var_2_10003

									var_7_5(var_7_4, var_2_10003[arg_7_0.result] .. arg_7_0.result)
								end

								return
							end)
						else
							local var_1_15 = var_1_1.operation

							ActivityConst = var_1_14

							if var_1_15 == var_1_14.INSTAGRAM_CHAT_ACTIVATE_TOPIC then
								pg = var_1_15

								local var_1_16 = var_1_15.ConnectionMgr.GetInstance()

								var_4.Send(var_1_16, 11722, {
									chat_group_id_list = var_1_1.topicIdList
								}, 11723, function(arg_8_0)
									ipairs = var_2_10001

									for iter_8_0, iter_8_1 in var_2_10001(arg_8_0.result_list) do
										if iter_8_1 == 0 then
											var_2_10006 = nil
											var_2_10008 = var_1_2

											if var_7.GetCharacterChatByTopicId(var_2_10008, var_1_1.topicIdList[iter_8_0]) then
												var_2_10008 = var_1_2
												var_2_10008 = var_7.GetTopicById(var_2_10008, var_1_1.topicIdList[iter_8_0])

												var_2_10006.Activate(var_2_10008, arg_8_0.op_time)
											else
												var_2_10008 = var_1_2

												var_7.CreateNewChat(var_2_10008, var_1_1.topicIdList[iter_8_0], arg_8_0.op_time)
											end

											var_2_10008 = var_1_2

											var_7.RemoveNotActiveTopicId(var_2_10008, var_1_1.topicIdList[iter_8_0])
										else
											pg = var_2_10006

											local var_8_0 = var_2_10006.TipsMgr.GetInstance()

											var_2_10006 = var_2_10006.ShowTips
											ERROR_MESSAGE = var_2_10008

											var_2_10006(var_8_0, var_2_10008[iter_8_1] .. iter_8_1)
										end
									end

									local var_8_1 = var_1_2

									var_1.SortChatList(var_8_1)

									local var_8_2 = arg_1_0
									local var_8_3 = var_1.sendNotification

									GAME = var_3

									var_8_3(var_8_2, var_3.ACT_INSTAGRAM_CHAT_DONE, {
										operation = var_1_1.operation
									})

									if var_1_1.callback then
										var_1_1.callback()
									end

									return
								end)
							end
						end
					end
				end
			end
		end
	end

	return
end

return var_0_1
