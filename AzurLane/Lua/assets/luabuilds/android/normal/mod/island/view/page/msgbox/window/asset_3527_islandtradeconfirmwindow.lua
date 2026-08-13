class = var_0_10000

local var_0_0 = "IslandTradeConfirmWindow"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".IslandBaseMsgboxWindow"))

function var_0_1.getUIName(arg_1_0)
	return "IslandTradeConfirmUI"
end

function var_0_1.OnLoaded(arg_2_0)
	local var_2_0 = arg_2_0._tf

	arg_2_0.panel = var_1.Find(var_2_0, "panel")

	local var_2_1 = arg_2_0.panel

	arg_2_0.closeBtn = var_1.Find(var_2_1, "closeBtn")

	local var_2_2 = arg_2_0.panel

	arg_2_0.icon = var_1.Find(var_2_2, "icon")

	local var_2_3 = arg_2_0.panel
	local var_2_4 = var_1.Find(var_2_3, "name")
	local var_2_5 = var_1.GetComponent

	typeof = var_3
	Text = var_1_10004
	arg_2_0.name = var_2_5(var_2_4, var_3(var_1_10004))

	local var_2_6 = arg_2_0.panel
	local var_2_7 = var_1.Find(var_2_6, "desc")
	local var_2_8 = var_1.GetComponent

	typeof = var_3
	Text = var_1_10004
	arg_2_0.desc = var_2_8(var_2_7, var_3(var_1_10004))

	local var_2_9 = arg_2_0.panel
	local var_2_10 = var_1.Find(var_2_9, "count/number_panel/value")
	local var_2_11 = var_1.GetComponent

	typeof = var_3
	Text = var_1_10004
	arg_2_0.count = var_2_11(var_2_10, var_3(var_1_10004))

	local var_2_12 = arg_2_0.panel

	arg_2_0.leftBtn = var_1.Find(var_2_12, "count/left")

	local var_2_13 = arg_2_0.panel

	arg_2_0.rightBtn = var_1.Find(var_2_13, "count/right")

	local var_2_14 = arg_2_0.panel

	arg_2_0.minBtn = var_1.Find(var_2_14, "count/min")

	local var_2_15 = arg_2_0.panel

	arg_2_0.maxBtn = var_1.Find(var_2_15, "count/max")
	UIItemList = var_1

	local var_2_16 = var_1.New
	local var_2_17 = arg_2_0.panel
	local var_2_18 = var_2.Find(var_2_17, "itemList/Viewport/Content")
	local var_2_19 = arg_2_0.panel

	arg_2_0.bottomItemList = var_2_16(var_2_18, var_3.Find(var_2_19, "itemList/Viewport/Content/IslandItemTpl"))

	local var_2_20 = arg_2_0.panel

	arg_2_0.buyBtn = var_1.Find(var_2_20, "buyBtn")

	local var_2_21 = arg_2_0.buyBtn

	arg_2_0.consumeIcon = var_1.Find(var_2_21, "consume/icon")

	local var_2_22 = arg_2_0.buyBtn
	local var_2_23 = var_1.Find(var_2_22, "consume/count")
	local var_2_24 = var_1.GetComponent

	typeof = var_3
	Text = var_2_19
	arg_2_0.consumeCount = var_2_24(var_2_23, var_3(var_2_19))
	setText = var_1

	local var_2_25 = arg_2_0._tf
	local var_2_26 = var_2.Find(var_2_25, "panel/getDesc")

	i18n = var_2_25

	var_1(var_2_26, var_2_25("island_3Dshop_buy_tip0"))

	return
end

function var_0_1.OnInit(arg_3_0)
	onButton = var_1_10001

	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0.closeBtn

	local function var_3_2()
		local var_4_0 = arg_3_0

		var_0.Hide(var_4_0)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_3_0, var_3_1, var_3_2, var_1_10005)

	onButton = var_1_10001

	local var_3_3 = arg_3_0
	local var_3_4 = arg_3_0._tf

	local function var_3_5()
		local var_5_0 = arg_3_0

		var_0.Hide(var_5_0)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_3_3, var_3_4, var_3_5, var_1_10005)

	pressPersistTrigger = var_1_10001

	local var_3_6 = arg_3_0.leftBtn
	local var_3_7 = 0.5

	local function var_3_8(arg_6_0)
		local var_6_0 = arg_3_0

		var_1.UpdateCount(var_6_0, arg_3_0.curCount - 1)

		return
	end

	local var_3_9
	local var_3_10 = true
	local var_3_11 = true
	local var_3_12 = 0.1

	SFX_PANEL = var_1_10009

	var_1_10001(var_3_6, var_3_7, var_3_8, var_3_9, var_3_10, var_3_11, var_3_12, var_1_10009)

	pressPersistTrigger = var_1_10001

	local var_3_13 = arg_3_0.rightBtn
	local var_3_14 = 0.5

	local function var_3_15(arg_7_0)
		local var_7_0 = arg_3_0

		var_1.UpdateCount(var_7_0, arg_3_0.curCount + 1)

		return
	end

	local var_3_16
	local var_3_17 = true
	local var_3_18 = true
	local var_3_19 = 0.1

	SFX_PANEL = var_1_10009

	var_1_10001(var_3_13, var_3_14, var_3_15, var_3_16, var_3_17, var_3_18, var_3_19, var_1_10009)

	pressPersistTrigger = var_1_10001

	local var_3_20 = arg_3_0.minBtn
	local var_3_21 = 0.5

	local function var_3_22(arg_8_0)
		local var_8_0 = arg_3_0

		var_1.UpdateCount(var_8_0, arg_3_0.curCount - 10)

		return
	end

	local var_3_23
	local var_3_24 = true
	local var_3_25 = true
	local var_3_26 = 0.1

	SFX_PANEL = var_1_10009

	var_1_10001(var_3_20, var_3_21, var_3_22, var_3_23, var_3_24, var_3_25, var_3_26, var_1_10009)

	pressPersistTrigger = var_1_10001

	local var_3_27 = arg_3_0.maxBtn
	local var_3_28 = 0.5

	local function var_3_29(arg_9_0)
		local var_9_0 = arg_3_0

		var_1.UpdateCount(var_9_0, arg_3_0.curCount + 10)

		return
	end

	local var_3_30
	local var_3_31 = true
	local var_3_32 = true
	local var_3_33 = 0.1

	SFX_PANEL = var_1_10009

	var_1_10001(var_3_27, var_3_28, var_3_29, var_3_30, var_3_31, var_3_32, var_3_33, var_1_10009)

	local var_3_34 = arg_3_0.bottomItemList

	var_1.make(var_3_34, function(arg_10_0, arg_10_1, arg_10_2)
		UIItemList = var_2_10003

		if arg_10_0 == var_2_10003.EventUpdate then
			local var_10_0 = arg_3_0.awards[arg_10_1 + 1]
			local var_10_1 = {
				count = 1
			}

			DROP_TYPE_ISLAND_ITEM = var_2_10005
			var_10_1.type = var_2_10005
			var_10_1.id = var_10_0.id
			updateCustomDrop = var_5

			var_5(arg_10_2, var_10_1)

			local var_10_2 = arg_3_0.settings.mode

			IslandConst = var_6

			if var_10_2 == var_6.TRADE_PURCHASE then
				setText = var_10_2

				var_10_2(arg_10_2:Find("icon_bg/count_bg/count"), arg_3_0.curCount)
			else
				local var_10_3 = arg_3_0.settings.mode

				IslandConst = var_6

				if var_10_3 == var_6.TRADE_SELL then
					setText = var_10_3

					var_10_3(arg_10_2:Find("icon_bg/count_bg/count"), arg_3_0.price * arg_3_0.curCount)
				end
			end
		end

		return
	end)

	onButton = var_1

	local var_3_35 = arg_3_0
	local var_3_36 = arg_3_0.buyBtn

	local function var_3_37()
		if arg_3_0.curCount <= 0 then
			local var_11_0 = arg_3_0.settings.mode

			IslandConst = var_2_10002

			if var_11_0 == var_2_10002.TRADE_PURCHASE then
				pg = var_11_0
				var_2_10002 = var_11_0.TipsMgr.GetInstance()

				local var_11_1 = var_1.ShowTips

				i18n = var_2_10003

				var_11_1(var_2_10002, var_2_10003("island_trade_cnt_inadequate"))
			else
				local var_11_2 = var_0.mode

				IslandConst = var_2_10002

				if var_11_2 == var_2_10002.TRADE_SELL then
					pg = var_11_2
					var_2_10002 = var_11_2.TipsMgr.GetInstance()

					local var_11_3 = var_1.ShowTips

					i18n = var_2_10003

					var_11_3(var_2_10002, var_2_10003("island_trade_sell_failed_label"))
				end
			end

			return
		end

		local var_11_4 = arg_3_0.curCount

		if arg_3_0.settings.maxCnt < var_11_4 then
			settings = var_11_4

			local var_11_5 = var_11_4.mode

			IslandConst = var_1

			local var_11_6

			if var_11_5 == var_1.TRADE_PURCHASE then
				pg = var_11_5
				var_11_6 = var_11_5.TipsMgr.GetInstance()
				var_11_5 = var_11_5.ShowTips
				i18n = var_2_10002

				var_11_5(var_11_6, var_2_10002("island_trade_purchase_failed_label"))
			else
				settings = var_11_5

				local var_11_7 = var_11_5.mode

				IslandConst = var_11_6

				if var_11_7 == var_11_6.TRADE_SELL then
					pg = var_11_7

					local var_11_8 = var_11_7.TipsMgr.GetInstance()
					local var_11_9 = var_0.ShowTips

					i18n = var_2_10002

					var_11_9(var_11_8, var_2_10002("island_trade_sell_failed_label2"))
				end
			end

			return
		end

		if arg_3_0.settings.onYes then
			arg_3_0.settings.onYes(arg_3_0.curCount)
		end

		local var_11_10 = arg_3_0

		var_0.Hide(var_11_10)

		return
	end

	SFX_PANEL = var_3_30

	var_1(var_3_35, var_3_36, var_3_37, var_3_30)

	return
end

function var_0_1.OnShow(arg_12_0)
	arg_12_0.curCount = 1

	local var_12_0

	if not arg_12_0.settings.price then
		var_12_0 = 0
	end

	arg_12_0.price = var_12_0

	local var_12_1

	if not var_1.maxCnt then
		var_12_1 = 0
	end

	arg_12_0.maxCnt = var_12_1
	arg_12_0.awards = {}
	IslandItem = var_2

	local var_12_2 = var_2.New
	local var_12_3 = {}

	IslandItem = var_1_10004
	var_12_3.id = var_1_10004.PEARL_ID

	local var_12_4 = var_12_2(var_12_3)

	IslandItem = var_12_3

	local var_12_5 = var_12_3.New
	local var_12_6 = {}

	IslandItem = var_1_10005
	var_12_6.id = var_1_10005.GOLD_ID

	local var_12_7 = var_12_5(var_12_6)
	local var_12_8 = var_1.mode

	IslandConst = var_5

	local var_12_10

	if var_12_8 == var_5.TRADE_PURCHASE then
		setText = var_12_8

		local var_12_9 = arg_12_0._tf

		var_12_10 = var_12_10.Find(var_12_9, "panel/title")
		i18n = var_12_9

		var_12_8(var_12_10, var_12_9("island_trade_purchase_sub_label"))

		setText = var_12_8

		local var_12_11 = arg_12_0._tf

		var_12_10 = var_12_10.Find(var_12_11, "panel/buyBtn/text")
		i18n = var_12_11

		var_12_8(var_12_10, var_12_11("island_trade_purchase_sub_label"))

		GetImageSpriteFromAtlasAsync = var_12_8

		var_12_8("island/" .. var_12_7:GetIcon(), "", arg_12_0.consumeIcon)

		table = var_12_8

		var_12_8.insert(arg_12_0.awards, var_12_4)
	else
		var_12_8 = var_1.mode
		IslandConst = var_12_10

		if var_12_8 == var_12_10.TRADE_SELL then
			setText = var_12_8

			local var_12_12 = arg_12_0._tf
			local var_12_13 = var_5.Find(var_12_12, "panel/title")

			i18n = var_12_12

			var_12_8(var_12_13, var_12_12("island_trade_sell_sub_label"))

			setText = var_12_8

			local var_12_14 = arg_12_0._tf
			local var_12_15 = var_5.Find(var_12_14, "panel/buyBtn/text")

			i18n = var_12_14

			var_12_8(var_12_15, var_12_14("island_trade_sell_sub_label"))

			GetImageSpriteFromAtlasAsync = var_12_8

			var_12_8("island/" .. var_12_4:GetIcon(), "", arg_12_0.consumeIcon)

			table = var_12_8

			var_12_8.insert(arg_12_0.awards, var_12_7)
		end
	end

	GetImageSpriteFromAtlasAsync = var_12_8

	var_12_8("island/" .. var_12_4:GetIcon(), "", arg_12_0.icon)

	arg_12_0.name.text = var_12_4:getConfig("name")
	arg_12_0.desc.text = var_12_4:getConfig("desc")

	arg_12_0:UpdateCount(arg_12_0.curCount)

	return
end

function var_0_1.UpdateCount(arg_13_0, arg_13_1)
	math = var_1_10002

	local var_13_0 = var_1_10002.min
	local var_13_1 = arg_13_0.maxCnt

	math = var_1_10004
	arg_13_0.curCount = var_13_0(var_13_1, var_1_10004.max(0, arg_13_1))
	arg_13_0.count.text = arg_13_0.curCount

	local var_13_2 = arg_13_0.settings.mode

	IslandConst = var_3

	if var_13_2 == var_3.TRADE_PURCHASE then
		arg_13_0.consumeCount.text = arg_13_0.curCount * arg_13_0.price
	else
		local var_13_3 = arg_13_0.settings.mode

		IslandConst = var_3

		if var_13_3 == var_3.TRADE_SELL then
			arg_13_0.consumeCount.text = arg_13_0.curCount
		end
	end

	local var_13_4 = arg_13_0.bottomItemList

	var_2.align(var_13_4, #arg_13_0.awards)

	return
end

function var_0_1.OnHide(arg_14_0)
	return
end

return var_0_1
