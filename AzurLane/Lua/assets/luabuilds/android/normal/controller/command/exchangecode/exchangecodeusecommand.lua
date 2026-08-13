class = var_0_10000

local var_0_0 = "ExchangeCodeUseCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().key

	pg = var_1_10004

	local var_1_1 = var_1_10004.SdkMgr.GetInstance()

	if var_4.GetChannelUID(var_1_1) == "" then
		PLATFORM_LOCAL = var_4
	end

	pg = var_1_1

	local var_1_2 = var_1_1.ConnectionMgr.GetInstance()

	var_5.Send(var_1_2, 11508, {
		key = var_1_0,
		platform = var_4
	}, 11509, function(arg_2_0)
		local var_2_1

		if arg_2_0.result == 0 then
			pg = var_2_1

			local var_2_0 = var_2_1.MsgboxMgr.GetInstance()

			var_2_1 = var_2_1.ShowMsgBox

			local var_2_2 = {
				hideNo = true
			}

			i18n = var_2_10004
			var_2_2.content = var_2_10004("exchangecode_use_ok")

			var_2_1(var_2_0, var_2_2)

			pg = var_2_1

			local var_2_3 = var_2_1.m02

			var_2_1 = var_2_1.sendNotification
			GAME = var_2_2

			var_2_1(var_2_3, var_2_2.EXCHANGECODE_USE_SUCCESS)
		else
			pg = var_2_1

			local var_2_5

			if var_2_1.gametip["exchange_code_error_" .. arg_2_0.result] then
				pg = var_2_5

				local var_2_4 = var_2_5.TipsMgr.GetInstance()

				var_2_5 = var_2_5.ShowTips
				pg = var_3

				var_2_5(var_2_4, var_3.gametip["exchange_code_error_" .. arg_2_0.result].tip)
			else
				pg = var_2_5

				local var_2_6 = var_2_5.TipsMgr.GetInstance()
				local var_2_7 = var_1.ShowTips

				errorTip = var_3

				var_2_7(var_2_6, var_3("exchangecode_use", arg_2_0.result))
			end
		end

		return
	end)

	return
end

return var_0_1
