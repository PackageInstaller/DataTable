class = var_0_10000

local var_0_0 = "GetRefundInfoCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	pg = var_1_10002

	local var_1_0 = var_1_10002.ConnectionMgr.GetInstance()

	var_2.Send(var_1_0, 11023, {
		type = 1
	}, 11024, function(arg_2_0)
		if arg_2_0.result == 0 then
			getProxy = var_1
			PlayerProxy = var_2_10002

			local var_2_0 = var_1(var_2_10002)

			var_1.setRefundInfo(var_2_0, arg_2_0.shop_info)

			pg = var_2

			local var_2_1 = var_2.m02
			local var_2_2 = var_2.sendNotification

			GAME = var_4

			var_2_2(var_2_1, var_4.REFUND_INFO_UPDATE)

			if arg_1_1 then
				local var_2_3 = arg_1_1

				if var_2.getBody(var_2_3) then
					local var_2_4 = arg_1_1

					if var_2.getBody(var_2_4).callback then
						local var_2_5 = arg_1_1

						var_2.getBody(var_2_5).callback()
					end
				end
			end
		end

		return
	end)

	return
end

return var_0_1
