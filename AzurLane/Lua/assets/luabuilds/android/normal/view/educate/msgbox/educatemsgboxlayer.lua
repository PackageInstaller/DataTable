class = var_0_10000

local var_0_0 = "EducateMsgBoxLayer"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("..base.EducateBaseUI"))

var_0_1.TYPE_NORMAL = 1
var_0_1.TYPE_SINGLE_ITEM = 2

local var_0_2 = {}
local var_0_3 = var_0_1.TYPE_NORMAL

Vector2 = var_3
var_0_2[var_0_3] = var_3(924, 616)

local var_0_4 = var_0_1.TYPE_SINGLE_ITEM

Vector2 = var_3
var_0_2[var_0_4] = var_3(1060, 628)

local var_0_5 = {}
local var_0_6 = var_0_1.TYPE_NORMAL

i18n = var_4
var_0_5[var_0_6] = var_4("child_msg_title_tip")

local var_0_7 = var_0_1.TYPE_SINGLE_ITEM

i18n = var_4
var_0_5[var_0_7] = var_4("child_msg_title_detail")

function var_0_1.getUIName(arg_1_0)
	return "EducateMsgBoxUI"
end

function var_0_1.init(arg_2_0)
	pg = var_1_10001

	local var_2_0 = var_1_10001.UIMgr.GetInstance()

	var_1.BlurPanel(var_2_0, arg_2_0._tf, {
		groupDelta = 3
	})

	local var_2_1 = arg_2_0._tf
	local var_2_2 = var_1.Find(var_2_1, "anim_root")
	local var_2_3 = var_1.GetComponent

	typeof = var_3
	Animation = var_4
	arg_2_0.anim = var_2_3(var_2_2, var_3(var_4))

	local var_2_4 = arg_2_0._tf
	local var_2_5 = var_1.Find(var_2_4, "anim_root")
	local var_2_6 = var_1.GetComponent

	typeof = var_3
	DftAniEvent = var_4
	arg_2_0.animEvent = var_2_6(var_2_5, var_3(var_4))

	local var_2_7 = arg_2_0.animEvent

	var_1.SetEndEvent(var_2_7, function()
		local var_3_0 = arg_2_0

		var_0.emit(var_3_0, var_0_1.ON_CLOSE)

		return
	end)

	local var_2_8 = arg_2_0._tf

	arg_2_0._window = var_1.Find(var_2_8, "anim_root/window")
	setActive = var_1

	var_1(arg_2_0._window, true)

	local var_2_9 = arg_2_0._window

	arg_2_0._top = var_1.Find(var_2_9, "top")

	local var_2_10 = arg_2_0._top

	arg_2_0._titleText = var_1.Find(var_2_10, "title")

	local var_2_11 = arg_2_0._top

	arg_2_0._closeBtn = var_1.Find(var_2_11, "btnBack")

	local var_2_12 = arg_2_0._window

	arg_2_0._msgPanel = var_1.Find(var_2_12, "msg_panel")

	local var_2_13 = arg_2_0._msgPanel
	local var_2_14 = var_1.Find(var_2_13, "content")

	arg_2_0.contentText = var_1.GetComponent(var_2_14, "RichText")

	local var_2_15 = arg_2_0.contentText
	local var_2_16 = var_1.AddSprite
	local var_2_17 = "gold"
	local var_2_18 = arg_2_0._tf
	local var_2_19 = var_4.Find(var_2_18, "res/gold")
	local var_2_20 = var_4.GetComponent

	typeof = var_6
	Image = var_1_10007

	var_2_16(var_2_15, var_2_17, var_2_20(var_2_19, var_6(var_1_10007)).sprite)

	local var_2_21 = arg_2_0._window

	arg_2_0._sigleItemPanel = var_1.Find(var_2_21, "single_item_panel")

	local var_2_22 = arg_2_0._sigleItemPanel

	arg_2_0.singleItemTF = var_1.Find(var_2_22, "item")

	local var_2_23 = arg_2_0._sigleItemPanel

	arg_2_0.singleItemOwn = var_1.Find(var_2_23, "own")

	local var_2_24 = arg_2_0._sigleItemPanel

	arg_2_0.singleItemName = var_1.Find(var_2_24, "display_panel/name")

	local var_2_25 = arg_2_0._sigleItemPanel

	arg_2_0.singleItemDesc = var_1.Find(var_2_25, "display_panel/desc/Text")

	local var_2_26 = arg_2_0._window

	arg_2_0._noBtn = var_1.Find(var_2_26, "button_container/no")
	setText = var_1

	local var_2_27 = arg_2_0._noBtn
	local var_2_28 = var_2.Find(var_2_27, "pic")

	i18n = var_2_27

	var_1(var_2_28, var_2_27("word_cancel"))

	local var_2_29 = arg_2_0._window

	arg_2_0._yesBtn = var_1.Find(var_2_29, "button_container/yes")
	setText = var_1

	local var_2_30 = arg_2_0._yesBtn
	local var_2_31 = var_2.Find(var_2_30, "pic")

	i18n = var_2_30

	var_1(var_2_31, var_2_30("word_ok"))

	return
end

function var_0_1.didEnter(arg_4_0)
	arg_4_0:ShowMsgBox(arg_4_0.contextData)

	return
end

function var_0_1.ShowMsgBox(arg_5_0, arg_5_1)
	arg_5_0:commonSetting(arg_5_1)
	arg_5_0:showByType(arg_5_1)

	return
end

function var_0_1.commonSetting(arg_6_0, arg_6_1)
	arg_6_0.settings = arg_6_1

	local var_6_0

	if not arg_6_0.settings.type then
		var_6_0 = var_0_1.TYPE_NORMAL
	end

	local var_6_1 = arg_6_0._window

	var_6_1.sizeDelta = var_0_2[var_6_0]
	setText = var_6_1

	var_6_1(arg_6_0._titleText, var_0_5[var_6_0])

	setActive = var_6_1

	var_6_1(arg_6_0._msgPanel, false)

	setActive = var_6_1

	var_6_1(arg_6_0._sigleItemPanel, false)

	local var_6_2

	if not arg_6_0.settings.hideNo then
		var_6_2 = false
	end

	local var_6_3

	if not arg_6_0.settings.hideYes then
		var_6_3 = false
	end

	local var_6_4

	if not arg_6_0.settings.hideClose then
		var_6_4 = false
	end

	local var_6_5

	if not arg_6_0.settings.onYes then
		function var_6_5()
			return
		end
	end

	local var_6_6

	if not arg_6_0.settings.onNo then
		function var_6_6()
			return
		end
	end

	local var_6_7

	if not arg_6_0.settings.onClose then
		function var_6_7()
			return
		end
	end

	setActive = var_1_10009

	var_1_10009(arg_6_0._noBtn, not var_6_2)

	onButton = var_1_10009

	local var_6_8 = arg_6_0
	local var_6_9 = arg_6_0._noBtn

	local function var_6_10()
		if var_6_6 then
			var_6_6()
		end

		local var_10_0 = arg_6_0

		var_0._close(var_10_0)

		return
	end

	SFX_CANCEL = var_1_10013

	var_1_10009(var_6_8, var_6_9, var_6_10, var_1_10013)

	setActive = var_1_10009

	var_1_10009(arg_6_0._yesBtn, not var_6_3)

	onButton = var_1_10009

	local var_6_11 = arg_6_0
	local var_6_12 = arg_6_0._yesBtn

	local function var_6_13()
		if var_6_5 then
			var_6_5()
		end

		local var_11_0 = arg_6_0

		var_0._close(var_11_0)

		return
	end

	SFX_CANCEL = var_1_10013

	var_1_10009(var_6_11, var_6_12, var_6_13, var_1_10013)

	setActive = var_1_10009

	var_1_10009(arg_6_0._closeBtn, not var_6_4)

	onButton = var_1_10009

	local var_6_14 = arg_6_0
	local var_6_15 = arg_6_0._closeBtn

	local function var_6_16()
		if var_6_7 then
			var_6_7()
		else
			var_6_6()
		end

		local var_12_0 = arg_6_0

		var_0._close(var_12_0)

		return
	end

	SFX_CANCEL = var_1_10013

	var_1_10009(var_6_14, var_6_15, var_6_16, var_1_10013)

	onButton = var_1_10009

	local var_6_17 = arg_6_0

	tf = var_6_15

	local var_6_18 = var_6_15(arg_6_0._go)
	local var_6_19 = var_11.Find(var_6_18, "anim_root/bg")

	local function var_6_20()
		if var_6_7 then
			var_6_7()
		else
			var_6_6()
		end

		local var_13_0 = arg_6_0

		var_0._close(var_13_0)

		return
	end

	SFX_CANCEL = var_13

	var_1_10009(var_6_17, var_6_19, var_6_20, var_13)

	return
end

function var_0_1.showByType(arg_14_0, arg_14_1)
	local var_14_0

	if not arg_14_0.settings.type then
		var_14_0 = var_0_1.TYPE_NORMAL
	end

	switch = var_1_10003

	var_1_10003(var_14_0, {
		[var_0_1.TYPE_NORMAL] = function()
			local var_15_0 = arg_14_0

			var_0.showNormalMsgBox(var_15_0)

			return
		end,
		[var_0_1.TYPE_SINGLE_ITEM] = function()
			local var_16_0 = arg_14_0

			var_0.showSingleItemBox(var_16_0)

			return
		end
	})

	return
end

function var_0_1.showNormalMsgBox(arg_17_0)
	setActive = var_1_10001

	var_1_10001(arg_17_0._msgPanel, true)

	local var_17_0 = arg_17_0.contentText
	local var_17_1

	if not arg_17_0.settings.content then
		var_17_1 = ""
	end

	var_17_0.text = var_17_1

	return
end

function var_0_1.showSingleItemBox(arg_18_0)
	setActive = var_1_10001

	var_1_10001(arg_18_0._sigleItemPanel, true)

	setActive = var_1_10001

	var_1_10001(arg_18_0._noBtn, false)

	EducateHelper = var_1_10001

	var_1_10001.UpdateDropShow(arg_18_0.singleItemTF, arg_18_0.settings.drop)

	EducateHelper = var_1

	local var_18_0 = var_1.GetDropConfig(arg_18_0.settings.drop)

	setText = var_2

	local var_18_1 = arg_18_0.singleItemName
	local var_18_2

	if not var_18_0.name then
		var_18_2 = ""
	end

	var_2(var_18_1, var_18_2)

	local var_18_3 = arg_18_0.settings.drop.type

	EducateConst = var_18_1

	local var_18_4

	if var_18_3 == var_18_1.DROP_TYPE_RES then
		var_18_3 = var_18_0.id
		EducateChar = var_18_4

		if var_18_3 == var_18_4.RES_MOOD_ID then
			setText = var_18_3
			var_18_4 = arg_18_0.singleItemDesc
			var_1_10005 = arg_18_0

			var_18_3(var_18_4, arg_18_0.getMoodDesc(var_1_10005, var_18_0.desc))

			goto label_18_0
		end
	end

	setText = var_18_3
	var_18_4 = arg_18_0.singleItemDesc

	do
		local var_18_5

		if not var_18_0.desc and not var_18_0.name then
			var_18_5 = ""
		end

		var_18_3(var_18_4, var_18_5)
	end

	::label_18_0::

	local var_18_6 = arg_18_0.settings.drop.type

	EducateConst = var_18_4

	if var_18_6 == var_18_4.DROP_TYPE_ITEM then
		getProxy = var_18_6
		EducateProxy = var_3

		local var_18_7 = var_18_6(var_3)

		var_18_6 = var_18_6.GetItemCntById(var_18_7, var_18_0.id)
		setText = var_18_7

		local var_18_8 = arg_18_0.singleItemOwn

		i18n = var_1_10005

		var_18_7(var_18_8, var_1_10005("child_msg_owned", var_18_6))

		setActive = var_18_7

		var_18_7(arg_18_0.singleItemOwn, true)
	else
		setActive = var_18_6

		var_18_6(arg_18_0.singleItemOwn, false)
	end

	return
end

function var_0_1.getMoodDesc(arg_19_0, arg_19_1)
	getProxy = var_1_10002
	EducateProxy = var_1_10003

	local var_19_0 = var_1_10002(var_1_10003)
	local var_19_1 = var_2.GetCharData(var_19_0)
	local var_19_2 = var_2.GetMoodStage(var_19_1)

	string = var_19_1

	local var_19_3 = var_19_1.gsub
	local var_19_4 = arg_19_1
	local var_19_5 = "$1"

	i18n = var_1_10006

	return var_19_3(var_19_4, var_19_5, var_1_10006("child_mood_desc" .. var_19_2))
end

function var_0_1._close(arg_20_0)
	local var_20_0 = arg_20_0.anim

	var_1.Play(var_20_0, "anim_educate_MsgBox_out")

	return
end

function var_0_1.onBackPressed(arg_21_0)
	arg_21_0:_close()

	return
end

function var_0_1.willExit(arg_22_0)
	local var_22_0 = arg_22_0.animEvent

	var_1.SetEndEvent(var_22_0, nil)

	pg = var_1

	local var_22_1 = var_1.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_22_1, arg_22_0._tf)

	if arg_22_0.contextData.onExit then
		arg_22_0.contextData.onExit()
	end

	return
end

return var_0_1
