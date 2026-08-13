class = var_0_10000

local var_0_0 = "BackYardThemeTemplateMsgBox"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("....base.BaseSubView"))

var_0_1.TYPE_TEXT = 1
var_0_1.TYPE_IMAGE = 2

function var_0_1.getUIName(arg_1_0)
	return "BackYardThemeTemplateMsgBox"
end

function var_0_1.OnLoaded(arg_2_0)
	local var_2_0 = arg_2_0._tf

	arg_2_0.frame = var_1.Find(var_2_0, "window1")

	local var_2_1 = arg_2_0._tf
	local var_2_2 = var_1.Find(var_2_1, "window1/content")
	local var_2_3 = var_1.GetComponent

	typeof = var_4
	Text = var_1_10006
	arg_2_0.content = var_2_3(var_2_2, var_4(var_1_10006))

	local var_2_4 = arg_2_0._tf

	arg_2_0.frame1 = var_1.Find(var_2_4, "window2")

	local var_2_5 = arg_2_0._tf
	local var_2_6 = var_1.Find(var_2_5, "window2/content")
	local var_2_7 = var_1.GetComponent

	typeof = var_4
	Text = var_1_10006
	arg_2_0.content1 = var_2_7(var_2_6, var_4(var_1_10006))

	local var_2_8 = arg_2_0._tf
	local var_2_9 = var_1.Find(var_2_8, "window2/mask/Icon")
	local var_2_10 = var_1.GetComponent

	typeof = var_4
	RawImage = var_1_10006
	arg_2_0.icon = var_2_10(var_2_9, var_4(var_1_10006))

	local var_2_11 = arg_2_0._tf

	arg_2_0.cancelBtn = var_1.Find(var_2_11, "btns/cancel")

	local var_2_12 = arg_2_0._tf
	local var_2_13 = var_1.Find(var_2_12, "btns/cancel/Text")
	local var_2_14 = var_1.GetComponent

	typeof = var_4
	Text = var_1_10006
	arg_2_0.cancelBtnTxt = var_2_14(var_2_13, var_4(var_1_10006))

	local var_2_15 = arg_2_0._tf

	arg_2_0.confirmBtn = var_1.Find(var_2_15, "btns/confirm")

	local var_2_16 = arg_2_0._tf
	local var_2_17 = var_1.Find(var_2_16, "btns/confirm/Text")
	local var_2_18 = var_1.GetComponent

	typeof = var_4
	Text = var_1_10006
	arg_2_0.confirmBtnTxt = var_2_18(var_2_17, var_4(var_1_10006))
	arg_2_0._parentTF = arg_2_0._tf.parent
	setText = var_1

	local var_2_19 = arg_2_0._tf
	local var_2_20 = var_3.Find(var_2_19, "title")

	i18n = var_4

	var_1(var_2_20, var_4("words_information"))

	return
end

function var_0_1.OnInit(arg_3_0)
	onButton = var_1_10001

	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0._tf

	local function var_3_2()
		local var_4_0 = arg_3_0

		var_0.Hide(var_4_0)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_3_0, var_3_1, var_3_2, var_1_10006)

	onButton = var_1_10001

	local var_3_3 = arg_3_0
	local var_3_4 = arg_3_0.cancelBtn

	local function var_3_5()
		local var_5_0 = arg_3_0

		var_0.Hide(var_5_0)

		if arg_3_0.onCancel then
			arg_3_0.onCancel()
		end

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_3_3, var_3_4, var_3_5, var_1_10006)

	onButton = var_1_10001

	local var_3_6 = arg_3_0
	local var_3_7 = arg_3_0.confirmBtn

	local function var_3_8()
		local var_6_0 = arg_3_0

		var_0.Hide(var_6_0)

		if arg_3_0.onYes then
			arg_3_0.onYes()
		end

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_3_6, var_3_7, var_3_8, var_1_10006)

	return
end

function var_0_1.SetUp(arg_7_0, arg_7_1)
	arg_7_0.onYes = arg_7_1.onYes
	arg_7_0.onCancel = arg_7_1.onCancel

	local var_7_0 = arg_7_0.cancelBtnTxt
	local var_7_1

	if not arg_7_1.cancelTxt then
		i18n = var_7_1
		var_7_1 = var_7_1("word_cancel")
	end

	var_7_0.text = var_7_1

	local var_7_2 = arg_7_0.confirmBtnTxt
	local var_7_3

	if not arg_7_1.confirmTxt then
		i18n = var_7_3
		var_7_3 = var_7_3("word_ok")
	end

	var_7_2.text = var_7_3

	local var_7_4

	if not arg_7_1.type then
		var_7_4 = var_0_1.TYPE_TEXT
	end

	local var_7_5

	if var_7_4 == var_0_1.TYPE_TEXT then
		var_7_5 = arg_7_0.content
		var_7_5.text = arg_7_1.content
	elseif var_7_4 == var_0_1.TYPE_IMAGE then
		var_7_5 = arg_7_0.content1
		var_7_5.text = arg_7_1.content
		BackYardThemeTempalteUtil = var_7_5

		var_7_5.GetNonCacheTexture(arg_7_1.srpiteName, arg_7_1.md5, function(arg_8_0)
			IsNil = var_2_10001

			if not var_2_10001(arg_7_0.icon) and arg_8_0 then
				arg_7_0.icon.texture = arg_8_0
			end

			return
		end)
	end

	setActive = var_7_5

	var_7_5(arg_7_0.frame, var_7_4 == var_0_1.TYPE_TEXT)

	setActive = var_7_5

	var_7_5(arg_7_0.frame1, var_7_4 == var_0_1.TYPE_IMAGE)

	setActive = var_7_5

	var_7_5(arg_7_0.cancelBtn, not arg_7_1.hideNo)
	arg_7_0:Show()

	return
end

function var_0_1.Show(arg_9_0)
	var_0_1.super.Show(arg_9_0)

	SetParent = var_1

	local var_9_0 = arg_9_0._tf

	pg = var_1_10004

	var_1(var_9_0, var_1_10004.UIMgr.GetInstance().OverlayMain)

	return
end

function var_0_1.Hide(arg_10_0)
	IsNil = var_1_10001

	if not var_1_10001(arg_10_0.icon.texture) then
		Object = var_1

		var_1.Destroy(arg_10_0.icon.texture)

		arg_10_0.icon.texture = nil
	end

	var_0_1.super.Hide(arg_10_0)

	SetParent = var_1

	var_1(arg_10_0._tf, arg_10_0._parentTF)

	return
end

function var_0_1.OnDestroy(arg_11_0)
	arg_11_0:Hide()

	return
end

return var_0_1
