local var_0_0 = class("ShadowPlayPage", import("...base.BaseActivityPage"))

function var_0_0.OnInit(arg_1_0)
	arg_1_0.bg = arg_1_0._tf:Find("AD")
	arg_1_0.getBtn = arg_1_0._tf:Find("AD/get")
	arg_1_0.gotBtn = arg_1_0._tf:Find("AD/got")
	arg_1_0.urlBtn = arg_1_0._tf:Find("AD/url")

	return
end

function var_0_0.OnFirstFlush(arg_2_0)
	onButton(arg_2_0, arg_2_0.urlBtn, function()
		Application.OpenURL(arg_2_0.activity:getConfig("config_client"))

		return
	end, SFX_PANEL)

	return
end

function var_0_0.OnUpdateFlush(arg_4_0)
	local var_4_0 = arg_4_0.activity:getConfig("config_data")[1]
	local var_4_1 = getProxy(TaskProxy)
	local var_4_2 = var_4_1:getTaskById(var_4_0) or var_4_1:getFinishTaskById(var_4_0) or Task.New({
		id = var_4_0
	})
	local var_4_3 = var_4_2:isFinish()
	local var_4_4 = var_4_2:isReceive()

	setActive(arg_4_0.getBtn, var_4_2 and var_4_3 and not var_4_4)
	setActive(arg_4_0.gotBtn, var_4_2 and var_4_4)
	onButton(arg_4_0, arg_4_0.getBtn, function()
		if var_4_2 and var_4_3 and not var_4_4 then
			arg_4_0:emit(ActivityMediator.ON_TASK_SUBMIT, var_4_2)
		end

		return
	end, SFX_PANEL)

	return
end

function var_0_0.OnDestroy(arg_6_0)
	return
end

return var_0_0
