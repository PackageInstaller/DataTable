class = var_0_10000

local var_0_0 = "ChargeActGiftLayer"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.BaseUI"))

function var_0_1.getUIName(arg_1_0)
	return "ChargeIActGiftUI"
end

function var_0_1.preload(arg_2_0, arg_2_1)
	getProxy = var_1_10002
	ActivityProxy = var_1_10003

	local var_2_0 = var_1_10002(var_1_10003)
	local var_2_1 = var_2.getActivityById(var_2_0, arg_2_0.contextData.actId)
	local var_2_2 = {}

	if var_2_1 and not var_2_1:isEnd() then
		arg_2_0.spriteDic = {
			name = {},
			icon = {}
		}
		ipairs = var_4

		for iter_2_0, iter_2_1 in var_4(var_2_1:getConfig("config_data")[1]) do
			table = var_1_10009

			var_1_10009.insert(var_2_2, function(arg_3_0)
				LoadSpriteAtlasAsync = var_2_10001

				var_2_10001("actgiftpackages/skin_card_name_" .. iter_2_1, "", function(arg_4_0)
					arg_2_0.spriteDic.name[iter_2_1] = arg_4_0

					arg_3_0()

					return
				end)

				return
			end)

			table = var_1_10009

			var_1_10009.insert(var_2_2, function(arg_5_0)
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

	parallelAsync = var_4

	var_4(var_2_2, arg_2_1)

	return
end

function var_0_1.init(arg_7_0)
	setText = var_1_10001

	local var_7_0 = arg_7_0.rtTip
	local var_7_1 = var_2.Find(var_7_0, "Text")

	i18n = var_7_0

	var_1_10001(var_7_1, var_7_0("black5_bundle_desc"))

	setText = var_1_10001

	local var_7_2 = arg_7_0.rtAward
	local var_7_3 = var_2.Find(var_7_2, "word/Text")

	i18n = var_7_2

	var_1_10001(var_7_3, var_7_2("black5_bundle_tip"))

	setText = var_1_10001

	local var_7_4 = arg_7_0.btnPay
	local var_7_5 = var_2.Find(var_7_4, "Text")

	i18n = var_7_4

	var_1_10001(var_7_5, var_7_4("black5_bundle_buy_all"))

	setText = var_1_10001

	local var_7_6 = arg_7_0.btnGet
	local var_7_7 = var_2.Find(var_7_6, "Text")

	i18n = var_7_6

	var_1_10001(var_7_7, var_7_6("black5_bundle_receive"))
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

	SFX_CANCEL = var_1_10005

	var_1_10001(var_8_0, var_8_1, var_8_2, var_1_10005)

	onButton = var_1_10001

	local var_8_3 = arg_8_0
	local var_8_4 = arg_8_0.rtTip

	local function var_8_5()
		pg = var_2_10000

		local var_10_0 = var_2_10000.MsgboxMgr.GetInstance()
		local var_10_1 = var_0.ShowMsgBox
		local var_10_2 = {}

		MSGBOX_TYPE_HELP = var_2_10003
		var_10_2.type = var_2_10003
		i18n = var_2_10003
		var_10_2.helps = var_2_10003("black5_bundle_help")

		var_10_1(var_10_0, var_10_2)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_8_3, var_8_4, var_8_5, var_1_10005)

	getProxy = var_1_10001
	ActivityProxy = var_8_3

	local var_8_6 = var_1_10001(var_8_3)
	local var_8_7 = var_1.getActivityById(var_8_6, arg_8_0.contextData.actId)
	local var_8_8 = var_1.getConfig(var_8_7, "config_data")[1]

	UIItemList = var_8_7

	var_8_7.StaticAlign(arg_8_0.rtContainer, arg_8_0.rtSkinTpl, #var_8_8, function(arg_11_0, arg_11_1, arg_11_2)
		arg_11_1 = arg_11_1 + 1
		UIItemList = var_2_10003

		if arg_11_0 == var_2_10003.EventUpdate then
			local var_11_0 = var_8_8[arg_11_1]

			setImageSprite = var_2_10004

			var_2_10004(arg_11_2:Find("name"), arg_8_0.spriteDic.name[var_11_0])

			setImageSprite = var_2_10004

			var_2_10004(arg_11_2, arg_8_0.spriteDic.icon[var_11_0])

			getProxy = var_2_10004
			ShipSkinProxy = var_5

			local var_11_1 = var_2_10004(var_5)
			local var_11_2 = var_4.hasNonLimitSkin(var_11_1, var_11_0)

			setActive = var_11_1

			var_11_1(arg_11_2:Find("btn_skin"), not var_11_2)

			setActive = var_11_1

			var_11_1(arg_11_2:Find("got"), var_11_2)

			local var_11_3

			if var_11_2 then
				setText = var_11_1
				var_11_3 = arg_11_2

				local var_11_4 = arg_11_2.Find(var_11_3, "got/Text")

				i18n = var_11_3

				var_11_1(var_11_4, var_11_3("black5_bundle_purchased"))
			else
				Goods = var_11_1

				local var_11_5 = var_11_1.Create
				local var_11_6 = {}

				pg = var_11_3
				var_11_6.id = var_11_3.ship_skin_template[var_11_0].shop_id
				Goods = var_7

				local var_11_7 = var_11_5(var_11_6, var_7.TYPE_SKIN)
				local var_11_8 = var_5.getConfig(var_11_7, "resource_num")

				setText = var_11_7

				var_11_7(arg_11_2:Find("btn_skin/price/Text"), var_11_8)

				onButton = var_11_7

				local var_11_9 = arg_8_0
				local var_11_10 = arg_11_2:Find("btn_skin")

				local function var_11_11()
					local var_12_0 = arg_8_0
					local var_12_1 = var_0.emit

					ChargeActGiftMediator = var_3_10002

					var_12_1(var_12_0, var_3_10002.GO_SHOP, var_11_0)

					return
				end

				SFX_PANEL = var_11

				var_11_7(var_11_9, var_11_10, var_11_11, var_11)
			end
		end

		return
	end)

	Drop = var_3

	local var_8_9 = var_3.Create(var_1:GetConfigClientSetting("drop"))

	updateDrop = var_4

	local var_8_10 = arg_8_0.rtAward

	var_4(var_5.Find(var_8_10, "icon/bg/IconTpl"), var_8_9)

	onButton = var_4

	local var_8_11 = arg_8_0
	local var_8_12 = arg_8_0.rtAward
	local var_8_13 = var_6.Find(var_8_12, "icon")

	local function var_8_14()
		local var_13_0 = arg_8_0
		local var_13_1 = var_0.emit

		BaseUI = var_2_10002

		var_13_1(var_13_0, var_2_10002.ON_DROP, var_8_9)

		return
	end

	SFX_PANEL = var_8

	var_4(var_8_11, var_8_13, var_8_14, var_8)

	GiftActCommodity = var_4

	local var_8_15, var_8_16, var_8_17 = var_4.CalcPrice(var_1)

	setActive = var_8_14

	local var_8_18 = arg_8_0.rtAward

	var_8_14(var_8.Find(var_8_18, "word"), var_8_15 > 0)

	setActive = var_8_14

	var_8_14(arg_8_0.btnPay, var_8_15 > 0)

	setActive = var_8_14

	var_8_14(arg_8_0.btnGet, var_8_15 == 0)

	if 0 < var_8_15 then
		setActive = var_7

		local var_8_19 = arg_8_0.btnPay

		var_7(var_8.Find(var_8_19, "price/old"), var_8_15 < var_8_17)

		setText = var_7

		local var_8_20 = arg_8_0.btnPay
		local var_8_21 = var_8.Find(var_8_20, "price/old")

		string = var_8_20

		var_7(var_8_21, var_8_20.format("<material=strike>%d</material>", var_8_17))

		setText = var_7

		local var_8_22 = arg_8_0.btnPay

		var_7(var_8.Find(var_8_22, "price/price"), var_8_15)

		onButton = var_7

		local var_8_23 = arg_8_0
		local var_8_24 = arg_8_0.btnPay

		local function var_8_25()
			Drop = var_2_10000

			local var_14_0 = var_2_10000.New
			local var_14_1 = {}

			DROP_TYPE_RESOURCE = var_2_10002
			var_14_1.type = var_2_10002
			PlayerConst = var_2_10002
			var_14_1.id = var_2_10002.ResDiamond
			var_14_1.count = var_8_15

			local var_14_2 = var_14_0(var_14_1).count
			local var_14_3 = var_0

			if var_14_2 > var_0.getOwnedCount(var_14_3) then
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

			var_14_6.shop_id = var_3.GetConfigClientSetting(var_14_7, "packageID")
			Goods = var_3

			local var_14_8 = var_14_5(var_14_6, var_3.TYPE_GIFT_PACKAGE_ACT)

			pg = var_14_6

			local var_14_9 = var_14_6.MsgboxMgr.GetInstance()
			local var_14_10 = var_2.ShowMsgBox
			local var_14_11 = {}

			i18n = var_5
			var_14_11.content = var_5("black5_bundle_popup", var_0.count, var_14_8:GetName())

			function var_14_11.onYes()
				local var_15_0 = arg_8_0
				local var_15_1 = var_0.emit

				ChargeActGiftMediator = var_3_10002

				var_15_1(var_15_0, var_3_10002.DO_PAY)

				return
			end

			var_14_10(var_14_9, var_14_11)

			return
		end

		SFX_CONFIRM = var_1_10011

		var_7(var_8_23, var_8_24, var_8_25, var_1_10011)
	else
		onButton = var_7

		local var_8_26 = arg_8_0
		local var_8_27 = arg_8_0.btnGet

		local function var_8_28()
			local var_16_0 = arg_8_0
			local var_16_1 = var_0.emit

			ChargeActGiftMediator = var_2_10002

			var_16_1(var_16_0, var_2_10002.DO_PAY)

			return
		end

		SFX_CONFIRM = var_1_10011

		var_7(var_8_26, var_8_27, var_8_28, var_1_10011)
	end

	return
end

function var_0_1.willExit(arg_17_0)
	arg_17_0:UnOverlayPanel(arg_17_0._tf)

	return
end

return var_0_1
