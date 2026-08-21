local var_0_0 = class("SkinGelideliPage", import("view.base.BaseActivityPage"))

function var_0_0.OnInit(arg_1_0)
	arg_1_0.bg = arg_1_0._tf:Find("AD")
	arg_1_0.textProgress = arg_1_0.bg:Find("progress_text")
	arg_1_0.btnGo = arg_1_0.bg:Find("btn_go")
	arg_1_0.markGot = arg_1_0.btnGo:Find("got")

	return
end

function var_0_0.OnDataSetting(arg_2_0)
	local var_2_0 = getProxy(TaskProxy)

	arg_2_0.taskList = arg_2_0.activity:getConfig("config_data")
	arg_2_0.taskIndex = #arg_2_0.taskList
	arg_2_0.taskVO = nil

	while arg_2_0.taskIndex > 0 do
		arg_2_0.taskVO = var_2_0:getTaskVO(arg_2_0.taskList[arg_2_0.taskIndex])

		if arg_2_0.taskVO then
			break
		end

		arg_2_0.taskIndex = arg_2_0.taskIndex - 1
	end

	return
end

function var_0_0.OnFirstFlush(arg_3_0)
	onButton(arg_3_0, arg_3_0.btnGo, function()
		if arg_3_0.taskVO and not arg_3_0.taskVO:isReceive() then
			arg_3_0:emit(ActivityMediator.EVENT_GO_SCENE, SCENE.TASK)
		else
			arg_3_0:emit(ActivityMediator.EVENT_GO_SCENE, SCENE.NAVALACADEMYSCENE)
		end

		return
	end, SFX_PANEL)

	return
end

function var_0_0.OnUpdateFlush(arg_5_0)
	setText(arg_5_0.textProgress, arg_5_0.taskIndex .. "/" .. #arg_5_0.taskList)
	setButtonEnabled(arg_5_0.btnGo, arg_5_0.taskIndex < #arg_5_0.taskList)
	setActive(arg_5_0.markGot, arg_5_0.taskIndex == #arg_5_0.taskList)

	return
end

function var_0_0.OnDestroy(arg_6_0)
	return
end

return var_0_0
