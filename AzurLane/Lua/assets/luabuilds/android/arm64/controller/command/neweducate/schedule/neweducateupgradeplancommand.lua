class = var_0_10000

local var_0_0 = "NewEducateUpgradePlanCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().id
	local var_1_1 = var_2.planIds

	pg = var_1_10005

	local var_1_2 = var_1_10005.ConnectionMgr.GetInstance()

	var_5.Send(var_1_2, 29044, {
		id = var_1_0,
		plan_ids = var_1_1
	}, 29045, function(arg_2_0)
		local var_2_1

		if arg_2_0.result == 0 then
			getProxy = var_2_1
			NewEducateProxy = var_2_10003

			local var_2_0 = var_2_1(var_2_10003)

			var_2_1 = var_2_1.GetCurChar(var_2_0)
			ipairs = var_2_10002

			for iter_2_0, iter_2_1 in var_2_10002(var_1_1) do
				NewEducatePlan = var_2_10007

				local var_2_2 = var_2_10007.New(iter_2_1)

				var_2_10007 = var_2_10007.GetNextId(var_2_2)

				var_2_1:OnUpgradedPlan(var_2_10007)

				NewEducatePlan = var_8

				local var_2_3 = var_8.New(var_2_10007)

				while var_2_3:GetNextId() and var_2_1:IsMatchComplex(var_2_3:getConfig("level_condition")) do
					var_2_10007 = var_2_3:GetNextId()

					var_2_1:OnUpgradedPlan(var_2_10007)

					NewEducatePlan = var_9
					var_2_3 = var_9.New(var_2_10007)
				end
			end

			local var_2_4 = arg_1_0
			local var_2_5 = var_2.sendNotification

			GAME = iter_2_0

			var_2_5(var_2_4, iter_2_0.NEW_EDUCATE_UPGRADE_PLAN_DONE)
		else
			pg = var_2_1

			local var_2_6 = var_2_1.TipsMgr.GetInstance()

			var_1.ShowTips(var_2_6, "NewEducate_UpgradePlan: " .. arg_2_0.result)
		end

		return
	end)

	return
end

return var_0_1
