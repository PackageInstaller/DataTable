class = var_0_10000

local var_0_0 = "SettingsMsgBosPage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("..base.BaseSubView"))

var_0_1.ALIGN_CENTER = 0
var_0_1.ALIGN_LEFT = 1

function var_0_1.getUIName(arg_1_0)
	return "SetttingMsgbox"
end

function var_0_1.OnLoaded(arg_2_0)
	local var_2_0 = arg_2_0._tf

	arg_2_0.closeBtn = var_1.Find(var_2_0, "window/top/btnBack")

	local var_2_1 = arg_2_0._tf

	arg_2_0.textTr = var_1.Find(var_2_1, "window/view/content/Text")

	local var_2_2 = arg_2_0.textTr
	local var_2_3 = var_1.GetComponent

	typeof = var_4
	Text = var_1_10006
	arg_2_0.text = var_2_3(var_2_2, var_4(var_1_10006))

	local var_2_4 = arg_2_0._tf

	arg_2_0.scrollrect = var_1.Find(var_2_4, "window/view/content")

	return
end

function var_0_1.OnInit(arg_3_0)
	onButton = var_1_10001

	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0.closeBtn

	local function var_3_2()
		local var_4_0 = arg_3_0

		var_0.Hide(var_4_0)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_3_0, var_3_1, var_3_2, var_1_10006)

	onButton = var_1_10001

	local var_3_3 = arg_3_0
	local var_3_4 = arg_3_0._tf

	local function var_3_5()
		local var_5_0 = arg_3_0

		var_0.Hide(var_5_0)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_3_3, var_3_4, var_3_5, var_1_10006)

	return
end

function var_0_1.Show(arg_6_0, arg_6_1, arg_6_2)
	pg = var_1_10003

	local var_6_0 = var_1_10003.UIMgr.GetInstance()

	var_3.BlurPanel(var_6_0, arg_6_0._tf)
	var_0_1.super.Show(arg_6_0)

	arg_6_0.text.text = arg_6_1

	arg_6_0:UpdateLayout(arg_6_2 or var_0_1.ALIGN_CENTER)

	local var_6_1 = arg_6_0.scrollrect
	local var_6_2 = var_3.GetComponent

	typeof = var_6
	ScrollRect = var_1_10008
	var_6_2(var_6_1, var_6(var_1_10008)).verticalNormalizedPosition = 1

	local var_6_3 = arg_6_0._tf

	var_3.SetAsLastSibling(var_6_3)

	return
end

function var_0_1.UpdateLayout(arg_7_0, arg_7_1)
	Vector2 = var_1_10002

	local var_7_0 = var_1_10002(0.5, 0.5)

	TextAnchor = var_1_10003

	local var_7_1 = var_1_10003.MiddleCenter

	if arg_7_1 == var_0_1.ALIGN_LEFT then
		Vector2 = var_4
		var_7_0 = var_4(0, 1)
		TextAnchor = var_4
		var_7_1 = var_4.UpperLeft
	end

	arg_7_0.textTr.pivot = var_7_0
	arg_7_0.text.alignment = var_7_1

	local var_7_2 = arg_7_0.textTr
	local var_7_3 = var_4.GetComponent

	typeof = var_1_10007
	LayoutElement = var_1_10009

	local var_7_4 = var_7_3(var_7_2, var_1_10007(var_1_10009)).preferredWidth

	setAnchoredPosition = var_5

	var_5(arg_7_0.textTr, {
		x = var_7_4 * (var_7_0.x - 0.5)
	})

	return
end

function var_0_1.Hide(arg_8_0)
	pg = var_1_10001

	local var_8_0 = var_1_10001.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_8_0, arg_8_0._tf, arg_8_0._parentTf)
	var_0_1.super.Hide(arg_8_0)

	arg_8_0.text.text = ""

	return
end

function var_0_1.OnDestroy(arg_9_0)
	arg_9_0:Hide()

	return
end

return var_0_1
