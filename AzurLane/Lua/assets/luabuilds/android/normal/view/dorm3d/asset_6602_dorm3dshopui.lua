class = var_0_10000

local var_0_0 = "Dorm3dShopUI"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.BaseUI"))

pg = var_0_0

local var_0_2 = var_0_0.dorm3d_set

pg = var_2

local var_0_3 = var_2.dorm3d_shop_template

pg = var_3

local var_0_4 = var_3.shop_template

pg = var_0_10004

local var_0_5 = var_0_10004.dorm3d_rooms

pg = var_0_10005

local var_0_6 = var_0_10005.dorm3d_gift

pg = var_0_10006

local var_0_7 = var_0_10006.dorm3d_furniture_template

function var_0_1.getUIName(arg_1_0)
	return "Dorm3dShopUI"
end

function var_0_1.init(arg_2_0)
	local var_2_0 = arg_2_0.rtAdapt

	arg_2_0.closeBtn = var_1.Find(var_2_0, "closeBtn")

	local var_2_1 = arg_2_0.rtAdapt

	arg_2_0.res = var_1.Find(var_2_1, "resourceBg/res")

	local var_2_2 = arg_2_0.rtAdapt

	arg_2_0.recommendationTg = var_1.Find(var_2_2, "left/recommendation")
	UIItemList = var_1

	local var_2_3 = var_1.New
	local var_2_4 = arg_2_0.rtAdapt
	local var_2_5 = var_2.Find(var_2_4, "left/charaScroll/mask/list")
	local var_2_6 = arg_2_0.rtAdapt

	arg_2_0.charaList = var_2_3(var_2_5, var_3.Find(var_2_6, "left/charaScroll/mask/list/tpl"))

	local var_2_7 = arg_2_0.rtAdapt

	arg_2_0.recommendationPage = var_1.Find(var_2_7, "pages/recommendationPage")

	local var_2_8 = arg_2_0.rtAdapt

	arg_2_0.charaPage = var_1.Find(var_2_8, "pages/charaPage")

	local var_2_9 = arg_2_0._tf

	arg_2_0.mask = var_1.Find(var_2_9, "mask")
	setText = var_1

	local var_2_10 = arg_2_0.rtAdapt
	local var_2_11 = var_2.Find(var_2_10, "title/Text")

	i18n = var_2_10

	var_1(var_2_11, var_2_10("dorm3d_shop_title"))

	setText = var_1

	local var_2_12 = arg_2_0.recommendationPage
	local var_2_13 = var_2.Find(var_2_12, "bannerCard/mask/content/item/soldOut")

	i18n = var_2_12

	var_1(var_2_13, var_2_12("dorm3d_shop_sold_out"))

	setText = var_1

	local var_2_14 = arg_2_0.recommendationPage
	local var_2_15 = var_2.Find(var_2_14, "giftCard/soldOut")

	i18n = var_2_14

	var_1(var_2_15, var_2_14("dorm3d_shop_sold_out"))

	setText = var_1

	local var_2_16 = arg_2_0.recommendationPage
	local var_2_17 = var_2.Find(var_2_16, "card1/soldOut")

	i18n = var_2_16

	var_1(var_2_17, var_2_16("dorm3d_shop_sold_out"))

	setText = var_1

	local var_2_18 = arg_2_0.recommendationPage
	local var_2_19 = var_2.Find(var_2_18, "card2/soldOut")

	i18n = var_2_18

	var_1(var_2_19, var_2_18("dorm3d_shop_sold_out"))

	setText = var_1

	local var_2_20 = arg_2_0.recommendationPage
	local var_2_21 = var_2.Find(var_2_20, "card3/soldOut")

	i18n = var_2_20

	var_1(var_2_21, var_2_20("dorm3d_shop_sold_out"))

	setText = var_1

	local var_2_22 = arg_2_0.charaPage
	local var_2_23 = var_2.Find(var_2_22, "scroll/Viewport/Content/card/soldOut")

	i18n = var_2_22

	var_1(var_2_23, var_2_22("dorm3d_shop_sold_out"))

	setText = var_1

	local var_2_24 = arg_2_0.charaPage
	local var_2_25 = var_2.Find(var_2_24, "switch/all/Text")

	i18n = var_2_24

	var_1(var_2_25, var_2_24("dorm3d_shop_all"))

	setText = var_1

	local var_2_26 = arg_2_0.charaPage
	local var_2_27 = var_2.Find(var_2_26, "switch/gift/Text")

	i18n = var_2_26

	var_1(var_2_27, var_2_26("dorm3d_shop_gift1"))

	setText = var_1

	local var_2_28 = arg_2_0.charaPage
	local var_2_29 = var_2.Find(var_2_28, "switch/furniture/Text")

	i18n = var_2_28

	var_1(var_2_29, var_2_28("dorm3d_shop_furniture"))

	setText = var_1

	local var_2_30 = arg_2_0.charaPage
	local var_2_31 = var_2.Find(var_2_30, "switch/others/Text")

	i18n = var_2_30

	var_1(var_2_31, var_2_30("dorm3d_shop_others"))

	setText = var_1

	local var_2_32 = arg_2_0.charaPage
	local var_2_33 = var_2.Find(var_2_32, "switch/all/selected/Text")

	i18n = var_2_32

	var_1(var_2_33, var_2_32("dorm3d_shop_all"))

	setText = var_1

	local var_2_34 = arg_2_0.charaPage
	local var_2_35 = var_2.Find(var_2_34, "switch/gift/selected/Text")

	i18n = var_2_34

	var_1(var_2_35, var_2_34("dorm3d_shop_gift1"))

	setText = var_1

	local var_2_36 = arg_2_0.charaPage
	local var_2_37 = var_2.Find(var_2_36, "switch/furniture/selected/Text")

	i18n = var_2_36

	var_1(var_2_37, var_2_36("dorm3d_shop_furniture"))

	setText = var_1

	local var_2_38 = arg_2_0.charaPage
	local var_2_39 = var_2.Find(var_2_38, "switch/others/selected/Text")

	i18n = var_2_38

	var_1(var_2_39, var_2_38("dorm3d_shop_others"))

	return
end

function var_0_1.didEnter(arg_3_0)
	arg_3_0:InitData()

	onButton = var_1

	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0.closeBtn

	local function var_3_2()
		local var_4_0 = arg_3_0

		var_0.closeView(var_4_0)

		return
	end

	SFX_PANEL = var_1_10005

	var_1(var_3_0, var_3_1, var_3_2, var_1_10005)
	arg_3_0:ShowResUI()
	arg_3_0:SetPageBtns()

	triggerToggle = var_1

	var_1(arg_3_0.recommendationTg, true)

	return
end

function var_0_1.InitData(arg_5_0)
	arg_5_0.bannerCount = var_0_2.drom3d_shop_product_panel_num.key_value_int
	arg_5_0.allCommodityCfgs = {}
	ipairs = var_1

	for iter_5_0, iter_5_1 in var_1(var_0_3.all) do
		table = var_1_10006

		var_1_10006.insert(arg_5_0.allCommodityCfgs, var_0_3[iter_5_1])
	end

	table = var_1

	var_1.sort(arg_5_0.allCommodityCfgs, function(arg_6_0, arg_6_1)
		tonumber = var_2_10002

		local var_6_0 = var_2_10002(arg_6_0.order)

		tonumber = var_3

		if var_6_0 ~= var_3(arg_6_1.order) then
			tonumber = var_6_0

			local var_6_1 = var_6_0(arg_6_0.order)

			tonumber = var_3

			return var_6_1 < var_3(arg_6_1.order)
		end

		return arg_6_0.id > arg_6_1.id
	end)

	arg_5_0.roomCfgs = {}
	_ = var_1

	var_1.each(var_0_5.all, function(arg_7_0)
		if var_0_5[arg_7_0].type == 2 then
			table = var_1

			var_1.insert(arg_5_0.roomCfgs, var_0_5[arg_7_0])
		end

		return
	end)

	table = var_1

	var_1.sort(arg_5_0.roomCfgs, function(arg_8_0, arg_8_1)
		return arg_8_0.id < arg_8_1.id
	end)

	arg_5_0.selectedId = 0

	return
end

function var_0_1.SetPageBtns(arg_9_0)
	SetParent = var_1_10001

	local var_9_0 = arg_9_0.recommendationTg
	local var_9_1 = arg_9_0.rtAdapt

	var_1_10001(var_9_0, var_3.Find(var_9_1, "left"), false)

	local var_9_2 = arg_9_0.charaList

	var_1.make(var_9_2, function(arg_10_0, arg_10_1, arg_10_2)
		UIItemList = var_2_10003

		if arg_10_0 == var_2_10003.EventUpdate then
			local var_10_0 = arg_9_0.roomCfgs[arg_10_1 + 1]

			string = var_4

			local var_10_1 = var_4.format
			local var_10_2 = "dorm3dselect/room_icon_%s"

			string = var_2_10006

			local var_10_3 = var_10_1(var_10_2, var_2_10006.lower(var_10_0.assets_prefix))

			GetImageSpriteFromAtlasAsync = var_10_2

			var_10_2(var_10_3, "", arg_10_2:Find("mask/icon"), false)

			local var_10_4 = arg_9_0
			local var_10_5 = var_5.GetCommoditiesCfgByChara(var_10_4, var_10_0.character[1])

			setActive = var_10_4

			var_10_4(arg_10_2:Find("tip"), var_0_1.ShouldShowSumTip(var_10_5))

			onToggle = var_10_4

			var_10_4(arg_9_0, arg_10_2, function(arg_11_0)
				if arg_11_0 then
					arg_9_0.selectedId = var_10_0.id

					local var_11_0 = arg_9_0

					var_1.SetPageBtns(var_11_0)

					local var_11_1 = arg_9_0

					var_1.RefreshPage(var_11_1)
				end

				return
			end)
		end

		return
	end)

	local var_9_3 = arg_9_0.charaList

	var_1.align(var_9_3, #arg_9_0.roomCfgs)

	arg_9_0.showingCommoditiesIndex = {}

	local var_9_4 = {}

	table = var_9_3

	var_9_3.insertto(var_9_4, arg_9_0:GetCommoditiesCfgByPanel(1, arg_9_0.bannerCount))

	table = var_2

	var_2.insertto(var_9_4, arg_9_0:GetCommoditiesCfgByPanel(2, 1))

	table = var_2

	var_2.insertto(var_9_4, arg_9_0:GetCommoditiesCfgByPanel(3, 1))

	table = var_2

	var_2.insertto(var_9_4, arg_9_0:GetCommoditiesCfgByPanel(4, 1))

	table = var_2

	var_2.insertto(var_9_4, arg_9_0:GetCommoditiesCfgByPanel(5, 1))

	setActive = var_2

	local var_9_5 = arg_9_0.recommendationTg

	var_2(var_3.Find(var_9_5, "icon/tip"), var_0_1.ShouldShowSumTip(var_9_4))

	onToggle = var_2

	var_2(arg_9_0, arg_9_0.recommendationTg, function(arg_12_0)
		if arg_12_0 then
			arg_9_0.selectedId = 0

			local var_12_0 = arg_9_0

			var_1.SetPageBtns(var_12_0)

			local var_12_1 = arg_9_0

			var_1.RefreshPage(var_12_1)
		end

		return
	end)

	SetParent = var_2

	local var_9_6 = arg_9_0.recommendationTg
	local var_9_7 = arg_9_0.rtAdapt

	var_2(var_9_6, var_4.Find(var_9_7, "left/charaScroll/mask/list"), false)

	local var_9_8 = arg_9_0.recommendationTg

	var_2.SetSiblingIndex(var_9_8, 0)

	return
end

function var_0_1.GetCommoditiesCfgByPanel(arg_13_0, arg_13_1, arg_13_2)
	local var_13_0 = {}
	local var_13_1 = 0

	ipairs = var_1_10005

	for iter_13_0, iter_13_1 in var_1_10005(arg_13_0.allCommodityCfgs) do
		table = var_1_10010

		if not var_1_10010.contains(arg_13_0.showingCommoditiesIndex, iter_13_0) then
			table = var_1_10010

			if var_1_10010.contains(iter_13_1.panel, arg_13_1) then
				local var_13_2 = arg_13_0

				if not arg_13_0.IsCommodityOutOfDate(var_13_2, iter_13_1) then
					var_13_2 = arg_13_0
					var_1_10010 = arg_13_0.IsCommoditySoldOut(var_13_2, iter_13_1)
				end

				if not var_1_10010 then
					var_13_1 = var_13_1 + 1
					table = var_13_2

					var_13_2.insert(var_13_0, iter_13_1)

					table = var_11

					var_11.insert(arg_13_0.showingCommoditiesIndex, iter_13_0)
				end

				if var_13_1 == arg_13_2 then
					break
				end
			end
		end
	end

	if var_13_1 < arg_13_2 then
		ipairs = var_5

		for iter_13_2, iter_13_3 in var_5(arg_13_0.allCommodityCfgs) do
			table = var_1_10010

			if not var_1_10010.contains(arg_13_0.showingCommoditiesIndex, iter_13_2) then
				table = var_1_10010

				if var_1_10010.contains(iter_13_3.panel, arg_13_1) then
					local var_13_3 = arg_13_0

					if not arg_13_0.IsCommodityOutOfDate(var_13_3, iter_13_3) then
						var_13_1 = var_13_1 + 1
						table = var_13_3

						var_13_3.insert(var_13_0, iter_13_3)

						table = var_11

						var_11.insert(arg_13_0.showingCommoditiesIndex, iter_13_2)
					end

					if var_13_1 == arg_13_2 then
						break
					end
				end
			end
		end
	end

	return var_13_0
end

function var_0_1.GetCommoditiesCfgByChara(arg_14_0, arg_14_1)
	local var_14_0 = {}
	local var_14_1 = {}

	ipairs = var_1_10004

	for iter_14_0, iter_14_1 in var_1_10004(arg_14_0.allCommodityCfgs) do
		local var_14_2 = {}

		if iter_14_1.realroom_id ~= 0 then
			table = var_10

			var_10.insertto(var_14_2, var_0_5[iter_14_1.realroom_id].character)

			table = var_10

			var_10.insertto(var_14_2, var_0_5[iter_14_1.realroom_id].character_pay)
		end

		if iter_14_1.room_id == arg_14_1 or iter_14_1.room_id == 0 then
			if iter_14_1.realroom_id ~= 0 then
				if iter_14_1.realroom_id ~= 0 then
					table = var_10

					if var_10.contains(var_14_2, arg_14_1) then
						local var_14_3 = arg_14_0:IsCommodityOutOfDate(iter_14_1)
						local var_14_4 = arg_14_0
						local var_14_5 = arg_14_0.IsCommoditySoldOut(var_14_4, iter_14_1)

						if not var_14_3 then
							if not var_14_5 then
								table = var_14_4

								var_14_4.insert(var_14_0, iter_14_1)
							else
								table = var_14_4

								var_14_4.insert(var_14_1, iter_14_1)
							end
						end
					end
				end
			end
		end
	end

	if #var_14_1 > 0 then
		table = var_4

		var_4.insertto(var_14_0, var_14_1)
	end

	return var_14_0
end

function var_0_1.IsCommodityOutOfDate(arg_15_0, arg_15_1)
	local var_15_0 = arg_15_1.shop_id

	ipairs = var_1_10003

	for iter_15_0, iter_15_1 in var_1_10003(var_15_0) do
		local var_15_1 = var_0_4[iter_15_1]

		pg = var_1_10009

		local var_15_2 = var_1_10009.TimeMgr.GetInstance()

		if not var_1_10009.inTime(var_15_2, var_15_1.time) then
			return true
		end
	end

	return false
end

function var_0_1.IsCommoditySoldOut(arg_16_0, arg_16_1)
	if arg_16_1.type == 1 then
		getProxy = var_2
		ApartmentProxy = var_1_10003
		var_1_10003 = var_2(var_1_10003)

		local var_16_0 = var_2.GetFurnitureShopCount(var_1_10003, arg_16_1.item_id)

		if 0 < var_16_0 then
			return true
		end
	elseif arg_16_1.type == 2 then
		Dorm3dGift = var_2

		local var_16_1 = var_2.New({
			configId = arg_16_1.item_id
		})

		return not var_2.CheckBuyLimit(var_16_1)
	elseif arg_16_1.type == 3 then
		getProxy = var_2
		ApartmentProxy = var_1_10003

		local var_16_2 = var_2(var_1_10003)
		local var_16_3

		var_16_3 = var_2.getRoom(var_16_2, arg_16_1.item_id) and var_2.unlockCharacter[arg_16_1.room_id]

		return var_16_3
	end

	return false
end

function var_0_1.ShowResUI(arg_17_0)
	getProxy = var_1_10001
	PlayerProxy = var_1_10002

	local var_17_0 = var_1_10001(var_1_10002)
	local var_17_1 = var_1.getRawData(var_17_0)
	local var_17_2 = arg_17_0.res
	local var_17_3 = var_2.Find(var_17_2, "gold/max")
	local var_17_4 = var_2.GetComponent

	typeof = var_4
	Text = var_1_10005
	arg_17_0.goldMax = var_17_4(var_17_3, var_4(var_1_10005))

	local var_17_5 = arg_17_0.res
	local var_17_6 = var_2.Find(var_17_5, "gold/Text")
	local var_17_7 = var_2.GetComponent

	typeof = var_4
	Text = var_1_10005
	arg_17_0.goldValue = var_17_7(var_17_6, var_4(var_1_10005))

	local var_17_8 = arg_17_0.res
	local var_17_9 = var_2.Find(var_17_8, "oil/max")
	local var_17_10 = var_2.GetComponent

	typeof = var_4
	Text = var_1_10005
	arg_17_0.oilMax = var_17_10(var_17_9, var_4(var_1_10005))

	local var_17_11 = arg_17_0.res
	local var_17_12 = var_2.Find(var_17_11, "oil/Text")
	local var_17_13 = var_2.GetComponent

	typeof = var_4
	Text = var_1_10005
	arg_17_0.oilValue = var_17_13(var_17_12, var_4(var_1_10005))

	local var_17_14 = arg_17_0.res
	local var_17_15 = var_2.Find(var_17_14, "gem/Text")
	local var_17_16 = var_2.GetComponent

	typeof = var_4
	Text = var_1_10005
	arg_17_0.gemValue = var_17_16(var_17_15, var_4(var_1_10005))
	PlayerResUI = var_2

	var_2.StaticFlush(var_17_1, arg_17_0.goldMax, arg_17_0.goldValue, arg_17_0.oilMax, arg_17_0.oilValue, arg_17_0.gemValue)

	onButton = var_2

	local var_17_17 = arg_17_0
	local var_17_18 = arg_17_0.res
	local var_17_19 = var_4.Find(var_17_18, "gold")

	local function var_17_20()
		pg = var_2_10000

		local var_18_0 = var_2_10000.playerResUI

		var_0.ClickGold(var_18_0)

		return
	end

	SFX_PANEL = var_6

	var_2(var_17_17, var_17_19, var_17_20, var_6)

	onButton = var_2

	local var_17_21 = arg_17_0
	local var_17_22 = arg_17_0.res
	local var_17_23 = var_4.Find(var_17_22, "oil")

	local function var_17_24()
		pg = var_2_10000

		local var_19_0 = var_2_10000.playerResUI

		var_0.ClickOil(var_19_0)

		return
	end

	SFX_PANEL = var_6

	var_2(var_17_21, var_17_23, var_17_24, var_6)

	onButton = var_2

	local var_17_25 = arg_17_0
	local var_17_26 = arg_17_0.res
	local var_17_27 = var_4.Find(var_17_26, "gem")

	local function var_17_28()
		pg = var_2_10000

		local var_20_0 = var_2_10000.playerResUI

		var_0.ClickGem(var_20_0)

		return
	end

	SFX_PANEL = var_6

	var_2(var_17_25, var_17_27, var_17_28, var_6)

	return
end

function var_0_1.RefreshPage(arg_21_0)
	arg_21_0.showingCommoditiesIndex = {}
	setActive = var_1

	var_1(arg_21_0.recommendationPage, arg_21_0.selectedId == 0)

	setActive = var_1

	var_1(arg_21_0.charaPage, arg_21_0.selectedId ~= 0)

	if arg_21_0.selectedId == 0 then
		arg_21_0:SetBannnerCard()
		arg_21_0:SetGiftCard()
		arg_21_0:SetNormalCard()
	else
		arg_21_0:SetCharaCard()
	end

	return
end

function var_0_1.SetBannnerCard(arg_22_0)
	local var_22_0 = arg_22_0.recommendationPage
	local var_22_1 = var_1.Find(var_22_0, "bannerCard")
	local var_22_2 = arg_22_0:GetCommoditiesCfgByPanel(1, arg_22_0.bannerCount)

	if not arg_22_0.scrollSnap then
		BannerScrollRectDorm3dShop = var_3
		arg_22_0.scrollSnap = var_3.New(var_22_1:Find("mask/content"), var_22_1:Find("dots"))
	end

	ipairs = var_3

	for iter_22_0, iter_22_1 in var_3(var_22_2) do
		local var_22_3 = arg_22_0.scrollSnap
		local var_22_5

		if not var_8.GetItemChild(var_22_3, iter_22_0) then
			local var_22_4 = arg_22_0.scrollSnap

			var_22_5 = var_9.AddChild(var_22_4)
		end

		local var_22_6 = arg_22_0:IsCommoditySoldOut(iter_22_1)
		local var_22_7 = false
		local var_22_8 = false
		local var_22_9 = {}
		local var_22_10 = 0
		local var_22_11 = ""
		local var_22_12 = ""

		if var_0_4[iter_22_1.shop_id[1]].group_type == 2 then
			i18n = var_22_13

			local var_22_13

			if not var_22_13("dorm3d_shop_limit1") then
				i18n = var_22_13
				var_22_13 = var_22_13("dorm3d_shop_limit")
			end

			local var_22_17

			if iter_22_1.type == 1 then
				var_22_8 = var_0_7[iter_22_1.item_id].is_special == 1
				var_22_7 = not var_22_8 and var_22_17.is_exclusive == 1
				Drop = var_18

				local var_22_14 = var_18.New
				local var_22_15 = {
					count = 0
				}

				DROP_TYPE_DORM3D_FURNITURE = var_1_10020
				var_22_15.type = var_1_10020
				var_22_15.id = var_22_17.id
				var_1_10020 = var_22_14(var_22_15)
				var_22_11 = var_18.getIcon(var_1_10020)

				local var_22_16 = var_22_13

				var_1_10020 = " "
				getProxy = iter_22_3
				ApartmentProxy = iter_22_4
				iter_22_4 = iter_22_3(iter_22_4)
				var_22_12 = var_22_16 .. var_1_10020 .. iter_22_3.GetFurnitureShopCount(iter_22_4, iter_22_1.item_id) .. "/1"
				var_22_9 = var_22_17.unlock_tips or {}
				var_22_10 = iter_22_1.shop_id[1]
			elseif iter_22_1.type == 2 then
				var_22_17 = var_0_6[iter_22_1.item_id]
				var_22_7 = iter_22_1.room_id ~= 0
				Dorm3dGift = var_18

				local var_22_18 = var_18.New({
					configId = iter_22_1.item_id
				})

				Drop = var_19

				local var_22_19 = var_19.New

				var_1_10020 = {}
				DROP_TYPE_DORM3D_GIFT = iter_22_3
				var_1_10020.type = iter_22_3
				var_1_10020.id = iter_22_1.item_id
				getProxy = iter_22_3
				ApartmentProxy = iter_22_4
				iter_22_4 = iter_22_3(iter_22_4)
				var_1_10020.count = iter_22_3.getGiftCount(iter_22_4, iter_22_1.item_id)
				iter_22_3 = var_22_19(var_1_10020)
				var_22_11 = var_19.getIcon(iter_22_3)
				var_1_10020 = 0

				for iter_22_2 = 1, #iter_22_1.shop_id do
					var_1_10025 = iter_22_1.shop_id[iter_22_2]

					if not var_0_4[var_1_10025].limit_args[1] and var_26.group_type == 0 then
						var_1_10020 = 0
					elseif var_27 and (var_27[1] == "dailycount" or var_27[1] == "count") then
						var_1_10020 = var_27[3]
					elseif var_26.group_type == 2 then
						var_1_10020 = var_26.group_limit
					end
				end

				iter_22_3 = var_22_13
				iter_22_4 = " "
				getProxy = var_1_10023
				ApartmentProxy = iter_22_2

				local var_22_20 = var_1_10023(iter_22_2)

				var_22_12 = iter_22_3 .. iter_22_4 .. var_1_10023.GetGiftShopCount(var_22_20, iter_22_1.item_id) .. "/" .. var_1_10020
				setText = iter_22_3
				var_1_10023 = var_22_5
				iter_22_4 = var_22_5.Find(var_1_10023, "favor/number")
				var_1_10023 = "+"
				pg = var_24

				iter_22_3(iter_22_4, var_1_10023 .. var_24.dorm3d_favor_trigger[var_0_6[iter_22_1.item_id].favor_trigger_id].num)

				iter_22_4 = var_22_5
				iter_22_4 = var_22_5.Find(iter_22_4, "favor")
				iter_22_3 = iter_22_3.GetComponent
				typeof = var_1_10023
				CanvasGroup = var_24
				iter_22_3 = iter_22_3(iter_22_4, var_1_10023(var_24))
				iter_22_4 = var_22_6 and 0.5 or 1
				iter_22_3.alpha = iter_22_4
				var_22_9 = var_22_17.unlock_tips or {}
				iter_22_4 = var_22_18
				var_22_10 = var_22_18.GetShopID(iter_22_4)
			elseif iter_22_1.type == 3 then
				var_22_7 = true
				var_22_17 = var_0_5[iter_22_1.item_id].invite_icon
				ipairs = var_18

				for iter_22_3, iter_22_4 in var_18(var_22_17) do
					if iter_22_4[1] == iter_22_1.room_id then
						var_22_11 = iter_22_4[2]
					end
				end

				local var_22_21 = var_22_6 and 1 or 0

				var_22_12 = var_22_13 .. " " .. var_22_21 .. "/1"
				var_22_10 = iter_22_1.shop_id[1]
			end

			setActive = var_22_17

			var_22_17(var_22_5:Find("bg/normal"), not var_22_7 and not var_22_8)

			setActive = var_22_17

			var_22_17(var_22_5:Find("bg/zhuanshu"), var_22_7)

			setActive = var_22_17

			var_22_17(var_22_5:Find("bg/tedian"), var_22_8)

			setActive = var_22_17

			var_22_17(var_22_5:Find("normal"), not var_22_7 and not var_22_8)

			setActive = var_22_17

			var_22_17(var_22_5:Find("zhuanshu"), var_22_7)

			setActive = var_22_17

			var_22_17(var_22_5:Find("tedian"), var_22_8)

			setActive = var_22_17

			var_22_17(var_22_5:Find("favor"), iter_22_1.type == 2)

			LoadImageSpriteAsync = var_22_17

			local var_22_22 = "dorm3dbanner/" .. iter_22_1.banners[1] .. "_shopCard1"

			var_1_10020 = var_22_5

			var_22_17(var_22_22, var_22_5.Find(var_1_10020, "bannerMask/banner"), true)

			setText = var_22_17

			var_22_17(var_22_5:Find("name"), iter_22_1.name)

			local var_22_23 = var_0_4[iter_22_1.shop_id[1]].time

			setActive = var_22_26
			var_1_10020 = var_22_5

			local var_22_24 = var_22_5.Find(var_1_10020, "timeLimit")

			var_1_10020 = var_22_23 ~= "always"

			var_22_26(var_22_24, var_1_10020)

			local var_22_26

			if var_22_23 ~= "always" then
				pg = var_22_26

				local var_22_25 = var_22_26.TimeMgr.GetInstance()

				var_22_26 = var_22_26.parseTimeFromConfig(var_22_25, var_22_23[2])
				setText = var_22_25
				iter_22_3 = var_22_5
				var_1_10020 = var_22_5.Find(iter_22_3, "timeLimit/Text")
				iter_22_4 = arg_22_0

				var_22_25(var_1_10020, arg_22_0.GetTimeRemain(iter_22_4, var_22_26))
			end

			UIItemList = var_22_26

			local var_22_27 = var_22_26.New

			var_1_10020 = var_22_5

			local var_22_28 = var_22_5.Find(var_1_10020, "bubbles/content")

			iter_22_3 = var_22_5

			local var_22_29 = var_22_27(var_22_28, var_22_5.Find(iter_22_3, "bubbles/content/tpl"))

			var_1_10020 = arg_22_0

			arg_22_0.SetBubbles(var_1_10020, var_22_29, var_22_9)

			setActive = var_19
			iter_22_3 = var_22_5

			var_19(var_22_5.Find(iter_22_3, "consume"), not var_22_6)

			setActive = var_19
			iter_22_3 = var_22_5

			var_19(var_22_5.Find(iter_22_3, "soldOut"), var_22_6)

			CommonCommodity = var_19

			local var_22_30 = var_19.New

			var_1_10020 = {
				id = var_22_10
			}
			Goods = iter_22_3
			iter_22_3 = var_22_30(var_1_10020, iter_22_3.TYPE_SHOPSTREET)
			var_1_10020, iter_22_3, iter_22_4 = var_19.GetPrice(iter_22_3)
			Drop = var_1_10023
			var_1_10023 = var_1_10023.New

			local var_22_31 = {}

			DROP_TYPE_RESOURCE = var_1_10025
			var_22_31.type = var_1_10025
			var_22_31.id = var_19:GetResType()
			var_22_31.count = var_1_10020
			var_1_10023 = var_1_10023(var_22_31)
			setText = var_22_31

			var_22_31(var_22_5:Find("consume/Text"), "<icon name=" .. var_19:GetResIcon() .. " w=0.81 h=0.81/>" .. var_1_10020)

			GetImageSpriteFromAtlasAsync = var_22_31

			var_22_31(var_22_11, "", var_22_5:Find("normal/Dorm3dIconTpl/icon"))

			GetImageSpriteFromAtlasAsync = var_22_31

			var_22_31(var_22_11, "", var_22_5:Find("zhuanshu/Dorm3dIconTpl/icon"))

			GetImageSpriteFromAtlasAsync = var_22_31
			var_1_10025 = var_22_11

			local var_22_32 = ""
			local var_22_33 = var_22_5

			var_22_31(var_1_10025, var_22_32, var_22_5.Find(var_22_33, "tedian/Dorm3dIconTpl/icon"))

			setText = var_22_31

			var_22_31(var_22_5:Find("normal/countLimit"), var_22_12)

			setText = var_22_31

			var_22_31(var_22_5:Find("zhuanshu/countLimit"), var_22_12)

			setText = var_22_31

			var_22_31(var_22_5:Find("tedian/countLimit"), var_22_12)

			var_1_10025 = var_22_5
			var_1_10025 = var_22_5.Find(var_1_10025, "normal/Dorm3dIconTpl")

			local var_22_34 = var_24.GetComponent

			typeof = var_26
			CanvasGroup = var_27

			local var_22_35 = var_22_34(var_1_10025, var_26(var_27))

			var_1_10025 = var_22_6 and 0.5 or 1
			var_22_35.alpha = var_1_10025
			var_1_10025 = var_22_5
			var_1_10025 = var_22_5.Find(var_1_10025, "zhuanshu/Dorm3dIconTpl")

			local var_22_36 = var_24.GetComponent

			typeof = var_26
			CanvasGroup = var_27

			local var_22_37 = var_22_36(var_1_10025, var_26(var_27))

			var_1_10025 = var_22_6 and 0.5 or 1
			var_22_37.alpha = var_1_10025
			var_1_10025 = var_22_5
			var_1_10025 = var_22_5.Find(var_1_10025, "tedian/Dorm3dIconTpl")

			local var_22_38 = var_24.GetComponent

			typeof = var_26
			CanvasGroup = var_27

			local var_22_39 = var_22_38(var_1_10025, var_26(var_27))

			var_1_10025 = var_22_6 and 0.5 or 1
			var_22_39.alpha = var_1_10025

			if not var_22_6 then
				onButton = var_22_39
				var_1_10025 = arg_22_0

				local var_22_40 = var_22_5

				local function var_22_41()
					local var_23_0 = arg_22_0
					local var_23_1 = var_0.ClickCommodity
					local var_23_2 = iter_22_1
					local var_23_3 = var_22_5

					var_23_1(var_23_0, var_23_2, var_3.Find(var_23_3, "tip"))

					return
				end

				SFX_PANEL = var_22_33

				var_22_39(var_1_10025, var_22_40, var_22_41, var_22_33)
			else
				onButton = var_22_39
				var_1_10025 = arg_22_0

				local var_22_42 = var_22_5

				local function var_22_43()
					var_0_1.UpdateCommodtyTip(iter_22_1)

					setActive = var_0

					local var_24_0 = var_22_5

					var_0(var_1.Find(var_24_0, "tip"), false)

					pg = var_0

					local var_24_1 = var_0.TipsMgr.GetInstance()
					local var_24_2 = var_0.ShowTips

					i18n = var_2

					var_24_2(var_24_1, var_2("word_sell_out"))

					return
				end

				SFX_PANEL = var_22_33

				var_22_39(var_1_10025, var_22_42, var_22_43, var_22_33)
			end

			local var_22_44 = var_0_1.ShouldShowCommodtyTip(iter_22_1)

			setActive = var_1_10025

			var_1_10025(var_22_5:Find("new"), var_22_44)

			setActive = var_1_10025

			var_1_10025(var_22_5:Find("tip"), var_22_44)
		end
	end

	local var_22_45 = arg_22_0.scrollSnap

	var_3.SetUp(var_22_45)

	return
end

function var_0_1.SetGiftCard(arg_25_0)
	local var_25_0 = arg_25_0.recommendationPage
	local var_25_1 = var_1.Find(var_25_0, "giftCard")
	local var_25_2 = arg_25_0:GetCommoditiesCfgByPanel(2, 1)[1]
	local var_25_3 = 0
	local var_25_4 = arg_25_0:IsCommoditySoldOut(var_25_2)
	local var_25_5 = ""
	local var_25_6 = false
	local var_25_7 = false

	if var_0_4[var_25_2.shop_id[1]].group_type == 2 then
		i18n = var_25_8

		local var_25_8

		if not var_25_8("dorm3d_shop_limit1") then
			i18n = var_25_8
			var_25_8 = var_25_8("dorm3d_shop_limit")
		end

		if var_25_2.type == 1 then
			var_25_7 = var_0_7[var_25_2.item_id].is_special == 1
			var_25_6 = not var_25_7 and var_9.is_exclusive == 1
			Drop = var_10

			local var_25_9 = var_10.New

			var_1_10011 = {
				count = 0
			}
			DROP_TYPE_DORM3D_FURNITURE = var_1_10012
			var_1_10011.type = var_1_10012
			var_1_10011.id = var_9.id

			local var_25_10 = var_25_9(var_1_10011)

			updateCustomDrop = var_1_10011
			var_1_10013 = var_25_1

			var_1_10011(var_25_1.Find(var_1_10013, "Dorm3dIconTpl"), var_25_10)

			var_25_3 = var_25_2.shop_id[1]
			var_1_10011 = var_25_8
			var_1_10012 = " "
			getProxy = var_1_10013
			ApartmentProxy = iter_25_1
			iter_25_1 = var_1_10013(iter_25_1)
			var_25_5 = var_1_10011 .. var_1_10012 .. var_1_10013.GetFurnitureShopCount(iter_25_1, var_25_2.item_id) .. "/1"
		elseif var_25_2.type == 2 then
			local var_25_11 = var_0_6[var_25_2.item_id]

			var_25_6 = var_25_2.room_id ~= 0
			Dorm3dGift = var_10

			local var_25_12 = var_10.New({
				configId = var_25_2.item_id
			})

			Drop = var_1_10011
			var_1_10011 = var_1_10011.New
			var_1_10012 = {}
			DROP_TYPE_DORM3D_GIFT = var_1_10013
			var_1_10012.type = var_1_10013
			var_1_10012.id = var_25_2.item_id
			getProxy = var_13
			ApartmentProxy = iter_25_1
			iter_25_1 = var_13(iter_25_1)
			var_1_10012.count = var_13.getGiftCount(iter_25_1, var_25_2.item_id)
			var_1_10011 = var_1_10011(var_1_10012)
			setText = var_1_10012
			iter_25_1 = var_25_1

			local var_25_13 = var_25_1.Find(iter_25_1, "favor/number")

			iter_25_1 = "+"
			pg = var_15

			var_1_10012(var_25_13, iter_25_1 .. var_15.dorm3d_favor_trigger[var_0_6[var_25_2.item_id].favor_trigger_id].num)

			updateCustomDrop = var_1_10012
			iter_25_1 = var_25_1

			var_1_10012(var_25_1.Find(iter_25_1, "Dorm3dIconTpl"), var_1_10011)

			var_25_3 = var_25_12:GetShopID()
			var_1_10012 = 0

			for iter_25_0 = 1, #var_25_2.shop_id do
				local var_25_14 = var_25_2.shop_id[iter_25_0]

				if not var_0_4[var_25_14].limit_args[1] and var_18.group_type == 0 then
					var_1_10012 = 0
				elseif var_19 and (var_19[1] == "dailycount" or var_19[1] == "count") then
					var_1_10012 = var_19[3]
				elseif var_18.group_type == 2 then
					var_1_10012 = var_18.group_limit
				end
			end

			local var_25_15 = var_25_8

			iter_25_1 = " "
			getProxy = var_15
			ApartmentProxy = iter_25_0
			iter_25_0 = var_15(iter_25_0)
			var_25_5 = var_25_15 .. iter_25_1 .. var_15.GetGiftShopCount(iter_25_0, var_25_2.item_id) .. "/" .. var_1_10012
		elseif var_25_2.type == 3 then
			var_25_6 = true

			local var_25_16 = var_0_5[var_25_2.item_id].invite_icon
			local var_25_17 = ""

			ipairs = var_1_10011

			for iter_25_1, iter_25_2 in var_1_10011(var_25_16) do
				if iter_25_2[1] == var_25_2.room_id then
					var_25_17 = iter_25_2[2]
				end
			end

			GetImageSpriteFromAtlasAsync = var_11

			var_11(var_25_17, "", var_25_1:Find("Dorm3dIconTpl/icon"))

			GetImageSpriteFromAtlasAsync = var_11
			var_1_10012 = "weaponframes"

			local var_25_18 = "dorm3d_"

			ItemRarity = iter_25_1

			var_11(var_1_10012, var_25_18 .. iter_25_1.Rarity2Print(var_25_2.rarity), var_25_1:Find("Dorm3dIconTpl"))

			local var_25_19 = var_25_4 and 1 or 0

			var_25_5 = var_25_8 .. " " .. var_25_19 .. "/1"
			var_25_3 = var_25_2.shop_id[1]
		end

		local var_25_20 = var_25_1:Find("Dorm3dIconTpl")
		local var_25_21 = var_9.GetComponent

		typeof = var_11
		CanvasGroup = var_1_10012
		var_25_21(var_25_20, var_11(var_1_10012)).alpha = var_25_4 and 0.5 or 1

		local var_25_22 = var_25_1:Find("favor")
		local var_25_23 = var_9.GetComponent

		typeof = var_11
		CanvasGroup = var_1_10012

		local var_25_24 = var_25_23(var_25_22, var_11(var_1_10012))

		var_25_24.alpha = var_25_4 and 0.5 or 1
		setActive = var_25_24

		var_25_24(var_25_1:Find("bg/normal"), not var_25_6 and not var_25_7)

		setActive = var_25_24

		var_25_24(var_25_1:Find("bg/zhuanshu"), var_25_6)

		setActive = var_25_24

		var_25_24(var_25_1:Find("bg/tedian"), var_25_7)

		setActive = var_25_24

		var_25_24(var_25_1:Find("normal"), not var_25_6 and not var_25_7)

		setActive = var_25_24

		var_25_24(var_25_1:Find("zhuanshu"), var_25_6)

		setActive = var_25_24

		var_25_24(var_25_1:Find("tedian"), var_25_7)

		setText = var_25_24

		var_25_24(var_25_1:Find("normal/countLimit"), var_25_5)

		setText = var_25_24

		var_25_24(var_25_1:Find("zhuanshu/countLimit"), var_25_5)

		setText = var_25_24

		var_25_24(var_25_1:Find("tedian/countLimit"), var_25_5)

		LoadImageSpriteAsync = var_25_24

		var_25_24("dorm3dbanner/" .. var_25_2.banners[1] .. "_shopCard2", var_25_1:Find("mask/item"), true)

		setScrollText = var_25_24

		var_25_24(var_25_1:Find("name/text"), var_25_2.name)

		setActive = var_25_24

		var_25_24(var_25_1:Find("favor"), var_25_2.type == 2)

		setActive = var_25_24

		var_25_24(var_25_1:Find("consume"), not var_25_4)

		setActive = var_25_24

		var_25_24(var_25_1:Find("soldOut"), var_25_4)

		local var_25_25 = var_0_4[var_25_2.shop_id[1]].time

		setActive = var_25_27

		var_25_27(var_25_1:Find("timeLimit"), var_25_25 ~= "always")

		local var_25_27, var_25_28

		if var_25_25 ~= "always" then
			pg = var_25_27

			local var_25_26 = var_25_27.TimeMgr.GetInstance()

			var_25_27 = var_25_27.parseTimeFromConfig(var_25_26, var_25_25[2])
			setText = var_25_26
			var_25_28 = var_25_1:Find("timeLimit/Text")
			iter_25_1 = arg_25_0

			var_25_26(var_25_28, arg_25_0.GetTimeRemain(iter_25_1, var_25_27))
		end

		CommonCommodity = var_25_27

		local var_25_29 = var_25_27.New
		local var_25_30 = {
			id = var_25_3
		}

		Goods = var_25_28

		local var_25_31 = var_25_29(var_25_30, var_25_28.TYPE_SHOPSTREET)
		local var_25_32, var_25_33, var_25_34 = var_10.GetPrice(var_25_31)

		Drop = iter_25_1

		local var_25_35 = iter_25_1.New
		local var_25_36 = {}

		DROP_TYPE_RESOURCE = iter_25_0
		var_25_36.type = iter_25_0
		var_25_36.id = var_10:GetResType()
		var_25_36.count = var_25_32

		local var_25_37 = var_25_35(var_25_36)

		setText = var_25_36

		var_25_36(var_25_1:Find("consume/Text"), "<icon name=" .. var_10:GetResIcon() .. " w=0.81 h=0.81/>" .. var_25_32)

		if not var_25_4 then
			onButton = var_25_36

			local var_25_38 = arg_25_0
			local var_25_39 = var_25_1

			local function var_25_40()
				local var_26_0 = arg_25_0
				local var_26_1 = var_0.ClickCommodity
				local var_26_2 = var_25_2
				local var_26_3 = var_25_1

				var_26_1(var_26_0, var_26_2, var_3.Find(var_26_3, "tip"))

				return
			end

			SFX_PANEL = var_19

			var_25_36(var_25_38, var_25_39, var_25_40, var_19)
		else
			onButton = var_25_36

			local var_25_41 = arg_25_0
			local var_25_42 = var_25_1

			local function var_25_43()
				var_0_1.UpdateCommodtyTip(var_25_2)

				setActive = var_0

				local var_27_0 = var_25_1

				var_0(var_1.Find(var_27_0, "tip"), false)

				pg = var_0

				local var_27_1 = var_0.TipsMgr.GetInstance()
				local var_27_2 = var_0.ShowTips

				i18n = var_2

				var_27_2(var_27_1, var_2("word_sell_out"))

				return
			end

			SFX_PANEL = var_19

			var_25_36(var_25_41, var_25_42, var_25_43, var_19)
		end

		local var_25_44 = var_0_1.ShouldShowCommodtyTip(var_25_2)

		setActive = var_16

		var_16(var_25_1:Find("new"), var_25_44)

		setActive = var_16

		var_16(var_25_1:Find("tip"), var_25_44)

		return
	end
end

function var_0_1.SetNormalCard(arg_28_0)
	for iter_28_0 = 1, 3 do
		local var_28_0 = arg_28_0.recommendationPage
		local var_28_1 = var_5.Find(var_28_0, "card" .. iter_28_0)
		local var_28_2 = arg_28_0:GetCommoditiesCfgByPanel(iter_28_0 + 2, 1)[1]
		local var_28_3 = false
		local var_28_4 = false
		local var_28_5 = arg_28_0:IsCommoditySoldOut(var_28_2)
		local var_28_6 = {}
		local var_28_7 = 0
		local var_28_8 = ""

		if var_0_4[var_28_2.shop_id[1]].group_type == 2 then
			i18n = var_28_9

			local var_28_9

			if not var_28_9("dorm3d_shop_limit1") then
				i18n = var_28_9
				var_28_9 = var_28_9("dorm3d_shop_limit")
			end

			local var_28_12

			if var_28_2.type == 1 then
				var_28_3 = var_0_7[var_28_2.item_id].is_special == 1
				var_28_4 = not var_28_3 and var_28_12.is_exclusive == 1
				Drop = var_15

				local var_28_10 = var_15.New
				local var_28_11 = {
					count = 0
				}

				DROP_TYPE_DORM3D_FURNITURE = var_1_10017
				var_28_11.type = var_1_10017
				var_28_11.id = var_28_12.id
				var_1_10017 = var_28_10(var_28_11)
				var_28_8 = var_15.getIcon(var_1_10017)
				setText = var_16
				iter_28_2 = var_28_1
				var_1_10017 = var_28_1.Find(iter_28_2, "countLimit/Text")
				iter_28_2 = var_28_9
				iter_28_3 = " "
				getProxy = var_1_10020
				ApartmentProxy = iter_28_1
				iter_28_1 = var_1_10020(iter_28_1)

				var_16(var_1_10017, iter_28_2 .. iter_28_3 .. var_1_10020.GetFurnitureShopCount(iter_28_1, var_28_2.item_id) .. "/1")

				var_28_6 = var_28_12.unlock_tips or {}
				var_28_7 = var_28_2.shop_id[1]
			elseif var_28_2.type == 2 then
				var_28_12 = var_0_6[var_28_2.item_id]
				var_28_4 = var_28_2.room_id ~= 0
				Dorm3dGift = var_15

				local var_28_13 = var_15.New({
					configId = var_28_2.item_id
				})

				Drop = var_16

				local var_28_14 = var_16.New

				var_1_10017 = {}
				DROP_TYPE_DORM3D_GIFT = iter_28_2
				var_1_10017.type = iter_28_2
				var_1_10017.id = var_28_2.item_id
				getProxy = iter_28_2
				ApartmentProxy = iter_28_3
				iter_28_3 = iter_28_2(iter_28_3)
				var_1_10017.count = iter_28_2.getGiftCount(iter_28_3, var_28_2.item_id)
				iter_28_2 = var_28_14(var_1_10017)
				var_28_8 = var_16.getIcon(iter_28_2)
				var_1_10017 = 0

				for iter_28_1 = 1, #var_28_2.shop_id do
					var_1_10022 = var_28_2.shop_id[iter_28_1]

					if not var_0_4[var_1_10022].limit_args[1] and var_1_10023.group_type == 0 then
						var_1_10017 = 0
					elseif var_24 and (var_24[1] == "dailycount" or var_24[1] == "count") then
						var_1_10017 = var_24[3]
					elseif var_1_10023.group_type == 2 then
						var_1_10017 = var_1_10023.group_limit
					end
				end

				setText = iter_28_2
				var_1_10020 = var_28_1
				iter_28_3 = var_28_1.Find(var_1_10020, "countLimit/Text")
				var_1_10020 = var_28_9
				iter_28_1 = " "
				getProxy = var_1_10022
				ApartmentProxy = var_1_10023
				var_1_10023 = var_1_10022(var_1_10023)

				iter_28_2(iter_28_3, var_1_10020 .. iter_28_1 .. var_1_10022.GetGiftShopCount(var_1_10023, var_28_2.item_id) .. "/" .. var_1_10017)

				pg = iter_28_2
				iter_28_2 = iter_28_2.dorm3d_favor_trigger[var_0_6[var_28_2.item_id].favor_trigger_id].num
				setText = iter_28_3
				iter_28_1 = var_28_1

				iter_28_3(var_28_1.Find(iter_28_1, "normal/favor/number"), "+" .. iter_28_2)

				setText = iter_28_3
				iter_28_1 = var_28_1

				iter_28_3(var_28_1.Find(iter_28_1, "zhuanshu/favor/number"), "+" .. iter_28_2)

				setText = iter_28_3
				iter_28_1 = var_28_1

				iter_28_3(var_28_1.Find(iter_28_1, "tedian/favor/number"), "+" .. iter_28_2)

				var_28_6 = var_28_12.unlock_tips or {}
				var_1_10020 = var_28_13
				var_28_7 = var_28_13.GetShopID(var_1_10020)
			elseif var_28_2.type == 3 then
				var_28_4 = true
				var_28_12 = var_0_5[var_28_2.item_id].invite_icon
				ipairs = var_15

				for iter_28_2, iter_28_3 in var_15(var_28_12) do
					if iter_28_3[1] == var_28_2.room_id then
						var_28_8 = iter_28_3[2]
					end
				end

				local var_28_15 = var_28_5 and 1 or 0

				setText = var_16
				iter_28_2 = var_28_1

				var_16(var_28_1.Find(iter_28_2, "countLimit/Text"), var_28_9 .. " " .. var_28_15 .. "/1")

				var_28_7 = var_28_2.shop_id[1]
			end

			setActive = var_28_12

			var_28_12(var_28_1:Find("bg/normal"), not var_28_4 and not var_28_3)

			setActive = var_28_12

			var_28_12(var_28_1:Find("bg/zhuanshu"), var_28_4)

			setActive = var_28_12

			var_28_12(var_28_1:Find("bg/tedian"), var_28_3)

			setActive = var_28_12

			var_28_12(var_28_1:Find("normal"), not var_28_4 and not var_28_3)

			setActive = var_28_12

			var_28_12(var_28_1:Find("zhuanshu"), var_28_4)

			setActive = var_28_12

			var_28_12(var_28_1:Find("tedian"), var_28_3)

			setActive = var_28_12

			var_28_12(var_28_1:Find("normal/favor"), var_28_2.type == 2)

			setActive = var_28_12

			var_28_12(var_28_1:Find("zhuanshu/favor"), var_28_2.type == 2)

			setActive = var_28_12

			var_28_12(var_28_1:Find("tedian/favor"), var_28_2.type == 2)

			setText = var_28_12

			var_28_12(var_28_1:Find("name"), var_28_2.name)

			UIItemList = var_28_12

			local var_28_16 = var_28_12.New
			local var_28_17 = var_28_1:Find("bubbles/content")

			var_1_10017 = var_28_1

			local var_28_18 = var_28_16(var_28_17, var_28_1.Find(var_1_10017, "bubbles/content/tpl"))

			arg_28_0:SetBubbles(var_28_18, var_28_6)

			setActive = var_15
			var_1_10017 = var_28_1

			var_15(var_28_1.Find(var_1_10017, "consume"), not var_28_5)

			setActive = var_15
			var_1_10017 = var_28_1

			var_15(var_28_1.Find(var_1_10017, "soldOut"), var_28_5)

			CommonCommodity = var_15

			local var_28_19 = var_15.New
			local var_28_20 = {
				id = var_28_7
			}

			Goods = var_1_10017
			var_1_10017 = var_28_19(var_28_20, var_1_10017.TYPE_SHOPSTREET)

			local var_28_21

			var_28_21, var_1_10017, iter_28_2 = var_15.GetPrice(var_1_10017)
			Drop = iter_28_3
			iter_28_3 = iter_28_3.New
			var_1_10020 = {}
			DROP_TYPE_RESOURCE = iter_28_1
			var_1_10020.type = iter_28_1
			var_1_10022 = var_15
			var_1_10020.id = var_15.GetResType(var_1_10022)
			var_1_10020.count = var_28_21
			iter_28_3 = iter_28_3(var_1_10020)
			setText = var_1_10020
			var_1_10022 = var_28_1

			var_1_10020(var_28_1.Find(var_1_10022, "consume/Text"), "<icon name=" .. var_15:GetResIcon() .. " w=0.81 h=0.81/>" .. var_28_21)

			GetImageSpriteFromAtlasAsync = var_1_10020

			var_1_10020(var_28_8, "", var_28_1:Find("normal/mask/Dorm3dIconTpl/icon"))

			GetImageSpriteFromAtlasAsync = var_1_10020

			var_1_10020(var_28_8, "", var_28_1:Find("zhuanshu/mask/Dorm3dIconTpl/icon"))

			GetImageSpriteFromAtlasAsync = var_1_10020
			iter_28_1 = var_28_8
			var_1_10022 = ""

			local var_28_22 = var_28_1

			var_1_10020(iter_28_1, var_1_10022, var_28_1.Find(var_28_22, "tedian/mask/Dorm3dIconTpl/icon"))

			if not var_28_5 then
				onButton = var_1_10020
				iter_28_1 = arg_28_0
				var_1_10022 = var_28_1

				function var_1_10023()
					local var_29_0 = arg_28_0
					local var_29_1 = var_0.ClickCommodity
					local var_29_2 = var_28_2
					local var_29_3 = var_28_1

					var_29_1(var_29_0, var_29_2, var_3.Find(var_29_3, "tip"))

					return
				end

				SFX_PANEL = var_28_22

				var_1_10020(iter_28_1, var_1_10022, var_1_10023, var_28_22)
			else
				onButton = var_1_10020
				iter_28_1 = arg_28_0
				var_1_10022 = var_28_1

				function var_1_10023()
					pg = var_2_10000

					local var_30_0 = var_2_10000.TipsMgr.GetInstance()
					local var_30_1 = var_0.ShowTips

					i18n = var_2_10002

					var_30_1(var_30_0, var_2_10002("word_sell_out"))
					var_0_1.UpdateCommodtyTip(var_28_2)

					setActive = var_0

					local var_30_2 = var_28_1

					var_0(var_1.Find(var_30_2, "tip"), false)

					return
				end

				SFX_PANEL = var_28_22

				var_1_10020(iter_28_1, var_1_10022, var_1_10023, var_28_22)
			end

			var_1_10020 = var_0_1.ShouldShowCommodtyTip(var_28_2)
			setActive = iter_28_1
			var_1_10023 = var_28_1

			iter_28_1(var_28_1.Find(var_1_10023, "new"), var_1_10020)

			setActive = iter_28_1
			var_1_10023 = var_28_1

			iter_28_1(var_28_1.Find(var_1_10023, "tip"), var_1_10020)
		end
	end

	return
end

function var_0_1.SetCharaCard(arg_31_0)
	local var_31_0 = arg_31_0
	local var_31_1 = arg_31_0.GetCommoditiesCfgByChara(var_31_0, var_0_5[arg_31_0.selectedId].character[1])

	UIItemList = var_31_0

	local var_31_2 = var_31_0.New
	local var_31_3 = arg_31_0.charaPage
	local var_31_4 = var_3.Find(var_31_3, "scroll/Viewport/Content")
	local var_31_5 = arg_31_0.charaPage
	local var_31_6 = var_31_2(var_31_4, var_4.Find(var_31_5, "scroll/Viewport/Content/card"))
	local var_31_7 = {}

	var_31_6:make(function(arg_32_0, arg_32_1, arg_32_2)
		UIItemList = var_2_10003

		if arg_32_0 == var_2_10003.EventInit then
			local var_32_0 = var_31_1[arg_32_1 + 1]

			table = var_4

			var_4.insert(var_31_7, {
				var_32_0.type,
				arg_32_2
			})

			local var_32_1 = arg_31_0
			local var_32_2 = var_4.IsCommoditySoldOut(var_32_1, var_32_0)
			local var_32_3 = false
			local var_32_4 = false
			local var_32_5 = ""
			local var_32_6 = {}
			local var_32_7 = 0

			if var_0_4[var_32_0.shop_id[1]].group_type == 2 then
				i18n = var_32_8

				local var_32_8

				if not var_32_8("dorm3d_shop_limit1") then
					i18n = var_32_8
					var_32_8 = var_32_8("dorm3d_shop_limit")
				end

				local var_32_12

				if var_32_0.type == 1 then
					var_32_4 = var_0_7[var_32_0.item_id].is_special == 1
					var_32_3 = not var_32_4 and var_32_12.is_exclusive == 1
					Drop = var_12

					local var_32_9 = var_12.New

					var_2_10013 = {
						count = 0
					}
					DROP_TYPE_DORM3D_FURNITURE = var_2_10014
					var_2_10013.type = var_2_10014
					var_2_10013.id = var_32_12.id

					local var_32_10 = var_32_9(var_2_10013)

					var_32_5 = var_12.getIcon(var_32_10)
					setText = var_2_10013
					var_2_10015 = arg_32_2

					var_2_10013(arg_32_2.Find(var_2_10015, "descScroll/Viewport/Content/desc"), var_32_12.desc)

					setText = var_2_10013
					var_2_10015 = arg_32_2

					local var_32_11 = arg_32_2.Find(var_2_10015, "countLimit")

					var_2_10015 = var_32_8
					var_2_10016 = " "
					getProxy = var_2_10017
					ApartmentProxy = iter_32_0
					iter_32_0 = var_2_10017(iter_32_0)

					var_2_10013(var_32_11, var_2_10015 .. var_2_10016 .. var_17.GetFurnitureShopCount(iter_32_0, var_32_0.item_id) .. "/1")

					var_32_6 = var_32_12.unlock_tips or {}
					var_32_7 = var_32_0.shop_id[1]
				elseif var_32_0.type == 2 then
					var_32_12 = var_0_6[var_32_0.item_id]
					var_32_3 = var_32_0.room_id ~= 0
					Dorm3dGift = var_12

					local var_32_13 = var_12.New({
						configId = var_32_0.item_id
					})

					Drop = var_2_10013
					var_2_10013 = var_2_10013.New

					local var_32_14 = {}

					DROP_TYPE_DORM3D_GIFT = var_2_10015
					var_32_14.type = var_2_10015
					var_32_14.id = var_32_0.item_id
					getProxy = var_15
					ApartmentProxy = var_2_10016

					local var_32_15 = var_15(var_2_10016)

					var_32_14.count = var_15.getGiftCount(var_32_15, var_32_0.item_id)

					local var_32_16 = var_2_10013(var_32_14)

					var_32_5 = var_2_10013.getIcon(var_32_16)
					setText = var_14

					var_14(arg_32_2:Find("descScroll/Viewport/Content/desc"), var_32_12.display)

					local var_32_17 = 0

					for iter_32_0 = 1, #var_32_0.shop_id do
						var_2_10019 = var_32_0.shop_id[iter_32_0]

						if not var_0_4[var_2_10019].limit_args[1] and var_2_10020.group_type == 0 then
							var_32_17 = 0
						elseif var_21 and (var_21[1] == "dailycount" or var_21[1] == "count") then
							var_32_17 = var_21[3]
						elseif var_2_10020.group_type == 2 then
							var_32_17 = var_2_10020.group_limit
						end
					end

					setText = var_15

					local var_32_18 = arg_32_2:Find("countLimit")
					local var_32_19 = var_32_8

					iter_32_0 = " "
					getProxy = var_2_10019
					ApartmentProxy = var_2_10020

					local var_32_20 = var_2_10019(var_2_10020)

					var_15(var_32_18, var_32_19 .. iter_32_0 .. var_19.GetGiftShopCount(var_32_20, var_32_0.item_id) .. "/" .. var_32_17)

					setText = var_15

					local var_32_21 = arg_32_2:Find("favor/number")
					local var_32_22 = "+"

					pg = iter_32_0

					var_15(var_32_21, var_32_22 .. iter_32_0.dorm3d_favor_trigger[var_0_6[var_32_0.item_id].favor_trigger_id].num)

					var_32_6 = var_32_12.unlock_tips or {}
					var_32_7 = var_32_13:GetShopID()
				elseif var_32_0.type == 3 then
					var_32_3 = true

					local var_32_23 = var_0_5[var_32_0.item_id].invite_icon

					ipairs = var_2_10013

					for iter_32_1, iter_32_2 in var_2_10013(var_32_23) do
						if iter_32_2[1] == var_32_0.room_id then
							var_32_5 = iter_32_2[2]
						end
					end

					setText = var_13

					var_13(arg_32_2:Find("descScroll/Viewport/Content/desc"), var_32_12.room_des)

					local var_32_24 = var_32_2 and 1 or 0

					setText = var_14

					var_14(arg_32_2:Find("countLimit"), var_32_8 .. " " .. var_32_24 .. "/1")

					var_32_7 = var_32_0.shop_id[1]
				end

				setActive = var_32_12

				var_32_12(arg_32_2:Find("bg/normal"), not var_32_2)

				setActive = var_32_12

				var_32_12(arg_32_2:Find("bg/soldOut"), var_32_2)

				setActive = var_32_12

				var_32_12(arg_32_2:Find("normal"), not var_32_3 and not var_32_4)

				setActive = var_32_12

				var_32_12(arg_32_2:Find("zhuanshu"), var_32_3)

				setActive = var_32_12

				var_32_12(arg_32_2:Find("tedian"), var_32_4)

				GetImageSpriteFromAtlasAsync = var_32_12

				var_32_12(var_32_5, "", arg_32_2:Find("mask/Dorm3dIconTpl/icon"))

				setActive = var_32_12

				var_32_12(arg_32_2:Find("favor"), var_32_0.type == 2)

				setScrollText = var_32_12

				var_32_12(arg_32_2:Find("name/text"), var_32_0.name)

				UIItemList = var_32_12

				local var_32_25 = var_32_12.New(arg_32_2:Find("bubbles/content"), arg_32_2:Find("bubbles/content/tpl"))
				local var_32_26 = arg_31_0

				var_12.SetBubbles(var_32_26, var_32_25, var_32_6)

				CommonCommodity = var_12

				local var_32_27 = var_12.New
				local var_32_28 = {
					id = var_32_7
				}

				Goods = var_14

				local var_32_29 = var_32_27(var_32_28, var_14.TYPE_SHOPSTREET)
				local var_32_30, var_32_31, var_32_32 = var_12.GetPrice(var_32_29)

				Drop = var_16

				local var_32_33 = var_16.New
				local var_32_34 = {}

				DROP_TYPE_RESOURCE = iter_32_0
				var_32_34.type = iter_32_0
				var_32_34.id = var_12:GetResType()
				var_32_34.count = var_32_30

				local var_32_35 = var_32_33(var_32_34)

				setText = var_32_34

				var_32_34(arg_32_2:Find("consume/Text"), "<icon name=" .. var_12:GetResIcon() .. " w=0.81 h=0.81/>" .. var_32_30)

				setActive = var_32_34

				var_32_34(arg_32_2:Find("consume"), not var_32_2)

				setActive = var_32_34

				var_32_34(arg_32_2:Find("soldOut"), var_32_2)

				local var_32_36 = var_0_4[var_32_0.shop_id[1]].time

				setActive = var_32_38

				var_32_38(arg_32_2:Find("timeLimit"), var_32_36 ~= "always")

				local var_32_38, var_32_40

				if var_32_36 ~= "always" then
					pg = var_32_38

					local var_32_37 = var_32_38.TimeMgr.GetInstance()

					var_32_38 = var_32_38.parseTimeFromConfig(var_32_37, var_32_36[2])
					setText = var_32_37

					local var_32_39 = arg_32_2:Find("timeLimit/Text")

					var_32_40 = arg_31_0

					var_32_37(var_32_39, var_21.GetTimeRemain(var_32_40, var_32_38))
				end

				if not var_32_2 then
					onButton = var_32_38

					local var_32_41 = arg_31_0
					local var_32_42 = arg_32_2

					local function var_32_43()
						local var_33_0 = arg_31_0
						local var_33_1 = var_0.ClickCommodity
						local var_33_2 = var_32_0
						local var_33_3 = arg_32_2

						var_33_1(var_33_0, var_33_2, var_3.Find(var_33_3, "tip"))

						return
					end

					SFX_PANEL = var_32_40

					var_32_38(var_32_41, var_32_42, var_32_43, var_32_40)
				else
					onButton = var_32_38

					local var_32_44 = arg_31_0
					local var_32_45 = arg_32_2

					local function var_32_46()
						var_0_1.UpdateCommodtyTip(var_32_0)

						setActive = var_0

						local var_34_0 = arg_32_2

						var_0(var_1.Find(var_34_0, "tip"), false)

						pg = var_0

						local var_34_1 = var_0.TipsMgr.GetInstance()
						local var_34_2 = var_0.ShowTips

						i18n = var_2

						var_34_2(var_34_1, var_2("word_sell_out"))

						return
					end

					SFX_PANEL = var_32_40

					var_32_38(var_32_44, var_32_45, var_32_46, var_32_40)
				end

				local var_32_47 = var_0_1.ShouldShowCommodtyTip(var_32_0)

				setActive = var_19

				var_19(arg_32_2:Find("new"), var_32_47)

				setActive = var_19

				var_19(arg_32_2:Find("tip"), var_32_47)

				return
			end
		end
	end)
	var_31_6:align(#var_31_1)

	arg_31_0.filterIndex = 1

	for iter_31_0 = 1, 4 do
		local var_31_8 = arg_31_0.charaPage
		local var_31_9 = var_8.Find(var_31_8, "switch")
		local var_31_10 = var_8.GetChild(var_31_9, iter_31_0 - 1)

		onToggle = var_31_9

		var_31_9(arg_31_0, var_31_10, function(arg_35_0)
			if arg_35_0 then
				arg_31_0.filterIndex = iter_31_0

				if iter_31_0 == 1 then
					ipairs = var_1

					for iter_35_0, iter_35_1 in var_1(var_31_7) do
						setActive = var_2_10006

						var_2_10006(iter_35_1[2], true)
					end
				elseif iter_31_0 == 2 then
					ipairs = var_1

					for iter_35_2, iter_35_3 in var_1(var_31_7) do
						setActive = var_2_10006

						var_2_10006(iter_35_3[2], iter_35_3[1] == 2)
					end
				elseif iter_31_0 == 3 then
					ipairs = var_1

					for iter_35_4, iter_35_5 in var_1(var_31_7) do
						setActive = var_2_10006

						var_2_10006(iter_35_5[2], iter_35_5[1] == 1)
					end
				else
					ipairs = var_1

					for iter_35_6, iter_35_7 in var_1(var_31_7) do
						setActive = var_2_10006

						var_2_10006(iter_35_7[2], iter_35_7[1] == 3)
					end
				end

				for iter_35_8 = 1, 4 do
					local var_35_0 = arg_31_0.charaPage
					local var_35_1 = var_5.Find(var_35_0, "switch")
					local var_35_2 = var_5.GetChild(var_35_1, iter_35_8 - 1)

					setActive = var_35_1

					var_35_1(var_35_2:Find("selected"), iter_35_8 == iter_31_0)
				end
			end

			return
		end)

		if iter_31_0 == 1 then
			triggerToggle = var_31_9

			var_31_9(var_31_10, true)
		end
	end

	return
end

function var_0_1.ClickCommodity(arg_36_0, arg_36_1, arg_36_2)
	arg_36_0.showCount = 1

	if arg_36_1.room_id ~= 0 then
		local var_36_0 = 0

		pairs = var_1_10004

		for iter_36_2, iter_36_1 in var_1_10004(var_0_5) do
			if iter_36_1.type == 2 and iter_36_1.character[1] == arg_36_1.room_id then
				var_36_0 = iter_36_1.id
			end
		end

		getProxy = var_1_10004
		ApartmentProxy = var_1_10005
		var_1_10005 = var_1_10004(var_1_10005)

		if not var_1_10004.getRoom(var_1_10005, var_36_0) then
			pg = var_1_10005
			var_1_10006 = var_1_10005.TipsMgr.GetInstance()
			var_1_10005 = var_1_10005.ShowTips
			i18n = iter_36_2

			var_1_10005(var_1_10006, iter_36_2("dorm3d_role_locked"))

			return
		end
	end

	if arg_36_1.realroom_id ~= 0 then
		getProxy = var_3
		ApartmentProxy = var_1_10004

		local var_36_1 = var_3(var_1_10004)

		if not var_3.getRoom(var_36_1, arg_36_1.realroom_id) then
			pg = var_36_1
			var_1_10005 = var_36_1.TipsMgr.GetInstance()

			local var_36_2 = var_4.ShowTips

			i18n = var_1_10006

			local var_36_3 = var_1_10006("dorm3d_publicroom_unlock")

			iter_36_2 = "："
			pg = iter_36_1

			var_36_2(var_1_10005, var_36_3 .. iter_36_2 .. iter_36_1.dorm3d_rooms[arg_36_1.realroom_id].room)

			return
		end
	end

	var_0_1.UpdateCommodtyTip(arg_36_1)

	if arg_36_2 then
		setActive = var_3

		var_3(arg_36_2, false)
	end

	local var_36_5

	if arg_36_1.type == 1 then
		Dorm3dFurniture = var_3

		local var_36_4 = var_3.New({
			configId = arg_36_1.item_id
		})

		CommonCommodity = var_36_5
		var_36_5 = var_36_5.New
		var_1_10005 = {
			id = arg_36_1.shop_id[1]
		}
		Goods = var_6

		local var_36_6 = var_36_5(var_1_10005, var_6.TYPE_SHOPSTREET)
		local var_36_7

		var_1_10005, var_36_7, iter_36_2 = var_36_5.GetPrice(var_36_6)
		Drop = iter_36_1

		local var_36_8 = iter_36_1.New

		var_1_10009 = {}
		DROP_TYPE_RESOURCE = var_1_10010
		var_1_10009.type = var_1_10010
		var_1_10011 = var_36_5
		var_1_10009.id = var_36_5.GetResType(var_1_10011)
		var_1_10009.count = var_1_10005

		local var_36_9 = var_36_8(var_1_10009)
		local var_36_10 = arg_36_0

		var_1_10009 = arg_36_0.emit
		Dorm3dShopMediator = var_1_10011
		var_1_10011 = var_1_10011.SHOW_SHOPPING_CONFIRM_WINDOW

		local var_36_11 = {
			content = {
				icon = "<icon name=" .. var_36_5:GetResIcon() .. " w=1.1 h=1.1/>",
				off = var_36_7,
				cost = var_36_9.count,
				old = iter_36_2,
				name = arg_36_1.name
			}
		}

		i18n = var_13
		var_36_11.tip = var_13("dorm3d_shop_gift_tip")
		var_36_11.drop = var_36_4
		var_36_11.endTime = var_36_4:GetEndTime()

		function var_36_11.onYes()
			local var_37_0 = var_36_4

			if not var_0.InShopTime(var_37_0) then
				pg = var_0

				local var_37_1 = var_0.TipsMgr.GetInstance()
				local var_37_2 = var_0.ShowTips

				i18n = var_2_10002

				var_37_2(var_37_1, var_2_10002("dorm3d_purchase_outtime"))

				return
			end

			local var_37_3 = arg_36_0
			local var_37_4 = var_0.emit

			GAME = var_2_10002

			var_37_4(var_37_3, var_2_10002.SHOPPING, {
				silentTip = true,
				count = 1,
				shopId = arg_36_1.shop_id[1]
			})

			return
		end

		var_1_10009(var_36_10, var_1_10011, var_36_11)
	elseif arg_36_1.type == 2 then
		local var_36_12 = 0

		for iter_36_2 = 1, #arg_36_1.shop_id do
			local var_36_13 = arg_36_1.shop_id[iter_36_2]

			if not var_0_4[var_36_13].limit_args[1] and var_1_10009.group_type == 0 then
				var_36_12 = 0
			elseif var_10 and (var_10[1] == "dailycount" or var_10[1] == "count") then
				var_36_12 = var_10[3]
			elseif var_1_10009.group_type == 2 then
				var_36_12 = var_1_10009.group_limit
			end
		end

		if 1 < var_36_12 then
			var_36_5 = 0

			if arg_36_0.selectedId ~= 0 then
				var_36_5 = var_0_5[arg_36_0.selectedId].character[1]
			end

			local var_36_14 = arg_36_0

			var_1_10005 = arg_36_0.emit
			Dorm3dShopMediator = iter_36_2

			var_1_10005(var_36_14, iter_36_2.OPEN_DETAIL, arg_36_1, var_36_5, function(arg_38_0)
				arg_36_0.showCount = arg_38_0

				return
			end)
		else
			Dorm3dGift = var_36_5
			var_36_5 = var_36_5.New({
				configId = arg_36_1.item_id
			})
			CommonCommodity = var_1_10005
			var_1_10005 = var_1_10005.New

			local var_36_15 = {
				id = var_36_5:GetShopID()
			}

			Goods = iter_36_2
			iter_36_2 = var_1_10005(var_36_15, iter_36_2.TYPE_SHOPSTREET)

			local var_36_16, var_36_17

			var_36_16, iter_36_2, var_36_17 = var_1_10005.GetPrice(iter_36_2)
			Drop = var_1_10009

			local var_36_18 = var_1_10009.New
			local var_36_19 = {}

			DROP_TYPE_RESOURCE = var_1_10011
			var_36_19.type = var_1_10011

			local var_36_20 = var_1_10005

			var_36_19.id = var_1_10005.GetResType(var_36_20)
			var_36_19.count = var_36_16

			local var_36_21 = var_36_18(var_36_19)
			local var_36_22
			local var_36_23 = 0

			_ = var_36_20

			var_36_20.each(var_36_5:getConfig("shop_id"), function(arg_39_0)
				if var_0_4[arg_39_0].group_type == 2 then
					math = var_2
					var_36_23 = var_2.max(var_1.group_limit, var_36_23)
				end

				return
			end)

			local var_36_25

			if var_36_23 > 0 then
				local var_36_24 = {}

				getProxy = var_13
				ApartmentProxy = var_36_25
				var_36_25 = var_13(var_36_25)
				var_36_24[1] = var_13.GetGiftShopCount(var_36_25, var_36_5:GetConfigID())
				var_36_24[2] = var_36_23
				var_36_22 = var_36_24
			end

			local var_36_26 = arg_36_0
			local var_36_27 = arg_36_0.emit

			Dorm3dShopMediator = var_36_25

			local var_36_28 = var_36_25.SHOW_SHOPPING_CONFIRM_WINDOW
			local var_36_29 = {
				content = {
					icon = "<icon name=" .. var_1_10005:GetResIcon() .. " w=1.1 h=1.1/>",
					off = iter_36_2,
					cost = var_36_21.count,
					old = var_36_17,
					name = arg_36_1.name,
					weekLimit = var_36_22
				}
			}

			i18n = var_16
			var_36_29.tip = var_16("dorm3d_shop_gift_tip")
			var_36_29.drop = var_36_5
			var_36_29.groupId = arg_36_1.room_id

			function var_36_29.onYes()
				local var_40_0 = arg_36_0
				local var_40_1 = var_0.emit

				GAME = var_2_10002

				local var_40_2 = var_2_10002.SHOPPING
				local var_40_3 = {
					silentTip = true,
					count = 1
				}
				local var_40_4 = var_36_5

				var_40_3.shopId = var_4.GetShopID(var_40_4)

				var_40_1(var_40_0, var_40_2, var_40_3)

				return
			end

			var_36_27(var_36_26, var_36_28, var_36_29)
		end
	elseif arg_36_1.type == 3 then
		local var_36_30

		getProxy = var_36_5
		ApartmentProxy = var_1_10005

		local var_36_31 = var_36_5(var_1_10005)

		if not var_4.getRoom(var_36_31, arg_36_1.item_id) then
			pg = var_36_31

			local var_36_32 = var_36_31.TipsMgr.GetInstance()
			local var_36_33 = var_5.ShowTips

			i18n = iter_36_2

			var_36_33(var_36_32, iter_36_2("dorm3d_role_locked"))

			return
		end

		if not var_4.unlockCharacter[arg_36_1.room_id] then
			var_36_30 = "lock"
		else
			getProxy = var_36_37
			ApartmentProxy = var_6

			local var_36_34 = var_36_37(var_6)

			if not var_36_37.getApartment(var_36_34, arg_36_1.room_id) then
				var_36_30 = "room"
			else
				Apartment = var_36_37

				local var_36_35 = var_36_37.New({
					ship_group = arg_36_1.room_id
				})

				if var_36_37.needDownload(var_36_35) then
					var_36_30 = "download"
				end
			end
		end

		local var_36_37

		if var_36_30 == "lock" then
			local var_36_36 = arg_36_0

			var_36_37 = arg_36_0.emit
			Dorm3dShopMediator = iter_36_2

			var_36_37(var_36_36, iter_36_2.OPEN_ROOM_UNLOCK_WINDOW, arg_36_1.item_id, arg_36_1.room_id)
		elseif var_36_30 == "room" then
			pg = var_36_37

			local var_36_38 = var_36_37.TipsMgr.GetInstance()

			var_36_37 = var_36_37.ShowTips
			i18n = iter_36_2

			var_36_37(var_36_38, iter_36_2("dorm3d_role_locked"))
		elseif var_36_30 == "download" then
			pg = var_36_37

			local var_36_39 = var_36_37.TipsMgr.GetInstance()
			local var_36_40 = var_5.ShowTips

			i18n = iter_36_2

			var_36_40(var_36_39, iter_36_2("dorm3d_guide_beach_tip"))
		end
	end

	return
end

function var_0_1.SetBubbles(arg_41_0, arg_41_1, arg_41_2)
	arg_41_1:make(function(arg_42_0, arg_42_1, arg_42_2)
		UIItemList = var_2_10003

		if arg_42_0 == var_2_10003.EventInit then
			local var_42_0 = arg_42_1 + 1
			local var_42_1 = arg_41_2[var_42_0]

			LoadImageSpriteAtlasAsync = var_2_10005

			var_2_10005("ui/shoptip_atlas", "icon_" .. var_42_1, arg_42_2:Find("icon/icon"), true)

			setText = var_2_10005

			local var_42_2 = arg_42_2
			local var_42_3 = arg_42_2.Find(var_42_2, "bubble/Text")

			i18n = var_42_2

			var_2_10005(var_42_3, var_42_2("dorm3d_shop_tag" .. var_42_1))

			setActive = var_2_10005

			var_2_10005(arg_42_2:Find("bubble"), false)

			onToggle = var_2_10005

			var_2_10005(arg_41_0, arg_42_2, function(arg_43_0)
				setActive = var_3_10001

				local var_43_0 = arg_42_2

				var_3_10001(var_2.Find(var_43_0, "icon/select"), arg_43_0)

				setActive = var_3_10001

				local var_43_1 = arg_42_2

				var_3_10001(var_2.Find(var_43_1, "icon/unselect"), not arg_43_0)

				setActive = var_3_10001

				local var_43_2 = arg_42_2

				var_3_10001(var_2.Find(var_43_2, "bubble"), arg_43_0)

				setActive = var_3_10001

				var_3_10001(arg_41_0.mask, arg_43_0)

				onButton = var_3_10001

				local var_43_3 = arg_41_0
				local var_43_4 = arg_41_0.mask

				local function var_43_5()
					triggerToggle = var_4_10000

					var_4_10000(arg_42_2, false)

					return
				end

				SFX_PANEL = var_3_10005

				var_3_10001(var_43_3, var_43_4, var_43_5, var_3_10005)

				return
			end)
		end

		return
	end)
	arg_41_1:align(#arg_41_2)

	return
end

function var_0_1.GetTimeRemain(arg_45_0, arg_45_1)
	pg = var_1_10002

	local var_45_0 = var_1_10002.TimeMgr.GetInstance()
	local var_45_1 = var_2.GetServerTime(var_45_0)

	math = var_45_0

	local var_45_2 = var_45_0.max(arg_45_1 - var_45_1, 0)

	math = var_4

	local var_45_3 = var_4.floor(var_45_2 / 0)
	local var_45_4

	if 0 < var_45_3 then
		var_45_4 = var_45_3
		i18n = var_1_10006

		return var_45_4 .. var_1_10006("word_date")
	else
		math = var_45_4

		local var_45_5 = var_45_4.floor(var_45_2 / 16)
		local var_45_6

		if 0 < var_45_5 then
			var_45_6 = var_45_5
			i18n = var_1_10007

			return var_45_6 .. var_1_10007("word_hour")
		else
			math = var_45_6

			if var_45_6.floor(var_45_2 / 60) > 0 then
				local var_45_7 = var_6

				i18n = var_1_10008

				return var_45_7 .. var_1_10008("word_minute")
			else
				local var_45_8 = var_45_2

				i18n = var_1_10008

				return var_45_8 .. var_1_10008("word_second")
			end
		end
	end

	return
end

function var_0_1.ShouldShowCommodtyTip(arg_46_0)
	if arg_46_0.room_id ~= 0 then
		local var_46_0 = 0

		ipairs = var_1_10002

		for iter_46_0, iter_46_1 in var_1_10002(var_0_5.all) do
			if var_0_5[iter_46_1].type == 2 and var_7.character[1] == arg_46_0.room_id then
				var_46_0 = iter_46_1
			end
		end

		getProxy = var_1_10002
		ApartmentProxy = var_3

		local var_46_1 = var_1_10002(var_3)

		if not var_1_10002.getRoom(var_46_1, var_46_0) then
			return false
		end
	end

	if arg_46_0.realroom_id ~= 0 then
		getProxy = var_1
		ApartmentProxy = var_1_10002
		var_1_10002 = var_1(var_1_10002)

		if not var_1.getRoom(var_1_10002, arg_46_0.realroom_id) then
			return false
		end
	end

	if arg_46_0.type == 1 then
		Dorm3dFurniture = var_1

		do return var_1.NeedViewTipByFurnitureId(arg_46_0.item_id) end

		goto label_46_0
	end

	if arg_46_0.type == 2 then
		getProxy = var_1
		PlayerProxy = var_1_10002

		local var_46_2 = var_1(var_1_10002)
		local var_46_3 = var_1.getRawData(var_46_2).id

		Dorm3dGift = var_46_2

		local var_46_4 = var_46_2.NeedViewTipByGiftId(arg_46_0.item_id)

		if var_0_4[arg_46_0.shop_id[1]].group ~= 0 then
			PlayerPrefs = var_3

			do
				local var_46_5

				if var_3.GetInt(var_46_3 .. "_dorm3dGiftWeekViewed_" .. arg_46_0.item_id, 0) ~= 0 then
					var_46_5 = false
				else
					var_46_5 = true
				end

				return var_46_4 or var_46_5
			end

			::label_46_0::

			return false
		end
	end
end

function var_0_1.ShouldShowSumTip(arg_47_0)
	ipairs = var_1_10001

	for iter_47_0, iter_47_1 in var_1_10001(arg_47_0) do
		if var_0_1.ShouldShowCommodtyTip(iter_47_1) then
			return true
		end
	end

	return false
end

function var_0_1.ShouldShowAllTip()
	local var_48_0 = {}

	ipairs = var_1_10001

	for iter_48_0, iter_48_1 in var_1_10001(var_0_3.all) do
		local var_48_1 = var_0_3[iter_48_1]
		local var_48_2 = false
		local var_48_3 = var_48_1.shop_id

		ipairs = var_1_10009

		for iter_48_2, iter_48_3 in var_1_10009(var_48_3) do
			local var_48_4 = var_0_4[iter_48_3]

			pg = var_1_10015

			local var_48_5 = var_1_10015.TimeMgr.GetInstance()

			if not var_1_10015.inTime(var_48_5, var_48_4.time) then
				var_48_2 = true

				break
			end
		end

		if not var_48_2 then
			table = var_1_10009

			var_1_10009.insert(var_48_0, var_48_1)
		end
	end

	return var_0_1.ShouldShowSumTip(var_48_0)
end

function var_0_1.UpdateCommodtyTip(arg_49_0)
	if arg_49_0.type == 1 then
		Dorm3dFurniture = var_1

		var_1.SetViewedFlag(arg_49_0.item_id)
	elseif arg_49_0.type == 2 then
		Dorm3dGift = var_1

		var_1.SetViewedFlag(arg_49_0.item_id)

		if var_0_4[arg_49_0.shop_id[1]].group ~= 0 then
			getProxy = var_1
			PlayerProxy = var_2

			local var_49_0 = var_1(var_2)
			local var_49_1 = var_1.getRawData(var_49_0).id

			PlayerPrefs = var_49_0

			var_49_0.SetInt(var_49_1 .. "_dorm3dGiftWeekViewed_" .. arg_49_0.item_id, 1)
		end
	end

	return
end

function var_0_1.UpdateSumTip(arg_50_0)
	ipairs = var_1_10001

	for iter_50_0, iter_50_1 in var_1_10001(arg_50_0) do
		var_0_1.UpdateCommodtyTip(iter_50_1)
	end

	return
end

function var_0_1.willExit(arg_51_0)
	local var_51_0 = arg_51_0.scrollSnap

	var_1.Dispose(var_51_0)

	arg_51_0.scrollSnap = nil

	return
end

function var_0_1.onBackPressed(arg_52_0)
	arg_52_0:closeView()

	return
end

return var_0_1
