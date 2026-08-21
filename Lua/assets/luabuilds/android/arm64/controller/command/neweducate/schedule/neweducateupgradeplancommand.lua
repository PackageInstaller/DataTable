local var_0_0 = class("NewEducateUpgradePlanCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()

	pg.ConnectionMgr.GetInstance():Send(29044, {
		id = var_1_0.id,
		plan_ids = var_1_0.planIds
	}, 29045, function(arg_2_0)
		if arg_2_0.result == 0 then
			local var_2_0 = getProxy(NewEducateProxy):GetCurChar()

			for iter_2_0, iter_2_1 in ipairs(var_0) do
				local var_2_1 = NewEducatePlan.New(iter_2_1):GetNextId()

				var_2_0:OnUpgradedPlan(var_2_1)

				local var_2_2 = NewEducatePlan.New(var_2_1)

				while var_2_2:GetNextId() and var_2_0:IsMatchComplex(var_2_2:getConfig("level_condition")) do
					local var_2_3 = var_2_2:GetNextId()

					var_2_0:OnUpgradedPlan(var_2_3)

					var_2_2 = NewEducatePlan.New(var_2_3)
				end
			end

			arg_1_0:sendNotification(GAME.NEW_EDUCATE_UPGRADE_PLAN_DONE)
		else
			pg.TipsMgr.GetInstance():ShowTips("NewEducate_UpgradePlan: " .. arg_2_0.result)
		end

		return
	end)

	return
end

return var_0_0
