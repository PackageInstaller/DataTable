local IslandSeasonShopPanel = class("IslandSeasonShopPanel", import("view.base.BaseSubView"))

function IslandSeasonShopPanel:getUIName()
	return "IslandSeasonShopPanel"
end

function IslandSeasonShopPanel:OnLoaded()
	local var_2_0 = self._tf:Find("content")

	self.lockTF = var_2_0:Find("view/lock")

	setText(var_2_0:Find("view/content/tpl/sellOut/Text"), i18n("common_sale_out"))

	self.resCntTxt = var_2_0:Find("res/Text"):GetComponent(typeof(Text))
	self.goodUIList = UIItemList.New(var_2_0:Find("view/content"), var_2_0:Find("view/content/tpl"))

	local var_2_1 = var_2_0:Find("toggles")

	self.togglesUIList = UIItemList.New(var_2_1, var_2_1:Find("tpl"))

	return
end

function IslandSeasonShopPanel:OnInit()
	self.shopIds = self.contextData.season:getConfig("shop_id")

	self.togglesUIList:make(function(arg_4_0, arg_4_1, arg_4_2)
		if arg_4_0 == UIItemList.EventInit then
			local function var_4_0()
				setActive(arg_4_2:Find("red"), IslandSeasonRedDotHelper.TipShopShowPhase(arg_4_1 + 1))

				return
			end

			arg_4_2.name = arg_4_1 + 1

			setText(arg_4_2:Find("unsel/Text"), i18n("island_season_shop_stage" .. arg_4_1 + 1))
			setText(arg_4_2:Find("sel/Text"), i18n("island_season_shop_stage" .. arg_4_1 + 1))
			onToggle(self, arg_4_2, function(arg_6_0)
				if arg_6_0 then
					self.showPhase = arg_4_1 + 1

					self:Flush()
					var_4_0()
				end

				return
			end, SFX_PANEL)
			var_4_0()
		end

		return
	end)
	self.togglesUIList:align(#self.shopIds)
	self.goodUIList:make(function(arg_7_0, arg_7_1, arg_7_2)
		if arg_7_0 == UIItemList.EventUpdate then
			self:UpdateGood(arg_7_1, arg_7_2)
		end

		return
	end)

	return
end

function IslandSeasonShopPanel:Show()
	IslandSeasonShopPanel.super.Show(self)

	self.showPhase = 1

	triggerToggle(self.togglesUIList.container:GetChild(0), true)
	IslandGuideChecker.CheckGuide("ISLAND_GUIDE_18")

	return
end

function IslandSeasonShopPanel:UpdateGood(arg_9_1, arg_9_2)
	local var_9_0 = self.displaysGoods[arg_9_1 + 1]

	arg_9_2.name = self.displaysGoods[arg_9_1 + 1].id

	IslandShopPage.StaticUpdateCommodityTpl(arg_9_2, self.displaysGoods[arg_9_1 + 1])
	setActive(arg_9_2:Find("notInTime"), not self.displayShop:IsInTime())

	if isActive(arg_9_2:Find("sellOut")) or isActive(arg_9_2:Find("hold")) or isActive(arg_9_2:Find("notInTime")) then
		removeOnButton(arg_9_2)
	else
		onButton(self, arg_9_2, function()
			self.contextData.openBuyLayer(self.displayShop.id, var_9_0)

			return
		end, SFX_PANEL)
	end

	return
end

function IslandSeasonShopPanel:Flush()
	self.inventoryAgency = getProxy(IslandProxy):GetIsland():GetInventoryAgency()
	self.shops = getProxy(IslandProxy):GetIsland():GetShopAgency():GetSeasonShops()
	self.displayShop = self.shops[self.shopIds[self.showPhase or 1]]

	IslandSeasonRedDotHelper.UpdateEnterShopPhase(self.showPhase)
	self:emit(IslandSeasonPage.UPDATE_REDDOT, IslandSeasonPage.PAGE_SHOP)

	local var_11_0 = pg.TimeMgr.GetInstance()
	local var_11_1 = self.displayShop:GetExistTime()
	local var_11_2 = var_11_0:inTime(var_11_1)

	setActive(self.lockTF, not var_11_2)

	if not var_11_2 then
		setText(self.lockTF:Find("layout/Text"), var_11_0:DescDateFromConfig(var_11_1[1]) .. "~" .. var_11_0:DescDateFromConfig(var_11_1[2]))
	end

	self.displaysGoods = self.displayShop:GetCommodities()

	IslandShopPage.SortShopCommodities(self.displaysGoods)
	self.goodUIList:align(#self.displaysGoods)
	setActive(self.lockTF, not self.displayShop:IsInTime())

	self.resCntTxt.text = self.inventoryAgency:GetOwnCount(IslandItem.GOLD_ID)

	return
end

function IslandSeasonShopPanel:OnDestroy()
	return
end

return IslandSeasonShopPanel
