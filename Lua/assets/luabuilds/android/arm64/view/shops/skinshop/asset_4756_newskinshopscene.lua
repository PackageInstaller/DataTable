local NewSkinShopScene = class("NewSkinShopScene", import("view.base.BaseUI"))

NewSkinShopScene.MODE_OVERVIEW = 1
NewSkinShopScene.MODE_EXPERIENCE = 2
NewSkinShopScene.MODE_EXPERIENCE_FOR_ITEM = 3

local var_0_1 = -1
local var_0_2 = -2
local var_0_3 = -3
local var_0_4 = -4

NewSkinShopScene.PAGE_RETURN = -3

local var_0_5 = 9999
local var_0_6 = 9997
local var_0_7 = 9998

NewSkinShopScene.PAGE_ALL = -1
NewSkinShopScene.optionsPath = {
	"overlay/blur_panel/adapt/top/option"
}

function NewSkinShopScene:getUIName()
	return "NewSkinShopUI"
end

function NewSkinShopScene:forceGC()
	return true
end

function NewSkinShopScene:ResUISettings()
	return {
		anim = true,
		showType = PlayerResUI.TYPE_GEM
	}
end

function NewSkinShopScene:GetAllCommodity()
	local var_4_0 = getProxy(ShipSkinProxy):GetAllSkins()

	if LOCK_SKIN_US then
		local var_4_1 = pg.gameset.levellimit_skintype.description

		if pg.gameset.levellimit_skintype.key_value >= getProxy(PlayerProxy):getData().level then
			var_4_0 = _.filter(var_4_0, function(arg_5_0)
				return table.contains(var_4_1, pg.ship_skin_template[arg_5_0:getSkinId()].shop_type_id)
			end)
		end
	end

	return var_4_0
end

function NewSkinShopScene:GetPlayer()
	return (getProxy(PlayerProxy):getRawData())
end

function NewSkinShopScene:GetShopTypeIdBySkinId(arg_7_1)
	NewSkinShopScene.shopTypeIdList = NewSkinShopScene.shopTypeIdList or {}

	if NewSkinShopScene.shopTypeIdList[arg_7_1] then
		return NewSkinShopScene.shopTypeIdList[arg_7_1]
	end

	for iter_7_0, iter_7_1 in pairs(pg.ship_skin_template.get_id_list_by_shop_type_id) do
		for iter_7_2, iter_7_3 in ipairs(iter_7_1) do
			NewSkinShopScene.shopTypeIdList[iter_7_3] = iter_7_0

			if iter_7_3 == arg_7_1 then
				return iter_7_0
			end
		end
	end

	return
end

function NewSkinShopScene:GetSkinClassify(arg_8_1, arg_8_2)
	local var_8_0 = {}
	local var_8_1 = {}

	for iter_8_0, iter_8_1 in ipairs(arg_8_1) do
		local var_8_2 = self:GetShopTypeIdBySkinId(iter_8_1:getSkinId())
		local var_8_3

		if var_8_2 == 0 then
			var_8_3 = var_0_5 or var_8_2
		end

		var_8_1[var_8_3] = (var_8_1[var_8_3] or 0) + 1
	end

	local var_8_4 = {}

	for iter_8_2, iter_8_3 in ipairs(self:GetReturnSkins()) do
		var_8_4[iter_8_3] = true
	end

	if underscore.any(arg_8_1, function(arg_9_0)
		return var_8_4[arg_9_0.id]
	end) then
		table.insert(var_8_0, var_0_3)
	end

	for iter_8_4, iter_8_5 in ipairs(pg.skin_page_template.all) do
		if iter_8_5 ~= var_0_6 and iter_8_5 ~= var_0_7 then
			if (var_8_1[iter_8_5] or 0) > 0 then
				table.insert(var_8_0, iter_8_5)
			end
		end
	end

	if arg_8_2 == NewSkinShopScene.MODE_EXPERIENCE then
		table.insert(var_8_0, 1, var_0_2)
	end

	if arg_8_2 == NewSkinShopScene.MODE_EXPERIENCE_FOR_ITEM then
		table.insert(var_8_0, 1, var_0_4)
	end

	table.insert(var_8_0, 1, var_0_1)

	return var_8_0
end

function NewSkinShopScene:GetReturnSkins()
	self.returnSkins = self.returnSkins or getProxy(ShipSkinProxy):GetEncoreSkins()

	return self.returnSkins
end

function NewSkinShopScene:GetReturnSkinMap()
	if not self.encoreSkinMap then
		self.encoreSkinMap = {}

		for iter_11_0, iter_11_1 in ipairs((self:GetReturnSkins())) do
			self.encoreSkinMap[iter_11_1] = true
		end
	end

	return self.encoreSkinMap
end

function NewSkinShopScene:OnFurnitureUpdate(arg_12_1)
	if not self.mainView.commodity then
		return
	end

	if Goods.ExistFurniture(self.mainView.commodity.id) and Goods.Id2FurnitureId(self.mainView.commodity.id) == arg_12_1 then
		self.mainView:Flush(self.mainView.commodity)
	end

	return
end

function NewSkinShopScene:OnShopping(arg_13_1)
	if not self.mainView.commodity then
		return
	end

	self.mainView:ClosePurchaseView()

	if self.mainView.commodity.id == arg_13_1 then
		local var_13_0 = self:GetAllCommodity()
		local var_13_1 = _.detect(var_13_0, function(arg_14_0)
			return arg_14_0.id == arg_13_1
		end)

		if var_13_1 then
			self.mainView:Flush(var_13_1)
		end

		self:UpdateCouponBtn()
		self:UpdateVoucherBtn()
		self:UpdateCommodities(var_13_0, false)

		self.commodities = var_13_0
	end

	return
end

function NewSkinShopScene:init()
	self.cgGroup = self._tf:GetComponent(typeof(CanvasGroup))
	self.backBtn = self._tf:Find("overlay/blur_panel/adapt/top/back_btn")
	self.atlasBtn = self._tf:Find("overlay/bottom/bg/atlas")
	self.prevBtn = self._tf:Find("overlay/bottom/bg/left_arr")
	self.nextBtn = self._tf:Find("overlay/bottom/bg/right_arr")
	self.live2dFilter = self._tf:Find("overlay/blur_panel/adapt/top/live2d")
	self.live2dFilterSel = self.live2dFilter:Find("selected")
	self.indexBtn = self._tf:Find("overlay/blur_panel/adapt/top/index_btn")
	self.indexBtnSel = self.indexBtn:Find("sel")
	self.inptuTr = self._tf:Find("overlay/blur_panel/adapt/top/search")
	self.changeBtn = self._tf:Find("overlay/blur_panel/adapt/top/change_btn")

	setText(self.inptuTr:Find("holder"), i18n("skinatlas_search_holder"))

	self.couponTr = self._tf:Find("overlay/blur_panel/adapt/top/discount/coupon")
	self.couponSelTr = self.couponTr:Find("selected")
	self.voucherTr = self._tf:Find("overlay/blur_panel/adapt/top/discount/voucher")
	self.voucherSelTr = self.voucherTr:Find("selected")
	self.rollingCircleRect = RollingCircleRect.New(self._tf:Find("overlay/left/mask/content/0"), self._tf:Find("overlay/left"))

	self.rollingCircleRect:SetCallback(self, NewSkinShopScene.OnSelectSkinPage, NewSkinShopScene.OnConfirmSkinPage)

	self.rollingCircleMaskTr = self._tf:Find("overlay/left")
	self.mainView = NewSkinShopMainView.New(self._tf, self.event, self.contextData)
	self.title = self._tf:Find("overlay/blur_panel/adapt/top/title"):GetComponent(typeof(Image))
	self.titleEn = self._tf:Find("overlay/blur_panel/adapt/top/title_en"):GetComponent(typeof(Image))
	self.scrollrect = self._tf:Find("overlay/bottom/scroll"):GetComponent("LScrollRect")
	self.scrollrect.isNewLoadingMethod = true

	function self.scrollrect.onInitItem(arg_16_0)
		self:OnInitItem(arg_16_0)

		return
	end

	function self.scrollrect.onUpdateItem(arg_17_0, arg_17_1)
		self:OnUpdateItem(arg_17_0, arg_17_1)

		return
	end

	self.emptyTr = self._tf:Find("bgs/empty")
	self.defaultIndex = {
		typeIndex = ShipIndexConst.TypeAll,
		campIndex = ShipIndexConst.CampAll,
		rarityIndex = ShipIndexConst.RarityAll,
		extraIndex = SkinIndexLayer.ExtraALL
	}
	Input.multiTouchEnabled = false

	return
end

function NewSkinShopScene:didEnter()
	onButton(self, self.backBtn, function()
		self:emit(NewSkinShopScene.ON_BACK)

		return
	end, SFX_CANCEL)
	onButton(self, self.atlasBtn, function()
		self:emit(NewSkinShopMediator.ON_ATLAS)

		return
	end, SFX_PANEL)
	onButton(self, self.prevBtn, function()
		self:OnPrevCommodity()

		return
	end, SFX_PANEL)
	onButton(self, self.nextBtn, function()
		self:OnNextCommodity()

		return
	end, SFX_PANEL)
	onButton(self, self.indexBtn, function()
		self:emit(NewSkinShopMediator.ON_INDEX, {
			OnFilter = function(arg_24_0)
				self:OnFilter(arg_24_0)

				return
			end,
			defaultIndex = self.defaultIndex
		})

		return
	end, SFX_PANEL)
	onInputChanged(self, self.inptuTr, function()
		self:OnSearch()

		return
	end)
	onToggle(self, self.changeBtn, function(arg_26_0)
		if arg_26_0 and getInputText(self.inptuTr) ~= "" then
			setInputText(self.inptuTr, "")
		end

		return
	end, SFX_PANEL)
	onButton(self, self.live2dFilter, function()
		if self.defaultIndex.extraIndex == SkinIndexLayer.ExtraL2D then
			self.defaultIndex.extraIndex = SkinIndexLayer.ExtraALL or SkinIndexLayer.ExtraL2D
		end

		self:OnFilter(self.defaultIndex)

		return
	end, SFX_PANEL)

	self.isFilterCoupon = false

	onButton(self, self.couponTr, function()
		if not SkinCouponActivity.StaticExistActivityAndCoupon() then
			self.isFilterCoupon = false

			self:UpdateCouponBtn()
			pg.TipsMgr.GetInstance():ShowTips(i18n("common_activity_end"))

			return
		end

		self.isFilterCoupon = not self.isFilterCoupon

		setActive(self.couponSelTr, self.isFilterCoupon)
		self:OnFilter(self.defaultIndex)

		return
	end, SFX_PANEL)

	self.isFilterVoucher = false

	onButton(self, self.voucherTr, function()
		self.isFilterVoucher = not self.isFilterVoucher

		setActive(self.voucherSelTr, self.isFilterVoucher)
		self:OnFilter(self.defaultIndex)

		return
	end, SFX_PANEL)
	self:SetUp()
	getProxy(CommanderManualProxy):TaskProgressAdd(2021, 1)

	return
end

function NewSkinShopScene:UpdateCouponBtn()
	local var_30_0 = SkinCouponActivity.StaticExistActivityAndCoupon() and (not self.contextData.mode or self.contextData.mode == NewSkinShopScene.MODE_OVERVIEW)

	self.isFilterCoupon = tobool(self.isFilterCoupon) and var_30_0
	self.couponTr.localScale = var_30_0 and Vector3(1, 1, 1) or Vector3(0, 0, 0)

	return
end

function NewSkinShopScene:UpdateVoucherBtn()
	local var_31_0 = getProxy(BagProxy)
	local var_31_1 = #var_31_0:GetSkinShopDiscountItemList() > 0 and (not self.contextData.mode or self.contextData.mode == NewSkinShopScene.MODE_OVERVIEW)
	local var_31_2 = tobool(self.isFilterVoucher)

	if var_31_0 then
		self.isFilterVoucher = var_31_1
	end

	self.voucherTr.localScale = var_31_1 and Vector3(1, 1, 1) or Vector3(0, 0, 0)

	return
end

function NewSkinShopScene:OnSelectSkinPage(arg_32_1)
	if self.selectedSkinPageItem then
		setActive(self.selectedSkinPageItem._tr:Find("selected"), false)
		setActive(self.selectedSkinPageItem._tr:Find("name"), true)
	end

	setActive(arg_32_1._tr:Find("selected"), true)
	setActive(arg_32_1._tr:Find("name"), false)

	self.selectedSkinPageItem = arg_32_1

	return
end

function NewSkinShopScene:OnConfirmSkinPage(arg_33_1)
	local var_33_0 = arg_33_1:GetID()

	if self.skinPageID ~= var_33_0 then
		self.skinPageID = var_33_0

		if self.commodities then
			self:UpdateCommodities(self.commodities, true)
		end
	end

	return
end

function NewSkinShopScene:OnFilter(arg_34_1)
	self.defaultIndex = {
		typeIndex = arg_34_1.typeIndex,
		campIndex = arg_34_1.campIndex,
		rarityIndex = arg_34_1.rarityIndex,
		extraIndex = arg_34_1.extraIndex
	}

	setActive(self.live2dFilterSel, arg_34_1.extraIndex == SkinIndexLayer.ExtraL2D)

	if self.commodities then
		self:UpdateCommodities(self.commodities, true)
	end

	setActive(self.indexBtnSel, arg_34_1.typeIndex ~= ShipIndexConst.TypeAll or arg_34_1.campIndex ~= ShipIndexConst.CampAll or arg_34_1.rarityIndex ~= ShipIndexConst.RarityAll or arg_34_1.extraIndex ~= SkinIndexLayer.ExtraALL)

	return
end

function NewSkinShopScene:OnSearch()
	if self.commodities then
		self:UpdateCommodities(self.commodities, true)
	end

	return
end

function NewSkinShopScene:GetDefaultPage(arg_36_1)
	if arg_36_1 == NewSkinShopScene.MODE_EXPERIENCE then
		return var_0_2
	elseif arg_36_1 == NewSkinShopScene.MODE_EXPERIENCE_FOR_ITEM then
		return var_0_4
	else
		return (self.contextData.page or nil) and (self.contextData.page or var_0_1)
	end

	return
end

function NewSkinShopScene:SetUp()
	local var_37_0 = self.contextData.mode or NewSkinShopScene.MODE_OVERVIEW

	self.mode = var_37_0

	local var_37_1 = self:GetAllCommodity()

	self.cgGroup.blocksRaycasts = false

	self:UpdateTitle(var_37_0)
	self:UpdateCouponBtn()
	self:UpdateVoucherBtn()
	setActive(self.rollingCircleMaskTr, var_37_0 == NewSkinShopScene.MODE_OVERVIEW)

	if var_37_0 == NewSkinShopScene.MODE_EXPERIENCE or var_37_0 == NewSkinShopScene.MODE_EXPERIENCE_FOR_ITEM then
		getProxy(SettingsProxy):SetNextTipTimeLimitSkinShop()
	end

	self.skinPageID = self:GetDefaultPage(var_37_0)

	parallelAsync({
		function(arg_38_0)
			self:InitSkinClassify(var_37_1, var_37_0, arg_38_0)

			return
		end,
		function(arg_39_0)
			seriesAsync({
				function(arg_40_0)
					onNextTick(arg_40_0)

					return
				end,
				function(arg_41_0)
					if self.exited then
						return
					end

					self:UpdateCommodities(var_37_1, true, arg_41_0)

					return
				end
			}, arg_39_0)

			return
		end
	}, function()
		self.commodities = var_37_1
		self.cgGroup.blocksRaycasts = true

		return
	end)

	return
end

function NewSkinShopScene:UpdateTitle(arg_43_1)
	self.title.sprite = GetSpriteFromAtlas("ui/SkinShopUI_atlas", ({
		"huanzhuangshagndian",
		"title_01",
		"title_01"
	})[arg_43_1])

	self.title:SetNativeSize()

	self.titleEn.sprite = GetSpriteFromAtlas("ui/SkinShopUI_atlas", ({
		"huanzhuangshagndian_en",
		"title_en_01",
		"title_en_01"
	})[arg_43_1])

	self.titleEn:SetNativeSize()

	return
end

local function var_0_8(arg_44_0, arg_44_1)
	local var_44_0 = arg_44_1:GetID()
	local var_44_1
	local var_44_2

	if var_44_0 ~= var_0_1 and var_44_0 ~= var_0_2 then
		if var_44_0 == var_0_4 then
			var_44_2 = "ALL"
			var_44_1 = "text_all"
		elseif var_44_0 == var_0_3 then
			var_44_2 = "RETURN"
			var_44_1 = "text_fanchang"
		end

		var_44_2 = pg.skin_page_template[var_44_0].english_name
	end

	var_44_1 = "text_" .. pg.skin_page_template[var_44_0].res

	LoadSpriteAtlasAsync("SkinClassified", var_44_1 .. "01", function(arg_45_0)
		if arg_44_0.exited then
			return
		end

		local var_45_0 = arg_44_1._tr:Find("name"):GetComponent(typeof(Image))

		var_45_0.sprite = arg_45_0

		var_45_0:SetNativeSize()

		return
	end)
	LoadSpriteAtlasAsync("SkinClassified", var_44_1, function(arg_46_0)
		if arg_44_0.exited then
			return
		end

		local var_46_0 = arg_44_1._tr:Find("selected/Image"):GetComponent(typeof(Image))

		var_46_0.sprite = arg_46_0

		var_46_0:SetNativeSize()

		return
	end)
	setText(arg_44_1._tr:Find("eng"), var_44_2)

	return
end

function NewSkinShopScene:InitSkinClassify(arg_47_1, arg_47_2, arg_47_3)
	local var_47_0 = self:GetSkinClassify(arg_47_1, arg_47_2)
	local var_47_1 = {}

	for iter_47_0, iter_47_1 in ipairs(var_47_0) do
		table.insert(var_47_1, function(arg_48_0)
			if self.exited then
				return
			end

			var_0_8(self, (self.rollingCircleRect:AddItem(iter_47_1)))

			if (iter_47_0 - 1) % 5 == 0 or iter_47_0 == #var_47_0 then
				onNextTick(arg_48_0)
			else
				arg_48_0()
			end

			return
		end)
	end

	seriesAsync(var_47_1, function()
		if self.exited then
			return
		end

		self.rollingCircleRect:ScrollTo(self.skinPageID)
		arg_47_3()

		return
	end)

	return
end

local function var_0_9(arg_50_0)
	NewSkinShopScene.cacheSkinExperienceItems = NewSkinShopScene.cacheSkinExperienceItems or getProxy(BagProxy):GetSkinExperienceItems()

	return _.any(NewSkinShopScene.cacheSkinExperienceItems, function(arg_51_0)
		return arg_51_0:CanUseForShop(arg_50_0)
	end)
end

function NewSkinShopScene:IsType(arg_52_1, arg_52_2)
	if arg_52_2:getConfig("genre") == ShopArgs.SkinShopTimeLimit then
		if self.mode == NewSkinShopScene.MODE_EXPERIENCE_FOR_ITEM then
			return arg_52_1 == var_0_4 and var_0_9(arg_52_2.id)
		else
			return arg_52_1 == var_0_2
		end
	elseif arg_52_1 == var_0_1 then
		return true
	elseif arg_52_1 == var_0_3 and self:GetReturnSkinMap()[arg_52_2.id] then
		return true
	else
		local var_52_0 = self:GetShopTypeIdBySkinId(arg_52_2:getSkinId())

		return ((var_52_0 == 0 or nil) and (var_0_5 or var_52_0)) == arg_52_1
	end

	return false
end

function NewSkinShopScene:ToVShip(arg_53_1)
	if not self.vship then
		self.vship = {}

		function self.vship.getNation()
			return self.vship.config.nationality
		end

		function self.vship.getShipType()
			return self.vship.config.type
		end

		function self.vship.getTeamType()
			return ShipType.GetTeamFromShipType(self.vship.config.type)
		end

		function self.vship.getRarity()
			return self.vship.config.rarity
		end
	end

	self.vship.config = arg_53_1

	return self.vship
end

function NewSkinShopScene:IsAllFilter(arg_58_1)
	return arg_58_1.typeIndex == ShipIndexConst.TypeAll and arg_58_1.campIndex == ShipIndexConst.CampAll and arg_58_1.rarityIndex == ShipIndexConst.RarityAll and arg_58_1.extraIndex == SkinIndexLayer.ExtraALL
end

function NewSkinShopScene:IsFilterType(arg_59_1, arg_59_2)
	local var_59_0

	if self:IsAllFilter(arg_59_1) then
		do return true end

		var_59_0 = {}
	end

	var_59_0.id = arg_59_2:getSkinId()

	local var_59_1 = ShipSkin.New(var_59_0)
	local var_59_2 = var_59_1:GetDefaultShipConfig()

	if not var_59_2 then
		return false
	end

	local var_59_3 = self:ToVShip(var_59_2)

	return ShipIndexConst.filterByType(var_59_3, arg_59_1.typeIndex) and ShipIndexConst.filterByCamp(var_59_3, arg_59_1.campIndex) and ShipIndexConst.filterByRarity(var_59_3, arg_59_1.rarityIndex) and SkinIndexLayer.filterByExtra(var_59_1, arg_59_1.extraIndex)
end

function NewSkinShopScene:IsSearchType(arg_60_1, arg_60_2)
	local var_60_0

	if not arg_60_1 or arg_60_1 == "" then
		do return true end

		var_60_0 = {}
	end

	var_60_0.id = arg_60_2:getSkinId()

	return ShipSkin.New(var_60_0):IsMatchKey(arg_60_1)
end

local function var_0_10(arg_61_0, arg_61_1, arg_61_2)
	local var_61_0 = arg_61_2[arg_61_0.id]
	local var_61_1 = arg_61_2[arg_61_1.id]

	if arg_61_2[arg_61_0.id] == arg_61_2[arg_61_1.id] then
		return arg_61_0.id < arg_61_1.id
	else
		return var_61_1 < var_61_0
	end

	return
end

function NewSkinShopScene:Sort(arg_62_1, arg_62_2, arg_62_3)
	local var_62_0 = arg_62_1.buyCount == 0 and 1 or 0
	local var_62_1 = arg_62_2.buyCount == 0 and 1 or 0

	if (arg_62_1.buyCount == 0 and 1 or 0) == (arg_62_2.buyCount == 0 and 1 or 0) then
		local var_62_2 = arg_62_1:getConfig("order")
		local var_62_3 = arg_62_2:getConfig("order")

		if var_62_2 == var_62_3 then
			return var_0_10(arg_62_1, arg_62_2, arg_62_3)
		else
			return var_62_2 < var_62_3
		end
	else
		return var_62_1 < var_62_0
	end

	return
end

function NewSkinShopScene:IsCouponType(arg_63_1, arg_63_2)
	if arg_63_1 and not SkinCouponActivity.GetBestReadySkinCouponAct(arg_63_2.id) then
		return false
	end

	return true
end

function NewSkinShopScene:IsVoucherType(arg_64_1, arg_64_2)
	if arg_64_1 and not arg_64_2 then
		return false
	end

	return true
end

function NewSkinShopScene:UpdateCommodities(arg_65_1, arg_65_2, arg_65_3)
	self:ClearCards()

	self.cards = {}
	self.displays = {}
	self.canUseVoucherCache = {}

	local var_65_0 = getInputText(self.inptuTr)
	local var_65_1 = getProxy(BagProxy):GetSkinShopDiscountItemList()

	for iter_65_0, iter_65_1 in ipairs(arg_65_1) do
		local var_65_2 = iter_65_1:StaticCanUseVoucherType(var_65_1)

		if self:IsType(self.skinPageID, iter_65_1) and self:IsFilterType(self.defaultIndex, iter_65_1) and self:IsSearchType(var_65_0, iter_65_1) and self:IsCouponType(self.isFilterCoupon, iter_65_1) and self:IsVoucherType(self.isFilterVoucher, var_65_2) then
			table.insert(self.displays, iter_65_1)
		end

		self.canUseVoucherCache[iter_65_1.id] = var_65_2
	end

	local var_65_3 = {}

	for iter_65_2, iter_65_3 in ipairs(self.displays) do
		if not (iter_65_3.type == Goods.TYPE_ACTIVITY or iter_65_3.type == Goods.TYPE_ACTIVITY_EXTRA) then
			var_65_3[iter_65_3.id] = iter_65_3:GetPrice()
		end
	end

	table.sort(self.displays, function(arg_66_0, arg_66_1)
		return self:Sort(arg_66_0, arg_66_1, var_65_3)
	end)

	if arg_65_2 then
		self.triggerFirstCard = true

		self.scrollrect:SetTotalCount(#self.displays, 0)
	else
		self.scrollrect:SetTotalCount(#self.displays)
	end

	local var_65_5 = #self.displays <= 0

	setActive(self.emptyTr, #self.displays <= 0)

	if var_65_5 then
		self.mainView:Flush(nil)
	end

	if arg_65_3 then
		arg_65_3()
	end

	return
end

function NewSkinShopScene:OnInitItem(arg_67_1)
	local var_67_0 = NewShopSkinCard.New(arg_67_1)

	onButton(self, var_67_0._go, function()
		if not var_67_0.commodity then
			return
		end

		for iter_68_0, iter_68_1 in pairs(self.cards) do
			iter_68_1:UpdateSelected(false)
		end

		self.selectedId = var_67_0.commodity.id

		var_67_0:UpdateSelected(true)
		self:UpdateMainView(var_67_0.commodity)
		self:GCHandle()

		return
	end, SFX_PANEL)

	self.cards[arg_67_1] = var_67_0

	return
end

function NewSkinShopScene:OnUpdateItem(arg_69_1, arg_69_2)
	local var_69_0 = self.cards[arg_69_2]

	if not self.cards[arg_69_2] then
		self:OnInitItem(arg_69_2)

		var_69_0 = self.cards[arg_69_2]
	end

	local var_69_1 = self.displays[arg_69_1 + 1]
	local var_69_2

	if not self.displays[arg_69_1 + 1] then
		do return end

		var_69_2 = self:GetReturnSkinMap()[var_69_1.id]
	end

	var_69_0:Update(var_69_1, self.selectedId == var_69_1.id, var_69_2)

	if self.triggerFirstCard and arg_69_1 == 0 then
		self.triggerFirstCard = nil

		triggerButton(var_69_0._go)
	end

	return
end

function NewSkinShopScene:GCHandle()
	NewSkinShopScene.GCCNT = (NewSkinShopScene.GCCNT or 0) + 1

	if NewSkinShopScene.GCCNT == 3 then
		gcAll()

		NewSkinShopScene.GCCNT = 0
	end

	return
end

function NewSkinShopScene:UpdateMainView(arg_71_1)
	self.mainView:Flush(arg_71_1)

	return
end

function NewSkinShopScene:GetCommodityIndex(arg_72_1)
	for iter_72_0, iter_72_1 in ipairs(self.displays) do
		if iter_72_1.id == arg_72_1 then
			return iter_72_0
		end
	end

	return
end

function NewSkinShopScene:OnPrevCommodity()
	if not self.selectedId then
		return
	end

	local var_73_0 = self:GetCommodityIndex(self.selectedId)

	if var_73_0 - 1 > 0 then
		self:TriggerCommodity(var_73_0, -1)
	end

	return
end

function NewSkinShopScene:OnNextCommodity()
	if not self.selectedId then
		return
	end

	local var_74_0 = self:GetCommodityIndex(self.selectedId)

	if var_74_0 + 1 <= #self.displays then
		self:TriggerCommodity(var_74_0, 1)
	end

	return
end

function NewSkinShopScene:CheckCardBound(arg_75_1, arg_75_2, arg_75_3, arg_75_4)
	local var_75_0 = getBounds(self.scrollrect.gameObject.transform)

	if arg_75_3 then
		if math.ceil(getBounds(arg_75_1._tf):GetMax().x - var_75_0:GetMax().x) > getBounds(arg_75_2._tf).size.x then
			self.scrollrect:SetNormalizedPosition(self.scrollrect.value - (self.scrollrect:HeadIndexToValue(arg_75_4 - 1) - self.scrollrect:HeadIndexToValue(arg_75_4)), 0)
		end
	elseif getBounds(arg_75_1._tf.parent):GetMin().x < var_75_0:GetMin().x and getBounds(arg_75_1._tf):GetMin().x < var_75_0:GetMin().x then
		self.scrollrect:SetNormalizedPosition(self.scrollrect:HeadIndexToValue(arg_75_4 - 1), 0)
	end

	return
end

function NewSkinShopScene:TriggerCommodity(arg_76_1, arg_76_2)
	local var_76_0
	local var_76_1

	for iter_76_0, iter_76_1 in pairs(self.cards) do
		if iter_76_1._tf.gameObject.name ~= "-1" then
			if iter_76_1.commodity.id == self.displays[arg_76_1 + arg_76_2].id then
				var_76_0 = iter_76_1
			elseif iter_76_1.commodity.id == self.displays[arg_76_1].id then
				var_76_1 = iter_76_1
			end
		end
	end

	if var_76_0 then
		triggerButton(var_76_0._tf)
	end

	if var_76_0 and var_76_1 then
		self:CheckCardBound(var_76_0, var_76_1, arg_76_2 > 0, arg_76_1 + arg_76_2)
	end

	return
end

function NewSkinShopScene:ClearCards()
	if not self.cards then
		return
	end

	for iter_77_0, iter_77_1 in pairs(self.cards) do
		iter_77_1:Dispose()
	end

	self.cards = nil

	return
end

function NewSkinShopScene:willExit()
	self:ClearCards()
	ClearLScrollrect(self.scrollrect)

	if self.rollingCircleRect then
		self.rollingCircleRect:Dispose()

		self.rollingCircleRect = nil
	end

	Input.multiTouchEnabled = true

	if self.mainView then
		self.mainView:Dispose()

		self.mainView = nil
	end

	NewSkinShopScene.shopTypeIdList = nil
	NewSkinShopScene.cacheSkinExperienceItems = nil

	return
end

return NewSkinShopScene
