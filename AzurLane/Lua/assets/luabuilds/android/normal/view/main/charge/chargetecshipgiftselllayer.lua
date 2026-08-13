class = var_0_10000

local var_0_0 = "ChargeTecShipGiftSellLayer"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("...base.BaseUI"))

function var_0_1.getUIName(arg_1_0)
	return "ChargeTecShipGiftSellLayer"
end

function var_0_1.init(arg_2_0)
	arg_2_0:initData()
	arg_2_0:findUI()
	arg_2_0:addListener()
	arg_2_0:initUIText()

	return
end

function var_0_1.didEnter(arg_3_0)
	pg = var_1_10001

	local var_3_0 = var_1_10001.UIMgr.GetInstance()

	var_1.BlurPanel(var_3_0, arg_3_0._tf)
	arg_3_0:updateGiftList()

	return
end

function var_0_1.willExit(arg_4_0)
	pg = var_1_10001

	local var_4_0 = var_1_10001.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_4_0, arg_4_0._tf)

	return
end

function var_0_1.initData(arg_5_0)
	arg_5_0.showGoodVO = arg_5_0.contextData.showGoodVO
	arg_5_0.chargedList = arg_5_0.contextData.chargedList

	local var_5_0 = arg_5_0.showGoodVO

	arg_5_0.goodVOList = var_1.getSameLimitGroupTecGoods(var_5_0)
	arg_5_0.normalGoodVO = nil
	arg_5_0.highGoodVO = nil
	arg_5_0.upGoodVO = nil
	ipairs = var_1

	for iter_5_0, iter_5_1 in var_1(arg_5_0.goodVOList) do
		if iter_5_1:getConfig("limit_arg") == 1 then
			arg_5_0.highGoodVO = iter_5_1
		elseif iter_5_1:getConfig("limit_arg") == 2 then
			arg_5_0.normalGoodVO = iter_5_1
		elseif iter_5_1:getConfig("limit_arg") == 3 then
			arg_5_0.upGoodVO = iter_5_1
		end
	end

	arg_5_0.goodVOShowList = {}
	ChargeConst = var_1

	local var_5_1 = var_1.getBuyCount(arg_5_0.chargedList, arg_5_0.normalGoodVO.id)

	ChargeConst = var_2

	local var_5_2 = var_2.getBuyCount(arg_5_0.chargedList, arg_5_0.highGoodVO.id)

	ChargeConst = var_3

	local var_5_3 = var_3.getBuyCount(arg_5_0.chargedList, arg_5_0.upGoodVO.id)

	if var_5_1 == 0 and var_5_2 == 0 and var_5_3 == 0 then
		table = var_4

		var_4.insert(arg_5_0.goodVOShowList, arg_5_0.normalGoodVO)

		table = var_4

		var_4.insert(arg_5_0.goodVOShowList, arg_5_0.highGoodVO)
	elseif 0 < var_5_1 and var_5_2 == 0 and var_5_3 == 0 then
		table = var_4

		var_4.insert(arg_5_0.goodVOShowList, arg_5_0.normalGoodVO)

		table = var_4

		var_4.insert(arg_5_0.goodVOShowList, arg_5_0.upGoodVO)
	elseif (not (var_5_1 > 0) or not (var_5_3 > 0)) and var_5_2 > 0 then
		-- block empty
	end

	return
end

function var_0_1.initUIText(arg_6_0)
	local var_6_0 = arg_6_0._tf
	local var_6_1

	var_6_1, setText = var_1.Find(var_6_0, "Adapt/TipBG/Text"), var_6_0
	i18n = var_1_10004

	var_6_0(var_6_1, var_1_10004("tech_package_tip"))

	return
end

function var_0_1.findUI(arg_7_0)
	local var_7_0 = arg_7_0._tf

	arg_7_0.bg = var_1.Find(var_7_0, "BG")

	local var_7_1 = arg_7_0._tf

	arg_7_0.itemTpl = var_1.Find(var_7_1, "ItemTpl")

	local var_7_2 = arg_7_0._tf

	arg_7_0.giftTpl = var_1.Find(var_7_2, "GiftTpl")

	local var_7_3 = arg_7_0._tf

	arg_7_0.giftContainer = var_1.Find(var_7_3, "List")
	UIItemList = var_1
	arg_7_0.giftUIItemList = var_1.New(arg_7_0.giftContainer, arg_7_0.giftTpl)

	local var_7_4 = arg_7_0.giftUIItemList

	var_1.make(var_7_4, function(arg_8_0, arg_8_1, arg_8_2)
		UIItemList = var_2_10003

		if arg_8_0 == var_2_10003.EventUpdate then
			arg_8_1 = arg_8_1 + 1

			local var_8_0 = arg_7_0.goodVOShowList[arg_8_1]
			local var_8_1 = arg_7_0

			var_4.updateGiftTF(var_8_1, arg_8_2, var_8_0)
		end

		return
	end)

	return
end

function var_0_1.addListener(arg_9_0)
	onButton = var_1_10001

	local var_9_0 = arg_9_0
	local var_9_1 = arg_9_0.bg

	local function var_9_2()
		local var_10_0 = arg_9_0

		var_0.closeView(var_10_0)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_9_0, var_9_1, var_9_2, var_1_10005)

	return
end

function var_0_1.updateGiftTF(arg_11_0, arg_11_1, arg_11_2)
	local var_11_0 = arg_11_1:Find("BG/Normal")
	local var_11_1 = arg_11_1:Find("BG/Special")
	local var_11_2 = arg_11_1:Find("Buy/Normal")
	local var_11_3 = arg_11_1:Find("Buy/Special")
	local var_11_4 = arg_11_1:Find("Buy/Up")
	local var_11_5 = arg_11_1:Find("Buy/Disable")
	local var_11_6 = arg_11_1:Find("Title")
	local var_11_7 = arg_11_1:Find("GiftImage")
	local var_11_8 = arg_11_1:Find("Desc1")
	local var_11_9 = arg_11_1:Find("Desc2")
	local var_11_10 = arg_11_1:Find("List")
	local var_11_11 = arg_11_2:getConfig("limit_arg") == 1
	local var_11_12 = arg_11_2:getConfig("limit_arg") == 2
	local var_11_13 = arg_11_2
	local var_11_14 = arg_11_2.getConfig(var_11_13, "limit_arg") == 3

	ChargeConst = var_11_13

	local var_11_15 = var_11_13.getBuyCount(arg_11_0.chargedList, arg_11_0.normalGoodVO.id)
	local var_11_16 = 0 < var_11_15

	setActive = var_18

	var_18(var_11_0, var_11_12)

	setActive = var_18

	var_18(var_11_1, not var_11_12)

	setActive = var_18

	var_18(var_11_2, var_11_12 and not var_11_16)

	setActive = var_18

	var_18(var_11_3, var_11_11)

	setActive = var_18

	var_18(var_11_4, var_11_14)

	setActive = var_18

	var_18(var_11_5, var_11_12 and var_11_16)

	if var_11_12 and var_11_16 then
		setGray = var_18

		var_18(arg_11_1, true, true)
	end

	local function var_11_17()
		pg = var_2_10000

		local var_12_0 = var_2_10000.m02
		local var_12_1 = var_0.sendNotification

		GAME = var_2_10002

		var_12_1(var_12_0, var_2_10002.CHARGE_OPERATION, {
			shopId = arg_11_2.id
		})

		local var_12_2 = arg_11_0

		var_0.closeView(var_12_2)

		return
	end

	onButton = var_19

	local var_11_18 = arg_11_0
	local var_11_19 = var_11_2

	local function var_11_20()
		var_11_17()

		return
	end

	SFX_PANEL = var_1_10023

	var_19(var_11_18, var_11_19, var_11_20, var_1_10023)

	onButton = var_19

	local var_11_21 = arg_11_0
	local var_11_22 = var_11_3

	local function var_11_23()
		var_11_17()

		return
	end

	SFX_PANEL = var_1_10023

	var_19(var_11_21, var_11_22, var_11_23, var_1_10023)

	onButton = var_19

	local var_11_24 = arg_11_0
	local var_11_25 = var_11_4

	local function var_11_26()
		var_11_17()

		return
	end

	SFX_PANEL = var_1_10023

	var_19(var_11_24, var_11_25, var_11_26, var_1_10023)

	setText = var_19

	var_19(var_11_6, arg_11_2:getConfig("name_display"))

	setText = var_19

	var_19(var_11_8, arg_11_2:getConfig("descrip"))

	setText = var_19

	var_19(var_11_9, arg_11_2:getConfig("descrip_extra"))

	setImageSprite = var_19

	local var_11_27 = var_11_7

	LoadSprite = var_21

	var_19(var_11_27, var_21("chargeicon/" .. arg_11_2:getConfig("picture")), true)

	local var_11_28 = {}

	ipairs = var_11_27

	for iter_11_0, iter_11_1 in var_11_27(arg_11_2:getConfig("display")) do
		table = var_11_29

		local var_11_29 = var_11_29.insert
		local var_11_30 = var_11_28

		Drop = var_1_10027

		var_11_29(var_11_30, var_1_10027.Create(iter_11_1))
	end

	UIItemList = var_20

	local var_11_31 = var_20.New(var_11_10, arg_11_0.itemTpl)

	var_20.make(var_11_31, function(arg_16_0, arg_16_1, arg_16_2)
		UIItemList = var_2_10003

		if arg_16_0 == var_2_10003.EventUpdate then
			local var_16_0 = arg_16_2:Find("Container")
			local var_16_1 = var_3.GetChild(var_16_0, 0)
			local var_16_2 = arg_16_2:Find("TextMask/Text")

			arg_16_1 = arg_16_1 + 1

			local var_16_3 = var_11_28[arg_16_1]

			updateDrop = var_7

			var_7(var_16_1, var_16_3)

			onButton = var_7

			local var_16_4 = arg_11_0
			local var_16_5 = var_16_1

			local function var_16_6()
				local var_17_0 = arg_11_0
				local var_17_1 = var_0.emit

				BaseUI = var_3_10002

				var_17_1(var_17_0, var_3_10002.ON_DROP, var_16_3)

				return
			end

			SFX_PANEL = var_2_10011

			var_7(var_16_4, var_16_5, var_16_6, var_2_10011)

			setScrollText = var_7

			var_7(var_16_2, var_16_3:getName())
		end

		return
	end)
	var_20:align(#var_11_28)

	return
end

function var_0_1.updateGiftList(arg_18_0)
	local var_18_0 = arg_18_0.giftUIItemList

	var_1.align(var_18_0, #arg_18_0.goodVOShowList)

	return
end

return var_0_1
