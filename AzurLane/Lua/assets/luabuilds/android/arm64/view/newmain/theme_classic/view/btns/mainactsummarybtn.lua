class = var_0_10000

local var_0_0 = "MainActSummaryBtn"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".MainBaseActivityBtn"))

function var_0_1.GetEventName(arg_1_0)
	return "event_all"
end

function var_0_1.GetTipImage(arg_2_0)
	return "tip_1920"
end

function var_0_1.GetActivityID(arg_3_0)
	return nil
end

function var_0_1.OnInit(arg_4_0)
	arg_4_0:PickPriortyActAsyn(function(arg_5_0, arg_5_1)
		arg_4_0.priority = arg_5_0

		local var_5_0

		if 0 < arg_5_1 then
			var_5_0 = arg_4_0.tipTxt
			var_5_0.text = arg_5_1
		end

		setActive = var_5_0

		var_5_0(arg_4_0.tipTr.gameObject, arg_5_1 > 0)

		return
	end)

	return
end

function var_0_1.PickPriortyActAsyn(arg_6_0, arg_6_1)
	local var_6_0 = {}
	local var_6_1 = 0
	local var_6_2

	table = var_1_10005

	var_1_10005.insert(var_6_0, function(arg_7_0)
		local var_7_0 = arg_6_0
		local var_7_1, var_7_2 = var_1.CollectActivity(var_7_0)

		var_6_2 = var_7_2
		var_6_1 = var_6_1 + var_7_1
		onNextTick = var_3

		var_3(arg_7_0)

		return
	end)

	table = var_5

	var_5.insert(var_6_0, function(arg_8_0)
		local var_8_0 = arg_6_0
		local var_8_1 = var_1.CollectActEntrance(var_8_0)

		var_6_1 = var_6_1 + var_8_1
		onNextTick = var_2

		var_2(arg_8_0)

		return
	end)

	seriesAsync = var_5

	var_5(var_6_0, function()
		arg_6_1(var_6_2, var_6_1)

		return
	end)

	return
end

function var_0_1.CollectActivity(arg_10_0)
	local var_10_0 = 0
	local var_10_1

	getProxy = var_1_10003
	ActivityProxy = var_1_10005

	local var_10_2 = var_1_10003(var_1_10005)
	local var_10_3 = var_3.getPanelActivities(var_10_2)

	pairs = var_1_10004

	for iter_10_0, iter_10_1 in var_1_10004(var_10_3) do
		if iter_10_1:readyToAchieve() then
			var_10_0 = var_10_0 + 1

			if not var_10_1 or var_10_1 and var_10_1.id > iter_10_1.id then
				var_10_1 = iter_10_1
			end
		end
	end

	return var_10_0, var_10_1
end

function var_0_1.CollectActEntrance(arg_11_0)
	local var_11_0 = 0

	ActivityMainScene = var_1_10002

	local var_11_1 = var_1_10002.GetOnShowEntranceData()

	_ = var_1_10003

	return #var_1_10003.filter(var_11_1, function(arg_12_0)
		local var_12_0

		if arg_12_0.isTip then
			var_12_0 = arg_12_0.isTip()
		end

		return var_12_0
	end)
end

function var_0_1.CustomOnClick(arg_13_0)
	pg = var_1_10001

	local var_13_0 = var_1_10001.m02
	local var_13_1 = var_1.sendNotification

	GAME = var_1_10004

	local var_13_2 = var_1_10004.GO_SCENE

	SCENE = var_1_10005

	var_13_1(var_13_0, var_13_2, var_1_10005.CARD_TOWER_MODE_SELECT)

	return
end

return var_0_1
