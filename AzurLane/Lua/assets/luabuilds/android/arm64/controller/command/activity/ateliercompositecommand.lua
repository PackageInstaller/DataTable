class = var_0_10000

local var_0_0 = "AtelierCompositeCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.SerialAsyncUnitl(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = 0
	local var_1_1

	;(function()
		var_1_0 = var_1_0 + 1

		if var_1_0 <= arg_1_1 then
			arg_1_0(var_1_0, var_0)
		else
			existCall = var_0

			var_0(arg_1_2)
		end

		return
	end)()

	return
end

function var_0_1.execute(arg_3_0, arg_3_1)
	local var_3_0 = arg_3_1.body.formulaId
	local var_3_1 = var_2.items
	local var_3_2 = var_2.repeats

	getProxy = var_1_10006
	ActivityProxy = var_1_10008

	local var_3_3 = var_1_10006(var_1_10008)
	local var_3_4 = var_6.getActivityByType

	ActivityConst = var_1_10009

	local var_3_5 = var_3_4(var_3_3, var_1_10009.ACTIVITY_TYPE_ATELIER_LINK)

	assert = var_1_10007

	var_1_10007(var_3_5)

	pg = var_1_10007

	local var_3_6 = var_1_10007.ConnectionMgr.GetInstance()

	var_7.Send(var_3_6, 26053, {
		act_id = var_3_5.id,
		recipe_id = var_3_0,
		items = var_3_1,
		times = var_3_2
	}, 26054, function(arg_4_0)
		local var_4_1

		if arg_4_0.result == 0 then
			getProxy = var_4_1
			ActivityProxy = var_2_10003

			local var_4_0 = var_4_1(var_2_10003)

			var_4_1 = var_4_1.getActivityByType
			ActivityConst = var_2_10004
			var_3_5 = var_4_1(var_4_0, var_2_10004.ACTIVITY_TYPE_ATELIER_LINK)

			local var_4_2 = var_3_5

			var_4_1 = var_4_1.GetItems(var_4_2)
			_ = var_2_10002

			var_2_10002.each(var_3_1, function(arg_5_0)
				if not var_4_1[arg_5_0.value] then
					return
				end

				var_4_1[arg_5_0.value].count = var_4_1[arg_5_0.value].count - var_3_2

				if var_4_1[arg_5_0.value].count <= 0 then
					var_4_1[arg_5_0.value] = nil
				end

				return
			end)

			var_2_10004 = var_3_5

			var_2.AddFormulaUseCount(var_2_10004, var_3_0, var_3_2)

			getProxy = var_2
			ActivityProxy = var_2_10004
			var_2_10004 = var_2(var_2_10004)

			var_2.updateActivity(var_2_10004, var_3_5)

			PlayerConst = var_2

			local var_4_3 = var_2.addTranDrop(arg_4_0.award_list)
			local var_4_4 = arg_3_0
			local var_4_5 = var_3.sendNotification

			GAME = var_6

			var_4_5(var_4_4, var_6.COMPOSITE_ATELIER_RECIPE_DONE, var_4_3)
		else
			pg = var_4_1

			local var_4_6 = var_4_1.TipsMgr.GetInstance()
			local var_4_7 = var_1.ShowTips

			errorTip = var_2_10004

			var_4_7(var_4_6, var_2_10004("", arg_4_0.result))
		end

		return
	end)

	return
end

return var_0_1
