class = var_0_10000

local var_0_0 = "HelenaFramePage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.activity.CorePage.CoreNewFrameTemplatePage"))

function var_0_1.OnInit(arg_1_0)
	arg_1_0.super.OnInit(arg_1_0)

	local var_1_0 = arg_1_0.bg

	arg_1_0.battleBtn = var_1.Find(var_1_0, "switcher/phase2/task_bg_2/battle_btn")

	local var_1_1 = arg_1_0.bg

	arg_1_0.getBtn = var_1.Find(var_1_1, "switcher/phase2/task_bg_2/get_btn")

	local var_1_2 = arg_1_0.bg

	arg_1_0.gotBtn = var_1.Find(var_1_2, "switcher/phase2/task_bg_2/got_btn")

	local var_1_3 = arg_1_0._tf

	arg_1_0.switchBtn = var_1.Find(var_1_3, "AD/switcher/switch_btn")

	local var_1_4 = arg_1_0._tf

	arg_1_0.gotTag = var_1.Find(var_1_4, "AD/switcher/phase2/task_bg_2/Image/got")

	local var_1_5 = arg_1_0._tf

	arg_1_0.bar = var_1.Find(var_1_5, "AD/switcher/phase2/task_bg_2/Image/barContent/bar")

	local var_1_6 = arg_1_0._tf

	arg_1_0.cur = var_1.Find(var_1_6, "AD/switcher/phase2/task_bg_2/Image/step")

	local var_1_7 = arg_1_0._tf

	arg_1_0.target = var_1.Find(var_1_7, "AD/switcher/phase2/task_bg_2/Image/progress")
	setText = var_1

	local var_1_8 = arg_1_0._tf
	local var_1_9 = var_2.Find(var_1_8, "AD/switcher/phase2/task_bg_2/battle_btn/Text")

	i18n = var_1_8

	var_1(var_1_9, var_1_8("other_world_task_go"))

	setText = var_1

	local var_1_10 = arg_1_0._tf
	local var_1_11 = var_2.Find(var_1_10, "AD/switcher/phase2/task_bg_2/get_btn/Text")

	i18n = var_1_10

	var_1(var_1_11, var_1_10("other_world_task_get"))

	setText = var_1

	local var_1_12 = arg_1_0._tf
	local var_1_13 = var_2.Find(var_1_12, "AD/switcher/phase2/task_bg_2/got_btn/Text")

	i18n = var_1_12

	var_1(var_1_13, var_1_12("other_world_task_got"))

	return
end

function var_0_1.OnFirstFlush(arg_2_0)
	onButton = var_1_10001

	local var_2_0 = arg_2_0
	local var_2_1 = arg_2_0.battleBtn

	local function var_2_2()
		local var_3_0 = arg_2_0
		local var_3_1 = var_0.emit

		ActivityMediator = var_2_10002

		local var_3_2 = var_2_10002.EVENT_GO_SCENE

		SCENE = var_2_10003

		var_3_1(var_3_0, var_3_2, var_2_10003.TASK)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_2_0, var_2_1, var_2_2, var_1_10005)

	onButton = var_1_10001

	local var_2_3 = arg_2_0
	local var_2_4 = arg_2_0.getBtn

	local function var_2_5()
		local var_4_0 = arg_2_0
		local var_4_1 = var_0.emit

		ActivityMediator = var_2_10002

		var_4_1(var_4_0, var_2_10002.EVENT_OPERATION, {
			cmd = 1,
			activity_id = arg_2_0.activity.id
		})

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_2_3, var_2_4, var_2_5, var_1_10005)

	onToggle = var_1_10001

	local var_2_6 = arg_2_0
	local var_2_7 = arg_2_0.switchBtn

	local function var_2_8(arg_5_0)
		if arg_2_0.isSwitching then
			return
		end

		local var_5_0 = arg_2_0

		var_1.Switch(var_5_0, arg_5_0)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_2_6, var_2_7, var_2_8, var_1_10005)

	local var_2_10

	if arg_2_0.timeStamp then
		pg = var_2_10

		local var_2_9 = var_2_10.TimeMgr.GetInstance()

		var_2_10 = var_2_10.GetServerTime(var_2_9) - arg_2_0.timeStamp > 0
	end

	arg_2_0.inPhase2 = var_2_10
	triggerToggle = var_2_10

	var_2_10(arg_2_0.switchBtn, arg_2_0.inPhase2)

	return
end

function var_0_1.OnUpdateFlush(arg_6_0)
	var_0_1.super.OnUpdateFlush(arg_6_0)

	local var_6_0 = arg_6_0.activity.data1

	var_6_0 = arg_6_0.avatarConfig.target < var_6_0 and var_2 or var_6_0

	local var_6_1 = var_6_0 / var_2

	setText = var_1_10004

	local var_6_2 = arg_6_0.cur

	if 1 <= var_6_1 then
		setColorStr = var_6_3

		local var_6_3

		if not var_6_3(var_6_0, "#FCE87A") then
			setColorStr = var_6_3
			var_6_3 = var_6_3(var_6_0, "#FCE87A")
		end

		setColorStr = var_1_10007

		var_1_10004(var_6_2, var_6_3 .. var_1_10007("/" .. var_2, "#FFFFFF"))

		setActive = var_1_10004

		var_1_10004(arg_6_0.target, false)

		return
	end
end

function var_0_1.Switch(arg_7_0, arg_7_1)
	arg_7_0.isSwitching = true
	setToggleEnabled = var_2

	var_2(arg_7_0.switchBtn, false)

	if arg_7_1 then
		quickPlayAnimation = var_2

		local var_7_0 = arg_7_0.bg

		var_2(var_3.Find(var_7_0, "switcher"), "anim_HelenaFramePage_switcher")
	else
		quickPlayAnimation = var_2

		local var_7_1 = arg_7_0.bg

		var_2(var_3.Find(var_7_1, "switcher"), "anim_HelenaFramePage_switcher2")
	end

	arg_7_0.isSwitching = nil
	setToggleEnabled = var_2

	var_2(arg_7_0.switchBtn, true)

	return
end

return var_0_1
