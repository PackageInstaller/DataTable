class = var_0_10000

local var_0_0 = "ReturnAwardOPCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()

	getProxy = var_1_10003
	ActivityProxy = var_1_10005

	local var_1_1 = var_1_10003(var_1_10005)

	if not var_3.getActivityById(var_1_1, var_1_0.activity_id) or var_4:isEnd() then
		return
	end

	pg = var_1_10005

	local var_1_2 = var_1_10005.ConnectionMgr.GetInstance()
	local var_1_3 = var_5.Send
	local var_1_4 = 11202
	local var_1_5 = {
		activity_id = var_1_0.activity_id
	}
	local var_1_6

	if not var_1_0.cmd then
		var_1_6 = 0
	end

	var_1_5.cmd = var_1_6

	local var_1_7

	if not var_1_0.arg1 then
		var_1_7 = 0
	end

	var_1_5.arg1 = var_1_7

	local var_1_8

	if not var_1_0.arg2 then
		var_1_8 = 0
	end

	var_1_5.arg2 = var_1_8
	var_1_5.arg_list = {}

	var_1_3(var_1_2, var_1_4, var_1_5, 11203, function(arg_2_0)
		local var_2_0

		if arg_2_0.result == 0 then
			PlayerConst = var_2_0
			var_2_0 = var_2_0.addTranDrop(arg_2_0.award_list)

			local var_2_1 = var_1_0.cmd

			ActivityConst = var_3

			if var_2_1 == var_3.RETURN_AWARD_OP_ACTIVTION then
				var_0.data1 = 1
			else
				local var_2_2 = var_1_0.cmd

				ActivityConst = var_3

				if var_2_2 == var_3.RETURN_AWARD_OP_GET_RETRUNERS then
					local var_2_3 = {}

					ipairs = var_3

					for iter_2_0, iter_2_1 in var_3(arg_2_0.return_user_list) do
						table = var_2_10008
						var_2_10008 = var_2_10008.insert

						local var_2_4 = var_2_3

						Returner = var_2_10011

						var_2_10008(var_2_4, var_2_10011.New(iter_2_1))
					end

					var_2_10005 = var_0

					var_3.setClientList(var_2_10005, var_2_3)
				else
					local var_2_5 = var_1_0.cmd

					ActivityConst = var_3

					if var_2_5 == var_3.RETURN_AWARD_OP_GET_AWARD then
						table = var_2_5

						var_2_5.insert(var_0.data1_list, var_1_0.arg1)
					else
						local var_2_6 = var_1_0.cmd

						ActivityConst = var_3

						if var_2_6 == var_3.RETURN_AWARD_OP_PUSH_UID then
							local var_2_7 = var_0.data2_list

							var_2_7[1] = 1
							pg = var_2_7
							var_2_10004 = var_2_7.TipsMgr.GetInstance()

							local var_2_8 = var_2.ShowTips

							i18n = var_2_10005

							var_2_8(var_2_10004, var_2_10005("returner_push_success"))
						else
							local var_2_9 = var_1_0.cmd

							ActivityConst = var_3

							if var_2_9 == var_3.RETURN_AWARD_OP_ACCEPT_TASK then
								-- block empty
							else
								local var_2_10 = var_1_0.cmd

								ActivityConst = var_3

								if var_2_10 == var_3.RETURN_AWARD_OP_SET_RETRUNER then
									local var_2_11 = var_0

									var_2_11.data2 = var_1_0.arg1
									pg = var_2_11
									var_2_10004 = var_2_11.TipsMgr.GetInstance()

									local var_2_12 = var_2.ShowTips

									i18n = var_2_10005

									var_2_12(var_2_10004, var_2_10005("return_award_bind_success"))
								else
									local var_2_13 = var_1_0.cmd

									ActivityConst = var_3

									local var_2_15

									if var_2_13 == var_3.RETURN_AWARD_OP_RETURNER_GET_AWARD then
										pg = var_2_13

										local var_2_14 = var_2_13.activity_template_returnner[var_0.id].task_list

										var_2_15 = var_0
										math = var_2_10004
										var_2_15.data4 = var_2_10004.min(var_0.data4 + 1, #var_2_14)
									else
										local var_2_16 = var_1_0.cmd

										ActivityConst = var_2_15

										if var_2_16 == var_2_15.RETURN_AWARD_OP_MATCH then
											local var_2_17 = var_0

											var_2_17.data2 = arg_2_0.number[1]
											pg = var_2_17
											var_2_10004 = var_2_17.TipsMgr.GetInstance()

											local var_2_18 = var_2.ShowTips

											i18n = var_2_10005

											var_2_18(var_2_10004, var_2_10005("return_award_bind_success"))
										end
									end
								end
							end
						end
					end
				end
			end

			var_2_10004 = var_0

			var_2.updateActivity(var_2_10004, var_0)

			var_2_10004 = arg_1_0

			local var_2_19 = var_2.sendNotification

			GAME = var_5

			var_2_19(var_2_10004, var_5.RETURN_AWARD_OP_DONE, {
				awards = var_2_0,
				id = var_0.id,
				cmd = var_1_0.cmd
			})
		else
			ERROR_MESSAGE = var_2_0

			local var_2_21

			if var_2_0[arg_2_0.result] then
				pg = var_2_21

				local var_2_20 = var_2_21.TipsMgr.GetInstance()

				var_2_21 = var_2_21.ShowTips
				ERROR_MESSAGE = var_2_10004

				var_2_21(var_2_20, var_2_10004[arg_2_0.result])
			else
				pg = var_2_21

				local var_2_22 = var_2_21.TipsMgr.GetInstance()
				local var_2_23 = var_1.ShowTips

				ERROR_MESSAGE = var_2_10004

				var_2_23(var_2_22, var_2_10004[9999] .. arg_2_0.result)
			end
		end

		return
	end)

	return
end

return var_0_1
