class = var_0_10000

local var_0_0 = "AuctionGameShowMatchWarningTipCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()

	pg = var_1_10003

	local var_1_1 = var_1_10003.ConnectionMgr.GetInstance()

	var_3.Send(var_1_1, 23424, {
		arg = 1
	}, 23425, function(arg_2_0)
		if arg_2_0.result == 0 then
			getProxy = var_1
			AuctionGameBaseProxy = var_2_10003
			var_2_10004 = var_1(var_2_10003)

			var_1.SetMatchWarning(var_2_10004)
		else
			pg = var_1

			local var_2_0 = var_1.TipsMgr.GetInstance()
			local var_2_1 = var_1.ShowTips

			errorTip = var_2_10004

			var_2_1(var_2_0, var_2_10004("", arg_2_0.result))
		end

		return
	end)

	return
end

return var_0_1
