class = var_0_10000

local var_0_0 = "ZanShipEvaCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().groupId
	local var_1_1 = var_2.evaId
	local var_1_2 = var_2.operation

	pg = var_1_10006

	local var_1_3 = var_1_10006.ConnectionMgr.GetInstance()

	var_6.Send(var_1_3, 17105, {
		ship_group_id = var_1_0,
		discuss_id = var_1_1,
		good_or_bad = var_1_2
	}, 17106, function(arg_2_0)
		getProxy = var_2_10001
		CollectionProxy = var_2_10003

		local var_2_0 = var_2_10001(var_2_10003)
		local var_2_1 = var_1.getShipGroup(var_2_0, var_1_0)
		local var_2_2

		if var_2_1 and var_2_1.evaluation then
			_ = var_5
			var_2_2 = var_5.detect(var_4.evas, function(arg_3_0)
				return arg_3_0.id == var_1_1
			end)
		end

		if arg_2_0.result == 0 then
			local var_2_5

			if var_2_2 then
				if var_1_2 == 0 then
					var_2_2.good_count = var_2_2.good_count + 1
				elseif var_1_2 == 1 then
					var_2_2.bad_count = var_2_2.bad_count + 1
				end

				var_2_2.izan = true

				local var_2_3 = var_2_1.evaluation

				var_2_5.sortEvas(var_2_3)
				var_1:updateShipGroup(var_2_1)

				local var_2_4 = arg_1_0

				var_2_5 = var_2_5.sendNotification
				CollectionProxy = var_2_10007

				var_2_5(var_2_4, var_2_10007.GROUP_EVALUATION_UPDATE, var_1_0)
			end

			pg = var_2_5

			local var_2_6 = var_2_5.TipsMgr.GetInstance()
			local var_2_7 = var_4.ShowTips

			i18n = var_2_10007

			var_2_7(var_2_6, var_2_10007("zan_ship_eva_success"))
		else
			local var_2_9

			if arg_2_0.result == 7 then
				if var_2_2 then
					var_2_2.izan = true

					var_1:updateShipGroup(var_2_1)

					local var_2_8 = arg_1_0

					var_2_9 = var_2_9.sendNotification
					CollectionProxy = var_2_10007

					var_2_9(var_2_8, var_2_10007.GROUP_EVALUATION_UPDATE, var_1_0)
				end

				pg = var_2_9

				local var_2_10 = var_2_9.TipsMgr.GetInstance()

				var_2_9 = var_2_9.ShowTips
				i18n = var_2_10007

				var_2_9(var_2_10, var_2_10007("zan_ship_eva_error_7"))
			else
				pg = var_2_9

				local var_2_11 = var_2_9.TipsMgr.GetInstance()
				local var_2_12 = var_4.ShowTips

				errorTip = var_2_10007

				var_2_12(var_2_11, var_2_10007("zan_ship_eva", arg_2_0.result))
			end
		end

		return
	end)

	return
end

return var_0_1
