local var_0_0 = class("IslandShopPage", import("..ship.IslandBaseShipDisplayPage"))
local var_0_1 = 3

var_0_0.CharaSetModel = {
	current = 1,
	default = 2
}

function var_0_0.getUIName(arg_1_0)
	return "IslandShopUI"
end

function var_0_0.OnLoaded(arg_2_0)
	arg_2_0.bg = arg_2_0._tf:Find("bg")
	arg_2_0.bgColor = arg_2_0.bg:Find("color")
	arg_2_0.closeBtn = arg_2_0._tf:Find("adapt/top/closeBtn")
	arg_2_0.helpBtn = arg_2_0._tf:Find("adapt/top/helpBtn")
	arg_2_0.title = arg_2_0._tf:Find("adapt/top/title")
	arg_2_0.resourceList = UIItemList.New(arg_2_0._tf:Find("adapt/top/resources"), arg_2_0._tf:Find("adapt/top/resources/resourceTpl"))
	arg_2_0.shop1List = UIItemList.New(arg_2_0._tf:Find("adapt/shop1List"), arg_2_0._tf:Find("adapt/shop1List/shop1Tpl"))
	arg_2_0.shop3 = arg_2_0._tf:Find("adapt/shop3List")
	arg_2_0.shop3List = UIItemList.New(arg_2_0._tf:Find("adapt/shop3List"), arg_2_0._tf:Find("adapt/shop3List/shop3Tpl"))
	arg_2_0.shop32 = arg_2_0._tf:Find("adapt/shop3List2")
	arg_2_0.shop3List2 = UIItemList.New(arg_2_0._tf:Find("adapt/shop3List2"), arg_2_0._tf:Find("adapt/shop3List2/shop3Tpl"))
	arg_2_0.recommendationPage5 = arg_2_0._tf:Find("adapt/shopPage/recommendation5")
	arg_2_0.recommendationPage1 = arg_2_0._tf:Find("adapt/shopPage/recommendation1")
	arg_2_0.shop2DPage = arg_2_0._tf:Find("adapt/shopPage/shop2D")
	arg_2_0.shop3DPage = arg_2_0._tf:Find("adapt/shopPage/shop3D")
	arg_2_0.shopFurniturePage = arg_2_0._tf:Find("adapt/shopPage/shopFurniture")
	arg_2_0.shopSkinPage = arg_2_0._tf:Find("adapt/shopPage/shopSkin")
	arg_2_0.morphBtn = arg_2_0.shopSkinPage:Find("morphBtn")
	arg_2_0.morphBlocker = arg_2_0._tf:Find("morph_blocker")

	setActive(arg_2_0.morphBlocker, false)

	arg_2_0.changeCharaPanel = arg_2_0.shopSkinPage:Find("changeCharaPanel/panel")
	arg_2_0.subPageContainer = arg_2_0._tf:Find("adapt/subPageContainer")
	arg_2_0.drawAwardPage = IslandShopDrawAwardPage.New(arg_2_0.subPageContainer, arg_2_0)

	setText(arg_2_0.shopSkinPage:Find("changeCharaPanel/panel/title"), i18n("island_3Dshop_chara_choose"))
	setText(arg_2_0.shopSkinPage:Find("changeCharaPanel/panel/setTxt"), i18n("island_3Dshop_chara_set"))

	arg_2_0.exchangSubView = IslandShopExchangePage.New(arg_2_0._tf, arg_2_0)

	arg_2_0.exchangSubView:RegisterView(arg_2_0)

	return
end

function var_0_0.OnInit(arg_3_0)
	onButton(arg_3_0, arg_3_0.closeBtn, function()
		arg_3_0:Hide()

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0.helpBtn, function()
		arg_3_0:ShowMsgBox({
			hideNo = true,
			type = IslandMsgBox.TYPE_COMMON,
			content = i18n("island_draw_help"),
			alignment = TextAnchor.MiddleLeft
		})

		return
	end, SFX_PANEL)
	arg_3_0:InitData()

	return
end

function var_0_0.InitData(arg_6_0)
	arg_6_0.shopAgency = getProxy(IslandProxy):GetIsland():GetShopAgency()
	arg_6_0.inventoryAgency = getProxy(IslandProxy):GetIsland():GetInventoryAgency()
	arg_6_0.characterAgency = getProxy(IslandProxy):GetIsland():GetCharacterAgency()
	arg_6_0.player = getProxy(PlayerProxy):getRawData()
	arg_6_0.ships = arg_6_0.characterAgency:GetShips()
	arg_6_0.defaultShipId = PlayerPrefs.GetInt("island_dressShop_defaultShipId_" .. arg_6_0.player.id, 10703)
	arg_6_0.islandShipDressHelper = IslandShipDressHelperNew.New()

	return
end

function var_0_0.DoUpdateShops(arg_7_0)
	local var_7_0 = arg_7_0.shopAgency:GetNewOrOverdueShopIds()

	if #var_7_0 > 0 then
		for iter_7_0, iter_7_1 in ipairs(var_7_0) do
			arg_7_0:emit(IslandMediator.GET_SHOP_DATA, iter_7_1, true)
		end
	end

	arg_7_0.showingShop = nil
	arg_7_0.selectShipId = arg_7_0.defaultShipId

	return
end

function var_0_0.DoUpdateShowingShop(arg_8_0)
	if arg_8_0.showingShop:IsInTime() then
		arg_8_0:emit(IslandMediator.GET_SHOP_DATA, arg_8_0.showingShop.id, false)
	else
		arg_8_0:SetShopPage()
	end

	if isActive(arg_8_0.shop3) or isActive(arg_8_0.shop32) then
		local var_8_0 = arg_8_0.showingShop:GetShowType()

		setActive(arg_8_0.shop3, var_8_0 == IslandConst.SHOP_TYPE_RECOMMENDATION_5 or var_8_0 == IslandConst.SHOP_TYPE_RECOMMENDATION_1 or var_8_0 == IslandConst.SHOP_TYPE_2D)
		setActive(arg_8_0.shop32, var_8_0 == IslandConst.SHOP_TYPE_3D or var_8_0 == IslandConst.SHOP_TYPE_FURNITURE or var_8_0 == IslandConst.SHOP_TYPE_SKIN)
	end

	return
end

function var_0_0.UpdateData(arg_9_0)
	arg_9_0.firstShopConfigs = arg_9_0.shopAgency:GetFirstShopConfigs(arg_9_0.showTypes, arg_9_0.firstShopIds)

	if not arg_9_0.showingShop or not arg_9_0.shopAgency:IsShowShop(arg_9_0.showingShop.id) then
		arg_9_0.showingShop = arg_9_0.shopAgency:GetInitShowingShop(arg_9_0.showTypes, arg_9_0.firstShopIds)
	end

	return
end

function var_0_0.SetShopPageVisible(arg_10_0, arg_10_1)
	setActive(arg_10_0._tf:Find("adapt/shopPage"), arg_10_1)

	if not IsNil(arg_10_0.roleContainer) then
		setActive(arg_10_0.roleContainer, arg_10_1)
	end

	return
end

function var_0_0.GetShopConfigIds(arg_11_0, arg_11_1)
	for iter_11_0, iter_11_1 in ipairs(arg_11_1) do
		table.insert({}, iter_11_1.id)
	end

	return {}
end

function var_0_0.GetRecommendationTargetShop(arg_12_0, arg_12_1)
	if not arg_12_1 then
		return nil
	end

	if arg_12_1.shop_type ~= 0 then
		return arg_12_0.shopAgency:GetShopById(arg_12_1.id)
	end

	if arg_12_1.tag_type == 1 then
		for iter_12_0, iter_12_1 in ipairs((arg_12_0.shopAgency:GetSecondShopConfigs(arg_12_0.showTypes, arg_12_1.id))) do
			local var_12_0 = arg_12_0:GetRecommendationTargetShop(iter_12_1)

			if var_12_0 then
				return var_12_0
			end
		end
	elseif arg_12_1.tag_type == 2 then
		for iter_12_2, iter_12_3 in ipairs((arg_12_0.shopAgency:GetThirdShopConfigs(arg_12_0.showTypes, arg_12_1.id))) do
			local var_12_1 = arg_12_0:GetRecommendationTargetShop(iter_12_3)

			if var_12_1 then
				return var_12_1
			end
		end
	end

	return nil
end

function var_0_0.JumpToRecommendationShop(arg_13_0, arg_13_1)
	local var_13_0 = arg_13_0:GetRecommendationTargetShop(pg.island_shop_template[arg_13_1])

	if not var_13_0 then
		return
	end

	arg_13_0.showingShop = var_13_0

	if arg_13_0.showingShop:IsInTime() then
		arg_13_0:emit(IslandMediator.GET_SHOP_DATA, arg_13_0.showingShop.id, true)
	else
		arg_13_0:UpdateData()
		arg_13_0:SetShopList()
	end

	return
end

function var_0_0.SetThirdShopTpl(arg_14_0, arg_14_1, arg_14_2)
	setActive(arg_14_1:Find("selected"), arg_14_0.showingShop.id == arg_14_2.id)
	setText(arg_14_1:Find("name"), arg_14_2.tag_icon[1])
	setText(arg_14_1:Find("selected/name"), arg_14_2.tag_icon[1])
	setActive(arg_14_1:Find("icon"), arg_14_2.tag_icon[3])

	if arg_14_2.tag_icon[3] then
		LoadImageSpriteAsync(arg_14_2.tag_icon[3], arg_14_1:Find("icon"), false)
	end

	local var_14_0 = arg_14_0.shopAgency:GetShopById(arg_14_2.id):IsInTime()

	setActive(arg_14_1:Find("lock"), not var_14_0)
	setActive(arg_14_1:Find("selected/lock"), not var_14_0)

	return
end

function var_0_0.SelectThirdShop(arg_15_0, arg_15_1, arg_15_2, arg_15_3, arg_15_4, arg_15_5, arg_15_6, arg_15_7)
	if arg_15_0.currentShop1TgIndex == arg_15_4 and arg_15_0.currentShop2TgIndex == arg_15_5 and arg_15_0.currentShop3TgIndex == arg_15_6 then
		return
	end

	for iter_15_0 = 0, arg_15_2.childCount - 1 do
		local var_15_0 = arg_15_2:GetChild(iter_15_0)

		setActive(var_15_0:Find("selected"), false)
	end

	setActive(arg_15_1:Find("selected"), true)

	if arg_15_7 then
		arg_15_1:GetComponent(typeof(Animation)):Play("anim_IslandShopUI_Shop3List_Selected")
	end

	arg_15_0.showingShop = arg_15_0.shopAgency:GetShopById(arg_15_3.id)

	arg_15_0:DoUpdateShowingShop()

	arg_15_0.currentShop3TgIndex = arg_15_6

	return
end

function var_0_0.BindThirdShopList(arg_16_0, arg_16_1, arg_16_2, arg_16_3, arg_16_4, arg_16_5, arg_16_6)
	local var_16_0 = arg_16_0:GetShopConfigIds(arg_16_3)

	arg_16_1:make(function(arg_17_0, arg_17_1, arg_17_2)
		if arg_17_0 ~= UIItemList.EventUpdate then
			return
		end

		local var_17_0 = arg_16_3[arg_17_1 + 1]

		arg_16_0:SetThirdShopTpl(arg_17_2, arg_16_3[arg_17_1 + 1])
		onToggle(arg_16_0, arg_17_2, function(arg_18_0)
			if arg_18_0 then
				arg_16_0:SelectThirdShop(arg_17_2, arg_16_2, var_17_0, arg_16_4, arg_16_5, var_0, arg_16_6)
			end

			return
		end, SFX_PANEL)

		if arg_16_0.showingShop.id == var_17_0.id then
			triggerToggle(arg_17_2, true)
		end

		if arg_17_1 == 0 and not table.contains(var_16_0, arg_16_0.showingShop.id) then
			triggerToggle(arg_17_2, true)
		end

		return
	end, SFX_PANEL)
	arg_16_1:align(#arg_16_3)

	return
end

function var_0_0.BindThirdShopLists(arg_19_0, arg_19_1, arg_19_2, arg_19_3)
	arg_19_0:BindThirdShopList(arg_19_0.shop3List, arg_19_0.shop3, arg_19_1, arg_19_2, arg_19_3, true)
	arg_19_0:BindThirdShopList(arg_19_0.shop3List2, arg_19_0.shop32, arg_19_1, arg_19_2, arg_19_3, false)

	return
end

function var_0_0.SetSecondShopTpl(arg_20_0, arg_20_1, arg_20_2)
	setActive(arg_20_1:Find("selected"), arg_20_0.showingShop.id == arg_20_2.id or arg_20_0.showingShop:GetSecondShopId() == arg_20_2.id)
	setText(arg_20_1:Find("name"), arg_20_2.tag_icon[1])
	setText(arg_20_1:Find("selected/name"), arg_20_2.tag_icon[1])

	return
end

function var_0_0.SelectSecondShop(arg_21_0, arg_21_1, arg_21_2, arg_21_3, arg_21_4)
	if arg_21_0.currentShop1TgIndex == arg_21_3 and arg_21_0.currentShop2TgIndex == arg_21_4 then
		return
	end

	arg_21_1:GetComponent(typeof(Animation)):Play("anim_IslandShopUI_Shop2List_Selected")
	setActive(arg_21_0.shop3, arg_21_2.shop_type == 0)
	setActive(arg_21_0.shop32, arg_21_2.shop_type == 0)

	if arg_21_2.shop_type == 0 then
		arg_21_0:BindThirdShopLists(arg_21_0.shopAgency:GetThirdShopConfigs(arg_21_0.showTypes, arg_21_2.id), arg_21_3, arg_21_4)
	else
		arg_21_0.showingShop = arg_21_0.shopAgency:GetShopById(arg_21_2.id)

		arg_21_0:DoUpdateShowingShop()
	end

	arg_21_0.currentShop2TgIndex = arg_21_4

	return
end

function var_0_0.BindSecondShopList(arg_22_0, arg_22_1, arg_22_2, arg_22_3)
	local var_22_0 = arg_22_0.shopAgency:GetSecondShopConfigs(arg_22_0.showTypes, arg_22_2.id)
	local var_22_1 = arg_22_0:GetShopConfigIds(var_22_0)
	local var_22_2 = UIItemList.New(arg_22_1:Find("shop2List"), arg_22_1:Find("shop2List/shop2Tpl"))

	var_22_2:make(function(arg_23_0, arg_23_1, arg_23_2)
		if arg_23_0 ~= UIItemList.EventUpdate then
			return
		end

		local var_23_0 = var_22_0[arg_23_1 + 1]

		arg_22_0:SetSecondShopTpl(arg_23_2, var_22_0[arg_23_1 + 1])
		onToggle(arg_22_0, arg_23_2, function(arg_24_0)
			if arg_24_0 then
				arg_22_0:SelectSecondShop(arg_23_2, var_23_0, arg_22_3, var_0)
			end

			return
		end, SFX_PANEL)

		if arg_22_0.showingShop.id == var_23_0.id or arg_22_0.showingShop:GetSecondShopId() == var_23_0.id then
			triggerToggle(arg_23_2, true)
		end

		if arg_23_1 == 0 and not table.contains(var_22_1, arg_22_0.showingShop.id) and not table.contains(var_22_1, arg_22_0.showingShop:GetSecondShopId()) then
			triggerToggle(arg_23_2, true)
		end

		return
	end)
	var_22_2:align(#var_22_0)

	return
end

function var_0_0.SelectFirstShop(arg_25_0, arg_25_1, arg_25_2, arg_25_3)
	if arg_25_0.currentShop1TgIndex == arg_25_3 then
		return
	end

	arg_25_0:SetShopPageVisible(true)
	setActive(arg_25_0.shop3, false)
	setActive(arg_25_0.shop32, false)
	arg_25_1:GetComponent(typeof(Animation)):Play("anim_IslandShopUI_Shop1List_Selected")
	setActive(arg_25_1:Find("shop2List"), arg_25_2.shop_type == 0)

	if arg_25_2.shop_type == 0 then
		arg_25_0:BindSecondShopList(arg_25_1, arg_25_2, arg_25_3)
	else
		arg_25_0.showingShop = arg_25_0.shopAgency:GetShopById(arg_25_2.id)

		arg_25_0:DoUpdateShowingShop()
	end

	arg_25_0.currentShop1TgIndex = arg_25_3

	return
end

function var_0_0.BindFirstShopTab(arg_26_0, arg_26_1, arg_26_2, arg_26_3)
	setActive(arg_26_1:Find("shop2List"), false)
	GetImageSpriteFromAtlasAsync("island/islandshopicon", arg_26_2.tag_icon[3], arg_26_1:Find("shop1Tg/selected/icon"), false)
	setText(arg_26_1:Find("shop1Tg/name"), arg_26_2.tag_icon[1])
	setText(arg_26_1:Find("shop1Tg/name/en"), arg_26_2.tag_icon[2])
	onToggle(arg_26_0, arg_26_1:Find("shop1Tg"), function(arg_27_0)
		if arg_27_0 then
			arg_26_0:SelectFirstShop(arg_26_1, arg_26_2, arg_26_3)
		else
			setActive(arg_26_1:Find("shop2List"), false)
		end

		return
	end, SFX_PANEL)

	if arg_26_0.showingShop.id == arg_26_2.id or arg_26_0.showingShop:GetFirstShopId() == arg_26_2.id then
		triggerToggle(arg_26_1:Find("shop1Tg"), true)
	end

	return
end

function var_0_0.BindDrawAwardTab(arg_28_0, arg_28_1, arg_28_2)
	setActive(arg_28_1:Find("shop2List"), false)
	setText(arg_28_1:Find("shop1Tg/name"), i18n("island_draw_tab"))
	setText(arg_28_1:Find("shop1Tg/name/en"), i18n("island_draw_tab_en"))
	setActive(arg_28_1:Find("shop1Tg/selected/icon"), false)
	onToggle(arg_28_0, arg_28_1:Find("shop1Tg"), function(arg_29_0)
		if arg_29_0 then
			if arg_28_0.currentShop1TgIndex == arg_28_2 then
				return
			end

			arg_28_0.currentShop1TgIndex = arg_28_2

			arg_28_1:GetComponent(typeof(Animation)):Play("anim_IslandShopUI_Shop1List_Selected")
			setText(arg_28_0.title:Find("Text"), i18n("island_draw_tab"))
			arg_28_0:SetResources()
			arg_28_0:SetShopPageVisible(false)
			setActive(arg_28_0.shop3, false)
			setActive(arg_28_0.shop32, false)
			arg_28_0.drawAwardPage:ActionInvoke("UpdateActivity", arg_28_0.drawAwardActivity)
			arg_28_0.drawAwardPage:ExecuteAction("Show")
		else
			arg_28_0.drawAwardPage:ExecuteAction("Hide")
		end

		return
	end, SFX_PANEL)

	return
end

function var_0_0.SetShopList(arg_30_0)
	arg_30_0.currentShop1TgIndex = nil
	arg_30_0.currentShop2TgIndex = nil
	arg_30_0.currentShop3TgIndex = nil
	arg_30_0.drawTabCnt = arg_30_0.showDrawAward and arg_30_0.drawAwardActivity and 1 or 0

	if arg_30_0.drawTabCnt > 0 then
		arg_30_0.drawTabIdx = #arg_30_0.firstShopConfigs + 1 or nil
		arg_30_0.exchangeShowIds = (function()
			if not getProxy(IslandProxy):GetIsland():GetTaskAgency():IsFinishTask(var_0_1) then
				return {}
			end

			return pg.island_exchange_group.all
		end)()

		if arg_30_0.drawTabIdx then
			arg_30_0.exchangeTabStartIdx = arg_30_0.drawTabIdx + 1 or #arg_30_0.firstShopConfigs + 1

			arg_30_0.shop1List:make(function(arg_32_0, arg_32_1, arg_32_2)
				arg_32_1 = arg_32_1 + 1

				if arg_32_0 == UIItemList.EventUpdate then
					if arg_30_0.firstShopConfigs[arg_32_1] then
						arg_30_0:BindFirstShopTab(arg_32_2, arg_30_0.firstShopConfigs[arg_32_1], arg_32_1)
					elseif arg_30_0.drawTabIdx and arg_32_1 == arg_30_0.drawTabIdx then
						arg_30_0:BindDrawAwardTab(arg_32_2, arg_32_1)
					elseif #arg_30_0.exchangeShowIds > 0 and arg_32_1 >= arg_30_0.exchangeTabStartIdx then
						arg_30_0:BindExchangeTab(arg_32_2, arg_32_1)
					end
				end

				return
			end)
			arg_30_0.shop1List:align(#arg_30_0.firstShopConfigs + arg_30_0.drawTabCnt + #arg_30_0.exchangeShowIds)

			return
		end
	end
end

function var_0_0.SetShopPage(arg_33_0)
	local var_33_0 = arg_33_0.showingShop:GetShowType()

	setText(arg_33_0.title:Find("Text"), arg_33_0.showingShop:GetShopIcon()[1])
	setText(arg_33_0.title:Find("Text/en"), arg_33_0.showingShop:GetShopIcon()[2])
	arg_33_0:SetResources()
	setActive(arg_33_0.recommendationPage1, var_33_0 == IslandConst.SHOP_TYPE_RECOMMENDATION_1)
	setActive(arg_33_0.recommendationPage5, var_33_0 == IslandConst.SHOP_TYPE_RECOMMENDATION_5)
	setActive(arg_33_0.shop2DPage, var_33_0 == IslandConst.SHOP_TYPE_2D)
	setActive(arg_33_0.shop3DPage, var_33_0 == IslandConst.SHOP_TYPE_3D)
	setActive(arg_33_0.shopFurniturePage, var_33_0 == IslandConst.SHOP_TYPE_FURNITURE)
	setActive(arg_33_0.shopSkinPage, var_33_0 == IslandConst.SHOP_TYPE_SKIN)
	switch(var_33_0, {
		[IslandConst.SHOP_TYPE_RECOMMENDATION_1] = function()
			arg_33_0:ShowRecommendation1()

			return
		end,
		[IslandConst.SHOP_TYPE_RECOMMENDATION_5] = function()
			arg_33_0:ShowRecommendation5()

			return
		end,
		[IslandConst.SHOP_TYPE_2D] = function()
			arg_33_0:ShowShop2D()

			return
		end,
		[IslandConst.SHOP_TYPE_3D] = function()
			arg_33_0:ShowShop3D()

			return
		end,
		[IslandConst.SHOP_TYPE_FURNITURE] = function()
			arg_33_0:ShowShopFurniture()

			return
		end,
		[IslandConst.SHOP_TYPE_SKIN] = function()
			arg_33_0:ShowShopSkin()

			return
		end
	})

	return
end

function var_0_0.SetResources(arg_40_0)
	arg_40_0.player = getProxy(PlayerProxy):getRawData()

	setActive(arg_40_0.helpBtn, not arg_40_0.firstShopConfigs[arg_40_0.currentShop1TgIndex])

	if not arg_40_0.firstShopConfigs[arg_40_0.currentShop1TgIndex] then
		local var_40_0 = {}

		table.insert({}, Drop.New({
			type = DROP_TYPE_VITEM,
			id = arg_40_0.drawAwardActivity:GetDrawConfig("cost_free")
		}))
		table.insert({}, Drop.New({
			type = DROP_TYPE_RESOURCE,
			id = PlayerConst.ResDiamond
		}))
		arg_40_0.resourceList:make(function(arg_41_0, arg_41_1, arg_41_2)
			arg_41_1 = arg_41_1 + 1

			if arg_41_0 == UIItemList.EventUpdate then
				local var_41_0

				eachChild(arg_41_2, function(arg_42_0, arg_42_1)
					setActive(arg_42_0, arg_42_0.name == "islandItem")

					if arg_42_0.name == "islandItem" then
						var_41_0 = arg_42_0
					end

					return
				end)
				GetImageSpriteFromAtlasAsync(var_40_0[arg_41_1]:getIcon(), "", (nil):Find("icon"))
				setText((nil):Find("Text"), var_40_0[arg_41_1]:getOwnedCount())
				setActive((nil):Find("add"), false)
				setActive((nil):Find("add"), false)
				setActive((nil):Find("descBtn"), false)
				setActive((nil):Find("resourceDesc"), false)
			end

			return
		end)
		arg_40_0.resourceList:align(#{})

		return
	end

	local var_40_1 = arg_40_0.showingShop:GetTopResources()

	arg_40_0.resourceList:make(function(arg_43_0, arg_43_1, arg_43_2)
		if arg_43_0 == UIItemList.EventUpdate then
			local var_43_0 = var_40_1[arg_43_1 + 1][1]
			local var_43_1 = var_40_1[arg_43_1 + 1][3]

			setActive(arg_43_2:Find("gold"), false)
			setActive(arg_43_2:Find("oil"), false)
			setActive(arg_43_2:Find("gem"), false)
			setActive(arg_43_2:Find("islandItem"), false)

			if var_40_1[arg_43_1 + 1][2] == DROP_TYPE_RESOURCE then
				if var_43_1 == 1 then
					setActive(arg_43_2:Find("gold"), true)
					setText(arg_43_2:Find("gold/max"), "MAX: " .. arg_40_0.player:getLevelMaxGold())
					setText(arg_43_2:Find("gold/Text"), arg_40_0.player.gold)
				elseif var_43_1 == 4 or var_43_1 == 14 then
					setActive(arg_43_2:Find("gem"), true)
					setText(arg_43_2:Find("gem/Text"), arg_40_0.player:getTotalGem())
				end
			elseif var_40_1[arg_43_1 + 1][2] == DROP_TYPE_ISLAND_ITEM then
				setActive(arg_43_2:Find("islandItem"), true)

				local var_43_2 = arg_40_0.inventoryAgency:GetOwnCount(var_43_1)

				setText(arg_43_2:Find("islandItem/Text"), var_43_2)
				GetImageSpriteFromAtlasAsync(Drop.New({
					type = DROP_TYPE_ISLAND_ITEM,
					id = var_43_1
				}):getIcon(), "", arg_43_2:Find("islandItem/icon"))
				setActive(arg_43_2:Find("islandItem/descBtn"), var_43_0 == 1)
				setActive(arg_43_2:Find("islandItem/resourceDesc"), false)

				if var_43_0 == 1 then
					setText(arg_43_2:Find("islandItem/Text"), var_43_2 .. "/" .. pg.island_item_data_template[var_43_1].have_max)
					onButton(arg_40_0, arg_43_2:Find("islandItem"), function()
						setActive(arg_43_2:Find("islandItem/resourceDesc"), not isActive(arg_43_2:Find("islandItem/resourceDesc")))
						setText(arg_43_2:Find("islandItem/resourceDesc"), i18n("island_3Dshop_res_have") .. var_0)

						return
					end, SFX_PANEL)
				end
			end
		end

		return
	end)
	arg_40_0.resourceList:align(#var_40_1)

	return
end

function var_0_0.SetResourcesVisible(arg_45_0, arg_45_1)
	setActive(arg_45_0._tf:Find("adapt/top/resources"), arg_45_1)

	return
end

function var_0_0.SetCloseAndRefresh(arg_46_0, arg_46_1)
	local var_46_0 = 0

	if arg_46_0.showingShop:IsNormalShop() then
		local var_46_1 = arg_46_0.showingShop:GetExistTime()

		if type(var_46_1) == "table" then
			var_46_0 = pg.TimeMgr.GetInstance():Table2ServerTime({
				year = var_46_1[2][1][1],
				month = var_46_1[2][1][2],
				day = var_46_1[2][1][3],
				hour = var_46_1[2][2][1],
				min = var_46_1[2][2][2],
				sec = var_46_1[2][2][3]
			})
		end
	elseif arg_46_0.showingShop:IsTemporaryShop() then
		var_46_0 = arg_46_0.showingShop.existTime
	end

	local var_46_2 = arg_46_0.showingShop.refreshTime
	local var_46_3 = arg_46_0.showingShop:GetPlayerRefreshResource()

	setActive(arg_46_1:Find("remainAndRefresh/remainTimer"), var_46_0 ~= 0)
	setActive(arg_46_1:Find("remainAndRefresh/refresh"), var_46_2 ~= 0)
	setActive(arg_46_1:Find("remainAndRefresh/refresh/refreshBtn"), var_46_3)

	local var_46_4 = isActive(arg_46_1:Find("remainAndRefresh/remainTimer")) or isActive(arg_46_1:Find("remainAndRefresh/refresh"))

	setActive(arg_46_1:Find("remainAndRefresh"), var_46_4)

	local var_46_5 = pg.TimeMgr.GetInstance():GetTimeToNextTime()

	if arg_46_0.timer then
		arg_46_0.timer:Stop()

		arg_46_0.timer = nil
	end

	arg_46_0.timer = Timer.New(function()
		local var_47_0 = pg.TimeMgr.GetInstance():GetServerTime()

		if var_46_0 ~= 0 then
			setText(arg_46_1:Find("remainAndRefresh/remainTimer"), i18n("island_3Dshop_time_close", (pg.TimeMgr.GetInstance():DescCDTime(var_46_0 - var_47_0))))
		elseif normalShopExistTime and type(normalShopExistTime) == "table" then
			-- block empty
		end

		if var_46_2 ~= 0 then
			setText(arg_46_1:Find("remainAndRefresh/refresh/refreshTimer"), i18n("island_3Dshop_time_refresh", (pg.TimeMgr.GetInstance():DescCDTime(var_46_2 - var_47_0))))

			if var_47_0 > var_46_2 then
				arg_46_0:DoUpdateShowingShop()
			end
		end

		if var_46_2 == 0 and var_46_3 and var_47_0 > var_46_5 then
			arg_46_0:DoUpdateShowingShop()
		end

		return
	end, 1, -1)

	arg_46_0.timer:Start()

	if var_46_3 then
		onButton(arg_46_0, arg_46_1:Find("remainAndRefresh/refresh/refreshBtn/button"), function()
			if arg_46_0.showingShop.refreshCount < arg_46_0.showingShop:GetMaxRefreshCount() then
				local var_48_0 = var_46_3[3]

				if arg_46_0.showingShop:GetFirstRefreshFree() and arg_46_0.showingShop.refreshCount == 0 then
					var_46_3[3] = 0
					var_48_0 = 0
				end

				pg.MsgboxMgr.GetInstance():ShowMsgBox({
					yesText = "text_confirm",
					hideNo = false,
					noText = "text_cancel",
					content = i18n("refresh_shopStreet_question", i18n("word_" .. id2res(var_46_3[2]) .. "_icon"), var_48_0, arg_46_0.showingShop.refreshCount),
					onYes = function()
						arg_46_0:emit(IslandMediator.REFRESH_SHOP_BY_PLAYER, arg_46_0.showingShop.id, var_46_3)

						return
					end
				})
			else
				pg.TipsMgr.GetInstance():ShowTips(i18n("island_3Dshop_refresh_limit"))
			end

			return
		end, SFX_PANEL)
	end

	return
end

function var_0_0.IsCommodityInShoppingCart(arg_50_0, arg_50_1)
	for iter_50_0, iter_50_1 in ipairs(arg_50_0.shoppingCartCommodities) do
		if iter_50_1.id == arg_50_1.id then
			return true
		end
	end

	return false
end

function var_0_0.IsCommodityDisabled(arg_51_0, arg_51_1)
	return isActive(arg_51_1:Find("sellOut")) or isActive(arg_51_1:Find("hold")) or isActive(arg_51_1:Find("notInTime"))
end

function var_0_0.OpenShoppingCart(arg_52_0)
	arg_52_0.myIslandShoppingCartLayer = arg_52_0:OpenPage(IslandShoppingCartLayer, arg_52_0.shoppingCartCommodities)

	return
end

function var_0_0.RefreshShopSkinCartButtons(arg_53_0)
	setActive(arg_53_0.shopSkinPage:Find("cancelBtn"), #arg_53_0.shoppingCartCommodities > 0)
	setActive(arg_53_0.shopSkinPage:Find("shoppingCartBtn"), #arg_53_0.shoppingCartCommodities > 0)
	setActive(arg_53_0.shopSkinPage:Find("shoppingCartBtn/count"), arg_53_0.showingShop:GetCommanderOrCharaType() == 1)

	return
end

function var_0_0.ResetShopSkinCartPreview(arg_54_0)
	local var_54_0 = arg_54_0.shoppingCartCommodities and arg_54_0.shoppingCartCommodities[1]

	arg_54_0.shoppingCartCommodities = {}
	arg_54_0.showingCommodity = nil

	if var_54_0 and arg_54_0:IsCommanderDressCommodity(var_54_0) then
		arg_54_0:ResetCommanderDressPreview(true)
	else
		arg_54_0:ResetCommanderDressPreview(false)
		arg_54_0.islandShipDressHelper:ResetDressUp()
	end

	return
end

function var_0_0.BindShopSkinCartButtons(arg_55_0, arg_55_1)
	if #arg_55_0.shoppingCartCommodities <= 0 then
		return
	end

	onButton(arg_55_0, arg_55_0.shopSkinPage:Find("cancelBtn"), function()
		if arg_55_1 then
			arg_55_1()
		else
			arg_55_0:ResetShopSkinCartPreview()
		end

		setActive(arg_55_0.shopSkinPage:Find("cancelBtn"), false)
		setActive(arg_55_0.shopSkinPage:Find("shoppingCartBtn"), false)
		setText(arg_55_0.shopSkinPage:Find("shoppingCartBtn/count"), "0/3")
		arg_55_0:SetCommodityList()

		return
	end, SFX_PANEL)
	onButton(arg_55_0, arg_55_0.shopSkinPage:Find("shoppingCartBtn"), function()
		arg_55_0:OpenShoppingCart()

		return
	end, SFX_PANEL)

	return
end

function var_0_0.IsDressCommodityExclusive(arg_58_0, arg_58_1)
	local var_58_0 = arg_58_0.characterAgency:GetShipById(arg_58_0.showingShipId)
	local var_58_1 = var_58_0:GetCurrentSkinId()
	local var_58_2 = pg.island_dress_template[arg_58_1:GetItems()[1][2]]

	if var_58_1 ~= 0 then
		if var_58_2.exclusive_skin ~= "" then
			for iter_58_0, iter_58_1 in ipairs(var_58_2.exclusive_skin) do
				if iter_58_1 == var_58_1 then
					return true, var_58_2
				end
			end
		end
	else
		local var_58_3 = var_58_2.exclusive_default_skin

		if var_58_2.exclusive_default_skin ~= "" then
			for iter_58_2, iter_58_3 in ipairs(var_58_3) do
				if iter_58_3 == var_58_0.id then
					return true, var_58_2
				end
			end
		end
	end

	return false, var_58_2
end

function var_0_0.IsCommanderDressCommodity(arg_59_0, arg_59_1)
	local var_59_0 = arg_59_1:GetItems()

	if #var_59_0 == 0 or var_59_0[1][1] ~= DROP_TYPE_ISLAND_DRESS then
		return false
	end

	local var_59_1 = pg.island_dress_template[var_59_0[1][2]]

	return pg.island_dress_template[var_59_0[1][2]] and var_59_1.belongto == 1
end

function var_0_0.CacheCommanderDressPreviewData(arg_60_0)
	if arg_60_0.commanderDressPreviewData then
		return
	end

	local var_60_0 = getProxy(IslandProxy):GetIsland():GetDressUpAgency()

	arg_60_0.commanderDressPreviewData = {}

	for iter_60_0, iter_60_1 in pairs(IslandShipDressHelperNew.CommanderCustom) do
		local var_60_1 = var_60_0:GetDressByType(iter_60_1) or 0

		arg_60_0.commanderDressPreviewData[iter_60_1] = {
			id = var_60_1,
			colorId = var_60_0:GetCurrentColorByDressId(var_60_1)
		}
	end

	return
end

function var_0_0.RestoreCommanderDressPreview(arg_61_0)
	if not arg_61_0.commanderDressPreviewData then
		return
	end

	local var_61_0 = arg_61_0.commanderDressPreviewData

	for iter_61_0, iter_61_1 in ipairs(IslandShipDressHelperNew.CommanderCustom) do
		if var_61_0[iter_61_1] then
			arg_61_0.islandShipDressHelper:ChangeDressByType(iter_61_1, var_61_0[iter_61_1])
		end
	end

	arg_61_0.commanderDressPreviewData = nil

	return
end

function var_0_0.ResetCommanderDressPreview(arg_62_0, arg_62_1, arg_62_2)
	if arg_62_1 then
		arg_62_0:RestoreCommanderDressPreview()
	else
		arg_62_0.commanderDressPreviewData = nil

		if arg_62_2 then
			arg_62_0.islandShipDressHelper:InvalidateRole()
		end
	end

	arg_62_0:SetMorphBlock(false)
	setActive(arg_62_0.morphBtn, false)

	return
end

function var_0_0.ChangeDressByCommodityItems(arg_63_0, arg_63_1)
	for iter_63_0, iter_63_1 in ipairs(arg_63_1:GetItems()) do
		local var_63_0

		if iter_63_1[1] == DROP_TYPE_ISLAND_DRESS then
			if pg.island_dress_template[iter_63_1[2]] then
				var_63_0 = pg.island_dress_template[iter_63_1[2]].type
			end
		end

		arg_63_0.islandShipDressHelper:ChangeDressByType(var_63_0, {
			colorId = 0,
			id = iter_63_1[2]
		})
	end

	return
end

function var_0_0.ToggleDressSuitCommodity(arg_64_0, arg_64_1)
	arg_64_0:ResetCommanderDressPreview(false)

	arg_64_0.showingCommodity = nil

	local var_64_0

	if #arg_64_0.shoppingCartCommodities == 1 and arg_64_0.shoppingCartCommodities[1].id == arg_64_1.id then
		arg_64_0.shoppingCartCommodities = {}

		arg_64_0.islandShipDressHelper:ResetDressUp()
	else
		arg_64_0.shoppingCartCommodities = {
			arg_64_1
		}

		arg_64_0:ChangeDressByCommodityItems(arg_64_1)

		var_64_0 = #arg_64_0.shoppingCartCommodities > 0 and #arg_64_1:GetDisplayItems() or 0
	end

	setText(arg_64_0.shopSkinPage:Find("shoppingCartBtn/count"), var_64_0 .. "/3")

	return
end

function var_0_0.ChangeCommanderDressByCommodity(arg_65_0, arg_65_1)
	arg_65_0:CacheCommanderDressPreviewData()

	for iter_65_0, iter_65_1 in ipairs(arg_65_1:GetDisplayItems()) do
		if iter_65_1[1] == DROP_TYPE_ISLAND_DRESS then
			if pg.island_dress_template[iter_65_1[2]] then
				local var_65_0 = iter_65_1[2]

				if pg.island_dress_template[iter_65_1[2]].type == IslandShipDressHelperNew.DressType.Body then
					local var_65_1 = getProxy(IslandProxy):GetIsland():GetDressUpAgency():GetTwinCurId(var_65_0)

					if var_65_1 and var_65_1 ~= 0 then
						var_65_0 = var_65_1
					end
				end

				arg_65_0.islandShipDressHelper:ChangeDressByType(pg.island_dress_template[iter_65_1[2]].type, {
					colorId = 0,
					id = var_65_0
				})
				arg_65_0:CheckCommanderHatState(pg.island_dress_template[iter_65_1[2]].type, var_65_0)
				arg_65_0:CheckCommanderMorphBtn(pg.island_dress_template[iter_65_1[2]].type, var_65_0)
			end
		end
	end

	return
end

function var_0_0.CheckCommanderHatState(arg_66_0, arg_66_1, arg_66_2)
	if arg_66_1 ~= IslandShipDressHelperNew.DressType.Body then
		return
	end

	local var_66_0 = pg.island_dress_template.get_id_list_by_related_dress[arg_66_2] or {}
	local var_66_1 = var_66_0[1]

	if not var_66_0[1] or var_66_1 == 0 then
		arg_66_0.islandShipDressHelper:ChangeDressByType(IslandShipDressHelperNew.DressType.Hat, {
			id = 0,
			colorId = 0
		})
	elseif var_66_1 and var_66_1 ~= 0 then
		arg_66_0.islandShipDressHelper:ChangeDressByType(IslandShipDressHelperNew.DressType.Hat, {
			colorId = 0,
			id = var_66_1
		})
	end

	return
end

function var_0_0.CheckCommanderMorphBtn(arg_67_0, arg_67_1, arg_67_2)
	local var_67_0

	if arg_67_1 ~= IslandShipDressHelperNew.DressType.Body then
		do return end

		var_67_0 = 0
	end

	local var_67_1 = pg.island_dress_template[arg_67_2].cloth_related

	if pg.island_dress_template[arg_67_2].cloth_related and var_67_1 ~= 0 then
		var_67_0 = var_67_1
	end

	if var_67_0 == 0 then
		setActive(arg_67_0.morphBtn, false)

		return
	end

	setActive(arg_67_0.morphBtn, true)
	onButton(arg_67_0, arg_67_0.morphBtn, function()
		arg_67_0:DoMorphSwitch(var_0, var_67_0)

		return
	end)

	return
end

function var_0_0.DoMorphSwitch(arg_69_0, arg_69_1, arg_69_2)
	if arg_69_0.morphing then
		return
	end

	arg_69_0:SetMorphBlock(true)

	if not arg_69_0.islandShipDressHelper then
		arg_69_0:DoSwitch(arg_69_2, function()
			arg_69_0:SetMorphBlock(false)

			return
		end)

		return
	end

	arg_69_0.islandShipDressHelper:DoMorphSwitch(arg_69_1, arg_69_2, function()
		arg_69_0:DoSwitch(arg_69_2, function()
			arg_69_0:SetMorphBlock(false)

			return
		end)

		return
	end)

	return
end

function var_0_0.DoSwitch(arg_73_0, arg_73_1, arg_73_2)
	arg_73_0.islandShipDressHelper:ChangeDressByType(IslandShipDressHelperNew.DressType.Body, {
		colorId = 0,
		id = arg_73_1
	}, arg_73_2)
	arg_73_0:CheckCommanderHatState(IslandShipDressHelperNew.DressType.Body, arg_73_1)
	arg_73_0:CheckCommanderMorphBtn(IslandShipDressHelperNew.DressType.Body, arg_73_1)

	return
end

function var_0_0.SetMorphBlock(arg_74_0, arg_74_1)
	arg_74_0.morphing = arg_74_1

	setActive(arg_74_0.morphBlocker, arg_74_1)

	return
end

function var_0_0.ToggleCommanderDressCommodity(arg_75_0, arg_75_1)
	local var_75_0

	if #arg_75_0.shoppingCartCommodities == 1 and arg_75_0.shoppingCartCommodities[1].id == arg_75_1.id then
		arg_75_0.shoppingCartCommodities = {}

		arg_75_0:ResetCommanderDressPreview(true)
	else
		arg_75_0.shoppingCartCommodities = {
			arg_75_1
		}

		arg_75_0:ChangeCommanderDressByCommodity(arg_75_1)

		var_75_0 = #arg_75_0.shoppingCartCommodities > 0 and #arg_75_1:GetDisplayItems() or 0
	end

	setText(arg_75_0.shopSkinPage:Find("shoppingCartBtn/count"), var_75_0 .. "/3")

	return
end

function var_0_0.RemoveSameDressTypeCommodity(arg_76_0, arg_76_1)
	local var_76_0 = 0

	for iter_76_0, iter_76_1 in ipairs(arg_76_0.shoppingCartCommodities) do
		if iter_76_1:GetDressType() == arg_76_1:GetDressType() then
			var_76_0 = iter_76_1.id

			table.remove(arg_76_0.shoppingCartCommodities, iter_76_0)

			break
		end
	end

	return var_76_0
end

function var_0_0.ToggleSingleDressCommodity(arg_77_0, arg_77_1)
	local var_77_0, var_77_1 = arg_77_0:IsDressCommodityExclusive(arg_77_1)

	if var_77_0 then
		pg.TipsMgr.GetInstance():ShowTips(i18n("island_dress_mutually_exclusive1", var_77_1.name))

		return false
	end

	arg_77_0:ResetCommanderDressPreview(false)

	arg_77_0.showingCommodity = nil

	if #arg_77_0.shoppingCartCommodities > 0 and #arg_77_0.shoppingCartCommodities[1]:GetItems() > 1 then
		arg_77_0.shoppingCartCommodities = {}

		arg_77_0.islandShipDressHelper:ResetDressUp()
	end

	if arg_77_1.id == arg_77_0:RemoveSameDressTypeCommodity(arg_77_1) then
		arg_77_0.islandShipDressHelper:ChangeDressByType(arg_77_1:GetDressType(), {
			id = 0,
			colorId = 0
		})
	else
		table.insert(arg_77_0.shoppingCartCommodities, arg_77_1)
		arg_77_0.islandShipDressHelper:ChangeDressByType(arg_77_1:GetDressType(), {
			colorId = 0,
			id = arg_77_1:GetItems()[1][2]
		})
	end

	setText(arg_77_0.shopSkinPage:Find("shoppingCartBtn/count"), #arg_77_0.shoppingCartCommodities .. "/3")

	return true
end

function var_0_0.HandleDressCommodity(arg_78_0, arg_78_1)
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

function var_0_0.HandleFurnitureCommodity(arg_79_0, arg_79_1)
	arg_79_0:ResetCommanderDressPreview(false, true)

	if arg_79_0.showingCommodity ~= arg_79_1 then
		arg_79_0.showingCommodity = arg_79_1
		arg_79_0.shoppingCartCommodities = {
			arg_79_1
		}

		arg_79_0:LoadFurniture(arg_79_1:GetModel(), arg_79_1:GetModelParam())
		setActive(arg_79_0.shopFurniturePage:Find("scenePreviewBtn"), false)
		setActive(arg_79_0.shopFurniturePage:Find("shoppingCartBtn"), true)

		if #arg_79_1:GetItems() == 1 then
			onButton(arg_79_0, arg_79_0.shopFurniturePage:Find("scenePreviewBtn"), function()
				setActive(arg_79_0._tf, false)
				arg_79_0:ClearCharacterScene()
				arg_79_0:emit(IslandMediator.PREVIEW_FURNITURE, arg_79_1:GetItems()[1][2])

				return
			end, SFX_PANEL)
		end

		onButton(arg_79_0, arg_79_0.shopFurniturePage:Find("shoppingCartBtn"), function()
			arg_79_0:OpenShoppingCart()

			return
		end, SFX_PANEL)
	else
		arg_79_0.showingCommodity = nil
		arg_79_0.shoppingCartCommodities = {}

		arg_79_0:UnloadCharacter()
		setActive(arg_79_0.shopFurniturePage:Find("scenePreviewBtn"), false)
		setActive(arg_79_0.shopFurniturePage:Find("shoppingCartBtn"), false)
	end

	arg_79_0:SetCommodityList()

	return
end

function var_0_0.HandleSkinCommodity(arg_82_0, arg_82_1)
	arg_82_0:ResetCommanderDressPreview(false, true)

	if arg_82_0.showingCommodity ~= arg_82_1 then
		arg_82_0.showingCommodity = arg_82_1
		arg_82_0.shoppingCartCommodities = {
			arg_82_1
		}

		arg_82_0:LoadCharacter(pg.island_unit_character[pg.island_skin_template[arg_82_1:GetItems()[1][2]].model], false)
	else
		arg_82_0.showingCommodity = nil
		arg_82_0.shoppingCartCommodities = {}

		arg_82_0:UnloadCharacter()
	end

	setActive(arg_82_0.shopSkinPage:Find("cancelBtn"), false)
	setActive(arg_82_0.shopSkinPage:Find("shoppingCartBtn"), #arg_82_0.shoppingCartCommodities > 0)
	setActive(arg_82_0.shopSkinPage:Find("shoppingCartBtn/count"), false)
	setText(arg_82_0.shopSkinPage:Find("shoppingCartBtn/count"), #arg_82_0.shoppingCartCommodities .. "/3")
	arg_82_0:BindShopSkinCartButtons(function()
		arg_82_0.shoppingCartCommodities = {}

		arg_82_0:LoadCharacter(arg_82_0.characterAgency:GetShipById(arg_82_0.showingShipId):GetModel(), false)

		return
	end)
	arg_82_0:SetCommodityList()

	return
end

function var_0_0.SetCommodity(arg_84_0, arg_84_1, arg_84_2)
	var_0_0.StaticUpdateCommodityTpl(arg_84_1, arg_84_2)
	setActive(arg_84_1:Find("notInTime"), not arg_84_0.showingShop:IsInTime())
	setActive(arg_84_1:Find("select"), arg_84_0:IsCommodityInShoppingCart(arg_84_2))

	if arg_84_0:IsCommodityDisabled(arg_84_1) then
		removeOnButton(arg_84_1)
	else
		onButton(arg_84_0, arg_84_1, function()
			switch(arg_84_2:GetCommodityShowType(), {
				[IslandConst.COMMODITY_SHOW_ITEM] = function()
					arg_84_0.myIslandShopItemLayer = arg_84_0:OpenPage(IslandShopItemLayer, arg_84_0.showingShop.id, arg_84_2)

					return
				end,
				[IslandConst.COMMODITY_SHOW_DRESS] = function()
					arg_84_0:HandleDressCommodity(arg_84_2)

					return
				end,
				[IslandConst.COMMODITY_SHOW_FURNITURE] = function()
					arg_84_0:HandleFurnitureCommodity(arg_84_2)

					return
				end,
				[IslandConst.COMMODITY_SHOW_SKIN] = function()
					arg_84_0:HandleSkinCommodity(arg_84_2)

					return
				end,
				[IslandConst.COMMODITY_SHOW_INVITE] = function()
					arg_84_0.myIslandShopItemLayer = arg_84_0:OpenPage(IslandShopItemLayer, arg_84_0.showingShop.id, arg_84_2, arg_84_2:GetItems()[1][2])

					return
				end
			})

			return
		end, SFX_PANEL)
	end

	return
end

function var_0_0.SetCommodityList(arg_91_0)
	local var_91_0 = switch(arg_91_0.showingShop:GetShowType(), {
		[IslandConst.SHOP_TYPE_2D] = function()
			return UIItemList.New(arg_91_0.shop2DPage:Find("shopView/Viewport/Content"), arg_91_0.shop2DPage:Find("shopView/Viewport/Content/IslandCommodityTpl"))
		end,
		[IslandConst.SHOP_TYPE_3D] = function()
			return UIItemList.New(arg_91_0.shop3DPage:Find("shopView/Viewport/Content"), arg_91_0.shop3DPage:Find("shopView/Viewport/Content/IslandCommodityTpl"))
		end,
		[IslandConst.SHOP_TYPE_FURNITURE] = function()
			return UIItemList.New(arg_91_0.shopFurniturePage:Find("shopView/Viewport/Content"), arg_91_0.shopFurniturePage:Find("shopView/Viewport/Content/IslandCommodityTpl"))
		end,
		[IslandConst.SHOP_TYPE_SKIN] = function()
			return UIItemList.New(arg_91_0.shopSkinPage:Find("shopView/Viewport/Content"), arg_91_0.shopSkinPage:Find("shopView/Viewport/Content/IslandCommodityTpl"))
		end
	})
	local var_91_1 = arg_91_0.showingShop:GetCommodities()

	var_0_0.SortShopCommodities(var_91_1)
	var_91_0:make(function(arg_96_0, arg_96_1, arg_96_2)
		if arg_96_0 == UIItemList.EventUpdate then
			arg_91_0:SetCommodity(arg_96_2, var_91_1[arg_96_1 + 1])
		end

		return
	end, SFX_PANEL)
	var_91_0:align(#var_91_1)

	return
end

function var_0_0.ShowRecommendation5(arg_97_0)
	arg_97_0:ClearCharacterScene()
	arg_97_0:OverlayPanel(arg_97_0._tf, {
		pbList = {
			arg_97_0.bg
		}
	})
	setActive(arg_97_0.bgColor, true)

	arg_97_0.shoppingCartCommodities = {}
	arg_97_0.showingCommodity = nil

	arg_97_0:ResetCommanderDressPreview(false)

	local var_97_0 = arg_97_0.showingShop:GetBanners()
	local var_97_1 = arg_97_0.recommendationPage5:Find("banners")

	for iter_97_0 = 1, #var_97_0 do
		local var_97_2 = var_97_0[iter_97_0]
		local var_97_3 = var_97_1:Find("banner" .. var_97_0[iter_97_0].id)

		if var_97_3 then
			GetImageSpriteFromAtlasAsync("activitybanner/" .. var_97_0[iter_97_0].pic, "", var_97_3)
			onButton(arg_97_0, var_97_3, function()
				arg_97_0:JumpToRecommendationShop(var_97_2.param)

				return
			end, SFX_PANEL)
		end
	end

	return
end

function var_0_0.ShowRecommendation1(arg_99_0)
	arg_99_0:ClearCharacterScene()
	arg_99_0:OverlayPanel(arg_99_0._tf, {
		pbList = {
			arg_99_0.bg
		}
	})
	setActive(arg_99_0.bgColor, true)

	arg_99_0.shoppingCartCommodities = {}
	arg_99_0.showingCommodity = nil

	arg_99_0:ResetCommanderDressPreview(false)

	local var_99_0 = arg_99_0.showingShop:GetBanners()
	local var_99_1 = arg_99_0.recommendationPage1:Find("banners")

	for iter_99_0 = 1, #var_99_0 do
		local var_99_2 = var_99_0[iter_99_0]
		local var_99_3 = var_99_1:Find("banner" .. var_99_0[iter_99_0].id)

		if var_99_3 then
			GetImageSpriteFromAtlasAsync("activitybanner/" .. var_99_0[iter_99_0].pic, "", var_99_3)
			onButton(arg_99_0, var_99_3, function()
				arg_99_0:JumpToRecommendationShop(var_99_2.param)

				return
			end, SFX_PANEL)
		end
	end

	return
end

function var_0_0.ShowShop2D(arg_101_0)
	arg_101_0:ClearCharacterScene()
	arg_101_0:OverlayPanel(arg_101_0._tf, {
		pbList = {
			arg_101_0.bg
		}
	})
	setActive(arg_101_0.bgColor, true)

	arg_101_0.shoppingCartCommodities = {}
	arg_101_0.showingCommodity = nil

	arg_101_0:ResetCommanderDressPreview(false)

	local var_101_0 = arg_101_0.showingShop:IsInTime()

	setActive(arg_101_0.shop2DPage:Find("lock"), not var_101_0)

	if var_101_0 then
		arg_101_0:SetCloseAndRefresh(arg_101_0.shop2DPage)
	else
		setActive(arg_101_0.shop2DPage:Find("remainAndRefresh"), false)

		if arg_101_0.timer then
			arg_101_0.timer:Stop()

			arg_101_0.timer = nil
		end

		arg_101_0.timer = Timer.New(function()
			local var_102_9000
			local var_102_0 = arg_101_0.showingShop:GetExistTime()[1]

			setText(arg_101_0.shop2DPage:Find("lock/openTimer"), i18n("island_3Dshop_time_unlock", (pg.TimeMgr.GetInstance():DescCDTime(pg.TimeMgr.GetInstance().Table2ServerTime(var_102_9000, {
				year = var_102_0[1][1],
				month = var_102_0[1][2],
				day = var_102_0[1][3],
				hour = var_102_0[2][1],
				min = var_102_0[2][2],
				sec = var_102_0[2][3]
			}) - pg.TimeMgr.GetInstance():GetServerTime()))))

			return
		end, 1, -1)

		arg_101_0.timer:Start()
	end

	arg_101_0:SetCommodityList()

	return
end

function var_0_0.ShowShop3D(arg_103_0)
	arg_103_0:ClearCharacterScene()
	arg_103_0:OverlayPanel(arg_103_0._tf, {
		pbList = {
			arg_103_0.shop3DPage:Find("bg")
		}
	})
	setActive(arg_103_0.bgColor, false)

	arg_103_0.shoppingCartCommodities = {}
	arg_103_0.showingCommodity = nil

	arg_103_0:ResetCommanderDressPreview(false)
	arg_103_0:SetCloseAndRefresh(arg_103_0.shop3DPage)
	arg_103_0:SetCommodityList()

	return
end

function var_0_0.ShowShopFurniture(arg_104_0)
	if not arg_104_0.isLoadCharacterScene then
		arg_104_0:PrepareCharacterScene()
	end

	arg_104_0:OverlayPanel(arg_104_0._tf, {
		pbList = {
			arg_104_0.shopFurniturePage:Find("bg")
		}
	})
	setActive(arg_104_0.bgColor, false)
	arg_104_0:UnloadCharacter()

	arg_104_0.shoppingCartCommodities = {}
	arg_104_0.showingCommodity = nil

	arg_104_0:ResetCommanderDressPreview(false)
	arg_104_0:SetCloseAndRefresh(arg_104_0.shopFurniturePage)
	arg_104_0:SetCommodityList()
	setActive(arg_104_0.shopFurniturePage:Find("scenePreviewBtn"), false)
	setActive(arg_104_0.shopFurniturePage:Find("shoppingCartBtn"), false)

	return
end

function var_0_0.ShowShopSkin(arg_105_0)
	if not arg_105_0.isLoadCharacterScene then
		arg_105_0:PrepareCharacterScene()
	end

	arg_105_0:OverlayPanel(arg_105_0._tf, {
		pbList = {
			arg_105_0.shopSkinPage:Find("bg"),
			arg_105_0.changeCharaPanel
		}
	})
	setActive(arg_105_0.bgColor, false)

	arg_105_0.shoppingCartCommodities = arg_105_0.shoppingCartCommodities or {}

	if #arg_105_0.shoppingCartCommodities > 0 then
		local var_105_0 = arg_105_0.shoppingCartCommodities[1]:GetCommodityShowType()

		if var_105_0 == IslandConst.COMMODITY_SHOW_FURNITURE or var_105_0 == IslandConst.COMMODITY_SHOW_SKIN then
			arg_105_0.shoppingCartCommodities = {}
			arg_105_0.showingCommodity = nil

			arg_105_0:ResetCommanderDressPreview(false, true)
		end
	end

	local var_105_1 = arg_105_0.showingShop:GetCommanderOrCharaType()

	if var_105_1 == 0 and (arg_105_0.showingShipId ~= 0 or #arg_105_0.shoppingCartCommodities == 0) then
		arg_105_0.showingShipId = 0

		arg_105_0:LoadCharacter({
			model = pg.island_unit_character[0].model,
			animator = pg.island_unit_character[0].animator
		}, true)

		arg_105_0.shoppingCartCommodities = {}
		arg_105_0.showingCommodity = nil

		arg_105_0:ResetCommanderDressPreview(false)
	elseif var_105_1 == 1 and (arg_105_0.showingShipId ~= arg_105_0.selectShipId or #arg_105_0.shoppingCartCommodities == 0) then
		arg_105_0:ResetCommanderDressPreview(false, true)

		arg_105_0.showingShipId = arg_105_0.selectShipId

		arg_105_0:LoadCharacter(arg_105_0.characterAgency:GetShipById(arg_105_0.showingShipId):GetModel(), false)

		arg_105_0.shoppingCartCommodities = {}
		arg_105_0.showingCommodity = nil

		arg_105_0:ResetCommanderDressPreview(false)
	elseif var_105_1 == 2 then
		arg_105_0:ResetCommanderDressPreview(false, true)

		arg_105_0.showingShipId = arg_105_0.selectShipId

		arg_105_0:UnloadCharacter()

		arg_105_0.shoppingCartCommodities = {}
		arg_105_0.showingCommodity = nil

		arg_105_0:ResetCommanderDressPreview(false)
	end

	arg_105_0:SetCloseAndRefresh(arg_105_0.shopSkinPage)
	arg_105_0:SetCommodityList()
	setActive(arg_105_0.shopSkinPage:Find("cancelBtn"), #arg_105_0.shoppingCartCommodities > 0)
	setActive(arg_105_0.shopSkinPage:Find("changeCharaBtn"), var_105_1 == 1)
	setActive(arg_105_0.shopSkinPage:Find("shoppingCartBtn"), #arg_105_0.shoppingCartCommodities > 0)
	setActive(arg_105_0.shopSkinPage:Find("shoppingCartBtn/count"), #arg_105_0.shoppingCartCommodities > 0 and var_105_1 == 1)
	setText(arg_105_0.shopSkinPage:Find("shoppingCartBtn/count"), #arg_105_0.shoppingCartCommodities .. "/3")
	setActive(arg_105_0.shopSkinPage:Find("changeCharaPanel"), false)
	arg_105_0:SetChangeCharaPanel()
	onButton(arg_105_0, arg_105_0.shopSkinPage:Find("changeCharaBtn"), function()
		setActive(arg_105_0.shopSkinPage:Find("changeCharaPanel"), true)

		return
	end, SFX_PANEL)

	return
end

function var_0_0.SetChangeCharaPanel(arg_107_0)
	onButton(arg_107_0, arg_107_0.shopSkinPage:Find("changeCharaPanel/bg"), function()
		setActive(arg_107_0.shopSkinPage:Find("changeCharaPanel"), false)

		return
	end, SFX_PANEL)
	onButton(arg_107_0, arg_107_0.changeCharaPanel:Find("closeBtn"), function()
		setActive(arg_107_0.shopSkinPage:Find("changeCharaPanel"), false)

		return
	end, SFX_PANEL)

	local var_107_0 = UIItemList.New(arg_107_0.changeCharaPanel:Find("charaScroll/Viewport/Content"), arg_107_0.changeCharaPanel:Find("charaScroll/Viewport/Content/IslandShipTpl"))

	var_107_0:make(function(arg_110_0, arg_110_1, arg_110_2)
		if arg_110_0 == UIItemList.EventUpdate then
			local var_110_0 = arg_107_0.ships[arg_110_1 + 1]

			GetImageSpriteFromAtlasAsync("ShipYardIcon/" .. IslandShip.StaticGetPrefab(arg_107_0.ships[arg_110_1 + 1].id), "", arg_110_2:Find("mask/icon"))
			setText(arg_110_2:Find("Text"), "Lv." .. var_110_0:GetLevel())
			setActive(arg_110_2:Find("add"), false)
			setActive(arg_110_2:Find("select"), var_110_0.id == arg_107_0.selectShipId)
			onButton(arg_107_0, arg_110_2, function()
				if arg_107_0.charaSetModel == var_0_0.CharaSetModel.current then
					arg_107_0:ResetCommanderDressPreview(false, true)

					arg_107_0.selectShipId = var_110_0.id
					arg_107_0.showingShipId = var_110_0.id

					arg_107_0:LoadCharacter(var_110_0:GetModel(), false)

					arg_107_0.shoppingCartCommodities = {}
					arg_107_0.showingCommodity = nil

					setActive(arg_107_0.shopSkinPage:Find("cancelBtn"), false)
					setActive(arg_107_0.shopSkinPage:Find("shoppingCartBtn"), false)
					setText(arg_107_0.shopSkinPage:Find("shoppingCartBtn/count"), "0/3")
					arg_107_0:SetCommodityList()
				elseif arg_107_0.charaSetModel == var_0_0.CharaSetModel.default then
					arg_107_0.defaultShipId = var_110_0.id

					PlayerPrefs.SetInt("island_dressShop_defaultShipId_" .. arg_107_0.player.id, var_110_0.id)
				end

				for iter_111_0 = 0, arg_107_0.changeCharaPanel:Find("charaScroll/Viewport/Content").childCount - 1 do
					local var_111_0 = arg_107_0.changeCharaPanel:Find("charaScroll/Viewport/Content"):GetChild(iter_111_0)

					setActive(var_111_0:Find("select"), iter_111_0 == arg_110_1)
				end

				return
			end, SFX_PANEL)
		end

		return
	end)
	var_107_0:align(#arg_107_0.ships)

	arg_107_0.charaSetModel = var_0_0.CharaSetModel.current

	onButton(arg_107_0, arg_107_0.changeCharaPanel:Find("defaultSet"), function()
		if arg_107_0.charaSetModel == var_0_0.CharaSetModel.current then
			arg_107_0.charaSetModel = var_0_0.CharaSetModel.default

			for iter_112_0 = 0, arg_107_0.changeCharaPanel:Find("charaScroll/Viewport/Content").childCount - 1 do
				local var_112_0 = arg_107_0.changeCharaPanel:Find("charaScroll/Viewport/Content"):GetChild(iter_112_0)

				setActive(var_112_0:Find("select"), arg_107_0.ships[iter_112_0 + 1].id == arg_107_0.defaultShipId)
			end
		elseif arg_107_0.charaSetModel == var_0_0.CharaSetModel.default then
			arg_107_0.charaSetModel = var_0_0.CharaSetModel.current

			for iter_112_1 = 0, arg_107_0.changeCharaPanel:Find("charaScroll/Viewport/Content").childCount - 1 do
				local var_112_1 = arg_107_0.changeCharaPanel:Find("charaScroll/Viewport/Content"):GetChild(iter_112_1)

				setActive(var_112_1:Find("select"), arg_107_0.ships[iter_112_1 + 1].id == arg_107_0.selectShipId)
			end
		end

		setActive(arg_107_0.changeCharaPanel:Find("defaultSet/off"), arg_107_0.charaSetModel == var_0_0.CharaSetModel.current)
		setActive(arg_107_0.changeCharaPanel:Find("defaultSet/on"), arg_107_0.charaSetModel == var_0_0.CharaSetModel.default)

		return
	end, SFX_PANEL)

	return
end

function var_0_0.AddListeners(arg_113_0)
	arg_113_0:AddListener(GAME.ISLAND_SHOP_OP_DONE, arg_113_0.UpdateView)
	arg_113_0:AddListener(ISLAND_EX_EVT.SWITCH_MAP_BY_POINT, arg_113_0.OnSwitchMapByPoint)
	arg_113_0:AddListener(ActivityProxy.ACTIVITY_UPDATED, arg_113_0.UpdateActivity)
	arg_113_0:AddListener(GAME.ACTIVITY_DRAW_AWARD_OPERATION_DONE, arg_113_0.DrawOperation)
	arg_113_0:AddListener(GAME.ISLAND_EXCHANGE_ITEM_DONE, arg_113_0.OnExchangeDone)

	return
end

function var_0_0.RemoveListeners(arg_114_0)
	arg_114_0:RemoveListener(GAME.ISLAND_SHOP_OP_DONE, arg_114_0.UpdateView)
	arg_114_0:RemoveListener(ISLAND_EX_EVT.SWITCH_MAP_BY_POINT, arg_114_0.OnSwitchMapByPoint)
	arg_114_0:RemoveListener(ActivityProxy.ACTIVITY_UPDATED, arg_114_0.UpdateActivity)
	arg_114_0:RemoveListener(GAME.ACTIVITY_DRAW_AWARD_OPERATION_DONE, arg_114_0.DrawOperation)
	arg_114_0:RemoveListener(GAME.ISLAND_EXCHANGE_ITEM_DONE, arg_114_0.OnExchangeDone)

	return
end

function var_0_0.UpdateView(arg_115_0, arg_115_1)
	if arg_115_1.operation == IslandConst.SHOP_GET_DATA then
		if arg_115_1.refreshAll then
			arg_115_0:UpdateData()
			arg_115_0:SetShopList()
		else
			arg_115_0:SetShopPage()
		end
	elseif arg_115_1.operation == IslandConst.SHOP_BUY_COMMODITY then
		arg_115_0.shoppingCartCommodities = {}

		arg_115_0:SetShopPage()

		if arg_115_0.myIslandShoppingCartLayer then
			arg_115_0.myIslandShoppingCartLayer:Hide()
		end

		arg_115_0:OpenPage(IslandShopBuySuccessLayer, arg_115_1.awards, function()
			if arg_115_0.showingShop:GetShowType() == IslandConst.SHOP_TYPE_SKIN then
				arg_115_0:ShowMsgBox({
					type = IslandMsgBox.TYPE_COMMON,
					content = i18n("island_3Dshop_clothes_jump"),
					onYes = function()
						arg_115_0:ClearCharacterScene(function()
							arg_115_0:Hide()

							local var_118_0 = arg_115_0.showingShop:GetCommanderOrCharaType()

							if var_118_0 == 0 then
								arg_115_0:OpenScenePage(IslandShipIslandCommanderMainPage)
							elseif var_118_0 == 1 or var_118_0 == 2 then
								arg_115_0:OpenScenePage(IslandShipMainPage, 3)
							end

							return
						end)

						return
					end
				})
			end

			return
		end)

		if arg_115_0.myIslandShopItemLayer then
			arg_115_0.myIslandShopItemLayer:Refresh()
		end
	elseif arg_115_1.operation == IslandConst.REFRESH_SHOP_BY_PLAYER then
		arg_115_0:SetShopPage()
	end

	return
end

function var_0_0.OnSwitchMapByPoint(arg_119_0)
	setActive(arg_119_0._tf, true)
	arg_119_0:PrepareCharacterScene()

	return
end

function var_0_0.UpdateActivity(arg_120_0, arg_120_1)
	if arg_120_1:getConfig("type") == ActivityConst.ACTIVITY_TYPE_ISLAND_DRAW_AWARD then
		arg_120_0.drawAwardActivity = arg_120_1

		arg_120_0.drawAwardPage:ActionInvoke("UpdateActivity", arg_120_0.drawAwardActivity)
		arg_120_0:SetResources()
	end

	return
end

function var_0_0.DrawOperation(arg_121_0, arg_121_1)
	arg_121_0.drawAwardPage:ActionInvoke("DrawOperation", arg_121_1)

	return
end

function var_0_0.Preload(arg_122_0, arg_122_1)
	arg_122_1()

	return
end

function var_0_0.GetSmoothRotateObject(arg_123_0)
	return arg_123_0._tf:Find("adapt/model")
end

function var_0_0.LoadFurniture(arg_124_0, arg_124_1, arg_124_2)
	arg_124_0:UnloadCharacter()

	if arg_124_0.isLoadingModel then
		return
	end

	arg_124_0.isLoadingModel = true

	local var_124_0 = arg_124_0.loadingIdList or {}

	table.insert(var_124_0, (IslandAssetLoadDispatcher.Instance:Enqueue(arg_124_1, "", typeof(GameObject), UnityEngine.Events.UnityAction_UnityEngine_Object(function(arg_125_0)
		arg_124_0.role = Object.Instantiate(arg_125_0)

		local var_125_0 = GameObject.New(arg_124_0.role.name)

		setParent(arg_124_0.role, var_125_0.transform, false)

		arg_124_0.role = var_125_0
		arg_124_0.isLoadingModel = false

		pg.ViewUtils.SetLayer(arg_124_0.role.transform, Layer.Character3D)
		setParent(arg_124_0.role, arg_124_0.roleContainer)

		arg_124_0.role.transform.localPosition = Vector3(arg_124_2[1][1], arg_124_2[1][2], 0)
		arg_124_0.role.transform.localEulerAngles = Vector3(0, arg_124_2[2], 0)
		arg_124_0.role.transform.localScale = Vector3(arg_124_2[3], arg_124_2[3], arg_124_2[3])

		local var_125_1 = GetOrAddComponent(arg_124_0:GetSmoothRotateObject(), typeof(SmoothRotateObject))

		var_125_1:SetUp(arg_124_0.role.transform)

		var_125_1.rotationSpeed = pg.island_set.character_detail_camera_speed.key_value_int

		return
	end), true, true)))

	return
end

function var_0_0.LoadCharacter(arg_126_0, arg_126_1, arg_126_2)
	arg_126_0:UnloadCharacter()

	if arg_126_0.isLoadingModel then
		return
	end

	arg_126_0.isLoadingModel = true

	arg_126_0.islandShipDressHelper:SetShipId(arg_126_0.showingShipId)

	arg_126_0.isCommander = arg_126_2
	arg_126_0.modelData = arg_126_1

	local function var_126_0(arg_127_0)
		arg_126_0.role = arg_127_0
		arg_126_0.isLoadingModel = false

		pg.ViewUtils.SetLayer(arg_126_0.role.transform, Layer.Character3D)
		setParent(arg_126_0.role, arg_126_0.roleContainer)

		local var_127_0 = 2.7

		if arg_126_0._tf.rect.width / arg_126_0._tf.rect.height < 1.7777777777777777 then
			var_127_0 = 2.7 - 0.5 * (1.7777777777777777 - arg_126_0._tf.rect.width / arg_126_0._tf.rect.height) / 0.4444444444444444
		end

		arg_126_0.role.transform.localPosition = Vector3(var_127_0, 0, 0)
		arg_126_0.role.transform.localEulerAngles = Vector3(0, -155, 0)

		local var_127_1 = GetOrAddComponent(arg_126_0:GetSmoothRotateObject(), typeof(SmoothRotateObject))

		var_127_1:SetUp(arg_126_0.role.transform)

		var_127_1.rotationSpeed = pg.island_set.character_detail_camera_speed.key_value_int

		arg_126_0.displayUnit:OnAttach(arg_127_0, arg_126_0.toolContainer)

		local var_127_2 = arg_126_0.modelData and arg_126_0.modelData.personal_ani

		if var_127_2 and var_127_2 ~= "" then
			local var_127_3 = GetOrAddComponent(arg_126_0.role.transform:GetChild(0), typeof(Animator))

			for iter_127_0 = 1, var_127_3.layerCount do
				var_127_3:CrossFadeInFixedTime(var_127_2, 0, iter_127_0 - 1)
			end
		end

		arg_126_0.islandShipDressHelper:OnRoleLoaded(arg_126_0.role.transform, arg_126_0.modelData)

		return
	end

	if arg_126_0.isCommander then
		arg_126_0:GetPoolMgr():GetCommanderModel(arg_126_1, function(arg_128_0)
			var_126_0(arg_128_0)

			return
		end)
	else
		arg_126_0:GetPoolMgr():GetCharacter(arg_126_1.model, arg_126_1.animator, function(arg_129_0)
			var_126_0(arg_129_0)

			return
		end)
	end

	return
end

function var_0_0.UnloadCharacter(arg_130_0)
	arg_130_0.islandShipDressHelper:InvalidateRole()
	arg_130_0.islandShipDressHelper:Destroy()

	if arg_130_0.role then
		arg_130_0.displayUnit:OnDetach()
		pg.ViewUtils.SetLayer(arg_130_0.role.transform, Layer.Default)

		if arg_130_0.isCommander then
			arg_130_0:GetPoolMgr():ReturnCommanderModel(arg_130_0.role)
		elseif arg_130_0.modelData then
			arg_130_0:GetPoolMgr():ReturnCharacter(arg_130_0.modelData.model, arg_130_0.modelData.animator, arg_130_0.role)

			arg_130_0.modelData = nil
		end

		arg_130_0.role = nil
	end

	arg_130_0.modelData = nil

	return
end

function var_0_0.BindExchangeTab(arg_131_0, arg_131_1, arg_131_2)
	setText(arg_131_1:Find("shop1Tg/name"), pg.island_exchange_group[arg_131_0.exchangeShowIds[arg_131_2 - arg_131_0.exchangeTabStartIdx + 1]].text[1])
	setText(arg_131_1:Find("shop1Tg/name/en"), pg.island_exchange_group[arg_131_0.exchangeShowIds[arg_131_2 - arg_131_0.exchangeTabStartIdx + 1]].text[2])
	GetImageSpriteFromAtlasAsync("island/islandshopicon", pg.island_exchange_group[arg_131_0.exchangeShowIds[arg_131_2 - arg_131_0.exchangeTabStartIdx + 1]].text[3], arg_131_1:Find("shop1Tg/selected/icon"))
	setActive(arg_131_1:Find("shop2List"), false)
	onToggle(arg_131_0, arg_131_1:Find("shop1Tg"), function(arg_132_0)
		setActive(arg_131_0.bg, not arg_132_0)
		setActive(arg_131_1:Find("shop2List"), arg_132_0)
		arg_131_0:SetResourcesVisible(not arg_132_0)

		if arg_132_0 then
			if arg_131_0.currentShop1TgIndex == arg_131_2 then
				return
			end

			arg_131_0.currentShop1TgIndex = arg_131_2

			arg_131_1:GetComponent(typeof(Animation)):Play("anim_IslandShopUI_Shop1List_Selected")
			triggerToggle(arg_131_1:Find("shop2List"):GetChild(0), true)
			setText(arg_131_0.title:Find("Text"), i18n("island_exchange_title"))
			setText(arg_131_0.title:Find("Text/en"), i18n("island_exchange_title_en"))
			arg_131_0:SetShopPageVisible(false)
			setActive(arg_131_0.shop3, false)
			setActive(arg_131_0.shop32, false)
			arg_131_0.exchangSubView:ExecuteAction("Show")
		else
			arg_131_0.exchangSubView:ExecuteAction("Hide")
		end

		return
	end, SFX_PANEL)
	UIItemList.StaticAlign(arg_131_1:Find("shop2List"), arg_131_1:Find("shop2List/shop2Tpl"), #pg.island_exchange_group[arg_131_0.exchangeShowIds[arg_131_2 - arg_131_0.exchangeTabStartIdx + 1]].exchange_group, function(arg_133_0, arg_133_1, arg_133_2)
		if arg_133_0 == UIItemList.EventUpdate then
			local var_133_0 = var_0[arg_133_1 + 1][2]

			setText(arg_133_2:Find("name"), var_0[arg_133_1 + 1][1])
			setText(arg_133_2:Find("selected/name"), var_0[arg_133_1 + 1][1])
			onToggle(arg_131_0, arg_133_2, function(arg_134_0)
				if arg_134_0 then
					arg_133_2:GetComponent(typeof(Animation)):Play("anim_IslandShopUI_Shop2List_Selected")
					arg_131_0.exchangSubView:ExecuteAction("FlushGroup", var_133_0)
				end

				return
			end, SFX_PANEL)
		end

		return
	end)

	return
end

function var_0_0.OnExchangeDone(arg_135_0)
	arg_135_0.exchangSubView:ExecuteAction("FlushGroup")

	return
end

function var_0_0.OnShow(arg_136_0, arg_136_1, arg_136_2, arg_136_3)
	arg_136_0:OverlayPanel(arg_136_0._tf)

	arg_136_0.showTypes = arg_136_1
	arg_136_0.firstShopIds = arg_136_2
	arg_136_0.showDrawAward = arg_136_3 == 1
	arg_136_0.drawAwardActivity = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_ISLAND_DRAW_AWARD)

	arg_136_0:DoUpdateShops()
	arg_136_0:UpdateData()
	arg_136_0:SetShopList()

	return
end

function var_0_0.OnHide(arg_137_0)
	arg_137_0:UnOverlayPanel(arg_137_0._tf)

	if arg_137_0.timer then
		arg_137_0.timer:Stop()

		arg_137_0.timer = nil
	end

	arg_137_0:ResetCommanderDressPreview(false)

	arg_137_0.shoppingCartCommodities = {}
	arg_137_0.showingCommodity = nil

	arg_137_0.islandShipDressHelper:Destroy()
	arg_137_0:UnloadCharacter()
	arg_137_0.drawAwardPage:Destroy()
	arg_137_0.drawAwardPage:Reset()
	arg_137_0.exchangSubView:ExecuteAction("Hide")

	local var_137_0 = arg_137_0.loadingIdList or {}

	for iter_137_0, iter_137_1 in ipairs(var_137_0) do
		IslandAssetLoadDispatcher.Instance:Cancel(iter_137_1)
	end

	arg_137_0.loadingIdList = {}

	return
end

function var_0_0.OnDisable(arg_138_0)
	arg_138_0:OnHide()
	var_0_0.super.OnDisable(arg_138_0)

	return
end

function var_0_0.OnDestroy(arg_139_0)
	arg_139_0:OnHide()

	if arg_139_0.exchangSubView then
		arg_139_0.exchangSubView:Destroy()

		arg_139_0.exchangSubView = nil
	end

	var_0_0.super.OnDestroy(arg_139_0)

	return
end

function var_0_0.CanEsc(arg_140_0)
	if arg_140_0.morphing then
		return false
	end

	return true
end

function var_0_0.StaticUpdateCommodityTpl(arg_141_0, arg_141_1)
	local var_141_0 = arg_141_1:GetMaxNum() - arg_141_1.purchasedNum

	setText(arg_141_0:Find("name"), arg_141_1:GetName())

	if #arg_141_1:GetItems() == 1 and arg_141_1:GetItems()[1][1] ~= DROP_TYPE_ISLAND_FURNITURE and arg_141_1:GetItems()[1][1] ~= DROP_TYPE_ISLAND_DRESS and arg_141_1:GetItems()[1][1] ~= DROP_TYPE_ISLAND_SKIN then
		local var_141_1 = arg_141_1:GetItems()[1]

		updateCustomDrop(arg_141_0:Find("IslandItemTpl"), {
			type = var_141_1[1],
			id = var_141_1[2],
			count = var_141_1[3]
		}, {
			style = "island"
		})
	else
		GetImageSpriteFromAtlasAsync(arg_141_1:GetIcon(), "", arg_141_0:Find("IslandItemTpl/icon_bg/icon"))
	end

	setActive(arg_141_0:Find("IslandItemTpl/icon_bg/count_bg"), arg_141_1:IsShowPurchaseLimit())
	setText(arg_141_0:Find("IslandItemTpl/icon_bg/count_bg/count"), var_141_0 .. "/" .. arg_141_1:GetMaxNum())

	local var_141_2 = arg_141_1:GetResourceConsume()

	GetImageSpriteFromAtlasAsync(Drop.New({
		type = var_141_2[1],
		id = var_141_2[2]
	}):getIcon(), "", arg_141_0:Find("cost/icon"))
	setText(arg_141_0:Find("cost/num"), math.ceil((100 - arg_141_1:GetDiscount()) / 100 * var_141_2[3]))

	local var_141_3 = arg_141_1:GetTag()

	setActive(arg_141_0:Find("tags/timeLimit"), var_141_3 == IslandCommodity.TAG.TIME)
	setActive(arg_141_0:Find("tags/new"), var_141_3 == IslandCommodity.TAG.NEW)
	setActive(arg_141_0:Find("tags/hot"), var_141_3 == IslandCommodity.TAG.HOT)
	setActive(arg_141_0:Find("discount"), arg_141_1:GetDiscount() ~= 0)
	setText(arg_141_0:Find("discount/Text"), "-" .. arg_141_1:GetDiscount() .. "%")
	setActive(arg_141_0:Find("have"), arg_141_1:IsShowHave())
	setText(arg_141_0:Find("have"), i18n("island_3Dshop_have") .. Drop.New({
		count = 1,
		type = arg_141_1:GetItems()[1][1],
		id = arg_141_1:GetItems()[1][2]
	}):getOwnedCount())

	local var_141_4 = arg_141_1:IsShowHold() and (arg_141_1:IsCharacterInviteItemHold() or underscore.all(arg_141_1:GetItems(), function(arg_142_0)
		local var_142_0 = Drop.New({
			count = 1,
			type = arg_142_0[1],
			id = arg_142_0[2]
		})

		return var_142_0:getOwnedCount() > 0
	end))

	setActive(arg_141_0:Find("hold"), var_141_4)
	setActive(arg_141_0:Find("sellOut"), arg_141_1:GetMaxNum() ~= 0 and var_141_0 == 0 and not isActive(arg_141_0:Find("hold")))
	setActive(arg_141_0:Find("cost"), not isActive(arg_141_0:Find("sellOut")) and not isActive(arg_141_0:Find("hold")))
	setActive(arg_141_0:Find("select"), false)
	setText(arg_141_0:Find("sellOut/Text"), i18n("common_sale_out"))
	setText(arg_141_0:Find("hold/Text"), i18n("common_already owned"))

	return
end

function var_0_0.SortShopCommodities(arg_143_0)
	table.sort(arg_143_0, CompareFuncs({
		function(arg_144_0)
			local var_144_0 = arg_144_0:GetMaxNum() - arg_144_0.purchasedNum

			if arg_144_0:GetMaxNum() ~= 0 and var_144_0 == 0 then
				return 3
			end

			if arg_144_0:IsShowHold() then
				if arg_144_0:IsCharacterInviteItemHold() then
					return 2
				else
					return underscore.all(arg_144_0:GetItems(), function(arg_145_0)
						local var_145_0 = Drop.New({
							count = 1,
							type = arg_145_0[1],
							id = arg_145_0[2]
						})

						return var_145_0:getOwnedCount() > 0
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

return var_0_0
