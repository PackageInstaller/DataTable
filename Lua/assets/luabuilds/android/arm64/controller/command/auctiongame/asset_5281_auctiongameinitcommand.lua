local AuctionGameInitCommand = class("AuctionGameInitCommand", pm.SimpleCommand)

function AuctionGameInitCommand:execute(arg_1_1)
	local var_1_0 = arg_1_1:getBody()

	if getProxy(AuctionGameBaseProxy):GetNeedInitFlag() == false then
		existCall(var_1_0.callback)

		return
	end

	pg.ConnectionMgr.GetInstance():Send(23430, {
		arg = 1
	}, 23431, function(arg_2_0)
		local var_2_0 = getProxy(AuctionGameBaseProxy)

		var_2_0:UpdateData(arg_2_0)
		var_2_0:SetNeedInitFlag(false)
		existCall(var_1_0.callback)
		self:sendNotification(ActivityProxy.UPDATED_TIP)

		return
	end)

	return
end

return AuctionGameInitCommand
