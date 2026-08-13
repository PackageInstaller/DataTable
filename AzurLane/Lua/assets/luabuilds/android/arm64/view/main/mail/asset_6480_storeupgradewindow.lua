class = var_0_10000

local var_0_0 = "StoreUpgradeWindow"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.BaseSubView"))

function var_0_1.getUIName(arg_1_0)
	return "MailStoreExtendMsgboxUI"
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

	arg_2_0.closeBtn = var_1.Find(var_2_4, "window/top/btnBack")
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

	arg_2_0.btnDiamond = var_1.Find(var_2_8, "window/button_container/btn_diamond")
	onButton = var_1

	local var_2_9 = arg_2_0
	local var_2_10 = arg_2_0.btnDiamond

	local function var_2_11()
		local var_5_0 = arg_2_0
		local var_5_1 = var_0.emit

		MailMediator = var_2_10003

		var_5_1(var_5_0, var_2_10003.ON_EXTEND_STORE, true)

		local var_5_2 = arg_2_0

		var_0.Hide(var_5_2)

		return
	end

	SFX_PANEL = var_2_1

	var_1(var_2_9, var_2_10, var_2_11, var_2_1)

	local var_2_12 = arg_2_0._tf

	arg_2_0.btnGold = var_1.Find(var_2_12, "window/button_container/btn_gold")
	onButton = var_1

	local var_2_13 = arg_2_0
	local var_2_14 = arg_2_0.btnGold

	local function var_2_15()
		local var_6_0 = arg_2_0
		local var_6_1 = var_0.emit

		MailMediator = var_2_10003

		var_6_1(var_6_0, var_2_10003.ON_EXTEND_STORE, false)

		local var_6_2 = arg_2_0

		var_0.Hide(var_6_2)

		return
	end

	SFX_PANEL = var_2_1

	var_1(var_2_13, var_2_14, var_2_15, var_2_1)

	setText = var_1

	local var_2_16 = arg_2_0._tf
	local var_2_17 = var_3.Find(var_2_16, "window/top/bg/infomation/title")

	i18n = var_2_14

	var_1(var_2_17, var_2_14("mail_boxroom_extend_title"))

	setText = var_1

	local var_2_18 = arg_2_0._tf
	local var_2_19 = var_3.Find(var_2_18, "window/frame/tip/Text")

	i18n = var_4

	var_1(var_2_19, var_4("mail_boxroom_extend_tips"))

	setText = var_1

	local var_2_20 = arg_2_0.btnGold
	local var_2_21 = var_3.Find(var_2_20, "Text")

	i18n = var_4

	var_1(var_2_21, var_4("mail_buy_button"))

	setText = var_1

	local var_2_22 = arg_2_0.btnDiamond
	local var_2_23 = var_3.Find(var_2_22, "Text")

	i18n = var_4

	var_1(var_2_23, var_4("mail_buy_button"))

	setText = var_1

	local var_2_24 = arg_2_0._tf
	local var_2_25 = var_3.Find(var_2_24, "window/frame/price/Text")

	i18n = var_4

	var_1(var_2_25, var_4("mail_all_price"))

	return
end

function var_0_1.UpdateInfo(arg_7_0)
	local var_7_0 = arg_7_0._tf
	local var_7_1 = var_1.Find(var_7_0, "window/frame")

	getProxy = var_1_10002
	PlayerProxy = var_4

	local var_7_2 = var_1_10002(var_4)
	local var_7_3 = var_2.getRawData(var_7_2)

	pg = var_7_0

	local var_7_4 = var_7_0.mail_storeroom[var_7_3.mailStoreLevel]

	pg = var_4

	local var_7_5 = var_4.mail_storeroom[var_7_3.mailStoreLevel + 1]
	local var_7_6 = var_7_3
	local var_7_7, var_7_8 = var_7_3.GetExtendStoreCost(var_7_6)

	setText = var_7_6

	var_7_6(var_7_1:Find("gold/before"), var_7_4.gold_store)

	setText = var_7_6

	var_7_6(var_7_1:Find("gold/after"), var_7_5.gold_store)

	setText = var_7_6

	var_7_6(var_7_1:Find("oil/before"), var_7_4.oil_store)

	setText = var_7_6

	var_7_6(var_7_1:Find("oil/after"), var_7_5.oil_store)

	setText = var_7_6

	local var_7_9 = var_7_1:Find("oil/name")

	i18n = var_10

	var_7_6(var_7_9, var_10("mail_oil_res"))

	setText = var_7_6

	local var_7_10 = var_7_1:Find("gold/name")

	i18n = var_10

	var_7_6(var_7_10, var_10("mail_gold_res"))

	setActive = var_7_6

	var_7_6(var_7_1:Find("price/price_diamond"), var_7_7)

	setText = var_7_6

	local var_7_11 = var_7_1:Find("price/price_diamond/Text")
	local var_7_12

	if not var_7_7 or not var_7_7.count then
		var_7_12 = 0
	end

	var_7_6(var_7_11, var_7_12)

	setActive = var_7_6

	var_7_6(var_7_1:Find("price/price_gold"), var_7_8)

	setText = var_7_6

	local var_7_13 = var_7_1:Find("price/price_gold/Text")
	local var_7_14

	if not var_7_8 or not var_7_8.count then
		var_7_14 = 0
	end

	var_7_6(var_7_13, var_7_14)

	setActive = var_7_6

	var_7_6(var_7_1:Find("price/line"), var_7_7 and var_7_8)

	setActive = var_7_6

	var_7_6(arg_7_0.btnDiamond, var_7_7)

	setActive = var_7_6

	var_7_6(arg_7_0.btnGold, var_7_8)

	return
end

function var_0_1.Show(arg_8_0)
	var_0_1.super.Show(arg_8_0)

	pg = var_1

	local var_8_0 = var_1.UIMgr.GetInstance()

	var_1.BlurPanel(var_8_0, arg_8_0._tf)
	arg_8_0:UpdateInfo()

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
