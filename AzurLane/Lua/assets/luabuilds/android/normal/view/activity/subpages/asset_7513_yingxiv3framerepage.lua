class = var_0_10000

local var_0_0 = "YingxiV3FrameRePage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".TemplatePage.NewFrameTemplatePage"))

function var_0_1.OnInit(arg_1_0)
	local var_1_0 = arg_1_0._tf

	arg_1_0.bg = var_1.Find(var_1_0, "AD")

	local var_1_1 = arg_1_0.bg

	arg_1_0.battleBtn = var_1.Find(var_1_1, "btn/battle_btn")

	local var_1_2 = arg_1_0.bg

	arg_1_0.getBtn = var_1.Find(var_1_2, "btn/get_btn")

	local var_1_3 = arg_1_0.bg

	arg_1_0.gotBtn = var_1.Find(var_1_3, "btn/got_btn")

	local var_1_4 = arg_1_0.bg

	arg_1_0.bar = var_1.Find(var_1_4, "barContent/bar")

	local var_1_5 = arg_1_0.bg

	arg_1_0.cur = var_1.Find(var_1_5, "progress/cur")

	local var_1_6 = arg_1_0.bg

	arg_1_0.target = var_1.Find(var_1_6, "progress/target")

	local var_1_7 = arg_1_0.bg

	arg_1_0.gotTag = var_1.Find(var_1_7, "tag/got")

	local var_1_8 = arg_1_0.bg

	arg_1_0.getTag = var_1.Find(var_1_8, "tag/get")

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

	local var_2_7

	if arg_2_0.timeStamp then
		pg = var_2_7

		local var_2_6 = var_2_7.TimeMgr.GetInstance()

		var_2_7 = var_2_7.GetServerTime(var_2_6) - arg_2_0.timeStamp > 0
	end

	arg_2_0.inPhase2 = var_2_7

	return
end

function var_0_1.OnUpdateFlush(arg_5_0)
	var_0_1.super.OnUpdateFlush(arg_5_0)

	local var_5_0 = arg_5_0.activity.data1
	local var_5_1 = arg_5_0.avatarConfig.target
	local var_5_2 = arg_5_0.activity.data2 >= 1
	local var_5_3 = var_5_1 <= var_5_0

	setActive = var_1_10005

	local var_5_4 = arg_5_0.getTag
	local var_5_5

	if arg_5_0.inPhase2 then
		var_5_5 = not var_5_2 and var_5_3
	end

	var_1_10005(var_5_4, var_5_5)

	return
end

return var_0_1
