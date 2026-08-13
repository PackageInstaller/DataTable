class = var_0_10000

local var_0_0 = "ChargeJPUserAgreeLayer"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("...base.BaseUI"))

function var_0_1.getUIName(arg_1_0)
	return "ChargeJPUserAgreeUI"
end

function var_0_1.init(arg_2_0)
	arg_2_0:initData()
	arg_2_0:findUI()
	arg_2_0:addListener()
	arg_2_0:initUIText()

	return
end

function var_0_1.didEnter(arg_3_0)
	pg = var_1_10001

	local var_3_0 = var_1_10001.UIMgr.GetInstance()

	var_1.BlurPanel(var_3_0, arg_3_0._tf)

	setText = var_1

	local var_3_1 = arg_3_0.scrollText
	local var_3_2

	if not arg_3_0.contentStr then
		var_3_2 = ""
	end

	var_1(var_3_1, var_3_2)

	scrollTo = var_1

	var_1(arg_3_0.scrollRect, 0, 1)

	return
end

function var_0_1.willExit(arg_4_0)
	pg = var_1_10001

	local var_4_0 = var_1_10001.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_4_0, arg_4_0._tf)

	return
end

function var_0_1.initData(arg_5_0)
	local var_5_0

	if arg_5_0.contextData.contentStr then
		var_5_0 = arg_5_0.contextData.contentStr.content
	end

	arg_5_0.contentStr = var_5_0

	return
end

function var_0_1.initUIText(arg_6_0)
	return
end

function var_0_1.findUI(arg_7_0)
	local var_7_0 = arg_7_0._tf

	arg_7_0.bg = var_1.Find(var_7_0, "bg")

	local var_7_1 = arg_7_0._tf

	arg_7_0.closeBtn = var_1.Find(var_7_1, "window/top/btnBack")

	local var_7_2 = arg_7_0._tf

	arg_7_0.scrollRect = var_1.Find(var_7_2, "container/scrollrect")

	local var_7_3 = arg_7_0.scrollRect

	arg_7_0.scrollText = var_1.Find(var_7_3, "content/Text")

	return
end

function var_0_1.addListener(arg_8_0)
	onButton = var_1_10001

	local var_8_0 = arg_8_0
	local var_8_1 = arg_8_0.bg

	local function var_8_2()
		local var_9_0 = arg_8_0

		var_0.closeView(var_9_0)

		return
	end

	SFX_CANCEL = var_1_10006

	var_1_10001(var_8_0, var_8_1, var_8_2, var_1_10006)

	onButton = var_1_10001

	local var_8_3 = arg_8_0
	local var_8_4 = arg_8_0.closeBtn

	local function var_8_5()
		local var_10_0 = arg_8_0

		var_0.closeView(var_10_0)

		return
	end

	SFX_CANCEL = var_1_10006

	var_1_10001(var_8_3, var_8_4, var_8_5, var_1_10006)

	return
end

return var_0_1
