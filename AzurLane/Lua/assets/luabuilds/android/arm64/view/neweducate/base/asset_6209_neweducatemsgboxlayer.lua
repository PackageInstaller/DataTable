class = var_0_10000

local var_0_0 = "NewEducateMsgBoxLayer"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.newEducate.base.NewEducateBaseUI"))

var_0_1.TYPE = {
	SHOP = 3,
	RESET = 4,
	BOX = 1,
	ITEM = 2
}

local var_0_2 = {}
local var_0_3 = var_0_1.TYPE.BOX

Vector2 = var_3
var_0_2[var_0_3] = var_3(924, 616)

local var_0_4 = var_0_1.TYPE.ITEM

Vector2 = var_3
var_0_2[var_0_4] = var_3(1060, 628)

local var_0_5 = var_0_1.TYPE.SHOP

Vector2 = var_3
var_0_2[var_0_5] = var_3(1060, 628)

local var_0_6 = var_0_1.TYPE.RESET

Vector2 = var_3
var_0_2[var_0_6] = var_3(980, 650)

local var_0_7 = {}
local var_0_8 = var_0_1.TYPE.BOX

i18n = var_0_10004
var_0_7[var_0_8] = var_0_10004("child_msg_title_tip")

local var_0_9 = var_0_1.TYPE.ITEM

i18n = var_4
var_0_7[var_0_9] = var_4("child_msg_title_detail")

local var_0_10 = var_0_1.TYPE.SHOP

i18n = var_4
var_0_7[var_0_10] = var_4("child_msg_title_detail")

local var_0_11 = var_0_1.TYPE.RESET

i18n = var_4
var_0_7[var_0_11] = var_4("child_msg_title_tip")

function var_0_1.getUIName(arg_1_0)
	return "NewEducateMsgBoxUI"
end

function var_0_1.init(arg_2_0)
	pg = var_1_10001

	local var_2_0 = var_1_10001.UIMgr.GetInstance()

	var_1.BlurPanel(var_2_0, arg_2_0._tf)

	local var_2_1 = arg_2_0._tf
	local var_2_2 = var_1.Find(var_2_1, "anim_root")
	local var_2_3 = var_1.GetComponent

	typeof = var_4
	Animation = var_1_10006
	arg_2_0.anim = var_2_3(var_2_2, var_4(var_1_10006))

	local var_2_4 = arg_2_0._tf
	local var_2_5 = var_1.Find(var_2_4, "anim_root")
	local var_2_6 = var_1.GetComponent

	typeof = var_4
	DftAniEvent = var_1_10006
	arg_2_0.animEvent = var_2_6(var_2_5, var_4(var_1_10006))

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

	local var_2_15 = arg_2_0._window

	arg_2_0._sigleItemPanel = var_1.Find(var_2_15, "single_item_panel")

	local var_2_16 = arg_2_0._sigleItemPanel

	arg_2_0.singleItemTF = var_1.Find(var_2_16, "item")

	local var_2_17 = arg_2_0._sigleItemPanel

	arg_2_0.singleItemOwn = var_1.Find(var_2_17, "own")

	local var_2_18 = arg_2_0._sigleItemPanel

	arg_2_0.singleItemName = var_1.Find(var_2_18, "display_panel/name")

	local var_2_19 = arg_2_0._sigleItemPanel

	arg_2_0.singleItemDesc = var_1.Find(var_2_19, "display_panel/desc/Text")

	local var_2_20 = arg_2_0._window

	arg_2_0._shopPanel = var_1.Find(var_2_20, "shop_panel")

	local var_2_21 = arg_2_0._shopPanel

	arg_2_0.goodsIcon = var_1.Find(var_2_21, "item/frame/icon")

	local var_2_22 = arg_2_0._shopPanel

	arg_2_0.goodsName = var_1.Find(var_2_22, "display_panel/name")

	local var_2_23 = arg_2_0._shopPanel

	arg_2_0.goodsDesc = var_1.Find(var_2_23, "display_panel/desc/Text")

	local var_2_24 = arg_2_0._window

	arg_2_0._resetPanel = var_1.Find(var_2_24, "reset_panel")
	setText = var_1

	local var_2_25 = arg_2_0._resetPanel
	local var_2_26 = var_3.Find(var_2_25, "Text")

	i18n = var_4

	var_1(var_2_26, var_4("child2_endless_reset_tip"))

	local var_2_27 = arg_2_0._resetPanel

	arg_2_0._resetContent = var_1.Find(var_2_27, "content")

	local var_2_28 = arg_2_0._window

	arg_2_0._noBtn = var_1.Find(var_2_28, "button_container/no")
	setText = var_1

	local var_2_29 = arg_2_0._noBtn
	local var_2_30 = var_3.Find(var_2_29, "pic")

	i18n = var_4

	var_1(var_2_30, var_4("word_cancel"))

	local var_2_31 = arg_2_0._window

	arg_2_0._yesBtn = var_1.Find(var_2_31, "button_container/yes")
	setText = var_1

	local var_2_32 = arg_2_0._yesBtn
	local var_2_33 = var_3.Find(var_2_32, "pic")

	i18n = var_4

	var_1(var_2_33, var_4("word_ok"))

	local var_2_34 = arg_2_0._window

	arg_2_0._buyBtn = var_1.Find(var_2_34, "button_container/buy")
	setText = var_1

	local var_2_35 = arg_2_0._buyBtn
	local var_2_36 = var_3.Find(var_2_35, "pic")

	i18n = var_4

	var_1(var_2_36, var_4("word_ok"))

	return
end

function var_0_1.didEnter(arg_4_0)
	arg_4_0:ShowMsgBox(arg_4_0.contextData)

	arg_4_0.isClosing = false

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
		var_6_0 = var_0_1.TYPE.BOX
	end

	local var_6_1 = arg_6_0._window

	var_6_1.sizeDelta = var_0_2[var_6_0]
	setText = var_6_1

	var_6_1(arg_6_0._titleText, var_0_7[var_6_0])

	setActive = var_6_1

	var_6_1(arg_6_0._msgPanel, false)

	setActive = var_6_1

	var_6_1(arg_6_0._sigleItemPanel, false)

	setActive = var_6_1

	var_6_1(arg_6_0._shopPanel, false)

	setActive = var_6_1

	var_6_1(arg_6_0._resetPanel, false)

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

	if not arg_6_0.settings.onBuy then
		function var_6_7()
			return
		end
	end

	local var_6_8

	if not arg_6_0.settings.onClose then
		function var_6_8()
			return
		end
	end

	setText = var_1_10010

	local var_6_9 = arg_6_0._noBtn
	local var_6_10 = var_12.Find(var_6_9, "pic")
	local var_6_11

	if not arg_6_0.settings.noText then
		i18n = var_6_11
		var_6_11 = var_6_11("word_cancel")
	end

	var_1_10010(var_6_10, var_6_11)

	setText = var_1_10010

	local var_6_12 = arg_6_0._yesBtn
	local var_6_13 = var_12.Find(var_6_12, "pic")
	local var_6_14

	if not arg_6_0.settings.yesText then
		i18n = var_6_14
		var_6_14 = var_6_14("word_ok")
	end

	var_1_10010(var_6_13, var_6_14)

	setActive = var_1_10010

	var_1_10010(arg_6_0._noBtn, not var_6_2)

	onButton = var_1_10010

	local var_6_15 = arg_6_0
	local var_6_16 = arg_6_0._noBtn

	local function var_6_17()
		if arg_6_0.isClosing then
			return
		end

		local var_11_0 = arg_6_0.contextData.onExit

		function arg_6_0.contextData.onExit()
			existCall = var_3_10000

			var_3_10000(var_6_6)

			existCall = var_3_10000

			var_3_10000(var_11_0)

			return
		end

		local var_11_1 = arg_6_0

		var_1._close(var_11_1)

		return
	end

	SFX_CANCEL = var_15

	var_1_10010(var_6_15, var_6_16, var_6_17, var_15)

	setActive = var_1_10010

	var_1_10010(arg_6_0._yesBtn, not var_6_3)

	onButton = var_1_10010

	local var_6_18 = arg_6_0
	local var_6_19 = arg_6_0._yesBtn

	local function var_6_20()
		if arg_6_0.isClosing then
			return
		end

		local var_13_0 = arg_6_0.contextData.onExit

		function arg_6_0.contextData.onExit()
			existCall = var_3_10000

			var_3_10000(var_6_5)

			existCall = var_3_10000

			var_3_10000(var_13_0)

			return
		end

		local var_13_1 = arg_6_0

		var_1._close(var_13_1)

		return
	end

	SFX_CANCEL = var_15

	var_1_10010(var_6_18, var_6_19, var_6_20, var_15)

	setActive = var_1_10010

	var_1_10010(arg_6_0._buyBtn, arg_6_0.settings.type == var_0_1.TYPE.SHOP)

	onButton = var_1_10010

	local var_6_21 = arg_6_0
	local var_6_22 = arg_6_0._buyBtn

	local function var_6_23()
		if arg_6_0.isClosing then
			return
		end

		local var_15_0 = arg_6_0.contextData.onExit

		function arg_6_0.contextData.onExit()
			existCall = var_3_10000

			var_3_10000(var_6_7)

			existCall = var_3_10000

			var_3_10000(var_15_0)

			return
		end

		local var_15_1 = arg_6_0

		var_1._close(var_15_1)

		return
	end

	SFX_CANCEL = var_15

	var_1_10010(var_6_21, var_6_22, var_6_23, var_15)

	setActive = var_1_10010

	var_1_10010(arg_6_0._closeBtn, not var_6_4)

	onButton = var_1_10010

	local var_6_24 = arg_6_0
	local var_6_25 = arg_6_0._closeBtn

	local function var_6_26()
		if arg_6_0.isClosing then
			return
		end

		local var_17_0 = arg_6_0.contextData.onExit

		function arg_6_0.contextData.onExit()
			existCall = var_3_10000

			var_3_10000(var_6_8)

			existCall = var_3_10000

			var_3_10000(var_17_0)

			return
		end

		local var_17_1 = arg_6_0

		var_1._close(var_17_1)

		return
	end

	SFX_CANCEL = var_15

	var_1_10010(var_6_24, var_6_25, var_6_26, var_15)

	onButton = var_1_10010

	local var_6_27 = arg_6_0

	tf = var_6_25

	local var_6_28 = var_6_25(arg_6_0._go)
	local var_6_29 = var_13.Find(var_6_28, "anim_root/bg")

	local function var_6_30()
		if arg_6_0.isClosing then
			return
		end

		if var_6_2 or var_6_4 then
			return
		end

		local var_19_0 = arg_6_0.contextData.onExit

		function arg_6_0.contextData.onExit()
			existCall = var_3_10000

			var_3_10000(var_6_8)

			existCall = var_3_10000

			var_3_10000(var_19_0)

			return
		end

		local var_19_1 = arg_6_0

		var_1._close(var_19_1)

		return
	end

	SFX_CANCEL = var_6_28

	var_1_10010(var_6_27, var_6_29, var_6_30, var_6_28)

	return
end

function var_0_1.showByType(arg_21_0, arg_21_1)
	local var_21_0

	if not arg_21_0.settings.type then
		var_21_0 = var_0_1.TYPE.BOX
	end

	switch = var_1_10003

	var_1_10003(var_21_0, {
		[var_0_1.TYPE.BOX] = function()
			local var_22_0 = arg_21_0

			var_0.showNormalMsgBox(var_22_0)

			return
		end,
		[var_0_1.TYPE.ITEM] = function()
			local var_23_0 = arg_21_0

			var_0.showSingleItemBox(var_23_0)

			return
		end,
		[var_0_1.TYPE.SHOP] = function()
			local var_24_0 = arg_21_0

			var_0.showShopBuyBox(var_24_0)

			return
		end,
		[var_0_1.TYPE.RESET] = function()
			local var_25_0 = arg_21_0

			var_0.showResetBox(var_25_0)

			return
		end
	})

	return
end

function var_0_1.showNormalMsgBox(arg_26_0)
	setActive = var_1_10001

	var_1_10001(arg_26_0._msgPanel, true)

	local var_26_0 = arg_26_0.contentText
	local var_26_1

	if not arg_26_0.settings.content then
		var_26_1 = ""
	end

	var_26_0.text = var_26_1

	return
end

function var_0_1.showSingleItemBox(arg_27_0)
	setActive = var_1_10001

	var_1_10001(arg_27_0._sigleItemPanel, true)

	setActive = var_1_10001

	var_1_10001(arg_27_0._noBtn, false)

	NewEducateHelper = var_1_10001

	var_1_10001.UpdateItem(arg_27_0.singleItemTF, arg_27_0.settings.drop)

	NewEducateHelper = var_1

	local var_27_0 = var_1.GetDropConfig(arg_27_0.settings.drop)

	setText = var_1_10002

	local var_27_1 = arg_27_0.singleItemName
	local var_27_2

	if not var_27_0.name then
		var_27_2 = ""
	end

	var_1_10002(var_27_1, var_27_2)

	getProxy = var_1_10002
	NewEducateProxy = var_27_1

	local var_27_3 = var_1_10002(var_27_1)
	local var_27_4 = var_2.GetCurChar(var_27_3)
	local var_27_5 = var_2.GetOwnCnt(var_27_4, arg_27_0.settings.drop)

	setText = var_27_3

	local var_27_6 = arg_27_0.singleItemOwn

	i18n = var_1_10007

	var_27_3(var_27_6, var_1_10007("child_msg_owned", var_27_5))

	local var_27_7 = arg_27_0.settings.drop.type

	NewEducateConst = var_27_4

	if var_27_7 == var_27_4.DROP_TYPE.RES then
		var_27_7 = var_27_0.type
		NewEducateChar = var_5

		if var_27_7 == var_5.RES_TYPE.MOOD then
			var_27_7 = var_2:GetMoodStage()
			setText = var_5

			local var_27_8 = arg_27_0.singleItemDesc

			string = var_1_10008

			local var_27_9 = var_1_10008.gsub
			local var_27_10 = var_27_0.desc
			local var_27_11 = "$1"

			i18n = var_1_10012

			var_5(var_27_8, var_27_9(var_27_10, var_27_11, var_1_10012("child2_mood_desc" .. var_27_7)))

			goto label_27_0
		end
	end

	setText = var_27_7

	do
		local var_27_12 = arg_27_0.singleItemDesc
		local var_27_13

		if not var_27_0.desc and not var_27_0.name then
			var_27_13 = ""
		end

		var_27_7(var_27_12, var_27_13)
	end

	::label_27_0::

	return
end

function var_0_1.showShopBuyBox(arg_28_0)
	setActive = var_1_10001

	var_1_10001(arg_28_0._shopPanel, true)

	setActive = var_1_10001

	var_1_10001(arg_28_0._yesBtn, false)

	setActive = var_1_10001

	var_1_10001(arg_28_0._buyBtn, true)

	setText = var_1_10001

	local var_28_0 = arg_28_0._buyBtn

	var_1_10001(var_3.Find(var_28_0, "price/Text"), arg_28_0.settings.price)

	pg = var_1_10001

	local var_28_1 = var_1_10001.child2_shop[arg_28_0.settings.shopId]

	LoadImageSpriteAsync = var_2

	var_2("neweducateicon/" .. var_28_1.icon, arg_28_0.goodsIcon)

	setText = var_2

	var_2(arg_28_0.goodsName, var_28_1.name)

	local var_28_2 = var_28_1.goods_type

	NewEducateGoods = var_3

	if var_28_2 == var_3.TYPE.BENEFIT then
		pg = var_28_2
		var_28_2 = var_28_2.child2_benefit_list[var_28_1.goods_id]
		setText = var_3

		var_3(arg_28_0.goodsDesc, var_28_2.desc)
	else
		setText = var_28_2

		var_28_2(arg_28_0.goodsDesc, var_28_1.desc)
	end

	return
end

function var_0_1.showResetBox(arg_29_0)
	setActive = var_1_10001

	var_1_10001(arg_29_0._resetPanel, true)

	getProxy = var_1_10001
	NewEducateProxy = var_3

	local var_29_0 = var_1_10001(var_3)
	local var_29_1 = var_1.GetCurChar(var_29_0)
	local var_29_2 = var_1.GetRoundData(var_29_1)
	local var_29_3 = var_1.GetHeighestWave(var_29_2)
	local var_29_4 = var_1:GetWave()

	setText = var_29_2

	local var_29_5 = arg_29_0._resetContent
	local var_29_6 = var_6.Find(var_29_5, "history")

	i18n = var_1_10007

	var_29_2(var_29_6, var_1_10007("child2_endless_history_wave", var_29_3))

	setText = var_29_2

	local var_29_7 = arg_29_0._resetContent
	local var_29_8 = var_6.Find(var_29_7, "current")

	i18n = var_7

	var_29_2(var_29_8, var_7("child2_endless_current_wave", var_29_4))

	setActive = var_29_2

	local var_29_9 = arg_29_0._resetContent

	var_29_2(var_6.Find(var_29_9, "current/new"), var_29_3 < var_29_4)

	return
end

function var_0_1._close(arg_30_0)
	arg_30_0.isClosing = true

	local var_30_0 = arg_30_0.anim

	var_1.Play(var_30_0, "anim_educate_MsgBox_out")

	return
end

function var_0_1.onBackPressed(arg_31_0)
	if arg_31_0.settings.hideNo or arg_31_0.settings.hideClose then
		return
	end

	arg_31_0:_close()

	return
end

function var_0_1.willExit(arg_32_0)
	local var_32_0 = arg_32_0.animEvent

	var_1.SetEndEvent(var_32_0, nil)

	pg = var_1

	local var_32_1 = var_1.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_32_1, arg_32_0._tf)

	if arg_32_0.contextData.onExit then
		arg_32_0.contextData.onExit()
	end

	return
end

return var_0_1
