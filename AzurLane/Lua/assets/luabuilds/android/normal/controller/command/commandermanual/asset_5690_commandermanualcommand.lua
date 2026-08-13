class = var_0_10000

local var_0_0 = "CommanderManualCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().operation

	CommanderManualProxy = var_1_10004

	local var_1_1

	if var_1_0 == var_1_10004.GET_TASK then
		pg = var_1_0
		var_1_1 = var_1_0.ConnectionMgr.GetInstance()

		var_3.Send(var_1_1, 22302, {
			id = var_2.pageId,
			index = var_2.index
		}, 22303, function(arg_2_0)
			if arg_2_0.result == 0 then
				getProxy = var_1
				CommanderManualProxy = var_2_10002

				local var_2_0 = var_1(var_2_10002)

				var_2_10003 = var_1.GetPageById(var_2_0, var_0.pageId)

				var_1.RemoveDoingGetTaskIndex(var_2_10003, var_0.index)

				if var_0.callback then
					var_0.callback()
				end
			else
				pg = var_1

				local var_2_1 = var_1.TipsMgr.GetInstance()
				local var_2_2 = var_1.ShowTips

				ERROR_MESSAGE = var_2_10003

				var_2_2(var_2_1, var_2_10003[arg_2_0.result] .. arg_2_0.result)
			end

			return
		end)
	else
		local var_1_2 = var_2.operation

		CommanderManualProxy = var_1_1

		if var_1_2 == var_1_1.GET_PT_AWARD then
			pg = var_1_2

			local var_1_3 = var_1_2.ConnectionMgr.GetInstance()

			var_3.Send(var_1_3, 22304, {
				id = var_2.pageId
			}, 22305, function(arg_3_0)
				local var_3_1

				if arg_3_0.result == 0 then
					getProxy = var_3_1
					CommanderManualProxy = var_2_10002

					local var_3_0 = var_3_1(var_2_10002)

					var_3_1.AddPageAward(var_3_0, var_0.pageId)

					PlayerConst = var_3_1
					var_3_1 = var_3_1.addTranDrop(arg_3_0.drop_list)
					var_2_10003 = arg_1_0

					local var_3_2 = var_2.sendNotification

					GAME = var_2_10004

					var_3_2(var_2_10003, var_2_10004.COMMANDER_MANUAL_OP_DONE, {
						operation = var_0.operation,
						awards = var_3_1,
						pageId = var_0.pageId
					})

					if var_0.callback then
						var_0.callback()
					end
				else
					pg = var_3_1

					local var_3_3 = var_3_1.TipsMgr.GetInstance()
					local var_3_4 = var_1.ShowTips

					ERROR_MESSAGE = var_2_10003

					var_3_4(var_3_3, var_2_10003[arg_3_0.result] .. arg_3_0.result)
				end

				return
			end)
		end
	end

	return
end

return var_0_1
