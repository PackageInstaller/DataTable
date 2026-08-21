local var_0_0 = class("MonopolyOPCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = var_1_0.autoFlag
	local var_1_2 = var_1_0.awardCollector
	local var_1_3 = getProxy(ActivityProxy)
	local var_1_4 = getProxy(ActivityProxy):getActivityById(var_1_0.activity_id)

	if not var_1_4 or var_1_4:isEnd() then
		return
	end

	if var_1_0.cmd == ActivityConst.MONOPOLY_OP_DIALOGUE and arg_1_0:IsReadDialogue(var_1_4, var_1_0.arg1) then
		return
	end

	pg.ConnectionMgr.GetInstance():Send(11202, {
		activity_id = var_1_0.activity_id,
		cmd = var_1_0.cmd,
		arg1 = var_1_0.arg1,
		arg2 = var_1_0.arg2,
		arg_list = {}
	}, 11203, function(arg_2_0)
		if arg_2_0.result == 0 then
			local var_2_0 = var_1_3:getActivityById(var_1_0.activity_id)
			local var_2_1 = PlayerConst.addTranDrop(arg_2_0.award_list)

			if var_1_2 then
				var_1_2:Add(var_2_1)
			end

			local var_2_2 = var_1_0.cmd
			local var_2_3 = {}
			local var_2_4 = ""
			local var_2_5 = arg_2_0.number[1]
			local var_2_6 = arg_2_0.number[2]

			if var_1_0.cmd == ActivityConst.MONOPOLY_OP_AWARD then
				var_2_0.data2_list[2] = var_2_0.data2_list[2] + 1

				var_1_3:updateActivity(var_2_0)
				arg_1_0:sendNotification(GAME.MONOPOLY_AWARD_DONE, {
					awards = var_2_1,
					autoFlag = var_1_1
				})

				goto label_2_0
			end

			if var_2_2 == ActivityConst.MONOPOLY_OP_LAST then
				var_2_0.data2_list[3] = 1

				if #var_2_1 > 0 then
					arg_1_0:sendNotification(GAME.MONOPOLY_AWARD_DONE, {
						awards = var_2_1,
						autoFlag = var_1_1,
						callback = function()
							return
						end
					})
				end

				if var_1_0.callback then
					var_1_0.callback()
				end
			end

			for iter_2_0, iter_2_1 in ipairs(arg_2_0.number) do
				if iter_2_0 > 2 then
					table.insert(var_2_3, iter_2_1)

					var_2_4 = var_2_4 .. "-" .. iter_2_1
				end
			end

			::label_2_0::

			if #var_2_3 > 0 then
				do
					local var_2_7 = var_2_3[#var_2_3] or var_2_0.data2

					print(var_2_2, "--", var_2_5, "-", var_2_6, "-", var_2_7, "-", #var_2_3)

					local var_2_8 = false

					if table.contains(var_2_3, 1) then
						var_2_0.data1_list[3] = var_2_0.data1_list[3] + 1
						var_2_8 = true
					end

					if var_2_2 == ActivityConst.MONOPOLY_OP_THROW then
						print("点数 : ", var_2_5)

						var_2_0.data3 = var_2_5
						var_2_0.data1_list[2] = var_2_0.data1_list[2] + 1

						local var_2_9 = var_2_0:getDataConfig("reward_time")
						local var_2_10 = var_2_0:getDataConfig("effective_times") or 0
						local var_2_11 = var_2_10 ~= 0 and math.min(var_2_0.data1_list[2], var_2_10) or var_2_0.data1_list[2]

						var_2_0.data2_list[1] = var_2_9 > 0 and math.floor(var_2_11 / var_2_9) or 0

						var_1_3:updateActivity(var_2_0)

						if var_1_0.callback then
							var_1_0.callback(var_2_5)
						end
					elseif var_2_2 == ActivityConst.MONOPOLY_OP_MOVE then
						var_2_0.data3 = var_2_5
						var_2_0.data2 = var_2_7
						var_2_0.data4 = var_2_6

						if var_2_8 then
							var_2_0.data1_list[4] = 0
						end

						var_1_3:updateActivity(var_2_0)

						if var_1_0.callback then
							var_1_0.callback(var_2_5, var_2_3, var_2_6)
						end
					elseif var_2_2 == ActivityConst.MONOPOLY_OP_TRIGGER then
						local var_2_12 = var_1_0.callback or function(arg_4_0, arg_4_1)
							return
						end

						var_2_0.data3 = var_2_5
						var_2_0.data2 = var_2_7
						var_2_0.data4 = var_2_6 or 0

						if var_2_8 then
							var_2_0.data1_list[4] = 0
						end

						var_1_3:updateActivity(var_2_0)

						if #var_2_1 > 0 then
							arg_1_0:sendNotification(GAME.MONOPOLY_AWARD_DONE, {
								awards = var_2_1,
								autoFlag = var_1_1,
								callback = function()
									var_2_12(var_2_3, var_2_6)

									return
								end
							})
						else
							var_2_12(var_2_3, var_2_6)
						end
					elseif var_2_2 == ActivityConst.MONOPOLY_OP_PICK then
						local var_2_13 = var_1_0.callback or function(arg_6_0, arg_6_1)
							return
						end

						var_2_0.data1_list[4] = var_1_0.arg1

						if not table.contains(var_2_0.data3_list, var_1_0.arg1) then
							table.insert(var_2_0.data3_list, var_1_0.arg1)
						end

						var_1_3:updateActivity(var_2_0)

						if #var_2_1 > 0 then
							arg_1_0:sendNotification(GAME.MONOPOLY_AWARD_DONE, {
								awards = var_2_1,
								autoFlag = var_1_1,
								callback = function()
									var_2_13(var_2_3, var_2_6)

									return
								end
							})
						else
							var_2_13(var_2_3, var_2_6)
						end

						print("cmd : 6", " 路径 ： ", var_2_4, "  剩余步数 ： ", var_2_5)
					elseif var_2_2 == ActivityConst.MONOPOLY_OP_DIALOGUE then
						if not table.contains(var_2_0.data4_list, var_1_0.arg1) then
							table.insert(var_2_0.data4_list, var_1_0.arg1)
						end

						var_1_3:updateActivity(var_2_0)
						print("cmd : 8", " 路径 ： ", var_2_4, "  剩余步数 ： ", var_2_5)
					elseif var_2_2 == ActivityConst.MONOPOLY_OP_AUTO then
						var_2_0.data1_list[5] = var_1_0.arg1

						var_1_3:updateActivity(var_2_0)
						print("cmd : 7", " 路径 ： ", var_2_4, "  剩余步数 ： ", var_2_5)
					elseif var_2_2 == ActivityConst.MONOPOLY_OP_ROUND_AWD then
						var_2_0.data1_list[6] = var_1_0.arg1

						var_1_3:updateActivity(var_2_0)

						if #var_2_1 > 0 then
							arg_1_0:sendNotification(GAME.MONOPOLY_AWARD_DONE, {
								awards = var_2_1,
								autoFlag = var_1_1
							})
						end

						print("cmd : 9", " 路径 ： ", var_2_4, "  剩余步数 ： ", var_2_5)
					end

					if false then
						if var_1_0.callback then
							var_1_0.callback()
						end

						originalPrint("Monopoly Activity erro code" .. arg_2_0.result .. " cmd:" .. var_1_0.cmd)
					end
				end

				return
			end
		end
	end)

	return
end

function var_0_0.IsReadDialogue(arg_8_0, arg_8_1, arg_8_2)
	return table.contains(arg_8_1.data4_list, arg_8_2)
end

return var_0_0
