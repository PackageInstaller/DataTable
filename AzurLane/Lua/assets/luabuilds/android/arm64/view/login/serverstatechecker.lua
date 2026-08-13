class = var_0_10000

local var_0_0 = var_0_10000("ServerStateChecker")

function var_0_0.Execute(arg_1_0, arg_1_1)
	local var_1_0 = {
		true
	}

	seriesAsync = var_1_10003

	var_1_10003({
		function(arg_2_0)
			onNextTick = var_2_10001

			var_2_10001(arg_2_0)

			return
		end,
		function(arg_3_0)
			local var_3_0 = arg_1_0

			var_1.DoCheck(var_3_0, var_1_0, arg_3_0)

			return
		end
	}, function()
		arg_1_1(var_1_0[1])

		return
	end)

	return
end

function var_0_0.DoCheck(arg_5_0, arg_5_1, arg_5_2)
	IsUnityEditor = var_1_10003

	if var_1_10003 then
		arg_5_1[1] = false

		arg_5_2()

		return
	end

	pg = var_1_10003

	local var_5_0 = var_1_10003.ConnectionMgr.GetInstance()
	local var_5_1 = var_3.Connect

	NetConst = var_1_10006

	local var_5_2 = var_1_10006.GATEWAY_HOST

	NetConst = var_1_10007

	var_5_1(var_5_0, var_5_2, var_1_10007.GATEWAY_PORT, function()
		pg = var_2_10000

		local var_6_0 = var_2_10000.ConnectionMgr.GetInstance()

		var_0.Send(var_6_0, 10018, {
			arg = 0
		}, 10019, function(arg_7_0)
			pg = var_3_10001

			local var_7_0 = var_3_10001.ConnectionMgr.GetInstance()

			var_1.Disconnect(var_7_0)

			ipairs = var_1

			local var_7_1

			if not arg_7_0.serverlist then
				var_7_1 = {}
			end

			for iter_7_0, iter_7_1 in var_1(var_7_1) do
				local var_7_2 = iter_7_1.state

				Server = var_3_10007

				if var_7_2 ~= var_3_10007.STATUS.VINDICATE then
					arg_5_1[1] = false

					break
				end
			end

			arg_5_2()

			return
		end)

		return
	end)

	return
end

return var_0_0
