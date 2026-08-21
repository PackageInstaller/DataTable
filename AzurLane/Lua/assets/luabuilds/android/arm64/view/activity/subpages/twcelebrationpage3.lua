local var_0_0 = class("TWCelebrationPage3", import("...base.BaseActivityPage"))

function var_0_0.OnInit(arg_1_0)
	arg_1_0.bg = arg_1_0._tf:Find("AD")
	arg_1_0.getBtn = arg_1_0._tf:Find("AD/get")
	arg_1_0.gotBtn = arg_1_0._tf:Find("AD/got")
	arg_1_0.share = arg_1_0._tf:Find("AD/share")
	arg_1_0.mask = arg_1_0._tf:Find("AD/mask")
	arg_1_0.finished = arg_1_0._tf:Find("AD/finished")
	arg_1_0.unfinished = arg_1_0._tf:Find("AD/unfinished")

	return
end

function var_0_0.OnFirstFlush(arg_2_0)
	return
end

function var_0_0.OnUpdateFlush(arg_3_0)
	local var_3_0 = arg_3_0.activity:getConfig("config_data")[1]
	local var_3_1 = getProxy(TaskProxy)
	local var_3_2 = var_3_1:getTaskById(var_3_0) or var_3_1:getFinishTaskById(var_3_0) or Task.New({
		id = var_3_0
	})
	local var_3_3 = var_3_2:isFinish()
	local var_3_4 = var_3_2:isReceive()

	setActive(arg_3_0.getBtn, var_3_2 and var_3_3 and not var_3_4)
	setActive(arg_3_0.gotBtn, var_3_2 and var_3_4)
	setActive(arg_3_0.mark, var_3_2 and var_3_4)
	setActive(arg_3_0.share, var_3_2 and not var_3_3)
	setActive(arg_3_0.finished, var_3_2 and var_3_3)
	setActive(arg_3_0.unfinished, var_3_2 and not var_3_3)
	onButton(arg_3_0, arg_3_0.share, function()
		arg_3_0:share()

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0.getBtn, function()
		if var_3_2 and var_3_3 and not var_3_4 then
			arg_3_0:emit(ActivityMediator.ON_TASK_SUBMIT, var_3_2)
		end

		return
	end, SFX_PANEL)

	return
end

function var_0_0.share(arg_6_0)
	arg_6_0:initShare()

	return
end

function var_0_0.initShare(arg_7_0)
	PoolMgr.GetInstance():GetUI("TWCelebrationShare", false, function(arg_8_0)
		SetParent(arg_8_0, GameObject.Find("UICamera"):GetComponent(typeof(Camera)).transform:GetChild(0), false)

		return
	end)

	return
end

return var_0_0
