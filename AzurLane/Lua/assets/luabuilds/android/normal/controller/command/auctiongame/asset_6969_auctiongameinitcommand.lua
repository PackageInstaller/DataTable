class = var_0_10000

local var_0_0 = "AuctionGameInitCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1
	local var_1_1 = arg_1_1.getBody(var_1_0)

	getProxy = var_1_0
	AuctionGameBaseProxy = var_1_10004

	local var_1_2 = var_1_0(var_1_10004)

	if var_3.GetNeedInitFlag(var_1_2) == false then
		existCall = var_3

		var_3(var_1_1.callback)

		return
	end

	pg = var_3

	local var_1_3 = var_3.ConnectionMgr.GetInstance()

	var_3.Send(var_1_3, 23430, {
		arg = 1
	}, 23431, function(arg_2_0)
		getProxy = var_2_10001
		AuctionGameBaseProxy = var_2_10002

		local var_2_0 = var_2_10001(var_2_10002)

		var_1.UpdateData(var_2_0, arg_2_0)
		var_1:SetNeedInitFlag(false)

		existCall = var_2

		var_2(var_1_1.callback)

		local var_2_1 = arg_1_0
		local var_2_2 = var_2.sendNotification

		ActivityProxy = var_4

		var_2_2(var_2_1, var_4.UPDATED_TIP)

		return
	end)

	return
end

return var_0_1
