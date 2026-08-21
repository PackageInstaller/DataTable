local var_0_0 = class("MainCoreActivityBtn", import(".MainBaseActivityBtn"))

function var_0_0.Register(arg_1_0)
	var_0_0.super.Register(arg_1_0)
	arg_1_0.event:connect(MainBaseActivityBtn.UPDATED_TIP, handler(arg_1_0, arg_1_0.OnRefreshBtn))

	return
end

function var_0_0.GetEventName(arg_2_0)
	return "event_core"
end

function var_0_0.OnInit(arg_3_0)
	arg_3_0:PickPriortyActAsyn(function(arg_4_0, arg_4_1)
		arg_3_0.priority = arg_4_0

		if arg_4_1 > 0 then
			arg_3_0.tipTxt.text = arg_4_1
		end

		setActive(arg_3_0.tipTr.gameObject, arg_4_1 > 0)

		return
	end)

	return
end

function var_0_0.PickPriortyActAsyn(arg_5_0, arg_5_1)
	local var_5_0 = 0
	local var_5_1

	table.insert({}, function(arg_6_0)
		local var_6_0, var_6_1 = arg_5_0:CollectActivity()

		var_5_1 = var_6_1
		var_5_0 = var_5_0 + var_6_0

		onNextTick(arg_6_0)

		return
	end)
	seriesAsync({}, function()
		arg_5_1(var_5_1, var_5_0)

		return
	end)

	return
end

function var_0_0.CollectActivity(arg_8_0)
	local var_8_0 = 0
	local var_8_1

	for iter_8_0, iter_8_1 in pairs((getProxy(ActivityProxy):getCorePanelActivities(pg.activity_template[arg_8_0:GetLinkConfig().time[2]].page_core))) do
		if iter_8_1:readyToAchieve() then
			var_8_0 = var_8_0 + 1

			if not var_8_1 or var_8_1 and var_8_1.id > iter_8_1.id then
				var_8_1 = iter_8_1
			end
		end
	end

	return var_8_0, var_8_1
end

function var_0_0.GetTipImage(arg_9_0)
	return "tip_1920"
end

function var_0_0.OnRefreshBtn(arg_10_0)
	arg_10_0:OnInit()

	return
end

function var_0_0.Dispose(arg_11_0)
	arg_11_0.event:disconnect(MainBaseActivityBtn.UPDATED_TIP, handler(arg_11_0, arg_11_0.OnRefreshBtn))
	var_0_0.super.Dispose(arg_11_0)

	return
end

return var_0_0
