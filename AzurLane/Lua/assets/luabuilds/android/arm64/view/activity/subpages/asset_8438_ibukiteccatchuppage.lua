class = var_0_10000

local var_0_0 = "LuyijiushiTecCatchupPage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("...base.BaseActivityPage"))

function var_0_1.OnInit(arg_1_0)
	local var_1_0 = arg_1_0._tf

	arg_1_0.bg = var_1.Find(var_1_0, "AD")

	local var_1_1 = arg_1_0.bg

	arg_1_0.itemTF = var_1.Find(var_1_1, "Award")

	local var_1_2 = arg_1_0.bg

	arg_1_0.sliderTF = var_1.Find(var_1_2, "Slider")

	local var_1_3 = arg_1_0.bg

	arg_1_0.progressText = var_1.Find(var_1_3, "Progress")

	local var_1_4 = arg_1_0.bg

	arg_1_0.goBtn = var_1.Find(var_1_4, "GoBtn")

	local var_1_5 = arg_1_0.bg

	arg_1_0.finishBtn = var_1.Find(var_1_5, "FinishBtn")

	return
end

function var_0_1.OnDataSetting(arg_2_0)
	arg_2_0.curCount = arg_2_0.activity.data1

	local var_2_0 = arg_2_0.activity
	local var_2_1 = var_1.getConfig(var_2_0, "config_id")

	pg = var_1_10002
	arg_2_0.maxCount = var_1_10002.activity_event_blueprint_catchup[var_2_1].obtain_max

	local var_2_2 = arg_2_0.activity

	arg_2_0.itemID = var_2.getConfig(var_2_2, "config_client").itemid

	return
end

function var_0_1.OnFirstFlush(arg_3_0)
	local var_3_0 = {}

	DROP_TYPE_ITEM = var_1_10002
	var_3_0.type = var_1_10002
	var_3_0.id = arg_3_0.itemID
	updateDrop = var_2

	var_2(arg_3_0.itemTF, var_3_0)

	onButton = var_2

	local var_3_1 = arg_3_0
	local var_3_2 = arg_3_0.itemTF

	local function var_3_3()
		local var_4_0 = arg_3_0
		local var_4_1 = var_0.emit

		BaseUI = var_2_10003

		var_4_1(var_4_0, var_2_10003.ON_DROP, var_3_0)

		return
	end

	SFX_PANEL = var_1_10007

	var_2(var_3_1, var_3_2, var_3_3, var_1_10007)

	setSlider = var_2

	var_2(arg_3_0.sliderTF, 0, arg_3_0.maxCount, arg_3_0.curCount)

	setText = var_2

	var_2(arg_3_0.progressText, arg_3_0.curCount .. "/" .. arg_3_0.maxCount)

	onButton = var_2

	local var_3_4 = arg_3_0
	local var_3_5 = arg_3_0.goBtn

	local function var_3_6()
		local var_5_0 = arg_3_0
		local var_5_1 = var_0.emit

		ActivityMediator = var_2_10003

		local var_5_2 = var_2_10003.EVENT_GO_SCENE

		SCENE = var_2_10004

		var_5_1(var_5_0, var_5_2, var_2_10004.TECHNOLOGY)

		return
	end

	SFX_PANEL = var_7

	var_2(var_3_4, var_3_5, var_3_6, var_7)

	return
end

function var_0_1.OnUpdateFlush(arg_6_0)
	local var_6_0 = arg_6_0.curCount
	local var_6_1 = arg_6_0.maxCount <= var_6_0

	setActive = var_2

	var_2(arg_6_0.goBtn, not var_6_1)

	setActive = var_2

	var_2(arg_6_0.finishBtn, var_6_1)

	return
end

function var_0_1.OnDestroy(arg_7_0)
	return
end

return var_0_1
