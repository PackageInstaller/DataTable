local BackYardFurnitureMsgBoxPage = class("BackYardFurnitureMsgBoxPage", import("....base.BaseSubView"))

function BackYardFurnitureMsgBoxPage:getUIName()
	return "FurnitureMsgboxPage"
end

function BackYardFurnitureMsgBoxPage:OnLoaded()
	self.nameTxt = self._tf:Find("frame/name"):GetComponent(typeof(Text))
	self.themeTxt = self._tf:Find("frame/theme/Text"):GetComponent(typeof(Text))
	self.descTxt = self._tf:Find("frame/desc"):GetComponent(typeof(Text))
	self.iconContainer = self._tf:Find("frame/icon")
	self.icon = self._tf:Find("frame/icon/Image"):GetComponent(typeof(Image))
	self.playBtn = self._tf:Find("frame/icon/play")
	self.rawIcon = self._tf:Find("frame/icon/rawImage"):GetComponent(typeof(RawImage))
	self.shipTr = self._tf:Find("frame/ship")
	self.shipIcon = self._tf:Find("frame/ship/icon"):GetComponent(typeof(Image))
	self.shipTxt = self._tf:Find("frame/ship/Text"):GetComponent(typeof(Text))
	self.countPanel = self._tf:Find("frame/count")
	self.leftArr = self._tf:Find("frame/count/left_arr")
	self.rightArr = self._tf:Find("frame/count/right_arr")
	self.countTxt = self._tf:Find("frame/count/Text"):GetComponent(typeof(Text))
	self.gemIcon = self._tf:Find("frame/price/gem")
	self.gemCount = self._tf:Find("frame/price/gem_text"):GetComponent(typeof(Text))
	self.goldIcon = self._tf:Find("frame/price/gold")
	self.goldCount = self._tf:Find("frame/price/gold_text"):GetComponent(typeof(Text))
	self.line = self._tf:Find("frame/price/line")
	self.energyIcon = self._tf:Find("frame/energy"):GetComponent(typeof(Image))
	self.energyTxt = self._tf:Find("frame/energy/Text"):GetComponent(typeof(Text))
	self.energyAddition = self._tf:Find("frame/energy/Text/addition"):GetComponent(typeof(Image))
	self.energyAdditionTxt = self._tf:Find("frame/energy/Text/addition/Text"):GetComponent(typeof(Text))
	self.closeBtn = self._tf:Find("frame/close_btn")
	self.btns = self._tf:Find("frame/btns")
	self.goldPurchaseBtn = self._tf:Find("frame/btns/gold_purchase_btn")
	self.gemPurchaseBtn = self._tf:Find("frame/btns/gem_purchase_btn")
	self.goldPurchaseIcon = self._tf:Find("frame/btns/gold_purchase_btn/content/icon")
	self.gemPurchaseIcon = self._tf:Find("frame/btns/gem_purchase_btn/content/icon")
	self.maxCnt = self._tf:Find("frame/max_cnt"):GetComponent(typeof(Text))
	self.maxBtn = self._tf:Find("frame/count/max")
	self.maxBtnTxt = self.maxBtn:Find("Text"):GetComponent(typeof(Text))

	setText(self._tf:Find("frame/price/label"), i18n("backyard_theme_total_print"))
	setActive(self.rawIcon, false)

	return
end

function BackYardFurnitureMsgBoxPage:OnInit()
	local function var_3_0()
		local var_4_0 = {}

		for iter_4_0 = 1, self.count do
			table.insert(var_4_0, self.furniture.id)
		end

		return var_4_0
	end

	onButton(self, self.goldPurchaseBtn, function()
		self:emit(NewBackYardShopMediator.ON_SHOPPING, var_3_0(), PlayerConst.ResDormMoney)
		self:Hide()

		return
	end, SFX_PANEL)
	onButton(self, self.gemPurchaseBtn, function()
		self:emit(NewBackYardShopMediator.ON_SHOPPING, var_3_0(), PlayerConst.ResDiamond)
		self:Hide()

		return
	end, SFX_PANEL)
	onButton(self, self.closeBtn, function()
		self:Hide()

		return
	end, SFX_PANEL)
	onButton(self, self._tf, function()
		self:Hide()

		return
	end, SFX_PANEL)
	onButton(self, self.leftArr, function()
		if self.count <= 1 then
			return
		end

		self.count = self.count - 1

		self:UpdatePrice()

		return
	end, SFX_PANEL)
	onButton(self, self.rightArr, function()
		if self.count == self.maxCount then
			return
		end

		self.count = self.count + 1

		self:UpdatePrice()

		return
	end, SFX_PANEL)
	onButton(self, self.maxBtn, function()
		self.count = self.maxCount

		self:UpdatePrice()

		return
	end, SFX_PANEL)

	return
end

function BackYardFurnitureMsgBoxPage:PlayerUpdated(arg_12_1)
	self.player = arg_12_1

	return
end

function BackYardFurnitureMsgBoxPage:SetUp(arg_13_1, arg_13_2, arg_13_3)
	self.dorm = arg_13_2
	self.furniture = arg_13_1
	self.count = 1
	self.player = arg_13_3
	self.maxCount = arg_13_1:getConfig("count") - arg_13_1.count

	local var_13_0 = self.maxCount > 1

	setActive(self.maxBtn, self.maxCount > 1)
	setAnchoredPosition(self.countPanel, {
		x = var_13_0 and 200 or 258
	})

	self.maxBtnTxt.text = "MAX"

	self:UpdateMainInfo()
	self:UpdateSkinType()
	self:Show()
	setText(self.gemPurchaseBtn:Find("content/Text"), i18n("word_buy"))
	setText(self.goldPurchaseBtn:Find("content/Text"), i18n("word_buy"))
	setActive(self.goldPurchaseIcon, true)
	setActive(self.gemPurchaseIcon, true)

	return
end

function BackYardFurnitureMsgBoxPage:UpdateSkinType()
	local var_14_0 = Goods.FurnitureId2Id(self.furniture.id)
	local var_14_1 = Goods.ExistFurniture(var_14_0)

	setActive(self.shipTr, var_14_1)

	if var_14_1 then
		local var_14_2 = pg.ship_skin_template[Goods.Id2ShipSkinId(Goods.GetFurnitureConfig(var_14_0).id)]

		GetImageSpriteFromAtlasAsync("QIcon/" .. var_14_2.prefab, "", self.shipIcon.gameObject)

		self.shipTxt.text = shortenString(ShipGroup.getDefaultShipConfig(var_14_2.ship_group).name .. "-" .. var_14_2.name, 15)
	end

	return
end

function BackYardFurnitureMsgBoxPage:UpdateMainInfo()
	self.nameTxt.text = HXSet.hxLan(self.furniture:getConfig("name"))
	self.themeTxt.text = self.furniture:GetThemeName()
	self.descTxt.text = HXSet.hxLan(self.furniture:getConfig("describe"))

	self:UpdateIcon()
	self:UpdatePrice()

	local var_15_0 = self.furniture:canPurchaseByDormMoeny()
	local var_15_1 = self.furniture:canPurchaseByGem()

	setActive(self.goldPurchaseBtn, var_15_0)
	setActive(self.gemPurchaseBtn, var_15_1)
	setActive(self.gemIcon, var_15_1)
	setActive(self.gemCount, var_15_1)
	setActive(self.goldIcon, var_15_0)
	setActive(self.goldCount, var_15_0)
	setActive(self.line, var_15_0 and var_15_1)

	local var_15_2 = self.goldPurchaseBtn:GetComponent(typeof(LayoutElement))
	local var_15_3 = self.gemPurchaseBtn:GetComponent(typeof(LayoutElement))

	if var_15_1 and var_15_0 then
		var_15_2.preferredWidth = 239
		var_15_3.preferredWidth = 239
	elseif var_15_1 and not var_15_0 then
		var_15_2.preferredWidth = 0
		var_15_3.preferredWidth = 510
	elseif not var_15_1 and var_15_0 then
		var_15_2.preferredWidth = 510
		var_15_3.preferredWidth = 0
	end

	self.maxCnt.text = ""

	if self.furniture:getConfig("count") > 1 then
		self.maxCnt.text = self.furniture.count .. "/" .. self.furniture:getConfig("count")
	end

	return
end

function BackYardFurnitureMsgBoxPage:UpdateEnergy(arg_16_1)
	local var_16_0 = self.dorm:getComfortable()
	local var_16_1 = self.dorm:getComfortable(arg_16_1) - var_16_0
	local var_16_2 = var_16_1 > 0

	LoadSpriteAtlasAsync("ui/CourtyardUI_atlas", "express_" .. self.dorm:_GetComfortableLevel(), function(arg_17_0)
		if self.exited then
			return
		end

		self.energyIcon.sprite = arg_17_0

		self.energyIcon:SetNativeSize()

		return
	end)

	self.energyAddition.color = var_16_2 and Color.New(0.5921569, 0.8470588, 0.4235294, 1) or Color.New(0.945098, 0.7960784, 0.3019608, 1)
	self.energyTxt.text = var_16_0
	self.energyAdditionTxt.text = " +" .. var_16_1

	return
end

function BackYardFurnitureMsgBoxPage:UpdatePrice()
	self.gemCount.text = self.furniture:getPrice(PlayerConst.ResDiamond) * self.count
	self.goldCount.text = self.furniture:getPrice(PlayerConst.ResDormMoney) * self.count
	self.countTxt.text = self.count

	local var_18_0 = {}

	for iter_18_0 = 1, self.count do
		table.insert(var_18_0, Furniture.New({
			id = self.furniture.id
		}))
	end

	self:UpdateEnergy(var_18_0)

	return
end

function BackYardFurnitureMsgBoxPage:UpdateIcon()
	self.icon.sprite = GetSpriteFromAtlas("furnitureicon/" .. self.furniture:getConfig("icon"), "")

	self.icon:SetNativeSize()
	setActive(self.icon.gameObject, true)

	local var_19_0 = pg.furniture_data_template[self.furniture.configId]

	setActive(self.playBtn, false)
	onButton(self, self.playBtn, function()
		local var_20_0 = Goods.FurnitureId2Id(self.furniture.id)
		local var_20_1 = 312011

		if Goods.ExistFurniture(var_20_0) then
			var_20_1 = Goods.Id2ShipSkinId(var_20_0)
		end

		self.interactionPreview = CourtyardInteractionPreview.New(pg.UIMgr.GetInstance().OverlayMain, self._event)

		self.interactionPreview:ExecuteAction("Show", var_19_0.id, var_20_1)

		return
	end, SFX_PANEL)

	return
end

function BackYardFurnitureMsgBoxPage:Show()
	self.isShowing = true

	BackYardFurnitureMsgBoxPage.super.Show(self)
	SetParent(self._tf, pg.UIMgr.GetInstance().OverlayMain)

	return
end

function BackYardFurnitureMsgBoxPage:Hide()
	self.isShowing = false

	BackYardFurnitureMsgBoxPage.super.Hide(self)
	SetParent(self._tf, self._parentTf)

	if self.interactionPreview then
		self.interactionPreview:Destroy()

		self.interactionPreview = nil
	end

	return
end

function BackYardFurnitureMsgBoxPage:OnDestroy()
	if self.isShowing then
		self:Hide()
	end

	return
end

return BackYardFurnitureMsgBoxPage
