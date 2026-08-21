local var_0_0 = class("ExchangeCodeUseCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = pg.SdkMgr.GetInstance():GetChannelUID()

	if var_1_0 == "" then
		var_1_0 = PLATFORM_LOCAL
	end

	pg.ConnectionMgr.GetInstance():Send(11508, {
		key = arg_1_1:getBody().key,
		platform = var_1_0
	}, 11509, function(arg_2_0)
		if arg_2_0.result == 0 then
			pg.MsgboxMgr.GetInstance():ShowMsgBox({
				hideNo = true,
				content = i18n("exchangecode_use_ok")
			})
			pg.m02:sendNotification(GAME.EXCHANGECODE_USE_SUCCESS)
		elseif pg.gametip["exchange_code_error_" .. arg_2_0.result] then
			pg.TipsMgr.GetInstance():ShowTips(pg.gametip["exchange_code_error_" .. arg_2_0.result].tip)
		else
			pg.TipsMgr.GetInstance():ShowTips(errorTip("exchangecode_use", arg_2_0.result))
		end

		return
	end)

	return
end

return var_0_0
