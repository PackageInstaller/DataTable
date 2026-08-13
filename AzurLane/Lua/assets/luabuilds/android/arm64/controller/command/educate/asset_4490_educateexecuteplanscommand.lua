class = var_0_10000

local var_0_0 = "EducateExecutePlansCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1
	local var_1_1

	var_1_1 = arg_1_1.getBody(var_1_0) and var_2.callback
	getProxy = var_1_0
	EducateProxy = var_1_10006

	local var_1_2 = var_1_0(var_1_10006)

	pg = var_1_10005

	local var_1_3 = var_1_10005.ConnectionMgr.GetInstance()

	var_5.Send(var_1_3, 27002, {
		type = 1
	}, 27003, function(arg_2_0)
		local var_2_2

		if arg_2_0.result == 0 then
			local var_2_0 = var_1_2
			local var_2_1 = var_2_2.GetPlanProxy(var_2_0)

			var_2_2 = var_2_2.GetGridData(var_2_1)

			local function var_2_3()
				local var_3_0 = arg_1_0
				local var_3_1 = var_0.sendNotification

				GAME = var_3_10003

				var_3_1(var_3_0, var_3_10003.EDUCATE_EXECUTE_PLANS_DONE, {
					gridData = var_2_2,
					plan_results = arg_2_0.plan_results,
					events = arg_2_0.events,
					isSkip = var_0.isSkip,
					isSkipEvent = var_0.isSkipEvent
				})

				return
			end

			local var_2_4 = var_1_2

			var_3.ReduceResForPlans(var_2_4)

			local var_2_5 = var_1_2
			local var_2_6 = var_3.GetPlanProxy(var_2_5)

			var_3.OnExecutePlanDone(var_2_6)

			local var_2_7 = var_1_2
			local var_2_8 = var_3.GetPlanProxy(var_2_7)

			var_3.UpdateHistory(var_2_8)

			local var_2_9 = arg_1_0
			local var_2_10 = var_3.sendNotification

			GAME = var_2_10006

			local var_2_11 = var_2_10006.CHANGE_SCENE

			SCENE = var_2_10007

			var_2_10(var_2_9, var_2_11, var_2_10007.EDUCATE, {
				ingoreGuideCheck = true,
				onEnter = var_2_3
			})
		else
			pg = var_2_2

			local var_2_12 = var_2_2.TipsMgr.GetInstance()
			local var_2_13 = var_1.ShowTips

			errorTip = var_2_10004

			var_2_13(var_2_12, var_2_10004("educate execute plans error: ", arg_2_0.result))
		end

		return
	end)

	return
end

return var_0_1
