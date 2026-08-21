local var_0_0 = class("IslandMapPage", import(".IslandBaseMapPage"))

function var_0_0.OnInit(arg_1_0)
	var_0_0.super.OnInit(arg_1_0)

	arg_1_0.timers = {}

	return
end

function var_0_0.Flush(arg_2_0)
	var_0_0.super.Flush(arg_2_0)

	for iter_2_0, iter_2_1 in pairs(arg_2_0.maps) do
		if arg_2_0:CheckUnlock(iter_2_0) then
			arg_2_0:CheckProductions(iter_2_0)
			arg_2_0:CheckAcceptableTask(iter_2_0)
			arg_2_0:CheckFinishableTask(iter_2_0)
			setActive(iter_2_1:Find("icon"), not isActive(iter_2_1:Find("fetch")) and not isActive(iter_2_1:Find("finish")) and not isActive(iter_2_1:Find("fetch")))
		end
	end

	return
end

function var_0_0.OnHide(arg_3_0)
	arg_3_0:RemoveAllTimer()

	return
end

function var_0_0.CheckAcceptableTask(arg_4_0, arg_4_1)
	local var_4_0 = getProxy(IslandProxy):GetIsland():GetTaskAgency()

	;(function(arg_5_0)
		SetActive(arg_4_0.maps[arg_4_1]:Find("fetch"), arg_5_0)

		return
	end)(#var_4_0:GetCanAcceptTasksByMapId(arg_4_1) > 0)

	return
end

function var_0_0.CheckFinishableTask(arg_6_0, arg_6_1)
	local var_6_0 = getProxy(IslandProxy):GetIsland():GetTaskAgency()

	;(function(arg_7_0)
		SetActive(arg_6_0.maps[arg_6_1]:Find("finish"), arg_7_0)

		return
	end)(#var_6_0:GetCanSubmitTasksByMapId(arg_6_1) > 0)

	return
end

function var_0_0.CheckProductions(arg_8_0, arg_8_1)
	local function var_8_0(arg_9_0)
		SetActive(arg_8_0.maps[arg_8_1]:Find("full"), arg_9_0)

		return
	end

	if arg_8_0.timers[arg_8_1] then
		arg_8_0.timers[arg_8_1]:Stop()

		arg_8_0.timers[arg_8_1] = nil
	end

	local var_8_1 = getProxy(IslandProxy):GetIsland():GetBuildingAgency():GetMinimumDelegationCompletionTimeByMapId(arg_8_1)

	if var_8_1 < 0 then
		(function(arg_9_0)
			SetActive(arg_8_0.maps[arg_8_1]:Find("full"), arg_9_0)

			return
		end)(false)

		return
	end

	local var_8_2 = pg.TimeMgr.GetInstance()
	local var_8_3 = var_8_1 - var_8_2:GetServerTime()

	if var_8_3 <= 0 then
		(function(arg_9_0)
			SetActive(arg_8_0.maps[arg_8_1]:Find("full"), arg_9_0)

			return
		end)(true)

		return
	end

	arg_8_0.timers[arg_8_1] = Timer.New(function()
		var_8_0(true)

		return
	end, var_8_3, 1)

	arg_8_0.timers[arg_8_1]:Start()

	return
end

function var_0_0.RemoveAllTimer(arg_11_0)
	for iter_11_0, iter_11_1 in pairs(arg_11_0.timers) do
		iter_11_1:Stop()
	end

	arg_11_0.timers = {}

	return
end

function var_0_0.GoDesc(arg_12_0, arg_12_1)
	arg_12_0:OpenPage(IslandMapDescPage, arg_12_1)

	return
end

function var_0_0.OnDestroy(arg_13_0)
	arg_13_0:RemoveAllTimer()

	return
end

return var_0_0
