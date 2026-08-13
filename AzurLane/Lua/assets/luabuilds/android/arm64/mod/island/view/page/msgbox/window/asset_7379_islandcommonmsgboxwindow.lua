class = var_0_10000

local var_0_0 = "IslandCommonMsgboxWindow"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".IslandBaseMsgboxWindow"))

function var_0_1.getUIName(arg_1_0)
	return "IslandCommonMsgBox"
end

function var_0_1.OnLoaded(arg_2_0)
	local var_2_0 = arg_2_0._tf
	local var_2_1 = var_1.Find(var_2_0, "title")
	local var_2_2 = var_1.GetComponent

	typeof = var_4
	Text = var_1_10006
	arg_2_0.titleTxt = var_2_2(var_2_1, var_4(var_1_10006))

	local var_2_3 = arg_2_0._tf
	local var_2_4 = var_1.Find(var_2_3, "content/Text")

	arg_2_0.contentTxt = var_1.GetComponent(var_2_4, "RichText")

	local var_2_5 = arg_2_0._tf

	arg_2_0.closeBtn = var_1.Find(var_2_5, "close")

	local var_2_6 = arg_2_0._tf

	arg_2_0.cancelBtn = var_1.Find(var_2_6, "cancel")

	local var_2_7 = arg_2_0._tf

	arg_2_0.confirmBtn = var_1.Find(var_2_7, "confirm")

	local var_2_8 = arg_2_0._tf
	local var_2_9 = var_1.Find(var_2_8, "cancel/Text")
	local var_2_10 = var_1.GetComponent

	typeof = var_4
	Text = var_1_10006
	arg_2_0.cancelTxt = var_2_10(var_2_9, var_4(var_1_10006))

	local var_2_11 = arg_2_0._tf
	local var_2_12 = var_1.Find(var_2_11, "confirm/Text")
	local var_2_13 = var_1.GetComponent

	typeof = var_4
	Text = var_1_10006
	arg_2_0.confirmTxt = var_2_13(var_2_12, var_4(var_1_10006))

	return
end

function var_0_1.OnInit(arg_3_0)
	onButton = var_1_10001

	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0.cancelBtn

	local function var_3_2()
		local var_4_0 = arg_3_0.onNo
		local var_4_1 = arg_3_0

		var_1.Hide(var_4_1)

		existCall = var_1

		var_1(var_4_0)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_3_0, var_3_1, var_3_2, var_1_10006)

	onButton = var_1_10001

	local var_3_3 = arg_3_0
	local var_3_4 = arg_3_0.closeBtn

	local function var_3_5()
		local var_5_0 = arg_3_0

		var_0.Hide(var_5_0)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_3_3, var_3_4, var_3_5, var_1_10006)

	onButton = var_1_10001

	local var_3_6 = arg_3_0
	local var_3_7 = arg_3_0.confirmBtn

	local function var_3_8()
		local var_6_0 = arg_3_0.onYes
		local var_6_1 = arg_3_0

		var_1.Hide(var_6_1)

		existCall = var_1

		var_1(var_6_0)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_3_6, var_3_7, var_3_8, var_1_10006)

	return
end

function var_0_1.OnShow(arg_7_0)
	if arg_7_0.settings.rawIconDic then
		pairs = var_2

		for iter_7_0, iter_7_1 in var_2(var_1.rawIconDic) do
			local var_7_0 = arg_7_0.contentTxt

			var_7.AddSprite(var_7_0, iter_7_0, iter_7_1)
		end
	end

	local var_7_1 = arg_7_0.titleTxt
	local var_7_2

	if not var_1.title then
		i18n = var_7_2
		var_7_2 = var_7_2("island_msg_info")
	end

	var_7_1.text = var_7_2

	local var_7_3 = arg_7_0.contentTxt
	local var_7_4

	if not var_1.content then
		var_7_4 = ""
	end

	var_7_3.text = var_7_4
	arg_7_0.onYes = var_1.onYes
	arg_7_0.onNo = var_1.onNo
	arg_7_0.onHide = var_1.onHide

	arg_7_0:FlushBtn(var_1)

	return
end

function var_0_1.FlushBtn(arg_8_0, arg_8_1)
	setActive = var_1_10002

	var_1_10002(arg_8_0.cancelBtn, not arg_8_1.hideNo)

	local var_8_0 = arg_8_1.hideNo and 880 or 420
	local var_8_1 = arg_8_0.confirmBtn

	Vector2 = var_4
	var_8_1.sizeDelta = var_4(var_8_0, arg_8_0.confirmBtn.sizeDelta.y)

	local var_8_2 = arg_8_0.cancelTxt
	local var_8_3

	if not arg_8_1.noText or not arg_8_1.noText then
		i18n = var_8_3
		var_8_3 = var_8_3("word_cancel")
	end

	var_8_2.text = var_8_3

	local var_8_4 = arg_8_0.confirmTxt
	local var_8_5

	if not arg_8_1.yesText or not arg_8_1.yesText then
		i18n = var_8_5
		var_8_5 = var_8_5("word_ok")
	end

	var_8_4.text = var_8_5

	return
end

function var_0_1.OnHide(arg_9_0)
	arg_9_0.onYes = nil
	arg_9_0.onNo = nil

	if arg_9_0.onHide then
		arg_9_0.onHide()

		arg_9_0.onHide = nil
	end

	return
end

function var_0_1.GetMsgBoxMgr(arg_10_0)
	return arg_10_0.view
end

function var_0_1.OnDestroy(arg_11_0)
	return
end

return var_0_1
