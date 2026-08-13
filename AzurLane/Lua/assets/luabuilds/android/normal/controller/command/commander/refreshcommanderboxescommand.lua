class = var_0_10000

local var_0_0 = "RefreshCommanderBoxesCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1
	local var_1_1 = arg_1_1.getBody(var_1_0)

	getProxy = var_1_0
	CommanderProxy = var_1_10004

	local var_1_2 = var_1_0(var_1_10004)

	pg = var_1_10004

	local var_1_3 = var_1_10004.ConnectionMgr.GetInstance()

	var_4.Send(var_1_3, 25034, {
		type = 0
	}, 25035, function(arg_2_0)
		ipairs = var_2_10001

		for iter_2_0, iter_2_1 in var_2_10001(arg_2_0.box_list) do
			CommanderBox = var_2_10006
			var_2_10006 = var_2_10006.New(iter_2_1, iter_2_0)

			local var_2_0 = var_1_2

			var_7.updateBox(var_2_0, var_2_10006)
		end

		local var_2_1 = arg_1_0
		local var_2_2 = var_1.sendNotification

		GAME = var_3

		var_2_2(var_2_1, var_3.REFRESH_COMMANDER_BOXES_DONE)

		return
	end)

	return
end

return var_0_1
