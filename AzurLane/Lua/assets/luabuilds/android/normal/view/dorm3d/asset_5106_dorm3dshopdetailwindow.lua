class = var_0_10000

local var_0_0 = "Dorm3dShopDetailWindow"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.BaseUI"))

var_0_1.SELECTED_WIDTH = 52
var_0_1.UNSELECTED_WIDTH = 12
var_0_1.LOOP_DURATION = 5

function var_0_1.getUIName(arg_1_0)
	return "Dorm3dShopDetailWindow"
end

function var_0_1.init(arg_2_0)
	local var_2_0 = arg_2_0._tf

	arg_2_0.previewTf = var_1.Find(var_2_0, "Window/Preview")

	local var_2_1 = arg_2_0._tf

	arg_2_0.bubbleContent = var_1.Find(var_2_1, "Window/Bubbles/content")

	local var_2_2 = arg_2_0._tf

	arg_2_0.bubbleTpl = var_1.Find(var_2_2, "Window/Bubbles/tpl")
	UIItemList = var_1
	arg_2_0.bubbleList = var_1.New(arg_2_0.bubbleContent, arg_2_0.bubbleTpl)
	BannerScrollRect4Dorm = var_1

	local var_2_3 = var_1.New
	local var_2_4 = arg_2_0._tf
	local var_2_5 = var_2.Find(var_2_4, "Window/banner/mask/content")
	local var_2_6 = arg_2_0._tf

	arg_2_0.scrollSnap = var_2_3(var_2_5, var_3.Find(var_2_6, "Window/banner/dots"))
	setActive = var_1

	var_1(arg_2_0.bubbleTpl, false)

	local var_2_7 = arg_2_0._tf

	arg_2_0.minusBtn = var_1.Find(var_2_7, "Window/countList/minusBtn")

	local var_2_8 = arg_2_0._tf

	arg_2_0.addBtn = var_1.Find(var_2_8, "Window/countList/addBtn")

	local var_2_9 = arg_2_0._tf

	arg_2_0.maxBtn = var_1.Find(var_2_9, "Window/countList/maxBtn")

	local var_2_10 = arg_2_0._tf

	arg_2_0.countText = var_1.Find(var_2_10, "Window/countList/count/Text")
	arg_2_0.shopCfg = arg_2_0.contextData.shopCfg
	pg = var_1

	local var_2_11

	if not var_1.dorm3d_gift[arg_2_0.shopCfg.item_id].unlock_tips then
		var_2_11 = {}
	end

	arg_2_0.unlockTips = var_2_11

	local var_2_12 = arg_2_0.shopCfg.room_id

	arg_2_0.unlockBanners = arg_2_0.shopCfg.banners

	local var_2_13

	if arg_2_0.contextData.groupId ~= 0 then
		var_2_12 = arg_2_0.contextData.groupId
		pg = var_2_13

		if not var_2_13.dorm3d_gift[arg_2_0.shopCfg.item_id].unlock_banners then
			var_2_13 = {}
		end

		table = var_3
		arg_2_0.unlockBanners = var_3.Find(var_2_13, function(arg_3_0, arg_3_1)
			if arg_3_1[1] == var_2_12 then
				return true
			end

			return
		end) and var_3[2]
	end

	pg = var_2_13
	arg_2_0.isExclusive = var_2_13.dorm3d_gift[arg_2_0.shopCfg.item_id].ship_group_id ~= 0
	arg_2_0.isSpecial = false
	pg = var_2

	local var_2_14 = var_2.dorm3d_favor_trigger

	pg = var_3
	arg_2_0.addFavor = var_2_14[var_3.dorm3d_gift[arg_2_0.shopCfg.item_id].favor_trigger_id].num
	setActive = var_2

	local var_2_15 = arg_2_0._tf

	var_2(var_3.Find(var_2_15, "Window/Title/gift"), true)

	arg_2_0.curCount = 1
	getProxy = var_2
	ApartmentProxy = var_3

	local var_2_16 = var_2(var_3)

	arg_2_0.buyCount = var_2.GetGiftShopCount(var_2_16, arg_2_0.shopCfg.item_id)

	return
end

function var_0_1.didEnter(arg_4_0)
	onButton = var_1_10001

	local var_4_0 = arg_4_0
	local var_4_1 = arg_4_0._tf
	local var_4_2 = var_3.Find(var_4_1, "Window/Cancel")

	local function var_4_3()
		local var_5_0 = arg_4_0

		var_0.closeView(var_5_0)

		return
	end

	SFX_CANCEL = var_5

	var_1_10001(var_4_0, var_4_2, var_4_3, var_5)

	onButton = var_1_10001

	local var_4_4 = arg_4_0
	local var_4_5 = arg_4_0._tf

	var_1_10001(var_4_4, var_3.Find(var_4_5, "Mask"), function()
		local var_6_0 = arg_4_0

		var_0.closeView(var_6_0)

		return
	end)
	arg_4_0:InitUIList()
	arg_4_0:InitDropIcon()
	arg_4_0:InitBanner()

	Dorm3dGift = var_1

	local var_4_6 = var_1.New({
		configId = arg_4_0.shopCfg.item_id
	})

	CommonCommodity = var_2

	local var_4_7 = var_2.New
	local var_4_8 = {
		id = var_4_6:GetShopID()
	}

	Goods = var_4

	local var_4_9 = var_4_7(var_4_8, var_4.TYPE_SHOPSTREET)
	local var_4_10, var_4_11, var_4_12 = var_2.GetPrice(var_4_9)

	Drop = var_1_10006

	local var_4_13 = var_1_10006.New
	local var_4_14 = {}

	DROP_TYPE_RESOURCE = var_1_10008
	var_4_14.type = var_1_10008
	var_4_14.id = var_2:GetResType()
	var_4_14.count = var_4_10

	local var_4_15 = var_4_13(var_4_14)

	i18n = var_4_14

	local var_4_16 = var_4_14("dorm3d_shop_buy_tips", "<icon name=" .. var_2:GetResIcon() .. " w=1.1 h=1.1/>", "x" .. var_4_15.count, "x" .. var_4_15.count, arg_4_0.shopCfg.name)
	local var_4_17
	local var_4_18 = 0

	_ = var_10

	var_10.each(var_4_6:getConfig("shop_id"), function(arg_7_0)
		pg = var_2_10001

		if var_2_10001.shop_template[arg_7_0].group_type == 2 then
			math = var_2
			var_4_18 = var_2.max(var_1.group_limit, var_4_18)
		end

		return
	end)

	if 0 < var_4_18 then
		var_4_17 = {
			arg_4_0.buyCount,
			var_4_18
		}
	end

	local var_4_19

	if var_4_17 then
		var_4_19 = var_4_16
		i18n = var_11
		var_4_16 = var_4_19 .. var_11("dorm3d_purchase_weekly_limit", var_4_17[1], var_4_17[2])
	end

	setText = var_4_19

	local var_4_20 = arg_4_0._tf

	var_4_19(var_11.Find(var_4_20, "Window/Content"), var_4_16)

	setText = var_4_19

	local var_4_21 = arg_4_0._tf
	local var_4_22 = var_11.Find(var_4_21, "Window/Confirm/Text")

	i18n = var_4_21

	var_4_19(var_4_22, var_4_21("msgbox_text_confirm"))

	setText = var_4_19

	local var_4_23 = arg_4_0._tf
	local var_4_24 = var_11.Find(var_4_23, "Window/Cancel/Text")

	i18n = var_4_23

	var_4_19(var_4_24, var_4_23("msgbox_text_cancel"))

	pg = var_4_19

	local var_4_25 = var_4_19.UIMgr.GetInstance()

	var_10.OverlayPanel(var_4_25, arg_4_0._tf)

	local var_4_26 = var_4_6:GetShopID()

	arg_4_0.itemList = {
		var_4_26
	}
	arg_4_0.sumPrice = arg_4_0:GetGoodPrice(var_4_26)
	setText = var_11

	var_11(arg_4_0.countText, arg_4_0.curCount)

	local var_4_27 = 1

	if var_4_17 then
		var_4_27 = var_4_17[2] - var_4_17[1]
	end

	local function var_4_28(arg_8_0)
		math = var_2_10001
		arg_8_0 = var_2_10001.max(arg_8_0, 1)
		math = var_1
		arg_8_0 = var_1.min(arg_8_0, var_4_27)

		local var_8_0 = arg_4_0

		var_8_0.curCount = arg_8_0
		setText = var_8_0

		var_8_0(arg_4_0.countText, arg_8_0)

		local var_8_1 = arg_4_0
		local var_8_2 = var_1.GetShopId(var_8_1, arg_4_0.buyCount + arg_4_0.curCount - 1)
		local var_8_3 = arg_4_0
		local var_8_4 = var_2.GetGoodPrice(var_8_3, var_8_2)

		arg_4_0.sumPrice = 0

		for iter_8_0 = arg_4_0.buyCount, arg_4_0.buyCount + arg_4_0.curCount - 1 do
			local var_8_5 = arg_4_0
			local var_8_6 = arg_4_0.sumPrice
			local var_8_7 = arg_4_0
			local var_8_8 = var_9.GetGoodPrice
			local var_8_9 = arg_4_0

			var_8_5.sumPrice = var_8_6 + var_8_8(var_8_7, var_11.GetShopId(var_8_9, iter_8_0))
		end

		i18n = var_3

		local var_8_10 = "dorm3d_shop_buy_tips"
		local var_8_11 = "<icon name="
		local var_8_12 = var_0
		local var_8_13 = var_3(var_8_10, var_8_11 .. var_6.GetResIcon(var_8_12) .. " w=1.1 h=1.1/>", "x" .. var_8_4, "x" .. arg_4_0.sumPrice, arg_4_0.shopCfg.name)
		local var_8_14

		if var_4_17 then
			var_8_14 = var_8_13
			i18n = var_5
			var_8_13 = var_8_14 .. var_5("dorm3d_purchase_weekly_limit", var_4_17[1], var_4_17[2])
		end

		setText = var_8_14

		local var_8_15 = arg_4_0._tf

		var_8_14(var_5.Find(var_8_15, "Window/Content"), var_8_13)
		arg_4_0.contextData.changeCount(arg_8_0)

		return
	end

	onButton = var_13

	local var_4_29 = arg_4_0
	local var_4_30 = arg_4_0.minusBtn

	local function var_4_31()
		if arg_4_0.curCount - 1 > 0 then
			table = var_0

			var_0.remove(arg_4_0.itemList, #arg_4_0.itemList)
		end

		var_4_28(arg_4_0.curCount - 1)

		return
	end

	SFX_PANEL = var_1_10017

	var_13(var_4_29, var_4_30, var_4_31, var_1_10017)

	onButton = var_13

	local var_4_32 = arg_4_0
	local var_4_33 = arg_4_0.addBtn

	local function var_4_34()
		if arg_4_0.buyCount + arg_4_0.curCount + 1 <= var_4_18 then
			table = var_0

			local var_10_0 = var_0.insert
			local var_10_1 = arg_4_0.itemList
			local var_10_2 = arg_4_0

			var_10_0(var_10_1, var_2.GetShopId(var_10_2, arg_4_0.buyCount + arg_4_0.curCount))
		end

		var_4_28(arg_4_0.curCount + 1)

		return
	end

	SFX_PANEL = var_1_10017

	var_13(var_4_32, var_4_33, var_4_34, var_1_10017)

	onButton = var_13

	local var_4_35 = arg_4_0
	local var_4_36 = arg_4_0.maxBtn

	local function var_4_37()
		arg_4_0.itemList = {}

		for iter_11_0 = arg_4_0.buyCount, var_4_18 - 1 do
			table = var_2_10004
			var_2_10004 = var_2_10004.insert

			local var_11_0 = arg_4_0.itemList
			local var_11_1 = arg_4_0

			var_2_10004(var_11_0, var_6.GetShopId(var_11_1, iter_11_0))
		end

		var_4_28(var_4_27)

		return
	end

	SFX_PANEL = var_1_10017

	var_13(var_4_35, var_4_36, var_4_37, var_1_10017)

	onButton = var_13

	local var_4_38 = arg_4_0
	local var_4_39 = arg_4_0._tf
	local var_4_40 = var_15.Find(var_4_39, "Window/Confirm")

	local function var_4_41()
		getProxy = var_2_10000
		PlayerProxy = var_2_10001

		local var_12_0 = var_2_10000(var_2_10001)
		local var_12_1 = var_0.getData(var_12_0)

		pg = var_12_0

		local var_12_2 = var_12_0.shop_template[arg_4_0.itemList[1]]

		id2res = var_2

		local var_12_3

		if var_12_1[var_2(var_12_2.resource_type)] < arg_4_0.sumPrice then
			Drop = var_12_3
			var_12_3 = var_12_3.New

			local var_12_4 = {}

			DROP_TYPE_RESOURCE = var_2_10004
			var_12_4.type = var_2_10004
			var_12_4.id = var_12_2.resource_type

			local var_12_5 = var_12_3(var_12_4)

			var_12_3 = var_12_3.getName(var_12_5)

			local var_12_7

			if var_12_2.resource_type == 1 then
				GoShoppingMsgBox = var_3
				i18n = var_12_7

				local var_12_6 = "switch_to_shop_tip_2"

				i18n = var_2_10006
				var_12_7 = var_12_7(var_12_6, var_2_10006("word_gold"))
				ChargeScene = var_12_6

				local var_12_8 = var_12_6.TYPE_ITEM

				var_2_10006 = {}

				local var_12_9 = {
					59001
				}
				local var_12_10 = arg_4_0.sumPrice

				id2res = var_2_10009
				var_12_9[2] = var_12_10 - var_12_1[var_2_10009(var_12_2.resource_type)]
				var_12_9[3] = arg_4_0.sumPrice
				var_2_10006[1] = var_12_9

				var_3(var_12_7, var_12_8, var_2_10006)
			elseif var_12_2.resource_type == 4 or var_12_2.resource_type == 14 then
				GoShoppingMsgBox = var_3
				i18n = var_12_7

				local var_12_11 = "switch_to_shop_tip_3"

				i18n = var_2_10006
				var_12_7 = var_12_7(var_12_11, var_2_10006("word_gem"))
				ChargeScene = var_12_11

				var_3(var_12_7, var_12_11.TYPE_DIAMOND)
			else
				ItemTipPanel = var_3

				local var_12_12 = var_3.ShowItemTip

				DROP_TYPE_RESOURCE = var_12_7

				if not var_12_12(var_12_7, var_12_2.resource_type) then
					pg = var_3

					local var_12_13 = var_3.TipsMgr.GetInstance()
					local var_12_14 = var_3.ShowTips

					i18n = var_5

					var_12_14(var_12_13, var_5("buyProp_noResource_error", var_12_3))
				end
			end

			local var_12_15 = arg_4_0

			var_3.closeView(var_12_15)

			return
		end

		ipairs = var_12_3

		for iter_12_0, iter_12_1 in var_12_3(arg_4_0.itemList) do
			local var_12_16 = arg_4_0
			local var_12_17 = var_7.emit

			Dorm3dShopDetailMediator = var_2_10009

			var_12_17(var_12_16, var_2_10009.SHOPPING, {
				silentTip = true,
				count = 1,
				shopId = iter_12_1
			})
		end

		local var_12_18 = arg_4_0

		var_2.closeView(var_12_18)

		return
	end

	SFX_PANEL = var_17

	var_13(var_4_38, var_4_40, var_4_41, var_17)

	return
end

function var_0_1.InitBanner(arg_13_0)
	for iter_13_0 = 1, #arg_13_0.unlockBanners do
		local var_13_0 = arg_13_0.scrollSnap
		local var_13_1 = var_5.AddChild(var_13_0)

		LoadImageSpriteAsync = var_13_0

		var_13_0("dorm3dbanner/" .. arg_13_0.unlockBanners[iter_13_0], var_13_1)
	end

	local var_13_2 = arg_13_0.scrollSnap

	var_1.SetUp(var_13_2)

	return
end

function var_0_1.InitUIList(arg_14_0)
	local var_14_0 = arg_14_0.bubbleList

	var_1.make(var_14_0, function(arg_15_0, arg_15_1, arg_15_2)
		UIItemList = var_2_10003

		if arg_15_0 == var_2_10003.EventInit then
			local var_15_0 = arg_15_1 + 1
			local var_15_1 = arg_14_0.unlockTips[var_15_0]

			LoadImageSpriteAtlasAsync = var_2_10005

			var_2_10005("ui/shoptip_atlas", "icon_" .. var_15_1, arg_15_2:Find("icon/icon"), true)

			setText = var_2_10005

			local var_15_2 = arg_15_2
			local var_15_3 = arg_15_2.Find(var_15_2, "bubble/Text")

			i18n = var_15_2

			var_2_10005(var_15_3, var_15_2("dorm3d_shop_tag" .. var_15_1))

			setActive = var_2_10005

			var_2_10005(arg_15_2:Find("bubble"), false)

			onToggle = var_2_10005

			var_2_10005(arg_14_0, arg_15_2, function(arg_16_0)
				setActive = var_3_10001

				local var_16_0 = arg_15_2

				var_3_10001(var_2.Find(var_16_0, "icon/select"), arg_16_0)

				setActive = var_3_10001

				local var_16_1 = arg_15_2

				var_3_10001(var_2.Find(var_16_1, "icon/unselect"), not arg_16_0)

				setActive = var_3_10001

				local var_16_2 = arg_15_2

				var_3_10001(var_2.Find(var_16_2, "bubble"), arg_16_0)

				return
			end)
		end

		return
	end)

	local var_14_1 = arg_14_0.bubbleList

	var_1.align(var_14_1, #arg_14_0.unlockTips)

	return
end

function var_0_1.InitDropIcon(arg_17_0)
	Drop = var_1_10001

	local var_17_0 = var_1_10001.New
	local var_17_1 = {}

	DROP_TYPE_DORM3D_GIFT = var_1_10003
	var_17_1.type = var_1_10003
	var_17_1.id = arg_17_0.shopCfg.item_id
	getProxy = var_3
	ApartmentProxy = var_1_10004

	local var_17_2 = var_3(var_1_10004)

	var_17_1.count = var_3.getGiftCount(var_17_2, arg_17_0.shopCfg.item_id)

	local var_17_3 = var_17_0(var_17_1)

	LoadImageSpriteAtlasAsync = var_17_1

	local var_17_4 = var_17_3:getIcon()
	local var_17_5 = ""
	local var_17_6 = arg_17_0._tf

	var_17_1(var_17_4, var_17_5, var_5.Find(var_17_6, "Window/Item/Dorm3dIconTpl/icon"), true)

	GetImageSpriteFromAtlasAsync = var_17_1

	local var_17_7 = "weaponframes"
	local var_17_8 = "dorm3d_"

	ItemRarity = var_5

	local var_17_9 = var_17_8 .. var_5.Rarity2Print(arg_17_0.shopCfg.rarity)
	local var_17_10 = arg_17_0._tf

	var_17_1(var_17_7, var_17_9, var_5.Find(var_17_10, "Window/Item/Dorm3dIconTpl"))

	setActive = var_17_1

	local var_17_11 = arg_17_0._tf
	local var_17_12 = var_3.Find(var_17_11, "Window/Item/sp")
	local var_17_13

	if not arg_17_0.isExclusive then
		var_17_13 = arg_17_0.isSpecial
	end

	var_17_1(var_17_12, var_17_13)

	if arg_17_0.isSpecial then
		setText = var_2

		local var_17_14 = arg_17_0._tf
		local var_17_15 = var_3.Find(var_17_14, "Window/Item/sp/Text")

		i18n = var_17_14

		var_2(var_17_15, var_17_14("dorm3d_purchase_label_special"))
	elseif arg_17_0.isExclusive then
		setText = var_2

		local var_17_16 = arg_17_0._tf
		local var_17_17 = var_3.Find(var_17_16, "Window/Item/sp/Text")

		i18n = var_17_16

		var_2(var_17_17, var_17_16("dorm3d_purchase_confirm_tip"))
	end

	if arg_17_0.addFavor then
		setActive = var_2

		local var_17_18 = arg_17_0._tf

		var_2(var_3.Find(var_17_18, "Window/Item/gift"), true)

		setText = var_2

		local var_17_19 = arg_17_0._tf

		var_2(var_3.Find(var_17_19, "Window/Item/gift/Text"), "+" .. arg_17_0.addFavor)
	end

	return
end

function var_0_1.GetShopId(arg_18_0, arg_18_1)
	local var_18_0 = arg_18_0.shopCfg.shop_id

	for iter_18_0 = 1, #var_18_0 - 1 do
		local var_18_1 = var_18_0[iter_18_0]

		pg = var_1_10008

		if not var_1_10008.shop_template[var_18_1].limit_args[1] and var_1_10008.group_type == 0 then
			return var_18_1
		elseif var_9 and (var_9[1] == "dailycount" or var_9[1] == "count") then
			if arg_18_1 < var_9[3] then
				return var_18_1
			end
		elseif var_1_10008.group_type == 2 then
			if arg_18_1 < var_1_10008.group_limit then
				return var_18_1
			end
		else
			return var_18_1
		end
	end

	local var_18_2

	if not var_18_0[#var_18_0] then
		var_18_2 = 0
	end

	return var_18_2
end

function var_0_1.GetGoodPrice(arg_19_0, arg_19_1)
	CommonCommodity = var_1_10002

	local var_19_0 = var_1_10002.New
	local var_19_1 = {
		id = arg_19_1
	}

	Goods = var_1_10004

	local var_19_2 = var_19_0(var_19_1, var_1_10004.TYPE_SHOPSTREET)

	return (var_2.GetPrice(var_19_2))
end

function var_0_1.willExit(arg_20_0)
	if arg_20_0.timerRefreshTime then
		local var_20_0 = arg_20_0.timerRefreshTime

		var_1.Stop(var_20_0)

		arg_20_0.timerRefreshTime = nil
	end

	local var_20_1 = arg_20_0.scrollSnap

	var_1.Dispose(var_20_1)

	arg_20_0.scrollSnap = nil
	pg = var_1

	local var_20_2 = var_1.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_20_2, arg_20_0._tf)

	return
end

return var_0_1
