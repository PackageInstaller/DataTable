class = var_0_10000

local var_0_0 = "ChargeActGiftLayer"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.BaseUI"))

function var_0_1.getUIName(arg_1_0)
	return "ChargeIActGiftUI"
end

function var_0_1.preload(arg_2_0, arg_2_1)
	getProxy = var_1_10002
	ActivityProxy = var_1_10004

	local var_2_0 = var_1_10002(var_1_10004)
	local var_2_1 = var_2.getActivityById(var_2_0, arg_2_0.contextData.actId)
	local var_2_2 = {}

	if var_2_1 and not var_2_1:isEnd() then
		arg_2_0.spriteDic = {
			name = {},
			icon = {}
		}
		ipairs = var_2_0

		for iter_2_0, iter_2_1 in var_2_0(var_2_1:getConfig("config_data")[1]) do
			table = var_9

			var_9.insert(var_2_2, function(arg_3_0)
				LoadSpriteAtlasAsync = var_2_10001

				var_2_10001("actgiftpackages/skin_card_name_" .. iter_2_1, "", function(arg_4_0)
					arg_2_0.spriteDic.name[iter_2_1] = arg_4_0

					arg_3_0()

					return
				end)

				return
			end)

			table = var_9

			var_9.insert(var_2_2, function(arg_5_0)
				LoadSpriteAtlasAsync = var_2_10001

				var_2_10001("actgiftpackages/skin_card_" .. iter_2_1, "", function(arg_6_0)
					arg_2_0.spriteDic.icon[iter_2_1] = arg_6_0

					arg_5_0()

					return
				end)

				return
			end)
		end
	end

	parallelAsync = var_2_0

	var_2_0(var_2_2, arg_2_1)

	return
end

function var_0_1.init(arg_7_0)
	setText = var_1_10001

	local var_7_0 = arg_7_0.rtTip
	local var_7_1 = var_3.Find(var_7_0, "Text")

	i18n = var_1_10004

	var_1_10001(var_7_1, var_1_10004("black5_bundle_desc"))

	setText = var_1_10001

	local var_7_2 = arg_7_0.rtAward
	local var_7_3 = var_3.Find(var_7_2, "word/Text")

	i18n = var_4

	var_1_10001(var_7_3, var_4("black5_bundle_tip"))

	setText = var_1_10001

	local var_7_4 = arg_7_0.btnPay
	local var_7_5 = var_3.Find(var_7_4, "Text")

	i18n = var_4

	var_1_10001(var_7_5, var_4("black5_bundle_buy_all"))

	setText = var_1_10001

	local var_7_6 = arg_7_0.btnGet
	local var_7_7 = var_3.Find(var_7_6, "Text")

	i18n = var_4

	var_1_10001(var_7_7, var_4("black5_bundle_receive"))
	arg_7_0:BlurPanel(arg_7_0._tf)

	return
end

function var_0_1.didEnter(arg_8_0)
	onButton = var_1_10001

	local var_8_0 = arg_8_0
	local var_8_1 = arg_8_0.rtBg

	local function var_8_2()
		local var_9_0 = arg_8_0

		var_0.closeView(var_9_0)

		return
	end

	SFX_CANCEL = var_1_10006

	var_1_10001(var_8_0, var_8_1, var_8_2, var_1_10006)

	onButton = var_1_10001

	local var_8_3 = arg_8_0
	local var_8_4 = arg_8_0.rtTip

	local function var_8_5()
		pg = var_2_10000

		local var_10_0 = var_2_10000.MsgboxMgr.GetInstance()
		local var_10_1 = var_0.ShowMsgBox
		local var_10_2 = {}

		MSGBOX_TYPE_HELP = var_2_10004
		var_10_2.type = var_2_10004
		i18n = var_2_10004
		var_10_2.helps = var_2_10004("black5_bundle_help")

		var_10_1(var_10_0, var_10_2)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_8_3, var_8_4, var_8_5, var_1_10006)

	getProxy = var_1_10001
	ActivityProxy = var_8_3

	local var_8_6 = var_1_10001(var_8_3)
	local var_8_7 = var_1.getActivityById(var_8_6, arg_8_0.contextData.actId)
	local var_8_8 = var_1.getConfig(var_8_7, "config_data")[1]

	UIItemList = var_8_6

	var_8_6.StaticAlign(arg_8_0.rtContainer, arg_8_0.rtSkinTpl, #var_8_8, function(arg_11_0, arg_11_1, arg_11_2)
		arg_11_1 = arg_11_1 + 1
		UIItemList = var_2_10003

		if arg_11_0 == var_2_10003.EventUpdate then
			local var_11_0 = var_8_8[arg_11_1]

			setImageSprite = var_2_10004

			var_2_10004(arg_11_2:Find("name"), arg_8_0.spriteDic.name[var_11_0])

			setImageSprite = var_2_10004

			var_2_10004(arg_11_2, arg_8_0.spriteDic.icon[var_11_0])

			getProxy = var_2_10004
			ShipSkinProxy = var_6

			local var_11_1 = var_2_10004(var_6)
			local var_11_2 = var_4.hasNonLimitSkin(var_11_1, var_11_0)

			setActive = var_2_10005

			var_2_10005(arg_11_2:Find("btn_skin"), not var_11_2)

			setActive = var_2_10005

			var_2_10005(arg_11_2:Find("got"), var_11_2)

			if var_11_2 then
				setText = var_2_10005

				local var_11_3 = arg_11_2:Find("got/Text")

				i18n = var_8

				var_2_10005(var_11_3, var_8("black5_bundle_purchased"))
			else
				Goods = var_2_10005

				local var_11_4 = var_2_10005.Create
				local var_11_5 = {}

				pg = var_8
				var_11_5.id = var_8.ship_skin_template[var_11_0].shop_id
				Goods = var_8

				local var_11_6 = var_11_4(var_11_5, var_8.TYPE_SKIN)
				local var_11_7 = var_5.getConfig(var_11_6, "resource_num")

				setText = var_11_5

				var_11_5(arg_11_2:Find("btn_skin/price/Text"), var_11_7)

				onButton = var_11_5

				local var_11_8 = arg_8_0
				local var_11_9 = arg_11_2
				local var_11_10 = arg_11_2.Find(var_11_9, "btn_skin")

				local function var_11_11()
					local var_12_0 = arg_8_0
					local var_12_1 = var_0.emit

					ChargeActGiftMediator = var_3_10003

					var_12_1(var_12_0, var_3_10003.GO_SHOP, var_11_0)

					return
				end

				SFX_PANEL = var_11_9

				var_11_5(var_11_8, var_11_10, var_11_11, var_11_9)
			end
		end

		return
	end)

	Drop = var_3

	local var_8_9 = var_3.Create(var_1:GetConfigClientSetting("drop"))

	updateDrop = var_8_7

	local var_8_10 = arg_8_0.rtAward

	var_8_7(var_6.Find(var_8_10, "icon/bg/IconTpl"), var_8_9)

	onButton = var_8_7

	local var_8_11 = arg_8_0
	local var_8_12 = arg_8_0.rtAward
	local var_8_13 = var_7.Find(var_8_12, "icon")

	local function var_8_14()
		local var_13_0 = arg_8_0
		local var_13_1 = var_0.emit

		BaseUI = var_2_10003

		var_13_1(var_13_0, var_2_10003.ON_DROP, var_8_9)

		return
	end

	SFX_PANEL = var_8_12

	var_8_7(var_8_11, var_8_13, var_8_14, var_8_12)

	GiftActCommodity = var_8_7

	local var_8_15, var_8_16, var_8_17 = var_8_7.CalcPrice(var_1)

	setActive = var_8_13

	local var_8_18 = arg_8_0.rtAward

	var_8_13(var_9.Find(var_8_18, "word"), var_8_15 > 0)

	setActive = var_8_13

	var_8_13(arg_8_0.btnPay, var_8_15 > 0)

	setActive = var_8_13

	var_8_13(arg_8_0.btnGet, var_8_15 == 0)

	if 0 < var_8_15 then
		setActive = var_7

		local var_8_19 = arg_8_0.btnPay

		var_7(var_9.Find(var_8_19, "price/old"), var_8_15 < var_8_17)

		setText = var_7

		local var_8_20 = arg_8_0.btnPay
		local var_8_21 = var_9.Find(var_8_20, "price/old")

		string = var_10

		var_7(var_8_21, var_10.format("<material=strike>%d</material>", var_8_17))

		setText = var_7

		local var_8_22 = arg_8_0.btnPay

		var_7(var_9.Find(var_8_22, "price/price"), var_8_15)

		onButton = var_7

		local var_8_23 = arg_8_0
		local var_8_24 = arg_8_0.btnPay

		local function var_8_25()
			Drop = var_2_10000

			local var_14_0 = var_2_10000.New
			local var_14_1 = {}

			DROP_TYPE_RESOURCE = var_2_10003
			var_14_1.type = var_2_10003
			PlayerConst = var_2_10003
			var_14_1.id = var_2_10003.ResDiamond
			var_14_1.count = var_8_15

			local var_14_2 = var_14_0(var_14_1).count
			local var_14_3 = var_0

			if var_0.getOwnedCount(var_14_3) < var_14_2 then
				pg = var_14_2

				local var_14_4 = var_14_2.TipsMgr.GetInstance()

				var_14_2 = var_14_2.ShowTips
				i18n = var_14_3

				var_14_2(var_14_4, var_14_3("temple_consume_not_enough"))

				return
			end

			Goods = var_14_2

			local var_14_5 = var_14_2.Create
			local var_14_6 = {}
			local var_14_7 = var_0

			var_14_6.shop_id = var_4.GetConfigClientSetting(var_14_7, "packageID")
			Goods = var_4

			local var_14_8 = var_14_5(var_14_6, var_4.TYPE_GIFT_PACKAGE_ACT)

			pg = var_2

			local var_14_9 = var_2.MsgboxMgr.GetInstance()
			local var_14_10 = var_2.ShowMsgBox
			local var_14_11 = {}

			i18n = var_14_7
			var_14_11.content = var_14_7("black5_bundle_popup", var_0.count, var_14_8:GetName())

			function var_14_11.onYes()
				local var_15_0 = arg_8_0
				local var_15_1 = var_0.emit

				ChargeActGiftMediator = var_3_10003

				var_15_1(var_15_0, var_3_10003.DO_PAY)

				return
			end

			var_14_10(var_14_9, var_14_11)

			return
		end

		SFX_CONFIRM = var_12

		var_7(var_8_23, var_8_24, var_8_25, var_12)
	else
		onButton = var_7

		local var_8_26 = arg_8_0
		local var_8_27 = arg_8_0.btnGet

		local function var_8_28()
			local var_16_0 = arg_8_0
			local var_16_1 = var_0.emit

			ChargeActGiftMediator = var_2_10003

			var_16_1(var_16_0, var_2_10003.DO_PAY)

			return
		end

		SFX_CONFIRM = var_12

		var_7(var_8_26, var_8_27, var_8_28, var_12)
	end

	return
end

function var_0_1.willExit(arg_17_0)
	arg_17_0:UnOverlayPanel(arg_17_0._tf)

	return
end

return var_0_1
