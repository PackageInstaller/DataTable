class = var_0_10000

local var_0_0 = "CommanderQuicklyFinishBoxesCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().itemCnt
	local var_1_1 = var_2.finishCnt
	local var_1_2 = var_2.affectCnt

	pg = var_1_10006

	local var_1_3 = var_1_10006.ConnectionMgr.GetInstance()

	var_6.Send(var_1_3, 25037, {
		item_cnt = var_1_0,
		finish_cnt = var_1_1,
		affect_cnt = var_1_2
	}, 25038, function(arg_2_0)
		if arg_2_0.result == 0 then
			getProxy = var_1
			BagProxy = var_2_10003

			local var_2_0 = var_1(var_2_10003)
			local var_2_1 = var_1.removeItemById

			Item = var_2_10004

			var_2_1(var_2_0, var_2_10004.COMMANDER_QUICKLY_TOOL_ID, var_1_0)

			local var_2_2 = arg_1_0
			local var_2_3 = var_1.sendNotification

			GAME = var_2_10004

			var_2_3(var_2_2, var_2_10004.COMMANDER_QUICKLY_FINISH_BOXES_DONE)

			local var_2_4 = arg_1_0
			local var_2_5 = var_1.sendNotification

			GAME = var_2_10004

			var_2_5(var_2_4, var_2_10004.REFRESH_COMMANDER_BOXES)
		else
			local var_2_6 = arg_1_0
			local var_2_7 = var_1.sendNotification

			GAME = var_2_10004

			var_2_7(var_2_6, var_2_10004.COMMANDER_QUICKLY_FINISH_BOXES_ERROR)
		end

		return
	end)

	return
end

return var_0_1
