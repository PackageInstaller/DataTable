class = var_0_10000

local var_0_0 = "MailRewardWindow"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.BaseSubView"))

function var_0_1.getUIName(arg_1_0)
	return "MailRewardMsgboxUI"
end

function var_0_1.OnInit(arg_2_0)
	onButton = var_1_10001

	local var_2_0 = arg_2_0
	local var_2_1 = arg_2_0._tf
	local var_2_2 = var_4.Find(var_2_1, "bg")

	local function var_2_3()
		local var_3_0 = arg_2_0

		var_0.Hide(var_3_0)

		return
	end

	SFX_PANEL = var_2_1

	var_1_10001(var_2_0, var_2_2, var_2_3, var_2_1)

	local var_2_4 = arg_2_0._tf

	arg_2_0.closeBtn = var_1.Find(var_2_4, "adapt/window/top/btnBack")
	onButton = var_1

	local var_2_5 = arg_2_0
	local var_2_6 = arg_2_0.closeBtn

	local function var_2_7()
		local var_4_0 = arg_2_0

		var_0.Hide(var_4_0)

		return
	end

	SFX_PANEL = var_2_1

	var_1(var_2_5, var_2_6, var_2_7, var_2_1)

	local var_2_8 = arg_2_0._tf

	arg_2_0.cancelButton = var_1.Find(var_2_8, "adapt/window/button_container/btn_not")

	local var_2_9 = arg_2_0._tf

	arg_2_0.confirmButton = var_1.Find(var_2_9, "adapt/window/button_container/btn_ok")

	local var_2_10 = arg_2_0._tf

	arg_2_0._window = var_1.Find(var_2_10, "adapt/window")

	local var_2_11 = arg_2_0._window

	arg_2_0.item_panel = var_1.Find(var_2_11, "item_panel")

	local var_2_12 = arg_2_0.item_panel

	arg_2_0.reward_gold = var_1.Find(var_2_12, "parentAdpter/textAdpter/reward_gold")

	local var_2_13 = arg_2_0.reward_gold

	arg_2_0.reward_goldText = var_1.Find(var_2_13, "gold_text")

	local var_2_14 = arg_2_0.item_panel

	arg_2_0.reward_oil = var_1.Find(var_2_14, "parentAdpter/textAdpter/reward_oil")

	local var_2_15 = arg_2_0.reward_oil

	arg_2_0.reward_oilText = var_1.Find(var_2_15, "oil_text")

	local var_2_16 = arg_2_0.item_panel

	arg_2_0._itemListItemContainer = var_1.Find(var_2_16, "parentAdpter/rewardAdpter/list")

	local var_2_17 = arg_2_0.item_panel

	arg_2_0._itemListItemTpl = var_1.Find(var_2_17, "parentAdpter/rewardAdpter/item")

	local var_2_18 = arg_2_0._window

	arg_2_0.titleTips = var_1.Find(var_2_18, "top/bg/infomation/title")
	setText = var_1

	local var_2_19 = arg_2_0.reward_goldText

	i18n = var_4

	var_1(var_2_19, var_4("mail_storeroom_max_4"))

	setText = var_1

	local var_2_20 = arg_2_0.reward_oilText

	i18n = var_4

	var_1(var_2_20, var_4("mail_storeroom_max_3"))

	setText = var_1

	local var_2_21 = arg_2_0.titleTips

	i18n = var_4

	var_1(var_2_21, var_4("mail_boxtitle_information"))

	setText = var_1

	local var_2_22 = arg_2_0.item_panel
	local var_2_23 = var_3.Find(var_2_22, "parentAdpter/rewardAdpter/Text")

	i18n = var_4

	var_1(var_2_23, var_4("mail_storeroom_collect"))

	setText = var_1

	local var_2_24 = arg_2_0.cancelButton
	local var_2_25 = var_3.Find(var_2_24, "Text")

	i18n = var_4

	var_1(var_2_25, var_4("mail_box_cancel"))

	setText = var_1

	local var_2_26 = arg_2_0.confirmButton
	local var_2_27 = var_3.Find(var_2_26, "Text")

	i18n = var_4

	var_1(var_2_27, var_4("mail_box_confirm"))

	return
end

function var_0_1.Show(arg_5_0, arg_5_1)
	var_0_1.super.Show(arg_5_0)

	pg = var_2

	local var_5_0 = var_2.UIMgr.GetInstance()

	var_2.BlurPanel(var_5_0, arg_5_0._tf)

	onButton = var_2

	local var_5_1 = arg_5_0
	local var_5_2 = arg_5_0.cancelButton

	local function var_5_3()
		local var_6_0 = arg_5_0

		var_0.Hide(var_6_0)

		return
	end

	SFX_PANEL = var_1_10007

	var_2(var_5_1, var_5_2, var_5_3, var_1_10007)

	onButton = var_2

	local var_5_4 = arg_5_0
	local var_5_5 = arg_5_0.confirmButton

	local function var_5_6()
		local var_7_0 = arg_5_0

		var_0.Hide(var_7_0)

		if arg_5_1.onYes then
			arg_5_1.onYes()
		end

		return
	end

	SFX_PANEL = var_1_10007

	var_2(var_5_4, var_5_5, var_5_6, var_1_10007)

	getProxy = var_2
	PlayerProxy = var_5_4

	local var_5_7 = var_2(var_5_4)
	local var_5_8 = var_2.getData(var_5_7)
	local var_5_9 = false
	local var_5_10 = false
	local var_5_11 = {}

	if arg_5_1.content.oil > 0 then
		table = var_6

		local var_5_12 = var_6.insert
		local var_5_13 = var_5_11

		Drop = var_1_10009
		var_1_10009 = var_1_10009.New

		local var_5_14 = {}

		DROP_TYPE_RESOURCE = var_1_10012
		var_5_14.type = var_1_10012
		PlayerConst = var_1_10012
		var_5_14.id = var_1_10012.ResOil
		var_5_14.count = arg_5_1.content.oil

		var_5_12(var_5_13, var_1_10009(var_5_14))

		local var_5_15 = var_5_8
		local var_5_16 = var_5_8.getResource

		PlayerConst = var_1_10009
		var_5_10 = var_5_16(var_5_15, var_1_10009.ResOil) + arg_5_1.content.oil >= var_5_8:getLevelMaxOil()
	end

	local var_5_17 = arg_5_1.content.gold

	if 0 < var_5_17 then
		table = var_5_17
		var_5_17 = var_5_17.insert

		local var_5_18 = var_5_11

		Drop = var_1_10009

		local var_5_19 = var_1_10009.New
		local var_5_20 = {}

		DROP_TYPE_RESOURCE = var_1_10012
		var_5_20.type = var_1_10012
		PlayerConst = var_1_10012
		var_5_20.id = var_1_10012.ResGold
		var_5_20.count = arg_5_1.content.gold

		var_5_17(var_5_18, var_5_19(var_5_20))

		local var_5_21 = var_5_8

		var_5_17 = var_5_8.getResource
		PlayerConst = var_9
		var_5_9 = var_5_17(var_5_21, var_9.ResGold) + arg_5_1.content.gold >= var_5_8:getLevelMaxGold()
	end

	setActive = var_5_17

	var_5_17(arg_5_0.reward_oil, var_5_10)

	setActive = var_5_17

	var_5_17(arg_5_0.reward_gold, var_5_9)

	local var_5_22 = var_5_9 or var_5_10

	setActive = var_7

	local var_5_23 = arg_5_0.item_panel

	var_7(var_9.Find(var_5_23, "parentAdpter/textAdpter"), var_5_22)

	UIItemList = var_7

	var_7.StaticAlign(arg_5_0._itemListItemContainer, arg_5_0._itemListItemTpl, #var_5_11, function(arg_8_0, arg_8_1, arg_8_2)
		arg_8_1 = arg_8_1 + 1
		UIItemList = var_2_10003

		if arg_8_0 == var_2_10003.EventUpdate then
			local var_8_0 = var_5_11[arg_8_1]

			updateDrop = var_2_10004

			var_2_10004(arg_8_2:Find("IconTpl"), var_8_0)
		end

		return
	end)

	local var_5_24 = var_5_22 and 17 or 32
	local var_5_25 = arg_5_0.item_panel
	local var_5_26 = var_8.Find(var_5_25, "parentAdpter")
	local var_5_27 = var_8.GetComponent

	typeof = var_11
	UnityEngine = var_1_10013

	local var_5_28 = var_5_27(var_5_26, var_11(var_1_10013.UI.HorizontalOrVerticalLayoutGroup))

	UnityEngine = var_9

	local var_5_29 = var_9.RectOffset.New()

	var_5_29.bottom = 0
	var_5_29.left = 0
	var_5_29.right = 0
	var_5_29.top = var_5_24
	var_5_28.padding = var_5_29
	Canvas = var_10

	var_10.ForceUpdateCanvases()

	return
end

function var_0_1.Hide(arg_9_0)
	pg = var_1_10001

	local var_9_0 = var_1_10001.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_9_0, arg_9_0._tf, arg_9_0._parentTf)
	var_0_1.super.Hide(arg_9_0)

	return
end

function var_0_1.OnDestroy(arg_10_0)
	if arg_10_0:isShowing() then
		arg_10_0:Hide()
	end

	return
end

return var_0_1
