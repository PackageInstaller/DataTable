local EducateExecutePlansCommand = class("EducateExecutePlansCommand", pm.SimpleCommand)

function EducateExecutePlansCommand:execute(arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_2 = getProxy(EducateProxy)

	pg.ConnectionMgr.GetInstance():Send(27002, {
		type = 1
	}, 27003, function(arg_2_0)
		if arg_2_0.result == 0 then
			local var_2_0 = var_1_2:GetPlanProxy():GetGridData()

			var_1_2:ReduceResForPlans()
			var_1_2:GetPlanProxy():OnExecutePlanDone()
			var_1_2:GetPlanProxy():UpdateHistory()
			self:sendNotification(GAME.CHANGE_SCENE, SCENE.EDUCATE, {
				ingoreGuideCheck = true,
				onEnter = function()
					self:sendNotification(GAME.EDUCATE_EXECUTE_PLANS_DONE, {
						gridData = var_2_0,
						plan_results = arg_2_0.plan_results,
						events = arg_2_0.events,
						isSkip = var_1_0.isSkip,
						isSkipEvent = var_1_0.isSkipEvent
					})

					return
				end
			})
		else
			pg.TipsMgr.GetInstance():ShowTips(errorTip("educate execute plans error: ", arg_2_0.result))
		end

		return
	end)

	return
end

return EducateExecutePlansCommand
