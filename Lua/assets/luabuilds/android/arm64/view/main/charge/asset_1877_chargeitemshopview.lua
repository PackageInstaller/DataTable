local ChargeItemShopView = class("ChargeItemShopView", import("...base.BaseSubView"))

function ChargeItemShopView:getUIName()
	return "ChargeItemShopUI"
end

function ChargeItemShopView:OnInit()
	self:initData()
	self:initUI()
	self:Show()

	return
end

function ChargeItemShopView:OnDestroy()
	self:unBlurView()

	for iter_3_0, iter_3_1 in ipairs(self.cardList) do
		iter_3_1:Dispose()
	end

	return
end

function ChargeItemShopView:initData()
	self.itemGoodsVOList = {}
	self.player = getProxy(PlayerProxy):getData()
	self.packageSortList = {
		0
	}
	self.selectedPackageType = nil
	self.prevBtn = nil

	self:updateData()

	return
end

function ChargeItemShopView:initUI()
	self.contextTF = self._tf:Find("scroll")
	self.lScrollRect = GetComponent(self.contextTF, "LScrollRect")
	self.scrollContent = self._tf:Find("scroll/content")
	self.scrollRectTF = GetComponent(self.scrollContent, typeof(RectTransform))
	self.layoutGroup = GetComponent(self.scrollContent, typeof(GridLayoutGroup))

	local var_5_0 = math.floor(self.scrollRectTF.rect.width / self.layoutGroup.cellSize.x)
	local var_5_1 = self.scrollRectTF.rect.width % self.layoutGroup.cellSize.x / var_5_0

	if self.scrollRectTF.rect.width % self.layoutGroup.cellSize.x / var_5_0 < 12 then
		var_5_1 = (self.scrollRectTF.rect.width - self.layoutGroup.cellSize.x * (var_5_0 - 1)) / (var_5_0 - 1)
	end

	self.layoutGroup.spacing = Vector2(var_5_1, var_5_1)
	self.layoutGroup.padding.left = var_5_1 / 2
	self.cardTable = {}
	self.cardList = {}

	self:initScrollRect()
	self:initToggleList()
	self:updateToggleList()
	self:updateScrollRect()
	triggerButton(self._tf:Find("toggleGroup"):GetChild(0))
	self:blurView()

	return
end

function ChargeItemShopView:initScrollRect()
	self.cardTable = {}
	self.cardList = {}

	local function var_6_0(arg_7_0)
		local var_7_0 = ChargeGoodsCard.New(arg_7_0)

		table.insert(self.cardList, var_7_0)
		onButton(self, var_7_0.tf, function()
			if var_7_0.goodsVO:isLevelLimit(self.player.level) then
				pg.TipsMgr.GetInstance():ShowTips(i18n("charge_level_limit"))

				return
			end

			local var_8_0 = var_7_0.goodsVO:getConfig("effect_args")
			local var_8_1 = {}
			local var_8_2

			if var_8_0 == "ship_bag_size" then
				if self.player:getMaxShipBagExcludeGuild() >= Player.MAX_SHIP_BAG then
					pg.TipsMgr.GetInstance():ShowTips(i18n("charge_ship_bag_max"))

					return
				end

				var_8_1 = {
					count = 1,
					type = DROP_TYPE_ITEM,
					id = Goods.SHIP_BAG_SIZE_ITEM
				}
				var_8_2 = var_8_1.id
			elseif var_8_0 == "equip_bag_size" then
				if self.player:getMaxEquipmentBagExcludeGuild() >= Player.MAX_EQUIP_BAG then
					pg.TipsMgr.GetInstance():ShowTips(i18n("charge_equip_bag_max"))

					return
				end

				var_8_1 = {
					count = 1,
					type = DROP_TYPE_ITEM,
					id = Goods.EQUIP_BAG_SIZE_ITEM
				}
				var_8_2 = var_8_1.id
			elseif var_8_0 == "commander_bag_size" then
				if self.player.commanderBagMax >= Player.MAX_COMMANDER_BAG then
					pg.TipsMgr.GetInstance():ShowTips(i18n("charge_commander_bag_max"))

					return
				end

				var_8_1 = {
					count = 1,
					type = DROP_TYPE_ITEM,
					id = Goods.COMMANDER_BAG_SIZE_ITEM
				}
				var_8_2 = var_8_1.id
			elseif var_8_0 == "spweapon_bag_size" then
				if getProxy(EquipmentProxy):GetSpWeaponCapacity() >= EquipmentProxy.MAX_SPWEAPON_BAG then
					pg.TipsMgr.GetInstance():ShowTips(i18n("charge_equip_bag_max"))

					return
				end

				var_8_1 = {
					count = 1,
					type = DROP_TYPE_ITEM,
					id = Goods.SPWEAPON_BAG_SIZE_ITEM
				}
				var_8_2 = var_8_1.id
			else
				var_8_1 = {
					id = var_7_0.goodsVO:getConfig("effect_args")[1],
					type = var_7_0.goodsVO:getConfig("type"),
					count = var_7_0.goodsVO:getConfig("num")
				}
				var_8_2 = var_7_0.goodsVO:getConfig("type") == DROP_TYPE_RESOURCE and id2ItemId(var_8_1.id) or var_8_1.id
			end

			local var_8_3 = var_7_0.goodsVO:IsGroupSale() and i18n("gem_shop_xinzhi_tip", (ChargeConst.getGroupLimit(self.normalGroupList, var_7_0.goodsVO:getConfig("group")))) or ""

			pg.MsgboxMgr.GetInstance():ShowMsgBox({
				yesText = "text_buy",
				type = MSGBOX_TYPE_SINGLE_ITEM,
				drop = var_8_1,
				subIntro = var_8_3,
				onYes = function()
					if var_8_2 then
						pg.MsgboxMgr.GetInstance():ShowMsgBox({
							content = i18n("charge_scene_buy_confirm", var_7_0.goodsVO:GetPrice(), (Item.New({
								id = var_8_2
							}):getConfig("name"))),
							onYes = function()
								self:emit(NewShopMainMediator.BUY_ITEM, var_7_0.goodsVO.id, 1)

								return
							end
						})
					end

					return
				end
			})

			return
		end)

		self.cardTable[arg_7_0] = var_7_0

		return
	end

	self.lScrollRect.onInitItem = var_6_0

	function self.lScrollRect.onUpdateItem(arg_11_0, arg_11_1)
		local var_11_0 = self.cardTable[arg_11_1]

		if not self.cardTable[arg_11_1] then
			var_6_0(arg_11_1)

			var_11_0 = self.cardTable[arg_11_1]
		end

		local var_11_1 = self.filterList[arg_11_0 + 1]

		var_11_0:update(self.filterList[arg_11_0 + 1])
		var_11_0:setLevelMask(self.player.level)
		var_11_0:setGroupMask((ChargeConst.getGroupLimit(self.normalGroupList, var_11_1:getConfig("group"))))

		return
	end

	return
end

function ChargeItemShopView:updateScrollRect()
	self.filterList = self:getFilterList()
	self.lScrollRect.enabled = true

	self.lScrollRect:SetTotalCount(#self.filterList, self.lScrollRect.value)

	return
end

function ChargeItemShopView:updateToggleList()
	self.uiToggleList:align(#self.packageSortList)

	return
end

function ChargeItemShopView:initToggleList()
	self.uiToggleList = UIItemList.New(self._tf:Find("toggleGroup"), self._tf:Find("toggleGroup/Toggle"))

	self.uiToggleList:make(function(arg_15_0, arg_15_1, arg_15_2)
		if arg_15_0 == UIItemList.EventInit then
			setText(arg_15_2:Find("selected/Label"), i18n(string.format("shop_package_sort_%s", self.packageSortList[arg_15_1 + 1])))
			setText(arg_15_2:Find("selected/enText"), i18n(string.format("shop_package_sort_en_%s", self.packageSortList[arg_15_1 + 1])))
			setText(arg_15_2:Find("unselected/Label"), i18n(string.format("shop_package_sort_%s", self.packageSortList[arg_15_1 + 1])))
			setActive(arg_15_2:Find("unselected"), true)
			setActive(arg_15_2:Find("selected"), false)
		elseif arg_15_0 == UIItemList.EventUpdate then
			onButton(self, arg_15_2, function()
				if self.selectedPackageType == self.packageSortList[arg_15_1 + 1] then
					return
				end

				setActive(arg_15_2:Find("unselected"), false)
				setActive(arg_15_2:Find("selected"), true)

				if self.prevBtn then
					setActive(self.prevBtn:Find("unselected"), true)
					setActive(self.prevBtn:Find("selected"), false)
				end

				self.prevBtn = arg_15_2
				self.selectedPackageType = self.packageSortList[arg_15_1 + 1]

				self:updateScrollRect()

				return
			end, SFX_PANEL)
		end

		return
	end)

	return
end

function ChargeItemShopView:updateItemGoodsVOList()
	self.itemGoodsVOList = {}
	self.packageSortList = {
		0
	}

	for iter_17_0, iter_17_1 in pairs(pg.shop_template.all) do
		if pg.shop_template[iter_17_1].genre == "gem_shop" then
			local var_17_0, var_17_1, var_17_2 = ChargeConst.getGoodsLimitInfo(iter_17_1)
			local var_17_3 = false

			if pg.shop_template[iter_17_1].effect_args == "ship_bag_size" and var_17_1 and var_17_2 then
				local var_17_4 = self.player:getMaxShipBagExcludeGuild()

				if var_17_1 <= var_17_4 and var_17_4 <= var_17_2 then
					var_17_3 = true
				end
			elseif pg.shop_template[iter_17_1].effect_args == "equip_bag_max" and var_17_1 and var_17_2 then
				local var_17_5 = self.player:getMaxEquipmentBag()

				if var_17_1 <= var_17_5 and var_17_5 <= var_17_2 then
					var_17_3 = true
				end
			elseif pg.shop_template[iter_17_1].effect_args == "commander_bag_size" and var_17_1 and var_17_2 then
				if var_17_1 <= self.player.commanderBagMax and self.player.commanderBagMax <= var_17_2 then
					var_17_3 = true
				end
			else
				var_17_3 = true
			end

			if var_17_3 == true then
				table.insert(self.itemGoodsVOList, (Goods.Create({
					count = 0,
					shop_id = iter_17_1
				}, Goods.TYPE_MILITARY)))
			end
		end
	end

	for iter_17_2 = #self.itemGoodsVOList, 1, -1 do
		if not self.itemGoodsVOList[iter_17_2]:IsShowWhenGroupSale((ChargeConst.getGroupLimit(self.normalGroupList, self.itemGoodsVOList[iter_17_2]:getConfig("group")))) then
			table.remove(self.itemGoodsVOList, iter_17_2)
		end
	end

	for iter_17_3, iter_17_4 in ipairs(self.itemGoodsVOList) do
		if not table.contains(self.packageSortList, pg.shop_template[iter_17_4.id].package_sort_id) then
			table.insert(self.packageSortList, pg.shop_template[iter_17_4.id].package_sort_id)
		end
	end

	table.sort(self.packageSortList, function(arg_18_0, arg_18_1)
		return arg_18_0 < arg_18_1
	end)

	return
end

function ChargeItemShopView:sortItemGoodsVOList()
	table.sort(self.itemGoodsVOList, function(arg_20_0, arg_20_1)
		local var_20_0 = arg_20_0:isLevelLimit(self.player.level) and 1 or 0
		local var_20_1 = arg_20_1:isLevelLimit(self.player.level) and 1 or 0
		local var_20_2 = arg_20_0:getConfig("order")
		local var_20_3 = arg_20_1:getConfig("order")

		if var_20_2 == var_20_3 then
			if var_20_0 == var_20_1 then
				return arg_20_0.id > arg_20_1.id
			end

			return var_20_0 < var_20_1
		else
			return var_20_2 < var_20_3
		end

		return
	end)

	return
end

function ChargeItemShopView:getFilterList()
	if self.selectedPackageType == 0 then
		return self.itemGoodsVOList
	end

	local var_21_0 = {}

	for iter_21_0, iter_21_1 in ipairs(self.itemGoodsVOList) do
		if iter_21_1:getConfig("package_sort_id") == self.selectedPackageType then
			table.insert(var_21_0, iter_21_1)
		end
	end

	return var_21_0
end

function ChargeItemShopView:updateGoodsData()
	self.firstChargeIds = self.contextData.firstChargeIds
	self.chargedList = self.contextData.chargedList
	self.normalList = self.contextData.normalList
	self.normalGroupList = self.contextData.normalGroupList

	return
end

function ChargeItemShopView:setGoodData(arg_23_1, arg_23_2, arg_23_3, arg_23_4)
	self.firstChargeIds = arg_23_1
	self.chargedList = arg_23_2
	self.normalList = arg_23_3
	self.normalGroupList = arg_23_4

	return
end

function ChargeItemShopView:updateData()
	self.player = getProxy(PlayerProxy):getData()

	self:updateItemGoodsVOList()
	self:sortItemGoodsVOList()

	return
end

function ChargeItemShopView:blurView()
	self:OverlayPanel(self._tf, {
		pbList = {
			self._tf:Find("bg")
		}
	})

	return
end

function ChargeItemShopView:unBlurView()
	self:UnOverlayPanel(self._tf, self._parentTf)

	return
end

function ChargeItemShopView:IsSupplyShop()
	return false
end

function ChargeItemShopView:reUpdateAll()
	self:updateData()
	self:updateScrollRect()

	return
end

function ChargeItemShopView:ShowPanel(arg_29_1)
	setActive(self._go, arg_29_1)

	return
end

return ChargeItemShopView
