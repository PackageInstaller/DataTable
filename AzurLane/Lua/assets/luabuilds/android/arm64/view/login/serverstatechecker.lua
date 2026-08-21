local var_0_0 = class("ServerStateChecker")

function var_0_0.Execute(arg_1_0, arg_1_1)
	local var_1_0 = {
		true
	}

	seriesAsync({
		function(arg_2_0)
			onNextTick(arg_2_0)

			return
		end,
		function(arg_3_0)
			arg_1_0:DoCheck(var_1_0, arg_3_0)

			return
		end
	}, function()
		arg_1_1(var_1_0[1])

		return
	end)

	return
end

function var_0_0.DoCheck(arg_5_0, arg_5_1, arg_5_2)
	if IsUnityEditor then
		arg_5_1[1] = false

		arg_5_2()

		return
	end

	pg.ConnectionMgr.GetInstance():Connect(NetConst.GATEWAY_HOST, NetConst.GATEWAY_PORT, function()
		pg.ConnectionMgr.GetInstance():Send(10018, {
			arg = 0
		}, 10019, function(arg_7_0)
			pg.ConnectionMgr.GetInstance():Disconnect()

			local var_7_0 = arg_7_0.serverlist or {}

			for iter_7_0, iter_7_1 in ipairs(var_7_0) do
				if iter_7_1.state ~= Server.STATUS.VINDICATE then
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
