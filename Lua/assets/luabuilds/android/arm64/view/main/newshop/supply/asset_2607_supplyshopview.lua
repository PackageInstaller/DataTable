local SupplyShopView = class("SupplyShopView", import("view.base.BaseSubView"))

function SupplyShopView:Ctor(arg_1_1, arg_1_2, arg_1_3, arg_1_4)
	SupplyShopView.super.Ctor(self, arg_1_1, arg_1_2, arg_1_3)

	self.supplyShopType = arg_1_4

	return
end

function SupplyShopView:getUIName()
	return "ShopSupplyShopUI"
end

function SupplyShopView:OnInit()
	self:initData()
	self:initUI()

	self.prevBtn = nil
	self.pages = {
		[ShopConst.TYPE_ACTIVITY] = ActivityShopPage.New(self, self._go),
		[ShopConst.TYPE_SHOP_STREET] = StreetShopPage.New(self, self._go),
		[ShopConst.TYPE_MILITARY_SHOP] = MilitaryShopPage.New(self, self._go),
		[ShopConst.TYPE_GUILD] = GuildShopPage.New(self, self._go),
		[ShopConst.TYPE_SHAM_SHOP] = ShamShopPage.New(self, self._go),
		[ShopConst.TYPE_FRAGMENT] = FragmentShopPage.New(self, self._go),
		[ShopConst.TYPE_META] = MetaShopPage.New(self, self._go),
		[ShopConst.TYPE_MEDAL] = MedalShopPage.New(self, self._go),
		[ShopConst.TYPE_QUOTA] = QuotaShopPage.New(self, self._go),
		[ShopConst.TYPE_MINI_GAME] = MiniGameShopPage.New(self, self._go)
	}
	self.shopResItemList = {}
	self.shopResParent = self._tf:Find("bg/resList")
	self.shopResItem = self._tf:Find("bg/resList/res")

	self:blurView()

	return
end

function SupplyShopView:OnDestroy()
	self:unBlurView()

	self.prevBtn = nil

	if self.page then
		self.page:StopBGM()

		self.page = nil
	end

	self:DestroyResItemList()

	for iter_4_0, iter_4_1 in pairs(self.pages) do
		iter_4_1:OnDestroy()
	end

	self.pages = nil

	return
end

function SupplyShopView:initUI()
	self.lScrollRect = GetComponent(self._tf:Find("scroll"), "LScrollRect")
	self.scrollContent = self._tf:Find("scroll/content")
	self.scrollRectTF = GetComponent(self.scrollContent, typeof(RectTransform))
	self.layoutGroup = GetComponent(self.scrollContent, typeof(GridLayoutGroup))
	self.scrollRectSpecial = self._tf:Find("scrollRectSpecial")

	setActive(self.scrollRectSpecial, false)

	local var_5_0 = GetComponent(self.scrollRectSpecial:Find("viewport/view/group/items"), typeof(GridLayoutGroup))
	local var_5_1 = math.floor(self.scrollRectTF.rect.width / self.layoutGroup.cellSize.x)
	local var_5_2 = self.scrollRectTF.rect.width % self.layoutGroup.cellSize.x / var_5_1

	if self.scrollRectTF.rect.width % self.layoutGroup.cellSize.x / var_5_1 < 12 then
		var_5_2 = (self.scrollRectTF.rect.width - self.layoutGroup.cellSize.x * (var_5_1 - 1)) / (var_5_1 - 1)
	end

	self.layoutGroup.spacing = Vector2(var_5_2, var_5_2)
	self.layoutGroup.padding.left = var_5_2 / 2
	var_5_0.spacing = Vector2(var_5_2, var_5_2)
	var_5_0.padding.left = var_5_2 / 2

	return
end

function SupplyShopView:initData()
	self.player = getProxy(PlayerProxy):getData()

	return
end

function SupplyShopView:SetAllShopData(arg_7_1)
	self.allShopList = arg_7_1
	self.packageSortList = {}

	local var_7_0 = 0

	for iter_7_0, iter_7_1 in ipairs(ShopConst.SUPPLY_SHOP_LIST[self.supplyShopType]) do
		for iter_7_2, iter_7_3 in ipairs(self.allShopList[iter_7_1] or {}) do
			var_7_0 = var_7_0 + 1

			table.insert(self.packageSortList, {
				type = iter_7_1,
				index = var_7_0,
				shopData = iter_7_3
			})
		end
	end

	self.selectedPackageType = nil

	self:updateData()
	self:initToggleList()
	self:updateToggleList()
	triggerButton(self._tf:Find("toggleGroup"):GetChild(self.packageSortList[self:GetDefaultShopIndex()].index - 1))
	self:UpdateShop()

	return
end

function SupplyShopView:GetDefaultShopIndex()
	if self.supplyShopType == ShopConst.CATEGORY_ACTIVITY then
		for iter_8_0, iter_8_1 in ipairs(self.packageSortList) do
			if iter_8_1.shopData.activityId == self.contextData.actId then
				return iter_8_1.index
			end
		end
	else
		for iter_8_2, iter_8_3 in pairs(self.packageSortList) do
			if iter_8_3.type == self.contextData.shopID then
				local var_8_1, var_8_2 = self.pages[iter_8_3.type]:CanOpen(self.allShopList[self.packageSortList[self.supplyShopType].type][1], self.player)

				if var_8_1 then
					return iter_8_3.index
				end
			end
		end
	end

	for iter_8_4, iter_8_5 in pairs(self.packageSortList) do
		local var_8_3, var_8_4 = self.pages[iter_8_5.type]:CanOpen(self.allShopList[iter_8_5.type][1], self.player)

		if var_8_3 then
			return iter_8_5.index
		end
	end

	return 1
end

function SupplyShopView:updateToggleList()
	self.uiToggleList:align(#self.packageSortList)

	return
end

function SupplyShopView:initToggleList()
	self.uiToggleList = UIItemList.New(self._tf:Find("toggleGroup"), (self._tf:Find("toggleGroup/Toggle")))

	self.uiToggleList:make(function(arg_11_0, arg_11_1, arg_11_2)
		if arg_11_0 == UIItemList.EventInit then
			local var_11_0 = self.packageSortList[arg_11_1 + 1].type

			if self.packageSortList[arg_11_1 + 1].type == ShopConst.TYPE_ACTIVITY then
				if pg.activity_template[self.packageSortList[arg_11_1 + 1].shopData.activityId] and pg.activity_template[self.packageSortList[arg_11_1 + 1].shopData.activityId].config_client then
					local var_11_2

					if not pg.activity_template[self.packageSortList[arg_11_1 + 1].shopData.activityId].config_client.shop_title then
						var_11_2 = i18n(nil) or i18n(ShopConst.TYPE2NAME[var_11_0])
					end
				end

				setText(arg_11_2:Find("selected/Label"), var_11_2)
			else
				setText(arg_11_2:Find("selected/Label"), i18n(ShopConst.TYPE2NAME[var_11_0]))
			end

			setText(arg_11_2:Find("selected/enText"), i18n(ShopConst.TYPE2NAME[var_11_0] .. "en"))
			setText(arg_11_2:Find("unselected/Label"), i18n(ShopConst.TYPE2NAME[var_11_0]))

			local var_11_4, var_11_5 = self.pages[var_11_0]:CanOpen(self.allShopList[var_11_0][1], self.player)

			if var_11_4 == false then
				setActive(arg_11_2:Find("unselected/Label/lock"), true)
			else
				setActive(arg_11_2:Find("unselected/Label/lock"), false)
			end

			setActive(arg_11_2:Find("unselected"), true)
			setActive(arg_11_2:Find("selected"), false)
		elseif arg_11_0 == UIItemList.EventUpdate then
			onButton(self, arg_11_2, function()
				if self.selectedPackageType == self.packageSortList[arg_11_1 + 1].index then
					return
				end

				local var_12_0 = self.packageSortList[arg_11_1 + 1].type
				local var_12_1, var_12_2 = self.pages[self.packageSortList[arg_11_1 + 1].type]:CanOpen(self.allShopList[self.packageSortList[arg_11_1 + 1].type][1], self.player)

				if var_12_1 == false then
					pg.TipsMgr.GetInstance():ShowTips(var_12_2)

					return
				end

				setActive(arg_11_2:Find("unselected"), false)
				setActive(arg_11_2:Find("selected"), true)

				if self.prevBtn then
					setActive(self.prevBtn:Find("unselected"), true)
					setActive(self.prevBtn:Find("selected"), false)
				end

				self.prevBtn = arg_11_2
				self.selectedPackageType = self.packageSortList[arg_11_1 + 1].index
				self.contextData.shopID = var_12_0

				self:UpdateShop()

				return
			end, SFX_PANEL)
		end

		return
	end)

	return
end

function SupplyShopView:updateGoodsData()
	self.firstChargeIds = self.contextData.firstChargeIds
	self.chargedList = self.contextData.chargedList
	self.normalList = self.contextData.normalList
	self.normalGroupList = self.contextData.normalGroupList

	return
end

function SupplyShopView:setGoodData(arg_14_1, arg_14_2, arg_14_3, arg_14_4)
	self.firstChargeIds = arg_14_1
	self.chargedList = arg_14_2
	self.normalList = arg_14_3
	self.normalGroupList = arg_14_4

	return
end

function SupplyShopView:updateData()
	self.player = getProxy(PlayerProxy):getData()

	return
end

function SupplyShopView:RefreshResItemList(arg_16_1)
	for iter_16_0, iter_16_1 in ipairs(arg_16_1) do
		self.shopResItemList[iter_16_0] = self.shopResItemList[iter_16_0] or ShopResItem.New(go(self.shopResItem), self.shopResParent)

		self.shopResItemList[iter_16_0]:SetData(iter_16_1.type, iter_16_1.resID, iter_16_1.cnt)
	end

	for iter_16_2 = #arg_16_1 + 1, #self.shopResItemList do
		self.shopResItemList[iter_16_2]:Show(false)
	end

	return
end

function SupplyShopView:DestroyResItemList()
	for iter_17_0, iter_17_1 in ipairs(self.shopResItemList or {}) do
		iter_17_1:Dispose()
	end

	self.shopResItemList = nil

	return
end

function SupplyShopView:IsSupplyShop()
	return true
end

function SupplyShopView:SetPlayer(arg_19_1)
	self.player = arg_19_1

	self.page:SetPlayer(arg_19_1)

	return
end

function SupplyShopView:reUpdateAll()
	self:updateData()

	return
end

function SupplyShopView:OnUpdateItems(arg_21_1)
	self.items = arg_21_1

	if self.packageSortList then
		self.pages[self.packageSortList[self.selectedPackageType].type]:SetItems(arg_21_1)
	end

	return
end

function SupplyShopView:OnUpdateShop(arg_22_1, arg_22_2)
	if self.page == self.pages[arg_22_1] then
		self.page:UpdateShop(arg_22_2)
	end

	for iter_22_0, iter_22_1 in ipairs(self.packageSortList) do
		if iter_22_1.shopData:IsSameKind(arg_22_2) then
			iter_22_1.shopData = arg_22_2

			break
		end
	end

	return
end

function SupplyShopView:OnUpdateCommodity(arg_23_1, arg_23_2, arg_23_3)
	for iter_23_0, iter_23_1 in ipairs(self.packageSortList) do
		if iter_23_1.shopData:IsSameKind(arg_23_2) then
			iter_23_1.shopData = arg_23_2

			if self.page == self.pages[arg_23_1] then
				self.page:UpdateCommodity(arg_23_2, arg_23_3)
			end

			break
		end
	end

	return
end

function SupplyShopView:OnFragmentSellUpdate()
	if self.page == self.pages[ShopConst.TYPE_FRAGMENT] then
		self.page:OnFragmentSellUpdate()
	end

	return
end

function SupplyShopView:UpdateShop()
	local var_25_0, var_25_1 = self.pages[self.packageSortList[self.selectedPackageType].type]:CanOpen(self.packageSortList[self.selectedPackageType].shopData, self.player)

	if var_25_0 then
		if self.page and self.page ~= self.pages[self.packageSortList[self.selectedPackageType].type] then
			self.page:Hide()
		end

		self.pages[self.packageSortList[self.selectedPackageType].type]:SetUp(self.packageSortList[self.selectedPackageType].shopData, self.player, self.items)

		self.page = self.pages[self.packageSortList[self.selectedPackageType].type]
	else
		pg.TipsMgr.GetInstance():ShowTips(var_25_1)
	end

	return
end

function SupplyShopView:ShowPanel(arg_26_1)
	if self._go then
		setActive(self._go, arg_26_1)
	end

	return
end

function SupplyShopView:blurView()
	self:OverlayPanel(self._tf, {
		pbList = {
			self._tf:Find("bg")
		}
	})

	return
end

function SupplyShopView:unBlurView()
	self:UnOverlayPanel(self._tf, self._parentTf)

	return
end

return SupplyShopView
