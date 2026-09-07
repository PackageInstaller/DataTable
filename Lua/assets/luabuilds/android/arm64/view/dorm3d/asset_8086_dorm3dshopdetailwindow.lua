local Dorm3dShopDetailWindow = class("Dorm3dShopDetailWindow", import("view.base.BaseUI"))

Dorm3dShopDetailWindow.SELECTED_WIDTH = 52
Dorm3dShopDetailWindow.UNSELECTED_WIDTH = 12
Dorm3dShopDetailWindow.LOOP_DURATION = 5

function Dorm3dShopDetailWindow:getUIName()
	return "Dorm3dShopDetailWindow"
end

function Dorm3dShopDetailWindow:init()
	self.previewTf = self._tf:Find("Window/Preview")
	self.bubbleContent = self._tf:Find("Window/Bubbles/content")
	self.bubbleTpl = self._tf:Find("Window/Bubbles/tpl")
	self.bubbleList = UIItemList.New(self.bubbleContent, self.bubbleTpl)
	self.scrollSnap = BannerScrollRect4Dorm.New(self._tf:Find("Window/banner/mask/content"), self._tf:Find("Window/banner/dots"))

	setActive(self.bubbleTpl, false)

	self.minusBtn = self._tf:Find("Window/countList/minusBtn")
	self.addBtn = self._tf:Find("Window/countList/addBtn")
	self.maxBtn = self._tf:Find("Window/countList/maxBtn")
	self.countText = self._tf:Find("Window/countList/count/Text")
	self.shopCfg = self.contextData.shopCfg
	self.unlockTips = pg.dorm3d_gift[self.shopCfg.item_id].unlock_tips or {}

	local var_2_0 = self.shopCfg.room_id

	self.unlockBanners = self.shopCfg.banners

	if self.contextData.groupId ~= 0 then
		var_2_0 = self.contextData.groupId

		local var_2_1 = table.Find(pg.dorm3d_gift[self.shopCfg.item_id].unlock_banners or {}, function(arg_3_0, arg_3_1)
			if arg_3_1[1] == var_2_0 then
				return true
			end

			return
		end)

		self.unlockBanners = var_2_1 and var_2_1[2]
	end

	self.isExclusive = pg.dorm3d_gift[self.shopCfg.item_id].ship_group_id ~= 0
	self.isSpecial = false
	self.addFavor = pg.dorm3d_favor_trigger[pg.dorm3d_gift[self.shopCfg.item_id].favor_trigger_id].num

	setActive(self._tf:Find("Window/Title/gift"), true)

	self.curCount = 1
	self.buyCount = getProxy(ApartmentProxy):GetGiftShopCount(self.shopCfg.item_id)

	return
end

function Dorm3dShopDetailWindow:didEnter()
	onButton(self, self._tf:Find("Window/Cancel"), function()
		self:closeView()

		return
	end, SFX_CANCEL)
	onButton(self, self._tf:Find("Mask"), function()
		self:closeView()

		return
	end)
	self:InitUIList()
	self:InitDropIcon()
	self:InitBanner()

	local var_4_0 = Dorm3dGift.New({
		configId = self.shopCfg.item_id
	})
	local var_4_1 = CommonCommodity.New({
		id = var_4_0:GetShopID()
	}, Goods.TYPE_SHOPSTREET)
	local var_4_2, var_4_3, var_4_4 = var_4_1:GetPrice()
	local var_4_5 = Drop.New({
		type = DROP_TYPE_RESOURCE,
		id = var_4_1:GetResType(),
		count = var_4_2
	})
	local var_4_6 = i18n("dorm3d_shop_buy_tips", "<icon name=" .. var_4_1:GetResIcon() .. " w=1.1 h=1.1/>", "x" .. var_4_5.count, "x" .. var_4_5.count, self.shopCfg.name)
	local var_4_7
	local var_4_8 = 0

	_.each(var_4_0:getConfig("shop_id"), function(arg_7_0)
		if pg.shop_template[arg_7_0].group_type == 2 then
			var_4_8 = math.max(pg.shop_template[arg_7_0].group_limit, var_4_8)
		end

		return
	end)

	if 0 > 0 then
		var_4_7 = {
			self.buyCount,
			0
		}
	end

	if var_4_7 then
		var_4_6 = var_4_6 .. i18n("dorm3d_purchase_weekly_limit", var_4_7[1], var_4_7[2])
	end

	setText(self._tf:Find("Window/Content"), var_4_6)
	setText(self._tf:Find("Window/Confirm/Text"), i18n("msgbox_text_confirm"))
	setText(self._tf:Find("Window/Cancel/Text"), i18n("msgbox_text_cancel"))
	pg.UIMgr.GetInstance():OverlayPanel(self._tf)

	local var_4_9 = var_4_0:GetShopID()

	self.itemList = {
		var_4_9
	}
	self.sumPrice = self:GetGoodPrice(var_4_9)

	setText(self.countText, self.curCount)

	local var_4_10 = 1

	if var_4_7 then
		var_4_10 = var_4_7[2] - var_4_7[1]
	end

	local function var_4_11(arg_8_0)
		arg_8_0 = math.max(arg_8_0, 1)
		arg_8_0 = math.min(arg_8_0, var_4_10)
		self.curCount = arg_8_0

		setText(self.countText, arg_8_0)

		self.sumPrice = 0

		for iter_8_0 = self.buyCount, self.buyCount + self.curCount - 1 do
			self.sumPrice = self.sumPrice + self:GetGoodPrice(self:GetShopId(iter_8_0))
		end

		local var_8_0 = i18n("dorm3d_shop_buy_tips", "<icon name=" .. var_4_1:GetResIcon() .. " w=1.1 h=1.1/>", "x" .. self:GetGoodPrice((self:GetShopId(self.buyCount + self.curCount - 1))), "x" .. self.sumPrice, self.shopCfg.name)

		if var_4_7 then
			var_8_0 = var_8_0 .. i18n("dorm3d_purchase_weekly_limit", var_4_7[1], var_4_7[2])
		end

		setText(self._tf:Find("Window/Content"), var_8_0)
		self.contextData.changeCount(arg_8_0)

		return
	end

	onButton(self, self.minusBtn, function()
		if self.curCount - 1 > 0 then
			table.remove(self.itemList, #self.itemList)
		end

		var_4_11(self.curCount - 1)

		return
	end, SFX_PANEL)
	onButton(self, self.addBtn, function()
		if self.buyCount + self.curCount + 1 <= var_4_8 then
			table.insert(self.itemList, self:GetShopId(self.buyCount + self.curCount))
		end

		var_4_11(self.curCount + 1)

		return
	end, SFX_PANEL)
	onButton(self, self.maxBtn, function()
		self.itemList = {}

		for iter_11_0 = self.buyCount, var_4_8 - 1 do
			table.insert(self.itemList, self:GetShopId(iter_11_0))
		end

		var_4_11(var_4_10)

		return
	end, SFX_PANEL)
	onButton(self, self._tf:Find("Window/Confirm"), function()
		local var_12_0 = getProxy(PlayerProxy):getData()

		if var_12_0[id2res(pg.shop_template[self.itemList[1]].resource_type)] < self.sumPrice then
			if pg.shop_template[self.itemList[1]].resource_type == 1 then
				GoShoppingMsgBox(i18n("switch_to_shop_tip_2", i18n("word_gold")), ChargeScene.TYPE_ITEM, {
					{
						59001,
						self.sumPrice - var_12_0[id2res(pg.shop_template[self.itemList[1]].resource_type)],
						self.sumPrice
					}
				})
			elseif pg.shop_template[self.itemList[1]].resource_type == 4 or pg.shop_template[self.itemList[1]].resource_type == 14 then
				GoShoppingMsgBox(i18n("switch_to_shop_tip_3", i18n("word_gem")), ChargeScene.TYPE_DIAMOND)
			elseif not ItemTipPanel.ShowItemTip(DROP_TYPE_RESOURCE, pg.shop_template[self.itemList[1]].resource_type) then
				pg.TipsMgr.GetInstance():ShowTips(i18n("buyProp_noResource_error", (Drop.New({
					type = DROP_TYPE_RESOURCE,
					id = pg.shop_template[self.itemList[1]].resource_type
				}):getName())))
			end

			self:closeView()

			return
		end

		for iter_12_0, iter_12_1 in ipairs(self.itemList) do
			self:emit(Dorm3dShopDetailMediator.SHOPPING, {
				silentTip = true,
				count = 1,
				shopId = iter_12_1
			})
		end

		self:closeView()

		return
	end, SFX_PANEL)

	return
end

function Dorm3dShopDetailWindow:InitBanner()
	for iter_13_0 = 1, #self.unlockBanners do
		LoadImageSpriteAsync("dorm3dbanner/" .. self.unlockBanners[iter_13_0], (self.scrollSnap:AddChild()))
	end

	self.scrollSnap:SetUp()

	return
end

function Dorm3dShopDetailWindow:InitUIList()
	self.bubbleList:make(function(arg_15_0, arg_15_1, arg_15_2)
		if arg_15_0 == UIItemList.EventInit then
			LoadImageSpriteAtlasAsync("ui/shoptip_atlas", "icon_" .. self.unlockTips[arg_15_1 + 1], arg_15_2:Find("icon/icon"), true)
			setText(arg_15_2:Find("bubble/Text"), i18n("dorm3d_shop_tag" .. self.unlockTips[arg_15_1 + 1]))
			setActive(arg_15_2:Find("bubble"), false)
			onToggle(self, arg_15_2, function(arg_16_0)
				setActive(arg_15_2:Find("icon/select"), arg_16_0)
				setActive(arg_15_2:Find("icon/unselect"), not arg_16_0)
				setActive(arg_15_2:Find("bubble"), arg_16_0)

				return
			end)
		end

		return
	end)
	self.bubbleList:align(#self.unlockTips)

	return
end

function Dorm3dShopDetailWindow:InitDropIcon()
	local var_17_0 = {
		type = DROP_TYPE_DORM3D_GIFT,
		id = self.shopCfg.item_id
	}

	var_17_0.count = getProxy(ApartmentProxy):getGiftCount(self.shopCfg.item_id)

	LoadImageSpriteAtlasAsync(Drop.New(var_17_0):getIcon(), "", self._tf:Find("Window/Item/Dorm3dIconTpl/icon"), true)
	GetImageSpriteFromAtlasAsync("weaponframes", "dorm3d_" .. ItemRarity.Rarity2Print(self.shopCfg.rarity), self._tf:Find("Window/Item/Dorm3dIconTpl"))
	setActive(self._tf:Find("Window/Item/sp"), self.isExclusive or self.isSpecial)

	if self.isSpecial then
		setText(self._tf:Find("Window/Item/sp/Text"), i18n("dorm3d_purchase_label_special"))
	elseif self.isExclusive then
		setText(self._tf:Find("Window/Item/sp/Text"), i18n("dorm3d_purchase_confirm_tip"))
	end

	if self.addFavor then
		setActive(self._tf:Find("Window/Item/gift"), true)
		setText(self._tf:Find("Window/Item/gift/Text"), "+" .. self.addFavor)
	end

	return
end

function Dorm3dShopDetailWindow:GetShopId(arg_18_1)
	for iter_18_0 = 1, #self.shopCfg.shop_id - 1 do
		if not pg.shop_template[self.shopCfg.shop_id[iter_18_0]].limit_args[1] and pg.shop_template[self.shopCfg.shop_id[iter_18_0]].group_type == 0 then
			return self.shopCfg.shop_id[iter_18_0]
		elseif pg.shop_template[self.shopCfg.shop_id[iter_18_0]].limit_args[1] and (pg.shop_template[self.shopCfg.shop_id[iter_18_0]].limit_args[1][1] == "dailycount" or pg.shop_template[self.shopCfg.shop_id[iter_18_0]].limit_args[1][1] == "count") then
			if arg_18_1 < pg.shop_template[self.shopCfg.shop_id[iter_18_0]].limit_args[1][3] then
				return self.shopCfg.shop_id[iter_18_0]
			end
		elseif pg.shop_template[self.shopCfg.shop_id[iter_18_0]].group_type == 2 then
			if arg_18_1 < pg.shop_template[self.shopCfg.shop_id[iter_18_0]].group_limit then
				return self.shopCfg.shop_id[iter_18_0]
			end
		else
			return self.shopCfg.shop_id[iter_18_0]
		end
	end

	return self.shopCfg.shop_id[#self.shopCfg.shop_id] or 0
end

function Dorm3dShopDetailWindow:GetGoodPrice(arg_19_1)
	return (CommonCommodity.New({
		id = arg_19_1
	}, Goods.TYPE_SHOPSTREET):GetPrice())
end

function Dorm3dShopDetailWindow:willExit()
	if self.timerRefreshTime then
		self.timerRefreshTime:Stop()

		self.timerRefreshTime = nil
	end

	self.scrollSnap:Dispose()

	self.scrollSnap = nil

	pg.UIMgr.GetInstance():UnOverlayPanel(self._tf)

	return
end

return Dorm3dShopDetailWindow
