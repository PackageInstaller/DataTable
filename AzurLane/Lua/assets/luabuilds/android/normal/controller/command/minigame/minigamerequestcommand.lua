class = var_0_10000

local var_0_0 = "MiniGameRequestCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

var_0_1.REQUEST_HUB_DATA = 1

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().type
	local var_1_1 = var_2.callback

	pg = var_1_10005

	local var_1_2 = var_1_10005.ConnectionMgr.GetInstance()

	var_5.Send(var_1_2, 26101, {
		type = var_1_0
	}, 26102, function(arg_2_0)
		getProxy = var_2_10001
		MiniGameProxy = var_2_10002

		local var_2_0 = var_2_10001(var_2_10002)

		ipairs = var_2_10002

		for iter_2_0, iter_2_1 in var_2_10002(arg_2_0.hubs) do
			var_2_0:UpdataHubData(iter_2_1)
		end

		if var_1_1 then
			var_1_1()
		end

		getProxy = var_2
		MiniGameProxy = var_3

		local var_2_1 = var_2(var_3)

		ipairs = var_3
		pg = var_4

		for iter_2_2, iter_2_3 in var_3(var_4.mini_game.all) do
			var_2_1:RequestInitData(iter_2_3, true)
		end

		return
	end)

	return
end

return var_0_1
