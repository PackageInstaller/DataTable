class = var_0_10000

local var_0_0 = "IslandShopPage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("..ship.IslandBaseShipDisplayPage"))
local var_0_2 = 3

pg = var_2

local var_0_3 = var_2.island_item_data_template

var_0_1.CharaSetModel = {
	current = 1,
	default = 2
}

function var_0_1.getUIName(arg_1_0)
	return "IslandShopUI"
end

function var_0_1.OnLoaded(arg_2_0)
	local var_2_0 = arg_2_0._tf

	arg_2_0.bg = var_1.Find(var_2_0, "bg")

	local var_2_1 = arg_2_0.bg

	arg_2_0.bgColor = var_1.Find(var_2_1, "color")

	local var_2_2 = arg_2_0._tf

	arg_2_0.closeBtn = var_1.Find(var_2_2, "adapt/top/closeBtn")

	local var_2_3 = arg_2_0._tf

	arg_2_0.helpBtn = var_1.Find(var_2_3, "adapt/top/helpBtn")

	local var_2_4 = arg_2_0._tf

	arg_2_0.title = var_1.Find(var_2_4, "adapt/top/title")
	UIItemList = var_1

	local var_2_5 = var_1.New
	local var_2_6 = arg_2_0._tf
	local var_2_7 = var_2.Find(var_2_6, "adapt/top/resources")
	local var_2_8 = arg_2_0._tf

	arg_2_0.resourceList = var_2_5(var_2_7, var_3.Find(var_2_8, "adapt/top/resources/resourceTpl"))
	UIItemList = var_1

	local var_2_9 = var_1.New
	local var_2_10 = arg_2_0._tf
	local var_2_11 = var_2.Find(var_2_10, "adapt/shop1List")
	local var_2_12 = arg_2_0._tf

	arg_2_0.shop1List = var_2_9(var_2_11, var_3.Find(var_2_12, "adapt/shop1List/shop1Tpl"))

	local var_2_13 = arg_2_0._tf

	arg_2_0.shop3 = var_1.Find(var_2_13, "adapt/shop3List")
	UIItemList = var_1

	local var_2_14 = var_1.New
	local var_2_15 = arg_2_0._tf
	local var_2_16 = var_2.Find(var_2_15, "adapt/shop3List")
	local var_2_17 = arg_2_0._tf

	arg_2_0.shop3List = var_2_14(var_2_16, var_3.Find(var_2_17, "adapt/shop3List/shop3Tpl"))

	local var_2_18 = arg_2_0._tf

	arg_2_0.shop32 = var_1.Find(var_2_18, "adapt/shop3List2")
	UIItemList = var_1

	local var_2_19 = var_1.New
	local var_2_20 = arg_2_0._tf
	local var_2_21 = var_2.Find(var_2_20, "adapt/shop3List2")
	local var_2_22 = arg_2_0._tf

	arg_2_0.shop3List2 = var_2_19(var_2_21, var_3.Find(var_2_22, "adapt/shop3List2/shop3Tpl"))

	local var_2_23 = arg_2_0._tf

	arg_2_0.recommendationPage5 = var_1.Find(var_2_23, "adapt/shopPage/recommendation5")

	local var_2_24 = arg_2_0._tf

	arg_2_0.recommendationPage1 = var_1.Find(var_2_24, "adapt/shopPage/recommendation1")

	local var_2_25 = arg_2_0._tf

	arg_2_0.shop2DPage = var_1.Find(var_2_25, "adapt/shopPage/shop2D")

	local var_2_26 = arg_2_0._tf

	arg_2_0.shop3DPage = var_1.Find(var_2_26, "adapt/shopPage/shop3D")

	local var_2_27 = arg_2_0._tf

	arg_2_0.shopFurniturePage = var_1.Find(var_2_27, "adapt/shopPage/shopFurniture")

	local var_2_28 = arg_2_0._tf

	arg_2_0.shopSkinPage = var_1.Find(var_2_28, "adapt/shopPage/shopSkin")

	local var_2_29 = arg_2_0.shopSkinPage

	arg_2_0.morphBtn = var_1.Find(var_2_29, "morphBtn")

	local var_2_30 = arg_2_0._tf

	arg_2_0.morphBlocker = var_1.Find(var_2_30, "morph_blocker")
	setActive = var_1

	var_1(arg_2_0.morphBlocker, false)

	local var_2_31 = arg_2_0.shopSkinPage

	arg_2_0.changeCharaPanel = var_1.Find(var_2_31, "changeCharaPanel/panel")

	local var_2_32 = arg_2_0._tf

	arg_2_0.subPageContainer = var_1.Find(var_2_32, "adapt/subPageContainer")
	IslandShopDrawAwardPage = var_1
	arg_2_0.drawAwardPage = var_1.New(arg_2_0.subPageContainer, arg_2_0)
	setText = var_1

	local var_2_33 = arg_2_0.shopSkinPage
	local var_2_34 = var_2.Find(var_2_33, "changeCharaPanel/panel/title")

	i18n = var_2_33

	var_1(var_2_34, var_2_33("island_3Dshop_chara_choose"))

	setText = var_1

	local var_2_35 = arg_2_0.shopSkinPage
	local var_2_36 = var_2.Find(var_2_35, "changeCharaPanel/panel/setTxt")

	i18n = var_2_35

	var_1(var_2_36, var_2_35("island_3Dshop_chara_set"))

	IslandShopExchangePage = var_1
	arg_2_0.exchangSubView = var_1.New(arg_2_0._tf, arg_2_0)

	local var_2_37 = arg_2_0.exchangSubView

	var_1.RegisterView(var_2_37, arg_2_0)

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
	local var_3_4 = arg_3_0.helpBtn

	local function var_3_5()
		local var_5_0 = arg_3_0
		local var_5_1 = var_0.ShowMsgBox
		local var_5_2 = {
			hideNo = true
		}

		IslandMsgBox = var_2_10003
		var_5_2.type = var_2_10003.TYPE_COMMON
		i18n = var_3
		var_5_2.content = var_3("island_draw_help")
		TextAnchor = var_3
		var_5_2.alignment = var_3.MiddleLeft

		var_5_1(var_5_0, var_5_2)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_3_3, var_3_4, var_3_5, var_1_10005)
	arg_3_0:InitData()

	return
end

function var_0_1.InitData(arg_6_0)
	getProxy = var_1_10001
	IslandProxy = var_1_10002

	local var_6_0 = var_1_10001(var_1_10002)
	local var_6_1 = var_1.GetIsland(var_6_0)

	arg_6_0.shopAgency = var_1.GetShopAgency(var_6_1)
	getProxy = var_1
	IslandProxy = var_6_1

	local var_6_2 = var_1(var_6_1)
	local var_6_3 = var_1.GetIsland(var_6_2)

	arg_6_0.inventoryAgency = var_1.GetInventoryAgency(var_6_3)
	getProxy = var_1
	IslandProxy = var_6_3

	local var_6_4 = var_1(var_6_3)
	local var_6_5 = var_1.GetIsland(var_6_4)

	arg_6_0.characterAgency = var_1.GetCharacterAgency(var_6_5)
	getProxy = var_1
	PlayerProxy = var_6_5

	local var_6_6 = var_1(var_6_5)

	arg_6_0.player = var_1.getRawData(var_6_6)

	local var_6_7 = arg_6_0.characterAgency

	arg_6_0.ships = var_1.GetShips(var_6_7)
	PlayerPrefs = var_1
	arg_6_0.defaultShipId = var_1.GetInt("island_dressShop_defaultShipId_" .. arg_6_0.player.id, 10703)
	IslandShipDressHelperNew = var_1
	arg_6_0.islandShipDressHelper = var_1.New()

	return
end

function var_0_1.DoUpdateShops(arg_7_0)
	local var_7_0 = arg_7_0.shopAgency

	if #var_1.GetNewOrOverdueShopIds(var_7_0) > 0 then
		ipairs = var_2

		for iter_7_0, iter_7_1 in var_2(var_1) do
			local var_7_1 = arg_7_0
			local var_7_2 = arg_7_0.emit

			IslandMediator = var_1_10009

			var_7_2(var_7_1, var_1_10009.GET_SHOP_DATA, iter_7_1, true)
		end
	end

	arg_7_0.showingShop = nil
	arg_7_0.selectShipId = arg_7_0.defaultShipId

	return
end

function var_0_1.DoUpdateShowingShop(arg_8_0)
	local var_8_0 = arg_8_0.showingShop
	local var_8_2

	if var_1.IsInTime(var_8_0) then
		local var_8_1 = arg_8_0

		var_8_2 = arg_8_0.emit
		IslandMediator = var_1_10003

		var_8_2(var_8_1, var_1_10003.GET_SHOP_DATA, arg_8_0.showingShop.id, false)
	else
		arg_8_0:SetShopPage()
	end

	isActive = var_8_2

	if not var_8_2(arg_8_0.shop3) then
		isActive = var_1

		if var_1(arg_8_0.shop32) then
			local var_8_3 = arg_8_0.showingShop
			local var_8_4 = var_1.GetShowType(var_8_3)

			setActive = var_8_3

			local var_8_5 = arg_8_0.shop3

			IslandConst = var_1_10004

			local var_8_6

			if var_8_4 ~= var_1_10004.SHOP_TYPE_RECOMMENDATION_5 then
				IslandConst = var_4

				if var_8_4 ~= var_4.SHOP_TYPE_RECOMMENDATION_1 then
					IslandConst = var_4

					if var_8_4 ~= var_4.SHOP_TYPE_2D then
						var_8_6 = false

						goto label_8_0
					end
				end
			end

			var_8_6 = true

			::label_8_0::

			var_8_3(var_8_5, var_8_6)

			setActive = var_8_3

			local var_8_7 = arg_8_0.shop32

			IslandConst = var_8_6

			local var_8_8

			if var_8_4 ~= var_8_6.SHOP_TYPE_3D then
				IslandConst = var_4

				if var_8_4 ~= var_4.SHOP_TYPE_FURNITURE then
					IslandConst = var_4

					if var_8_4 ~= var_4.SHOP_TYPE_SKIN then
						var_8_8 = false

						goto label_8_1
					end
				end
			end

			var_8_8 = true

			::label_8_1::

			var_8_3(var_8_7, var_8_8)
		end

		return
	end
end

function var_0_1.UpdateData(arg_9_0)
	local var_9_0 = arg_9_0.shopAgency

	arg_9_0.firstShopConfigs = var_1.GetFirstShopConfigs(var_9_0, arg_9_0.showTypes, arg_9_0.firstShopIds)

	if arg_9_0.showingShop then
		local var_9_1 = arg_9_0.shopAgency

		if not var_1.IsShowShop(var_9_1, arg_9_0.showingShop.id) then
			local var_9_2 = arg_9_0.shopAgency

			arg_9_0.showingShop = var_1.GetInitShowingShop(var_9_2, arg_9_0.showTypes, arg_9_0.firstShopIds)
		end

		return
	end
end

function var_0_1.SetShopPageVisible(arg_10_0, arg_10_1)
	setActive = var_1_10002

	local var_10_0 = arg_10_0._tf

	var_1_10002(var_3.Find(var_10_0, "adapt/shopPage"), arg_10_1)

	IsNil = var_1_10002

	if not var_1_10002(arg_10_0.roleContainer) then
		setActive = var_2

		var_2(arg_10_0.roleContainer, arg_10_1)
	end

	return
end

function var_0_1.GetShopConfigIds(arg_11_0, arg_11_1)
	local var_11_0 = {}

	ipairs = var_1_10003

	for iter_11_0, iter_11_1 in var_1_10003(arg_11_1) do
		table = var_1_10008

		var_1_10008.insert(var_11_0, iter_11_1.id)
	end

	return var_11_0
end

function var_0_1.GetRecommendationTargetShop(arg_12_0, arg_12_1)
	if not arg_12_1 then
		return nil
	end

	if arg_12_1.shop_type ~= 0 then
		local var_12_0 = arg_12_0.shopAgency

		return var_2.GetShopById(var_12_0, arg_12_1.id)
	end

	if arg_12_1.tag_type == 1 then
		local var_12_1 = arg_12_0.shopAgency
		local var_12_2 = var_2.GetSecondShopConfigs(var_12_1, arg_12_0.showTypes, arg_12_1.id)

		ipairs = var_12_1

		for iter_12_0, iter_12_1 in var_12_1(var_12_2) do
			if arg_12_0:GetRecommendationTargetShop(iter_12_1) then
				return var_8
			end
		end
	elseif arg_12_1.tag_type == 2 then
		local var_12_3 = arg_12_0.shopAgency
		local var_12_4 = var_2.GetThirdShopConfigs(var_12_3, arg_12_0.showTypes, arg_12_1.id)

		ipairs = var_12_3

		for iter_12_2, iter_12_3 in var_12_3(var_12_4) do
			if arg_12_0:GetRecommendationTargetShop(iter_12_3) then
				return var_8
			end
		end
	end

	return nil
end

function var_0_1.JumpToRecommendationShop(arg_13_0, arg_13_1)
	local var_13_0 = arg_13_0
	local var_13_1 = arg_13_0.GetRecommendationTargetShop

	pg = var_1_10004

	if not var_13_1(var_13_0, var_1_10004.island_shop_template[arg_13_1]) then
		return
	end

	arg_13_0.showingShop = var_2

	local var_13_2 = arg_13_0.showingShop

	if var_3.IsInTime(var_13_2) then
		local var_13_3 = arg_13_0
		local var_13_4 = arg_13_0.emit

		IslandMediator = var_1_10005

		var_13_4(var_13_3, var_1_10005.GET_SHOP_DATA, arg_13_0.showingShop.id, true)
	else
		arg_13_0:UpdateData()
		arg_13_0:SetShopList()
	end

	return
end

function var_0_1.SetThirdShopTpl(arg_14_0, arg_14_1, arg_14_2)
	setActive = var_1_10003

	var_1_10003(arg_14_1:Find("selected"), arg_14_0.showingShop.id == arg_14_2.id)

	setText = var_1_10003

	var_1_10003(arg_14_1:Find("name"), arg_14_2.tag_icon[1])

	setText = var_1_10003

	var_1_10003(arg_14_1:Find("selected/name"), arg_14_2.tag_icon[1])

	setActive = var_1_10003

	var_1_10003(arg_14_1:Find("icon"), arg_14_2.tag_icon[3])

	if arg_14_2.tag_icon[3] then
		LoadImageSpriteAsync = var_3

		var_3(arg_14_2.tag_icon[3], arg_14_1:Find("icon"), false)
	end

	local var_14_0 = arg_14_0.shopAgency
	local var_14_1 = var_3.GetShopById(var_14_0, arg_14_2.id)
	local var_14_2 = var_3.IsInTime(var_14_1)

	setActive = var_14_1

	var_14_1(arg_14_1:Find("lock"), not var_14_2)

	setActive = var_14_1

	var_14_1(arg_14_1:Find("selected/lock"), not var_14_2)

	return
end

function var_0_1.SelectThirdShop(arg_15_0, arg_15_1, arg_15_2, arg_15_3, arg_15_4, arg_15_5, arg_15_6, arg_15_7)
	if arg_15_0.currentShop1TgIndex == arg_15_4 and arg_15_0.currentShop2TgIndex == arg_15_5 and arg_15_0.currentShop3TgIndex == arg_15_6 then
		return
	end

	for iter_15_0 = 0, arg_15_2.childCount - 1 do
		setActive = var_1_10012

		local var_15_0 = arg_15_2:GetChild(iter_15_0)

		var_1_10012(var_13.Find(var_15_0, "selected"), false)
	end

	setActive = var_8

	var_8(arg_15_1:Find("selected"), true)

	if arg_15_7 then
		local var_15_1 = arg_15_1
		local var_15_2 = arg_15_1.GetComponent

		typeof = var_10
		Animation = var_11

		local var_15_3 = var_15_2(var_15_1, var_10(var_11))

		var_8.Play(var_15_3, "anim_IslandShopUI_Shop3List_Selected")
	end

	local var_15_4 = arg_15_0.shopAgency

	arg_15_0.showingShop = var_8.GetShopById(var_15_4, arg_15_3.id)

	arg_15_0:DoUpdateShowingShop()

	arg_15_0.currentShop3TgIndex = arg_15_6

	return
end

function var_0_1.BindThirdShopList(arg_16_0, arg_16_1, arg_16_2, arg_16_3, arg_16_4, arg_16_5, arg_16_6)
	local var_16_0 = arg_16_0:GetShopConfigIds(arg_16_3)
	local var_16_1 = arg_16_1
	local var_16_2 = arg_16_1.make

	local function var_16_3(arg_17_0, arg_17_1, arg_17_2)
		UIItemList = var_2_10003

		if arg_17_0 ~= var_2_10003.EventUpdate then
			return
		end

		local var_17_0 = arg_17_1 + 1
		local var_17_1 = arg_16_3[var_17_0]
		local var_17_2 = arg_16_0

		var_5.SetThirdShopTpl(var_17_2, arg_17_2, var_17_1)

		onToggle = var_5

		local var_17_3 = arg_16_0
		local var_17_4 = arg_17_2

		local function var_17_5(arg_18_0)
			if arg_18_0 then
				local var_18_0 = arg_16_0

				var_1.SelectThirdShop(var_18_0, arg_17_2, arg_16_2, var_17_1, arg_16_4, arg_16_5, var_17_0, arg_16_6)
			end

			return
		end

		SFX_PANEL = var_2_10009

		var_5(var_17_3, var_17_4, var_17_5, var_2_10009)

		if arg_16_0.showingShop.id == var_17_1.id then
			triggerToggle = var_5

			var_5(arg_17_2, true)
		end

		if arg_17_1 == 0 then
			table = var_5

			if not var_5.contains(var_16_0, arg_16_0.showingShop.id) then
				triggerToggle = var_5

				var_5(arg_17_2, true)
			end
		end

		return
	end

	SFX_PANEL = var_1_10011

	var_16_2(var_16_1, var_16_3, var_1_10011)
	arg_16_1:align(#arg_16_3)

	return
end

function var_0_1.BindThirdShopLists(arg_19_0, arg_19_1, arg_19_2, arg_19_3)
	arg_19_0:BindThirdShopList(arg_19_0.shop3List, arg_19_0.shop3, arg_19_1, arg_19_2, arg_19_3, true)
	arg_19_0:BindThirdShopList(arg_19_0.shop3List2, arg_19_0.shop32, arg_19_1, arg_19_2, arg_19_3, false)

	return
end

function var_0_1.SetSecondShopTpl(arg_20_0, arg_20_1, arg_20_2)
	setActive = var_1_10003

	local var_20_0 = arg_20_1:Find("selected")
	local var_20_2

	if arg_20_0.showingShop.id ~= arg_20_2.id then
		local var_20_1 = arg_20_0.showingShop

		if var_5.GetSecondShopId(var_20_1) ~= arg_20_2.id then
			var_20_2 = false

			goto label_20_0
		end
	end

	var_20_2 = true

	::label_20_0::

	var_1_10003(var_20_0, var_20_2)

	setText = var_1_10003

	var_1_10003(arg_20_1:Find("name"), arg_20_2.tag_icon[1])

	setText = var_1_10003

	var_1_10003(arg_20_1:Find("selected/name"), arg_20_2.tag_icon[1])

	return
end

function var_0_1.SelectSecondShop(arg_21_0, arg_21_1, arg_21_2, arg_21_3, arg_21_4)
	if arg_21_0.currentShop1TgIndex == arg_21_3 and arg_21_0.currentShop2TgIndex == arg_21_4 then
		return
	end

	local var_21_0 = arg_21_1
	local var_21_1 = arg_21_1.GetComponent

	typeof = var_1_10007
	Animation = var_1_10008

	local var_21_2 = var_21_1(var_21_0, var_1_10007(var_1_10008))

	var_5.Play(var_21_2, "anim_IslandShopUI_Shop2List_Selected")

	setActive = var_5

	var_5(arg_21_0.shop3, arg_21_2.shop_type == 0)

	setActive = var_5

	var_5(arg_21_0.shop32, arg_21_2.shop_type == 0)

	if arg_21_2.shop_type == 0 then
		local var_21_3 = arg_21_0.shopAgency
		local var_21_4 = var_5.GetThirdShopConfigs(var_21_3, arg_21_0.showTypes, arg_21_2.id)

		arg_21_0:BindThirdShopLists(var_21_4, arg_21_3, arg_21_4)
	else
		local var_21_5 = arg_21_0.shopAgency

		arg_21_0.showingShop = var_5.GetShopById(var_21_5, arg_21_2.id)

		arg_21_0:DoUpdateShowingShop()
	end

	arg_21_0.currentShop2TgIndex = arg_21_4

	return
end

function var_0_1.BindSecondShopList(arg_22_0, arg_22_1, arg_22_2, arg_22_3)
	local var_22_0 = arg_22_0.shopAgency
	local var_22_1 = var_4.GetSecondShopConfigs(var_22_0, arg_22_0.showTypes, arg_22_2.id)
	local var_22_2 = arg_22_0
	local var_22_3 = arg_22_0.GetShopConfigIds(var_22_2, var_22_1)

	UIItemList = var_22_2

	local var_22_4 = var_22_2.New(arg_22_1:Find("shop2List"), arg_22_1:Find("shop2List/shop2Tpl"))

	var_6.make(var_22_4, function(arg_23_0, arg_23_1, arg_23_2)
		UIItemList = var_2_10003

		if arg_23_0 ~= var_2_10003.EventUpdate then
			return
		end

		local var_23_0 = arg_23_1 + 1
		local var_23_1 = var_22_1[var_23_0]
		local var_23_2 = arg_22_0

		var_5.SetSecondShopTpl(var_23_2, arg_23_2, var_23_1)

		onToggle = var_5

		local var_23_3 = arg_22_0
		local var_23_4 = arg_23_2

		local function var_23_5(arg_24_0)
			if arg_24_0 then
				local var_24_0 = arg_22_0

				var_1.SelectSecondShop(var_24_0, arg_23_2, var_23_1, arg_22_3, var_23_0)
			end

			return
		end

		SFX_PANEL = var_2_10009

		var_5(var_23_3, var_23_4, var_23_5, var_2_10009)

		if arg_22_0.showingShop.id ~= var_23_1.id then
			local var_23_6 = arg_22_0.showingShop

			if var_5.GetSecondShopId(var_23_6) == var_23_1.id then
				triggerToggle = var_5

				var_5(arg_23_2, true)
			end

			if arg_23_1 == 0 then
				table = var_5

				if not var_5.contains(var_22_3, arg_22_0.showingShop.id) then
					table = var_5

					local var_23_7 = var_5.contains
					local var_23_8 = var_22_3
					local var_23_9 = arg_22_0.showingShop

					if not var_23_7(var_23_8, var_7.GetSecondShopId(var_23_9)) then
						triggerToggle = var_5

						var_5(arg_23_2, true)
					end
				end
			end

			return
		end
	end)
	var_6:align(#var_22_1)

	return
end

function var_0_1.SelectFirstShop(arg_25_0, arg_25_1, arg_25_2, arg_25_3)
	if arg_25_0.currentShop1TgIndex == arg_25_3 then
		return
	end

	arg_25_0:SetShopPageVisible(true)

	setActive = var_4

	var_4(arg_25_0.shop3, false)

	setActive = var_4

	var_4(arg_25_0.shop32, false)

	local var_25_0 = arg_25_1
	local var_25_1 = arg_25_1.GetComponent

	typeof = var_6
	Animation = var_1_10007

	local var_25_2 = var_25_1(var_25_0, var_6(var_1_10007))

	var_4.Play(var_25_2, "anim_IslandShopUI_Shop1List_Selected")

	setActive = var_4

	var_4(arg_25_1:Find("shop2List"), arg_25_2.shop_type == 0)

	if arg_25_2.shop_type == 0 then
		arg_25_0:BindSecondShopList(arg_25_1, arg_25_2, arg_25_3)
	else
		local var_25_3 = arg_25_0.shopAgency

		arg_25_0.showingShop = var_4.GetShopById(var_25_3, arg_25_2.id)

		arg_25_0:DoUpdateShowingShop()
	end

	arg_25_0.currentShop1TgIndex = arg_25_3

	return
end

function var_0_1.BindFirstShopTab(arg_26_0, arg_26_1, arg_26_2, arg_26_3)
	setActive = var_1_10004

	var_1_10004(arg_26_1:Find("shop2List"), false)

	GetImageSpriteFromAtlasAsync = var_1_10004

	var_1_10004("island/islandshopicon", arg_26_2.tag_icon[3], arg_26_1:Find("shop1Tg/selected/icon"), false)

	setText = var_1_10004

	var_1_10004(arg_26_1:Find("shop1Tg/name"), arg_26_2.tag_icon[1])

	setText = var_1_10004

	var_1_10004(arg_26_1:Find("shop1Tg/name/en"), arg_26_2.tag_icon[2])

	onToggle = var_1_10004

	local var_26_0 = arg_26_0
	local var_26_1 = arg_26_1:Find("shop1Tg")

	local function var_26_2(arg_27_0)
		if arg_27_0 then
			local var_27_0 = arg_26_0

			var_2_10001.SelectFirstShop(var_27_0, arg_26_1, arg_26_2, arg_26_3)
		else
			setActive = var_2_10001

			local var_27_1 = arg_26_1

			var_2_10001(var_2.Find(var_27_1, "shop2List"), false)
		end

		return
	end

	SFX_PANEL = var_8

	var_1_10004(var_26_0, var_26_1, var_26_2, var_8)

	if arg_26_0.showingShop.id ~= arg_26_2.id then
		local var_26_3 = arg_26_0.showingShop

		if var_4.GetFirstShopId(var_26_3) == arg_26_2.id then
			triggerToggle = var_4

			var_4(arg_26_1:Find("shop1Tg"), true)
		end

		return
	end
end

function var_0_1.BindDrawAwardTab(arg_28_0, arg_28_1, arg_28_2)
	setActive = var_1_10003

	var_1_10003(arg_28_1:Find("shop2List"), false)

	setText = var_1_10003

	local var_28_0 = arg_28_1
	local var_28_1 = arg_28_1.Find(var_28_0, "shop1Tg/name")

	i18n = var_28_0

	var_1_10003(var_28_1, var_28_0("island_draw_tab"))

	setText = var_1_10003

	local var_28_2 = arg_28_1
	local var_28_3 = arg_28_1.Find(var_28_2, "shop1Tg/name/en")

	i18n = var_28_2

	var_1_10003(var_28_3, var_28_2("island_draw_tab_en"))

	setActive = var_1_10003

	var_1_10003(arg_28_1:Find("shop1Tg/selected/icon"), false)

	onToggle = var_1_10003

	local var_28_4 = arg_28_0
	local var_28_5 = arg_28_1:Find("shop1Tg")

	local function var_28_6(arg_29_0)
		if arg_29_0 then
			if arg_28_0.currentShop1TgIndex == arg_28_2 then
				return
			end

			arg_28_0.currentShop1TgIndex = arg_28_2

			local var_29_0 = arg_28_1
			local var_29_1 = var_1.GetComponent

			typeof = var_2_10003
			Animation = var_2_10004

			local var_29_2 = var_29_1(var_29_0, var_2_10003(var_2_10004))

			var_1.Play(var_29_2, "anim_IslandShopUI_Shop1List_Selected")

			setText = var_1

			local var_29_3 = arg_28_0.title
			local var_29_4 = var_2.Find(var_29_3, "Text")

			i18n = var_29_3

			var_1(var_29_4, var_29_3("island_draw_tab"))

			local var_29_5 = arg_28_0

			var_1.SetResources(var_29_5)

			local var_29_6 = arg_28_0

			var_1.SetShopPageVisible(var_29_6, false)

			setActive = var_1

			var_1(arg_28_0.shop3, false)

			setActive = var_1

			var_1(arg_28_0.shop32, false)

			local var_29_7 = arg_28_0.drawAwardPage

			var_1.ActionInvoke(var_29_7, "UpdateActivity", arg_28_0.drawAwardActivity)

			local var_29_8 = arg_28_0.drawAwardPage

			var_1.ExecuteAction(var_29_8, "Show")
		else
			local var_29_9 = arg_28_0.drawAwardPage

			var_1.ExecuteAction(var_29_9, "Hide")
		end

		return
	end

	SFX_PANEL = var_7

	var_1_10003(var_28_4, var_28_5, var_28_6, var_7)

	return
end

function var_0_1.SetShopList(arg_30_0)
	arg_30_0.currentShop1TgIndex = nil
	arg_30_0.currentShop2TgIndex = nil
	arg_30_0.currentShop3TgIndex = nil
	arg_30_0.drawTabCnt = arg_30_0.showDrawAward and arg_30_0.drawAwardActivity and 1 or 0

	local var_30_0

	if not (arg_30_0.drawTabCnt > 0) or not (#arg_30_0.firstShopConfigs + 1) then
		var_30_0 = nil
	end

	arg_30_0.drawTabIdx = var_30_0
	arg_30_0.exchangeShowIds = (function()
		getProxy = var_2_10000
		IslandProxy = var_2_10001

		local var_31_0 = var_2_10000(var_2_10001)
		local var_31_1 = var_0.GetIsland(var_31_0)
		local var_31_2 = var_0.GetTaskAgency(var_31_1)

		if not var_0.IsFinishTask(var_31_2, var_0_2) then
			return {}
		end

		pg = var_31_2

		return var_31_2.island_exchange_group.all
	end)()

	local var_30_1

	if not arg_30_0.drawTabIdx or not (arg_30_0.drawTabIdx + 1) then
		var_30_1 = #arg_30_0.firstShopConfigs + 1
	end

	arg_30_0.exchangeTabStartIdx = var_30_1

	local var_30_2 = arg_30_0.shop1List

	var_2.make(var_30_2, function(arg_32_0, arg_32_1, arg_32_2)
		arg_32_1 = arg_32_1 + 1
		UIItemList = var_2_10003

		if arg_32_0 == var_2_10003.EventUpdate then
			if arg_30_0.firstShopConfigs[arg_32_1] then
				local var_32_0 = arg_30_0

				var_4.BindFirstShopTab(var_32_0, arg_32_2, var_3, arg_32_1)
			elseif arg_30_0.drawTabIdx and arg_32_1 == arg_30_0.drawTabIdx then
				local var_32_1 = arg_30_0

				var_4.BindDrawAwardTab(var_32_1, arg_32_2, arg_32_1)
			elseif #arg_30_0.exchangeShowIds > 0 and arg_32_1 >= arg_30_0.exchangeTabStartIdx then
				local var_32_2 = arg_30_0

				var_4.BindExchangeTab(var_32_2, arg_32_2, arg_32_1)
			end
		end

		return
	end)

	local var_30_3 = arg_30_0.shop1List

	var_2.align(var_30_3, #arg_30_0.firstShopConfigs + arg_30_0.drawTabCnt + #arg_30_0.exchangeShowIds)

	return
end

function var_0_1.SetShopPage(arg_33_0)
	local var_33_0 = arg_33_0.showingShop
	local var_33_1 = var_1.GetShowType(var_33_0)

	setText = var_33_0

	local var_33_2 = arg_33_0.title
	local var_33_3 = var_3.Find(var_33_2, "Text")
	local var_33_4 = arg_33_0.showingShop

	var_33_0(var_33_3, var_4.GetShopIcon(var_33_4)[1])

	setText = var_33_0

	local var_33_5 = arg_33_0.title
	local var_33_6 = var_3.Find(var_33_5, "Text/en")
	local var_33_7 = arg_33_0.showingShop

	var_33_0(var_33_6, var_4.GetShopIcon(var_33_7)[2])
	arg_33_0:SetResources()

	setActive = var_2

	local var_33_8 = arg_33_0.recommendationPage1

	IslandConst = var_4

	var_2(var_33_8, var_33_1 == var_4.SHOP_TYPE_RECOMMENDATION_1)

	setActive = var_2

	local var_33_9 = arg_33_0.recommendationPage5

	IslandConst = var_4

	var_2(var_33_9, var_33_1 == var_4.SHOP_TYPE_RECOMMENDATION_5)

	setActive = var_2

	local var_33_10 = arg_33_0.shop2DPage

	IslandConst = var_4

	var_2(var_33_10, var_33_1 == var_4.SHOP_TYPE_2D)

	setActive = var_2

	local var_33_11 = arg_33_0.shop3DPage

	IslandConst = var_4

	var_2(var_33_11, var_33_1 == var_4.SHOP_TYPE_3D)

	setActive = var_2

	local var_33_12 = arg_33_0.shopFurniturePage

	IslandConst = var_4

	var_2(var_33_12, var_33_1 == var_4.SHOP_TYPE_FURNITURE)

	setActive = var_2

	local var_33_13 = arg_33_0.shopSkinPage

	IslandConst = var_4

	var_2(var_33_13, var_33_1 == var_4.SHOP_TYPE_SKIN)

	switch = var_2

	local var_33_14 = var_33_1
	local var_33_15 = {}

	IslandConst = var_33_7
	var_33_15[var_33_7.SHOP_TYPE_RECOMMENDATION_1] = function()
		local var_34_0 = arg_33_0

		var_0.ShowRecommendation1(var_34_0)

		return
	end
	IslandConst = var_5
	var_33_15[var_5.SHOP_TYPE_RECOMMENDATION_5] = function()
		local var_35_0 = arg_33_0

		var_0.ShowRecommendation5(var_35_0)

		return
	end
	IslandConst = var_5
	var_33_15[var_5.SHOP_TYPE_2D] = function()
		local var_36_0 = arg_33_0

		var_0.ShowShop2D(var_36_0)

		return
	end
	IslandConst = var_5
	var_33_15[var_5.SHOP_TYPE_3D] = function()
		local var_37_0 = arg_33_0

		var_0.ShowShop3D(var_37_0)

		return
	end
	IslandConst = var_5
	var_33_15[var_5.SHOP_TYPE_FURNITURE] = function()
		local var_38_0 = arg_33_0

		var_0.ShowShopFurniture(var_38_0)

		return
	end
	IslandConst = var_5
	var_33_15[var_5.SHOP_TYPE_SKIN] = function()
		local var_39_0 = arg_33_0

		var_0.ShowShopSkin(var_39_0)

		return
	end

	var_2(var_33_14, var_33_15)

	return
end

function var_0_1.SetResources(arg_40_0)
	getProxy = var_1_10001
	PlayerProxy = var_1_10002

	local var_40_0 = var_1_10001(var_1_10002)

	arg_40_0.player = var_1.getRawData(var_40_0)

	local var_40_1 = not arg_40_0.firstShopConfigs[arg_40_0.currentShop1TgIndex]

	setActive = var_2

	var_2(arg_40_0.helpBtn, var_40_1)

	if var_40_1 then
		local var_40_2 = {}

		table = var_3

		local var_40_3 = var_3.insert
		local var_40_4 = var_40_2

		Drop = var_1_10005

		local var_40_5 = var_1_10005.New
		local var_40_6 = {}

		DROP_TYPE_VITEM = var_1_10007
		var_40_6.type = var_1_10007

		local var_40_7 = arg_40_0.drawAwardActivity

		var_40_6.id = var_7.GetDrawConfig(var_40_7, "cost_free")

		var_40_3(var_40_4, var_40_5(var_40_6))

		table = var_40_3

		local var_40_8 = var_40_3.insert
		local var_40_9 = var_40_2

		Drop = var_5

		local var_40_10 = var_5.New
		local var_40_11 = {}

		DROP_TYPE_RESOURCE = var_7
		var_40_11.type = var_7
		PlayerConst = var_7
		var_40_11.id = var_7.ResDiamond

		var_40_8(var_40_9, var_40_10(var_40_11))

		local var_40_12 = arg_40_0.resourceList

		var_3.make(var_40_12, function(arg_41_0, arg_41_1, arg_41_2)
			arg_41_1 = arg_41_1 + 1
			UIItemList = var_2_10003

			if arg_41_0 == var_2_10003.EventUpdate then
				local var_41_0 = var_40_2[arg_41_1]
				local var_41_1

				eachChild = var_2_10005

				var_2_10005(arg_41_2, function(arg_42_0, arg_42_1)
					setActive = var_3_10002

					var_3_10002(arg_42_0, arg_42_0.name == "islandItem")

					if arg_42_0.name == "islandItem" then
						var_41_1 = arg_42_0
					end

					return
				end)

				GetImageSpriteFromAtlasAsync = var_2_10005

				var_2_10005(var_41_0:getIcon(), "", var_41_1:Find("icon"))

				setText = var_2_10005

				var_2_10005(var_41_1:Find("Text"), var_41_0:getOwnedCount())

				setActive = var_2_10005

				var_2_10005(var_41_1:Find("add"), false)

				setActive = var_2_10005

				var_2_10005(var_41_1:Find("add"), false)

				setActive = var_2_10005

				var_2_10005(var_41_1:Find("descBtn"), false)

				setActive = var_2_10005

				var_2_10005(var_41_1:Find("resourceDesc"), false)
			end

			return
		end)

		local var_40_13 = arg_40_0.resourceList

		var_3.align(var_40_13, #var_40_2)

		return
	end

	local var_40_14 = arg_40_0.showingShop
	local var_40_15 = var_2.GetTopResources(var_40_14)
	local var_40_16 = arg_40_0.resourceList

	var_3.make(var_40_16, function(arg_43_0, arg_43_1, arg_43_2)
		UIItemList = var_2_10003

		if arg_43_0 == var_2_10003.EventUpdate then
			local var_43_0 = var_40_15[arg_43_1 + 1][1]
			local var_43_1 = var_3[2]
			local var_43_2 = var_3[3]

			setActive = var_2_10007

			var_2_10007(arg_43_2:Find("gold"), false)

			setActive = var_2_10007

			var_2_10007(arg_43_2:Find("oil"), false)

			setActive = var_2_10007

			var_2_10007(arg_43_2:Find("gem"), false)

			setActive = var_2_10007

			var_2_10007(arg_43_2:Find("islandItem"), false)

			DROP_TYPE_RESOURCE = var_2_10007

			if var_43_1 == var_2_10007 then
				if var_43_2 == 1 then
					setActive = var_2_10007

					var_2_10007(arg_43_2:Find("gold"), true)

					local var_43_3 = arg_40_0.player

					var_2_10007 = var_2_10007.getLevelMaxGold(var_43_3)
					setText = var_43_3

					var_43_3(arg_43_2:Find("gold/max"), "MAX: " .. var_2_10007)

					setText = var_43_3

					var_43_3(arg_43_2:Find("gold/Text"), arg_40_0.player.gold)
				elseif var_43_2 == 4 or var_43_2 == 14 then
					setActive = var_2_10007

					var_2_10007(arg_43_2:Find("gem"), true)

					setText = var_2_10007

					local var_43_4 = arg_43_2:Find("gem/Text")
					local var_43_5 = arg_40_0.player

					var_2_10007(var_43_4, var_9.getTotalGem(var_43_5))
				end
			else
				DROP_TYPE_ISLAND_ITEM = var_2_10007

				if var_43_1 == var_2_10007 then
					setActive = var_2_10007

					var_2_10007(arg_43_2:Find("islandItem"), true)

					local var_43_6 = arg_40_0.inventoryAgency
					local var_43_7 = var_7.GetOwnCount(var_43_6, var_43_2)

					setText = var_43_6

					var_43_6(arg_43_2:Find("islandItem/Text"), var_43_7)

					GetImageSpriteFromAtlasAsync = var_43_6
					Drop = var_9

					local var_43_8 = var_9.New
					local var_43_9 = {}

					DROP_TYPE_ISLAND_ITEM = var_11
					var_43_9.type = var_11
					var_43_9.id = var_43_2

					local var_43_10 = var_43_8(var_43_9)

					var_43_6(var_9.getIcon(var_43_10), "", arg_43_2:Find("islandItem/icon"))

					setActive = var_43_6

					var_43_6(arg_43_2:Find("islandItem/descBtn"), var_43_0 == 1)

					setActive = var_43_6

					var_43_6(arg_43_2:Find("islandItem/resourceDesc"), false)

					if var_43_0 == 1 then
						pg = var_43_6

						local var_43_11 = var_43_6.island_item_data_template[var_43_2].have_max

						setText = var_9

						var_9(arg_43_2:Find("islandItem/Text"), var_43_7 .. "/" .. var_43_11)

						onButton = var_9

						local var_43_12 = arg_40_0
						local var_43_13 = arg_43_2:Find("islandItem")

						local function var_43_14()
							setActive = var_3_10000

							local var_44_0 = arg_43_2
							local var_44_1 = var_1.Find(var_44_0, "islandItem/resourceDesc")

							isActive = var_44_0

							local var_44_2 = arg_43_2

							var_3_10000(var_44_1, not var_44_0(var_3.Find(var_44_2, "islandItem/resourceDesc")))

							setText = var_3_10000

							local var_44_3 = arg_43_2
							local var_44_4 = var_1.Find(var_44_3, "islandItem/resourceDesc")

							i18n = var_44_3

							var_3_10000(var_44_4, var_44_3("island_3Dshop_res_have") .. var_43_11)

							return
						end

						SFX_PANEL = var_13

						var_9(var_43_12, var_43_13, var_43_14, var_13)
					end
				end
			end
		end

		return
	end)

	local var_40_17 = arg_40_0.resourceList

	var_3.align(var_40_17, #var_40_15)

	return
end

function var_0_1.SetResourcesVisible(arg_45_0, arg_45_1)
	setActive = var_1_10002

	local var_45_0 = arg_45_0._tf

	var_1_10002(var_3.Find(var_45_0, "adapt/top/resources"), arg_45_1)

	return
end

function var_0_1.SetCloseAndRefresh(arg_46_0, arg_46_1)
	local var_46_0 = 0
	local var_46_1 = arg_46_0.showingShop

	if var_3.IsNormalShop(var_46_1) then
		local var_46_2 = arg_46_0.showingShop
		local var_46_3 = var_3.GetExistTime(var_46_2)

		type = var_46_2

		if var_46_2(var_46_3) == "table" then
			local var_46_4 = var_46_3[2]

			pg = var_5

			local var_46_5 = var_5.TimeMgr.GetInstance()

			var_46_0 = var_5.Table2ServerTime(var_46_5, {
				year = var_46_4[1][1],
				month = var_46_4[1][2],
				day = var_46_4[1][3],
				hour = var_46_4[2][1],
				min = var_46_4[2][2],
				sec = var_46_4[2][3]
			})
		end
	else
		local var_46_6 = arg_46_0.showingShop

		if var_3.IsTemporaryShop(var_46_6) then
			var_46_0 = arg_46_0.showingShop.existTime
		end
	end

	local var_46_7 = arg_46_0.showingShop.refreshTime
	local var_46_8 = arg_46_0.showingShop
	local var_46_9 = var_4.GetPlayerRefreshResource(var_46_8)

	setActive = var_46_8

	var_46_8(arg_46_1:Find("remainAndRefresh/remainTimer"), var_46_0 ~= 0)

	setActive = var_46_8

	var_46_8(arg_46_1:Find("remainAndRefresh/refresh"), var_46_7 ~= 0)

	setActive = var_46_8

	var_46_8(arg_46_1:Find("remainAndRefresh/refresh/refreshBtn"), var_46_9)

	setActive = var_46_8

	local var_46_10 = arg_46_1
	local var_46_11 = arg_46_1.Find(var_46_10, "remainAndRefresh")

	isActive = var_46_10

	local var_46_12

	if not var_46_10(arg_46_1:Find("remainAndRefresh/remainTimer")) then
		isActive = var_46_12
		var_46_12 = var_46_12(arg_46_1:Find("remainAndRefresh/refresh"))
	end

	var_46_8(var_46_11, var_46_12)

	pg = var_46_8

	local var_46_13 = var_46_8.TimeMgr.GetInstance()
	local var_46_14 = var_5.GetTimeToNextTime(var_46_13)

	if arg_46_0.timer then
		local var_46_15 = arg_46_0.timer

		var_6.Stop(var_46_15)

		arg_46_0.timer = nil
	end

	Timer = var_6
	arg_46_0.timer = var_6.New(function()
		pg = var_2_10000

		local var_47_0 = var_2_10000.TimeMgr.GetInstance()
		local var_47_1 = var_0.GetServerTime(var_47_0)
		local var_47_2

		if var_46_0 ~= 0 then
			pg = var_47_2
			var_2_10002 = var_47_2.TimeMgr.GetInstance()
			var_47_2 = var_47_2.DescCDTime(var_2_10002, var_46_0 - var_47_1)
			setText = var_2_10002

			local var_47_3 = arg_46_1
			local var_47_4 = var_3.Find(var_47_3, "remainAndRefresh/remainTimer")

			i18n = var_47_3

			var_2_10002(var_47_4, var_47_3("island_3Dshop_time_close", var_47_2))
		else
			normalShopExistTime = var_47_2

			if var_47_2 then
				type = var_47_2
				normalShopExistTime = var_2_10002

				if var_47_2(var_2_10002) == "table" then
					-- block empty
				end
			end
		end

		if var_46_7 ~= 0 then
			pg = var_1

			local var_47_5 = var_1.TimeMgr.GetInstance()
			local var_47_6 = var_1.DescCDTime(var_47_5, var_46_7 - var_47_1)

			setText = var_47_5

			local var_47_7 = arg_46_1
			local var_47_8 = var_3.Find(var_47_7, "remainAndRefresh/refresh/refreshTimer")

			i18n = var_47_7

			var_47_5(var_47_8, var_47_7("island_3Dshop_time_refresh", var_47_6))

			if var_47_1 > var_46_7 then
				local var_47_9 = arg_46_0

				var_2.DoUpdateShowingShop(var_47_9)
			end
		end

		if var_46_7 == 0 and var_46_9 and var_47_1 > var_46_14 then
			local var_47_10 = arg_46_0

			var_1.DoUpdateShowingShop(var_47_10)
		end

		return
	end, 1, -1)

	local var_46_16 = arg_46_0.timer

	var_6.Start(var_46_16)

	if var_46_9 then
		onButton = var_6

		local var_46_17 = arg_46_0
		local var_46_18 = arg_46_1:Find("remainAndRefresh/refresh/refreshBtn/button")

		local function var_46_19()
			local var_48_0 = arg_46_0.showingShop.refreshCount
			local var_48_1 = arg_46_0.showingShop

			if var_48_0 < var_1.GetMaxRefreshCount(var_48_1) then
				local var_48_2 = arg_46_0.showingShop

				var_48_1 = var_48_1.GetFirstRefreshFree(var_48_2)

				local var_48_3 = var_46_9[3]

				if var_48_1 and var_48_0 == 0 then
					var_2_10004 = var_46_9
					var_2_10004[3] = 0
					var_48_3 = 0
				end

				pg = var_2_10004

				local var_48_4 = var_2_10004.MsgboxMgr.GetInstance()

				var_2_10004 = var_2_10004.ShowMsgBox

				local var_48_5 = {
					yesText = "text_confirm",
					hideNo = false,
					noText = "text_cancel"
				}

				i18n = var_2_10007

				local var_48_6 = "refresh_shopStreet_question"

				i18n = var_2_10009

				local var_48_7 = "word_"

				id2res = var_2_10011
				var_48_5.content = var_2_10007(var_48_6, var_2_10009(var_48_7 .. var_2_10011(var_46_9[2]) .. "_icon"), var_48_3, var_48_0)

				function var_48_5.onYes()
					local var_49_0 = arg_46_0
					local var_49_1 = var_0.emit

					IslandMediator = var_3_10002

					var_49_1(var_49_0, var_3_10002.REFRESH_SHOP_BY_PLAYER, arg_46_0.showingShop.id, var_46_9)

					return
				end

				var_2_10004(var_48_4, var_48_5)
			else
				pg = var_48_1

				local var_48_8 = var_48_1.TipsMgr.GetInstance()
				local var_48_9 = var_2.ShowTips

				i18n = var_2_10004

				var_48_9(var_48_8, var_2_10004("island_3Dshop_refresh_limit"))
			end

			return
		end

		SFX_PANEL = var_10

		var_6(var_46_17, var_46_18, var_46_19, var_10)
	end

	return
end

function var_0_1.IsCommodityInShoppingCart(arg_50_0, arg_50_1)
	ipairs = var_1_10002

	for iter_50_0, iter_50_1 in var_1_10002(arg_50_0.shoppingCartCommodities) do
		if iter_50_1.id == arg_50_1.id then
			return true
		end
	end

	return false
end

function var_0_1.IsCommodityDisabled(arg_51_0, arg_51_1)
	isActive = var_1_10002

	local var_51_0

	if not var_1_10002(arg_51_1:Find("sellOut")) then
		isActive = var_51_0

		if not var_51_0(arg_51_1:Find("hold")) then
			isActive = var_51_0
			var_51_0 = var_51_0(arg_51_1:Find("notInTime"))
		end
	end

	return var_51_0
end

function var_0_1.OpenShoppingCart(arg_52_0)
	local var_52_0 = arg_52_0
	local var_52_1 = arg_52_0.OpenPage

	IslandShoppingCartLayer = var_1_10003
	arg_52_0.myIslandShoppingCartLayer = var_52_1(var_52_0, var_1_10003, arg_52_0.shoppingCartCommodities)

	return
end

function var_0_1.RefreshShopSkinCartButtons(arg_53_0)
	setActive = var_1_10001

	local var_53_0 = arg_53_0.shopSkinPage

	var_1_10001(var_2.Find(var_53_0, "cancelBtn"), #arg_53_0.shoppingCartCommodities > 0)

	setActive = var_1_10001

	local var_53_1 = arg_53_0.shopSkinPage

	var_1_10001(var_2.Find(var_53_1, "shoppingCartBtn"), #arg_53_0.shoppingCartCommodities > 0)

	setActive = var_1_10001

	local var_53_2 = arg_53_0.shopSkinPage
	local var_53_3 = var_2.Find(var_53_2, "shoppingCartBtn/count")
	local var_53_4 = arg_53_0.showingShop

	var_1_10001(var_53_3, var_3.GetCommanderOrCharaType(var_53_4) == 1)

	return
end

function var_0_1.ResetShopSkinCartPreview(arg_54_0)
	local var_54_0

	if arg_54_0.shoppingCartCommodities then
		var_54_0 = arg_54_0.shoppingCartCommodities[1]
	end

	arg_54_0.shoppingCartCommodities = {}
	arg_54_0.showingCommodity = nil

	if var_54_0 and arg_54_0:IsCommanderDressCommodity(var_54_0) then
		arg_54_0:ResetCommanderDressPreview(true)
	else
		arg_54_0:ResetCommanderDressPreview(false)

		local var_54_1 = arg_54_0.islandShipDressHelper

		var_2.ResetDressUp(var_54_1)
	end

	return
end

function var_0_1.BindShopSkinCartButtons(arg_55_0, arg_55_1)
	if #arg_55_0.shoppingCartCommodities <= 0 then
		return
	end

	onButton = var_2

	local var_55_0 = arg_55_0
	local var_55_1 = arg_55_0.shopSkinPage
	local var_55_2 = var_4.Find(var_55_1, "cancelBtn")

	local function var_55_3()
		if arg_55_1 then
			arg_55_1()
		else
			local var_56_0 = arg_55_0

			var_0.ResetShopSkinCartPreview(var_56_0)
		end

		setActive = var_0

		local var_56_1 = arg_55_0.shopSkinPage

		var_0(var_1.Find(var_56_1, "cancelBtn"), false)

		setActive = var_0

		local var_56_2 = arg_55_0.shopSkinPage

		var_0(var_1.Find(var_56_2, "shoppingCartBtn"), false)

		setText = var_0

		local var_56_3 = arg_55_0.shopSkinPage

		var_0(var_1.Find(var_56_3, "shoppingCartBtn/count"), "0/3")

		local var_56_4 = arg_55_0

		var_0.SetCommodityList(var_56_4)

		return
	end

	SFX_PANEL = var_6

	var_2(var_55_0, var_55_2, var_55_3, var_6)

	onButton = var_2

	local var_55_4 = arg_55_0
	local var_55_5 = arg_55_0.shopSkinPage
	local var_55_6 = var_4.Find(var_55_5, "shoppingCartBtn")

	local function var_55_7()
		local var_57_0 = arg_55_0

		var_0.OpenShoppingCart(var_57_0)

		return
	end

	SFX_PANEL = var_6

	var_2(var_55_4, var_55_6, var_55_7, var_6)

	return
end

function var_0_1.IsDressCommodityExclusive(arg_58_0, arg_58_1)
	local var_58_0 = arg_58_0.characterAgency
	local var_58_1 = var_2.GetShipById(var_58_0, arg_58_0.showingShipId)
	local var_58_2 = var_2.GetCurrentSkinId(var_58_1)

	pg = var_58_1

	local var_58_3 = var_58_1.island_dress_template
	local var_58_4 = arg_58_1
	local var_58_5 = var_58_3[arg_58_1.GetItems(var_58_4)[1][2]]

	if var_58_2 ~= 0 then
		if var_58_5.exclusive_skin ~= "" then
			ipairs = var_58_4

			for iter_58_0, iter_58_1 in var_58_4(var_5) do
				if iter_58_1 == var_58_2 then
					return true, var_58_5
				end
			end
		end
	elseif var_58_5.exclusive_default_skin ~= "" then
		ipairs = var_58_4

		for iter_58_2, iter_58_3 in var_58_4(var_5) do
			if iter_58_3 == var_2.id then
				return true, var_58_5
			end
		end
	end

	return false, var_58_5
end

function var_0_1.IsCommanderDressCommodity(arg_59_0, arg_59_1)
	if #arg_59_1:GetItems() ~= 0 then
		local var_59_0 = var_2[1][1]

		DROP_TYPE_ISLAND_DRESS = var_1_10004

		if var_59_0 ~= var_1_10004 then
			return false
		end

		pg = var_59_0

		return var_59_0.island_dress_template[var_2[1][2]] and var_3.belongto == 1
	end
end

function var_0_1.CacheCommanderDressPreviewData(arg_60_0)
	if arg_60_0.commanderDressPreviewData then
		return
	end

	getProxy = var_1
	IslandProxy = var_1_10002

	local var_60_0 = var_1(var_1_10002)
	local var_60_1 = var_1.GetIsland(var_60_0)
	local var_60_2 = var_1.GetDressUpAgency(var_60_1)

	arg_60_0.commanderDressPreviewData = {}
	pairs = var_2
	IslandShipDressHelperNew = var_1_10003

	for iter_60_0, iter_60_1 in var_2(var_1_10003.CommanderCustom) do
		local var_60_3

		if not var_60_2:GetDressByType(iter_60_1) then
			var_60_3 = 0
		end

		arg_60_0.commanderDressPreviewData[iter_60_1] = {
			id = var_60_3,
			colorId = var_60_2:GetCurrentColorByDressId(var_60_3)
		}
	end

	return
end

function var_0_1.RestoreCommanderDressPreview(arg_61_0)
	if not arg_61_0.commanderDressPreviewData then
		return
	end

	local var_61_0 = arg_61_0.commanderDressPreviewData

	ipairs = var_1_10002
	IslandShipDressHelperNew = var_1_10003

	for iter_61_0, iter_61_1 in var_1_10002(var_1_10003.CommanderCustom) do
		if var_61_0[iter_61_1] then
			local var_61_1 = arg_61_0.islandShipDressHelper

			var_8.ChangeDressByType(var_61_1, iter_61_1, var_7)
		end
	end

	arg_61_0.commanderDressPreviewData = nil

	return
end

function var_0_1.ResetCommanderDressPreview(arg_62_0, arg_62_1, arg_62_2)
	if arg_62_1 then
		arg_62_0:RestoreCommanderDressPreview()
	else
		arg_62_0.commanderDressPreviewData = nil

		if arg_62_2 then
			local var_62_0 = arg_62_0.islandShipDressHelper

			var_3.InvalidateRole(var_62_0)
		end
	end

	arg_62_0:SetMorphBlock(false)

	setActive = var_3

	var_3(arg_62_0.morphBtn, false)

	return
end

function var_0_1.ChangeDressByCommodityItems(arg_63_0, arg_63_1)
	ipairs = var_1_10002

	for iter_63_0, iter_63_1 in var_1_10002(arg_63_1:GetItems()) do
		local var_63_0
		local var_63_1 = iter_63_1[1]

		DROP_TYPE_ISLAND_DRESS = var_1_10009

		if var_63_1 == var_1_10009 then
			pg = var_63_1

			if var_63_1.island_dress_template[iter_63_1[2]] then
				var_63_0 = var_8.type
			end
		end

		var_1_10009 = arg_63_0.islandShipDressHelper

		var_8.ChangeDressByType(var_1_10009, var_63_0, {
			colorId = 0,
			id = iter_63_1[2]
		})
	end

	return
end

function var_0_1.ToggleDressSuitCommodity(arg_64_0, arg_64_1)
	arg_64_0:ResetCommanderDressPreview(false)

	arg_64_0.showingCommodity = nil

	if #arg_64_0.shoppingCartCommodities == 1 and arg_64_0.shoppingCartCommodities[1].id == arg_64_1.id then
		arg_64_0.shoppingCartCommodities = {}

		local var_64_0 = arg_64_0.islandShipDressHelper

		var_2.ResetDressUp(var_64_0)
	else
		arg_64_0.shoppingCartCommodities = {
			arg_64_1
		}

		arg_64_0:ChangeDressByCommodityItems(arg_64_1)
	end

	setText = var_2

	local var_64_1 = arg_64_0.shopSkinPage
	local var_64_2 = var_3.Find(var_64_1, "shoppingCartBtn/count")
	local var_64_3

	if not (#arg_64_0.shoppingCartCommodities > 0) or not #arg_64_1:GetDisplayItems() then
		var_64_3 = 0
	end

	var_2(var_64_2, var_64_3 .. "/3")

	return
end

function var_0_1.ChangeCommanderDressByCommodity(arg_65_0, arg_65_1)
	arg_65_0:CacheCommanderDressPreviewData()

	ipairs = var_2

	for iter_65_0, iter_65_1 in var_2(arg_65_1:GetDisplayItems()) do
		local var_65_0 = iter_65_1[1]

		DROP_TYPE_ISLAND_DRESS = var_1_10008

		if var_65_0 == var_1_10008 then
			pg = var_65_0

			if var_65_0.island_dress_template[iter_65_1[2]] then
				var_1_10008 = iter_65_1[2]

				local var_65_1 = var_7.type

				IslandShipDressHelperNew = var_1_10010

				if var_65_1 == var_1_10010.DressType.Body then
					getProxy = var_65_1
					IslandProxy = var_1_10010
					var_1_10010 = var_65_1(var_1_10010)
					var_1_10010 = var_9.GetIsland(var_1_10010)

					local var_65_2 = var_9.GetDressUpAgency(var_1_10010)

					if var_9.GetTwinCurId(var_65_2, var_1_10008) and var_1_10010 ~= 0 then
						var_1_10008 = var_1_10010
					end
				end

				var_1_10010 = arg_65_0.islandShipDressHelper

				var_9.ChangeDressByType(var_1_10010, var_7.type, {
					colorId = 0,
					id = var_1_10008
				})

				var_1_10010 = arg_65_0

				arg_65_0.CheckCommanderHatState(var_1_10010, var_7.type, var_1_10008)

				var_1_10010 = arg_65_0

				arg_65_0.CheckCommanderMorphBtn(var_1_10010, var_7.type, var_1_10008)
			end
		end
	end

	return
end

function var_0_1.CheckCommanderHatState(arg_66_0, arg_66_1, arg_66_2)
	IslandShipDressHelperNew = var_1_10003

	if arg_66_1 ~= var_1_10003.DressType.Body then
		return
	end

	pg = var_3

	local var_66_0

	if not var_3.island_dress_template.get_id_list_by_related_dress[arg_66_2] then
		var_66_0 = {}
	end

	if not var_66_0[1] or var_4 == 0 then
		local var_66_1 = arg_66_0.islandShipDressHelper
		local var_66_2 = var_5.ChangeDressByType

		IslandShipDressHelperNew = var_1_10007

		var_66_2(var_66_1, var_1_10007.DressType.Hat, {
			id = 0,
			colorId = 0
		})
	elseif var_4 and var_4 ~= 0 then
		local var_66_3 = arg_66_0.islandShipDressHelper
		local var_66_4 = var_5.ChangeDressByType

		IslandShipDressHelperNew = var_1_10007

		var_66_4(var_66_3, var_1_10007.DressType.Hat, {
			colorId = 0,
			id = var_4
		})
	end

	return
end

function var_0_1.CheckCommanderMorphBtn(arg_67_0, arg_67_1, arg_67_2)
	IslandShipDressHelperNew = var_1_10003

	if arg_67_1 ~= var_1_10003.DressType.Body then
		return
	end

	local var_67_0 = arg_67_2
	local var_67_1 = 0

	pg = var_1_10005

	if var_1_10005.island_dress_template[var_67_0].cloth_related and var_5 ~= 0 then
		var_67_1 = var_5
	end

	if var_67_1 == 0 then
		setActive = var_1_10006

		var_1_10006(arg_67_0.morphBtn, false)

		return
	end

	setActive = var_1_10006

	var_1_10006(arg_67_0.morphBtn, true)

	onButton = var_1_10006

	var_1_10006(arg_67_0, arg_67_0.morphBtn, function()
		local var_68_0 = arg_67_0

		var_0.DoMorphSwitch(var_68_0, var_67_0, var_67_1)

		return
	end)

	return
end

function var_0_1.DoMorphSwitch(arg_69_0, arg_69_1, arg_69_2)
	if arg_69_0.morphing then
		return
	end

	arg_69_0:SetMorphBlock(true)

	if not arg_69_0.islandShipDressHelper then
		arg_69_0:DoSwitch(arg_69_2, function()
			local var_70_0 = arg_69_0

			var_0.SetMorphBlock(var_70_0, false)

			return
		end)

		return
	end

	local var_69_0 = arg_69_0.islandShipDressHelper

	var_3.DoMorphSwitch(var_69_0, arg_69_1, arg_69_2, function()
		local var_71_0 = arg_69_0

		var_0.DoSwitch(var_71_0, arg_69_2, function()
			local var_72_0 = arg_69_0

			var_0.SetMorphBlock(var_72_0, false)

			return
		end)

		return
	end)

	return
end

function var_0_1.DoSwitch(arg_73_0, arg_73_1, arg_73_2)
	IslandShipDressHelperNew = var_1_10003

	local var_73_0 = var_1_10003.DressType.Body
	local var_73_1 = arg_73_0.islandShipDressHelper

	var_4.ChangeDressByType(var_73_1, var_73_0, {
		colorId = 0,
		id = arg_73_1
	}, arg_73_2)

	local var_73_2 = arg_73_0
	local var_73_3 = arg_73_0.CheckCommanderHatState

	IslandShipDressHelperNew = var_6

	var_73_3(var_73_2, var_6.DressType.Body, arg_73_1)
	arg_73_0:CheckCommanderMorphBtn(var_73_0, arg_73_1)

	return
end

function var_0_1.SetMorphBlock(arg_74_0, arg_74_1)
	arg_74_0.morphing = arg_74_1
	setActive = var_1_10002

	var_1_10002(arg_74_0.morphBlocker, arg_74_1)

	return
end

function var_0_1.ToggleCommanderDressCommodity(arg_75_0, arg_75_1)
	if #arg_75_0.shoppingCartCommodities == 1 and arg_75_0.shoppingCartCommodities[1].id == arg_75_1.id then
		arg_75_0.shoppingCartCommodities = {}

		arg_75_0:ResetCommanderDressPreview(true)
	else
		arg_75_0.shoppingCartCommodities = {
			arg_75_1
		}

		arg_75_0:ChangeCommanderDressByCommodity(arg_75_1)
	end

	setText = var_2

	local var_75_0 = arg_75_0.shopSkinPage
	local var_75_1 = var_3.Find(var_75_0, "shoppingCartBtn/count")
	local var_75_2

	if not (#arg_75_0.shoppingCartCommodities > 0) or not #arg_75_1:GetDisplayItems() then
		var_75_2 = 0
	end

	var_2(var_75_1, var_75_2 .. "/3")

	return
end

function var_0_1.RemoveSameDressTypeCommodity(arg_76_0, arg_76_1)
	local var_76_0 = 0

	ipairs = var_1_10003

	for iter_76_0, iter_76_1 in var_1_10003(arg_76_0.shoppingCartCommodities) do
		if iter_76_1:GetDressType() == arg_76_1:GetDressType() then
			var_76_0 = iter_76_1.id
			table = var_8

			var_8.remove(arg_76_0.shoppingCartCommodities, iter_76_0)

			break
		end
	end

	return var_76_0
end

function var_0_1.ToggleSingleDressCommodity(arg_77_0, arg_77_1)
	local var_77_0, var_77_1 = arg_77_0:IsDressCommodityExclusive(arg_77_1)

	if var_77_0 then
		pg = var_4

		local var_77_2 = var_4.TipsMgr.GetInstance()
		local var_77_3 = var_4.ShowTips

		i18n = var_1_10006

		var_77_3(var_77_2, var_1_10006("island_dress_mutually_exclusive1", var_77_1.name))

		return false
	end

	arg_77_0:ResetCommanderDressPreview(false)

	arg_77_0.showingCommodity = nil

	if #arg_77_0.shoppingCartCommodities > 0 then
		local var_77_4 = arg_77_0.shoppingCartCommodities[1]

		if #var_4.GetItems(var_77_4) > 1 then
			arg_77_0.shoppingCartCommodities = {}

			local var_77_5 = arg_77_0.islandShipDressHelper

			var_4.ResetDressUp(var_77_5)
		end
	end

	local var_77_6 = arg_77_0:RemoveSameDressTypeCommodity(arg_77_1)

	if arg_77_1.id == var_77_6 then
		local var_77_7 = arg_77_0.islandShipDressHelper

		var_5.ChangeDressByType(var_77_7, arg_77_1:GetDressType(), {
			id = 0,
			colorId = 0
		})
	else
		table = var_5

		var_5.insert(arg_77_0.shoppingCartCommodities, arg_77_1)

		local var_77_8 = arg_77_0.islandShipDressHelper

		var_5.ChangeDressByType(var_77_8, arg_77_1:GetDressType(), {
			colorId = 0,
			id = arg_77_1:GetItems()[1][2]
		})
	end

	setText = var_5

	local var_77_9 = arg_77_0.shopSkinPage

	var_5(var_6.Find(var_77_9, "shoppingCartBtn/count"), #arg_77_0.shoppingCartCommodities .. "/3")

	return true
end

function var_0_1.HandleDressCommodity(arg_78_0, arg_78_1)
	if arg_78_0:IsCommanderDressCommodity(arg_78_1) then
		arg_78_0:ToggleCommanderDressCommodity(arg_78_1)
	elseif #arg_78_1:GetItems() > 1 then
		arg_78_0:ToggleDressSuitCommodity(arg_78_1)
	elseif not arg_78_0:ToggleSingleDressCommodity(arg_78_1) then
		return
	end

	arg_78_0:RefreshShopSkinCartButtons()
	arg_78_0:BindShopSkinCartButtons()
	arg_78_0:SetCommodityList()

	return
end

function var_0_1.HandleFurnitureCommodity(arg_79_0, arg_79_1)
	arg_79_0:ResetCommanderDressPreview(false, true)

	if arg_79_0.showingCommodity ~= arg_79_1 then
		arg_79_0.showingCommodity = arg_79_1
		arg_79_0.shoppingCartCommodities = {
			arg_79_1
		}

		arg_79_0:LoadFurniture(arg_79_1:GetModel(), arg_79_1:GetModelParam())

		setActive = var_2

		local var_79_0 = arg_79_0.shopFurniturePage

		var_2(var_3.Find(var_79_0, "scenePreviewBtn"), false)

		setActive = var_2

		local var_79_1 = arg_79_0.shopFurniturePage

		var_2(var_3.Find(var_79_1, "shoppingCartBtn"), true)

		if #arg_79_1:GetItems() == 1 then
			onButton = var_2

			local var_79_2 = arg_79_0
			local var_79_3 = arg_79_0.shopFurniturePage
			local var_79_4 = var_4.Find(var_79_3, "scenePreviewBtn")

			local function var_79_5()
				setActive = var_2_10000

				var_2_10000(arg_79_0._tf, false)

				local var_80_0 = arg_79_0

				var_0.ClearCharacterScene(var_80_0)

				local var_80_1 = arg_79_0
				local var_80_2 = var_0.emit

				IslandMediator = var_2

				local var_80_3 = var_2.PREVIEW_FURNITURE
				local var_80_4 = arg_79_1

				var_80_2(var_80_1, var_80_3, var_3.GetItems(var_80_4)[1][2])

				return
			end

			SFX_PANEL = var_6

			var_2(var_79_2, var_79_4, var_79_5, var_6)
		end

		onButton = var_2

		local var_79_6 = arg_79_0
		local var_79_7 = arg_79_0.shopFurniturePage
		local var_79_8 = var_4.Find(var_79_7, "shoppingCartBtn")

		local function var_79_9()
			local var_81_0 = arg_79_0

			var_0.OpenShoppingCart(var_81_0)

			return
		end

		SFX_PANEL = var_6

		var_2(var_79_6, var_79_8, var_79_9, var_6)
	else
		arg_79_0.showingCommodity = nil
		arg_79_0.shoppingCartCommodities = {}

		arg_79_0:UnloadCharacter()

		setActive = var_2

		local var_79_10 = arg_79_0.shopFurniturePage

		var_2(var_3.Find(var_79_10, "scenePreviewBtn"), false)

		setActive = var_2

		local var_79_11 = arg_79_0.shopFurniturePage

		var_2(var_3.Find(var_79_11, "shoppingCartBtn"), false)
	end

	arg_79_0:SetCommodityList()

	return
end

function var_0_1.HandleSkinCommodity(arg_82_0, arg_82_1)
	arg_82_0:ResetCommanderDressPreview(false, true)

	local var_82_0

	if arg_82_0.showingCommodity ~= arg_82_1 then
		arg_82_0.showingCommodity = arg_82_1
		arg_82_0.shoppingCartCommodities = {
			arg_82_1
		}
		pg = var_82_0
		var_82_0 = var_82_0.island_skin_template[arg_82_1:GetItems()[1][2]].model
		pg = var_3

		local var_82_1 = var_3.island_unit_character[var_82_0]

		arg_82_0:LoadCharacter(var_82_1, false)
	else
		arg_82_0.showingCommodity = nil
		arg_82_0.shoppingCartCommodities = {}

		arg_82_0:UnloadCharacter()
	end

	setActive = var_82_0

	local var_82_2 = arg_82_0.shopSkinPage

	var_82_0(var_3.Find(var_82_2, "cancelBtn"), false)

	setActive = var_82_0

	local var_82_3 = arg_82_0.shopSkinPage

	var_82_0(var_3.Find(var_82_3, "shoppingCartBtn"), #arg_82_0.shoppingCartCommodities > 0)

	setActive = var_82_0

	local var_82_4 = arg_82_0.shopSkinPage

	var_82_0(var_3.Find(var_82_4, "shoppingCartBtn/count"), false)

	setText = var_82_0

	local var_82_5 = arg_82_0.shopSkinPage

	var_82_0(var_3.Find(var_82_5, "shoppingCartBtn/count"), #arg_82_0.shoppingCartCommodities .. "/3")
	arg_82_0:BindShopSkinCartButtons(function()
		arg_82_0.shoppingCartCommodities = {}

		local var_83_0 = arg_82_0.characterAgency
		local var_83_1 = var_0.GetShipById(var_83_0, arg_82_0.showingShipId)
		local var_83_2 = var_0.GetModel(var_83_1)
		local var_83_3 = arg_82_0

		var_2.LoadCharacter(var_83_3, var_83_2, false)

		return
	end)
	arg_82_0:SetCommodityList()

	return
end

function var_0_1.SetCommodity(arg_84_0, arg_84_1, arg_84_2)
	var_0_1.StaticUpdateCommodityTpl(arg_84_1, arg_84_2)

	setActive = var_3

	local var_84_0 = arg_84_1:Find("notInTime")
	local var_84_1 = arg_84_0.showingShop

	var_3(var_84_0, not var_5.IsInTime(var_84_1))

	setActive = var_3

	var_3(arg_84_1:Find("select"), arg_84_0:IsCommodityInShoppingCart(arg_84_2))

	if arg_84_0:IsCommodityDisabled(arg_84_1) then
		removeOnButton = var_3

		var_3(arg_84_1)
	else
		onButton = var_3

		local var_84_2 = arg_84_0
		local var_84_3 = arg_84_1

		local function var_84_4()
			switch = var_2_10000

			local var_85_0 = arg_84_2
			local var_85_1 = var_1.GetCommodityShowType(var_85_0)
			local var_85_2 = {}

			IslandConst = var_2_10003
			var_85_2[var_2_10003.COMMODITY_SHOW_ITEM] = function()
				local var_86_0 = arg_84_0
				local var_86_1 = arg_84_0
				local var_86_2 = var_1.OpenPage

				IslandShopItemLayer = var_3_10003
				var_86_0.myIslandShopItemLayer = var_86_2(var_86_1, var_3_10003, arg_84_0.showingShop.id, arg_84_2)

				return
			end
			IslandConst = var_3
			var_85_2[var_3.COMMODITY_SHOW_DRESS] = function()
				local var_87_0 = arg_84_0

				var_0.HandleDressCommodity(var_87_0, arg_84_2)

				return
			end
			IslandConst = var_3
			var_85_2[var_3.COMMODITY_SHOW_FURNITURE] = function()
				local var_88_0 = arg_84_0

				var_0.HandleFurnitureCommodity(var_88_0, arg_84_2)

				return
			end
			IslandConst = var_3
			var_85_2[var_3.COMMODITY_SHOW_SKIN] = function()
				local var_89_0 = arg_84_0

				var_0.HandleSkinCommodity(var_89_0, arg_84_2)

				return
			end
			IslandConst = var_3
			var_85_2[var_3.COMMODITY_SHOW_INVITE] = function()
				local var_90_0 = arg_84_2
				local var_90_1 = var_0.GetItems(var_90_0)[1][2]
				local var_90_2 = arg_84_0
				local var_90_3 = arg_84_0
				local var_90_4 = var_2.OpenPage

				IslandShopItemLayer = var_3_10004
				var_90_2.myIslandShopItemLayer = var_90_4(var_90_3, var_3_10004, arg_84_0.showingShop.id, arg_84_2, var_90_1)

				return
			end

			var_2_10000(var_85_1, var_85_2)

			return
		end

		SFX_PANEL = var_7

		var_3(var_84_2, var_84_3, var_84_4, var_7)
	end

	return
end

function var_0_1.SetCommodityList(arg_91_0)
	local var_91_0 = arg_91_0.showingShop
	local var_91_1

	var_91_1, switch = var_1.GetShowType(var_91_0), var_91_0

	local var_91_2 = {}

	IslandConst = var_1_10005
	var_91_2[var_1_10005.SHOP_TYPE_2D] = function()
		UIItemList = var_2_10000

		local var_92_0 = var_2_10000.New
		local var_92_1 = arg_91_0.shop2DPage
		local var_92_2 = var_1.Find(var_92_1, "shopView/Viewport/Content")
		local var_92_3 = arg_91_0.shop2DPage

		return var_92_0(var_92_2, var_2.Find(var_92_3, "shopView/Viewport/Content/IslandCommodityTpl"))
	end
	IslandConst = var_5
	var_91_2[var_5.SHOP_TYPE_3D] = function()
		UIItemList = var_2_10000

		local var_93_0 = var_2_10000.New
		local var_93_1 = arg_91_0.shop3DPage
		local var_93_2 = var_1.Find(var_93_1, "shopView/Viewport/Content")
		local var_93_3 = arg_91_0.shop3DPage

		return var_93_0(var_93_2, var_2.Find(var_93_3, "shopView/Viewport/Content/IslandCommodityTpl"))
	end
	IslandConst = var_5
	var_91_2[var_5.SHOP_TYPE_FURNITURE] = function()
		UIItemList = var_2_10000

		local var_94_0 = var_2_10000.New
		local var_94_1 = arg_91_0.shopFurniturePage
		local var_94_2 = var_1.Find(var_94_1, "shopView/Viewport/Content")
		local var_94_3 = arg_91_0.shopFurniturePage

		return var_94_0(var_94_2, var_2.Find(var_94_3, "shopView/Viewport/Content/IslandCommodityTpl"))
	end
	IslandConst = var_5
	var_91_2[var_5.SHOP_TYPE_SKIN] = function()
		UIItemList = var_2_10000

		local var_95_0 = var_2_10000.New
		local var_95_1 = arg_91_0.shopSkinPage
		local var_95_2 = var_1.Find(var_95_1, "shopView/Viewport/Content")
		local var_95_3 = arg_91_0.shopSkinPage

		return var_95_0(var_95_2, var_2.Find(var_95_3, "shopView/Viewport/Content/IslandCommodityTpl"))
	end

	local var_91_3 = var_91_0(var_91_1, var_91_2)
	local var_91_4 = arg_91_0.showingShop
	local var_91_5 = var_3.GetCommodities(var_91_4)

	var_0_1.SortShopCommodities(var_91_5)

	local var_91_6 = var_91_3
	local var_91_7 = var_91_3.make

	local function var_91_8(arg_96_0, arg_96_1, arg_96_2)
		UIItemList = var_2_10003

		if arg_96_0 == var_2_10003.EventUpdate then
			local var_96_0 = var_91_5[arg_96_1 + 1]
			local var_96_1 = arg_91_0

			var_4.SetCommodity(var_96_1, arg_96_2, var_96_0)
		end

		return
	end

	SFX_PANEL = var_1_10007

	var_91_7(var_91_6, var_91_8, var_1_10007)
	var_91_3:align(#var_91_5)

	return
end

function var_0_1.ShowRecommendation5(arg_97_0)
	arg_97_0:ClearCharacterScene()
	arg_97_0:OverlayPanel(arg_97_0._tf, {
		pbList = {
			arg_97_0.bg
		}
	})

	setActive = var_1

	var_1(arg_97_0.bgColor, true)

	arg_97_0.shoppingCartCommodities = {}
	arg_97_0.showingCommodity = nil

	arg_97_0:ResetCommanderDressPreview(false)

	local var_97_0 = arg_97_0.showingShop
	local var_97_1 = var_1.GetBanners(var_97_0)
	local var_97_2 = arg_97_0.recommendationPage5
	local var_97_3 = var_2.Find(var_97_2, "banners")

	for iter_97_0 = 1, #var_97_1 do
		local var_97_4 = var_97_1[iter_97_0]
		local var_97_5 = var_97_3

		if var_97_3.Find(var_97_5, "banner" .. var_97_4.id) then
			GetImageSpriteFromAtlasAsync = var_97_5

			var_97_5("activitybanner/" .. var_97_4.pic, "", var_8)

			onButton = var_97_5

			local var_97_6 = arg_97_0
			local var_97_7 = var_8

			local function var_97_8()
				local var_98_0 = arg_97_0

				var_0.JumpToRecommendationShop(var_98_0, var_97_4.param)

				return
			end

			SFX_PANEL = var_1_10013

			var_97_5(var_97_6, var_97_7, var_97_8, var_1_10013)
		end
	end

	return
end

function var_0_1.ShowRecommendation1(arg_99_0)
	arg_99_0:ClearCharacterScene()
	arg_99_0:OverlayPanel(arg_99_0._tf, {
		pbList = {
			arg_99_0.bg
		}
	})

	setActive = var_1

	var_1(arg_99_0.bgColor, true)

	arg_99_0.shoppingCartCommodities = {}
	arg_99_0.showingCommodity = nil

	arg_99_0:ResetCommanderDressPreview(false)

	local var_99_0 = arg_99_0.showingShop
	local var_99_1 = var_1.GetBanners(var_99_0)
	local var_99_2 = arg_99_0.recommendationPage1
	local var_99_3 = var_2.Find(var_99_2, "banners")

	for iter_99_0 = 1, #var_99_1 do
		local var_99_4 = var_99_1[iter_99_0]
		local var_99_5 = var_99_3

		if var_99_3.Find(var_99_5, "banner" .. var_99_4.id) then
			GetImageSpriteFromAtlasAsync = var_99_5

			var_99_5("activitybanner/" .. var_99_4.pic, "", var_8)

			onButton = var_99_5

			local var_99_6 = arg_99_0
			local var_99_7 = var_8

			local function var_99_8()
				local var_100_0 = arg_99_0

				var_0.JumpToRecommendationShop(var_100_0, var_99_4.param)

				return
			end

			SFX_PANEL = var_1_10013

			var_99_5(var_99_6, var_99_7, var_99_8, var_1_10013)
		end
	end

	return
end

function var_0_1.ShowShop2D(arg_101_0)
	arg_101_0:ClearCharacterScene()
	arg_101_0:OverlayPanel(arg_101_0._tf, {
		pbList = {
			arg_101_0.bg
		}
	})

	setActive = var_1

	var_1(arg_101_0.bgColor, true)

	arg_101_0.shoppingCartCommodities = {}
	arg_101_0.showingCommodity = nil

	arg_101_0:ResetCommanderDressPreview(false)

	local var_101_0 = arg_101_0.showingShop
	local var_101_1 = var_1.IsInTime(var_101_0)

	setActive = var_101_0

	local var_101_2 = arg_101_0.shop2DPage

	var_101_0(var_3.Find(var_101_2, "lock"), not var_101_1)

	if var_101_1 then
		arg_101_0:SetCloseAndRefresh(arg_101_0.shop2DPage)
	else
		setActive = var_101_0

		local var_101_3 = arg_101_0.shop2DPage

		var_101_0(var_3.Find(var_101_3, "remainAndRefresh"), false)

		if arg_101_0.timer then
			local var_101_4 = arg_101_0.timer

			var_2.Stop(var_101_4)

			arg_101_0.timer = nil
		end

		Timer = var_2
		arg_101_0.timer = var_2.New(function()
			local var_102_0 = arg_101_0.showingShop
			local var_102_1 = var_0.GetExistTime(var_102_0)[1]

			pg = var_102_0

			local var_102_2 = var_102_0.TimeMgr.GetInstance()
			local var_102_3 = var_1.Table2ServerTime(var_102_2, {
				year = var_102_1[1][1],
				month = var_102_1[1][2],
				day = var_102_1[1][3],
				hour = var_102_1[2][1],
				min = var_102_1[2][2],
				sec = var_102_1[2][3]
			})

			pg = var_102_2

			local var_102_4 = var_102_2.TimeMgr.GetInstance()
			local var_102_5 = var_2.GetServerTime(var_102_4)

			pg = var_102_4

			local var_102_6 = var_102_4.TimeMgr.GetInstance()
			local var_102_7 = var_3.DescCDTime(var_102_6, var_102_3 - var_102_5)

			setText = var_102_6

			local var_102_8 = arg_101_0.shop2DPage
			local var_102_9 = var_5.Find(var_102_8, "lock/openTimer")

			i18n = var_102_8

			var_102_6(var_102_9, var_102_8("island_3Dshop_time_unlock", var_102_7))

			return
		end, 1, -1)

		local var_101_5 = arg_101_0.timer

		var_2.Start(var_101_5)
	end

	arg_101_0:SetCommodityList()

	return
end

function var_0_1.ShowShop3D(arg_103_0)
	arg_103_0:ClearCharacterScene()

	local var_103_0 = arg_103_0
	local var_103_1 = arg_103_0.OverlayPanel
	local var_103_2 = arg_103_0._tf
	local var_103_3 = {}
	local var_103_4 = {}
	local var_103_5 = arg_103_0.shop3DPage

	var_103_4[1] = var_6.Find(var_103_5, "bg")
	var_103_3.pbList = var_103_4

	var_103_1(var_103_0, var_103_2, var_103_3)

	setActive = var_103_1

	var_103_1(arg_103_0.bgColor, false)

	arg_103_0.shoppingCartCommodities = {}
	arg_103_0.showingCommodity = nil

	arg_103_0:ResetCommanderDressPreview(false)
	arg_103_0:SetCloseAndRefresh(arg_103_0.shop3DPage)
	arg_103_0:SetCommodityList()

	return
end

function var_0_1.ShowShopFurniture(arg_104_0)
	if not arg_104_0.isLoadCharacterScene then
		arg_104_0:PrepareCharacterScene()
	end

	local var_104_0 = arg_104_0
	local var_104_1 = arg_104_0.OverlayPanel
	local var_104_2 = arg_104_0._tf
	local var_104_3 = {}
	local var_104_4 = {}
	local var_104_5 = arg_104_0.shopFurniturePage

	var_104_4[1] = var_6.Find(var_104_5, "bg")
	var_104_3.pbList = var_104_4

	var_104_1(var_104_0, var_104_2, var_104_3)

	setActive = var_104_1

	var_104_1(arg_104_0.bgColor, false)
	arg_104_0:UnloadCharacter()

	arg_104_0.shoppingCartCommodities = {}
	arg_104_0.showingCommodity = nil

	arg_104_0:ResetCommanderDressPreview(false)
	arg_104_0:SetCloseAndRefresh(arg_104_0.shopFurniturePage)
	arg_104_0:SetCommodityList()

	setActive = var_1

	local var_104_6 = arg_104_0.shopFurniturePage

	var_1(var_2.Find(var_104_6, "scenePreviewBtn"), false)

	setActive = var_1

	local var_104_7 = arg_104_0.shopFurniturePage

	var_1(var_2.Find(var_104_7, "shoppingCartBtn"), false)

	return
end

function var_0_1.ShowShopSkin(arg_105_0)
	if not arg_105_0.isLoadCharacterScene then
		arg_105_0:PrepareCharacterScene()
	end

	local var_105_0 = arg_105_0
	local var_105_1 = arg_105_0.OverlayPanel
	local var_105_2 = arg_105_0._tf
	local var_105_3 = {}
	local var_105_4 = {}
	local var_105_5 = arg_105_0.shopSkinPage

	var_105_4[1] = var_6.Find(var_105_5, "bg")
	var_105_4[2] = arg_105_0.changeCharaPanel
	var_105_3.pbList = var_105_4

	var_105_1(var_105_0, var_105_2, var_105_3)

	setActive = var_105_1

	var_105_1(arg_105_0.bgColor, false)

	if not arg_105_0.shoppingCartCommodities then
		arg_105_0.shoppingCartCommodities = {}
	end

	if #arg_105_0.shoppingCartCommodities > 0 then
		local var_105_6 = arg_105_0.shoppingCartCommodities[1]
		local var_105_7 = var_1.GetCommodityShowType(var_105_6)

		IslandConst = var_105_6

		if var_105_7 ~= var_105_6.COMMODITY_SHOW_FURNITURE then
			IslandConst = var_2

			if var_105_7 == var_2.COMMODITY_SHOW_SKIN then
				arg_105_0.shoppingCartCommodities = {}
				arg_105_0.showingCommodity = nil

				arg_105_0:ResetCommanderDressPreview(false, true)
			end

			local var_105_8 = arg_105_0.showingShop

			if var_1.GetCommanderOrCharaType(var_105_8) == 0 and (arg_105_0.showingShipId ~= 0 or #arg_105_0.shoppingCartCommodities == 0) then
				arg_105_0.showingShipId = 0
				pg = var_2

				local var_105_9 = var_2.island_unit_character[0]

				arg_105_0:LoadCharacter({
					model = var_105_9.model,
					animator = var_105_9.animator
				}, true)

				arg_105_0.shoppingCartCommodities = {}
				arg_105_0.showingCommodity = nil

				arg_105_0:ResetCommanderDressPreview(false)
			elseif var_1 == 1 and (arg_105_0.showingShipId ~= arg_105_0.selectShipId or #arg_105_0.shoppingCartCommodities == 0) then
				arg_105_0:ResetCommanderDressPreview(false, true)

				arg_105_0.showingShipId = arg_105_0.selectShipId

				local var_105_10 = arg_105_0.characterAgency
				local var_105_11 = var_2.GetShipById(var_105_10, arg_105_0.showingShipId)
				local var_105_12 = var_2.GetModel(var_105_11)

				arg_105_0:LoadCharacter(var_105_12, false)

				arg_105_0.shoppingCartCommodities = {}
				arg_105_0.showingCommodity = nil

				arg_105_0:ResetCommanderDressPreview(false)
			elseif var_1 == 2 then
				arg_105_0:ResetCommanderDressPreview(false, true)

				arg_105_0.showingShipId = arg_105_0.selectShipId

				arg_105_0:UnloadCharacter()

				arg_105_0.shoppingCartCommodities = {}
				arg_105_0.showingCommodity = nil

				arg_105_0:ResetCommanderDressPreview(false)
			end

			arg_105_0:SetCloseAndRefresh(arg_105_0.shopSkinPage)
			arg_105_0:SetCommodityList()

			setActive = var_2

			local var_105_13 = arg_105_0.shopSkinPage

			var_2(var_3.Find(var_105_13, "cancelBtn"), #arg_105_0.shoppingCartCommodities > 0)

			setActive = var_2

			local var_105_14 = arg_105_0.shopSkinPage

			var_2(var_3.Find(var_105_14, "changeCharaBtn"), var_1 == 1)

			setActive = var_2

			local var_105_15 = arg_105_0.shopSkinPage

			var_2(var_3.Find(var_105_15, "shoppingCartBtn"), #arg_105_0.shoppingCartCommodities > 0)

			setActive = var_2

			local var_105_16 = arg_105_0.shopSkinPage

			var_2(var_3.Find(var_105_16, "shoppingCartBtn/count"), #arg_105_0.shoppingCartCommodities > 0 and var_1 == 1)

			setText = var_2

			local var_105_17 = arg_105_0.shopSkinPage

			var_2(var_3.Find(var_105_17, "shoppingCartBtn/count"), #arg_105_0.shoppingCartCommodities .. "/3")

			setActive = var_2

			local var_105_18 = arg_105_0.shopSkinPage

			var_2(var_3.Find(var_105_18, "changeCharaPanel"), false)
			arg_105_0:SetChangeCharaPanel()

			onButton = var_2

			local var_105_19 = arg_105_0
			local var_105_20 = arg_105_0.shopSkinPage
			local var_105_21 = var_4.Find(var_105_20, "changeCharaBtn")

			local function var_105_22()
				setActive = var_2_10000

				local var_106_0 = arg_105_0.shopSkinPage

				var_2_10000(var_1.Find(var_106_0, "changeCharaPanel"), true)

				return
			end

			SFX_PANEL = var_6

			var_2(var_105_19, var_105_21, var_105_22, var_6)

			return
		end
	end
end

function var_0_1.SetChangeCharaPanel(arg_107_0)
	onButton = var_1_10001

	local var_107_0 = arg_107_0
	local var_107_1 = arg_107_0.shopSkinPage
	local var_107_2 = var_3.Find(var_107_1, "changeCharaPanel/bg")

	local function var_107_3()
		setActive = var_2_10000

		local var_108_0 = arg_107_0.shopSkinPage

		var_2_10000(var_1.Find(var_108_0, "changeCharaPanel"), false)

		return
	end

	SFX_PANEL = var_5

	var_1_10001(var_107_0, var_107_2, var_107_3, var_5)

	onButton = var_1_10001

	local var_107_4 = arg_107_0
	local var_107_5 = arg_107_0.changeCharaPanel
	local var_107_6 = var_3.Find(var_107_5, "closeBtn")

	local function var_107_7()
		setActive = var_2_10000

		local var_109_0 = arg_107_0.shopSkinPage

		var_2_10000(var_1.Find(var_109_0, "changeCharaPanel"), false)

		return
	end

	SFX_PANEL = var_5

	var_1_10001(var_107_4, var_107_6, var_107_7, var_5)

	UIItemList = var_1_10001

	local var_107_8 = var_1_10001.New
	local var_107_9 = arg_107_0.changeCharaPanel
	local var_107_10 = var_2.Find(var_107_9, "charaScroll/Viewport/Content")
	local var_107_11 = arg_107_0.changeCharaPanel
	local var_107_12 = var_107_8(var_107_10, var_3.Find(var_107_11, "charaScroll/Viewport/Content/IslandShipTpl"))

	var_1.make(var_107_12, function(arg_110_0, arg_110_1, arg_110_2)
		UIItemList = var_2_10003

		if arg_110_0 == var_2_10003.EventUpdate then
			local var_110_0 = arg_107_0.ships[arg_110_1 + 1]

			IslandShip = var_4

			local var_110_1 = var_4.StaticGetPrefab(var_110_0.id)

			GetImageSpriteFromAtlasAsync = var_5

			var_5("ShipYardIcon/" .. var_110_1, "", arg_110_2:Find("mask/icon"))

			setText = var_5

			local var_110_2 = arg_110_2:Find("Text")
			local var_110_3 = "Lv."
			local var_110_4 = var_110_0

			var_5(var_110_2, var_110_3 .. var_110_0.GetLevel(var_110_4))

			setActive = var_5

			var_5(arg_110_2:Find("add"), false)

			setActive = var_5

			var_5(arg_110_2:Find("select"), var_110_0.id == arg_107_0.selectShipId)

			onButton = var_5

			local var_110_5 = arg_107_0
			local var_110_6 = arg_110_2

			local function var_110_7()
				if arg_107_0.charaSetModel == var_0_1.CharaSetModel.current then
					local var_111_0 = arg_107_0

					var_0.ResetCommanderDressPreview(var_111_0, false, true)

					arg_107_0.selectShipId = var_110_0.id
					arg_107_0.showingShipId = var_110_0.id

					local var_111_1 = arg_107_0
					local var_111_2 = var_0.LoadCharacter
					local var_111_3 = var_110_0

					var_111_2(var_111_1, var_2.GetModel(var_111_3), false)

					arg_107_0.shoppingCartCommodities = {}

					local var_111_4 = arg_107_0

					var_111_4.showingCommodity = nil
					setActive = var_111_4

					local var_111_5 = arg_107_0.shopSkinPage

					var_111_4(var_1.Find(var_111_5, "cancelBtn"), false)

					setActive = var_111_4

					local var_111_6 = arg_107_0.shopSkinPage

					var_111_4(var_1.Find(var_111_6, "shoppingCartBtn"), false)

					setText = var_111_4

					local var_111_7 = arg_107_0.shopSkinPage

					var_111_4(var_1.Find(var_111_7, "shoppingCartBtn/count"), "0/3")

					local var_111_8 = arg_107_0

					var_0.SetCommodityList(var_111_8)
				elseif arg_107_0.charaSetModel == var_0_1.CharaSetModel.default then
					local var_111_9 = arg_107_0

					var_111_9.defaultShipId = var_110_0.id
					PlayerPrefs = var_111_9

					var_111_9.SetInt("island_dressShop_defaultShipId_" .. arg_107_0.player.id, var_110_0.id)
				end

				local var_111_10 = 0
				local var_111_11 = arg_107_0.changeCharaPanel

				for iter_111_0 = var_111_10, var_1.Find(var_111_11, "charaScroll/Viewport/Content").childCount - 1 do
					setActive = var_3_10004

					local var_111_12 = arg_107_0.changeCharaPanel
					local var_111_13 = var_5.Find(var_111_12, "charaScroll/Viewport/Content")
					local var_111_14 = var_5.GetChild(var_111_13, iter_111_0)

					var_3_10004(var_5.Find(var_111_14, "select"), iter_111_0 == arg_110_1)
				end

				return
			end

			SFX_PANEL = var_110_4

			var_5(var_110_5, var_110_6, var_110_7, var_110_4)
		end

		return
	end)
	var_1:align(#arg_107_0.ships)

	arg_107_0.charaSetModel = var_0_1.CharaSetModel.current
	onButton = var_2

	local var_107_13 = arg_107_0
	local var_107_14 = arg_107_0.changeCharaPanel
	local var_107_15 = var_4.Find(var_107_14, "defaultSet")

	local function var_107_16()
		local var_112_0

		if arg_107_0.charaSetModel == var_0_1.CharaSetModel.current then
			var_112_0 = arg_107_0
			var_112_0.charaSetModel = var_0_1.CharaSetModel.default
			var_112_0 = 0

			local var_112_1 = arg_107_0.changeCharaPanel

			for iter_112_0 = var_112_0, var_1.Find(var_112_1, "charaScroll/Viewport/Content").childCount - 1 do
				setActive = var_2_10004

				local var_112_2 = arg_107_0.changeCharaPanel
				local var_112_3 = var_5.Find(var_112_2, "charaScroll/Viewport/Content")
				local var_112_4 = var_5.GetChild(var_112_3, iter_112_0)

				var_2_10004(var_5.Find(var_112_4, "select"), arg_107_0.ships[iter_112_0 + 1].id == arg_107_0.defaultShipId)
			end
		elseif arg_107_0.charaSetModel == var_0_1.CharaSetModel.default then
			var_112_0 = arg_107_0
			var_112_0.charaSetModel = var_0_1.CharaSetModel.current
			var_112_0 = 0

			local var_112_5 = arg_107_0.changeCharaPanel

			for iter_112_1 = var_112_0, var_1.Find(var_112_5, "charaScroll/Viewport/Content").childCount - 1 do
				setActive = var_2_10004

				local var_112_6 = arg_107_0.changeCharaPanel
				local var_112_7 = var_5.Find(var_112_6, "charaScroll/Viewport/Content")
				local var_112_8 = var_5.GetChild(var_112_7, iter_112_1)

				var_2_10004(var_5.Find(var_112_8, "select"), arg_107_0.ships[iter_112_1 + 1].id == arg_107_0.selectShipId)
			end
		end

		setActive = var_112_0

		local var_112_9 = arg_107_0.changeCharaPanel

		var_112_0(var_1.Find(var_112_9, "defaultSet/off"), arg_107_0.charaSetModel == var_0_1.CharaSetModel.current)

		setActive = var_112_0

		local var_112_10 = arg_107_0.changeCharaPanel

		var_112_0(var_1.Find(var_112_10, "defaultSet/on"), arg_107_0.charaSetModel == var_0_1.CharaSetModel.default)

		return
	end

	SFX_PANEL = var_6

	var_2(var_107_13, var_107_15, var_107_16, var_6)

	return
end

function var_0_1.AddListeners(arg_113_0)
	local var_113_0 = arg_113_0
	local var_113_1 = arg_113_0.AddListener

	GAME = var_1_10003

	var_113_1(var_113_0, var_1_10003.ISLAND_SHOP_OP_DONE, arg_113_0.UpdateView)

	local var_113_2 = arg_113_0
	local var_113_3 = arg_113_0.AddListener

	ISLAND_EX_EVT = var_3

	var_113_3(var_113_2, var_3.SWITCH_MAP_BY_POINT, arg_113_0.OnSwitchMapByPoint)

	local var_113_4 = arg_113_0
	local var_113_5 = arg_113_0.AddListener

	ActivityProxy = var_3

	var_113_5(var_113_4, var_3.ACTIVITY_UPDATED, arg_113_0.UpdateActivity)

	local var_113_6 = arg_113_0
	local var_113_7 = arg_113_0.AddListener

	GAME = var_3

	var_113_7(var_113_6, var_3.ACTIVITY_DRAW_AWARD_OPERATION_DONE, arg_113_0.DrawOperation)

	local var_113_8 = arg_113_0
	local var_113_9 = arg_113_0.AddListener

	GAME = var_3

	var_113_9(var_113_8, var_3.ISLAND_EXCHANGE_ITEM_DONE, arg_113_0.OnExchangeDone)

	return
end

function var_0_1.RemoveListeners(arg_114_0)
	local var_114_0 = arg_114_0
	local var_114_1 = arg_114_0.RemoveListener

	GAME = var_1_10003

	var_114_1(var_114_0, var_1_10003.ISLAND_SHOP_OP_DONE, arg_114_0.UpdateView)

	local var_114_2 = arg_114_0
	local var_114_3 = arg_114_0.RemoveListener

	ISLAND_EX_EVT = var_3

	var_114_3(var_114_2, var_3.SWITCH_MAP_BY_POINT, arg_114_0.OnSwitchMapByPoint)

	local var_114_4 = arg_114_0
	local var_114_5 = arg_114_0.RemoveListener

	ActivityProxy = var_3

	var_114_5(var_114_4, var_3.ACTIVITY_UPDATED, arg_114_0.UpdateActivity)

	local var_114_6 = arg_114_0
	local var_114_7 = arg_114_0.RemoveListener

	GAME = var_3

	var_114_7(var_114_6, var_3.ACTIVITY_DRAW_AWARD_OPERATION_DONE, arg_114_0.DrawOperation)

	local var_114_8 = arg_114_0
	local var_114_9 = arg_114_0.RemoveListener

	GAME = var_3

	var_114_9(var_114_8, var_3.ISLAND_EXCHANGE_ITEM_DONE, arg_114_0.OnExchangeDone)

	return
end

function var_0_1.UpdateView(arg_115_0, arg_115_1)
	local var_115_0 = arg_115_1.operation

	IslandConst = var_1_10003

	local var_115_1

	if var_115_0 == var_1_10003.SHOP_GET_DATA then
		if arg_115_1.refreshAll then
			var_115_1 = arg_115_0

			arg_115_0.UpdateData(var_115_1)

			var_115_1 = arg_115_0

			arg_115_0.SetShopList(var_115_1)
		else
			var_115_1 = arg_115_0

			arg_115_0.SetShopPage(var_115_1)
		end
	else
		local var_115_2 = arg_115_1.operation

		IslandConst = var_115_1

		local var_115_3

		if var_115_2 == var_115_1.SHOP_BUY_COMMODITY then
			arg_115_0.shoppingCartCommodities = {}
			var_115_3 = arg_115_0

			arg_115_0.SetShopPage(var_115_3)

			if arg_115_0.myIslandShoppingCartLayer then
				var_115_3 = arg_115_0.myIslandShoppingCartLayer

				var_2.Hide(var_115_3)
			end

			var_115_3 = arg_115_0

			local var_115_4 = arg_115_0.OpenPage

			IslandShopBuySuccessLayer = var_1_10004

			var_115_4(var_115_3, var_1_10004, arg_115_1.awards, function()
				local var_116_0 = arg_115_0.showingShop
				local var_116_1 = var_0.GetShowType(var_116_0)

				IslandConst = var_116_0

				if var_116_1 == var_116_0.SHOP_TYPE_SKIN then
					local var_116_2 = arg_115_0
					local var_116_3 = var_0.ShowMsgBox
					local var_116_4 = {}

					IslandMsgBox = var_2_10003
					var_116_4.type = var_2_10003.TYPE_COMMON
					i18n = var_3
					var_116_4.content = var_3("island_3Dshop_clothes_jump")

					function var_116_4.onYes()
						local var_117_0 = arg_115_0

						var_0.ClearCharacterScene(var_117_0, function()
							local var_118_0 = arg_115_0

							var_0.Hide(var_118_0)

							local var_118_1 = arg_115_0.showingShop

							if var_0.GetCommanderOrCharaType(var_118_1) == 0 then
								local var_118_2 = arg_115_0
								local var_118_3 = var_1.OpenScenePage

								IslandShipIslandCommanderMainPage = var_4_10003

								var_118_3(var_118_2, var_4_10003)
							elseif var_0 == 1 or var_0 == 2 then
								local var_118_4 = arg_115_0
								local var_118_5 = var_1.OpenScenePage

								IslandShipMainPage = var_4_10003

								var_118_5(var_118_4, var_4_10003, 3)
							end

							return
						end)

						return
					end

					var_116_3(var_116_2, var_116_4)
				end

				return
			end)

			if arg_115_0.myIslandShopItemLayer then
				var_115_3 = arg_115_0.myIslandShopItemLayer

				var_2.Refresh(var_115_3)
			end
		else
			local var_115_5 = arg_115_1.operation

			IslandConst = var_115_3

			if var_115_5 == var_115_3.REFRESH_SHOP_BY_PLAYER then
				arg_115_0:SetShopPage()
			end
		end
	end

	return
end

function var_0_1.OnSwitchMapByPoint(arg_119_0)
	setActive = var_1_10001

	var_1_10001(arg_119_0._tf, true)
	arg_119_0:PrepareCharacterScene()

	return
end

function var_0_1.UpdateActivity(arg_120_0, arg_120_1)
	local var_120_0 = arg_120_1
	local var_120_1 = arg_120_1.getConfig(var_120_0, "type")

	ActivityConst = var_120_0

	if var_120_1 == var_120_0.ACTIVITY_TYPE_ISLAND_DRAW_AWARD then
		arg_120_0.drawAwardActivity = arg_120_1

		local var_120_2 = arg_120_0.drawAwardPage

		var_2.ActionInvoke(var_120_2, "UpdateActivity", arg_120_0.drawAwardActivity)
		arg_120_0:SetResources()
	end

	return
end

function var_0_1.DrawOperation(arg_121_0, arg_121_1)
	local var_121_0 = arg_121_0.drawAwardPage

	var_2.ActionInvoke(var_121_0, "DrawOperation", arg_121_1)

	return
end

function var_0_1.Preload(arg_122_0, arg_122_1)
	arg_122_1()

	return
end

function var_0_1.GetSmoothRotateObject(arg_123_0)
	local var_123_0 = arg_123_0._tf

	return var_1.Find(var_123_0, "adapt/model")
end

function var_0_1.LoadFurniture(arg_124_0, arg_124_1, arg_124_2)
	arg_124_0:UnloadCharacter()

	if arg_124_0.isLoadingModel then
		return
	end

	arg_124_0.isLoadingModel = true
	IslandAssetLoadDispatcher = var_3

	local var_124_0 = var_3.Instance
	local var_124_1 = var_3.Enqueue
	local var_124_2 = arg_124_1
	local var_124_3 = ""

	typeof = var_1_10007
	GameObject = var_1_10008

	local var_124_4 = var_1_10007(var_1_10008)

	UnityEngine = var_1_10008

	local var_124_5 = var_124_1(var_124_0, var_124_2, var_124_3, var_124_4, var_1_10008.Events.UnityAction_UnityEngine_Object(function(arg_125_0)
		local var_125_0 = arg_124_0

		Object = var_2_10002
		var_125_0.role = var_2_10002.Instantiate(arg_125_0)

		local var_125_1 = arg_124_0.role.name

		GameObject = var_2

		local var_125_2 = var_2.New(var_125_1)

		setParent = var_3

		var_3(arg_124_0.role, var_125_2.transform, false)

		arg_124_0.role = var_125_2

		local var_125_3 = arg_124_0

		var_125_3.isLoadingModel = false
		pg = var_125_3

		local var_125_4 = var_125_3.ViewUtils.SetLayer
		local var_125_5 = arg_124_0.role.transform

		Layer = var_5

		var_125_4(var_125_5, var_5.Character3D)

		setParent = var_125_4

		var_125_4(arg_124_0.role, arg_124_0.roleContainer)

		local var_125_6 = arg_124_0.role.transform

		Vector3 = var_4
		var_125_6.localPosition = var_4(arg_124_2[1][1], arg_124_2[1][2], 0)

		local var_125_7 = arg_124_0.role.transform

		Vector3 = var_4
		var_125_7.localEulerAngles = var_4(0, arg_124_2[2], 0)

		local var_125_8 = arg_124_0.role.transform

		Vector3 = var_4
		var_125_8.localScale = var_4(arg_124_2[3], arg_124_2[3], arg_124_2[3])

		local var_125_9 = arg_124_0
		local var_125_10

		var_125_10, GetOrAddComponent = var_3.GetSmoothRotateObject(var_125_9), var_125_9
		typeof = var_6
		SmoothRotateObject = var_7

		local var_125_11 = var_125_9(var_125_10, var_6(var_7))

		var_4.SetUp(var_125_11, arg_124_0.role.transform)

		pg = var_5
		var_4.rotationSpeed = var_5.island_set.character_detail_camera_speed.key_value_int

		return
	end), true, true)

	table = var_124_0

	local var_124_6 = var_124_0.insert
	local var_124_7

	if not arg_124_0.loadingIdList then
		var_124_7 = {}
	end

	var_124_6(var_124_7, var_124_5)

	return
end

function var_0_1.LoadCharacter(arg_126_0, arg_126_1, arg_126_2)
	arg_126_0:UnloadCharacter()

	if arg_126_0.isLoadingModel then
		return
	end

	arg_126_0.isLoadingModel = true

	local var_126_0 = arg_126_0.islandShipDressHelper

	var_3.SetShipId(var_126_0, arg_126_0.showingShipId)

	arg_126_0.isCommander = arg_126_2
	arg_126_0.modelData = arg_126_1

	local function var_126_1(arg_127_0)
		arg_126_0.role = arg_127_0

		local var_127_0 = arg_126_0

		var_127_0.isLoadingModel = false
		pg = var_127_0

		local var_127_1 = var_127_0.ViewUtils.SetLayer
		local var_127_2 = arg_126_0.role.transform

		Layer = var_2_10003

		var_127_1(var_127_2, var_2_10003.Character3D)

		setParent = var_127_1

		var_127_1(arg_126_0.role, arg_126_0.roleContainer)

		local var_127_3 = 2.7

		if arg_126_0._tf.rect.width / arg_126_0._tf.rect.height < 1.7777777777777777 then
			var_127_3 = 2.7 - 0.5 * (1.7777777777777777 - var_2) / 0.4444444444444444
		end

		local var_127_4 = arg_126_0.role.transform

		Vector3 = var_2_10004
		var_127_4.localPosition = var_2_10004(var_127_3, 0, 0)

		local var_127_5 = arg_126_0.role.transform

		Vector3 = var_4
		var_127_5.localEulerAngles = var_4(0, -155, 0)

		local var_127_6 = arg_126_0
		local var_127_7

		var_127_7, GetOrAddComponent = var_3.GetSmoothRotateObject(var_127_6), var_127_6
		typeof = var_6
		SmoothRotateObject = var_7

		local var_127_8 = var_127_6(var_127_7, var_6(var_7))

		var_4.SetUp(var_127_8, arg_126_0.role.transform)

		pg = var_5
		var_4.rotationSpeed = var_5.island_set.character_detail_camera_speed.key_value_int

		local var_127_9 = arg_126_0.displayUnit

		var_6.OnAttach(var_127_9, arg_127_0, arg_126_0.toolContainer)

		local var_127_10

		if arg_126_0.modelData then
			var_127_10 = arg_126_0.modelData.personal_ani
		end

		if var_127_10 and var_127_10 ~= "" then
			GetOrAddComponent = var_127_9

			local var_127_11 = arg_126_0.role.transform
			local var_127_12 = var_8.GetChild(var_127_11, 0)

			typeof = var_127_11
			Animator = var_10

			local var_127_13 = var_127_9(var_127_12, var_127_11(var_10))

			for iter_127_0 = 1, var_127_13.layerCount do
				var_127_13:CrossFadeInFixedTime(var_127_10, 0, iter_127_0 - 1)
			end
		end

		local var_127_14 = arg_126_0.islandShipDressHelper

		var_7.OnRoleLoaded(var_127_14, arg_126_0.role.transform, arg_126_0.modelData)

		return
	end

	if arg_126_0.isCommander then
		local var_126_2 = arg_126_0:GetPoolMgr()

		var_4.GetCommanderModel(var_126_2, arg_126_1, function(arg_128_0)
			var_126_1(arg_128_0)

			return
		end)
	else
		local var_126_3 = arg_126_0:GetPoolMgr()

		var_4.GetCharacter(var_126_3, arg_126_1.model, arg_126_1.animator, function(arg_129_0)
			var_126_1(arg_129_0)

			return
		end)
	end

	return
end

function var_0_1.UnloadCharacter(arg_130_0)
	local var_130_0 = arg_130_0.islandShipDressHelper

	var_1.InvalidateRole(var_130_0)

	local var_130_1 = arg_130_0.islandShipDressHelper

	var_1.Destroy(var_130_1)

	if arg_130_0.role then
		local var_130_2 = arg_130_0.displayUnit

		var_1.OnDetach(var_130_2)

		pg = var_1

		local var_130_3 = var_1.ViewUtils.SetLayer
		local var_130_4 = arg_130_0.role.transform

		Layer = var_1_10003

		var_130_3(var_130_4, var_1_10003.Default)

		if arg_130_0.isCommander then
			local var_130_5 = arg_130_0:GetPoolMgr()

			var_1.ReturnCommanderModel(var_130_5, arg_130_0.role)
		elseif arg_130_0.modelData then
			local var_130_6 = arg_130_0:GetPoolMgr()

			var_1.ReturnCharacter(var_130_6, arg_130_0.modelData.model, arg_130_0.modelData.animator, arg_130_0.role)

			arg_130_0.modelData = nil
		end

		arg_130_0.role = nil
	end

	arg_130_0.modelData = nil

	return
end

function var_0_1.BindExchangeTab(arg_131_0, arg_131_1, arg_131_2)
	local var_131_0 = arg_131_2 - arg_131_0.exchangeTabStartIdx + 1
	local var_131_1 = arg_131_0.exchangeShowIds[var_131_0]

	pg = var_1_10005

	local var_131_2 = var_1_10005.island_exchange_group[var_131_1]

	setText = var_1_10006

	var_1_10006(arg_131_1:Find("shop1Tg/name"), var_131_2.text[1])

	setText = var_1_10006

	var_1_10006(arg_131_1:Find("shop1Tg/name/en"), var_131_2.text[2])

	GetImageSpriteFromAtlasAsync = var_1_10006

	var_1_10006("island/islandshopicon", var_131_2.text[3], arg_131_1:Find("shop1Tg/selected/icon"))

	setActive = var_1_10006

	var_1_10006(arg_131_1:Find("shop2List"), false)

	onToggle = var_1_10006

	local var_131_3 = arg_131_0
	local var_131_4 = arg_131_1:Find("shop1Tg")

	local function var_131_5(arg_132_0)
		setActive = var_2_10001

		var_2_10001(arg_131_0.bg, not arg_132_0)

		setActive = var_2_10001

		local var_132_0 = arg_131_1

		var_2_10001(var_2.Find(var_132_0, "shop2List"), arg_132_0)

		local var_132_1 = arg_131_0

		var_1.SetResourcesVisible(var_132_1, not arg_132_0)

		if arg_132_0 then
			if arg_131_0.currentShop1TgIndex == arg_131_2 then
				return
			end

			arg_131_0.currentShop1TgIndex = arg_131_2

			local var_132_2 = arg_131_1
			local var_132_3 = var_1.GetComponent

			typeof = var_3
			Animation = var_4

			local var_132_4 = var_132_3(var_132_2, var_3(var_4))

			var_1.Play(var_132_4, "anim_IslandShopUI_Shop1List_Selected")

			triggerToggle = var_1

			local var_132_5 = arg_131_1
			local var_132_6 = var_2.Find(var_132_5, "shop2List")

			var_1(var_2.GetChild(var_132_6, 0), true)

			setText = var_1

			local var_132_7 = arg_131_0.title
			local var_132_8 = var_2.Find(var_132_7, "Text")

			i18n = var_132_7

			var_1(var_132_8, var_132_7("island_exchange_title"))

			setText = var_1

			local var_132_9 = arg_131_0.title
			local var_132_10 = var_2.Find(var_132_9, "Text/en")

			i18n = var_132_9

			var_1(var_132_10, var_132_9("island_exchange_title_en"))

			local var_132_11 = arg_131_0

			var_1.SetShopPageVisible(var_132_11, false)

			setActive = var_1

			var_1(arg_131_0.shop3, false)

			setActive = var_1

			var_1(arg_131_0.shop32, false)

			local var_132_12 = arg_131_0.exchangSubView

			var_1.ExecuteAction(var_132_12, "Show")
		else
			local var_132_13 = arg_131_0.exchangSubView

			var_1.ExecuteAction(var_132_13, "Hide")
		end

		return
	end

	SFX_PANEL = var_10

	var_1_10006(var_131_3, var_131_4, var_131_5, var_10)

	local var_131_6 = var_131_2.exchange_group

	UIItemList = var_131_3

	var_131_3.StaticAlign(arg_131_1:Find("shop2List"), arg_131_1:Find("shop2List/shop2Tpl"), #var_131_6, function(arg_133_0, arg_133_1, arg_133_2)
		UIItemList = var_2_10003

		if arg_133_0 == var_2_10003.EventUpdate then
			local var_133_0 = arg_133_1 + 1
			local var_133_1 = var_131_6[var_133_0][1]
			local var_133_2 = var_131_6[var_133_0][2]

			setText = var_2_10006

			var_2_10006(arg_133_2:Find("name"), var_133_1)

			setText = var_2_10006

			var_2_10006(arg_133_2:Find("selected/name"), var_133_1)

			onToggle = var_2_10006

			local var_133_3 = arg_131_0
			local var_133_4 = arg_133_2

			local function var_133_5(arg_134_0)
				if arg_134_0 then
					local var_134_0 = arg_133_2
					local var_134_1 = var_1.GetComponent

					typeof = var_3_10003
					Animation = var_3_10004

					local var_134_2 = var_134_1(var_134_0, var_3_10003(var_3_10004))

					var_1.Play(var_134_2, "anim_IslandShopUI_Shop2List_Selected")

					local var_134_3 = arg_131_0.exchangSubView

					var_1.ExecuteAction(var_134_3, "FlushGroup", var_133_2)
				end

				return
			end

			SFX_PANEL = var_2_10010

			var_2_10006(var_133_3, var_133_4, var_133_5, var_2_10010)
		end

		return
	end)

	return
end

function var_0_1.OnExchangeDone(arg_135_0)
	local var_135_0 = arg_135_0.exchangSubView

	var_1.ExecuteAction(var_135_0, "FlushGroup")

	return
end

function var_0_1.OnShow(arg_136_0, arg_136_1, arg_136_2, arg_136_3)
	local var_136_0 = arg_136_0

	arg_136_0.OverlayPanel(var_136_0, arg_136_0._tf)

	arg_136_0.showTypes = arg_136_1
	arg_136_0.firstShopIds = arg_136_2
	arg_136_0.showDrawAward = arg_136_3 == 1
	getProxy = var_4
	ActivityProxy = var_136_0

	local var_136_1 = var_4(var_136_0)
	local var_136_2 = var_4.getActivityByType

	ActivityConst = var_6
	arg_136_0.drawAwardActivity = var_136_2(var_136_1, var_6.ACTIVITY_TYPE_ISLAND_DRAW_AWARD)

	arg_136_0:DoUpdateShops()
	arg_136_0:UpdateData()
	arg_136_0:SetShopList()

	return
end

function var_0_1.OnHide(arg_137_0)
	arg_137_0:UnOverlayPanel(arg_137_0._tf)

	if arg_137_0.timer then
		local var_137_0 = arg_137_0.timer

		var_1.Stop(var_137_0)

		arg_137_0.timer = nil
	end

	arg_137_0:ResetCommanderDressPreview(false)

	arg_137_0.shoppingCartCommodities = {}
	arg_137_0.showingCommodity = nil

	local var_137_1 = arg_137_0.islandShipDressHelper

	var_1.Destroy(var_137_1)
	arg_137_0:UnloadCharacter()

	local var_137_2 = arg_137_0.drawAwardPage

	var_1.Destroy(var_137_2)

	local var_137_3 = arg_137_0.drawAwardPage

	var_1.Reset(var_137_3)

	local var_137_4 = arg_137_0.exchangSubView

	var_1.ExecuteAction(var_137_4, "Hide")

	ipairs = var_1

	local var_137_5

	if not arg_137_0.loadingIdList then
		var_137_5 = {}
	end

	for iter_137_0, iter_137_1 in var_1(var_137_5) do
		IslandAssetLoadDispatcher = var_1_10006

		local var_137_6 = var_1_10006.Instance

		var_1_10006.Cancel(var_137_6, iter_137_1)
	end

	arg_137_0.loadingIdList = {}

	return
end

function var_0_1.OnDisable(arg_138_0)
	arg_138_0:OnHide()
	var_0_1.super.OnDisable(arg_138_0)

	return
end

function var_0_1.OnDestroy(arg_139_0)
	arg_139_0:OnHide()

	if arg_139_0.exchangSubView then
		local var_139_0 = arg_139_0.exchangSubView

		var_1.Destroy(var_139_0)

		arg_139_0.exchangSubView = nil
	end

	var_0_1.super.OnDestroy(arg_139_0)

	return
end

function var_0_1.CanEsc(arg_140_0)
	if arg_140_0.morphing then
		return false
	end

	return true
end

function var_0_1.StaticUpdateCommodityTpl(arg_141_0, arg_141_1)
	local var_141_0 = arg_141_1:GetMaxNum() - arg_141_1.purchasedNum

	setText = var_3

	var_3(arg_141_0:Find("name"), arg_141_1:GetName())

	local var_141_2

	if #arg_141_1:GetItems() == 1 then
		local var_141_1 = arg_141_1

		var_141_2 = arg_141_1.GetItems(var_141_1)[1][1]
		DROP_TYPE_ISLAND_FURNITURE = var_141_1

		if var_141_2 ~= var_141_1 then
			local var_141_3 = arg_141_1

			var_141_2 = arg_141_1.GetItems(var_141_3)[1][1]
			DROP_TYPE_ISLAND_DRESS = var_141_3

			if var_141_2 ~= var_141_3 then
				local var_141_4 = arg_141_1

				var_141_2 = arg_141_1.GetItems(var_141_4)[1][1]
				DROP_TYPE_ISLAND_SKIN = var_141_4

				if var_141_2 ~= var_141_4 then
					var_141_2 = arg_141_1:GetItems()[1]

					local var_141_5 = {
						type = var_141_2[1],
						id = var_141_2[2],
						count = var_141_2[3]
					}

					updateCustomDrop = var_5

					var_5(arg_141_0:Find("IslandItemTpl"), var_141_5, {
						style = "island"
					})

					goto label_141_0
				end
			end
		end
	end

	GetImageSpriteFromAtlasAsync = var_141_2

	var_141_2(arg_141_1:GetIcon(), "", arg_141_0:Find("IslandItemTpl/icon_bg/icon"))

	::label_141_0::

	setActive = var_141_2

	var_141_2(arg_141_0:Find("IslandItemTpl/icon_bg/count_bg"), arg_141_1:IsShowPurchaseLimit())

	setText = var_141_2

	var_141_2(arg_141_0:Find("IslandItemTpl/icon_bg/count_bg/count"), var_141_0 .. "/" .. arg_141_1:GetMaxNum())

	local var_141_6 = arg_141_1
	local var_141_7 = arg_141_1.GetResourceConsume(var_141_6)

	GetImageSpriteFromAtlasAsync = var_141_6
	Drop = var_5

	local var_141_8 = var_5.New({
		type = var_141_7[1],
		id = var_141_7[2]
	})

	var_141_6(var_5.getIcon(var_141_8), "", arg_141_0:Find("cost/icon"))

	setText = var_141_6

	local var_141_9 = arg_141_0
	local var_141_10 = arg_141_0.Find(var_141_9, "cost/num")

	math = var_141_9

	var_141_6(var_141_10, var_141_9.ceil((100 - arg_141_1:GetDiscount()) / 100 * var_141_7[3]))

	local var_141_11 = arg_141_1
	local var_141_12 = arg_141_1.GetTag(var_141_11)

	setActive = var_141_11

	local var_141_13 = arg_141_0
	local var_141_14 = arg_141_0.Find(var_141_13, "tags/timeLimit")

	IslandCommodity = var_141_13

	var_141_11(var_141_14, var_141_12 == var_141_13.TAG.TIME)

	setActive = var_141_11

	local var_141_15 = arg_141_0
	local var_141_16 = arg_141_0.Find(var_141_15, "tags/new")

	IslandCommodity = var_141_15

	var_141_11(var_141_16, var_141_12 == var_141_15.TAG.NEW)

	setActive = var_141_11

	local var_141_17 = arg_141_0
	local var_141_18 = arg_141_0.Find(var_141_17, "tags/hot")

	IslandCommodity = var_141_17

	var_141_11(var_141_18, var_141_12 == var_141_17.TAG.HOT)

	setActive = var_141_11

	var_141_11(arg_141_0:Find("discount"), arg_141_1:GetDiscount() ~= 0)

	setText = var_141_11

	var_141_11(arg_141_0:Find("discount/Text"), "-" .. arg_141_1:GetDiscount() .. "%")

	local var_141_19 = arg_141_1:GetItems()[1][1]
	local var_141_20 = arg_141_1
	local var_141_21 = arg_141_1.GetItems(var_141_20)[1][2]

	Drop = var_141_20

	local var_141_22 = var_141_20.New({
		count = 1,
		type = var_141_19,
		id = var_141_21
	})
	local var_141_23 = var_7.getOwnedCount(var_141_22)

	setActive = var_141_22

	var_141_22(arg_141_0:Find("have"), arg_141_1:IsShowHave())

	setText = var_141_22

	local var_141_24 = arg_141_0
	local var_141_25 = arg_141_0.Find(var_141_24, "have")

	i18n = var_141_24

	var_141_22(var_141_25, var_141_24("island_3Dshop_have") .. var_141_23)

	underscore = var_141_22

	local var_141_26 = var_141_22.all(arg_141_1:GetItems(), function(arg_142_0)
		Drop = var_2_10001

		local var_142_0 = var_2_10001.New({
			count = 1,
			type = arg_142_0[1],
			id = arg_142_0[2]
		})

		return var_1.getOwnedCount(var_142_0) > 0
	end)

	setActive = var_9

	local var_141_27 = arg_141_0:Find("hold")
	local var_141_28

	if arg_141_1:IsShowHold() and not arg_141_1:IsCharacterInviteItemHold() then
		var_141_28 = var_141_26
	end

	var_9(var_141_27, var_141_28)

	setActive = var_9

	local var_141_29 = arg_141_0:Find("sellOut")
	local var_141_30

	if arg_141_1:GetMaxNum() ~= 0 and var_141_0 == 0 then
		isActive = var_11
		var_141_30 = not var_11(arg_141_0:Find("hold"))
	else
		var_141_30 = false
	end

	if false then
		var_141_30 = true
	end

	var_9(var_141_29, var_141_30)

	setActive = var_9

	local var_141_31 = arg_141_0
	local var_141_32 = arg_141_0.Find(var_141_31, "cost")

	isActive = var_141_31

	local var_141_33

	if not var_141_31(arg_141_0:Find("sellOut")) then
		isActive = var_11
		var_141_33 = not var_11(arg_141_0:Find("hold"))
	else
		var_141_33 = false
	end

	if false then
		var_141_33 = true
	end

	var_9(var_141_32, var_141_33)

	setActive = var_9

	var_9(arg_141_0:Find("select"), false)

	setText = var_9

	local var_141_34 = arg_141_0
	local var_141_35 = arg_141_0.Find(var_141_34, "sellOut/Text")

	i18n = var_141_34

	var_9(var_141_35, var_141_34("common_sale_out"))

	setText = var_9

	local var_141_36 = arg_141_0
	local var_141_37 = arg_141_0.Find(var_141_36, "hold/Text")

	i18n = var_141_36

	var_9(var_141_37, var_141_36("common_already owned"))

	return
end

function var_0_1.SortShopCommodities(arg_143_0)
	table = var_1_10001

	local var_143_0 = var_1_10001.sort
	local var_143_1 = arg_143_0

	CompareFuncs = var_1_10003

	var_143_0(var_143_1, var_1_10003({
		function(arg_144_0)
			local var_144_0 = arg_144_0:GetMaxNum() - arg_144_0.purchasedNum

			if arg_144_0:GetMaxNum() ~= 0 and var_144_0 == 0 then
				return 3
			end

			if arg_144_0:IsShowHold() then
				if arg_144_0:IsCharacterInviteItemHold() then
					return 2
				else
					underscore = var_3

					return var_3.all(arg_144_0:GetItems(), function(arg_145_0)
						Drop = var_3_10001

						local var_145_0 = var_3_10001.New({
							count = 1,
							type = arg_145_0[1],
							id = arg_145_0[2]
						})

						return var_1.getOwnedCount(var_145_0) > 0
					end) and 2 or 1
				end
			else
				return 1
			end

			return
		end,
		function(arg_146_0)
			return arg_146_0:GetCfgSortIdx()
		end,
		function(arg_147_0)
			return arg_147_0.id
		end
	}))

	return
end

return var_0_1
