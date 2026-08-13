class = var_0_10000

local var_0_0 = "MailTipsLayer"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.BaseUI"))

function var_0_1.getUIName(arg_1_0)
	return "MailTipLayersMsgBoxUI"
end

function var_0_1.init(arg_2_0)
	local var_2_0 = arg_2_0._tf

	arg_2_0.btnBack = var_1.Find(var_2_0, "adapt/window/top/btnBack")

	local var_2_1 = arg_2_0._tf

	arg_2_0.goBtn = var_1.Find(var_2_1, "adapt/window/button_container/btn_ok")

	local var_2_2 = arg_2_0._tf

	arg_2_0.title = var_1.Find(var_2_2, "adapt/window/top/bg/infomation/title")

	local var_2_3 = arg_2_0._tf

	arg_2_0.bgBack = var_1.Find(var_2_3, "bg")

	local var_2_4 = arg_2_0._tf
	local var_2_5 = var_1.Find(var_2_4, "adapt/window/msg_panel/content")

	arg_2_0.context = var_1.GetComponent(var_2_5, "RichText")

	return
end

function var_0_1.didEnter(arg_3_0)
	pg = var_1_10001

	local var_3_0 = var_1_10001.UIMgr.GetInstance()

	var_1.BlurPanel(var_3_0, arg_3_0._tf)

	onButton = var_1

	local var_3_1 = arg_3_0
	local var_3_2 = arg_3_0.btnBack

	local function var_3_3()
		local var_4_0 = arg_3_0

		var_0.closeView(var_4_0)

		return
	end

	SFX_CANCEL = var_1_10006

	var_1(var_3_1, var_3_2, var_3_3, var_1_10006)

	onButton = var_1

	local var_3_4 = arg_3_0
	local var_3_5 = arg_3_0.bgBack

	local function var_3_6()
		local var_5_0 = arg_3_0

		var_0.closeView(var_5_0)

		return
	end

	SFX_CANCEL = var_1_10006

	var_1(var_3_4, var_3_5, var_3_6, var_1_10006)

	onButton = var_1

	local var_3_7 = arg_3_0
	local var_3_8 = arg_3_0.goBtn

	local function var_3_9()
		arg_3_0.contextData.onYes()

		local var_6_0 = arg_3_0

		var_0.closeView(var_6_0)

		return
	end

	SFX_CANCEL = var_1_10006

	var_1(var_3_7, var_3_8, var_3_9, var_1_10006)

	local var_3_10 = arg_3_0.context

	var_3_10.text = arg_3_0.contextData.content
	setText = var_3_10

	local var_3_11 = arg_3_0.title

	i18n = var_3_8

	var_3_10(var_3_11, var_3_8("mail_boxtitle_information"))

	setText = var_3_10

	local var_3_12 = arg_3_0.goBtn
	local var_3_13 = var_3.Find(var_3_12, "Text")

	i18n = var_4

	var_3_10(var_3_13, var_4("mail_box_confirm"))

	pg = var_3_10

	local var_3_14 = var_3_10.NewStoryMgr.GetInstance()

	if not var_1.IsPlayed(var_3_14, "NEW_MAIL_GUIDE") then
		pg = var_1

		local var_3_15 = var_1.NewGuideMgr.GetInstance()

		var_1.Play(var_3_15, "NEW_MAIL_GUIDE")

		pg = var_1

		local var_3_16 = var_1.m02
		local var_3_17 = var_1.sendNotification

		GAME = var_4

		var_3_17(var_3_16, var_4.STORY_UPDATE, {
			storyId = "NEW_MAIL_GUIDE"
		})
	end

	return
end

function var_0_1.willExit(arg_7_0)
	pg = var_1_10001

	local var_7_0 = var_1_10001.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_7_0, arg_7_0._tf)

	return
end

return var_0_1
