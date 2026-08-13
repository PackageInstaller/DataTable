class = var_0_10000

local var_0_0 = "EvaluateShipCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().groupId
	local var_1_1 = var_2.content

	pg = var_1_10005

	local var_1_2 = var_1_10005.ConnectionMgr.GetInstance()

	var_5.Send(var_1_2, 17103, {
		ship_group_id = var_1_0,
		context = var_1_1
	}, 17104, function(arg_2_0)
		if arg_2_0.result == 0 then
			getProxy = var_1
			CollectionProxy = var_2_10002
			var_2_10003 = var_1(var_2_10002)

			if var_1.getShipGroup(var_2_10003, var_1_0) then
				ShipEvaluation = var_2_10003
				var_2.evaluation = var_2_10003.New(arg_2_0.ship_discuss)

				var_1:updateShipGroup(var_2)

				local var_2_0 = arg_1_0

				var_2_10003 = var_2_10003.sendNotification
				CollectionProxy = var_2_10005

				var_2_10003(var_2_0, var_2_10005.GROUP_EVALUATION_UPDATE, var_1_0)
			end

			pg = var_2_10003

			local var_2_1 = var_2_10003.TipsMgr.GetInstance()

			var_2_10003 = var_2_10003.ShowTips
			i18n = var_2_10005

			var_2_10003(var_2_1, var_2_10005("eva_ship_success"))
		elseif arg_2_0.result == 1 then
			pg = var_1

			local var_2_2 = var_1.TipsMgr.GetInstance()
			local var_2_3 = var_1.ShowTips

			i18n = var_2_10003

			var_2_3(var_2_2, var_2_10003("report_ship_cannot_comment"))
		elseif arg_2_0.result == 2011 then
			pg = var_1

			local var_2_4 = var_1.TipsMgr.GetInstance()
			local var_2_5 = var_1.ShowTips

			i18n = var_2_10003

			var_2_5(var_2_4, var_2_10003("evaluate_too_loog"))
		elseif arg_2_0.result == 2013 then
			pg = var_1

			local var_2_6 = var_1.TipsMgr.GetInstance()
			local var_2_7 = var_1.ShowTips

			i18n = var_2_10003

			var_2_7(var_2_6, var_2_10003("evaluate_ban_word"))
		elseif arg_2_0.result == 40 then
			pg = var_1

			local var_2_8 = var_1.TipsMgr.GetInstance()
			local var_2_9 = var_1.ShowTips

			i18n = var_2_10003

			var_2_9(var_2_8, var_2_10003("report_cannot_comment_level_2"))
		else
			local var_2_11

			if arg_2_0.result == 41 then
				pg = var_2_11

				local var_2_10 = var_2_11.TipsMgr.GetInstance()

				var_2_11 = var_2_11.ShowTips
				i18n = var_2_10003

				var_2_11(var_2_10, var_2_10003("report_cannot_comment_level_1", arg_2_0.need_level))
			else
				pg = var_2_11

				local var_2_12 = var_2_11.TipsMgr.GetInstance()
				local var_2_13 = var_1.ShowTips

				errorTip = var_2_10003

				var_2_13(var_2_12, var_2_10003("eva_ship", arg_2_0.result))
			end
		end

		return
	end)

	return
end

return var_0_1
