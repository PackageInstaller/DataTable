class = var_0_10000

local var_0_0 = "SandiegoReformPage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("...base.BaseActivityPage"))

function var_0_1.OnInit(arg_1_0)
	local var_1_0 = arg_1_0._tf

	arg_1_0.bg = var_1.Find(var_1_0, "AD")

	local var_1_1 = arg_1_0.bg

	arg_1_0.progress = var_1.Find(var_1_1, "progress/left")

	local var_1_2 = arg_1_0.bg

	arg_1_0.gameBtn = var_1.Find(var_1_2, "start")

	local var_1_3 = arg_1_0.bg

	arg_1_0.helpBtn = var_1.Find(var_1_3, "mic")

	local var_1_4 = arg_1_0.bg

	arg_1_0.getSign = var_1.Find(var_1_4, "get")

	local var_1_5 = arg_1_0.bg

	arg_1_0.days = var_1.Find(var_1_5, "days")

	local var_1_6 = arg_1_0.bg

	arg_1_0.nums = var_1.Find(var_1_6, "count")

	return
end

function var_0_1.OnDataSetting(arg_2_0)
	local var_2_0 = arg_2_0.activity

	if var_1.getConfig(var_2_0, "config_client")[1][1] ~= nil then
		pg = var_1_10002

		local var_2_1 = var_1_10002.NewStoryMgr.GetInstance()

		var_2.Play(var_2_1, var_1)
	end

	return
end

function var_0_1.OnFirstFlush(arg_3_0)
	local var_3_0 = arg_3_0.activity
	local var_3_1 = var_1.getConfig(var_3_0, "config_client")[3]

	setText = var_1_10003

	local var_3_2 = arg_3_0.nums

	_ = var_1_10006

	local var_3_3 = var_1_10006.reduce

	_ = var_1_10008

	var_1_10003(var_3_2, var_3_3(var_1_10008.slice(var_3_1, 1, var_1.data2), 0, function(arg_4_0, arg_4_1)
		return arg_4_0 + arg_4_1
	end))

	setActive = var_1_10003

	var_1_10003(arg_3_0.getSign, var_1.data1 == 1)

	local var_3_4 = var_1
	local var_3_5 = var_1.getConfig(var_3_4, "config_data")[4]
	local var_3_6 = arg_3_0.progress

	Vector2 = var_3_4

	local var_3_7 = var_3_4.New

	math = var_1_10007
	var_3_6.sizeDelta = var_3_7(10 + 90 * var_1_10007.max(var_1.data2 - 1, 0), arg_3_0.progress.sizeDelta.y)
	Color = var_3_6

	local var_3_8 = var_3_6.New(1, 0.83, 0.15)

	Color = var_5

	local var_3_9 = var_5.New(0.59, 0.62, 0.69)

	for iter_3_0 = 1, 7 do
		local var_3_10 = arg_3_0.days
		local var_3_11 = var_10.Find(var_3_10, iter_3_0)

		setTextColor = var_11

		var_11(var_3_11, iter_3_0 <= var_1.data2 and var_3_8 or var_3_9)
	end

	onButton = var_6

	local var_3_12 = arg_3_0
	local var_3_13 = arg_3_0.gameBtn

	local function var_3_14()
		local var_5_0 = arg_3_0
		local var_5_1 = var_0.emit

		ActivityMediator = var_2_10003

		local var_5_2 = var_2_10003.EVENT_GO_SCENE

		SCENE = var_2_10004

		var_5_1(var_5_0, var_5_2, var_2_10004.LINK_LINK)

		return
	end

	SFX_PANEL = var_11

	var_6(var_3_12, var_3_13, var_3_14, var_11)

	onButton = var_6

	local var_3_15 = arg_3_0
	local var_3_16 = arg_3_0.helpBtn

	local function var_3_17()
		pg = var_2_10000

		local var_6_0 = var_2_10000.MsgboxMgr.GetInstance()
		local var_6_1 = var_0.ShowMsgBox
		local var_6_2 = {}

		MSGBOX_TYPE_HELP = var_2_10004
		var_6_2.type = var_2_10004
		i18n = var_2_10004
		var_6_2.helps = var_2_10004("link_link_help_tip")

		var_6_1(var_6_0, var_6_2)

		return
	end

	SFX_PANEL = var_11

	var_6(var_3_15, var_3_16, var_3_17, var_11)

	return
end

function var_0_1.OnUpdateFlush(arg_7_0)
	return
end

function var_0_1.OnDestroy(arg_8_0)
	return
end

return var_0_1
