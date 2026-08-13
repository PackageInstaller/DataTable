class = var_0_10000

local var_0_0 = "MonopolyOPCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().autoFlag
	local var_1_1 = var_2.awardCollector

	getProxy = var_1_10005
	ActivityProxy = var_1_10006

	local var_1_2 = var_1_10005(var_1_10006)

	if var_5.getActivityById(var_1_2, var_2.activity_id) then
		local var_1_3 = var_6

		if var_6.isEnd(var_1_3) then
			return
		end

		local var_1_4 = var_2.cmd

		ActivityConst = var_1_3

		if var_1_4 == var_1_3.MONOPOLY_OP_DIALOGUE and arg_1_0:IsReadDialogue(var_6, var_2.arg1) then
			return
		end

		pg = var_1_4

		local var_1_5 = var_1_4.ConnectionMgr.GetInstance()

		var_7.Send(var_1_5, 11202, {
			activity_id = var_2.activity_id,
			cmd = var_2.cmd,
			arg1 = var_2.arg1,
			arg2 = var_2.arg2,
			arg_list = {}
		}, 11203, function(arg_2_0)
			if arg_2_0.result == 0 then
				local var_2_0 = var_0
				local var_2_1 = var_1.getActivityById(var_2_0, var_0.activity_id)

				PlayerConst = var_2_0

				local var_2_2 = var_2_0.addTranDrop(arg_2_0.award_list)

				if var_1_1 then
					var_2_10004 = var_1_1

					var_3.Add(var_2_10004, var_2_2)
				end

				local var_2_3 = var_0.cmd

				ActivityConst = var_2_10004

				local var_2_4

				if var_2_3 == var_2_10004.MONOPOLY_OP_AWARD then
					var_2_4 = var_2_1.data2_list
					var_2_4[2] = var_2_1.data2_list[2] + 1

					local var_2_5 = var_0

					var_2_4.updateActivity(var_2_5, var_2_1)

					local var_2_6 = arg_1_0

					var_2_4 = var_2_4.sendNotification
					GAME = var_2_10006

					var_2_4(var_2_6, var_2_10006.MONOPOLY_AWARD_DONE, {
						awards = var_2_2,
						autoFlag = var_1_0
					})
				else
					ActivityConst = var_2_4

					if var_2_3 == var_2_4.MONOPOLY_OP_LAST then
						var_2_1.data2_list[3] = 1

						if #var_2_2 > 0 then
							local var_2_7 = arg_1_0
							local var_2_8 = var_4.sendNotification

							GAME = var_2_10006

							var_2_8(var_2_7, var_2_10006.MONOPOLY_AWARD_DONE, {
								awards = var_2_2,
								autoFlag = var_1_0,
								callback = function()
									return
								end
							})
						end

						if var_0.callback then
							var_0.callback()
						end
					end

					local var_2_9 = {}
					local var_2_10 = ""

					ipairs = var_2_10006

					for iter_2_0, iter_2_1 in var_2_10006(arg_2_0.number) do
						if 2 < iter_2_0 then
							table = var_11

							var_11.insert(var_2_9, iter_2_1)

							var_2_10 = var_2_10 .. "-" .. iter_2_1
						end
					end

					local var_2_11 = arg_2_0.number[1]
					local var_2_12 = arg_2_0.number[2]
					local var_2_13 = #var_2_9
					local var_2_14

					if not (0 < var_2_13) or not var_2_9[#var_2_9] then
						var_2_14 = var_2_1.data2
					end

					print = var_9

					var_9(var_2_3, "--", var_2_11, "-", var_2_12, "-", var_2_14, "-", #var_2_9)

					local var_2_15 = false

					table = var_10

					local var_2_16

					if var_10.contains(var_2_9, 1) then
						var_2_16 = var_2_1.data1_list
						var_2_16[3] = var_2_1.data1_list[3] + 1
						var_2_15 = true
					end

					ActivityConst = var_2_16

					local var_2_17

					if var_2_3 == var_2_16.MONOPOLY_OP_THROW then
						print = var_2_17

						var_2_17("点数 : ", var_2_11)

						var_2_1.data3 = var_2_11
						var_2_17 = var_2_1.data1_list
						var_2_17[2] = var_2_1.data1_list[2] + 1
						var_2_17 = var_2_1:getDataConfig("reward_time")

						local var_2_18

						if not var_2_1:getDataConfig("effective_times") then
							var_2_18 = 0
						end

						local var_2_19

						if var_2_18 ~= 0 then
							math = var_13
							var_2_19 = var_13.min(var_2_1.data1_list[2], var_2_18)
						else
							var_2_19 = var_2_1.data1_list[2]
						end

						if var_2_17 > 0 then
							local var_2_20 = var_2_1.data2_list

							math = var_14
							var_2_20[1] = var_14.floor(var_2_19 / var_2_17)
						else
							var_2_1.data2_list[1] = 0
						end

						local var_2_21 = var_0

						var_13.updateActivity(var_2_21, var_2_1)

						if var_0.callback then
							var_0.callback(var_2_11)
						end
					else
						ActivityConst = var_2_17

						local var_2_22

						if var_2_3 == var_2_17.MONOPOLY_OP_MOVE then
							var_2_1.data3 = var_2_11
							var_2_1.data2 = var_2_14
							var_2_1.data4 = var_2_12

							if var_2_15 then
								var_2_22 = var_2_1.data1_list
								var_2_22[4] = 0
							end

							local var_2_23 = var_0

							var_2_22.updateActivity(var_2_23, var_2_1)

							if var_0.callback then
								var_0.callback(var_2_11, var_2_9, var_2_12)
							end
						else
							ActivityConst = var_2_22

							local var_2_24

							if var_2_3 == var_2_22.MONOPOLY_OP_TRIGGER then
								if not var_0.callback then
									function var_2_24(arg_4_0, arg_4_1)
										return
									end
								end

								var_2_1.data3 = var_2_11
								var_2_1.data2 = var_2_14
								var_2_1.data4 = var_2_12 or 0

								if var_2_15 then
									var_2_1.data1_list[4] = 0
								end

								local var_2_25 = var_0

								var_11.updateActivity(var_2_25, var_2_1)

								if #var_2_2 > 0 then
									local var_2_26 = arg_1_0
									local var_2_27 = var_11.sendNotification

									GAME = var_13

									var_2_27(var_2_26, var_13.MONOPOLY_AWARD_DONE, {
										awards = var_2_2,
										autoFlag = var_1_0,
										callback = function()
											var_2_24(var_2_9, var_2_12)

											return
										end
									})
								else
									var_2_24(var_2_9, var_2_12)
								end
							else
								ActivityConst = var_2_24

								local var_2_28

								if var_2_3 == var_2_24.MONOPOLY_OP_PICK then
									if not var_0.callback then
										function var_2_28(arg_6_0, arg_6_1)
											return
										end
									end

									local var_2_29 = var_2_1.data1_list

									var_2_29[4] = var_0.arg1
									table = var_2_29

									if not var_2_29.contains(var_2_1.data3_list, var_0.arg1) then
										table = var_11

										var_11.insert(var_2_1.data3_list, var_0.arg1)
									end

									local var_2_30 = var_0

									var_11.updateActivity(var_2_30, var_2_1)

									local var_2_32

									if #var_2_2 > 0 then
										local var_2_31 = arg_1_0

										var_2_32 = var_2_32.sendNotification
										GAME = var_13

										var_2_32(var_2_31, var_13.MONOPOLY_AWARD_DONE, {
											awards = var_2_2,
											autoFlag = var_1_0,
											callback = function()
												var_2_28(var_2_9, var_2_12)

												return
											end
										})
									else
										var_2_28(var_2_9, var_2_12)
									end

									print = var_2_32

									var_2_32("cmd : 6", " 路径 ： ", var_2_10, "  剩余步数 ： ", var_2_11)
								else
									ActivityConst = var_2_28

									if var_2_3 == var_2_28.MONOPOLY_OP_DIALOGUE then
										table = var_10

										if not var_10.contains(var_2_1.data4_list, var_0.arg1) then
											table = var_10

											var_10.insert(var_2_1.data4_list, var_0.arg1)
										end

										local var_2_33 = var_0

										var_10.updateActivity(var_2_33, var_2_1)

										print = var_10

										var_10("cmd : 8", " 路径 ： ", var_2_10, "  剩余步数 ： ", var_2_11)
									else
										ActivityConst = var_10

										local var_2_34

										if var_2_3 == var_10.MONOPOLY_OP_AUTO then
											var_2_34 = var_2_1.data1_list
											var_2_34[5] = var_0.arg1

											local var_2_35 = var_0

											var_2_34.updateActivity(var_2_35, var_2_1)

											print = var_2_34

											var_2_34("cmd : 7", " 路径 ： ", var_2_10, "  剩余步数 ： ", var_2_11)
										else
											ActivityConst = var_2_34

											if var_2_3 == var_2_34.MONOPOLY_OP_ROUND_AWD then
												var_2_1.data1_list[6] = var_0.arg1

												local var_2_36 = var_0

												var_10.updateActivity(var_2_36, var_2_1)

												local var_2_38

												if #var_2_2 > 0 then
													local var_2_37 = arg_1_0

													var_2_38 = var_2_38.sendNotification
													GAME = var_12

													var_2_38(var_2_37, var_12.MONOPOLY_AWARD_DONE, {
														awards = var_2_2,
														autoFlag = var_1_0
													})
												end

												print = var_2_38

												var_2_38("cmd : 9", " 路径 ： ", var_2_10, "  剩余步数 ： ", var_2_11)
											end
										end
									end
								end
							end
						end
					end
				end
			else
				if var_0.callback then
					var_0.callback()
				end

				originalPrint = var_1

				var_1("Monopoly Activity erro code" .. arg_2_0.result .. " cmd:" .. var_0.cmd)
			end

			return
		end)

		return
	end
end

function var_0_1.IsReadDialogue(arg_8_0, arg_8_1, arg_8_2)
	table = var_1_10003

	return var_1_10003.contains(arg_8_1.data4_list, arg_8_2)
end

return var_0_1
