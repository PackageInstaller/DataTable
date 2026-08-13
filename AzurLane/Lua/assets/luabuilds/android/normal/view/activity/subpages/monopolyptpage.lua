class = var_0_10000

local var_0_0 = "MonopolyPtPage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("...base.BaseActivityPage"))

function var_0_1.OnInit(arg_1_0)
	onToggle = var_1_10001

	local var_1_0 = arg_1_0

	findTF = var_1_10003

	local var_1_1 = var_1_10003(arg_1_0._tf, "AD/toggle/1")

	local function var_1_2()
		local var_2_0 = arg_1_0

		var_0.changeToggle(var_2_0, 1)

		return
	end

	SFX_CONFIRM = var_5

	var_1_10001(var_1_0, var_1_1, var_1_2, var_5)

	onToggle = var_1_10001

	local var_1_3 = arg_1_0

	findTF = var_1_1

	local var_1_4 = var_1_1(arg_1_0._tf, "AD/toggle/2")

	local function var_1_5()
		local var_3_0 = arg_1_0

		var_0.changeToggle(var_3_0, 2)

		return
	end

	SFX_CONFIRM = var_5

	var_1_10001(var_1_3, var_1_4, var_1_5, var_5)

	onToggle = var_1_10001

	local var_1_6 = arg_1_0

	findTF = var_1_4

	local var_1_7 = var_1_4(arg_1_0._tf, "AD/toggle/3")

	local function var_1_8()
		local var_4_0 = arg_1_0

		var_0.changeToggle(var_4_0, 3)

		return
	end

	SFX_CONFIRM = var_5

	var_1_10001(var_1_6, var_1_7, var_1_8, var_5)

	triggerToggle = var_1_10001
	findTF = var_1_6

	var_1_10001(var_1_6(arg_1_0._tf, "AD/toggle/1"), true)

	onButton = var_1_10001

	local var_1_9 = arg_1_0

	findTF = var_3

	local var_1_10 = var_3(arg_1_0._tf, "AD/btnShop")

	local function var_1_11()
		local var_5_0 = arg_1_0
		local var_5_1 = var_0.emit

		ActivityMediator = var_2_10002

		local var_5_2 = var_2_10002.EVENT_GO_SCENE

		SCENE = var_2_10003

		var_5_1(var_5_0, var_5_2, var_2_10003.SHOP)

		return
	end

	SFX_CONFIRM = var_5

	var_1_10001(var_1_9, var_1_10, var_1_11, var_5)

	onButton = var_1_10001

	local var_1_12 = arg_1_0

	findTF = var_1_10

	local var_1_13 = var_1_10(arg_1_0._tf, "AD/btnGo")

	local function var_1_14()
		local var_6_0 = arg_1_0
		local var_6_1 = var_0.emit

		ActivityMediator = var_2_10002

		local var_6_2 = var_2_10002.EVENT_GO_SCENE

		SCENE = var_2_10003

		var_6_1(var_6_0, var_6_2, var_2_10003.MONOPOLY_PT, {
			config_id = arg_1_0.activity.id
		})

		return
	end

	SFX_CONFIRM = var_5

	var_1_10001(var_1_12, var_1_13, var_1_14, var_5)

	return
end

function var_0_1.changeToggle(arg_7_0, arg_7_1)
	for iter_7_0 = 1, 3 do
		setActive = var_1_10006
		findTF = var_1_10007

		var_1_10006(var_1_10007(arg_7_0._tf, "AD/toggle/" .. iter_7_0 .. "/on/desc"), iter_7_0 == arg_7_1)
	end

	return
end

function var_0_1.OnFirstFlush(arg_8_0)
	if arg_8_0.ptData then
		local var_8_0 = arg_8_0.ptData

		var_1.Update(var_8_0, arg_8_0.activity)
	else
		ActivityPtData = var_1
		arg_8_0.ptData = var_1.New(arg_8_0.activity)
	end

	return
end

function var_0_1.OnUpdateFlush(arg_9_0)
	if arg_9_0.ptData then
		local var_9_0 = arg_9_0.ptData

		var_1.Update(var_9_0, arg_9_0.activity)
	else
		ActivityPtData = var_1
		arg_9_0.ptData = var_1.New(arg_9_0.activity)
	end

	local var_9_1 = arg_9_0.ptData
	local var_9_2, var_9_3, var_9_4 = var_1.GetLevelProgress(var_9_1)
	local var_9_5 = arg_9_0.ptData
	local var_9_6, var_9_7, var_9_8 = var_4.GetResProgress(var_9_5)
	local var_9_9 = arg_9_0.ptData
	local var_9_10 = 20 - var_7.GetLevel(var_9_9)

	math = var_1_10009

	local var_9_11

	if var_9_10 < var_1_10009.floor(var_9_6 / 500) - var_7 then
		var_9_11 = var_9_10
	end

	if var_9_10 == 0 then
		setActive = var_10
		findTF = var_1_10011

		var_10(var_1_10011(arg_9_0._tf, "AD/clear"), true)
	else
		setActive = var_10
		findTF = var_1_10011

		var_10(var_1_10011(arg_9_0._tf, "AD/clear"), false)
	end

	setActive = var_10
	findTF = var_1_10011

	var_10(var_1_10011(arg_9_0._tf, "AD/count"), var_9_11 > 0)

	setText = var_10
	findTF = var_11

	var_10(var_11(arg_9_0._tf, "AD/count/txt"), var_9_11)

	return
end

return var_0_1
