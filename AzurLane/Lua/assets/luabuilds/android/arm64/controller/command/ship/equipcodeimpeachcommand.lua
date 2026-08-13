class = var_0_10000

local var_0_0 = "EquipCodeImpeachCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().groupId
	local var_1_1 = var_2.shareId
	local var_1_2 = var_2.type

	pg = var_1_10006

	local var_1_3 = var_1_10006.ConnectionMgr.GetInstance()

	var_6.Send(var_1_3, 17607, {
		shipgroup = var_1_0,
		shareid = var_1_1,
		report_type = var_1_2
	}, 17608, function(arg_2_0)
		if arg_2_0.result == 0 then
			pg = var_1

			local var_2_0 = var_1.m02
			local var_2_1 = var_1.sendNotification

			GAME = var_2_10004

			var_2_1(var_2_0, var_2_10004.EQUIP_CODE_IMPEACH_DONE)

			pg = var_2_1

			local var_2_2 = var_2_1.TipsMgr.GetInstance()
			local var_2_3 = var_1.ShowTips

			i18n = var_2_10004

			var_2_3(var_2_2, var_2_10004("equipcode_dislike_success"))
		else
			local var_2_5

			if arg_2_0.result == -1 then
				pg = var_2_5

				local var_2_4 = var_2_5.TipsMgr.GetInstance()

				var_2_5 = var_2_5.ShowTips
				i18n = var_2_10004

				var_2_5(var_2_4, var_2_10004("equipcode_report_warning"))
			else
				pg = var_2_5

				local var_2_6 = var_2_5.TipsMgr.GetInstance()
				local var_2_7 = var_1.ShowTips

				errorTip = var_2_10004

				var_2_7(var_2_6, var_2_10004("", arg_2_0.result))
			end
		end

		return
	end)

	return
end

return var_0_1
