local IslandShopPage = class("IslandShopPage", import("..ship.IslandBaseShipDisplayPage"))
local var_0_1 = 3

IslandShopPage.CharaSetModel = {
	current = 1,
	default = 2
}

function IslandShopPage:getUIName()
	return "IslandShopUI"
end

function IslandShopPage:OnLoaded()
	self.bg = self._tf:Find("bg")
	self.bgColor = self.bg:Find("color")
	self.closeBtn = self._tf:Find("adapt/top/closeBtn")
	self.helpBtn = self._tf:Find("adapt/top/helpBtn")
	self.title = self._tf:Find("adapt/top/title")
	self.resourceList = UIItemList.New(self._tf:Find("adapt/top/resources"), self._tf:Find("adapt/top/resources/resourceTpl"))
	self.shop1List = UIItemList.New(self._tf:Find("adapt/shop1List"), self._tf:Find("adapt/shop1List/shop1Tpl"))
	self.shop3 = self._tf:Find("adapt/shop3List")
	self.shop3List = UIItemList.New(self._tf:Find("adapt/shop3List"), self._tf:Find("adapt/shop3List/shop3Tpl"))
	self.shop32 = self._tf:Find("adapt/shop3List2")
	self.shop3List2 = UIItemList.New(self._tf:Find("adapt/shop3List2"), self._tf:Find("adapt/shop3List2/shop3Tpl"))
	self.recommendationPage5 = self._tf:Find("adapt/shopPage/recommendation5")
	self.recommendationPage1 = self._tf:Find("adapt/shopPage/recommendation1")
	self.shop2DPage = self._tf:Find("adapt/shopPage/shop2D")
	self.shop3DPage = self._tf:Find("adapt/shopPage/shop3D")
	self.shopFurniturePage = self._tf:Find("adapt/shopPage/shopFurniture")
	self.shopSkinPage = self._tf:Find("adapt/shopPage/shopSkin")
	self.morphBtn = self.shopSkinPage:Find("morphBtn")
	self.morphBlocker = self._tf:Find("morph_blocker")

	setActive(self.morphBlocker, false)

	self.changeCharaPanel = self.shopSkinPage:Find("changeCharaPanel/panel")
	self.subPageContainer = self._tf:Find("adapt/subPageContainer")
	self.drawAwardPage = IslandShopDrawAwardPage.New(self.subPageContainer, self)

	setText(self.shopSkinPage:Find("changeCharaPanel/panel/title"), i18n("island_3Dshop_chara_choose"))
	setText(self.shopSkinPage:Find("changeCharaPanel/panel/setTxt"), i18n("island_3Dshop_chara_set"))

	self.exchangSubView = IslandShopExchangePage.New(self._tf, self)

	self.exchangSubView:RegisterView(self)

	return
end

function IslandShopPage:OnInit()
	onButton(self, self.closeBtn, function()
		self:Hide()

		return
	end, SFX_PANEL)
	onButton(self, self.helpBtn, function()
		self:ShowMsgBox({
			hideNo = true,
			type = IslandMsgBox.TYPE_COMMON,
			content = i18n("island_draw_help"),
			alignment = TextAnchor.MiddleLeft
		})

		return
	end, SFX_PANEL)
	self:InitData()

	return
end

function IslandShopPage:InitData()
	self.shopAgency = getProxy(IslandProxy):GetIsland():GetShopAgency()
	self.inventoryAgency = getProxy(IslandProxy):GetIsland():GetInventoryAgency()
	self.characterAgency = getProxy(IslandProxy):GetIsland():GetCharacterAgency()
	self.player = getProxy(PlayerProxy):getRawData()
	self.ships = self.characterAgency:GetShips()
	self.defaultShipId = PlayerPrefs.GetInt("island_dressShop_defaultShipId_" .. self.player.id, 10703)
	self.islandShipDressHelper = IslandShipDressHelperNew.New()

	return
end

function IslandShopPage:DoUpdateShops()
	local var_7_0 = self.shopAgency:GetNewOrOverdueShopIds()

	if #var_7_0 > 0 then
		for iter_7_0, iter_7_1 in ipairs(var_7_0) do
			self:emit(IslandMediator.GET_SHOP_DATA, iter_7_1, true)
		end
	end

	self.showingShop = nil
	self.selectShipId = self.defaultShipId

	return
end

function IslandShopPage:DoUpdateShowingShop()
	if self.showingShop:IsInTime() then
		self:emit(IslandMediator.GET_SHOP_DATA, self.showingShop.id, false)
	else
		self:SetShopPage()
	end

	if isActive(self.shop3) or isActive(self.shop32) then
		local var_8_0 = self.showingShop:GetShowType()

		setActive(self.shop3, var_8_0 == IslandConst.SHOP_TYPE_RECOMMENDATION_5 or var_8_0 == IslandConst.SHOP_TYPE_RECOMMENDATION_1 or var_8_0 == IslandConst.SHOP_TYPE_2D)
		setActive(self.shop32, var_8_0 == IslandConst.SHOP_TYPE_3D or var_8_0 == IslandConst.SHOP_TYPE_FURNITURE or var_8_0 == IslandConst.SHOP_TYPE_SKIN)
	end

	return
end

function IslandShopPage:UpdateData()
	self.firstShopConfigs = self.shopAgency:GetFirstShopConfigs(self.showTypes, self.firstShopIds)

	if not self.showingShop or not self.shopAgency:IsShowShop(self.showingShop.id) then
		self.showingShop = self.shopAgency:GetInitShowingShop(self.showTypes, self.firstShopIds)
	end

	return
end

function IslandShopPage:SetShopPageVisible(arg_10_1)
	setActive(self._tf:Find("adapt/shopPage"), arg_10_1)

	if not IsNil(self.roleContainer) then
		setActive(self.roleContainer, arg_10_1)
	end

	return
end

function IslandShopPage:GetShopConfigIds(arg_11_1)
	local var_11_0 = {}

	for iter_11_0, iter_11_1 in ipairs(arg_11_1) do
		table.insert(var_11_0, iter_11_1.id)
	end

	return var_11_0
end

function IslandShopPage:GetRecommendationTargetShop(arg_12_1)
	if not arg_12_1 then
		return nil
	end

	if arg_12_1.shop_type ~= 0 then
		return self.shopAgency:GetShopById(arg_12_1.id)
	end

	if arg_12_1.tag_type == 1 then
		for iter_12_0, iter_12_1 in ipairs((self.shopAgency:GetSecondShopConfigs(self.showTypes, arg_12_1.id))) do
			local var_12_0 = self:GetRecommendationTargetShop(iter_12_1)

			if var_12_0 then
				return var_12_0
			end
		end
	elseif arg_12_1.tag_type == 2 then
		for iter_12_2, iter_12_3 in ipairs((self.shopAgency:GetThirdShopConfigs(self.showTypes, arg_12_1.id))) do
			local var_12_1 = self:GetRecommendationTargetShop(iter_12_3)

			if var_12_1 then
				return var_12_1
			end
		end
	end

	return nil
end

function IslandShopPage:JumpToRecommendationShop(arg_13_1)
	local var_13_0 = self:GetRecommendationTargetShop(pg.island_shop_template[arg_13_1])

	if not var_13_0 then
		return
	end

	self.showingShop = var_13_0

	if self.showingShop:IsInTime() then
		self:emit(IslandMediator.GET_SHOP_DATA, self.showingShop.id, true)
	else
		self:UpdateData()
		self:SetShopList()
	end

	return
end

function IslandShopPage:SetThirdShopTpl(arg_14_1, arg_14_2)
	setActive(arg_14_1:Find("selected"), self.showingShop.id == arg_14_2.id)
	setText(arg_14_1:Find("name"), arg_14_2.tag_icon[1])
	setText(arg_14_1:Find("selected/name"), arg_14_2.tag_icon[1])
	setActive(arg_14_1:Find("icon"), arg_14_2.tag_icon[3])

	if arg_14_2.tag_icon[3] then
		LoadImageSpriteAsync(arg_14_2.tag_icon[3], arg_14_1:Find("icon"), false)
	end

	local var_14_0 = self.shopAgency:GetShopById(arg_14_2.id):IsInTime()

	setActive(arg_14_1:Find("lock"), not var_14_0)
	setActive(arg_14_1:Find("selected/lock"), not var_14_0)

	return
end

function IslandShopPage:SelectThirdShop(arg_15_1, arg_15_2, arg_15_3, arg_15_4, arg_15_5, arg_15_6, arg_15_7)
	if self.currentShop1TgIndex == arg_15_4 and self.currentShop2TgIndex == arg_15_5 and self.currentShop3TgIndex == arg_15_6 then
		return
	end

	for iter_15_0 = 0, arg_15_2.childCount - 1 do
		setActive(arg_15_2:GetChild(iter_15_0):Find("selected"), false)
	end

	setActive(arg_15_1:Find("selected"), true)

	if arg_15_7 then
		arg_15_1:GetComponent(typeof(Animation)):Play("anim_IslandShopUI_Shop3List_Selected")
	end

	self.showingShop = self.shopAgency:GetShopById(arg_15_3.id)

	self:DoUpdateShowingShop()

	self.currentShop3TgIndex = arg_15_6

	return
end

function IslandShopPage:BindThirdShopList(arg_16_1, arg_16_2, arg_16_3, arg_16_4, arg_16_5, arg_16_6)
	local var_16_0 = self:GetShopConfigIds(arg_16_3)

	arg_16_1:make(function(arg_17_0, arg_17_1, arg_17_2)
		if arg_17_0 ~= UIItemList.EventUpdate then
			return
		end

		local var_17_0 = arg_17_1 + 1
		local var_17_1 = arg_16_3[arg_17_1 + 1]

		self:SetThirdShopTpl(arg_17_2, arg_16_3[arg_17_1 + 1])
		onToggle(self, arg_17_2, function(arg_18_0)
			if arg_18_0 then
				self:SelectThirdShop(arg_17_2, arg_16_2, var_17_1, arg_16_4, arg_16_5, var_17_0, arg_16_6)
			end

			return
		end, SFX_PANEL)

		if self.showingShop.id == arg_16_3[arg_17_1 + 1].id then
			triggerToggle(arg_17_2, true)
		end

		if arg_17_1 == 0 and not table.contains(var_16_0, self.showingShop.id) then
			triggerToggle(arg_17_2, true)
		end

		return
	end, SFX_PANEL)
	arg_16_1:align(#arg_16_3)

	return
end

function IslandShopPage:BindThirdShopLists(arg_19_1, arg_19_2, arg_19_3)
	self:BindThirdShopList(self.shop3List, self.shop3, arg_19_1, arg_19_2, arg_19_3, true)
	self:BindThirdShopList(self.shop3List2, self.shop32, arg_19_1, arg_19_2, arg_19_3, false)

	return
end

function IslandShopPage:SetSecondShopTpl(arg_20_1, arg_20_2)
	setActive(arg_20_1:Find("selected"), self.showingShop.id == arg_20_2.id or self.showingShop:GetSecondShopId() == arg_20_2.id)
	setText(arg_20_1:Find("name"), arg_20_2.tag_icon[1])
	setText(arg_20_1:Find("selected/name"), arg_20_2.tag_icon[1])

	return
end

function IslandShopPage:SelectSecondShop(arg_21_1, arg_21_2, arg_21_3, arg_21_4)
	if self.currentShop1TgIndex == arg_21_3 and self.currentShop2TgIndex == arg_21_4 then
		return
	end

	arg_21_1:GetComponent(typeof(Animation)):Play("anim_IslandShopUI_Shop2List_Selected")
	setActive(self.shop3, arg_21_2.shop_type == 0)
	setActive(self.shop32, arg_21_2.shop_type == 0)

	if arg_21_2.shop_type == 0 then
		self:BindThirdShopLists(self.shopAgency:GetThirdShopConfigs(self.showTypes, arg_21_2.id), arg_21_3, arg_21_4)
	else
		self.showingShop = self.shopAgency:GetShopById(arg_21_2.id)

		self:DoUpdateShowingShop()
	end

	self.currentShop2TgIndex = arg_21_4

	return
end

function IslandShopPage:BindSecondShopList(arg_22_1, arg_22_2, arg_22_3)
	local var_22_0 = self.shopAgency:GetSecondShopConfigs(self.showTypes, arg_22_2.id)
	local var_22_1 = self:GetShopConfigIds(var_22_0)
	local var_22_2 = UIItemList.New(arg_22_1:Find("shop2List"), arg_22_1:Find("shop2List/shop2Tpl"))

	var_22_2:make(function(arg_23_0, arg_23_1, arg_23_2)
		if arg_23_0 ~= UIItemList.EventUpdate then
			return
		end

		local var_23_0 = arg_23_1 + 1
		local var_23_1 = var_22_0[arg_23_1 + 1]

		self:SetSecondShopTpl(arg_23_2, var_22_0[arg_23_1 + 1])
		onToggle(self, arg_23_2, function(arg_24_0)
			if arg_24_0 then
				self:SelectSecondShop(arg_23_2, var_23_1, arg_22_3, var_23_0)
			end

			return
		end, SFX_PANEL)

		if self.showingShop.id == var_22_0[arg_23_1 + 1].id or self.showingShop:GetSecondShopId() == var_22_0[arg_23_1 + 1].id then
			triggerToggle(arg_23_2, true)
		end

		if arg_23_1 == 0 and not table.contains(var_22_1, self.showingShop.id) and not table.contains(var_22_1, self.showingShop:GetSecondShopId()) then
			triggerToggle(arg_23_2, true)
		end

		return
	end)
	var_22_2:align(#var_22_0)

	return
end

function IslandShopPage:SelectFirstShop(arg_25_1, arg_25_2, arg_25_3)
	if self.currentShop1TgIndex == arg_25_3 then
		return
	end

	self:SetShopPageVisible(true)
	setActive(self.shop3, false)
	setActive(self.shop32, false)
	arg_25_1:GetComponent(typeof(Animation)):Play("anim_IslandShopUI_Shop1List_Selected")
	setActive(arg_25_1:Find("shop2List"), arg_25_2.shop_type == 0)

	if arg_25_2.shop_type == 0 then
		self:BindSecondShopList(arg_25_1, arg_25_2, arg_25_3)
	else
		self.showingShop = self.shopAgency:GetShopById(arg_25_2.id)

		self:DoUpdateShowingShop()
	end

	self.currentShop1TgIndex = arg_25_3

	return
end

function IslandShopPage:BindFirstShopTab(arg_26_1, arg_26_2, arg_26_3)
	setActive(arg_26_1:Find("shop2List"), false)
	GetImageSpriteFromAtlasAsync("island/islandshopicon", arg_26_2.tag_icon[3], arg_26_1:Find("shop1Tg/selected/icon"), false)
	setText(arg_26_1:Find("shop1Tg/name"), arg_26_2.tag_icon[1])
	setText(arg_26_1:Find("shop1Tg/name/en"), arg_26_2.tag_icon[2])
	onToggle(self, arg_26_1:Find("shop1Tg"), function(arg_27_0)
		if arg_27_0 then
			self:SelectFirstShop(arg_26_1, arg_26_2, arg_26_3)
		else
			setActive(arg_26_1:Find("shop2List"), false)
		end

		return
	end, SFX_PANEL)

	if self.showingShop.id == arg_26_2.id or self.showingShop:GetFirstShopId() == arg_26_2.id then
		triggerToggle(arg_26_1:Find("shop1Tg"), true)
	end

	return
end

function IslandShopPage:BindDrawAwardTab(arg_28_1, arg_28_2)
	setActive(arg_28_1:Find("shop2List"), false)
	setText(arg_28_1:Find("shop1Tg/name"), i18n("island_draw_tab"))
	setText(arg_28_1:Find("shop1Tg/name/en"), i18n("island_draw_tab_en"))
	setActive(arg_28_1:Find("shop1Tg/selected/icon"), false)
	onToggle(self, arg_28_1:Find("shop1Tg"), function(arg_29_0)
		if arg_29_0 then
			if self.currentShop1TgIndex == arg_28_2 then
				return
			end

			self.currentShop1TgIndex = arg_28_2

			arg_28_1:GetComponent(typeof(Animation)):Play("anim_IslandShopUI_Shop1List_Selected")
			setText(self.title:Find("Text"), i18n("island_draw_tab"))
			self:SetResources()
			self:SetShopPageVisible(false)
			setActive(self.shop3, false)
			setActive(self.shop32, false)
			self.drawAwardPage:ActionInvoke("UpdateActivity", self.drawAwardActivity)
			self.drawAwardPage:ExecuteAction("Show")
		else
			self.drawAwardPage:ExecuteAction("Hide")
		end

		return
	end, SFX_PANEL)

	return
end

function IslandShopPage:SetShopList()
	self.currentShop1TgIndex = nil
	self.currentShop2TgIndex = nil
	self.currentShop3TgIndex = nil
	self.drawTabCnt = self.showDrawAward and self.drawAwardActivity and 1 or 0

	if self.drawTabCnt > 0 then
		self.drawTabIdx = #self.firstShopConfigs + 1 or nil
	end

	self.exchangeShowIds = (function()
		if not getProxy(IslandProxy):GetIsland():GetTaskAgency():IsFinishTask(var_0_1) then
			return {}
		end

		return pg.island_exchange_group.all
	end)()

	if self.drawTabIdx then
		self.exchangeTabStartIdx = self.drawTabIdx + 1 or #self.firstShopConfigs + 1
	end

	self.shop1List:make(function(arg_32_0, arg_32_1, arg_32_2)
		arg_32_1 = arg_32_1 + 1

		if arg_32_0 == UIItemList.EventUpdate then
			if self.firstShopConfigs[arg_32_1] then
				self:BindFirstShopTab(arg_32_2, self.firstShopConfigs[arg_32_1], arg_32_1)
			elseif self.drawTabIdx and arg_32_1 == self.drawTabIdx then
				self:BindDrawAwardTab(arg_32_2, arg_32_1)
			elseif #self.exchangeShowIds > 0 and arg_32_1 >= self.exchangeTabStartIdx then
				self:BindExchangeTab(arg_32_2, arg_32_1)
			end
		end

		return
	end)
	self.shop1List:align(#self.firstShopConfigs + self.drawTabCnt + #self.exchangeShowIds)

	return
end

function IslandShopPage:SetShopPage()
	local var_33_0 = self.showingShop:GetShowType()

	setText(self.title:Find("Text"), self.showingShop:GetShopIcon()[1])
	setText(self.title:Find("Text/en"), self.showingShop:GetShopIcon()[2])
	self:SetResources()
	setActive(self.recommendationPage1, var_33_0 == IslandConst.SHOP_TYPE_RECOMMENDATION_1)
	setActive(self.recommendationPage5, var_33_0 == IslandConst.SHOP_TYPE_RECOMMENDATION_5)
	setActive(self.shop2DPage, var_33_0 == IslandConst.SHOP_TYPE_2D)
	setActive(self.shop3DPage, var_33_0 == IslandConst.SHOP_TYPE_3D)
	setActive(self.shopFurniturePage, var_33_0 == IslandConst.SHOP_TYPE_FURNITURE)
	setActive(self.shopSkinPage, var_33_0 == IslandConst.SHOP_TYPE_SKIN)
	switch(var_33_0, {
		[IslandConst.SHOP_TYPE_RECOMMENDATION_1] = function()
			self:ShowRecommendation1()

			return
		end,
		[IslandConst.SHOP_TYPE_RECOMMENDATION_5] = function()
			self:ShowRecommendation5()

			return
		end,
		[IslandConst.SHOP_TYPE_2D] = function()
			self:ShowShop2D()

			return
		end,
		[IslandConst.SHOP_TYPE_3D] = function()
			self:ShowShop3D()

			return
		end,
		[IslandConst.SHOP_TYPE_FURNITURE] = function()
			self:ShowShopFurniture()

			return
		end,
		[IslandConst.SHOP_TYPE_SKIN] = function()
			self:ShowShopSkin()

			return
		end
	})

	return
end

function IslandShopPage:SetResources()
	self.player = getProxy(PlayerProxy):getRawData()

	setActive(self.helpBtn, not self.firstShopConfigs[self.currentShop1TgIndex])

	if not self.firstShopConfigs[self.currentShop1TgIndex] then
		local var_40_0 = {}

		table.insert(var_40_0, Drop.New({
			type = DROP_TYPE_VITEM,
			id = self.drawAwardActivity:GetDrawConfig("cost_free")
		}))
		table.insert(var_40_0, Drop.New({
			type = DROP_TYPE_RESOURCE,
			id = PlayerConst.ResDiamond
		}))
		self.resourceList:make(function(arg_41_0, arg_41_1, arg_41_2)
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
		self.resourceList:align(#var_40_0)

		return
	end

	local var_40_1 = self.showingShop:GetTopResources()

	self.resourceList:make(function(arg_43_0, arg_43_1, arg_43_2)
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
					setText(arg_43_2:Find("gold/max"), "MAX: " .. self.player:getLevelMaxGold())
					setText(arg_43_2:Find("gold/Text"), self.player.gold)
				elseif var_43_1 == 4 or var_43_1 == 14 then
					setActive(arg_43_2:Find("gem"), true)
					setText(arg_43_2:Find("gem/Text"), self.player:getTotalGem())
				end
			elseif var_40_1[arg_43_1 + 1][2] == DROP_TYPE_ISLAND_ITEM then
				setActive(arg_43_2:Find("islandItem"), true)

				local var_43_2 = self.inventoryAgency:GetOwnCount(var_43_1)

				setText(arg_43_2:Find("islandItem/Text"), var_43_2)
				GetImageSpriteFromAtlasAsync(Drop.New({
					type = DROP_TYPE_ISLAND_ITEM,
					id = var_43_1
				}):getIcon(), "", arg_43_2:Find("islandItem/icon"))
				setActive(arg_43_2:Find("islandItem/descBtn"), var_43_0 == 1)
				setActive(arg_43_2:Find("islandItem/resourceDesc"), false)

				if var_43_0 == 1 then
					local var_43_3 = pg.island_item_data_template[var_43_1].have_max

					setText(arg_43_2:Find("islandItem/Text"), var_43_2 .. "/" .. pg.island_item_data_template[var_43_1].have_max)
					onButton(self, arg_43_2:Find("islandItem"), function()
						setActive(arg_43_2:Find("islandItem/resourceDesc"), not isActive(arg_43_2:Find("islandItem/resourceDesc")))
						setText(arg_43_2:Find("islandItem/resourceDesc"), i18n("island_3Dshop_res_have") .. var_43_3)

						return
					end, SFX_PANEL)
				end
			end
		end

		return
	end)
	self.resourceList:align(#var_40_1)

	return
end

function IslandShopPage:SetResourcesVisible(arg_45_1)
	setActive(self._tf:Find("adapt/top/resources"), arg_45_1)

	return
end

function IslandShopPage:SetCloseAndRefresh(arg_46_1)
	local var_46_0 = 0

	if self.showingShop:IsNormalShop() then
		local var_46_1 = self.showingShop:GetExistTime()

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
	elseif self.showingShop:IsTemporaryShop() then
		var_46_0 = self.showingShop.existTime
	end

	local var_46_2 = self.showingShop.refreshTime
	local var_46_3 = self.showingShop:GetPlayerRefreshResource()

	setActive(arg_46_1:Find("remainAndRefresh/remainTimer"), var_46_0 ~= 0)
	setActive(arg_46_1:Find("remainAndRefresh/refresh"), var_46_2 ~= 0)
	setActive(arg_46_1:Find("remainAndRefresh/refresh/refreshBtn"), var_46_3)
	setActive(arg_46_1:Find("remainAndRefresh"), isActive(arg_46_1:Find("remainAndRefresh/remainTimer")) or isActive(arg_46_1:Find("remainAndRefresh/refresh")))

	local var_46_4 = pg.TimeMgr.GetInstance():GetTimeToNextTime()

	if self.timer then
		self.timer:Stop()

		self.timer = nil
	end

	self.timer = Timer.New(function()
		local var_47_0 = pg.TimeMgr.GetInstance():GetServerTime()

		if var_46_0 ~= 0 then
			setText(arg_46_1:Find("remainAndRefresh/remainTimer"), i18n("island_3Dshop_time_close", (pg.TimeMgr.GetInstance():DescCDTime(var_46_0 - var_47_0))))
		elseif normalShopExistTime and type(normalShopExistTime) == "table" then
			-- block empty
		end

		if var_46_2 ~= 0 then
			setText(arg_46_1:Find("remainAndRefresh/refresh/refreshTimer"), i18n("island_3Dshop_time_refresh", (pg.TimeMgr.GetInstance():DescCDTime(var_46_2 - var_47_0))))

			if var_47_0 > var_46_2 then
				self:DoUpdateShowingShop()
			end
		end

		if var_46_2 == 0 and var_46_3 and var_47_0 > var_46_4 then
			self:DoUpdateShowingShop()
		end

		return
	end, 1, -1)

	self.timer:Start()

	if var_46_3 then
		onButton(self, arg_46_1:Find("remainAndRefresh/refresh/refreshBtn/button"), function()
			if self.showingShop.refreshCount < self.showingShop:GetMaxRefreshCount() then
				local var_48_0 = var_46_3[3]

				if self.showingShop:GetFirstRefreshFree() and self.showingShop.refreshCount == 0 then
					var_46_3[3] = 0
					var_48_0 = 0
				end

				pg.MsgboxMgr.GetInstance():ShowMsgBox({
					yesText = "text_confirm",
					hideNo = false,
					noText = "text_cancel",
					content = i18n("refresh_shopStreet_question", i18n("word_" .. id2res(var_46_3[2]) .. "_icon"), var_48_0, self.showingShop.refreshCount),
					onYes = function()
						self:emit(IslandMediator.REFRESH_SHOP_BY_PLAYER, self.showingShop.id, var_46_3)

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

function IslandShopPage:IsCommodityInShoppingCart(arg_50_1)
	for iter_50_0, iter_50_1 in ipairs(self.shoppingCartCommodities) do
		if iter_50_1.id == arg_50_1.id then
			return true
		end
	end

	return false
end

function IslandShopPage:IsCommodityDisabled(arg_51_1)
	return isActive(arg_51_1:Find("sellOut")) or isActive(arg_51_1:Find("hold")) or isActive(arg_51_1:Find("notInTime"))
end

function IslandShopPage:OpenShoppingCart()
	self.myIslandShoppingCartLayer = self:OpenPage(IslandShoppingCartLayer, self.shoppingCartCommodities)

	return
end

function IslandShopPage:RefreshShopSkinCartButtons()
	setActive(self.shopSkinPage:Find("cancelBtn"), #self.shoppingCartCommodities > 0)
	setActive(self.shopSkinPage:Find("shoppingCartBtn"), #self.shoppingCartCommodities > 0)
	setActive(self.shopSkinPage:Find("shoppingCartBtn/count"), self.showingShop:GetCommanderOrCharaType() == 1)

	return
end

function IslandShopPage:ResetShopSkinCartPreview()
	local var_54_0 = self.shoppingCartCommodities and self.shoppingCartCommodities[1]

	self.shoppingCartCommodities = {}
	self.showingCommodity = nil

	if var_54_0 and self:IsCommanderDressCommodity(var_54_0) then
		self:ResetCommanderDressPreview(true)
	else
		self:ResetCommanderDressPreview(false)
		self.islandShipDressHelper:ResetDressUp()
	end

	return
end

function IslandShopPage:BindShopSkinCartButtons(arg_55_1)
	if #self.shoppingCartCommodities <= 0 then
		return
	end

	onButton(self, self.shopSkinPage:Find("cancelBtn"), function()
		if arg_55_1 then
			arg_55_1()
		else
			self:ResetShopSkinCartPreview()
		end

		setActive(self.shopSkinPage:Find("cancelBtn"), false)
		setActive(self.shopSkinPage:Find("shoppingCartBtn"), false)
		setText(self.shopSkinPage:Find("shoppingCartBtn/count"), "0/3")
		self:SetCommodityList()

		return
	end, SFX_PANEL)
	onButton(self, self.shopSkinPage:Find("shoppingCartBtn"), function()
		self:OpenShoppingCart()

		return
	end, SFX_PANEL)

	return
end

function IslandShopPage:IsDressCommodityExclusive(arg_58_1)
	local var_58_0 = self.characterAgency:GetShipById(self.showingShipId)
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
	elseif var_58_2.exclusive_default_skin ~= "" then
		for iter_58_2, iter_58_3 in ipairs(var_58_2.exclusive_default_skin) do
			if iter_58_3 == var_58_0.id then
				return true, var_58_2
			end
		end
	end

	return false, var_58_2
end

function IslandShopPage:IsCommanderDressCommodity(arg_59_1)
	local var_59_0 = arg_59_1:GetItems()

	if #var_59_0 == 0 or var_59_0[1][1] ~= DROP_TYPE_ISLAND_DRESS then
		return false
	end

	return pg.island_dress_template[var_59_0[1][2]] and pg.island_dress_template[var_59_0[1][2]].belongto == 1
end

function IslandShopPage:CacheCommanderDressPreviewData()
	if self.commanderDressPreviewData then
		return
	end

	local var_60_0 = getProxy(IslandProxy):GetIsland():GetDressUpAgency()

	self.commanderDressPreviewData = {}

	for iter_60_0, iter_60_1 in pairs(IslandShipDressHelperNew.CommanderCustom) do
		local var_60_1 = var_60_0:GetDressByType(iter_60_1) or 0

		self.commanderDressPreviewData[iter_60_1] = {
			id = var_60_1,
			colorId = var_60_0:GetCurrentColorByDressId(var_60_1)
		}
	end

	return
end

function IslandShopPage:RestoreCommanderDressPreview()
	if not self.commanderDressPreviewData then
		return
	end

	local var_61_0 = self.commanderDressPreviewData

	for iter_61_0, iter_61_1 in ipairs(IslandShipDressHelperNew.CommanderCustom) do
		if var_61_0[iter_61_1] then
			self.islandShipDressHelper:ChangeDressByType(iter_61_1, var_61_0[iter_61_1])
		end
	end

	self.commanderDressPreviewData = nil

	return
end

function IslandShopPage:ResetCommanderDressPreview(arg_62_1, arg_62_2)
	if arg_62_1 then
		self:RestoreCommanderDressPreview()
	else
		self.commanderDressPreviewData = nil

		if arg_62_2 then
			self.islandShipDressHelper:InvalidateRole()
		end
	end

	self:SetMorphBlock(false)
	setActive(self.morphBtn, false)

	return
end

function IslandShopPage:ChangeDressByCommodityItems(arg_63_1)
	for iter_63_0, iter_63_1 in ipairs(arg_63_1:GetItems()) do
		local var_63_0

		if iter_63_1[1] == DROP_TYPE_ISLAND_DRESS then
			if pg.island_dress_template[iter_63_1[2]] then
				var_63_0 = pg.island_dress_template[iter_63_1[2]].type
			end
		end

		self.islandShipDressHelper:ChangeDressByType(var_63_0, {
			colorId = 0,
			id = iter_63_1[2]
		})
	end

	return
end

function IslandShopPage:ToggleDressSuitCommodity(arg_64_1)
	self:ResetCommanderDressPreview(false)

	self.showingCommodity = nil

	if #self.shoppingCartCommodities == 1 and self.shoppingCartCommodities[1].id == arg_64_1.id then
		self.shoppingCartCommodities = {}

		self.islandShipDressHelper:ResetDressUp()
	end

	local var_64_0

	do
		self.shoppingCartCommodities = {
			arg_64_1
		}

		self:ChangeDressByCommodityItems(arg_64_1)

		var_64_0 = #self.shoppingCartCommodities > 0 and #arg_64_1:GetDisplayItems() or 0
	end

	setText(self.shopSkinPage:Find("shoppingCartBtn/count"), var_64_0 .. "/3")

	return
end

function IslandShopPage:ChangeCommanderDressByCommodity(arg_65_1)
	self:CacheCommanderDressPreviewData()

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

				self.islandShipDressHelper:ChangeDressByType(pg.island_dress_template[iter_65_1[2]].type, {
					colorId = 0,
					id = var_65_0
				})
				self:CheckCommanderHatState(pg.island_dress_template[iter_65_1[2]].type, var_65_0)
				self:CheckCommanderMorphBtn(pg.island_dress_template[iter_65_1[2]].type, var_65_0)
			end
		end
	end

	return
end

function IslandShopPage:CheckCommanderHatState(arg_66_1, arg_66_2)
	if arg_66_1 ~= IslandShipDressHelperNew.DressType.Body then
		return
	end

	local var_66_0 = (pg.island_dress_template.get_id_list_by_related_dress[arg_66_2] or {})[1]

	if not (pg.island_dress_template.get_id_list_by_related_dress[arg_66_2] or {})[1] or var_66_0 == 0 then
		self.islandShipDressHelper:ChangeDressByType(IslandShipDressHelperNew.DressType.Hat, {
			id = 0,
			colorId = 0
		})
	elseif var_66_0 and var_66_0 ~= 0 then
		self.islandShipDressHelper:ChangeDressByType(IslandShipDressHelperNew.DressType.Hat, {
			colorId = 0,
			id = var_66_0
		})
	end

	return
end

function IslandShopPage:CheckCommanderMorphBtn(arg_67_1, arg_67_2)
	if arg_67_1 ~= IslandShipDressHelperNew.DressType.Body then
		return
	end

	local var_67_0 = arg_67_2
	local var_67_1 = 0

	if pg.island_dress_template[arg_67_2].cloth_related and pg.island_dress_template[arg_67_2].cloth_related ~= 0 then
		var_67_1 = pg.island_dress_template[arg_67_2].cloth_related
	end

	if var_67_1 == 0 then
		setActive(self.morphBtn, false)

		return
	end

	setActive(self.morphBtn, true)
	onButton(self, self.morphBtn, function()
		self:DoMorphSwitch(var_67_0, var_67_1)

		return
	end)

	return
end

function IslandShopPage:DoMorphSwitch(arg_69_1, arg_69_2)
	if self.morphing then
		return
	end

	self:SetMorphBlock(true)

	if not self.islandShipDressHelper then
		self:DoSwitch(arg_69_2, function()
			self:SetMorphBlock(false)

			return
		end)

		return
	end

	self.islandShipDressHelper:DoMorphSwitch(arg_69_1, arg_69_2, function()
		self:DoSwitch(arg_69_2, function()
			self:SetMorphBlock(false)

			return
		end)

		return
	end)

	return
end

function IslandShopPage:DoSwitch(arg_73_1, arg_73_2)
	self.islandShipDressHelper:ChangeDressByType(IslandShipDressHelperNew.DressType.Body, {
		colorId = 0,
		id = arg_73_1
	}, arg_73_2)
	self:CheckCommanderHatState(IslandShipDressHelperNew.DressType.Body, arg_73_1)
	self:CheckCommanderMorphBtn(IslandShipDressHelperNew.DressType.Body, arg_73_1)

	return
end

function IslandShopPage:SetMorphBlock(arg_74_1)
	self.morphing = arg_74_1

	setActive(self.morphBlocker, arg_74_1)

	return
end

function IslandShopPage:ToggleCommanderDressCommodity(arg_75_1)
	if #self.shoppingCartCommodities == 1 and self.shoppingCartCommodities[1].id == arg_75_1.id then
		self.shoppingCartCommodities = {}

		self:ResetCommanderDressPreview(true)
	end

	local var_75_0

	do
		self.shoppingCartCommodities = {
			arg_75_1
		}

		self:ChangeCommanderDressByCommodity(arg_75_1)

		var_75_0 = #self.shoppingCartCommodities > 0 and #arg_75_1:GetDisplayItems() or 0
	end

	setText(self.shopSkinPage:Find("shoppingCartBtn/count"), var_75_0 .. "/3")

	return
end

function IslandShopPage:RemoveSameDressTypeCommodity(arg_76_1)
	local var_76_0 = 0

	for iter_76_0, iter_76_1 in ipairs(self.shoppingCartCommodities) do
		if iter_76_1:GetDressType() == arg_76_1:GetDressType() then
			var_76_0 = iter_76_1.id

			table.remove(self.shoppingCartCommodities, iter_76_0)

			break
		end
	end

	return var_76_0
end

function IslandShopPage:ToggleSingleDressCommodity(arg_77_1)
	local var_77_0, var_77_1 = self:IsDressCommodityExclusive(arg_77_1)

	if var_77_0 then
		pg.TipsMgr.GetInstance():ShowTips(i18n("island_dress_mutually_exclusive1", var_77_1.name))

		return false
	end

	self:ResetCommanderDressPreview(false)

	self.showingCommodity = nil

	if #self.shoppingCartCommodities > 0 and #self.shoppingCartCommodities[1]:GetItems() > 1 then
		self.shoppingCartCommodities = {}

		self.islandShipDressHelper:ResetDressUp()
	end

	if arg_77_1.id == self:RemoveSameDressTypeCommodity(arg_77_1) then
		self.islandShipDressHelper:ChangeDressByType(arg_77_1:GetDressType(), {
			id = 0,
			colorId = 0
		})
	else
		table.insert(self.shoppingCartCommodities, arg_77_1)
		self.islandShipDressHelper:ChangeDressByType(arg_77_1:GetDressType(), {
			colorId = 0,
			id = arg_77_1:GetItems()[1][2]
		})
	end

	setText(self.shopSkinPage:Find("shoppingCartBtn/count"), #self.shoppingCartCommodities .. "/3")

	return true
end

function IslandShopPage:HandleDressCommodity(arg_78_1)
	if self:IsCommanderDressCommodity(arg_78_1) then
		self:ToggleCommanderDressCommodity(arg_78_1)
	elseif #arg_78_1:GetItems() > 1 then
		self:ToggleDressSuitCommodity(arg_78_1)
	elseif not self:ToggleSingleDressCommodity(arg_78_1) then
		return
	end

	self:RefreshShopSkinCartButtons()
	self:BindShopSkinCartButtons()
	self:SetCommodityList()

	return
end

function IslandShopPage:HandleFurnitureCommodity(arg_79_1)
	self:ResetCommanderDressPreview(false, true)

	if self.showingCommodity ~= arg_79_1 then
		self.showingCommodity = arg_79_1
		self.shoppingCartCommodities = {
			arg_79_1
		}

		self:LoadFurniture(arg_79_1:GetModel(), arg_79_1:GetModelParam())
		setActive(self.shopFurniturePage:Find("scenePreviewBtn"), false)
		setActive(self.shopFurniturePage:Find("shoppingCartBtn"), true)

		if #arg_79_1:GetItems() == 1 then
			onButton(self, self.shopFurniturePage:Find("scenePreviewBtn"), function()
				setActive(self._tf, false)
				self:ClearCharacterScene()
				self:emit(IslandMediator.PREVIEW_FURNITURE, arg_79_1:GetItems()[1][2])

				return
			end, SFX_PANEL)
		end

		onButton(self, self.shopFurniturePage:Find("shoppingCartBtn"), function()
			self:OpenShoppingCart()

			return
		end, SFX_PANEL)
	else
		self.showingCommodity = nil
		self.shoppingCartCommodities = {}

		self:UnloadCharacter()
		setActive(self.shopFurniturePage:Find("scenePreviewBtn"), false)
		setActive(self.shopFurniturePage:Find("shoppingCartBtn"), false)
	end

	self:SetCommodityList()

	return
end

function IslandShopPage:HandleSkinCommodity(arg_82_1)
	self:ResetCommanderDressPreview(false, true)

	if self.showingCommodity ~= arg_82_1 then
		self.showingCommodity = arg_82_1
		self.shoppingCartCommodities = {
			arg_82_1
		}

		self:LoadCharacter(pg.island_unit_character[pg.island_skin_template[arg_82_1:GetItems()[1][2]].model], false)
	else
		self.showingCommodity = nil
		self.shoppingCartCommodities = {}

		self:UnloadCharacter()
	end

	setActive(self.shopSkinPage:Find("cancelBtn"), false)
	setActive(self.shopSkinPage:Find("shoppingCartBtn"), #self.shoppingCartCommodities > 0)
	setActive(self.shopSkinPage:Find("shoppingCartBtn/count"), false)
	setText(self.shopSkinPage:Find("shoppingCartBtn/count"), #self.shoppingCartCommodities .. "/3")
	self:BindShopSkinCartButtons(function()
		self.shoppingCartCommodities = {}

		self:LoadCharacter(self.characterAgency:GetShipById(self.showingShipId):GetModel(), false)

		return
	end)
	self:SetCommodityList()

	return
end

function IslandShopPage:SetCommodity(arg_84_1, arg_84_2)
	IslandShopPage.StaticUpdateCommodityTpl(arg_84_1, arg_84_2)
	setActive(arg_84_1:Find("notInTime"), not self.showingShop:IsInTime())
	setActive(arg_84_1:Find("select"), self:IsCommodityInShoppingCart(arg_84_2))

	if self:IsCommodityDisabled(arg_84_1) then
		removeOnButton(arg_84_1)
	else
		onButton(self, arg_84_1, function()
			switch(arg_84_2:GetCommodityShowType(), {
				[IslandConst.COMMODITY_SHOW_ITEM] = function()
					self.myIslandShopItemLayer = self:OpenPage(IslandShopItemLayer, self.showingShop.id, arg_84_2)

					return
				end,
				[IslandConst.COMMODITY_SHOW_DRESS] = function()
					self:HandleDressCommodity(arg_84_2)

					return
				end,
				[IslandConst.COMMODITY_SHOW_FURNITURE] = function()
					self:HandleFurnitureCommodity(arg_84_2)

					return
				end,
				[IslandConst.COMMODITY_SHOW_SKIN] = function()
					self:HandleSkinCommodity(arg_84_2)

					return
				end,
				[IslandConst.COMMODITY_SHOW_INVITE] = function()
					self.myIslandShopItemLayer = self:OpenPage(IslandShopItemLayer, self.showingShop.id, arg_84_2, arg_84_2:GetItems()[1][2])

					return
				end
			})

			return
		end, SFX_PANEL)
	end

	return
end

function IslandShopPage:SetCommodityList()
	local var_91_0 = switch(self.showingShop:GetShowType(), {
		[IslandConst.SHOP_TYPE_2D] = function()
			return UIItemList.New(self.shop2DPage:Find("shopView/Viewport/Content"), self.shop2DPage:Find("shopView/Viewport/Content/IslandCommodityTpl"))
		end,
		[IslandConst.SHOP_TYPE_3D] = function()
			return UIItemList.New(self.shop3DPage:Find("shopView/Viewport/Content"), self.shop3DPage:Find("shopView/Viewport/Content/IslandCommodityTpl"))
		end,
		[IslandConst.SHOP_TYPE_FURNITURE] = function()
			return UIItemList.New(self.shopFurniturePage:Find("shopView/Viewport/Content"), self.shopFurniturePage:Find("shopView/Viewport/Content/IslandCommodityTpl"))
		end,
		[IslandConst.SHOP_TYPE_SKIN] = function()
			return UIItemList.New(self.shopSkinPage:Find("shopView/Viewport/Content"), self.shopSkinPage:Find("shopView/Viewport/Content/IslandCommodityTpl"))
		end
	})
	local var_91_1 = self.showingShop:GetCommodities()

	IslandShopPage.SortShopCommodities(var_91_1)
	var_91_0:make(function(arg_96_0, arg_96_1, arg_96_2)
		if arg_96_0 == UIItemList.EventUpdate then
			self:SetCommodity(arg_96_2, var_91_1[arg_96_1 + 1])
		end

		return
	end, SFX_PANEL)
	var_91_0:align(#var_91_1)

	return
end

function IslandShopPage:ShowRecommendation5()
	self:ClearCharacterScene()
	self:OverlayPanel(self._tf, {
		pbList = {
			self.bg
		}
	})
	setActive(self.bgColor, true)

	self.shoppingCartCommodities = {}
	self.showingCommodity = nil

	self:ResetCommanderDressPreview(false)

	local var_97_0 = self.showingShop:GetBanners()
	local var_97_1 = self.recommendationPage5:Find("banners")

	for iter_97_0 = 1, #var_97_0 do
		local var_97_2 = var_97_0[iter_97_0]
		local var_97_3 = var_97_1:Find("banner" .. var_97_0[iter_97_0].id)

		if var_97_3 then
			GetImageSpriteFromAtlasAsync("activitybanner/" .. var_97_0[iter_97_0].pic, "", var_97_3)
			onButton(self, var_97_3, function()
				self:JumpToRecommendationShop(var_97_2.param)

				return
			end, SFX_PANEL)
		end
	end

	return
end

function IslandShopPage:ShowRecommendation1()
	self:ClearCharacterScene()
	self:OverlayPanel(self._tf, {
		pbList = {
			self.bg
		}
	})
	setActive(self.bgColor, true)

	self.shoppingCartCommodities = {}
	self.showingCommodity = nil

	self:ResetCommanderDressPreview(false)

	local var_99_0 = self.showingShop:GetBanners()
	local var_99_1 = self.recommendationPage1:Find("banners")

	for iter_99_0 = 1, #var_99_0 do
		local var_99_2 = var_99_0[iter_99_0]
		local var_99_3 = var_99_1:Find("banner" .. var_99_0[iter_99_0].id)

		if var_99_3 then
			GetImageSpriteFromAtlasAsync("activitybanner/" .. var_99_0[iter_99_0].pic, "", var_99_3)
			onButton(self, var_99_3, function()
				self:JumpToRecommendationShop(var_99_2.param)

				return
			end, SFX_PANEL)
		end
	end

	return
end

function IslandShopPage:ShowShop2D()
	self:ClearCharacterScene()
	self:OverlayPanel(self._tf, {
		pbList = {
			self.bg
		}
	})
	setActive(self.bgColor, true)

	self.shoppingCartCommodities = {}
	self.showingCommodity = nil

	self:ResetCommanderDressPreview(false)

	local var_101_0 = self.showingShop:IsInTime()

	setActive(self.shop2DPage:Find("lock"), not var_101_0)

	if var_101_0 then
		self:SetCloseAndRefresh(self.shop2DPage)
	else
		setActive(self.shop2DPage:Find("remainAndRefresh"), false)

		if self.timer then
			self.timer:Stop()

			self.timer = nil
		end

		self.timer = Timer.New(function()
			local var_102_0 = self.showingShop:GetExistTime()[1]

			setText(self.shop2DPage:Find("lock/openTimer"), i18n("island_3Dshop_time_unlock", (pg.TimeMgr.GetInstance():DescCDTime(pg.TimeMgr.GetInstance():Table2ServerTime({
				year = var_102_0[1][1],
				month = var_102_0[1][2],
				day = var_102_0[1][3],
				hour = var_102_0[2][1],
				min = var_102_0[2][2],
				sec = var_102_0[2][3]
			}) - pg.TimeMgr.GetInstance():GetServerTime()))))

			return
		end, 1, -1)

		self.timer:Start()
	end

	self:SetCommodityList()

	return
end

function IslandShopPage:ShowShop3D()
	self:ClearCharacterScene()
	self:OverlayPanel(self._tf, {
		pbList = {
			self.shop3DPage:Find("bg")
		}
	})
	setActive(self.bgColor, false)

	self.shoppingCartCommodities = {}
	self.showingCommodity = nil

	self:ResetCommanderDressPreview(false)
	self:SetCloseAndRefresh(self.shop3DPage)
	self:SetCommodityList()

	return
end

function IslandShopPage:ShowShopFurniture()
	if not self.isLoadCharacterScene then
		self:PrepareCharacterScene()
	end

	self:OverlayPanel(self._tf, {
		pbList = {
			self.shopFurniturePage:Find("bg")
		}
	})
	setActive(self.bgColor, false)
	self:UnloadCharacter()

	self.shoppingCartCommodities = {}
	self.showingCommodity = nil

	self:ResetCommanderDressPreview(false)
	self:SetCloseAndRefresh(self.shopFurniturePage)
	self:SetCommodityList()
	setActive(self.shopFurniturePage:Find("scenePreviewBtn"), false)
	setActive(self.shopFurniturePage:Find("shoppingCartBtn"), false)

	return
end

function IslandShopPage:ShowShopSkin()
	if not self.isLoadCharacterScene then
		self:PrepareCharacterScene()
	end

	self:OverlayPanel(self._tf, {
		pbList = {
			self.shopSkinPage:Find("bg"),
			self.changeCharaPanel
		}
	})
	setActive(self.bgColor, false)

	self.shoppingCartCommodities = self.shoppingCartCommodities or {}

	if #self.shoppingCartCommodities > 0 then
		local var_105_0 = self.shoppingCartCommodities[1]:GetCommodityShowType()

		if var_105_0 == IslandConst.COMMODITY_SHOW_FURNITURE or var_105_0 == IslandConst.COMMODITY_SHOW_SKIN then
			self.shoppingCartCommodities = {}
			self.showingCommodity = nil

			self:ResetCommanderDressPreview(false, true)
		end
	end

	local var_105_1 = self.showingShop:GetCommanderOrCharaType()

	if var_105_1 == 0 and (self.showingShipId ~= 0 or #self.shoppingCartCommodities == 0) then
		self.showingShipId = 0

		self:LoadCharacter({
			model = pg.island_unit_character[0].model,
			animator = pg.island_unit_character[0].animator
		}, true)

		self.shoppingCartCommodities = {}
		self.showingCommodity = nil

		self:ResetCommanderDressPreview(false)
	elseif var_105_1 == 1 and (self.showingShipId ~= self.selectShipId or #self.shoppingCartCommodities == 0) then
		self:ResetCommanderDressPreview(false, true)

		self.showingShipId = self.selectShipId

		self:LoadCharacter(self.characterAgency:GetShipById(self.showingShipId):GetModel(), false)

		self.shoppingCartCommodities = {}
		self.showingCommodity = nil

		self:ResetCommanderDressPreview(false)
	elseif var_105_1 == 2 then
		self:ResetCommanderDressPreview(false, true)

		self.showingShipId = self.selectShipId

		self:UnloadCharacter()

		self.shoppingCartCommodities = {}
		self.showingCommodity = nil

		self:ResetCommanderDressPreview(false)
	end

	self:SetCloseAndRefresh(self.shopSkinPage)
	self:SetCommodityList()
	setActive(self.shopSkinPage:Find("cancelBtn"), #self.shoppingCartCommodities > 0)
	setActive(self.shopSkinPage:Find("changeCharaBtn"), var_105_1 == 1)
	setActive(self.shopSkinPage:Find("shoppingCartBtn"), #self.shoppingCartCommodities > 0)
	setActive(self.shopSkinPage:Find("shoppingCartBtn/count"), #self.shoppingCartCommodities > 0 and var_105_1 == 1)
	setText(self.shopSkinPage:Find("shoppingCartBtn/count"), #self.shoppingCartCommodities .. "/3")
	setActive(self.shopSkinPage:Find("changeCharaPanel"), false)
	self:SetChangeCharaPanel()
	onButton(self, self.shopSkinPage:Find("changeCharaBtn"), function()
		setActive(self.shopSkinPage:Find("changeCharaPanel"), true)

		return
	end, SFX_PANEL)

	return
end

function IslandShopPage:SetChangeCharaPanel()
	onButton(self, self.shopSkinPage:Find("changeCharaPanel/bg"), function()
		setActive(self.shopSkinPage:Find("changeCharaPanel"), false)

		return
	end, SFX_PANEL)
	onButton(self, self.changeCharaPanel:Find("closeBtn"), function()
		setActive(self.shopSkinPage:Find("changeCharaPanel"), false)

		return
	end, SFX_PANEL)

	local var_107_0 = UIItemList.New(self.changeCharaPanel:Find("charaScroll/Viewport/Content"), self.changeCharaPanel:Find("charaScroll/Viewport/Content/IslandShipTpl"))

	var_107_0:make(function(arg_110_0, arg_110_1, arg_110_2)
		if arg_110_0 == UIItemList.EventUpdate then
			local var_110_0 = self.ships[arg_110_1 + 1]

			GetImageSpriteFromAtlasAsync("ShipYardIcon/" .. IslandShip.StaticGetPrefab(self.ships[arg_110_1 + 1].id), "", arg_110_2:Find("mask/icon"))
			setText(arg_110_2:Find("Text"), "Lv." .. var_110_0:GetLevel())
			setActive(arg_110_2:Find("add"), false)
			setActive(arg_110_2:Find("select"), var_110_0.id == self.selectShipId)
			onButton(self, arg_110_2, function()
				if self.charaSetModel == IslandShopPage.CharaSetModel.current then
					self:ResetCommanderDressPreview(false, true)

					self.selectShipId = var_110_0.id
					self.showingShipId = var_110_0.id

					self:LoadCharacter(var_110_0:GetModel(), false)

					self.shoppingCartCommodities = {}
					self.showingCommodity = nil

					setActive(self.shopSkinPage:Find("cancelBtn"), false)
					setActive(self.shopSkinPage:Find("shoppingCartBtn"), false)
					setText(self.shopSkinPage:Find("shoppingCartBtn/count"), "0/3")
					self:SetCommodityList()
				elseif self.charaSetModel == IslandShopPage.CharaSetModel.default then
					self.defaultShipId = var_110_0.id

					PlayerPrefs.SetInt("island_dressShop_defaultShipId_" .. self.player.id, var_110_0.id)
				end

				for iter_111_0 = 0, self.changeCharaPanel:Find("charaScroll/Viewport/Content").childCount - 1 do
					setActive(self.changeCharaPanel:Find("charaScroll/Viewport/Content"):GetChild(iter_111_0):Find("select"), iter_111_0 == arg_110_1)
				end

				return
			end, SFX_PANEL)
		end

		return
	end)
	var_107_0:align(#self.ships)

	self.charaSetModel = IslandShopPage.CharaSetModel.current

	onButton(self, self.changeCharaPanel:Find("defaultSet"), function()
		if self.charaSetModel == IslandShopPage.CharaSetModel.current then
			self.charaSetModel = IslandShopPage.CharaSetModel.default

			for iter_112_0 = 0, self.changeCharaPanel:Find("charaScroll/Viewport/Content").childCount - 1 do
				setActive(self.changeCharaPanel:Find("charaScroll/Viewport/Content"):GetChild(iter_112_0):Find("select"), self.ships[iter_112_0 + 1].id == self.defaultShipId)
			end
		elseif self.charaSetModel == IslandShopPage.CharaSetModel.default then
			self.charaSetModel = IslandShopPage.CharaSetModel.current

			for iter_112_1 = 0, self.changeCharaPanel:Find("charaScroll/Viewport/Content").childCount - 1 do
				setActive(self.changeCharaPanel:Find("charaScroll/Viewport/Content"):GetChild(iter_112_1):Find("select"), self.ships[iter_112_1 + 1].id == self.selectShipId)
			end
		end

		setActive(self.changeCharaPanel:Find("defaultSet/off"), self.charaSetModel == IslandShopPage.CharaSetModel.current)
		setActive(self.changeCharaPanel:Find("defaultSet/on"), self.charaSetModel == IslandShopPage.CharaSetModel.default)

		return
	end, SFX_PANEL)

	return
end

function IslandShopPage:AddListeners()
	self:AddListener(GAME.ISLAND_SHOP_OP_DONE, self.UpdateView)
	self:AddListener(ISLAND_EX_EVT.SWITCH_MAP_BY_POINT, self.OnSwitchMapByPoint)
	self:AddListener(ActivityProxy.ACTIVITY_UPDATED, self.UpdateActivity)
	self:AddListener(GAME.ACTIVITY_DRAW_AWARD_OPERATION_DONE, self.DrawOperation)
	self:AddListener(GAME.ISLAND_EXCHANGE_ITEM_DONE, self.OnExchangeDone)

	return
end

function IslandShopPage:RemoveListeners()
	self:RemoveListener(GAME.ISLAND_SHOP_OP_DONE, self.UpdateView)
	self:RemoveListener(ISLAND_EX_EVT.SWITCH_MAP_BY_POINT, self.OnSwitchMapByPoint)
	self:RemoveListener(ActivityProxy.ACTIVITY_UPDATED, self.UpdateActivity)
	self:RemoveListener(GAME.ACTIVITY_DRAW_AWARD_OPERATION_DONE, self.DrawOperation)
	self:RemoveListener(GAME.ISLAND_EXCHANGE_ITEM_DONE, self.OnExchangeDone)

	return
end

function IslandShopPage:UpdateView(arg_115_1)
	if arg_115_1.operation == IslandConst.SHOP_GET_DATA then
		if arg_115_1.refreshAll then
			self:UpdateData()
			self:SetShopList()
		else
			self:SetShopPage()
		end
	elseif arg_115_1.operation == IslandConst.SHOP_BUY_COMMODITY then
		self.shoppingCartCommodities = {}

		self:SetShopPage()

		if self.myIslandShoppingCartLayer then
			self.myIslandShoppingCartLayer:Hide()
		end

		self:OpenPage(IslandShopBuySuccessLayer, arg_115_1.awards, function()
			if self.showingShop:GetShowType() == IslandConst.SHOP_TYPE_SKIN then
				self:ShowMsgBox({
					type = IslandMsgBox.TYPE_COMMON,
					content = i18n("island_3Dshop_clothes_jump"),
					onYes = function()
						self:ClearCharacterScene(function()
							self:Hide()

							local var_118_0 = self.showingShop:GetCommanderOrCharaType()

							if var_118_0 == 0 then
								self:OpenScenePage(IslandShipIslandCommanderMainPage)
							elseif var_118_0 == 1 or var_118_0 == 2 then
								self:OpenScenePage(IslandShipMainPage, 3)
							end

							return
						end)

						return
					end
				})
			end

			return
		end)

		if self.myIslandShopItemLayer then
			self.myIslandShopItemLayer:Refresh()
		end
	elseif arg_115_1.operation == IslandConst.REFRESH_SHOP_BY_PLAYER then
		self:SetShopPage()
	end

	return
end

function IslandShopPage:OnSwitchMapByPoint()
	setActive(self._tf, true)
	self:PrepareCharacterScene()

	return
end

function IslandShopPage:UpdateActivity(arg_120_1)
	if arg_120_1:getConfig("type") == ActivityConst.ACTIVITY_TYPE_ISLAND_DRAW_AWARD then
		self.drawAwardActivity = arg_120_1

		self.drawAwardPage:ActionInvoke("UpdateActivity", self.drawAwardActivity)
		self:SetResources()
	end

	return
end

function IslandShopPage:DrawOperation(arg_121_1)
	self.drawAwardPage:ActionInvoke("DrawOperation", arg_121_1)

	return
end

function IslandShopPage:Preload(arg_122_1)
	arg_122_1()

	return
end

function IslandShopPage:GetSmoothRotateObject()
	return self._tf:Find("adapt/model")
end

function IslandShopPage:LoadFurniture(arg_124_1, arg_124_2)
	self:UnloadCharacter()

	if self.isLoadingModel then
		return
	end

	self.isLoadingModel = true

	table.insert(self.loadingIdList or {}, (IslandAssetLoadDispatcher.Instance:Enqueue(arg_124_1, "", typeof(GameObject), UnityEngine.Events.UnityAction_UnityEngine_Object(function(arg_125_0)
		self.role = Object.Instantiate(arg_125_0)

		local var_125_0 = GameObject.New(self.role.name)

		setParent(self.role, var_125_0.transform, false)

		self.role = var_125_0
		self.isLoadingModel = false

		pg.ViewUtils.SetLayer(self.role.transform, Layer.Character3D)
		setParent(self.role, self.roleContainer)

		self.role.transform.localPosition = Vector3(arg_124_2[1][1], arg_124_2[1][2], 0)
		self.role.transform.localEulerAngles = Vector3(0, arg_124_2[2], 0)
		self.role.transform.localScale = Vector3(arg_124_2[3], arg_124_2[3], arg_124_2[3])

		local var_125_1 = GetOrAddComponent(self:GetSmoothRotateObject(), typeof(SmoothRotateObject))

		var_125_1:SetUp(self.role.transform)

		var_125_1.rotationSpeed = pg.island_set.character_detail_camera_speed.key_value_int

		return
	end), true, true)))

	return
end

function IslandShopPage:LoadCharacter(arg_126_1, arg_126_2)
	self:UnloadCharacter()

	if self.isLoadingModel then
		return
	end

	self.isLoadingModel = true

	self.islandShipDressHelper:SetShipId(self.showingShipId)

	self.isCommander = arg_126_2
	self.modelData = arg_126_1

	local function var_126_0(arg_127_0)
		self.role = arg_127_0
		self.isLoadingModel = false

		pg.ViewUtils.SetLayer(self.role.transform, Layer.Character3D)
		setParent(self.role, self.roleContainer)

		self.role.transform.localPosition = Vector3((self._tf.rect.width / self._tf.rect.height < 1.7777777777777777 or nil) and 2.7 - 0.5 * (1.7777777777777777 - self._tf.rect.width / self._tf.rect.height) / 0.4444444444444444, 0, 0)
		self.role.transform.localEulerAngles = Vector3(0, -155, 0)

		local var_127_1 = GetOrAddComponent(self:GetSmoothRotateObject(), typeof(SmoothRotateObject))

		var_127_1:SetUp(self.role.transform)

		var_127_1.rotationSpeed = pg.island_set.character_detail_camera_speed.key_value_int

		self.displayUnit:OnAttach(arg_127_0, self.toolContainer)

		local var_127_2 = self.modelData and self.modelData.personal_ani

		if var_127_2 and var_127_2 ~= "" then
			local var_127_3 = GetOrAddComponent(self.role.transform:GetChild(0), typeof(Animator))

			for iter_127_0 = 1, var_127_3.layerCount do
				var_127_3:CrossFadeInFixedTime(var_127_2, 0, iter_127_0 - 1)
			end
		end

		self.islandShipDressHelper:OnRoleLoaded(self.role.transform, self.modelData)

		return
	end

	if self.isCommander then
		self:GetPoolMgr():GetCommanderModel(arg_126_1, function(arg_128_0)
			var_126_0(arg_128_0)

			return
		end)
	else
		self:GetPoolMgr():GetCharacter(arg_126_1.model, arg_126_1.animator, function(arg_129_0)
			var_126_0(arg_129_0)

			return
		end)
	end

	return
end

function IslandShopPage:UnloadCharacter()
	self.islandShipDressHelper:InvalidateRole()
	self.islandShipDressHelper:Destroy()

	if self.role then
		self.displayUnit:OnDetach()
		pg.ViewUtils.SetLayer(self.role.transform, Layer.Default)

		if self.isCommander then
			self:GetPoolMgr():ReturnCommanderModel(self.role)
		elseif self.modelData then
			self:GetPoolMgr():ReturnCharacter(self.modelData.model, self.modelData.animator, self.role)

			self.modelData = nil
		end

		self.role = nil
	end

	self.modelData = nil

	return
end

function IslandShopPage:BindExchangeTab(arg_131_1, arg_131_2)
	setText(arg_131_1:Find("shop1Tg/name"), pg.island_exchange_group[self.exchangeShowIds[arg_131_2 - self.exchangeTabStartIdx + 1]].text[1])
	setText(arg_131_1:Find("shop1Tg/name/en"), pg.island_exchange_group[self.exchangeShowIds[arg_131_2 - self.exchangeTabStartIdx + 1]].text[2])
	GetImageSpriteFromAtlasAsync("island/islandshopicon", pg.island_exchange_group[self.exchangeShowIds[arg_131_2 - self.exchangeTabStartIdx + 1]].text[3], arg_131_1:Find("shop1Tg/selected/icon"))
	setActive(arg_131_1:Find("shop2List"), false)
	onToggle(self, arg_131_1:Find("shop1Tg"), function(arg_132_0)
		setActive(self.bg, not arg_132_0)
		setActive(arg_131_1:Find("shop2List"), arg_132_0)
		self:SetResourcesVisible(not arg_132_0)

		if arg_132_0 then
			if self.currentShop1TgIndex == arg_131_2 then
				return
			end

			self.currentShop1TgIndex = arg_131_2

			arg_131_1:GetComponent(typeof(Animation)):Play("anim_IslandShopUI_Shop1List_Selected")
			triggerToggle(arg_131_1:Find("shop2List"):GetChild(0), true)
			setText(self.title:Find("Text"), i18n("island_exchange_title"))
			setText(self.title:Find("Text/en"), i18n("island_exchange_title_en"))
			self:SetShopPageVisible(false)
			setActive(self.shop3, false)
			setActive(self.shop32, false)
			self.exchangSubView:ExecuteAction("Show")
		else
			self.exchangSubView:ExecuteAction("Hide")
		end

		return
	end, SFX_PANEL)

	local var_131_0 = pg.island_exchange_group[self.exchangeShowIds[arg_131_2 - self.exchangeTabStartIdx + 1]].exchange_group

	UIItemList.StaticAlign(arg_131_1:Find("shop2List"), arg_131_1:Find("shop2List/shop2Tpl"), #pg.island_exchange_group[self.exchangeShowIds[arg_131_2 - self.exchangeTabStartIdx + 1]].exchange_group, function(arg_133_0, arg_133_1, arg_133_2)
		if arg_133_0 == UIItemList.EventUpdate then
			local var_133_0 = var_131_0[arg_133_1 + 1][2]

			setText(arg_133_2:Find("name"), var_131_0[arg_133_1 + 1][1])
			setText(arg_133_2:Find("selected/name"), var_131_0[arg_133_1 + 1][1])
			onToggle(self, arg_133_2, function(arg_134_0)
				if arg_134_0 then
					arg_133_2:GetComponent(typeof(Animation)):Play("anim_IslandShopUI_Shop2List_Selected")
					self.exchangSubView:ExecuteAction("FlushGroup", var_133_0)
				end

				return
			end, SFX_PANEL)
		end

		return
	end)

	return
end

function IslandShopPage:OnExchangeDone()
	self.exchangSubView:ExecuteAction("FlushGroup")

	return
end

function IslandShopPage:OnShow(arg_136_1, arg_136_2, arg_136_3)
	self:OverlayPanel(self._tf)

	self.showTypes = arg_136_1
	self.firstShopIds = arg_136_2
	self.showDrawAward = arg_136_3 == 1
	self.drawAwardActivity = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_ISLAND_DRAW_AWARD)

	self:DoUpdateShops()
	self:UpdateData()
	self:SetShopList()

	return
end

function IslandShopPage:OnHide()
	self:UnOverlayPanel(self._tf)

	if self.timer then
		self.timer:Stop()

		self.timer = nil
	end

	self:ResetCommanderDressPreview(false)

	self.shoppingCartCommodities = {}
	self.showingCommodity = nil

	self.islandShipDressHelper:Destroy()
	self:UnloadCharacter()
	self.drawAwardPage:Destroy()
	self.drawAwardPage:Reset()
	self.exchangSubView:ExecuteAction("Hide")

	for iter_137_0, iter_137_1 in ipairs(self.loadingIdList or {}) do
		IslandAssetLoadDispatcher.Instance:Cancel(iter_137_1)
	end

	self.loadingIdList = {}

	return
end

function IslandShopPage:OnDisable()
	self:OnHide()
	IslandShopPage.super.OnDisable(self)

	return
end

function IslandShopPage:OnDestroy()
	self:OnHide()

	if self.exchangSubView then
		self.exchangSubView:Destroy()

		self.exchangSubView = nil
	end

	IslandShopPage.super.OnDestroy(self)

	return
end

function IslandShopPage:CanEsc()
	if self.morphing then
		return false
	end

	return true
end

function IslandShopPage:StaticUpdateCommodityTpl(arg_141_1)
	local var_141_0 = arg_141_1:GetMaxNum() - arg_141_1.purchasedNum

	setText(self:Find("name"), arg_141_1:GetName())

	if #arg_141_1:GetItems() == 1 and arg_141_1:GetItems()[1][1] ~= DROP_TYPE_ISLAND_FURNITURE and arg_141_1:GetItems()[1][1] ~= DROP_TYPE_ISLAND_DRESS and arg_141_1:GetItems()[1][1] ~= DROP_TYPE_ISLAND_SKIN then
		local var_141_1 = arg_141_1:GetItems()[1]

		updateCustomDrop(self:Find("IslandItemTpl"), {
			type = var_141_1[1],
			id = var_141_1[2],
			count = var_141_1[3]
		}, {
			style = "island"
		})
	else
		GetImageSpriteFromAtlasAsync(arg_141_1:GetIcon(), "", self:Find("IslandItemTpl/icon_bg/icon"))
	end

	setActive(self:Find("IslandItemTpl/icon_bg/count_bg"), arg_141_1:IsShowPurchaseLimit())
	setText(self:Find("IslandItemTpl/icon_bg/count_bg/count"), var_141_0 .. "/" .. arg_141_1:GetMaxNum())

	local var_141_2 = arg_141_1:GetResourceConsume()

	GetImageSpriteFromAtlasAsync(Drop.New({
		type = var_141_2[1],
		id = var_141_2[2]
	}):getIcon(), "", self:Find("cost/icon"))
	setText(self:Find("cost/num"), math.ceil((100 - arg_141_1:GetDiscount()) / 100 * var_141_2[3]))

	local var_141_3 = arg_141_1:GetTag()

	setActive(self:Find("tags/timeLimit"), var_141_3 == IslandCommodity.TAG.TIME)
	setActive(self:Find("tags/new"), var_141_3 == IslandCommodity.TAG.NEW)
	setActive(self:Find("tags/hot"), var_141_3 == IslandCommodity.TAG.HOT)
	setActive(self:Find("discount"), arg_141_1:GetDiscount() ~= 0)
	setText(self:Find("discount/Text"), "-" .. arg_141_1:GetDiscount() .. "%")
	setActive(self:Find("have"), arg_141_1:IsShowHave())
	setText(self:Find("have"), i18n("island_3Dshop_have") .. Drop.New({
		count = 1,
		type = arg_141_1:GetItems()[1][1],
		id = arg_141_1:GetItems()[1][2]
	}):getOwnedCount())
	setActive(self:Find("hold"), arg_141_1:IsShowHold() and (arg_141_1:IsCharacterInviteItemHold() or underscore.all(arg_141_1:GetItems(), function(arg_142_0)
		return Drop.New({
			count = 1,
			type = arg_142_0[1],
			id = arg_142_0[2]
		}):getOwnedCount() > 0
	end)))
	setActive(self:Find("sellOut"), arg_141_1:GetMaxNum() ~= 0 and var_141_0 == 0 and not isActive(self:Find("hold")))
	setActive(self:Find("cost"), not isActive(self:Find("sellOut")) and not isActive(self:Find("hold")))
	setActive(self:Find("select"), false)
	setText(self:Find("sellOut/Text"), i18n("common_sale_out"))
	setText(self:Find("hold/Text"), i18n("common_already owned"))

	return
end

function IslandShopPage:SortShopCommodities()
	table.sort(self, CompareFuncs({
		function(arg_144_0)
			if arg_144_0:GetMaxNum() ~= 0 and arg_144_0:GetMaxNum() - arg_144_0.purchasedNum == 0 then
				return 3
			end

			if arg_144_0:IsShowHold() then
				if arg_144_0:IsCharacterInviteItemHold() then
					return 2
				else
					return underscore.all(arg_144_0:GetItems(), function(arg_145_0)
						return Drop.New({
							count = 1,
							type = arg_145_0[1],
							id = arg_145_0[2]
						}):getOwnedCount() > 0
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

return IslandShopPage
