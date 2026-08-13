class = var_0_10000

local var_0_0 = "ExchangeCodeUseCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1
	local var_1_1 = arg_1_1.getBody(var_1_0).key

	pg = var_1_0

	local var_1_2 = var_1_0.SdkMgr.GetInstance()

	if var_4.GetChannelUID(var_1_2) == "" then
		PLATFORM_LOCAL = var_4
	end

	pg = var_1_10005

	local var_1_3 = var_1_10005.ConnectionMgr.GetInstance()

	var_5.Send(var_1_3, 11508, {
		key = var_1_1,
		platform = var_4
	}, 11509, function(arg_2_0)
		local var_2_1

		if arg_2_0.result == 0 then
			pg = var_2_1

			local var_2_0 = var_2_1.MsgboxMgr.GetInstance()

			var_2_1 = var_2_1.ShowMsgBox
			var_2_10004 = {
				hideNo = true
			}
			i18n = var_2_10005
			var_2_10004.content = var_2_10005("exchangecode_use_ok")

			var_2_1(var_2_0, var_2_10004)

			pg = var_2_1

			local var_2_2 = var_2_1.m02

			var_2_1 = var_2_1.sendNotification
			GAME = var_2_10004

			var_2_1(var_2_2, var_2_10004.EXCHANGECODE_USE_SUCCESS)
		else
			pg = var_2_1

			local var_2_4

			if var_2_1.gametip["exchange_code_error_" .. arg_2_0.result] then
				pg = var_2_4

				local var_2_3 = var_2_4.TipsMgr.GetInstance()

				var_2_4 = var_2_4.ShowTips
				pg = var_2_10004

				var_2_4(var_2_3, var_2_10004.gametip["exchange_code_error_" .. arg_2_0.result].tip)
			else
				pg = var_2_4

				local var_2_5 = var_2_4.TipsMgr.GetInstance()
				local var_2_6 = var_1.ShowTips

				errorTip = var_2_10004

				var_2_6(var_2_5, var_2_10004("exchangecode_use", arg_2_0.result))
			end
		end

		return
	end)

	return
end

return var_0_1
