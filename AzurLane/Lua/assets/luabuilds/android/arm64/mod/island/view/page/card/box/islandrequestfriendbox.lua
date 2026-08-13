class = var_0_10000

local var_0_0 = "IslandRequestFriendBox"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.BaseSubView"))

function var_0_1.getUIName(arg_1_0)
	return "IslandRequestFriendBox"
end

function var_0_1.OnLoaded(arg_2_0)
	setText = var_1_10001

	local var_2_0 = arg_2_0._tf
	local var_2_1 = var_3.Find(var_2_0, "frame/title")

	i18n = var_1_10004

	var_1_10001(var_2_1, var_1_10004("word_apply"))

	setText = var_1_10001

	local var_2_2 = arg_2_0._tf
	local var_2_3 = var_3.Find(var_2_2, "Text")

	i18n = var_4

	var_1_10001(var_2_3, var_4("friend_request_msg_title"))

	local var_2_4 = arg_2_0._tf

	arg_2_0.closeBtn = var_1.Find(var_2_4, "frame/close")

	local var_2_5 = arg_2_0._tf

	arg_2_0.requestBtn = var_1.Find(var_2_5, "request")
	setText = var_1

	local var_2_6 = arg_2_0.requestBtn
	local var_2_7 = var_3.Find(var_2_6, "Text")

	i18n = var_4

	var_1(var_2_7, var_4("word_apply"))

	local var_2_8 = arg_2_0._tf

	arg_2_0.input = var_1.Find(var_2_8, "InputField")
	setText = var_1

	local var_2_9 = arg_2_0.input
	local var_2_10 = var_3.Find(var_2_9, "Placeholder")

	i18n = var_4

	var_1(var_2_10, var_4("friend_request_msg_placeholder"))

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
	local var_3_4 = arg_3_0.requestBtn

	local function var_3_5()
		getInputText = var_2_10000

		local var_5_0 = var_2_10000(arg_3_0.input)

		pg = var_2_10001

		local var_5_1 = var_2_10001.m02
		local var_5_2 = var_1.sendNotification

		GAME = var_2_10004

		var_5_2(var_5_1, var_2_10004.FRIEND_SEND_REQUEST, {
			id = arg_3_0.userId,
			msg = var_5_0
		})

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_3_3, var_3_4, var_3_5, var_1_10006)

	return
end

function var_0_1.Show(arg_6_0, arg_6_1)
	var_0_1.super.Show(arg_6_0)

	arg_6_0.userId = arg_6_1
	setInputText = var_2

	var_2(arg_6_0.input, "")

	pg = var_2

	local var_6_0 = var_2.UIMgr.GetInstance()

	var_2.BlurPanel(var_6_0, arg_6_0._tf)

	return
end

function var_0_1.Hide(arg_7_0)
	var_0_1.super.Hide(arg_7_0)

	pg = var_1

	local var_7_0 = var_1.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_7_0, arg_7_0._tf, arg_7_0._parentTf)

	return
end

function var_0_1.OnDestroy(arg_8_0)
	pg = var_1_10001

	local var_8_0 = var_1_10001.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_8_0, arg_8_0._tf, arg_8_0._parentTf)

	return
end

return var_0_1
