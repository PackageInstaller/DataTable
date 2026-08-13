class = var_0_10000

local var_0_0 = "EquipCodeShareCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().groupId
	local var_1_1 = var_2.code

	pg = var_1_10005

	local var_1_2 = var_1_10005.ConnectionMgr.GetInstance()

	var_5.Send(var_1_2, 17603, {
		shipgroup = var_1_0,
		eqcode = var_1_1
	}, 17604, function(arg_2_0)
		if arg_2_0.result == 0 then
			pg = var_1

			local var_2_0 = var_1.m02
			local var_2_1 = var_1.sendNotification

			GAME = var_2_10004

			var_2_1(var_2_0, var_2_10004.EQUIP_CODE_SHARE_DONE)

			pg = var_2_1

			local var_2_2 = var_2_1.TipsMgr.GetInstance()
			local var_2_3 = var_1.ShowTips

			i18n = var_2_10004

			var_2_3(var_2_2, var_2_10004("equipcode_share_success"))
		elseif arg_2_0.result == 7 then
			pg = var_1

			local var_2_4 = var_1.TipsMgr.GetInstance()
			local var_2_5 = var_1.ShowTips

			i18n = var_2_10004

			var_2_5(var_2_4, var_2_10004("equipcode_share_errorcode7"))
		else
			local var_2_7

			if arg_2_0.result == 44 then
				pg = var_2_7

				local var_2_6 = var_2_7.TipsMgr.GetInstance()

				var_2_7 = var_2_7.ShowTips
				i18n = var_2_10004

				var_2_7(var_2_6, var_2_10004("equipcode_share_errorcode44"))
			else
				pg = var_2_7

				local var_2_8 = var_2_7.TipsMgr.GetInstance()
				local var_2_9 = var_1.ShowTips

				errorTip = var_2_10004

				var_2_9(var_2_8, var_2_10004("", arg_2_0.result))
			end
		end

		return
	end)

	return
end

return var_0_1
