class = var_0_10000

local var_0_0 = "ChargeScene"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("..base.BaseUI"))

function var_0_1.getUIName(arg_1_0)
	return "BackChargeUI"
end

function var_0_1.init(arg_2_0)
	return
end

function var_0_1.didEnter(arg_3_0)
	findTF = var_1_10001
	arg_3_0.diamondPanel = var_1_10001(arg_3_0._tf, "frame/viewContainer/diamondPanel")

	local var_3_0 = arg_3_0._tf

	arg_3_0.blurPanel = var_1.Find(var_3_0, "blur_panel")

	local var_3_1 = arg_3_0.blurPanel

	arg_3_0.detail = var_1.Find(var_3_1, "detail")
	arg_3_0.damondItems = {}
	setText = var_1
	findTF = var_3_1

	local var_3_2 = var_3_1(arg_3_0._tf, "frame/viewContainer/leftPanel/desc")

	i18n = var_4

	var_1(var_3_2, var_4("Supplement_pay2"))

	setText = var_1
	findTF = var_3_2

	local var_3_3 = var_3_2(arg_3_0._tf, "tip")

	i18n = var_4

	var_1(var_3_3, var_4("Supplement_pay5"))
	arg_3_0:initDamonds()
	arg_3_0:refundUpdate()

	return
end

function var_0_1.refundUpdate(arg_4_0)
	arg_4_0:updateDamondsData()
	arg_4_0:sortDamondItems()

	if #arg_4_0.tempDamondVOs <= 0 then
		pg = var_1

		local var_4_0 = var_1.MsgboxMgr.GetInstance()
		local var_4_1 = var_1.ShowMsgBox
		local var_4_2 = {
			modal = true,
			hideNo = true,
			hideClose = true
		}

		i18n = var_1_10005
		var_4_2.content = var_1_10005("Supplement_pay3")

		function var_4_2.onYes()
			Application = var_2_10000

			var_2_10000.Quit()

			return
		end

		var_4_1(var_4_0, var_4_2)
	end

	return
end

function var_0_1.setPlayer(arg_6_0, arg_6_1)
	arg_6_0.player = arg_6_1

	return
end

function var_0_1.setChargedList(arg_7_0, arg_7_1)
	arg_7_0.chargedList = arg_7_1

	return
end

function var_0_1.initDamonds(arg_8_0)
	arg_8_0.diamondUIItemList = arg_8_0:initDiamondList(arg_8_0.diamondPanel)

	return
end

function var_0_1.confirm(arg_9_0, arg_9_1)
	if not arg_9_1 then
		return
	end

	local var_9_0 = arg_9_0
	local var_9_1 = arg_9_0.emit

	BackChargeMediator = var_1_10005

	var_9_1(var_9_0, var_1_10005.CHARGE, arg_9_1.id)

	return
end

function var_0_1.initDiamondList(arg_10_0, arg_10_1)
	local var_10_0 = arg_10_1:Find("content")
	local var_10_1 = arg_10_1:Find("ItemTpl")

	local function var_10_2(arg_11_0)
		BackChargeDiamondCard = var_2_10001

		local var_11_0 = var_2_10001.New(arg_11_0, arg_10_0)

		onButton = var_2_10002

		local var_11_1 = arg_10_0
		local var_11_2 = var_11_0.tr

		local function var_11_3()
			local var_12_0 = arg_10_0

			var_0.confirm(var_12_0, var_11_0.goods)

			return
		end

		SFX_PANEL = var_2_10007

		var_2_10002(var_11_1, var_11_2, var_11_3, var_2_10007)

		arg_10_0.damondItems[arg_11_0] = var_11_0

		return
	end

	local function var_10_3(arg_13_0, arg_13_1)
		local var_13_0

		if not arg_10_0.damondItems[arg_13_1] then
			var_10_2(arg_13_1)

			var_13_0 = arg_10_0.damondItems[arg_13_1]
		end

		if arg_10_0.tempDamondVOs[arg_13_0 + 1] then
			var_13_0:update(var_3, arg_10_0.player, arg_10_0.firstChargeIds)
		end

		return
	end

	UIItemList = var_6

	local var_10_4 = var_6.New(var_10_0, var_10_1)

	var_6.make(var_10_4, function(arg_14_0, arg_14_1, arg_14_2)
		UIItemList = var_2_10003

		local var_14_0

		if arg_14_0 == var_2_10003.EventInit then
			var_14_0 = var_10_2
			go = var_2_10005

			var_14_0(var_2_10005(arg_14_2))
		else
			UIItemList = var_14_0

			if arg_14_0 == var_14_0.EventUpdate then
				local var_14_1 = var_10_3
				local var_14_2 = arg_14_1

				go = var_2_10006

				var_14_1(var_14_2, var_2_10006(arg_14_2))
			end
		end

		return
	end)

	return var_6
end

function var_0_1.updateDamondsData(arg_15_0)
	pg = var_1_10001

	local var_15_0 = var_1_10001.pay_data_display

	arg_15_0.damondItemVOs = {}
	getProxy = var_2
	UserProxy = var_1_10004

	local var_15_1 = var_2(var_1_10004)
	local var_15_2 = var_2.getData(var_15_1)

	getProxy = var_1_10004
	ServerProxy = var_1_10006

	local var_15_3 = var_1_10004(var_1_10006)

	getProxy = var_15_1
	PlayerProxy = var_1_10007

	local var_15_4 = var_15_1(var_1_10007)
	local var_15_5 = var_5.getRefundInfo(var_15_4)
	local var_15_6 = var_15_3:getLastServer(var_15_2.uid)

	var_15_5 = var_15_5 or {}

	for iter_15_0 = 1, #var_15_5 do
		Goods = var_1_10012
		var_1_10012 = var_1_10012.Create

		local var_15_7 = {
			shop_id = var_15_5[iter_15_0].shopId
		}

		Goods = var_15
		var_1_10012 = var_1_10012(var_15_7, var_15.TYPE_CHARGE)
		var_1_10012.buyTime = var_15_5[iter_15_0].buyTime
		var_1_10012.refundTime = var_15_5[iter_15_0].refundTime
		table = var_13

		var_13.insert(arg_15_0.damondItemVOs, var_1_10012)
	end

	return
end

function var_0_1.sortDamondItems(arg_16_0)
	if arg_16_0.damondItemVOs == nil then
		return
	end

	arg_16_0.tempDamondVOs = {}
	ipairs = var_1

	for iter_16_0, iter_16_1 in var_1(arg_16_0.damondItemVOs) do
		if iter_16_1:isChargeType() then
			iter_16_1:updateBuyCount(arg_16_0:getBuyCount(arg_16_0.chargedList, iter_16_1.id))

			table = var_6

			var_6.insert(arg_16_0.tempDamondVOs, iter_16_1)
		end
	end

	table = var_1

	var_1.sort(arg_16_0.tempDamondVOs, function(arg_17_0, arg_17_1)
		table = var_2_10002

		local var_17_0 = not var_2_10002.contains(arg_16_0.firstChargeIds, arg_17_0.id) and arg_17_0:firstPayDouble() and 1 or 0

		table = var_4

		local var_17_1 = not var_4.contains(arg_16_0.firstChargeIds, arg_17_1.id) and arg_17_1:firstPayDouble() and 1 or 0
		local var_17_2 = 0
		local var_17_3 = 0
		local var_17_4

		if var_17_2 ~= var_17_3 then
			return var_17_2 < var_17_3
		end

		local var_17_5 = arg_17_0:getConfig("tag") == 2 and 1 or 0
		local var_17_6 = arg_17_1:getConfig("tag") == 2 and 1 or 0

		if var_17_0 == var_17_1 and var_17_5 == var_17_6 then
			return arg_17_0.id < arg_17_1.id
		else
			return var_17_1 < var_17_0 or var_17_0 == var_17_1 and var_17_6 < var_17_5
		end

		return
	end)

	page = var_1

	if var_1 == var_0_1.TYPE_DIAMOND then
		local var_16_0 = arg_16_0.diamondUIItemList

		var_1.align(var_16_0, #arg_16_0.tempDamondVOs)
	else
		page = var_1

		if var_1 == var_0_1.TYPE_GIFT then
			local var_16_1 = arg_16_0.giftRect

			var_1.SetTotalCount(var_16_1, #arg_16_0.tempDamondVOs, arg_16_0.giftRect.value)
		end
	end

	return
end

function var_0_1.getBuyCount(arg_18_0, arg_18_1, arg_18_2)
	if not arg_18_1 then
		return 0
	end

	local var_18_0

	if not arg_18_1[arg_18_2] or not var_3.buyCount then
		var_18_0 = 0
	end

	return var_18_0
end

function var_0_1.showItemDetail(arg_19_0, arg_19_1)
	local var_19_0 = arg_19_1.icon
	local var_19_1

	if not arg_19_1.name or not arg_19_1.name then
		var_19_1 = ""
	end

	local var_19_2

	if not arg_19_1.tipBonus then
		var_19_2 = ""
	end

	local var_19_3 = arg_19_1.bonusItem
	local var_19_4

	if not arg_19_1.tipExtra or not arg_19_1.tipExtra then
		var_19_4 = ""
	end

	local var_19_5

	if not arg_19_1.extraItems or not arg_19_1.extraItems then
		var_19_5 = {}
	end

	local var_19_6

	if not arg_19_1.price or not arg_19_1.price then
		var_19_6 = 0
	end

	local var_19_7 = arg_19_1.isChargeType
	local var_19_8 = arg_19_1.isMonthCard
	local var_19_9 = arg_19_1.tagType
	local var_19_10 = arg_19_1.normalTip

	setActive = var_1_10013

	local var_19_11 = arg_19_0.detail

	var_1_10013(var_15.Find(var_19_11, "window2"), var_19_10)

	setActive = var_1_10013

	local var_19_12 = arg_19_0.detail

	var_1_10013(var_15.Find(var_19_12, "window"), not var_19_10)

	local var_19_13 = arg_19_0
	local var_19_14 = arg_19_0.bindDetailTF

	if var_19_10 then
		local var_19_15 = arg_19_0.detail
		local var_19_16

		if not var_16.Find(var_19_15, "window2") then
			var_19_15 = arg_19_0.detail
			var_19_16 = var_16.Find(var_19_15, "window")
		end

		var_19_14(var_19_13, var_19_16)

		if arg_19_0.detailNormalTip then
			setActive = var_13

			var_13(arg_19_0.detailNormalTip, var_19_10)
		end

		if arg_19_0.detailContain then
			setActive = var_13

			var_13(arg_19_0.detailContain, not var_19_10)
		end

		if var_19_10 then
			local var_19_17 = arg_19_0.detailNormalTip

			if var_13.GetComponent(var_19_17, "Text") then
				setText = var_13

				var_13(arg_19_0.detailNormalTip, var_19_10)
			else
				setButtonText = var_13

				var_13(arg_19_0.detailNormalTip, var_19_10)
			end
		end

		setActive = var_13

		var_13(arg_19_0.detailTag, var_19_9 > 0)

		if 0 < var_19_9 then
			ipairs = var_13

			for iter_19_0, iter_19_1 in var_13(arg_19_0.detailTags) do
				setActive = var_19_15

				var_19_15(iter_19_1, iter_19_0 == var_19_9)
			end
		end

		local var_19_18 = arg_19_0.detailIconTF

		GetSpriteFromAtlas = var_1_10014
		var_19_18.sprite = var_1_10014("chargeicon/1", "")
		LoadSpriteAsync = var_19_18

		var_19_18(var_19_0, function(arg_20_0)
			if arg_20_0 then
				arg_19_0.detailIconTF.sprite = arg_20_0
			end

			return
		end)

		setText = var_19_18

		var_19_18(arg_19_0.detailName, var_19_1)

		setActive = var_19_18

		var_19_18(arg_19_0.detailRmb, var_19_7)

		setActive = var_19_18

		var_19_18(arg_19_0.detailGem, not var_19_7)

		setText = var_19_18

		var_19_18(arg_19_0.detailPrice, var_19_6)

		if arg_19_0.detailDescExtra ~= nil then
			setActive = var_13

			local var_19_19 = arg_19_0.detailDescExtra
			local var_19_20

			if arg_19_1.descExtra then
				var_19_20 = arg_19_1.descExtra ~= ""
			end

			var_13(var_19_19, var_19_20)

			setText = var_13

			local var_19_21 = arg_19_0.detailDescExtra
			local var_19_22

			if not arg_19_1.descExtra then
				var_19_22 = ""
			end

			var_13(var_19_21, var_19_22)
		end

		local var_19_26

		if arg_19_0.detailContain then
			SetActive = var_19_26

			var_19_26(arg_19_0.normal, var_19_8)

			local var_19_25

			if var_19_8 then
				updateDrop = var_19_26

				var_19_26(arg_19_0.detailItem, var_19_3)

				onButton = var_19_26

				local var_19_23 = arg_19_0
				local var_19_24 = arg_19_0.detailItem

				function var_19_25()
					local var_21_0 = arg_19_0

					var_0.emit(var_21_0, var_0_1.ON_DROP, var_19_3)

					return
				end

				SFX_PANEL = var_19_15

				var_19_26(var_19_23, var_19_24, var_19_25, var_19_15)

				contentWrap = var_19_26
				var_19_25 = var_19_3

				local var_19_27

				var_19_26, var_19_27 = var_19_26(var_19_3.getConfig(var_19_25, "name"), 10, 2)

				if var_19_26 then
					var_19_27 = var_19_27 .. "..."
				end

				setText = var_15

				local var_19_28 = arg_19_0.detailItem

				var_15(var_19_25.Find(var_19_28, "name"), var_19_27)

				setText = var_15

				var_15(arg_19_0.detailTip, var_19_2)
			end

			setText = var_19_26

			var_19_26(arg_19_0.detailTip2, var_19_4)

			for iter_19_2 = #var_19_5, arg_19_0.detailItemList.childCount - 1 do
				Destroy = var_19_25

				local var_19_29 = arg_19_0.detailItemList

				var_19_25(var_19.GetChild(var_19_29, iter_19_2))
			end

			for iter_19_3 = arg_19_0.detailItemList.childCount, #var_19_5 - 1 do
				cloneTplTo = var_19_25

				var_19_25(arg_19_0.detailItem, arg_19_0.detailItemList)
			end

			for iter_19_4 = 1, #var_19_5 do
				local var_19_30 = arg_19_0.detailItemList
				local var_19_31 = var_17.GetChild(var_19_30, iter_19_4 - 1)

				updateDrop = var_19_15

				var_19_15(var_19_31, var_19_5[iter_19_4])

				contentWrap = var_19_15

				local var_19_32 = var_19_5[iter_19_4]
				local var_19_33

				var_19_15, var_19_33 = var_19_15(var_20.getConfig(var_19_32, "name"), 8, 2)

				if var_19_15 then
					var_19_33 = var_19_33 .. "..."
				end

				setText = var_20

				var_20(var_19_31:Find("name"), var_19_33)

				onButton = var_20

				local var_19_34 = arg_19_0
				local var_19_35 = var_19_31

				local function var_19_36()
					pg = var_2_10000

					local var_22_0 = var_2_10000.MsgboxMgr.GetInstance()
					local var_22_1 = var_0.ShowMsgBox
					local var_22_2 = {
						hideNo = true
					}

					MSGBOX_TYPE_SINGLE_ITEM = var_2_10004
					var_22_2.type = var_2_10004
					var_22_2.drop = var_19_5[iter_19_4]

					var_22_1(var_22_0, var_22_2)

					return
				end

				SFX_PANEL = var_25

				var_20(var_19_34, var_19_35, var_19_36, var_25)
			end
		end

		onButton = var_19_26

		local var_19_37 = arg_19_0
		local var_19_38 = arg_19_0.detail
		local var_19_39 = var_16.Find(var_19_38, "back_sign")

		local function var_19_40()
			SetActive = var_2_10000

			var_2_10000(arg_19_0.detail, false)

			local var_23_0 = arg_19_0

			var_0.revertDetailBlur(var_23_0)

			return
		end

		SFX_PANEL = var_19_38

		var_19_26(var_19_37, var_19_39, var_19_40, var_19_38)

		onButton = var_19_26

		local var_19_41 = arg_19_0
		local var_19_42 = arg_19_0.detailWindow
		local var_19_43 = var_16.Find(var_19_42, "button_container/button_cancel")

		local function var_19_44()
			SetActive = var_2_10000

			var_2_10000(arg_19_0.detail, false)

			local var_24_0 = arg_19_0

			var_0.revertDetailBlur(var_24_0)

			return
		end

		SFX_PANEL = var_19_42

		var_19_26(var_19_41, var_19_43, var_19_44, var_19_42)

		onButton = var_19_26

		local var_19_45 = arg_19_0
		local var_19_46 = arg_19_0.detailWindow
		local var_19_47 = var_16.Find(var_19_46, "button_container/button_ok")
		local var_19_48

		if not arg_19_1.onYes then
			function var_19_48()
				return
			end
		end

		SFX_PANEL = var_19_46

		var_19_26(var_19_45, var_19_47, var_19_48, var_19_46)

		setActive = var_19_26

		var_19_26(arg_19_0.detail, true)

		pg = var_19_26

		local var_19_49 = var_19_26.UIMgr.GetInstance()

		var_13.BlurPanel(var_19_49, arg_19_0.blurPanel)

		return
	end
end

function var_0_1.bindDetailTF(arg_26_0, arg_26_1)
	arg_26_0.detailWindow = arg_26_1

	local var_26_0 = arg_26_0.detailWindow

	arg_26_0.detailName = var_2.Find(var_26_0, "goods/name")

	local var_26_1 = arg_26_0.detailWindow

	arg_26_0.detailIcon = var_2.Find(var_26_1, "goods/icon")

	local var_26_2 = arg_26_0.detailIcon
	local var_26_3 = var_2.GetComponent

	typeof = var_5
	Image = var_1_10007
	arg_26_0.detailIconTF = var_26_3(var_26_2, var_5(var_1_10007))

	local var_26_4 = arg_26_0.detailWindow

	arg_26_0.detailRmb = var_2.Find(var_26_4, "prince_bg/contain/icon_rmb")

	local var_26_5 = arg_26_0.detailWindow

	arg_26_0.detailGem = var_2.Find(var_26_5, "prince_bg/contain/icon_gem")

	local var_26_6 = arg_26_0.detailWindow

	arg_26_0.detailPrice = var_2.Find(var_26_6, "prince_bg/contain/Text")

	local var_26_7 = arg_26_0.detailWindow

	arg_26_0.detailTag = var_2.Find(var_26_7, "goods/tag")
	arg_26_0.detailTags = {}
	table = var_2

	local var_26_8 = var_2.insert
	local var_26_9 = arg_26_0.detailTags
	local var_26_10 = arg_26_0.detailTag

	var_26_8(var_26_9, var_5.Find(var_26_10, "hot"))

	table = var_26_8

	local var_26_11 = var_26_8.insert
	local var_26_12 = arg_26_0.detailTags
	local var_26_13 = arg_26_0.detailTag

	var_26_11(var_26_12, var_5.Find(var_26_13, "new"))

	table = var_26_11

	local var_26_14 = var_26_11.insert
	local var_26_15 = arg_26_0.detailTags
	local var_26_16 = arg_26_0.detailTag

	var_26_14(var_26_15, var_5.Find(var_26_16, "advice"))

	table = var_26_14

	local var_26_17 = var_26_14.insert
	local var_26_18 = arg_26_0.detailTags
	local var_26_19 = arg_26_0.detailTag

	var_26_17(var_26_18, var_5.Find(var_26_19, "double"))

	table = var_26_17

	local var_26_20 = var_26_17.insert
	local var_26_21 = arg_26_0.detailTags
	local var_26_22 = arg_26_0.detailTag

	var_26_20(var_26_21, var_5.Find(var_26_22, "discount"))

	local var_26_23 = arg_26_0.detailTag

	arg_26_0.detailTagDoubleTF = var_2.Find(var_26_23, "double")

	local var_26_24 = arg_26_0.detailTag

	arg_26_0.detailTagAdviceTF = var_2.Find(var_26_24, "advice")

	local var_26_25 = arg_26_0.detailWindow

	arg_26_0.detailContain = var_2.Find(var_26_25, "container")

	if arg_26_0.detailContain then
		local var_26_26 = arg_26_0.detailWindow

		arg_26_0.extra = var_2.Find(var_26_26, "container/items")

		local var_26_27 = arg_26_0.extra

		arg_26_0.detailTip2 = var_2.Find(var_26_27, "Text")

		local var_26_28 = arg_26_0.extra

		arg_26_0.detailItemList = var_2.Find(var_26_28, "scrollview/list")

		local var_26_29 = arg_26_0.detailWindow

		arg_26_0.normal = var_2.Find(var_26_29, "container/normal_items")

		local var_26_30 = arg_26_0.normal

		arg_26_0.detailTip = var_2.Find(var_26_30, "Text")

		local var_26_31 = arg_26_0.normal

		arg_26_0.detailItem = var_2.Find(var_26_31, "item_tpl")

		local var_26_32 = arg_26_0.detailWindow

		arg_26_0.detailDescExtra = var_2.Find(var_26_32, "container/Text")
	end

	local var_26_33 = arg_26_0.detailWindow

	arg_26_0.detailNormalTip = var_2.Find(var_26_33, "NormalTips")

	return
end

function var_0_1.revertDetailBlur(arg_27_0)
	pg = var_1_10001

	local var_27_0 = var_1_10001.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_27_0, arg_27_0.blurPanel, arg_27_0._tf)

	return
end

function var_0_1.willExit(arg_28_0)
	arg_28_0:revertDetailBlur()

	return
end

function var_0_1.onBackPressed(arg_29_0)
	return
end

return var_0_1
