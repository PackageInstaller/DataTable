local var_0_0 = class("AuctionGameShowMatchWarningTipCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()

	pg.ConnectionMgr.GetInstance():Send(23424, {
		arg = 1
	}, 23425, function(arg_2_0)
		if arg_2_0.result == 0 then
			getProxy(AuctionGameBaseProxy):SetMatchWarning()
		else
			pg.TipsMgr.GetInstance():ShowTips(errorTip("", arg_2_0.result))
		end

		return
	end)

	return
end

return var_0_0
