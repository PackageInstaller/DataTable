local GetRefundInfoCommand = class("GetRefundInfoCommand", pm.SimpleCommand)

function GetRefundInfoCommand:execute(arg_1_1)
	pg.ConnectionMgr.GetInstance():Send(11023, {
		type = 1
	}, 11024, function(arg_2_0)
		if arg_2_0.result == 0 then
			getProxy(PlayerProxy):setRefundInfo(arg_2_0.shop_info)
			pg.m02:sendNotification(GAME.REFUND_INFO_UPDATE)

			if arg_1_1 and arg_1_1:getBody() and arg_1_1:getBody().callback then
				arg_1_1:getBody().callback()
			end
		end

		return
	end)

	return
end

return GetRefundInfoCommand
