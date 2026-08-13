class = var_0_10000

local var_0_0 = "WorldActivateCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1
	local var_1_1 = arg_1_1.getBody(var_1_0)

	pg = var_1_0

	local var_1_2 = var_1_0.ConnectionMgr.GetInstance()

	var_3.Send(var_1_2, 33101, var_1_1, 33102, function(arg_2_0)
		if arg_2_0.result == 0 then
			getProxy = var_1
			WorldProxy = var_2_10002
			var_2_10003 = var_1(var_2_10002)

			local var_2_0 = var_1.NetUpdateWorld
			local var_2_1 = arg_2_0.world
			local var_2_2

			if not arg_2_0.global_flag_list then
				var_2_2 = {}
			end

			var_2_0(var_2_10003, var_2_1, var_2_2, var_1_1.camp)

			var_2_10003 = var_1

			var_1.NetUpdateWorldCountInfo(var_2_10003, arg_2_0.count_info)

			var_2_10003 = var_1

			var_1.NetUpdateWorldMapPressing(var_2_10003, {})

			var_2_10003 = var_1

			var_1.NetUpdateWorldPressingAward(var_2_10003, arg_2_0.chapter_award)

			var_2_10003 = var_1

			var_1.NetUpdateWorldPortShopMark(var_2_10003, arg_2_0.port_list, arg_2_0.new_flag_port_list)

			nowWorld = var_2
			var_2_10003 = var_2()

			local var_2_3 = var_2.GetBossProxy(var_2_10003)

			var_2.GenFleet(var_2_3)

			local var_2_4 = arg_1_0

			var_2_10003 = var_2_10003.sendNotification
			GAME = var_5

			var_2_10003(var_2_4, var_5.WORLD_ACTIVATE_DONE)
		else
			pg = var_1

			local var_2_5 = var_1.TipsMgr.GetInstance()
			local var_2_6 = var_1.ShowTips

			errorTip = var_2_10003

			var_2_6(var_2_5, var_2_10003("world_activate_error_", arg_2_0.result))
		end

		return
	end)

	return
end

return var_0_1
