class = var_0_10000

local var_0_0 = var_0_10000("EducatePlanProxy")

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
	pg = var_1

	local var_1_0 = var_1.child_plan.all

	ipairs = var_1_10002

	for iter_1_0, iter_1_1 in var_1_10002(var_1_0) do
		table = var_1_10007
		var_1_10007 = var_1_10007.insert

		local var_1_1 = arg_1_0.allPlans

		EducatePlan = var_1_10010

		var_1_10007(var_1_1, var_1_10010.New(iter_1_1))
	end

	pg = var_2
	arg_1_0.gridColorCfg = var_2.child_data[1].plan_color

	return
end

function var_0_0.GetCfgPlans(arg_2_0)
	return arg_2_0.allPlans
end

function var_0_0.SetUp(arg_3_0, arg_3_1)
	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0.initHistory
	local var_3_2

	if not arg_3_1.history then
		var_3_2 = {}
	end

	var_3_1(var_3_0, var_3_2)

	local var_3_3

	if not arg_3_1.selectedPlans then
		var_3_3 = {}
	end

	arg_3_0.selectedPlans = var_3_3

	if #arg_3_0.selectedPlans > 0 then
		var_3_0 = arg_3_0

		arg_3_0.initGridData(var_3_0)
	else
		arg_3_0.gridData = {}
	end

	getProxy = var_2
	PlayerProxy = var_3_0

	local var_3_4 = var_2(var_3_0)

	arg_3_0.playerId = var_2.getRawData(var_3_4).id

	return
end

function var_0_0.GetGridBgName(arg_4_0, arg_4_1, arg_4_2)
	local var_4_0 = 1

	underscore = var_1_10004

	var_1_10004.each(arg_4_0.gridColorCfg, function(arg_5_0)
		underscore = var_2_10001

		var_2_10001.each(arg_5_0[1], function(arg_6_0)
			if arg_6_0[1] == arg_4_1 and arg_6_0[2] == arg_4_2 then
				var_4_0 = arg_5_0[2]

				return
			end

			return
		end)

		return
	end)

	return var_0_0.INDEX2BG[var_4_0]
end

function var_0_0.initHistory(arg_7_0, arg_7_1)
	arg_7_0.history = {}
	ipairs = var_2

	for iter_7_0, iter_7_1 in var_2(arg_7_1) do
		arg_7_0.history[iter_7_1.plan_id] = iter_7_1.count
	end

	return
end

function var_0_0.UpdateHistory(arg_8_0, arg_8_1)
	pairs = var_1_10002

	for iter_8_0, iter_8_1 in var_1_10002(arg_8_0.gridData) do
		pairs = var_1_10007

		for iter_8_2, iter_8_3 in var_1_10007(iter_8_1) do
			if iter_8_3:IsPlan() then
				if not arg_8_0.history[iter_8_3.id] then
					arg_8_0.history[iter_8_3.id] = 0
				end

				arg_8_0.history[iter_8_3.id] = arg_8_0.history[iter_8_3.id] + 1
			end
		end
	end

	return
end

function var_0_0.GetHistoryCntById(arg_9_0, arg_9_1)
	local var_9_0

	if not arg_9_0.history[arg_9_1] then
		var_9_0 = 0
	end

	return var_9_0
end

function var_0_0.initGridData(arg_10_0)
	arg_10_0.gridData = {}
	ipairs = var_1

	for iter_10_0, iter_10_1 in var_1(arg_10_0.selectedPlans) do
		if not arg_10_0.gridData[iter_10_1.day] then
			arg_10_0.gridData[iter_10_1.day] = {}
		end

		if iter_10_1.value[1] then
			local var_10_0 = iter_10_1.value[1].spec_event_id
			local var_10_1 = iter_10_1.value[1].plan_id

			if var_10_0 and var_10_0 ~= 0 then
				getProxy = var_1_10008
				EducateProxy = var_1_10010
				var_1_10010 = var_1_10008(var_1_10010)
				var_1_10010 = var_1_10008.GetEventProxy(var_1_10010)

				var_1_10008.AddFinishSpecEvent(var_1_10010, var_10_0)

				var_1_10008 = arg_10_0.gridData[iter_10_1.day]

				local var_10_2 = iter_10_1.index

				EducateGrid = var_1_10010
				var_1_10010 = var_1_10010.New

				local var_10_3 = {
					id = var_10_0
				}

				EducateGrid = var_1_10013
				var_10_3.type = var_1_10013.TYPE_EVENT
				var_1_10008[var_10_2] = var_1_10010(var_10_3)
			elseif var_10_1 and var_10_1 ~= 0 then
				var_1_10008 = arg_10_0.gridData[iter_10_1.day]

				local var_10_4 = iter_10_1.index

				EducateGrid = var_1_10010
				var_1_10010 = var_1_10010.New

				local var_10_5 = {
					id = var_10_1
				}

				EducateGrid = var_1_10013
				var_10_5.type = var_1_10013.TYPE_PLAN
				var_1_10008[var_10_4] = var_1_10010(var_10_5)
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

	pairs = var_1_10003

	for iter_13_0, iter_13_1 in var_1_10003(arg_13_0.gridData) do
		pairs = var_1_10008

		for iter_13_2, iter_13_3 in var_1_10008(iter_13_1) do
			if iter_13_3:IsPlan() then
				local var_13_2 = iter_13_3.data
				local var_13_3, var_13_4 = var_13.GetCost(var_13_2)

				var_13_0 = var_13_0 + var_13_3
				var_13_1 = var_13_1 + var_13_4
			end
		end
	end

	return var_13_0, var_13_1
end

function var_0_0.CheckExcute(arg_14_0)
	return #arg_14_0.selectedPlans > 0
end

function var_0_0.GetShowPlans(arg_15_0, arg_15_1, arg_15_2, arg_15_3)
	underscore = var_1_10004

	return var_1_10004.select(arg_15_0.allPlans, function(arg_16_0)
		local var_16_0 = arg_16_0:getConfig("pre")[1]
		local var_16_4

		if arg_16_0:IsShow(arg_15_1, arg_15_2, arg_15_3) then
			local var_16_1 = arg_16_0
			local var_16_2 = arg_16_0.IsMatchPre
			local var_16_3 = arg_15_0

			var_16_4 = var_16_2(var_16_1, var_5.GetHistoryCntById(var_16_3, var_16_0))
		end

		return var_16_4
	end)
end

function var_0_0.ClearLocalPlansData(arg_17_0)
	getProxy = var_1_10001
	EducateProxy = var_1_10003

	local var_17_0 = var_1_10001(var_1_10003)
	local var_17_1 = var_1.GetCharData(var_17_0)
	local var_17_2 = var_1.GetNextWeekPlanCnt(var_17_1)

	for iter_17_0 = 1, 6 do
		for iter_17_1 = 1, 3 do
			if iter_17_1 <= var_17_2 then
				EducateGrid = var_1_10010

				if not var_1_10010.TYPE_EMPTY then
					EducateGrid = var_1_10010
					var_1_10010 = var_1_10010.TYPE_LOCK
				end

				local var_17_3 = 0 .. "_" .. var_1_10010

				PlayerPrefs = var_12

				local var_17_4 = var_12.SetString

				EducateConst = var_1_10014

				var_17_4(var_1_10014.PLANS_DATA_KEY .. arg_17_0.playerId .. "_" .. iter_17_0 .. "_" .. iter_17_1, var_17_3)
			end
		end
	end

	return
end

function var_0_0.GetRecommendPlan(arg_18_0, arg_18_1, arg_18_2, arg_18_3, arg_18_4, arg_18_5, arg_18_6, arg_18_7)
	local var_18_0 = arg_18_0:GetShowPlans(arg_18_3:GetNextWeekStage(), arg_18_1, arg_18_2)
	local var_18_1 = arg_18_3.money - arg_18_4
	local var_18_2 = arg_18_3.mood - arg_18_5

	ipairs = var_11

	for iter_18_0, iter_18_1 in var_11(arg_18_7) do
		table = var_1_10016
		var_1_10016 = var_1_10016.sort

		local var_18_3 = var_18_0

		CompareFuncs = iter_18_2

		var_1_10016(var_18_3, iter_18_2({
			function(arg_19_0)
				return -arg_19_0:GetAttrResultValue(iter_18_1)
			end,
			function(arg_20_0)
				return arg_20_0.id
			end
		}))

		ipairs = var_1_10016

		for iter_18_2, iter_18_3 in var_1_10016(var_18_0) do
			local var_18_4, var_18_5, var_18_6 = iter_18_3:GetCost()

			if var_18_4 <= var_18_1 and var_18_5 <= var_18_2 and var_18_6 <= arg_18_6 and iter_18_3:IsMatchAttr(arg_18_3) and iter_18_3:IsMatchPre(arg_18_0:GetHistoryCntById(iter_18_3.id)) then
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
	local var_23_0 = {}

	pairs = var_1_10002

	for iter_23_0, iter_23_1 in var_1_10002(arg_23_0) do
		pairs = var_1_10007

		for iter_23_2, iter_23_3 in var_1_10007(iter_23_1) do
			if iter_23_3:IsPlan() then
				table = var_12

				var_12.insert(var_23_0, {
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
				table = var_12

				var_12.insert(var_23_0, {
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

	return var_23_0
end

return var_0_0
