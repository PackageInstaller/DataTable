class = var_0_10000

local var_0_0 = "ActivityPermanentLayer"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("..base.BaseUI"))

function var_0_1.getUIName(arg_1_0)
	return "ActivitySelectUI"
end

function var_0_1.onBackPressed(arg_2_0)
	arg_2_0:closeView()

	return
end

function var_0_1.onBackPressed(arg_3_0)
	isActive = var_1_10001

	if var_1_10001(arg_3_0.rtMsgbox) then
		arg_3_0:hideMsgbox()
	else
		var_0_1.super.onBackPressed(arg_3_0)
	end

	return
end

function var_0_1.init(arg_4_0)
	local var_4_0 = arg_4_0._tf

	arg_4_0.bg = var_1.Find(var_4_0, "bg_back")
	onButton = var_1

	local var_4_1 = arg_4_0
	local var_4_2 = arg_4_0.bg

	local function var_4_3()
		local var_5_0 = arg_4_0

		var_0.closeView(var_5_0)

		return
	end

	SFX_CANCEL = var_1_10006

	var_1(var_4_1, var_4_2, var_4_3, var_1_10006)

	local var_4_4 = arg_4_0._tf

	arg_4_0.btnBack = var_1.Find(var_4_4, "window/inner/top/back")
	onButton = var_1

	local var_4_5 = arg_4_0
	local var_4_6 = arg_4_0.btnBack

	local function var_4_7()
		local var_6_0 = arg_4_0

		var_0.closeView(var_6_0)

		return
	end

	SFX_CANCEL = var_1_10006

	var_1(var_4_5, var_4_6, var_4_7, var_1_10006)

	setText = var_1

	local var_4_8 = arg_4_0._tf
	local var_4_9 = var_3.Find(var_4_8, "window/inner/top/back/Text")

	i18n = var_4_6

	var_1(var_4_9, var_4_6("activity_permanent_total"))

	local var_4_10 = arg_4_0._tf

	arg_4_0.btnHelp = var_1.Find(var_4_10, "window/inner/top/help")
	onButton = var_1

	local var_4_11 = arg_4_0
	local var_4_12 = arg_4_0.btnHelp

	local function var_4_13()
		pg = var_2_10000

		local var_7_0 = var_2_10000.MsgboxMgr.GetInstance()
		local var_7_1 = var_0.ShowMsgBox
		local var_7_2 = {}

		MSGBOX_TYPE_HELP = var_2_10004
		var_7_2.type = var_2_10004
		i18n = var_2_10004
		var_7_2.helps = var_2_10004("activity_permanent_help")

		var_7_1(var_7_0, var_7_2)

		return
	end

	SFX_PANEL = var_6

	var_1(var_4_11, var_4_12, var_4_13, var_6)

	local var_4_14 = arg_4_0._tf

	arg_4_0.content = var_1.Find(var_4_14, "window/inner/content/scroll_rect")
	UIItemList = var_1

	local var_4_15 = var_1.New
	local var_4_16 = arg_4_0.content
	local var_4_17 = arg_4_0.content

	arg_4_0.itemList = var_4_15(var_4_16, var_4.Find(var_4_17, "item"))
	getProxy = var_1
	ActivityPermanentProxy = var_4_16

	local var_4_18 = var_1(var_4_16)
	local var_4_19 = arg_4_0.itemList

	var_2.make(var_4_19, function(arg_8_0, arg_8_1, arg_8_2)
		arg_8_1 = arg_8_1 + 1
		UIItemList = var_2_10003

		if arg_8_0 == var_2_10003.EventUpdate then
			local var_8_0 = arg_4_0.ids[arg_8_1]

			pg = var_2_10004

			local var_8_1 = var_2_10004.activity_task_permanent[var_8_0]

			setText = var_2_10005

			var_2_10005(arg_8_2:Find("main/word/Text"), var_8_1.gametip)

			setText = var_2_10005

			var_2_10005(arg_8_2:Find("main/Image/tip/Text"), var_8_1.gametip_extra)

			GetImageSpriteFromAtlasAsync = var_2_10005

			var_2_10005("activitybanner/" .. var_8_1.banner_route, "", arg_8_2:Find("main/Image"))

			onButton = var_2_10005

			local var_8_2 = arg_4_0
			local var_8_3 = arg_8_2
			local var_8_4 = arg_8_2.Find(var_8_3, "main")

			local function var_8_5()
				local var_9_0 = arg_4_0

				var_0.showMsgbox(var_9_0, var_8_0)

				return
			end

			SFX_PANEL = var_8_3

			var_2_10005(var_8_2, var_8_4, var_8_5, var_8_3)

			local var_8_6 = arg_8_2:Find("finish")

			GetOrAddComponent = var_2_10006

			local var_8_7 = var_8_6

			typeof = var_8_5
			CanvasGroup = var_11

			local var_8_8 = var_2_10006(var_8_7, var_8_5(var_11))
			local var_8_9

			if var_8_0 == arg_4_0.contextData.finishId then
				var_8_9 = arg_4_0
				var_8_9.childFinish = arg_8_2
				var_8_8.alpha = 0
			else
				var_8_8.alpha = 1
			end

			setText = var_8_9

			local var_8_10 = var_8_6:Find("Image/Text")

			i18n = var_8_3

			var_8_9(var_8_10, var_8_3("activity_permanent_finished"))

			setActive = var_8_9

			local var_8_11 = var_8_6
			local var_8_12 = var_4_18

			var_8_9(var_8_11, var_10.isActivityFinish(var_8_12, var_8_0))
		end

		return
	end)

	local var_4_20 = arg_4_0._tf

	arg_4_0.rtMsgbox = var_2.Find(var_4_20, "Msgbox")
	onButton = var_2

	local var_4_21 = arg_4_0
	local var_4_22 = arg_4_0.rtMsgbox
	local var_4_23 = var_5.Find(var_4_22, "bg")

	local function var_4_24()
		local var_10_0 = arg_4_0

		var_0.hideMsgbox(var_10_0)

		return
	end

	SFX_CANCEL = var_4_22

	var_2(var_4_21, var_4_23, var_4_24, var_4_22)

	onButton = var_2

	local var_4_25 = arg_4_0
	local var_4_26 = arg_4_0.rtMsgbox
	local var_4_27 = var_5.Find(var_4_26, "window/top/btnBack")

	local function var_4_28()
		local var_11_0 = arg_4_0

		var_0.hideMsgbox(var_11_0)

		return
	end

	SFX_CANCEL = var_4_26

	var_2(var_4_25, var_4_27, var_4_28, var_4_26)

	onButton = var_2

	local var_4_29 = arg_4_0
	local var_4_30 = arg_4_0.rtMsgbox
	local var_4_31 = var_5.Find(var_4_30, "window/button_container/custom_button_2")

	local function var_4_32()
		local var_12_0 = arg_4_0

		var_0.hideMsgbox(var_12_0)

		return
	end

	SFX_CANCEL = var_4_30

	var_2(var_4_29, var_4_31, var_4_32, var_4_30)

	return
end

function var_0_1.didEnter(arg_13_0)
	pg = var_1_10001

	local var_13_0 = var_1_10001.UIMgr.GetInstance()

	var_1.BlurPanel(var_13_0, arg_13_0._tf)

	local var_13_1 = arg_13_0.itemList

	var_1.align(var_13_1, #arg_13_0.ids)

	local var_13_3

	if arg_13_0.childFinish then
		local var_13_2 = arg_13_0.content

		var_13_3 = var_13_3.GetComponent
		typeof = var_4
		ScrollRect = var_1_10006
		var_13_3 = var_13_3(var_13_2, var_4(var_1_10006)).viewport
		scrollTo = var_1_10002

		local var_13_4 = arg_13_0.content
		local var_13_5

		math = var_1_10006

		var_1_10002(var_13_4, var_13_5, var_1_10006.clamp(arg_13_0.childFinish.anchoredPosition.y / (arg_13_0.content.rect.height - var_13_3.rect.height), 0, 1))
		arg_13_0:doFinishAnim(arg_13_0.childFinish)

		arg_13_0.childFinish = nil
	end

	PlayerPrefs = var_13_3

	if var_13_3.GetInt("permanent_select", 0) ~= 1 then
		PlayerPrefs = var_1

		var_1.SetInt("permanent_select", 1)

		triggerButton = var_1

		var_1(arg_13_0.btnHelp)
	end

	return
end

function var_0_1.willExit(arg_14_0)
	isActive = var_1_10001

	if var_1_10001(arg_14_0.rtMsgbox) then
		arg_14_0:hideMsgbox()
	end

	pg = var_1

	local var_14_0 = var_1.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_14_0, arg_14_0._tf)

	if arg_14_0.ltId then
		LeanTween = var_1

		var_1.cancel(arg_14_0.ltId)

		arg_14_0.ltId = nil
	end

	return
end

function var_0_1.setActivitys(arg_15_0, arg_15_1)
	arg_15_0.ids = arg_15_1
	getProxy = var_1_10002
	ActivityPermanentProxy = var_1_10004

	local var_15_0 = var_1_10002(var_1_10004)

	table = var_1_10003

	var_1_10003.sort(arg_15_0.ids, function(arg_16_0, arg_16_1)
		local var_16_0 = var_15_0
		local var_16_1 = var_2.isActivityFinish(var_16_0, arg_16_0)
		local var_16_2 = var_15_0

		if var_16_1 == var_3.isActivityFinish(var_16_2, arg_16_1) then
			return arg_16_0 < arg_16_1
		else
			return var_3
		end

		return
	end)

	return
end

function var_0_1.doFinishAnim(arg_17_0, arg_17_1)
	local var_17_0 = arg_17_1
	local var_17_1

	var_17_1, GetOrAddComponent = arg_17_1.Find(var_17_0, "finish"), var_1_10003
	typeof = var_1_10006
	CanvasGroup = var_1_10008

	local var_17_2 = var_1_10003(var_17_1, var_1_10006(var_1_10008))

	LeanTween = var_17_0
	arg_17_0.ltId = var_17_0.alphaCanvas(var_17_2, 1, 1).uniqueId

	return
end

function var_0_1.showMsgbox(arg_18_0, arg_18_1)
	setText = var_1_10002

	local var_18_0 = arg_18_0.rtMsgbox
	local var_18_1 = var_4.Find(var_18_0, "window/button_container/custom_button_1/pic")

	i18n = var_1_10005

	var_1_10002(var_18_1, var_1_10005("msgbox_text_confirm"))

	setText = var_1_10002

	local var_18_2 = arg_18_0.rtMsgbox
	local var_18_3 = var_4.Find(var_18_2, "window/button_container/custom_button_2/pic")

	i18n = var_5

	var_1_10002(var_18_3, var_5("msgbox_text_cancel"))

	setText = var_1_10002

	local var_18_4 = arg_18_0.rtMsgbox
	local var_18_5 = var_4.Find(var_18_4, "window/top/bg/infomation/title")

	i18n = var_5

	var_1_10002(var_18_5, var_5("words_information"))

	setText = var_1_10002

	local var_18_6 = arg_18_0.rtMsgbox
	local var_18_7 = var_4.Find(var_18_6, "window/msg_panel/content")

	i18n = var_5

	local var_18_8 = "activity_permanent_tips1"

	pg = var_1_10008

	var_1_10002(var_18_7, var_5(var_18_8, var_1_10008.activity_task_permanent[arg_18_1].activity_name))

	setText = var_1_10002

	local var_18_9 = arg_18_0.rtMsgbox
	local var_18_10 = var_4.Find(var_18_9, "window/msg_panel/Text")

	i18n = var_5

	var_1_10002(var_18_10, var_5("activity_permanent_tips4"))

	onButton = var_1_10002

	local var_18_11 = arg_18_0
	local var_18_12 = arg_18_0.rtMsgbox
	local var_18_13 = var_5.Find(var_18_12, "window/button_container/custom_button_1")

	local function var_18_14()
		local var_19_0 = arg_18_0

		var_0.hideMsgbox(var_19_0)

		local var_19_1 = arg_18_0
		local var_19_2 = var_0.emit

		ActivityPermanentMediator = var_2_10003

		var_19_2(var_19_1, var_2_10003.START_SELECT, arg_18_1)

		return
	end

	SFX_CONFIRM = var_18_12

	var_1_10002(var_18_11, var_18_13, var_18_14, var_18_12)

	setActive = var_1_10002

	var_1_10002(arg_18_0.rtMsgbox, true)

	pg = var_1_10002

	local var_18_15 = var_1_10002.UIMgr.GetInstance()

	var_2.BlurPanel(var_18_15, arg_18_0.rtMsgbox)

	return
end

function var_0_1.hideMsgbox(arg_20_0)
	setActive = var_1_10001

	var_1_10001(arg_20_0.rtMsgbox, false)

	pg = var_1_10001

	local var_20_0 = var_1_10001.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_20_0, arg_20_0.rtMsgbox)

	return
end

return var_0_1
