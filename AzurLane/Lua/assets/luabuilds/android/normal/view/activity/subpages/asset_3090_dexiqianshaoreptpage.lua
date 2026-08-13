class = var_0_10000

local var_0_0 = "DeXiQianShaoRePtPage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".TemplatePage.NewFrameTemplatePage"))

function var_0_1.OnInit(arg_1_0)
	local var_1_0 = arg_1_0._tf

	arg_1_0.bg = var_1.Find(var_1_0, "AD")

	local var_1_1 = arg_1_0.bg

	arg_1_0.battleBtn = var_1.Find(var_1_1, "battle_btn")

	local var_1_2 = arg_1_0.bg

	arg_1_0.getBtn = var_1.Find(var_1_2, "get_btn")

	local var_1_3 = arg_1_0.bg

	arg_1_0.gotBtn = var_1.Find(var_1_3, "got_btn")

	local var_1_4 = arg_1_0._tf

	arg_1_0.switchBtn = var_1.Find(var_1_4, "AD/switcher/switch_btn")

	local var_1_5 = {}
	local var_1_6 = arg_1_0._tf

	var_1_5[1] = var_2.Find(var_1_6, "AD/switcher/phase1")

	local var_1_7 = arg_1_0._tf

	var_1_5[2] = var_2.Find(var_1_7, "AD/switcher/phase2")
	arg_1_0.phases = var_1_5

	local var_1_8 = arg_1_0._tf

	arg_1_0.bar = var_1.Find(var_1_8, "AD/switcher/phase2/Image/bar")

	local var_1_9 = arg_1_0._tf

	arg_1_0.cur = var_1.Find(var_1_9, "AD/switcher/phase2/Image/step")

	local var_1_10 = arg_1_0._tf

	arg_1_0.target = var_1.Find(var_1_10, "AD/switcher/phase2/Image/progress")

	local var_1_11 = arg_1_0._tf

	arg_1_0.gotTag = var_1.Find(var_1_11, "AD/switcher/phase2/got")

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

	IsNil = var_2_10

	local var_2_11 = arg_2_0.gotTag

	if not var_2_10(var_2.Find(var_2_11, "Text")) then
		setText = var_1

		local var_2_12 = arg_2_0.gotTag
		local var_2_13 = var_2.Find(var_2_12, "Text")

		i18n = var_2_12

		var_1(var_2_13, var_2_12("avatarframe_got"))
	end

	return
end

return var_0_1
