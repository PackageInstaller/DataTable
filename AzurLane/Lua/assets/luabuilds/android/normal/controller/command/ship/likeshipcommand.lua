class = var_0_10000

local var_0_0 = "LikeShipCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1
	local var_1_1 = arg_1_1.getBody(var_1_0)

	pg = var_1_0

	local var_1_2 = var_1_0.ConnectionMgr.GetInstance()

	var_3.Send(var_1_2, 17107, {
		ship_group_id = var_1_1
	}, 17108, function(arg_2_0)
		if arg_2_0.result == 0 then
			getProxy = var_1
			CollectionProxy = var_2_10002
			var_2_10003 = var_1(var_2_10002)

			if var_1.getShipGroup(var_2_10003, var_1_1) then
				var_2.iheart = true
				var_2.hearts = var_2.hearts + 1
				var_2_10003 = var_2.evaluation
				var_2_10003.hearts = var_2.evaluation.hearts + 1

				var_1:updateShipGroup(var_2)

				local var_2_0 = arg_1_0

				var_2_10003 = var_2_10003.sendNotification
				CollectionProxy = var_2_10005

				var_2_10003(var_2_0, var_2_10005.GROUP_INFO_UPDATE, var_1_1)
			end

			pg = var_2_10003

			local var_2_1 = var_2_10003.TipsMgr.GetInstance()

			var_2_10003 = var_2_10003.ShowTips
			i18n = var_2_10005

			var_2_10003(var_2_1, var_2_10005("like_ship_success"))
		else
			pg = var_1

			local var_2_2 = var_1.TipsMgr.GetInstance()
			local var_2_3 = var_1.ShowTips

			errorTip = var_2_10003

			var_2_3(var_2_2, var_2_10003("like_ship", arg_2_0.result))
		end

		return
	end)

	return
end

return var_0_1
