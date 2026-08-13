class = var_0_10000

local var_0_0 = "LikeShipCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()

	pg = var_1_10003

	local var_1_1 = var_1_10003.ConnectionMgr.GetInstance()

	var_3.Send(var_1_1, 17107, {
		ship_group_id = var_1_0
	}, 17108, function(arg_2_0)
		if arg_2_0.result == 0 then
			getProxy = var_1
			CollectionProxy = var_2_10003
			var_2_10004 = var_1(var_2_10003)

			if var_1.getShipGroup(var_2_10004, var_1_0) then
				var_2.iheart = true
				var_2.hearts = var_2.hearts + 1
				var_2_10003 = var_2.evaluation
				var_2_10003.hearts = var_2.evaluation.hearts + 1

				var_1:updateShipGroup(var_2)

				local var_2_0 = arg_1_0

				var_2_10003 = var_2_10003.sendNotification
				CollectionProxy = var_2_10006

				var_2_10003(var_2_0, var_2_10006.GROUP_INFO_UPDATE, var_1_0)
			end

			pg = var_2_10003

			local var_2_1 = var_2_10003.TipsMgr.GetInstance()
			local var_2_2 = var_3.ShowTips

			i18n = var_2_10006

			var_2_2(var_2_1, var_2_10006("like_ship_success"))
		else
			pg = var_1

			local var_2_3 = var_1.TipsMgr.GetInstance()
			local var_2_4 = var_1.ShowTips

			errorTip = var_2_10004

			var_2_4(var_2_3, var_2_10004("like_ship", arg_2_0.result))
		end

		return
	end)

	return
end

return var_0_1
