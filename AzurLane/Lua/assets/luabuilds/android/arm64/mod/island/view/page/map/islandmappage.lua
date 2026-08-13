class = var_0_10000

local var_0_0 = "IslandMapPage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".IslandBaseMapPage"))

function var_0_1.OnInit(arg_1_0)
	var_0_1.super.OnInit(arg_1_0)

	arg_1_0.timers = {}

	return
end

function var_0_1.Flush(arg_2_0)
	var_0_1.super.Flush(arg_2_0)

	pairs = var_1

	for iter_2_0, iter_2_1 in var_1(arg_2_0.maps) do
		if arg_2_0:CheckUnlock(iter_2_0) then
			arg_2_0:CheckProductions(iter_2_0)
			arg_2_0:CheckAcceptableTask(iter_2_0)
			arg_2_0:CheckFinishableTask(iter_2_0)

			setActive = var_6

			local var_2_0 = iter_2_1:Find("icon")

			isActive = var_9

			local var_2_1

			if not var_9(iter_2_1:Find("fetch")) then
				isActive = var_9

				if not var_9(iter_2_1:Find("finish")) then
					isActive = var_9
					var_2_1 = not var_9(iter_2_1:Find("fetch"))

					goto label_2_0
				end
			end

			var_2_1 = false

			if false then
				var_2_1 = true
			end

			::label_2_0::

			var_6(var_2_0, var_2_1)
		end
	end

	return
end

function var_0_1.OnHide(arg_3_0)
	arg_3_0:RemoveAllTimer()

	return
end

function var_0_1.CheckAcceptableTask(arg_4_0, arg_4_1)
	local function var_4_0(arg_5_0)
		local var_5_0 = arg_4_0.maps[arg_4_1]

		SetActive = var_2

		var_2(var_5_0:Find("fetch"), arg_5_0)

		return
	end

	getProxy = var_1_10003
	IslandProxy = var_1_10005

	local var_4_1 = var_1_10003(var_1_10005)
	local var_4_2 = var_3.GetIsland(var_4_1)
	local var_4_3 = var_3.GetTaskAgency(var_4_2)
	local var_4_4 = var_3.GetCanAcceptTasksByMapId(var_4_3, arg_4_1)

	var_4_0(#var_4_4 > 0)

	return
end

function var_0_1.CheckFinishableTask(arg_6_0, arg_6_1)
	local function var_6_0(arg_7_0)
		local var_7_0 = arg_6_0.maps[arg_6_1]

		SetActive = var_2

		var_2(var_7_0:Find("finish"), arg_7_0)

		return
	end

	getProxy = var_1_10003
	IslandProxy = var_1_10005

	local var_6_1 = var_1_10003(var_1_10005)
	local var_6_2 = var_3.GetIsland(var_6_1)
	local var_6_3 = var_3.GetTaskAgency(var_6_2)
	local var_6_4 = var_3.GetCanSubmitTasksByMapId(var_6_3, arg_6_1)

	var_6_0(#var_6_4 > 0)

	return
end

function var_0_1.CheckProductions(arg_8_0, arg_8_1)
	local function var_8_0(arg_9_0)
		local var_9_0 = arg_8_0.maps[arg_8_1]

		SetActive = var_2

		var_2(var_9_0:Find("full"), arg_9_0)

		return
	end

	local var_8_1

	if arg_8_0.timers[arg_8_1] then
		var_1_10005 = arg_8_0.timers[arg_8_1]

		var_8_1.Stop(var_1_10005)

		var_8_1 = arg_8_0.timers
		var_8_1[arg_8_1] = nil
	end

	getProxy = var_8_1
	IslandProxy = var_1_10005

	local var_8_2 = var_8_1(var_1_10005)
	local var_8_3 = var_3.GetIsland(var_8_2)
	local var_8_4 = var_3.GetBuildingAgency(var_8_3)

	if var_3.GetMinimumDelegationCompletionTimeByMapId(var_8_4, arg_8_1) < 0 then
		var_8_0(false)

		return
	end

	pg = var_5

	local var_8_5 = var_5.TimeMgr.GetInstance()

	if var_4 - var_5.GetServerTime(var_8_5) <= 0 then
		var_8_0(true)

		return
	end

	local var_8_6 = arg_8_0.timers

	Timer = var_1_10008
	var_8_6[arg_8_1] = var_1_10008.New(function()
		var_8_0(true)

		return
	end, var_6, 1)

	local var_8_7 = arg_8_0.timers[arg_8_1]

	var_7.Start(var_8_7)

	return
end

function var_0_1.RemoveAllTimer(arg_11_0)
	pairs = var_1_10001

	for iter_11_0, iter_11_1 in var_1_10001(arg_11_0.timers) do
		iter_11_1:Stop()
	end

	arg_11_0.timers = {}

	return
end

function var_0_1.GoDesc(arg_12_0, arg_12_1)
	local var_12_0 = arg_12_0
	local var_12_1 = arg_12_0.OpenPage

	IslandMapDescPage = var_1_10005

	var_12_1(var_12_0, var_1_10005, arg_12_1)

	return
end

function var_0_1.OnDestroy(arg_13_0)
	arg_13_0:RemoveAllTimer()

	return
end

return var_0_1
