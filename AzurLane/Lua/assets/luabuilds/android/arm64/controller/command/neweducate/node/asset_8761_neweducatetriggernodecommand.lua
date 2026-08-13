class = var_0_10000

local var_0_0 = "NewEducateTriggerNodeCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().id
	local var_1_1

	if not var_2.branch then
		var_1_1 = 0
	end

	local var_1_2

	if not var_2.costs then
		var_1_2 = {}
	end

	pg = var_1_10006

	local var_1_3 = var_1_10006.ConnectionMgr.GetInstance()

	var_6.Send(var_1_3, 29030, {
		id = var_1_0,
		branch = var_1_1
	}, 29031, function(arg_2_0)
		local var_2_1

		if arg_2_0.result == 0 then
			getProxy = var_2_1
			NewEducateProxy = var_2_10003

			local var_2_0 = var_2_1(var_2_10003)

			var_2_1.Costs(var_2_0, var_1_2)

			NewEducateDropHelper = var_2_1
			var_2_1 = var_2_1.HandleDrops(arg_2_0.drop)
			getProxy = var_2_10002
			NewEducateProxy = var_4

			local var_2_2 = var_2_10002(var_4)
			local var_2_3 = var_2.GetCurChar(var_2_2)
			local var_2_4 = var_2.GetFSM(var_2_3)

			var_2.SetCurNode(var_2_4, arg_2_0.next_node)

			local var_2_5 = arg_1_0
			local var_2_6 = var_3.sendNotification

			GAME = var_6

			var_2_6(var_2_5, var_6.NEW_EDUCATE_NEXT_NODE, {
				node = arg_2_0.next_node,
				drop = var_2_1,
				noNextCb = function()
					if arg_2_0.next_node == 0 then
						local var_3_0 = var_0
						local var_3_1 = var_0.GetSystemNo(var_3_0)

						NewEducateFSM = var_3_10001

						if var_3_1 == var_3_10001.SYSTEM.PLAN then
							local var_3_2 = var_0
							local var_3_3 = var_0.GetState

							NewEducateFSM = var_3_10003
							var_3_10003 = var_3_3(var_3_2, var_3_10003.SYSTEM.PLAN)

							if var_0.IsFinish(var_3_10003) then
								var_3_10003 = arg_1_0

								local var_3_4 = var_1.sendNotification

								GAME = var_3_10004

								var_3_4(var_3_10003, var_3_10004.NEW_EDUCATE_GET_EXTRA_DROP, {
									id = var_1_0,
									scheduleDrops = var_0:GetDrops()
								})
							else
								var_3_10003 = arg_1_0

								local var_3_5 = var_1.sendNotification

								GAME = var_3_10004

								var_3_5(var_3_10003, var_3_10004.NEW_EDUCATE_NEXT_PLAN, {
									id = var_1_0
								})
							end
						else
							local var_3_6 = arg_1_0
							local var_3_7 = var_0.sendNotification

							GAME = var_3_10003

							var_3_7(var_3_6, var_3_10003.NEW_EDUCATE_CHECK_FSM)
						end
					end

					return
				end
			})
		else
			pg = var_2_1

			local var_2_7 = var_2_1.TipsMgr.GetInstance()

			var_1.ShowTips(var_2_7, "NewEducate_TriggerNode: " .. arg_2_0.result)
		end

		return
	end)

	return
end

return var_0_1
