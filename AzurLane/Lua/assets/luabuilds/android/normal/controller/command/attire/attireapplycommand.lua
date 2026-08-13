class = var_0_10000

local var_0_0 = "AttireApplyCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().id
	local var_1_1 = var_2.type

	getProxy = var_1_10005
	AttireProxy = var_1_10006

	local var_1_2 = var_1_10005(var_1_10006)

	if not var_5.getAttireFrame(var_1_2, var_1_1, var_1_0) then
		return
	end

	getProxy = var_1_2
	PlayerProxy = var_7

	local var_1_3 = var_1_2(var_7)
	local var_1_4 = var_6.getData(var_1_3)

	pg = var_1_3

	local var_1_5 = var_1_3.ConnectionMgr.GetInstance()

	var_8.Send(var_1_5, 11005, {
		id = var_1_0,
		type = var_1_1
	}, 11006, function(arg_2_0)
		local var_2_3

		if arg_2_0.result == 0 then
			local var_2_0 = var_1_4

			var_2_3.updateAttireFrame(var_2_0, var_1_1, var_1_0)

			local var_2_1 = var_0

			var_2_3.updatePlayer(var_2_1, var_1_4)

			local var_2_2 = arg_1_0

			var_2_3 = var_2_3.sendNotification
			GAME = var_3

			var_2_3(var_2_2, var_3.ATTIRE_APPLY_DONE)
		else
			print = var_2_3

			var_2_3(arg_2_0.result)
		end

		return
	end)

	return
end

return var_0_1
