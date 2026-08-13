class = var_0_10000

local var_0_0 = "InstagramActivityCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1
	local var_1_1 = arg_1_1.getBody(var_1_0)

	getProxy = var_1_0
	InstagramProxy = var_1_10004

	local var_1_2 = var_1_0(var_1_10004)

	ActivityConst = var_1_10004

	if var_1_10004.INSTAGRAM_OP_ACTIVE == var_1_1.cmd then
		pg = var_4

		local var_1_3 = var_4.ConnectionMgr.GetInstance()

		var_4.Send(var_1_3, 11701, {
			cmd = 1,
			id = var_1_1.arg1
		}, 11702, function(arg_2_0)
			local var_2_0

			if arg_2_0.result == 0 then
				Instagram = var_2_0
				var_2_0 = var_2_0.New(arg_2_0.data)
				var_2_10003 = var_1_2

				var_2.UpdateMessage(var_2_10003, var_2_0)

				var_2_10003 = var_1_2

				var_2.AddInstagramTimer(var_2_10003)

				var_2_10003 = arg_1_0

				local var_2_1 = var_2.sendNotification

				GAME = var_4

				var_2_1(var_2_10003, var_4.ACT_INSTAGRAM_OP_DONE, {
					cmd = var_1_1.cmd,
					id = var_1_1.arg1
				})

				if var_1_1.callback then
					var_1_1.callback()
				end
			else
				pg = var_2_0

				local var_2_2 = var_2_0.TipsMgr.GetInstance()
				local var_2_3 = var_1.ShowTips

				ERROR_MESSAGE = var_2_10003

				var_2_3(var_2_2, var_2_10003[arg_2_0.result] .. arg_2_0.result)
			end

			return
		end)

		goto label_1_0
	end

	ActivityConst = var_4

	if var_4.INSTAGRAM_OP_LIKE ~= var_1_1.cmd then
		ActivityConst = var_4

		if var_4.INSTAGRAM_OP_MARK_READ ~= var_1_1.cmd then
			ActivityConst = var_4

			if var_4.INSTAGRAM_OP_UPDATE ~= var_1_1.cmd then
				ActivityConst = var_4

				if var_4.INSTAGRAM_OP_SHARE == var_1_1.cmd then
					pg = var_4

					local var_1_4 = var_4.ConnectionMgr.GetInstance()

					var_4.Send(var_1_4, 11701, {
						id = var_1_1.arg1,
						cmd = var_1_1.cmd
					}, 11702, function(arg_3_0)
						local var_3_0

						if arg_3_0.result == 0 then
							ActivityConst = var_3_0

							if var_3_0.INSTAGRAM_OP_MARK_READ == var_1_1.cmd then
								var_3_0 = nil
								pg = var_2

								local var_3_1 = var_2.activity_ins_template[var_1_1.arg1].type

								InstagramConst = var_2_10003

								if var_3_1 == var_2_10003.INSTAGRAM_TYPE.OFFICIAL_ACCOUNT then
									var_2_10003 = var_1_2
									var_3_0 = var_2.GetOfficialAccounts(var_2_10003)[var_1_1.arg1]
								else
									var_2_10003 = var_1_2
									var_3_0 = var_2.GetMessageById(var_2_10003, var_1_1.arg1)
								end

								var_3_0.isRead = true
								var_2_10003 = var_1_2

								var_2.UpdateMessage(var_2_10003, var_3_0)
							else
								ActivityConst = var_3_0

								if var_3_0.INSTAGRAM_OP_SHARE ~= var_1_1.cmd then
									Instagram = var_3_0
									var_3_0 = var_3_0.New(arg_3_0.data)
									var_2_10003 = var_1_2

									var_2.UpdateMessage(var_2_10003, var_3_0)
								end
							end

							local var_3_2 = arg_1_0

							var_3_0 = var_3_0.sendNotification
							GAME = var_2_10003

							var_3_0(var_3_2, var_2_10003.ACT_INSTAGRAM_OP_DONE, {
								cmd = var_1_1.cmd,
								id = var_1_1.arg1
							})

							if var_1_1.callback then
								var_1_1.callback()
							end
						else
							pg = var_3_0

							local var_3_3 = var_3_0.TipsMgr.GetInstance()
							local var_3_4 = var_1.ShowTips

							ERROR_MESSAGE = var_2_10003

							var_3_4(var_3_3, var_2_10003[arg_3_0.result] .. arg_3_0.result)
						end

						return
					end)
				else
					ActivityConst = var_4

					if var_4.INSTAGRAM_OP_COMMENT == var_1_1.cmd then
						pg = var_4

						local var_1_5 = var_4.ConnectionMgr.GetInstance()

						var_4.Send(var_1_5, 11703, {
							id = var_1_1.arg1,
							discuss = var_1_1.arg2,
							index = var_1_1.arg3
						}, 11704, function(arg_4_0)
							local var_4_0

							if arg_4_0.result == 0 then
								Instagram = var_4_0
								var_4_0 = var_4_0.New(arg_4_0.data)
								var_2_10003 = var_1_2

								var_2.UpdateMessage(var_2_10003, var_4_0)

								var_2_10003 = arg_1_0

								local var_4_1 = var_2.sendNotification

								GAME = var_4

								var_4_1(var_2_10003, var_4.ACT_INSTAGRAM_OP_DONE, {
									cmd = var_1_1.cmd,
									id = var_1_1.arg1
								})

								if var_1_1.callback then
									var_1_1.callback()
								end
							else
								pg = var_4_0

								local var_4_2 = var_4_0.TipsMgr.GetInstance()
								local var_4_3 = var_1.ShowTips

								ERROR_MESSAGE = var_2_10003

								var_4_3(var_4_2, var_2_10003[arg_4_0.result] .. arg_4_0.result)
							end

							return
						end)
					end
				end

				::label_1_0::

				return
			end
		end
	end
end

return var_0_1
