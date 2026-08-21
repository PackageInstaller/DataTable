local var_0_0 = class("HelenaFramePage", import("view.activity.CorePage.CoreNewFrameTemplatePage"))

function var_0_0.OnInit(arg_1_0)
	arg_1_0.super.OnInit(arg_1_0)

	arg_1_0.battleBtn = arg_1_0.bg:Find("switcher/phase2/task_bg_2/battle_btn")
	arg_1_0.getBtn = arg_1_0.bg:Find("switcher/phase2/task_bg_2/get_btn")
	arg_1_0.gotBtn = arg_1_0.bg:Find("switcher/phase2/task_bg_2/got_btn")
	arg_1_0.switchBtn = arg_1_0._tf:Find("AD/switcher/switch_btn")
	arg_1_0.gotTag = arg_1_0._tf:Find("AD/switcher/phase2/task_bg_2/Image/got")
	arg_1_0.bar = arg_1_0._tf:Find("AD/switcher/phase2/task_bg_2/Image/barContent/bar")
	arg_1_0.cur = arg_1_0._tf:Find("AD/switcher/phase2/task_bg_2/Image/step")
	arg_1_0.target = arg_1_0._tf:Find("AD/switcher/phase2/task_bg_2/Image/progress")

	setText(arg_1_0._tf:Find("AD/switcher/phase2/task_bg_2/battle_btn/Text"), i18n("other_world_task_go"))
	setText(arg_1_0._tf:Find("AD/switcher/phase2/task_bg_2/get_btn/Text"), i18n("other_world_task_get"))
	setText(arg_1_0._tf:Find("AD/switcher/phase2/task_bg_2/got_btn/Text"), i18n("other_world_task_got"))

	return
end

function var_0_0.OnFirstFlush(arg_2_0)
	onButton(arg_2_0, arg_2_0.battleBtn, function()
		arg_2_0:emit(ActivityMediator.EVENT_GO_SCENE, SCENE.TASK)

		return
	end, SFX_PANEL)
	onButton(arg_2_0, arg_2_0.getBtn, function()
		arg_2_0:emit(ActivityMediator.EVENT_OPERATION, {
			cmd = 1,
			activity_id = arg_2_0.activity.id
		})

		return
	end, SFX_PANEL)
	onToggle(arg_2_0, arg_2_0.switchBtn, function(arg_5_0)
		if arg_2_0.isSwitching then
			return
		end

		arg_2_0:Switch(arg_5_0)

		return
	end, SFX_PANEL)

	arg_2_0.inPhase2 = arg_2_0.timeStamp and pg.TimeMgr.GetInstance():GetServerTime() - arg_2_0.timeStamp > 0

	triggerToggle(arg_2_0.switchBtn, arg_2_0.inPhase2)

	return
end

function var_0_0.OnUpdateFlush(arg_6_0)
	var_0_0.super.OnUpdateFlush(arg_6_0)

	local var_6_0 = arg_6_0.avatarConfig.target
	local var_6_1, var_6_2

	if arg_6_0.avatarConfig.target < arg_6_0.activity.data1 and not var_6_0 then
		var_6_1 = setText
		var_6_2 = arg_6_0.cur
	end

	local var_6_3 = arg_6_0.activity.data1 / var_6_0 >= 1 and setColorStr(arg_6_0.activity.data1, "#FCE87A") or setColorStr(arg_6_0.activity.data1, "#FCE87A")

	var_6_1(var_6_2, var_6_3 .. setColorStr("/" .. var_6_0, "#FFFFFF"))
	setActive(arg_6_0.target, false)

	return
end

function var_0_0.Switch(arg_7_0, arg_7_1)
	arg_7_0.isSwitching = true

	setToggleEnabled(arg_7_0.switchBtn, false)

	if arg_7_1 then
		quickPlayAnimation(arg_7_0.bg:Find("switcher"), "anim_HelenaFramePage_switcher")
	else
		quickPlayAnimation(arg_7_0.bg:Find("switcher"), "anim_HelenaFramePage_switcher2")
	end

	arg_7_0.isSwitching = nil

	setToggleEnabled(arg_7_0.switchBtn, true)

	return
end

return var_0_0
