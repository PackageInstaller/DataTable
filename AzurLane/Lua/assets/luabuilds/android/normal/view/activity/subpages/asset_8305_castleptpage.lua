class = var_0_10000

local var_0_0 = "CastlePtPage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".TemplatePage.PtTemplatePage"))

ActivityConst = var_0_0
var_0_1.MAIN_ID = var_0_0.CASTLE_ACT_ID

function var_0_1.OnFirstFlush(arg_1_0)
	var_0_1.super.OnFirstFlush(arg_1_0)

	onButton = var_1

	local var_1_0 = arg_1_0
	local var_1_1 = arg_1_0.bg
	local var_1_2 = var_3.Find(var_1_1, "main_btn")

	local function var_1_3()
		local var_2_0 = arg_1_0
		local var_2_1 = var_0.emit

		ActivityMediator = var_2_10002

		local var_2_2 = var_2_10002.EVENT_GO_SCENE

		SCENE = var_2_10003

		var_2_1(var_2_0, var_2_2, var_2_10003.CASTLE_MAIN)

		return
	end

	SFX_PANEL = var_5

	var_1(var_1_0, var_1_2, var_1_3, var_5)

	return
end

function var_0_1.OnUpdateFlush(arg_3_0)
	var_0_1.super.OnUpdateFlush(arg_3_0)

	getProxy = var_1
	ActivityProxy = var_2

	local var_3_0 = var_1(var_2)

	arg_3_0.mainAct = var_1.getActivityById(var_3_0, var_0_1.MAIN_ID)

	local var_3_1 = arg_3_0.mainAct.data2
	local var_3_2 = arg_3_0.mainAct.data1

	table = var_3

	local var_3_4

	if var_3.contains({
		4565,
		4568,
		4571,
		4574,
		4577,
		4580,
		4583,
		4586
	}, var_3_2) then
		pg = var_3_4

		local var_3_3 = var_3_4.NewStoryMgr.GetInstance()

		var_3_4 = var_3_4.IsPlayed
		pg = var_5

		local var_3_5 = var_5.NewStoryMgr.GetInstance()

		if not var_3_4(var_3_3, var_5.StoryId2StoryName(var_3_5, var_3_2)) then
			var_3_1 = var_3_1 - 1
		end
	end

	setText = var_3_4

	local var_3_6 = arg_3_0.bg
	local var_3_7 = var_4.Find(var_3_6, "main_btn/Text")

	i18n = var_3_6

	var_3_4(var_3_7, var_3_6("roll_times_left", var_3_1))

	setText = var_3_4

	local var_3_8 = arg_3_0.bg
	local var_3_9 = var_4.Find(var_3_8, "description")

	i18n = var_3_8

	var_3_4(var_3_9, var_3_8("activity_kill"))

	return
end

return var_0_1
