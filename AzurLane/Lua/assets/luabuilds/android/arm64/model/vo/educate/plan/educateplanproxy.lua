local var_0_0 = class("EducatePlanProxy")

var_0_0.INDEX2BG = {
	{
		"empty_blue",
		"plan_name_blue"
	},
	{
		"empty_green",
		"plan_name_green"
	},
	{
		"empty_red",
		"plan_name_red"
	}
}

function var_0_0.Ctor(arg_1_0)
	arg_1_0.allPlans = {}

	for iter_1_0, iter_1_1 in ipairs(pg.child_plan.all) do
		table.insert(arg_1_0.allPlans, EducatePlan.New(iter_1_1))
	end

	arg_1_0.gridColorCfg = pg.child_data[1].plan_color

	return
end

function var_0_0.GetCfgPlans(arg_2_0)
	return arg_2_0.allPlans
end

function var_0_0.SetUp(arg_3_0, arg_3_1)
	local var_3_0 = arg_3_1.history or {}

	arg_3_0:initHistory(var_3_0)

	arg_3_0.selectedPlans = arg_3_1.selectedPlans or {}

	if #arg_3_0.selectedPlans > 0 then
		arg_3_0:initGridData()
	else
		arg_3_0.gridData = {}
	end

	local var_3_1 = getProxy(PlayerProxy)

	arg_3_0.playerId = var_3_1:getRawData().id

	return
end

function var_0_0.GetGridBgName(arg_4_0, arg_4_1, arg_4_2)
	local var_4_0 = 1

	underscore.each(arg_4_0.gridColorCfg, function(arg_5_0)
		underscore.each(arg_5_0[1], function(arg_6_0)
			if arg_6_0[1] == arg_4_1 and arg_6_0[2] == arg_4_2 then
				var_4_0 = arg_5_0[2]

				return
			end

			return
		end)

		return
	end)

	return var_0_0.INDEX2BG[1]
end

function var_0_0.initHistory(arg_7_0, arg_7_1)
	arg_7_0.history = {}

	for iter_7_0, iter_7_1 in ipairs(arg_7_1) do
		arg_7_0.history[iter_7_1.plan_id] = iter_7_1.count
	end

	return
end

function var_0_0.UpdateHistory(arg_8_0, arg_8_1)
	for iter_8_0, iter_8_1 in pairs(arg_8_0.gridData) do
		for iter_8_2, iter_8_3 in pairs(iter_8_1) do
			if iter_8_3:IsPlan() then
				arg_8_0.history[iter_8_3.id] = arg_8_0.history[iter_8_3.id] or 0
				arg_8_0.history[iter_8_3.id] = arg_8_0.history[iter_8_3.id] + 1
			end
		end
	end

	return
end

function var_0_0.GetHistoryCntById(arg_9_0, arg_9_1)
	return arg_9_0.history[arg_9_1] or 0
end

function var_0_0.initGridData(arg_10_0)
	arg_10_0.gridData = {}

	for iter_10_0, iter_10_1 in ipairs(arg_10_0.selectedPlans) do
		arg_10_0.gridData[iter_10_1.day] = arg_10_0.gridData[iter_10_1.day] or {}

		if iter_10_1.value[1] then
			if iter_10_1.value[1].spec_event_id and iter_10_1.value[1].spec_event_id ~= 0 then
				getProxy(EducateProxy):GetEventProxy():AddFinishSpecEvent(iter_10_1.value[1].spec_event_id)

				arg_10_0.gridData[iter_10_1.day][iter_10_1.index] = EducateGrid.New({
					id = iter_10_1.value[1].spec_event_id,
					type = EducateGrid.TYPE_EVENT
				})
			elseif iter_10_1.value[1].plan_id and iter_10_1.value[1].plan_id ~= 0 then
				arg_10_0.gridData[iter_10_1.day][iter_10_1.index] = EducateGrid.New({
					id = iter_10_1.value[1].plan_id,
					type = EducateGrid.TYPE_PLAN
				})
			end
		end
	end

	return
end

function var_0_0.SetGridData(arg_11_0, arg_11_1)
	arg_11_0.selectedPlans = arg_11_1

	arg_11_0:initGridData()

	return
end

function var_0_0.GetGridData(arg_12_0)
	return arg_12_0.gridData
end

function var_0_0.GetCost(arg_13_0)
	local var_13_0 = 0
	local var_13_1 = 0

	for iter_13_0, iter_13_1 in pairs(arg_13_0.gridData) do
		for iter_13_2, iter_13_3 in pairs(iter_13_1) do
			if iter_13_3:IsPlan() then
				local var_13_2, var_13_3 = iter_13_3.data:GetCost()

				var_13_0 = var_13_0 + var_13_2
				var_13_1 = var_13_1 + var_13_3
			end
		end
	end

	return var_13_0, var_13_1
end

function var_0_0.CheckExcute(arg_14_0)
	return #arg_14_0.selectedPlans > 0
end

function var_0_0.GetShowPlans(arg_15_0, arg_15_1, arg_15_2, arg_15_3)
	return underscore.select(arg_15_0.allPlans, function(arg_16_0)
		return arg_16_0:IsShow(arg_15_1, arg_15_2, arg_15_3) and arg_16_0:IsMatchPre(arg_15_0:GetHistoryCntById(arg_16_0:getConfig("pre")[1]))
	end)
end

function var_0_0.ClearLocalPlansData(arg_17_0)
	local var_17_0 = getProxy(EducateProxy):GetCharData():GetNextWeekPlanCnt()

	for iter_17_0 = 1, 6 do
		for iter_17_1 = 1, 3 do
			if iter_17_1 <= var_17_0 then
				local var_17_1 = EducateGrid.TYPE_EMPTY or EducateGrid.TYPE_LOCK

				PlayerPrefs.SetString(EducateConst.PLANS_DATA_KEY .. arg_17_0.playerId .. "_" .. iter_17_0 .. "_" .. iter_17_1, 0 .. "_" .. var_17_1)
			end
		end
	end

	return
end

function var_0_0.GetRecommendPlan(arg_18_0, arg_18_1, arg_18_2, arg_18_3, arg_18_4, arg_18_5, arg_18_6, arg_18_7)
	local var_18_0 = arg_18_0:GetShowPlans(arg_18_3:GetNextWeekStage(), arg_18_1, arg_18_2)

	for iter_18_0, iter_18_1 in ipairs(arg_18_7) do
		table.sort(var_18_0, CompareFuncs({
			function(arg_19_0)
				return -arg_19_0:GetAttrResultValue(iter_18_1)
			end,
			function(arg_20_0)
				return arg_20_0.id
			end
		}))

		for iter_18_2, iter_18_3 in ipairs(var_18_0) do
			local var_18_1, var_18_2, var_18_3 = iter_18_3:GetCost()

			if var_18_1 <= arg_18_3.money - arg_18_4 and var_18_2 <= arg_18_3.mood - arg_18_5 and var_18_3 <= arg_18_6 and iter_18_3:IsMatchAttr(arg_18_3) and iter_18_3:IsMatchPre(arg_18_0:GetHistoryCntById(iter_18_3.id)) then
				return iter_18_3
			end
		end
	end

	return nil
end

function var_0_0.OnExecutePlanDone(arg_21_0)
	arg_21_0.selectedPlans = {}

	return
end

function var_0_0.OnNewWeek(arg_22_0)
	return
end

function var_0_0.GridData2ProtData(arg_23_0)
	for iter_23_0, iter_23_1 in pairs(arg_23_0) do
		for iter_23_2, iter_23_3 in pairs(iter_23_1) do
			if iter_23_3:IsPlan() then
				table.insert({}, {
					day = iter_23_0,
					index = iter_23_2,
					value = {
						{
							event_id = 0,
							spec_event_id = 0,
							plan_id = iter_23_3.id
						}
					}
				})
			end

			if iter_23_3:IsEvent() then
				table.insert({}, {
					day = iter_23_0,
					index = iter_23_2,
					value = {
						{
							event_id = 0,
							plan_id = 0,
							spec_event_id = iter_23_3.id
						}
					}
				})
			end
		end
	end

	return {}
end

return var_0_0
