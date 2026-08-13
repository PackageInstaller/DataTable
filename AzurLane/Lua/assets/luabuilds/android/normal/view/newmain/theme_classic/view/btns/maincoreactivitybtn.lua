class = var_0_10000

local var_0_0 = "MainCoreActivityBtn"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".MainBaseActivityBtn"))

function var_0_1.Register(arg_1_0)
	var_0_1.super.Register(arg_1_0)

	local var_1_0 = arg_1_0.event
	local var_1_1 = var_1.connect

	MainBaseActivityBtn = var_1_10003

	local var_1_2 = var_1_10003.UPDATED_TIP

	handler = var_1_10004

	var_1_1(var_1_0, var_1_2, var_1_10004(arg_1_0, arg_1_0.OnRefreshBtn))

	return
end

function var_0_1.GetEventName(arg_2_0)
	return "event_core"
end

function var_0_1.OnInit(arg_3_0)
	arg_3_0:PickPriortyActAsyn(function(arg_4_0, arg_4_1)
		arg_3_0.priority = arg_4_0

		local var_4_0

		if 0 < arg_4_1 then
			var_4_0 = arg_3_0.tipTxt
			var_4_0.text = arg_4_1
		end

		setActive = var_4_0

		var_4_0(arg_3_0.tipTr.gameObject, arg_4_1 > 0)

		return
	end)

	return
end

function var_0_1.PickPriortyActAsyn(arg_5_0, arg_5_1)
	local var_5_0 = {}
	local var_5_1 = 0
	local var_5_2

	table = var_1_10005

	var_1_10005.insert(var_5_0, function(arg_6_0)
		local var_6_0 = arg_5_0
		local var_6_1, var_6_2 = var_1.CollectActivity(var_6_0)

		var_5_2 = var_6_2
		var_5_1 = var_5_1 + var_6_1
		onNextTick = var_3

		var_3(arg_6_0)

		return
	end)

	seriesAsync = var_5

	var_5(var_5_0, function()
		arg_5_1(var_5_2, var_5_1)

		return
	end)

	return
end

function var_0_1.CollectActivity(arg_8_0)
	local var_8_0 = arg_8_0
	local var_8_1 = arg_8_0.GetLinkConfig(var_8_0).time[2]

	pg = var_8_0

	local var_8_2 = var_8_0.activity_template[var_8_1].page_core
	local var_8_3 = 0
	local var_8_4

	getProxy = var_1_10005
	ActivityProxy = var_1_10006

	local var_8_5 = var_1_10005(var_1_10006)
	local var_8_6 = var_5.getCorePanelActivities(var_8_5, var_8_2)

	pairs = var_8_5

	for iter_8_0, iter_8_1 in var_8_5(var_8_6) do
		if iter_8_1:readyToAchieve() then
			var_8_3 = var_8_3 + 1

			if not var_8_4 or var_8_4 and var_8_4.id > iter_8_1.id then
				var_8_4 = iter_8_1
			end
		end
	end

	return var_8_3, var_8_4
end

function var_0_1.GetTipImage(arg_9_0)
	return "tip_1920"
end

function var_0_1.OnRefreshBtn(arg_10_0)
	arg_10_0:OnInit()

	return
end

function var_0_1.Dispose(arg_11_0)
	local var_11_0 = arg_11_0.event
	local var_11_1 = var_1.disconnect

	MainBaseActivityBtn = var_1_10003

	local var_11_2 = var_1_10003.UPDATED_TIP

	handler = var_1_10004

	var_11_1(var_11_0, var_11_2, var_1_10004(arg_11_0, arg_11_0.OnRefreshBtn))
	var_0_1.super.Dispose(arg_11_0)

	return
end

return var_0_1
