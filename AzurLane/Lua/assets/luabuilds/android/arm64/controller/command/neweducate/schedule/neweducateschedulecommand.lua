local var_0_0 = class("NewEducateScheduleCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = var_1_0.isSkip

	pg.ConnectionMgr.GetInstance():Send(29040, {
		id = var_1_0.id,
		plans = var_1_0.planKVs
	}, 29041, function(arg_2_0)
		if arg_2_0.result == 0 then
			local var_2_0 = getProxy(NewEducateProxy):GetCurChar()
			local var_2_1 = var_2_0:GetFSM()

			var_2_1:SetSystemNo(NewEducateFSM.SYSTEM.PLAN)

			local var_2_2 = var_2_1:GetState(NewEducateFSM.SYSTEM.PLAN)
			local var_2_3 = arg_2_0.plans or var_0

			arg_1_0:TrackPlan(var_2_0, var_0, var_2_3)
			var_2_2:SetPlans(var_2_3)
			var_2_2:SetResources(var_2_0:GetResources())
			var_2_2:SetAttrs(var_2_0:GetAttrs())

			local var_2_4 = getProxy(NewEducateProxy):GetCurChar():GetPlanDiscountInfos()

			for iter_2_0, iter_2_1 in ipairs(var_0) do
				local var_2_5 = NewEducatePlan.New(iter_2_1.value)

				getProxy(NewEducateProxy):Costs((var_2_5:GetCostWithBenefit(var_2_4)))
			end

			arg_1_0:sendNotification(GAME.NEW_EDUCATE_SCHEDULE_DONE, {
				drops = NewEducateDropHelper.HandleDrops(arg_2_0.drop),
				callback = function()
					if #var_2_3 > 0 then
						if not var_1_1 then
							arg_1_0:sendNotification(GAME.NEW_EDUCATE_NEXT_PLAN, {
								id = var_0
							})
						else
							arg_1_0:sendNotification(GAME.NEW_EDUCATE_SCHEDULE_SKIP, {
								id = var_0
							})
						end
					else
						arg_1_0:sendNotification(GAME.NEW_EDUCATE_GET_EXTRA_DROP, {
							id = var_0,
							scheduleDrops = {}
						})
					end

					return
				end
			})
		else
			pg.TipsMgr.GetInstance():ShowTips("NewEducate_Schedule: " .. arg_2_0.result)
		end

		return
	end)

	return
end

function var_0_0.TrackPlan(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	table.sort(arg_4_3, CompareFuncs({
		function(arg_6_0)
			return arg_6_0.key
		end
	}))
	pg.m02:sendNotification(GAME.NEW_EDUCATE_TRACK, NewEducateTrackCommand.BuildDataPlan(arg_4_1.id, arg_4_1:GetGameCnt(), arg_4_1:GetRoundData().round, table.concat(underscore.map(arg_4_2, function(arg_5_0)
		return arg_5_0.value
	end), ","), table.concat(underscore.map(arg_4_3, function(arg_7_0)
		return arg_7_0.value
	end), ",")))

	return
end

return var_0_0
