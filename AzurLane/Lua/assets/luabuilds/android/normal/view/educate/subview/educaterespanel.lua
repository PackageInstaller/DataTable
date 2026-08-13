class = var_0_10000

local var_0_0 = "EducateResPanel"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("...base.BaseSubView"))

function var_0_1.getUIName(arg_1_0)
	return "EducateResPanel"
end

function var_0_1.OnInit(arg_2_0)
	findTF = var_1_10001
	arg_2_0.moneyBtn = var_1_10001(arg_2_0._go, "res/money")
	findTF = var_1

	local var_2_0 = var_1(arg_2_0._go, "res/money/value")
	local var_2_1 = var_1.GetComponent

	typeof = var_3
	Text = var_1_10004
	arg_2_0.moneyValue = var_2_1(var_2_0, var_3(var_1_10004))
	findTF = var_1
	arg_2_0.moodBtn = var_1(arg_2_0._go, "res/mood")
	findTF = var_1

	local var_2_2 = var_1(arg_2_0._go, "res/mood/value")
	local var_2_3 = var_1.GetComponent

	typeof = var_3
	Text = var_1_10004
	arg_2_0.moodValue = var_2_3(var_2_2, var_3(var_1_10004))
	pg = var_1

	local var_2_4 = var_1.child_resource

	EducateChar = var_2_2
	arg_2_0.moodMaxValue = var_2_4[var_2_2.RES_MOOD_ID].max_value
	findTF = var_1
	arg_2_0.siteBtn = var_1(arg_2_0._go, "res/site")
	findTF = var_1

	local var_2_5 = var_1(arg_2_0._go, "res/site/value")
	local var_2_6 = var_1.GetComponent

	typeof = var_3
	Text = var_1_10004
	arg_2_0.siteValue = var_2_6(var_2_5, var_3(var_1_10004))
	pg = var_1

	local var_2_7 = var_1.child_resource

	EducateChar = var_2_5
	arg_2_0.siteMaxValue = var_2_7[var_2_5.RES_SITE_ID].max_value
	findTF = var_1

	local var_2_8 = var_1(arg_2_0._go, "res")
	local var_2_9 = var_1.GetComponent

	typeof = var_3
	Image = var_1_10004

	local var_2_10 = var_2_9(var_2_8, var_3(var_1_10004))

	findTF = var_2_8

	local var_2_11 = var_2_8(arg_2_0._go, "res")

	if arg_2_0.contextData and arg_2_0.contextData.showBg then
		var_2_10.enabled = true

		local var_2_12 = arg_2_0
		local var_2_13 = arg_2_0.OverlayPanel
		local var_2_14 = arg_2_0._tf
		local var_2_15 = {}
		local var_2_16 = {}

		findTF = var_1_10008
		var_2_16[1] = var_1_10008(arg_2_0._go, "res")
		var_2_15.pbList = var_2_16

		var_2_13(var_2_12, var_2_14, var_2_15)
	else
		var_2_10.enabled = false
	end

	arg_2_0:addListener()
	arg_2_0:Flush()

	return
end

function var_0_1.addListener(arg_3_0)
	onButton = var_1_10001

	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0.moneyBtn

	local function var_3_2()
		local var_4_0 = arg_3_0
		local var_4_1 = var_0.ShowResBox

		EducateChar = var_2_10002

		var_4_1(var_4_0, var_2_10002.RES_MONEY_ID)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_3_0, var_3_1, var_3_2, var_1_10005)

	onButton = var_1_10001

	local var_3_3 = arg_3_0
	local var_3_4 = arg_3_0.moodBtn

	local function var_3_5()
		local var_5_0 = arg_3_0
		local var_5_1 = var_0.ShowResBox

		EducateChar = var_2_10002

		var_5_1(var_5_0, var_2_10002.RES_MOOD_ID)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_3_3, var_3_4, var_3_5, var_1_10005)

	onButton = var_1_10001

	local var_3_6 = arg_3_0
	local var_3_7 = arg_3_0.siteBtn

	local function var_3_8()
		local var_6_0 = arg_3_0
		local var_6_1 = var_0.ShowResBox

		EducateChar = var_2_10002

		var_6_1(var_6_0, var_2_10002.RES_SITE_ID)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_3_6, var_3_7, var_3_8, var_1_10005)

	return
end

function var_0_1.ShowResBox(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_0
	local var_7_1 = arg_7_0.emit

	EducateBaseUI = var_1_10004

	local var_7_2 = var_1_10004.EDUCATE_ON_ITEM
	local var_7_3 = {}
	local var_7_4 = {
		number = 1
	}

	EducateConst = var_1_10007
	var_7_4.type = var_1_10007.DROP_TYPE_RES
	var_7_4.id = arg_7_1
	var_7_3.drop = var_7_4

	var_7_1(var_7_0, var_7_2, var_7_3)

	return
end

function var_0_1.Flush(arg_8_0)
	local var_8_0 = arg_8_0

	if not arg_8_0.GetLoaded(var_8_0) then
		return
	end

	getProxy = var_1
	EducateProxy = var_8_0

	local var_8_1 = var_1(var_8_0)

	arg_8_0.char = var_1.GetCharData(var_8_1)

	local var_8_2 = arg_8_0.char

	arg_8_0.siteMaxValue = var_1.GetSiteCnt(var_8_2)
	arg_8_0.moneyValue.text = arg_8_0.char.money
	arg_8_0.moodValue.text = arg_8_0.char.mood .. "/" .. arg_8_0.moodMaxValue
	arg_8_0.siteValue.text = arg_8_0.char.site .. "/" .. arg_8_0.siteMaxValue

	return
end

function var_0_1.FlushAddValue(arg_9_0, arg_9_1, arg_9_2)
	if not arg_9_0:GetLoaded() then
		return
	end

	arg_9_0.moodValue.text = arg_9_0.char.mood .. arg_9_1
	arg_9_0.moneyValue.text = arg_9_0.char.money .. arg_9_2

	return
end

function var_0_1.OnDestroy(arg_10_0)
	if arg_10_0.contextData and arg_10_0.contextData.showBg then
		arg_10_0:UnOverlayPanel(arg_10_0._tf)
	end

	return
end

return var_0_1
