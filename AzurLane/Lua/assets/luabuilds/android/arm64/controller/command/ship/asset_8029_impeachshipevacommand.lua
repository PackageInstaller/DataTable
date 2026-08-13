class = var_0_10000

local var_0_0 = "ImpeachShipEvaCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().groupId
	local var_1_1 = var_2.evaId
	local var_1_2 = var_2.reason

	pg = var_1_10006

	local var_1_3 = var_1_10006.ConnectionMgr.GetInstance()

	var_6.Send(var_1_3, 17109, {
		ship_group_id = var_1_0,
		discuss_id = var_1_1,
		reason = var_1_2
	}, 17110, function(arg_2_0)
		if arg_2_0.result == 0 then
			pg = var_1

			local var_2_0 = var_1.TipsMgr.GetInstance()
			local var_2_1 = var_1.ShowTips

			i18n = var_2_10004

			var_2_1(var_2_0, var_2_10004("report_sent_thank"))
		end

		return
	end)

	return
end

return var_0_1
