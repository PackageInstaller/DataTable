local var_0_0 = class("AuctionGameInitCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()

	if getProxy(AuctionGameBaseProxy):GetNeedInitFlag() == false then
		existCall(arg_1_1:getBody().callback)

		return
	end

	pg.ConnectionMgr.GetInstance():Send(23430, {
		arg = 1
	}, 23431, function(arg_2_0)
		local var_2_0 = getProxy(AuctionGameBaseProxy)

		var_2_0:UpdateData(arg_2_0)
		var_2_0:SetNeedInitFlag(false)
		existCall(var_1_0.callback)
		arg_1_0:sendNotification(ActivityProxy.UPDATED_TIP)

		return
	end)

	return
end

return var_0_0
