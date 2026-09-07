local LatestSkinShopLayer = class("LatestSkinShopLayer", import("...base.BaseUI"))

LatestSkinShopLayer.MODE_OVERVIEW = 1
LatestSkinShopLayer.MODE_EXPERIENCE = 2
LatestSkinShopLayer.MODE_EXPERIENCE_FOR_ITEM = 3

local var_0_1 = 1
local var_0_2 = 2
local var_0_3 = 3
local var_0_4 = 1
local var_0_5 = 2
local var_0_6 = 3
local var_0_7 = 4
local var_0_8 = 5
local var_0_9 = 6
local var_0_10 = 7
local var_0_11 = 8
local var_0_12 = -1
local var_0_13 = -2
local var_0_14 = -3
local var_0_15 = -4
local var_0_16 = 9999
local var_0_17 = 9997
local var_0_18 = 9998

LatestSkinShopLayer.EVT_SHOW_OR_HIDE_PURCHASE_VIEW = "NewSkinShopMainView:EVT_SHOW_OR_HIDE_PURCHASE_VIEW"
LatestSkinShopLayer.EVT_ON_PURCHASE = "NewSkinShopMainView:EVT_ON_PURCHASE"

local function var_0_19(arg_1_0)
	LatestSkinShopLayer.obtainBtnSpriteNames = LatestSkinShopLayer.obtainBtnSpriteNames or {
		[var_0_4] = "yigoumai_button",
		[var_0_5] = "goumai_button",
		[var_0_6] = "qianwanghuoqu_button",
		[var_0_7] = "item_buy",
		[var_0_8] = "furniture_shop",
		[var_0_9] = "tiyan_btn",
		[var_0_10] = "item_buy",
		[var_0_11] = "buy_with_gift"
	}

	return LatestSkinShopLayer.obtainBtnSpriteNames[arg_1_0]
end

function LatestSkinShopLayer:getUIName()
	return "LatestSkinShopUI"
end

function LatestSkinShopLayer:getGroupName()
	return "NewShopMainScene"
end

function LatestSkinShopLayer:init()
	self.bgs = self._tf:Find("bgs")
	self.adapt = self._tf:Find("adapt")
	self.top = self.adapt:Find("top")
	self.bottom = self.adapt:Find("bottom")
	self.right = self.adapt:Find("right")
	self.subPage = self.adapt:Find("subPage")
	self.resources = self.adapt:Find("top/resources")
	self.limitTime = self.adapt:Find("top/title/limit_time/Text")
	self.skinName = self.adapt:Find("top/title/skin_name_mask/skin_name")
	self.shipName = self.adapt:Find("top/title/name_mask/name")
	self.changeSkin = self.adapt:Find("top/change_skin")
	self.changeSkinToggle = ChangeSkinToggle.New(findTF(self.changeSkin, "toggle_ui"))
	self.showOwnBtn = self.adapt:Find("bottom/showOwnBtn")
	self.filterBtn = self.adapt:Find("bottom/filterBtn")
	self.search = self.adapt:Find("bottom/search")
	self.scrollrect = self.adapt:Find("bottom/scroll/content"):GetComponent("LScrollRect")
	self.sdTg = self.adapt:Find("right/sdTg")
	self.hideUITg = self.adapt:Find("right/hideUITg")
	self.charContainer = self.adapt:Find("right/char_container")
	self.backChara = self.charContainer:Find("bg/back/chara")
	self.charTf = self.charContainer:Find("char")
	self.furnitureContainer = self.charContainer:Find("fur")
	self.switchPreviewBtn = self.charContainer:Find("switch")
	self.dynamicToggle = self.adapt:Find("right/functionsAndTags/dynamic")
	self.dynamicIcon = self.adapt:Find("right/functionsAndTags/dynamic/icon")
	self.showBgToggle = self.adapt:Find("right/functionsAndTags/showBg")
	self.dynamicResToggle = self.adapt:Find("right/functionsAndTags/dynamic/l2d_res_state")
	self.tagList = UIItemList.New(self.adapt:Find("right/functionsAndTags/tags"), self.adapt:Find("right/functionsAndTags/tags/tag"))
	self.giftPackBtn = self.adapt:Find("right/giftPackBtn")
	self.price = self.adapt:Find("right/price")
	self.btns = self.price:Find("btns")
	self.filterUI = self.adapt:Find("subPage/filterUI")
	self.filterContent = self.filterUI:Find("panelMask/panel/filterScroll/Viewport/Content")
	self.painting = self._tf:Find("painting")
	self.paintingTF = self._tf:Find("painting/paint")
	self.defaultPaintingPosition = self.paintingTF.anchoredPosition
	self.defaultPaintingScale = self.paintingTF.localScale
	self.live2dContainer = self._tf:Find("painting/paint/live2d")
	self.spTF = self._tf:Find("painting/paint/spinePainting")
	self.spBg = self._tf:Find("painting/paintBg/spinePainting")

	setActive(self.charContainer, false)
	setActive(self.filterUI, false)

	self.mainTitle = self.adapt:Find("top/mainTitle")
	self.backBtn = self.adapt:Find("top/closeBtn")
	self.homeBtn = self.adapt:Find("top/homeBtn")
	self.giftPack = self.adapt:Find("giftPack")

	setActive(self.mainTitle, false)
	setActive(self.backBtn, false)
	setActive(self.homeBtn, false)
	setActive(self.giftPack, false)

	self.downloads = {}
	self.isToggleDynamic = false
	self.isToggleShowBg = true
	self.isPreviewFurniture = false
	self.interactionPreview = BackYardInteractionPreview.New(self.furnitureContainer, Vector3(0, 0, 0))
	self.voucherMsgBox = SkinVoucherMsgBox.New(pg.UIMgr.GetInstance().OverlayMain)
	self.purchaseView = NewSkinShopPurchaseView.New(self._tf, self.event)

	self:RegisterEvent()
	setGray(self.btns:Find("yigoumai_button"), true, true)
	setText(self._tf:Find("bgs/empty/Text"), i18n("shop_new_unfound"))
	setText(self.adapt:Find("top/mainTitle/Text"), i18n("shop_new_shop"))
	setText(self.filterBtn:Find("Text"), i18n("shop_new_sort"))
	setText(self.search:Find("holder"), i18n("shop_new_search"))
	setText(self.btns:Find("yigoumai_button/Text"), i18n("shop_new_purchased"))
	setText(self.btns:Find("goumai_button/Text"), i18n("shop_new_purchase"))
	setText(self.btns:Find("qianwanghuoqu_button/Text"), i18n("shop_new_claim"))
	setText(self.btns:Find("furniture_shop/Text"), i18n("shop_new_furniture"))
	setText(self.btns:Find("item_buy/Text"), i18n("shop_new_discount"))
	setText(self.btns:Find("tiyan_btn/Text"), i18n("shop_new_try"))
	setText(self.btns:Find("buy_with_gift/Text"), i18n("shop_new_purchase"))
	setText(self.price:Find("btn/tag/Text"), i18n("shop_new_gift"))
	setText(self.giftPack:Find("panel/desc"), i18n("shop_new_gem_transform"))
	setText(self.giftPack:Find("price/btns/yigoumai_button/Text"), i18n("shop_new_purchased"))
	setText(self.filterUI:Find("panelMask/panel/title"), i18n("shop_new_sort"))
	setText(self.filterUI:Find("panelMask/panel/filterScroll/Viewport/Content/own/subTitleFrame/subTitle"), i18n("shop_new_review"))
	setText(self.filterUI:Find("panelMask/panel/filterScroll/Viewport/Content/own/options/0/Text"), i18n("shop_new_all"))
	setText(self.filterUI:Find("panelMask/panel/filterScroll/Viewport/Content/own/options/1/Text"), i18n("shop_new_owned"))
	setText(self.filterUI:Find("panelMask/panel/filterScroll/Viewport/Content/own/options/2/Text"), i18n("shop_new_havent_own"))
	setScrollText(self.filterUI:Find("panelMask/panel/filterScroll/Viewport/Content/own/options/3/mask/Text"), i18n("shop_new_unused"))
	setText(self.filterUI:Find("panelMask/panel/filterScroll/Viewport/Content/type/subTitleFrame/subTitle"), i18n("shop_new_type"))
	setText(self.filterUI:Find("panelMask/panel/filterScroll/Viewport/Content/type/options/0/Text"), i18n("shop_new_all"))
	setText(self.filterUI:Find("panelMask/panel/filterScroll/Viewport/Content/type/options/2/Text"), i18n("shop_new_static"))
	setText(self.filterUI:Find("panelMask/panel/filterScroll/Viewport/Content/type/options/3/Text"), i18n("shop_new_dynamic"))
	setText(self.filterUI:Find("panelMask/panel/filterScroll/Viewport/Content/type/options/4/Text"), i18n("shop_new_static_bg"))
	setText(self.filterUI:Find("panelMask/panel/filterScroll/Viewport/Content/type/options/5/Text"), i18n("shop_new_dynamic_bg"))
	setText(self.filterUI:Find("panelMask/panel/filterScroll/Viewport/Content/type/options/6/Text"), i18n("shop_new_bgm"))
	setText(self.filterUI:Find("panelMask/panel/filterScroll/Viewport/Content/shipHave/subTitleFrame/subTitle"), i18n("shop_new_index"))
	setText(self.filterUI:Find("panelMask/panel/filterScroll/Viewport/Content/shipHave/options/0/Text"), i18n("shop_new_all"))
	setText(self.filterUI:Find("panelMask/panel/filterScroll/Viewport/Content/shipHave/options/1/Text"), i18n("shop_new_ship_owned"))
	setText(self.filterUI:Find("panelMask/panel/filterScroll/Viewport/Content/shipHave/options/2/Text"), i18n("shop_new_ship_havent_owned"))
	setText(self.filterUI:Find("panelMask/panel/filterScroll/Viewport/Content/camp/subTitleFrame/subTitle"), i18n("shop_new_nation"))
	setText(self.filterUI:Find("panelMask/panel/filterScroll/Viewport/Content/rarity/subTitleFrame/subTitle"), i18n("shop_new_rarity"))
	setText(self.filterUI:Find("panelMask/panel/filterScroll/Viewport/Content/shipType/subTitleFrame/subTitle"), i18n("shop_new_category"))
	setText(self.filterUI:Find("panelMask/panel/filterScroll/Viewport/Content/themeType/subTitleFrame/subTitle"), i18n("shop_new_skin_theme"))
	setText(self.filterUI:Find("panelMask/panel/filterScroll/Viewport/Content/tag/subTitleFrame/subTitle"), i18n("skin_shop_tag"))
	setText(self.filterUI:Find("panelMask/panel/filterScroll/Viewport/Content/tag/options/0/Text"), i18n("skin_shop_tag_0"))
	setText(self.filterUI:Find("panelMask/panel/filterScroll/Viewport/Content/tag/options/1/Text"), i18n("skin_shop_tag_1"))
	setText(self.filterUI:Find("panelMask/panel/filterScroll/Viewport/Content/tag/options/2/Text"), i18n("skin_shop_tag_2"))
	setText(self.filterUI:Find("panelMask/panel/filterScroll/Viewport/Content/tag/options/3/Text"), i18n("skin_shop_tag_3"))
	setText(self.filterUI:Find("panelMask/panel/filterScroll/Viewport/Content/tag/options/4/Text"), i18n("skin_shop_tag_4"))
	setText(self.filterUI:Find("panelMask/panel/filterScroll/Viewport/Content/tag/options/5/Text"), i18n("skin_shop_tag_5"))
	setText(self.filterUI:Find("panelMask/panel/filterScroll/Viewport/Content/tag/options/6/Text"), i18n("skin_shop_tag_6"))
	setText(self.filterUI:Find("panelMask/panel/bottom/ok/Text"), i18n("shop_new_confirm"))

	self.uiOwnOptions = self.filterContent:Find("own/options")
	self.uiTypeOptions = self.filterContent:Find("type/options")
	self.uiShipHaveOptions = self.filterContent:Find("shipHave/options")
	self.uiCampOptions = self.filterContent:Find("camp/options")
	self.uiRrarityOptions = self.filterContent:Find("rarity/options")
	self.uiShipTypeOptions = self.filterContent:Find("shipType/options")
	self.uiThemeTypeOptions = self.filterContent:Find("themeType/options")
	self.uiTagTypeOptions = self.filterContent:Find("tag/options")

	self:Overlay()

	return
end

function LatestSkinShopLayer:Overlay()
	self:OverlayPanel(self.adapt, {
		pbList = {
			self.top:Find("title"),
			self.top:Find("title/limit_time"),
			self.top:Find("title/charaNameBg"),
			self.showOwnBtn,
			self.filterBtn,
			self.search,
			self.charContainer:Find("bg"),
			self.price:Find("consume"),
			self.filterUI:Find("panelMask/panel")
		}
	})

	return
end

function LatestSkinShopLayer:UnOverlay()
	self:UnOverlayPanel(self.adapt, self._tf)

	return
end

function LatestSkinShopLayer:didEnter()
	self:InitData()
	self:SetFilterPanel()
	self:SetResource()

	if self.mode == LatestSkinShopLayer.MODE_EXPERIENCE or self.mode == LatestSkinShopLayer.MODE_EXPERIENCE_FOR_ITEM then
		pg.m02:sendNotification(NewShopMainScene.SHOW_OR_HIDE_UI_2, false)
		setActive(self.showOwnBtn, false)
		setActive(self.filterBtn, false)
		setActive(self.search, false)

		self.top:Find("title").anchoredPosition = Vector2(184.2, -208.3)
		self.top:Find("change_skin").anchoredPosition = Vector2(70.7, -337.8)
		self.right:Find("giftPackBtn").anchoredPosition = Vector2(-483, -446.4)
		self.right:Find("price").anchoredPosition = Vector2(-238.3, -140.7)
		self.bottom:Find("scroll").offsetMin = Vector2(17.7, 0)
		self.bottom:Find("scroll").offsetMax = Vector2(-718.7, 227.9)
	end

	self:SetGiftPackLayer()
	onDelayTick(function()
		local var_8_0 = {}

		table.insert(var_8_0, function(arg_9_0)
			self:CheckDownloadSkinList(arg_9_0)

			return
		end)
		seriesAsync(var_8_0, function()
			self:SetSkinScroll()
			self:Refresh(true)

			return
		end)

		return
	end, 0.001)
	onButton(self, self.backBtn, function()
		self:closeView()

		return
	end, SFX_CANCEL)
	onButton(self, self.homeBtn, function()
		self:emit(LatestSkinShopLayer.ON_HOME)

		return
	end, SFX_CANCEL)
	onButton(self, self.filterBtn, function()
		self:OpenFilterPanel()

		return
	end, SFX_PANEL)

	if self.mode == LatestSkinShopLayer.MODE_EXPERIENCE or self.mode == LatestSkinShopLayer.MODE_EXPERIENCE_FOR_ITEM then
		getProxy(SettingsProxy):SetNextTipTimeLimitSkinShop()
	end

	local var_7_0 = getProxy(PlayerProxy):getRawData().id

	onToggle(self, self.sdTg, function(arg_14_0)
		setActive(self.charContainer, arg_14_0)
		PlayerPrefs.SetInt("LatestSkinShopLayerSdTg" .. var_7_0, arg_14_0 and 1 or 0)
		PlayerPrefs.Save()

		return
	end, SFX_PANEL)
	triggerToggle(self.sdTg, PlayerPrefs.GetInt("LatestSkinShopLayerSdTg" .. var_7_0, 0) == 1)
	onToggle(self, self.hideUITg, function(arg_15_0)
		setActive(self.top, not arg_15_0)
		setActive(self.bottom, not arg_15_0)
		pg.m02:sendNotification(NewShopMainScene.SHOW_OR_HIDE_UI, not arg_15_0)

		return
	end, SFX_PANEL)
	onInputChanged(self, self.search, function()
		self:Refresh(true)
		setActive(self.search:Find("holder"), getInputText(self.search) == "")

		return
	end)
	onButton(self, self.showOwnBtn, function()
		self:emit(LatestSkinShopMediator.OPEN_OWN_SKIN_LAYER)

		return
	end, SFX_PANEL)
	getProxy(CommanderManualProxy):TaskProgressAdd(2021, 1)

	return
end

function LatestSkinShopLayer:SetResource()
	setText(self.resources:Find("gem/Text"), getProxy(PlayerProxy):getRawData():getTotalGem())
	onButton(self, self.resources:Find("gem"), function()
		pg.playerResUI:ClickGem()

		return
	end, SFX_PANEL)

	return
end

function LatestSkinShopLayer:InitData()
	self.type = self.contextData.type or ShopConst.PERMANANT_SKIN_SHOP_ID
	self.mode = self.contextData.mode or LatestSkinShopLayer.MODE_OVERVIEW

	self:GetAllCommodities()
	self:GetGiftPackCommodities()

	self.returnSkins = getProxy(ShipSkinProxy):GetEncoreSkins()

	self:GetSkinClassify()

	self.filterValues = {
		shipHaveType = 0,
		ownType = 0,
		typeType = {
			0
		},
		campType = {
			0
		},
		rarityType = {
			0
		},
		shipType = {
			0
		},
		themeType = {
			(self.mode == LatestSkinShopLayer.MODE_EXPERIENCE or self.mode == LatestSkinShopLayer.MODE_EXPERIENCE_FOR_ITEM) and 1 or 0
		},
		tagType = {
			0
		}
	}
	self.filterValuesTemp = Clone(self.filterValues)

	return
end

function LatestSkinShopLayer:GetAllCommodities()
	if self.type == ShopConst.NEW_SKIN_SHOP_ID then
		self.commodities = getProxy(ShipSkinProxy):GetInTimeSkins()
	elseif self.type == ShopConst.PERMANANT_SKIN_SHOP_ID then
		self.commodities = getProxy(ShipSkinProxy):GetPermanentSkins()
	else
		self.commodities = {}

		for iter_21_0, iter_21_1 in ipairs((getProxy(ShipSkinProxy):GetAllSkins())) do
			if table.keyof(pg.shop_skin_subsheet[self.type].param, iter_21_1.id) then
				table.insert(self.commodities, iter_21_1)
			end
		end
	end

	if LOCK_SKIN_US then
		local var_21_0 = pg.gameset.levellimit_skintype.description

		if pg.gameset.levellimit_skintype.key_value >= getProxy(PlayerProxy):getData().level then
			self.commodities = _.filter(self.commodities, function(arg_22_0)
				return table.contains(var_21_0, pg.ship_skin_template[arg_22_0:getSkinId()].shop_type_id)
			end)
		end
	end

	if self.mode == LatestSkinShopLayer.MODE_OVERVIEW then
		for iter_21_2 = #self.commodities, 1, -1 do
			if self.commodities[iter_21_2]:getConfig("genre") == ShopArgs.SkinShopTimeLimit then
				table.remove(self.commodities, iter_21_2)
			end
		end
	end

	return
end

function LatestSkinShopLayer:GetGiftPackCommodities()
	self.giftPackCommodities = {}
	self.giftSkinCommodities = {}
	self.giftSkinProbabilitys = {}

	for iter_23_0, iter_23_1 in ipairs(pg.pay_data_display.all) do
		if pg.pay_data_display[iter_23_1].skin_inquire_relation ~= 0 then
			if pg.TimeMgr.GetInstance():inTime(pg.pay_data_display[iter_23_1].time) then
				local var_23_0 = getProxy(ShopsProxy):GetGiftCommodity(iter_23_1, Goods.TYPE_CHARGE)

				self.giftPackCommodities[iter_23_1] = var_23_0

				local var_23_1 = var_23_0:GetSkinProbability()

				self.giftSkinCommodities[iter_23_1] = getProxy(ShipSkinProxy):GetProbabilitySkins(var_23_1)
				self.giftSkinProbabilitys[iter_23_1] = getProxy(ShipSkinProxy):GetSkinProbabilitys(var_23_1)
			end
		end
	end

	return
end

function LatestSkinShopLayer:SetSkinScroll()
	self.scrollrect.isNewLoadingMethod = true

	function self.scrollrect.onInitItem(arg_25_0)
		self:OnInitItem(arg_25_0)

		return
	end

	function self.scrollrect.onUpdateItem(arg_26_0, arg_26_1)
		self:OnUpdateItem(arg_26_0, arg_26_1)

		return
	end

	self.scrollrect.enabled = true

	return
end

function LatestSkinShopLayer:Refresh(arg_27_1)
	self:ClearCards()

	self.cards = {}
	self.displays = {}

	local var_27_0 = getInputText(self.search)

	for iter_27_0, iter_27_1 in ipairs(self.commodities) do
		if self:filterOk(iter_27_1) and self:IsSearchType(var_27_0, iter_27_1) then
			table.insert(self.displays, iter_27_1)
		end
	end

	local var_27_1 = {}

	for iter_27_2, iter_27_3 in ipairs(self.displays) do
		if not (iter_27_3.type == Goods.TYPE_ACTIVITY or iter_27_3.type == Goods.TYPE_ACTIVITY_EXTRA) then
			var_27_1[iter_27_3.id] = iter_27_3:GetPrice()
		end
	end

	table.sort(self.displays, function(arg_28_0, arg_28_1)
		return self:Sort(arg_28_0, arg_28_1, var_27_1)
	end)

	local var_27_3 = #self.displays == 0

	setActive(self.bgs:Find("default"), #self.displays == 0)
	setActive(self.bgs:Find("diffBg"), not var_27_3)
	setActive(self.bgs:Find("empty"), var_27_3)
	setActive(self._tf:Find("leftMask"), not var_27_3)
	setActive(self._tf:Find("bottomMask"), not var_27_3)
	setActive(self.painting, not var_27_3)
	setActive(self.top:Find("title"), not var_27_3)
	setActive(self.changeSkin, not var_27_3)
	setActive(self.right, not var_27_3)
	setActive(self.right, not var_27_3)
	setActive(self.bottom:Find("scroll"), not var_27_3)

	if not var_27_3 then
		if arg_27_1 then
			self.triggerFirstCard = true

			self.scrollrect:SetTotalCount(#self.displays, 0)
		else
			self.scrollrect:SetTotalCount(#self.displays)
		end
	end

	return
end

function LatestSkinShopLayer:IsSearchType(arg_29_1, arg_29_2)
	local var_29_0

	if not arg_29_1 or arg_29_1 == "" then
		do return true end

		var_29_0 = {}
	end

	var_29_0.id = arg_29_2:getSkinId()

	return ShipSkin.New(var_29_0):IsMatchKey(arg_29_1)
end

local function var_0_20(arg_30_0, arg_30_1, arg_30_2)
	local var_30_0 = arg_30_2[arg_30_0.id]
	local var_30_1 = arg_30_2[arg_30_1.id]

	if arg_30_2[arg_30_0.id] == arg_30_2[arg_30_1.id] then
		return arg_30_0.id < arg_30_1.id
	else
		return var_30_1 < var_30_0
	end

	return
end

function LatestSkinShopLayer:Sort(arg_31_1, arg_31_2, arg_31_3)
	local var_31_0 = arg_31_1.buyCount == 0 and 1 or 0
	local var_31_1 = arg_31_2.buyCount == 0 and 1 or 0

	if (arg_31_1.buyCount == 0 and 1 or 0) == (arg_31_2.buyCount == 0 and 1 or 0) then
		local var_31_2 = arg_31_1:getConfig("order")
		local var_31_3 = arg_31_2:getConfig("order")

		if var_31_2 == var_31_3 then
			return var_0_20(arg_31_1, arg_31_2, arg_31_3)
		else
			return var_31_2 < var_31_3
		end
	else
		return var_31_1 < var_31_0
	end

	return
end

function LatestSkinShopLayer:filterOk(arg_32_1)
	local var_32_0 = arg_32_1:getSkinId()
	local var_32_1 = ShipSkin.New({
		id = var_32_0
	})
	local var_32_2 = var_32_1:GetDefaultShipConfig()
	local var_32_3 = self:ToVShip(var_32_2)

	if self.filterValues.ownType ~= 0 then
		local var_32_4 = false
		local var_32_5 = getProxy(ShipSkinProxy):hasSkin(var_32_0)

		if self.filterValues.ownType == 1 and var_32_5 then
			var_32_4 = true
		end

		if self.filterValues.ownType == 2 and not var_32_5 then
			var_32_4 = true
		end

		if not ((self.filterValues.ownType == 3 and var_32_5 and var_32_1:NoUse() or nil) and true) then
			return false
		end
	end

	if self.filterValues.typeType[1] ~= 0 then
		local var_32_6 = false

		for iter_32_0, iter_32_1 in ipairs(self.filterValues.typeType) do
			if iter_32_1 == 1 and (var_32_1:IsLive2d() or var_32_1:IsLive2dPlus()) then
				var_32_6 = true
			end

			if iter_32_1 == 2 and not var_32_1:IsLive2d() and not var_32_1:IsLive2dPlus() and not var_32_1:IsSpine() and not var_32_1:IsSpinePlus() then
				var_32_6 = true
			end

			if iter_32_1 == 3 and (var_32_1:IsSpine() or var_32_1:IsSpinePlus()) then
				var_32_6 = true
			end

			if iter_32_1 == 4 and var_32_1:IsBG() then
				var_32_6 = true
			end

			if iter_32_1 == 5 and var_32_1:IsDbg() then
				var_32_6 = true
			end

			if iter_32_1 == 6 and var_32_1:isBgm() then
				var_32_6 = true
			end

			if var_32_6 then
				break
			end
		end

		if not var_32_6 then
			return false
		end
	end

	if self.filterValues.shipHaveType ~= 0 then
		local var_32_7 = false
		local var_32_8 = var_32_1:CantUse()

		if self.filterValues.shipHaveType == 1 and not var_32_8 then
			var_32_7 = true
		end

		if not ((self.filterValues.shipHaveType == 2 and var_32_8 or nil) and true) then
			return false
		end
	end

	if self.filterValues.campType[1] ~= 0 then
		if not var_32_2 then
			return false
		end

		local var_32_9 = false

		for iter_32_2, iter_32_3 in ipairs(self.filterValues.campType) do
			for iter_32_4, iter_32_5 in ipairs(ShipIndexCfg.camp[iter_32_3 + 1].types) do
				if iter_32_5 == Nation.LINK then
					if var_32_3:getNation() >= Nation.LINK then
						var_32_9 = true
					end
				elseif iter_32_5 == var_32_3:getNation() then
					var_32_9 = true
				end
			end

			if var_32_9 then
				break
			end
		end

		if not var_32_9 then
			return false
		end
	end

	if self.filterValues.rarityType[1] ~= 0 then
		if not var_32_2 then
			return false
		end

		local var_32_10 = false

		for iter_32_6, iter_32_7 in ipairs(self.filterValues.rarityType) do
			if table.contains(ShipIndexCfg.rarity[iter_32_7 + 1].types, var_32_3:getRarity()) then
				var_32_10 = true
			end

			if var_32_10 then
				break
			end
		end

		if not var_32_10 then
			return false
		end
	end

	if self.filterValues.shipType[1] ~= 0 then
		if not var_32_2 then
			return false
		end

		local var_32_11 = false

		for iter_32_8, iter_32_9 in ipairs(self.filterValues.shipType) do
			if iter_32_9 + 1 < 4 then
				if table.contains(ShipIndexCfg.type[iter_32_9 + 1].types, var_32_3:getShipType()) then
					var_32_11 = true
				end

				if table.contains(ShipIndexCfg.type[iter_32_9 + 1].types, var_32_3:getTeamType()) then
					var_32_11 = true
				end
			elseif table.contains(ShipIndexCfg.type[iter_32_9 + 1].types, var_32_3:getShipType()) then
				var_32_11 = true
			end

			if var_32_11 then
				break
			end
		end

		if not var_32_11 then
			return false
		end
	end

	if self.filterValues.themeType[1] ~= 0 then
		local var_32_13 = false

		for iter_32_10, iter_32_11 in ipairs(self.filterValues.themeType) do
			local var_32_14 = self.classifyIds[iter_32_11 + 1]

			if arg_32_1:getConfig("genre") == ShopArgs.SkinShopTimeLimit then
				var_32_13 = self.mode == LatestSkinShopLayer.MODE_EXPERIENCE_FOR_ITEM and var_32_14 == var_0_15 and self:ExitSkinExperienceItem(arg_32_1.id) or var_32_14 == var_0_13
			elseif var_32_14 == var_0_12 then
				var_32_13 = true
			elseif var_32_14 == var_0_14 and table.contains(self.returnSkins, arg_32_1.id) then
				var_32_13 = true
			else
				local var_32_15 = self:GetShopTypeIdBySkinId(var_32_0)

				var_32_13 = ((var_32_15 == 0 or nil) and (var_0_16 or var_32_15)) == var_32_14
			end

			if var_32_13 then
				break
			end
		end

		if not var_32_13 then
			return false
		end
	end

	if self.filterValues.tagType[1] ~= 0 then
		if table.keyof(self.filterValues.tagType, (NewShopSkinCard.GetTagId(arg_32_1, (table.contains(self.returnSkins, arg_32_1.id))))) then
			return true
		else
			return false
		end
	end

	return true
end

function LatestSkinShopLayer:ToVShip(arg_33_1)
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

	self.vship.config = arg_33_1

	return self.vship
end

function LatestSkinShopLayer:ExitSkinExperienceItem(arg_38_1)
	self.cacheSkinExperienceItems = self.cacheSkinExperienceItems or getProxy(BagProxy):GetSkinExperienceItems()

	return _.any(self.cacheSkinExperienceItems, function(arg_39_0)
		return arg_39_0:CanUseForShop(arg_38_1)
	end)
end

function LatestSkinShopLayer:RegisterEvent()
	self:bind(LatestSkinShopLayer.EVT_SHOW_OR_HIDE_PURCHASE_VIEW, function(arg_41_0, arg_41_1)
		self:AdjustPainting(arg_41_1)
		setActive(self.top, not arg_41_1)
		setActive(self.bottom, not arg_41_1)
		setActive(self.right, not arg_41_1)

		if self.live2dChar then
			self.live2dChar:setPurchaseOffset(arg_41_1)
		end

		if self.spineChar then
			if arg_41_1 then
				if pg.ship_skin_template[self.skinId].purchase_offset and #pg.ship_skin_template[self.skinId].purchase_offset >= 3 then
					self.spineChar:SetLocalPosition(Vector3(pg.ship_skin_template[self.skinId].purchase_offset[1], pg.ship_skin_template[self.skinId].purchase_offset[2], pg.ship_skin_template[self.skinId].purchase_offset[3]))
				end

				if pg.ship_skin_template[self.skinId].purchase_offset and #pg.ship_skin_template[self.skinId].purchase_offset >= 4 then
					self.spineChar:SetLocalScale(Vector3(pg.ship_skin_template[self.skinId].purchase_offset[4], pg.ship_skin_template[self.skinId].purchase_offset[4], pg.ship_skin_template[self.skinId].purchase_offset[4]))
				end
			else
				self.spineChar:SetLocalScale(Vector3(0.9, 0.9, 1))
				self.spineChar:SetLocalPosition(Vector3(0, 0, 0))
			end
		end

		pg.m02:sendNotification(NewShopMainScene.SHOW_OR_HIDE_UI, not arg_41_1)

		return
	end)
	self:bind(LatestSkinShopLayer.EVT_ON_PURCHASE, function(arg_42_0, arg_42_1)
		self:OnClickBtn(self:GetObtainBtnState(arg_42_1), arg_42_1)

		return
	end)
	onButton(self, self.changeSkin, function()
		if ShipSkin.IsChangeSkin(self.skinId) then
			self.changeSkinId = ShipSkin.GetChangeSkinNextId(self.skinId)

			self:UpdateMainView(self.showingCommodity)
		end

		return
	end, SFX_PANEL)

	return
end

function LatestSkinShopLayer:OnInitItem(arg_44_1)
	local var_44_0 = NewShopSkinCard.New(arg_44_1)

	onButton(self, var_44_0._go, function()
		if not var_44_0.commodity then
			return
		end

		for iter_45_0, iter_45_1 in pairs(self.cards) do
			iter_45_1:UpdateSelected(false)
		end

		self.selectedId = var_44_0.commodity.id

		var_44_0:UpdateSelected(true)
		self:UpdateMainView(var_44_0.commodity)
		self:GCHandle()

		return
	end, SFX_PANEL)

	self.cards[arg_44_1] = var_44_0

	return
end

function LatestSkinShopLayer:OnUpdateItem(arg_46_1, arg_46_2)
	local var_46_0 = self.cards[arg_46_2]

	if not self.cards[arg_46_2] then
		self:OnInitItem(arg_46_2)

		var_46_0 = self.cards[arg_46_2]
	end

	local var_46_1 = self.displays[arg_46_1 + 1]
	local var_46_2

	if not self.displays[arg_46_1 + 1] then
		do return end

		var_46_2 = table.contains(self.returnSkins, var_46_1.id)
	end

	var_46_0:Update(var_46_1, self.selectedId == var_46_1.id, var_46_2)

	if self.triggerFirstCard and arg_46_1 == 0 then
		self.triggerFirstCard = false

		triggerButton(var_46_0._go)
	end

	return
end

function LatestSkinShopLayer:UpdateMainView(arg_47_1)
	self.skinId = arg_47_1:getSkinId()

	local var_47_0 = ShipSkin.IsChangeSkin(self.skinId)

	setActive(self.changeSkin, var_47_0)

	if var_47_0 then
		self:FlushChangeSkin(arg_47_1)
	end

	self.shipSkin = ShipSkin.New({
		id = self.skinId
	})

	self:FlushName()
	self:FlushPreviewBtn(arg_47_1)
	self:FlushTimeLimit(arg_47_1)
	self:SwitchPreview(arg_47_1, self.isPreviewFurniture)
	self:FlushPaintingToggle(arg_47_1)
	self:FlushTag()
	self:FlushBG(arg_47_1)
	self:FlushPainting(arg_47_1)
	self:FlushPrice(arg_47_1)
	self:FlushObtainBtn(arg_47_1)
	self:FlushGifgPackBtn(arg_47_1)

	self.showingCommodity = arg_47_1

	return
end

function LatestSkinShopLayer:FlushChangeSkin(arg_48_1)
	local var_48_0 = ShipSkin.GetChangeSkinGroupId(self.skinId)
	local var_48_1 = ShipSkin.GetChangeSkinCustomDataId(self.skinId, "hide_shop")
	local var_48_2 = pg.gameset.changeskin_switch_block
	local var_48_3 = false
	local var_48_4 = false
	local var_48_5 = not not self.changeSkinToggle:IsAsmrSkin()

	if pg.gameset.changeskin_switch_block and var_48_2.description and table.contains(var_48_2.description, var_48_0) and HXSet.isHx() then
		var_48_4 = true
	end

	if var_48_1 and var_48_1 == 1 then
		var_48_3 = true
	end

	if not self.changeSkinId then
		self.changeSkinId = self.skinId
	elseif ShipSkin.GetChangeSkinGroupId(self.changeSkinId) == var_48_0 then
		self.skinId = self.changeSkinId
	else
		self.changeSkinId = self.skinId
	end

	self.changeSkinToggle:setSkinData(self.skinId)

	if var_48_3 or var_48_4 or var_48_5 then
		setActive(self.changeSkin, false)
	else
		setActive(self.changeSkin, true)
	end

	return
end

function LatestSkinShopLayer:GCHandle()
	LatestSkinShopLayer.GCCNT = (LatestSkinShopLayer.GCCNT or 0) + 1

	if LatestSkinShopLayer.GCCNT == 3 then
		gcAll()

		LatestSkinShopLayer.GCCNT = 0
	end

	return
end

function LatestSkinShopLayer:FlushName()
	setScrollText(self.skinName, SwitchSpecialChar(pg.ship_skin_template[self.skinId].name, true))

	if pg.ship_skin_template[self.skinId].skin_type == ShipSkin.SKIN_TYPE_TB then
		setScrollText(self.shipName, NewEducateHelper.GetShipNameBySecId(NewEducateHelper.GetSecIdBySkinId(self.skinId)))
	else
		setScrollText(self.shipName, ShipGroup.getDefaultShipConfig(pg.ship_skin_template[self.skinId].ship_group).name)
	end

	return
end

function LatestSkinShopLayer:FlushPreviewBtn(arg_51_1)
	local var_51_0 = Goods.ExistFurniture(arg_51_1.id)

	removeOnButton(self.switchPreviewBtn)

	if not var_51_0 and self.isPreviewFurniture then
		self.isPreviewFurniture = false
	end

	setActive(self.switchPreviewBtn, var_51_0)

	if var_51_0 then
		onButton(self, self.switchPreviewBtn, function()
			self.isPreviewFurniture = not self.isPreviewFurniture

			self:SwitchPreview(arg_51_1, self.isPreviewFurniture)
			self:FlushPrice(arg_51_1)
			self:FlushObtainBtn(arg_51_1)

			return
		end, SFX_PANEL)
	end

	return
end

function LatestSkinShopLayer:SwitchPreview(arg_53_1, arg_53_2)
	if pg.ship_skin_template[self.skinId].skin_type == ShipSkin.SKIN_TYPE_TB then
		setActive(self.charContainer, false)

		return
	end

	setActive(self.charContainer, PlayerPrefs.GetInt("LatestSkinShopLayerSdTg" .. getProxy(PlayerProxy):getRawData().id, 0) == 1)
	setActive(self.charTf, not arg_53_2)
	setActive(self.furnitureContainer, arg_53_2)

	if not arg_53_2 then
		self:FlushChar(pg.ship_skin_template[self.skinId].prefab, pg.ship_skin_template[self.skinId].id)
		GetImageSpriteFromAtlasAsync("qicon/" .. pg.ship_skin_template[self.skinId].painting, "", self.backChara)
	else
		local var_53_0 = Goods.GetFurnitureConfig(arg_53_1.id)

		self.interactionPreview:Flush(self.skinId, Goods.Id2FurnitureId(arg_53_1.id), var_53_0.scale[2] or 1, var_53_0.position[2])
	end

	return
end

function LatestSkinShopLayer:FlushChar(arg_54_1, arg_54_2)
	if self.prefabName and self.prefabName == arg_54_1 then
		return
	end

	self:ReturnChar()

	self.prefabName = arg_54_1

	local var_54_0 = SpineAnimChar.New()

	var_54_0:SetPaint(arg_54_1)
	var_54_0:Load(true, function(arg_55_0)
		if self.prefabName ~= arg_54_1 then
			arg_55_0:Dispose()

			return
		end

		self.spineChar = arg_55_0

		if pg.skinshop_spine_scale[arg_54_2] then
			self.spineChar:SetLocalScale(Vector3(pg.skinshop_spine_scale[arg_54_2].skinshop_scale, pg.skinshop_spine_scale[arg_54_2].skinshop_scale, 1))
		else
			self.spineChar:SetLocalScale(Vector3(0.9, 0.9, 1))
		end

		self.spineChar:SetLocalPosition(Vector3(0, 0, 0))
		self.spineChar:SetLayer(Layer.UI)
		self.spineChar:SetParent(self.charTf)
		self.spineChar:SetAction("normal", 0)

		return
	end)

	return
end

function LatestSkinShopLayer:ReturnChar()
	if self.spineChar then
		self.spineChar:Dispose()

		self.spineChar = nil
		self.prefabName = nil
	end

	return
end

function LatestSkinShopLayer:ClearCards()
	if not self.cards then
		return
	end

	for iter_57_0, iter_57_1 in pairs(self.cards) do
		iter_57_1:Dispose()
	end

	self.cards = nil

	return
end

function LatestSkinShopLayer:FlushTimeLimit(arg_58_1)
	local var_58_0 = false
	local var_58_1

	if arg_58_1:IsActivityExtra() and arg_58_1:ShowMaintenanceTime() then
		local var_58_2, var_58_3 = arg_58_1:GetMaintenanceMonthAndDay()

		function var_58_1()
			return i18n("limit_skin_time_before_maintenance", var_58_2, var_58_3)
		end

		var_58_0 = true
	elseif arg_58_1:getConfig("genre") == ShopArgs.SkinShopTimeLimit then
		local var_58_4 = getProxy(ShipSkinProxy):getSkinById(self.skinId)

		var_58_0 = var_58_4 and var_58_4:isExpireType() and not var_58_4:isExpired()

		if var_58_0 then
			function var_58_1()
				return skinTimeStamp(var_58_4:getRemainTime())
			end
		end
	else
		local var_58_5, var_58_6 = pg.TimeMgr.GetInstance():inTime(arg_58_1:getConfig("time"))

		var_58_0 = var_58_6

		if var_58_6 then
			local var_58_7 = pg.TimeMgr.GetInstance():Table2ServerTime(var_58_6)

			function var_58_1()
				return skinCommdityTimeStamp(var_58_7)
			end
		end
	end

	setActive(self.top:Find("title/limit_time"), var_58_0)
	self:ClearTimer()

	if var_58_0 then
		self:AddTimer(var_58_1)
	end

	return
end

function LatestSkinShopLayer:AddTimer(arg_62_1)
	self.timer = Timer.New(function()
		setText(self.limitTime, arg_62_1())

		return
	end, 1, -1)

	self.timer.func()
	self.timer:Start()

	return
end

function LatestSkinShopLayer:ClearTimer()
	if self.timer then
		self.timer:Stop()

		self.timer = nil
	end

	return
end

function LatestSkinShopLayer:FlushPaintingToggle(arg_65_1)
	removeOnToggle(self.dynamicToggle)
	removeOnToggle(self.showBgToggle)

	local var_65_0 = checkABExist("painting/" .. self.shipSkin:getConfig("painting") .. "_n")

	if self.isToggleShowBg and not var_65_0 then
		triggerToggle(self.showBgToggle, false)

		self.isToggleShowBg = false
	elseif var_65_0 then
		triggerToggle(self.showBgToggle, true)

		self.isToggleShowBg = true
	end

	local var_65_1 = self.shipSkin:IsSpine() or self.shipSkin:IsLive2d() or self.shipSkin:IsSpinePlus() or self.shipSkin:IsLive2dPlus()
	local var_65_2 = self.shipSkin:IsHxDynamicPreview()

	if var_65_1 and not var_65_2 then
		if PlayerPrefs.GetInt("skinShop#l2dPreViewToggle" .. getProxy(PlayerProxy):getRawData().id, 0) == 1 then
			self.isToggleDynamic = true
		end
	end

	if var_65_1 then
		local var_65_3 = 0

		if self.shipSkin:IsSpine() then
			var_65_3 = 6
		elseif self.shipSkin:IsLive2d() then
			var_65_3 = 1
		elseif self.shipSkin:IsSpinePlus() then
			var_65_3 = 7
		elseif self.shipSkin:IsLive2dPlus() then
			var_65_3 = 9
		end

		LoadImageSpriteAtlasAsync("SkinIcon", "type_" .. ShipSkin.Tag2Name(var_65_3) .. "_off", self.dynamicToggle)
		LoadImageSpriteAtlasAsync("SkinIcon", "type_" .. ShipSkin.Tag2Name(var_65_3), self.dynamicToggle:Find("select"))
	end

	if var_65_2 and self.isToggleDynamic then
		triggerToggle(self.dynamicToggle, false)

		self.isToggleDynamic = false
	end

	if self.isToggleDynamic and not var_65_1 then
		triggerToggle(self.dynamicToggle, false)

		self.isToggleDynamic = false
	elseif self.isToggleDynamic and not self.dynamicToggle:GetComponent(typeof(Toggle)).isOn then
		if (self.shipSkin:IsLive2d() or self.shipSkin:IsLive2dPlus()) and Live2dConst.GetLive2DArm32MatchAble() then
			self.isToggleDynamic = false

			PlayerPrefs.SetInt("skinShop#l2dPreViewToggle" .. getProxy(PlayerProxy):getRawData().id, 0)
			PlayerPrefs.Save()
			triggerToggle(self.dynamicToggle, false)
		else
			triggerToggle(self.dynamicToggle, true)

			self.isToggleDynamic = true
		end
	end

	if var_65_0 then
		onToggle(self, self.showBgToggle, function(arg_66_0)
			self.isToggleShowBg = arg_66_0

			self:FlushPainting(arg_65_1)
			self:FlushBG(arg_65_1)

			return
		end, SFX_PANEL)
	end

	if self.shipSkin:IsSpine() or self.shipSkin:IsLive2d() or self.shipSkin:IsSpinePlus() or self.shipSkin:IsLive2dPlus() then
		onToggle(self, self.dynamicToggle, function(arg_67_0)
			if arg_67_0 and self.shipSkin:IsHxDynamicPreview() then
				pg.TipsMgr.GetInstance():ShowTips(i18n("shop_tag_control_tip"))
				triggerToggle(self.dynamicToggle, false)
				setActive(self.dynamicResToggle, false)

				return
			end

			if arg_67_0 and Live2dConst.GetLive2DArm32MatchAble() and (self.shipSkin:IsLive2d() or self.shipSkin:IsLive2dPlus()) then
				Live2dConst.ShowLive2DArm32Tips()
				triggerToggle(self.dynamicToggle, false)

				return
			end

			self.isToggleDynamic = arg_67_0

			setActive(self.showBgToggle, not arg_67_0 and var_65_0)
			self:FlushPainting(arg_65_1)
			self:FlushDynamicPaintingResState(arg_65_1)
			self:RecordFlag(arg_67_0)

			return
		end, SFX_PANEL)
	end

	setActive(self.dynamicIcon, true)

	if self.isToggleDynamic then
		self:FlushDynamicPaintingResState(arg_65_1)
	elseif var_65_2 then
		setActive(self.dynamicResToggle, false)
		setActive(self.dynamicIcon, false)
	end

	setActive(self.dynamicToggle, var_65_1)
	setActive(self.showBgToggle, not self.isToggleDynamic and var_65_0)

	return
end

function LatestSkinShopLayer:FlushTag()
	local var_68_0 = Clone(pg.ship_skin_template[self.skinId].tag)

	for iter_68_0 = #var_68_0, 1, -1 do
		if var_68_0[iter_68_0] == 1 or var_68_0[iter_68_0] == 6 or var_68_0[iter_68_0] == 7 or var_68_0[iter_68_0] == 9 then
			table.remove(var_68_0, iter_68_0)
		end
	end

	local var_68_3 = checkABExist("painting/" .. self.shipSkin:getConfig("painting") .. "_n")

	self.tagList:make(function(arg_69_0, arg_69_1, arg_69_2)
		if arg_69_0 == UIItemList.EventUpdate then
			LoadSpriteAtlasAsync("SkinIcon", "type_" .. ShipSkin.Tag2Name(var_68_0[arg_69_1 + 1]), function(arg_70_0)
				if self.exited then
					return
				end

				arg_69_2:GetComponent(typeof(Image)).sprite = arg_70_0

				return
			end)
		end

		return
	end)
	self.tagList:align(#var_68_0)

	return
end

function LatestSkinShopLayer:FlushPainting(arg_71_1)
	local var_71_0 = self:GetPaintingState(arg_71_1)
	local var_71_1 = pg.ship_skin_template[self.skinId].painting
	local var_71_2 = not not ShipSkin.GetChangeSkinData(self.skinId)

	if var_71_0 == var_0_2 and not self:ExistL2dRes(var_71_1) or var_71_0 == var_0_3 and not self:ExistSpineRes(var_71_1) then
		var_71_0 = var_0_1
	end

	if self.paintingState and self.paintingState.state == var_71_0 and self.paintingState.id == arg_71_1.id and self.paintingState.showBg == self.isToggleShowBg and self.paintingState.purchaseFlag == arg_71_1.buyCount and not var_71_2 then
		return
	end

	self:ClearPainting()

	if var_71_0 == var_0_1 then
		self:LoadMeshPainting(arg_71_1, self.isToggleShowBg)
	elseif var_71_0 == var_0_2 then
		self:LoadL2dPainting(arg_71_1)
	elseif var_71_0 == var_0_3 then
		self:LoadSpinePainting(arg_71_1)
	end

	self.paintingState = {
		state = var_71_0,
		id = arg_71_1.id,
		showBg = self.isToggleShowBg,
		purchaseFlag = arg_71_1.buyCount
	}

	self:AdjustPainting(false)

	return
end

function LatestSkinShopLayer:ClearPainting()
	if not self.paintingState then
		return
	end

	if self.paintingState.state == var_0_1 then
		self:ClearMeshPainting()
	elseif self.paintingState.state == var_0_2 then
		self:ClearL2dPainting()
	elseif self.paintingState.state == var_0_3 then
		self:ClearSpinePainting()
	end

	self.paintingState = nil

	return
end

function LatestSkinShopLayer:LoadMeshPainting(arg_73_1, arg_73_2)
	local var_73_0 = findTF(self.paintingTF, "fitter")
	local var_73_1 = GetOrAddComponent(var_73_0, "PaintingScaler")

	var_73_1.FrameName = "chuanwu"
	var_73_1.Tween = 1

	local var_73_2 = pg.ship_skin_template[self.skinId].painting
	local var_73_3 = pg.ship_skin_template[self.skinId].painting

	if not arg_73_2 and checkABExist("painting/" .. var_73_2 .. "_n") then
		var_73_2 = var_73_2 .. "_n"
	end

	if not checkABExist("painting/" .. var_73_2) then
		return
	end

	if PLATFORM_CODE == PLATFORM_CH and checkABExist("painting/" .. var_73_2 .. "_shop") then
		var_73_2 = var_73_2 .. "_shop"
	end

	pg.UIMgr.GetInstance():LoadingOn()
	PoolMgr.GetInstance():GetPainting(var_73_2, true, function(arg_74_0)
		pg.UIMgr.GetInstance():LoadingOff()
		setParent(arg_74_0, var_73_0, false)
		ShipExpressionHelper.SetExpression(var_73_0:GetChild(0), var_73_3)

		self.paintingName = var_73_2

		if self.paintingState and self.paintingState.id ~= arg_73_1.id then
			self:ClearMeshPainting()
		end

		self:CheckShowShopHx((arg_74_0.transform:Find("shop_hx")))
		self:CheckShowShopHx((arg_74_0.transform:Find("shop_hx_ch" .. pg.SdkMgr.GetInstance():GetChannelUIDIncludeHarmony())))

		return
	end)

	return
end

function LatestSkinShopLayer:ClearMeshPainting()
	local var_75_0 = self.paintingTF:Find("fitter")

	if self.paintingName and var_75_0.childCount > 0 then
		local var_75_1 = var_75_0:GetChild(0).gameObject

		self:RevertShopHx((var_75_1.transform:Find("shop_hx")))
		PoolMgr.GetInstance():ReturnPainting(self.paintingName, var_75_1)
	end

	self.paintingName = nil

	return
end

function LatestSkinShopLayer:LoadL2dPainting(arg_76_1)
	local var_76_0

	if pg.ship_skin_template[self.skinId].skin_type == ShipSkin.SKIN_TYPE_TB then
		var_76_0 = VirtualEducateCharShip.New(NewEducateHelper.GetSecIdBySkinId(self.skinId))
	else
		local var_76_1 = {
			noChangeSkin = true
		}

		var_76_1.configId = ShipGroup.getDefaultShipConfig(pg.ship_skin_template[self.skinId].ship_group).id
		var_76_1.skin_id = self.skinId
		var_76_0 = Ship.New(var_76_1)
	end

	local var_76_2 = Live2DPainting.GenerateData({
		ship = var_76_0,
		position = Vector3(0, 0, -1),
		parent = self.live2dContainer,
		offset = var_76_0:GetSkinConfig().shop_offset
	})

	var_76_2.shopPreView = true

	pg.UIMgr.GetInstance():LoadingOn()

	self.live2dChar = Live2DPainting.New(var_76_2, function(arg_77_0)
		arg_77_0:IgonreReactPos(true)
		self:CheckShowShopHxForL2d(arg_77_0, arg_76_1)

		if self.paintingState and self.paintingState.id ~= arg_76_1.id then
			self:ClearL2dPainting()
		end

		arg_77_0:setSortingLayer(LayerWeightConst.L2D_DEFAULT_LAYER)
		pg.UIMgr.GetInstance():LoadingOff()

		return
	end)

	return
end

function LatestSkinShopLayer:ClearL2dPainting()
	if self.live2dChar then
		self:RevertShopHxForL2d(self.live2dChar)
		self.live2dChar:Dispose()

		self.live2dChar = nil
	end

	return
end

function LatestSkinShopLayer:LoadSpinePainting(arg_79_1)
	local var_79_0

	if pg.ship_skin_template[self.skinId].skin_type == ShipSkin.SKIN_TYPE_TB then
		var_79_0 = VirtualEducateCharShip.New(NewEducateHelper.GetSecIdBySkinId(self.skinId))
	else
		local var_79_1 = {
			noChangeSkin = true
		}

		var_79_1.configId = ShipGroup.getDefaultShipConfig(pg.ship_skin_template[self.skinId].ship_group).id
		var_79_1.skin_id = self.skinId
		var_79_0 = Ship.New(var_79_1)
	end

	local var_79_2 = SpinePainting.GenerateData({
		ship = var_79_0,
		position = Vector3(0, 0, 0),
		parent = self.spTF,
		effectParent = self.spBg,
		offset = var_79_0:GetSkinConfig().shop_offset
	})

	pg.UIMgr.GetInstance():LoadingOn()

	self.spinePainting = SpinePainting.New(var_79_2, function(arg_80_0)
		arg_80_0:SetShopHx(true)

		if self.paintingState and self.paintingState.id ~= arg_79_1.id then
			self:ClearSpinePainting()
		end

		self:CheckShowShopHx((arg_80_0._tf:Find("shop_hx")))
		self:CheckShowShopHx((arg_80_0._tf:Find("shop_hx_ch" .. pg.SdkMgr.GetInstance():GetChannelUIDIncludeHarmony())))
		pg.UIMgr.GetInstance():LoadingOff()

		return
	end)

	return
end

function LatestSkinShopLayer:ClearSpinePainting()
	if self.spinePainting and self.spinePainting._tf then
		local var_81_0 = self.spinePainting._tf:Find("shop_hx")

		self:RevertShopHx(self.shopHx)
		self.spinePainting:Dispose()

		self.spinePainting = nil
	end

	return
end

function LatestSkinShopLayer:CheckShowShopHx(arg_82_1)
	if IsNil(arg_82_1) then
		return
	end

	setActive(arg_82_1, false)

	if PLATFORM_CODE ~= PLATFORM_CH then
		return
	end

	if not HXSet.isHx() then
		return
	end

	setActive(arg_82_1, true)

	return
end

function LatestSkinShopLayer:RevertShopHx(arg_83_1)
	if not IsNil(arg_83_1) then
		setActive(arg_83_1, false)
	end

	return
end

function LatestSkinShopLayer:CheckShowShopHxForL2d(arg_84_1, arg_84_2)
	if PLATFORM_CODE ~= PLATFORM_CH then
		return
	end

	if not HXSet.isHx() then
		return
	end

	arg_84_1:changeParamaterValue("shop_hx", 1)

	return
end

function LatestSkinShopLayer:RevertShopHxForL2d(arg_85_1)
	arg_85_1:changeParamaterValue("shop_hx", 0)

	return
end

function LatestSkinShopLayer:AdjustPainting(arg_86_1)
	if pg.ship_skin_newmainui_shift[self.skinId] then
		local var_86_0 = pg.ship_skin_newmainui_shift[self.skinId].skin_shop_shift

		self.paintingTF.anchoredPosition = arg_86_1 and Vector2(var_86_0[1] - 440, var_86_0[2] + self.defaultPaintingPosition.y) or Vector2(var_86_0[1] + self.defaultPaintingPosition.x, var_86_0[2] + self.defaultPaintingPosition.y)
		self.paintingTF.localScale = Vector3(var_86_0[4], var_86_0[4], 1)
	else
		self.paintingTF.anchoredPosition = Vector2(self.defaultPaintingPosition.x, self.defaultPaintingPosition.y)
		self.paintingTF.localScale = self.defaultPaintingScale
	end

	return
end

function LatestSkinShopLayer:FlushBG(arg_87_1, arg_87_2)
	local var_87_0 = pg.ship_skin_template[self.skinId]
	local var_87_1

	if pg.ship_skin_template[self.skinId].skin_type == ShipSkin.SKIN_TYPE_TB then
		var_87_1 = VirtualEducateCharShip.New(NewEducateHelper.GetSecIdBySkinId(self.skinId))
	else
		local var_87_2 = {
			id = 999
		}

		var_87_2.configId = ShipGroup.getDefaultShipConfig(var_87_0.ship_group).id
		var_87_2.skin_id = self.skinId
		var_87_1 = Ship.New(var_87_2)
	end

	local var_87_3 = var_87_1:getShipBgPrint(true)

	if (self.isToggleShowBg or not checkABExist("painting/" .. pg.ship_skin_template[self.skinId].painting .. "_n")) and var_87_0.bg_sp ~= "" then
		var_87_3 = var_87_0.bg_sp
	end

	local var_87_4 = var_87_3 ~= var_87_1:rarity2bgPrintForGet()

	if var_87_4 then
		pg.DynamicBgMgr.GetInstance():LoadBg(self, var_87_3, self.bgs:Find("diffBg"), self.bgs:Find("diffBg/bg"), function(arg_88_0)
			if arg_87_2 then
				arg_87_2()
			end

			return
		end, function(arg_89_0)
			if arg_87_2 then
				arg_87_2()
			end

			return
		end)
	else
		pg.DynamicBgMgr.GetInstance():ClearBg(self:getUIName())

		if arg_87_2 then
			arg_87_2()
		end
	end

	setActive(self.bgs:Find("diffBg"), var_87_4)
	setActive(self.bgs:Find("default"), not var_87_4)

	return
end

function LatestSkinShopLayer:FlushDynamicPaintingResState(arg_90_1)
	if not self.isToggleDynamic then
		return
	end

	local var_90_0 = self:GetPaintingState(arg_90_1)
	local var_90_1 = false
	local var_90_2 = ""

	if var_0_2 == var_90_0 then
		var_90_1, var_90_2 = self:ExistL2dRes(pg.ship_skin_template[self.skinId].painting)
	elseif var_0_3 == var_90_0 then
		var_90_1, var_90_2 = self:ExistSpineRes(pg.ship_skin_template[self.skinId].painting)
	end

	setActive(self.dynamicResToggle, not var_90_1)
	removeOnButton(self.dynamicResToggle)

	if not var_90_1 and var_90_2 ~= "" then
		onButton(self, self.dynamicResToggle, function()
			self:DownloadDynamicPainting(var_90_2, arg_90_1)

			return
		end, SFX_PANEL)
	end

	return
end

function LatestSkinShopLayer:DownloadDynamicPainting(arg_92_1, arg_92_2)
	local var_92_0 = self.skinId

	if self.downloads[self.skinId] then
		return
	end

	local var_92_1 = SkinShopDownloadRequest.New()

	self.downloads[self.skinId] = var_92_1

	var_92_1:Start(arg_92_1, function(arg_93_0)
		if arg_93_0 and self.paintingState and self.paintingState.id == arg_92_2.id then
			self:FlushPainting(arg_92_2)
			self:FlushDynamicPaintingResState(arg_92_2)
		end

		var_92_1:Dispose()

		self.downloads[var_92_0] = nil

		return
	end)

	return
end

function LatestSkinShopLayer:GetPaintingState(arg_94_1)
	if self.isToggleDynamic and (self.shipSkin:IsLive2d() or self.shipSkin:IsLive2dPlus()) then
		return var_0_2
	elseif self.isToggleDynamic and (self.shipSkin:IsSpine() or self.shipSkin:IsSpinePlus()) then
		if self.shipSkin:getConfig("spine_use_live2d") == 1 then
			return var_0_2
		end

		return var_0_3
	else
		return var_0_1
	end

	return
end

function LatestSkinShopLayer:ExistL2dRes(arg_95_1)
	local var_95_0 = HXSet.autoHxShiftPath("live2d/" .. string.lower(arg_95_1), nil, true)

	return checkABExist(var_95_0), var_95_0
end

function LatestSkinShopLayer:ExistSpineRes(arg_96_1)
	local var_96_0 = HXSet.autoHxShiftPath("SpinePainting/" .. string.lower(arg_96_1), nil, true)

	return checkABExist(var_96_0), var_96_0
end

function LatestSkinShopLayer:RecordFlag(arg_97_1)
	PlayerPrefs.SetInt("skinShop#l2dPreViewToggle" .. getProxy(PlayerProxy):getRawData().id, arg_97_1 and 1 or 0)
	PlayerPrefs.Save()
	self:emit(LatestSkinShopMediator.ON_RECORD_ANIM_PREVIEW_BTN, arg_97_1)

	return
end

function LatestSkinShopLayer:FlushPrice(arg_98_1)
	local var_98_0 = arg_98_1:getConfig("genre") == ShopArgs.SkinShopTimeLimit
	local var_98_1 = arg_98_1.type == Goods.TYPE_ACTIVITY or arg_98_1.type == Goods.TYPE_ACTIVITY_EXTRA

	if var_98_0 then
		if self.mode == NewSkinShopScene.MODE_EXPERIENCE_FOR_ITEM then
			self:UpdateExperiencePrice4Item(arg_98_1)
		else
			self:UpdateExperiencePrice(arg_98_1)
		end
	elseif self.isPreviewFurniture then
		self:UpdateFurniturePrice(arg_98_1)
	elseif var_98_1 then
		-- block empty
	else
		self:UpdateCommodityPrice(arg_98_1)
	end

	local var_98_2 = arg_98_1.type == Goods.TYPE_SKIN

	setActive(self.price:Find("timeLimit"), var_98_0 and not var_98_1)
	setActive(self.price:Find("consume"), var_98_2 and not var_98_0 and not var_98_1)

	return
end

function LatestSkinShopLayer:UpdateExperiencePrice4Item(arg_99_1)
	local var_99_0 = arg_99_1:getConfig("resource_num")
	local var_99_1 = _.detect(getProxy(BagProxy):GetSkinExperienceItems(), function(arg_100_0)
		return arg_100_0:CanUseForShop(arg_99_1.id)
	end)
	local var_99_2

	if var_99_1 then
		var_99_2 = var_99_1.count or 0

		local var_99_3

		if var_99_2 < var_99_0 then
			var_99_3 = "<color=" .. COLOR_RED .. ">" or ""
		end
	end

	setText(self.price:Find("timeLimit/consume/Text"), (var_99_3 .. var_99_2 .. (var_99_2 < var_99_0 and "</color>" or "")) .. "/" .. var_99_0)

	return
end

function LatestSkinShopLayer:UpdateExperiencePrice(arg_101_1)
	local var_101_0 = arg_101_1:getConfig("resource_num")
	local var_101_1 = getProxy(PlayerProxy):getRawData():getSkinTicket()

	setText(self.price:Find("timeLimit/consume/Text"), (((var_101_1 < var_101_0 or nil) and ("<color=" .. COLOR_RED .. ">" or "")) .. var_101_1 .. (var_101_1 < var_101_0 and "</color>" or "")) .. "/" .. var_101_0)

	return
end

function LatestSkinShopLayer:UpdateCommodityPrice(arg_102_1)
	local var_102_0 = arg_102_1:GetPrice()
	local var_102_1 = arg_102_1:getConfig("resource_num")

	setText(self.price:Find("consume/Text"), var_102_0)
	setText(self.price:Find("consume/originalprice/Text"), var_102_1)
	setActive(self.price:Find("consume/originalprice"), var_102_0 ~= var_102_1)

	return
end

function LatestSkinShopLayer:UpdateFurniturePrice(arg_103_1)
	local var_103_0 = Furniture.New({
		id = Goods.Id2FurnitureId(arg_103_1.id)
	})
	local var_103_1 = var_103_0:getConfig("gem_price")

	setText(self.price:Find("consume/originalprice/Text"), var_103_1)

	local var_103_2 = var_103_0:getPrice(PlayerConst.ResDiamond)

	setText(self.price:Find("consume/Text"), var_103_2)
	setActive(self.price:Find("consume/originalprice"), var_103_1 ~= var_103_2)

	return
end

function LatestSkinShopLayer:FlushObtainBtn(arg_104_1)
	local var_104_0 = self:GetObtainBtnState(arg_104_1)
	local var_104_1 = var_0_19(var_104_0)

	for iter_104_0 = 0, self.btns.childCount - 1 do
		local var_104_2 = self.btns:GetChild(iter_104_0)

		setActive(var_104_2, var_104_2.name == var_104_1)
	end

	setActive(self.price:Find("btn/item"), var_104_0 == var_0_11)
	setActive(self.price:Find("btn/tag"), var_104_0 == var_0_11)

	if var_104_0 == var_0_11 then
		self:FlushGift(arg_104_1)
	end

	onButton(self, self.price:Find("btn"), function()
		local var_105_0 = {}
		local var_105_1 = SkinCouponActivity.StaticEncoreActTip(arg_104_1.id)

		if tobool(var_105_1) then
			table.insert(var_105_0, function(arg_106_0)
				pg.MsgboxMgr.GetInstance():ShowMsgBox({
					content = i18n("SkinDiscount_Hint"),
					onYes = function()
						if var_105_1 and not var_105_1:isEnd() then
							self:emit(LatestSkinShopMediator.OPEN_ACTIVITY, var_105_1.id)
						end

						return
					end,
					onNo = arg_106_0
				})

				return
			end)
		end

		if arg_104_1:getConfig("genre") == ShopArgs.SkinShop and not arg_104_1:IsItemDiscountType() and #SkinCouponActivity.GetOvercountEncoreActs(arg_104_1.id) > 0 then
			table.insert(var_105_0, function(arg_108_0)
				pg.MsgboxMgr.GetInstance():ShowMsgBox({
					content = i18n("SkinDiscount_Last_Coupon"),
					onYes = arg_108_0
				})

				return
			end)
		end

		seriesAsync(var_105_0, function()
			if var_104_0 == var_0_5 or var_104_0 == var_0_7 or var_104_0 == var_0_11 then
				self.purchaseView:ExecuteAction("Show", arg_104_1)
			else
				self:OnClickBtn(var_104_0, arg_104_1)
			end

			return
		end)

		return
	end, SFX_PANEL)

	return
end

function LatestSkinShopLayer:GetObtainBtnState(arg_110_1)
	if arg_110_1:getConfig("genre") == ShopArgs.SkinShopTimeLimit then
		return var_0_9
	elseif self.isPreviewFurniture then
		if getProxy(DormProxy):getRawData():HasFurniture(Goods.Id2FurnitureId(arg_110_1.id)) then
			return var_0_4
		else
			return var_0_8
		end
	elseif arg_110_1.type == Goods.TYPE_ACTIVITY or arg_110_1.type == Goods.TYPE_ACTIVITY_EXTRA then
		return var_0_6
	elseif arg_110_1.buyCount > 0 then
		return var_0_4
	elseif arg_110_1:isDisCount() and arg_110_1:IsItemDiscountType() then
		return var_0_7
	elseif arg_110_1:CanUseVoucherType() or arg_110_1:ExistExclusiveDiscountItem() then
		return var_0_10
	elseif #arg_110_1:GetGiftList() > 0 then
		return var_0_11
	else
		return var_0_5
	end

	return
end

function LatestSkinShopLayer:FlushGift(arg_111_1)
	local var_111_0 = arg_111_1:GetGiftList()[1]

	updateDrop(self.price:Find("btn/item/mask/item"), {
		type = var_111_0.type,
		id = var_111_0.id,
		count = var_111_0.count
	})

	return
end

function LatestSkinShopLayer:OnClickBtn(arg_112_1, arg_112_2)
	if arg_112_1 == var_0_5 or arg_112_1 == var_0_7 or arg_112_1 == var_0_11 then
		self:OnPurchase(arg_112_2)
	elseif arg_112_1 == var_0_10 then
		self:OnItemPurchase(arg_112_2)
	elseif arg_112_1 == var_0_6 then
		self:OnActivity(arg_112_2)
	elseif arg_112_1 == var_0_8 then
		self:OnBackyard(arg_112_2)
	elseif arg_112_1 == var_0_9 then
		if self.mode == NewSkinShopScene.MODE_EXPERIENCE_FOR_ITEM then
			self:OnExperience4Item(arg_112_2)
		else
			self:OnExperience(arg_112_2)
		end
	end

	return
end

function LatestSkinShopLayer:FlushGifgPackBtn(arg_113_1)
	local var_113_0 = false
	local var_113_1
	local var_113_2
	local var_113_3

	for iter_113_0, iter_113_1 in pairs(self.giftSkinCommodities) do
		for iter_113_2, iter_113_3 in ipairs(iter_113_1) do
			if iter_113_3.id == arg_113_1.id then
				var_113_0 = true

				break
			end
		end

		if var_113_0 then
			var_113_1 = self.giftPackCommodities[iter_113_0]
			var_113_2 = self.giftSkinCommodities[iter_113_0]
			var_113_3 = self.giftSkinProbabilitys[iter_113_0]

			break
		end
	end

	if var_113_0 then
		setText(self.giftPackBtn:Find("title"), i18n("skinshop_on_sale_tip_2"))
		onButton(self, self.giftPackBtn, function()
			if not var_113_1:isChargeType() then
				return
			end

			local var_114_0 = var_113_1:GetSkinProbability()

			if #var_114_0 <= 0 or #var_114_0 ~= #getProxy(ShipSkinProxy):GetProbabilitySkins(var_114_0) then
				self:emit(LatestSkinShopMediator.OPEN_SCENE, {
					SCENE.CHARGE,
					{
						wrap = ChargeScene.TYPE_PICK
					}
				})
			else
				self:emit(LatestSkinShopMediator.OPEN_GIFT_PACK_LAYER, var_113_1, var_113_2, var_113_3)
			end

			return
		end, SFX_PANEL)
	else
		var_113_0 = getProxy(ActivityProxy):GetFakeGiftPackActivity(arg_113_1)

		if var_113_0 then
			setText(self.giftPackBtn:Find("title"), i18n("skinshop_on_sale_tip"))
			onButton(self, self.giftPackBtn, function()
				self:emit(LatestSkinShopMediator.OPEN_GIFT_ACT_LAYER, var_113_0.id)

				return
			end, SFX_PANEL)
		end
	end

	setActive(self.giftPackBtn, var_113_0)

	return
end

function LatestSkinShopLayer:SetGiftPackLayer()
	return
end

function LatestSkinShopLayer:OnPurchase(arg_117_1)
	if arg_117_1.type ~= Goods.TYPE_SKIN then
		return
	end

	if arg_117_1:isDisCount() and arg_117_1:IsItemDiscountType() then
		self:emit(LatestSkinShopMediator.ON_SHOPPING_BY_ACT, arg_117_1.id, 1)
	else
		self:emit(LatestSkinShopMediator.ON_SHOPPING, arg_117_1.id, 1)
	end

	return
end

function LatestSkinShopLayer:OnItemPurchase(arg_118_1)
	if arg_118_1.type ~= Goods.TYPE_SKIN then
		return
	end

	local var_118_0 = arg_118_1:GetVoucherIdList()
	local var_118_1 = getProxy(BagProxy):GetExclusiveDiscountItem4Shop(arg_118_1.id)

	if #var_118_0 <= 0 and #var_118_1 <= 0 then
		return
	end

	local var_118_2 = {}

	for iter_118_0, iter_118_1 in ipairs(var_118_0) do
		table.insert(var_118_2, iter_118_1)
	end

	for iter_118_2, iter_118_3 in ipairs(var_118_1) do
		table.insert(var_118_2, iter_118_3.id)
	end

	self.voucherMsgBox:ExecuteAction("Show", {
		itemList = var_118_2,
		skinId = self.skinId,
		skinName = SwitchSpecialChar(pg.ship_skin_template[self.skinId].name, true),
		price = arg_118_1:GetPrice(),
		onYes = function(arg_119_0)
			if arg_119_0 then
				self:emit(LatestSkinShopMediator.ON_ITEM_PURCHASE, arg_119_0, arg_118_1.id)
			else
				self:emit(LatestSkinShopMediator.ON_SHOPPING, arg_118_1.id, 1)
			end

			return
		end
	})

	return
end

function LatestSkinShopLayer:OnActivity(arg_120_1)
	local var_120_0 = arg_120_1:getConfig("activity")
	local var_120_1 = getProxy(ActivityProxy):getActivityById(var_120_0)

	if var_120_0 == 0 then
		if not pg.TimeMgr.GetInstance():inTime((arg_120_1:getConfig("time"))) then
			if var_120_1 and not var_120_1:isEnd() then
				if arg_120_1.type == Goods.TYPE_ACTIVITY then
					self:emit(LatestSkinShopMediator.GO_SHOPS_LAYER, arg_120_1:getConfig("activity"))
				elseif arg_120_1.type == Goods.TYPE_ACTIVITY_EXTRA then
					local var_120_2 = arg_120_1:getConfig("scene")

					if var_120_2 and #var_120_2 > 0 then
						self:emit(LatestSkinShopMediator.OPEN_SCENE, var_120_2)
					else
						self:emit(LatestSkinShopMediator.OPEN_ACTIVITY, var_120_0)
					end
				end

				goto label_120_0
			end
		end
	end

	pg.TipsMgr.GetInstance():ShowTips(i18n("common_activity_not_start"))

	::label_120_0::

	return
end

function LatestSkinShopLayer:OnBackyard(arg_121_1)
	if not pg.SystemOpenMgr.GetInstance():isOpenSystem(getProxy(PlayerProxy):getRawData().level, "BackYardMediator") then
		pg.TipsMgr.GetInstance():ShowTips(i18n("no_open_system_tip", pg.open_systems_limited[1].name, pg.open_systems_limited[1].level))

		return
	end

	self:emit(LatestSkinShopMediator.ON_BACKYARD_SHOP)

	return
end

function LatestSkinShopLayer:OnExperience(arg_122_1)
	local var_122_0 = getProxy(ShipSkinProxy):getSkinById(self.skinId)

	if var_122_0 and not var_122_0:isExpireType() then
		pg.TipsMgr.GetInstance():ShowTips(i18n("already_have_the_skin"))

		return
	end

	local var_122_1 = arg_122_1:getConfig("resource_num")
	local var_122_2, var_122_3, var_122_4, var_122_5 = pg.TimeMgr.GetInstance():parseTimeFrom(arg_122_1:getConfig("time_second") * var_122_1)

	pg.MsgboxMgr.GetInstance():ShowMsgBox({
		content = i18n("exchange_limit_skin_tip", var_122_1, pg.ship_skin_template[self.skinId].name, var_122_2, var_122_3),
		onYes = function()
			if getProxy(PlayerProxy):getRawData():getSkinTicket() < var_122_1 then
				pg.TipsMgr.GetInstance():ShowTips(i18n("common_no_item_1"))

				return
			end

			self:emit(LatestSkinShopMediator.ON_SHOPPING, arg_122_1.id, 1)

			return
		end
	})

	return
end

function LatestSkinShopLayer:OnExperience4Item(arg_124_1)
	local var_124_0 = getProxy(ShipSkinProxy):getSkinById(self.skinId)

	if var_124_0 and not var_124_0:isExpireType() then
		pg.TipsMgr.GetInstance():ShowTips(i18n("already_have_the_skin"))

		return
	end

	local var_124_1 = arg_124_1:getConfig("resource_num")
	local var_124_2, var_124_3, var_124_4, var_124_5 = pg.TimeMgr.GetInstance():parseTimeFrom(arg_124_1:getConfig("time_second") * var_124_1)
	local var_124_6 = _.detect(getProxy(BagProxy):GetSkinExperienceItems(), function(arg_125_0)
		return arg_125_0:CanUseForShop(arg_124_1.id)
	end)

	pg.MsgboxMgr.GetInstance():ShowMsgBox({
		content = i18n("exchange_limit_skin_tip", var_124_1, pg.ship_skin_template[self.skinId].name, var_124_2, var_124_3),
		onYes = function()
			if not var_124_6 or var_124_6.count < var_124_1 then
				pg.TipsMgr.GetInstance():ShowTips(i18n("common_no_item_1"))

				return
			end

			self:emit(LatestSkinShopMediator.ON_ITEM_EXPERIENCE, var_124_6.id, arg_124_1.id, 1)

			return
		end
	})

	return
end

function LatestSkinShopLayer:SetFilterPanel()
	local var_127_0 = self.filterContent:Find("camp/options")
	local var_127_1 = self.filterContent:Find("rarity/options")
	local var_127_2 = self.filterContent:Find("shipType/options")
	local var_127_3 = self.filterContent:Find("themeType/options")

	self:SetOptionList(var_127_0, ShipIndexConst.CampNames, true)
	self:SetOptionList(var_127_1, ShipIndexConst.RarityNames, true)
	self:SetOptionList(var_127_2, ShipIndexConst.TypeNames, true)
	self:SetOptionList(var_127_3, self.classifyNames)
	self:SetSingleOptions(self.filterContent:Find("own/options"), "ownType")
	self:SetMultiOptions(self.filterContent:Find("type/options"), "typeType")
	self:SetSingleOptions(self.filterContent:Find("shipHave/options"), "shipHaveType")
	self:SetMultiOptions(var_127_0, "campType")
	self:SetMultiOptions(var_127_1, "rarityType")
	self:SetMultiOptions(var_127_2, "shipType")
	self:SetMultiOptions(var_127_3, "themeType")
	self:SetMultiOptions(self.filterContent:Find("tag/options"), "tagType")
	self:HideEmptyOptions()
	onButton(self, self.filterUI:Find("bg"), function()
		for iter_128_0, iter_128_1 in pairs(self.filterValues) do
			self.filterValuesTemp[iter_128_0] = Clone(self.filterValues[iter_128_0])
		end

		setActive(self.filterUI, false)

		return
	end, SFX_PANEL)
	onButton(self, self.filterUI:Find("panelMask/panel/closeBtn"), function()
		for iter_129_0, iter_129_1 in pairs(self.filterValues) do
			self.filterValuesTemp[iter_129_0] = Clone(self.filterValues[iter_129_0])
		end

		setActive(self.filterUI, false)

		return
	end, SFX_PANEL)
	onButton(self, self.filterUI:Find("panelMask/panel/bottom/ok"), function()
		for iter_130_0, iter_130_1 in pairs(self.filterValues) do
			self.filterValues[iter_130_0] = Clone(self.filterValuesTemp[iter_130_0])
		end

		setActive(self.filterUI, false)
		self:Refresh(true)

		return
	end, SFX_PANEL)

	return
end

function LatestSkinShopLayer:OpenFilterPanel()
	setActive(self.filterUI, true)
	self:SetSingleOptions(self.filterContent:Find("own/options"), "ownType", true)
	self:SetMultiOptions(self.filterContent:Find("type/options"), "typeType", true)
	self:SetSingleOptions(self.filterContent:Find("shipHave/options"), "shipHaveType", true)
	self:SetMultiOptions(self.filterContent:Find("camp/options"), "campType", true)
	self:SetMultiOptions(self.filterContent:Find("rarity/options"), "rarityType", true)
	self:SetMultiOptions(self.filterContent:Find("shipType/options"), "shipType", true)
	self:SetMultiOptions(self.filterContent:Find("themeType/options"), "themeType", true)
	self:SetMultiOptions(self.filterContent:Find("tag/options"), "tagType", true)

	return
end

function LatestSkinShopLayer:SetOptionList(arg_132_1, arg_132_2, arg_132_3)
	local var_132_0 = UIItemList.New(arg_132_1, arg_132_1:GetChild(0))

	var_132_0:make(function(arg_133_0, arg_133_1, arg_133_2)
		if arg_133_0 == UIItemList.EventUpdate then
			local var_133_0 = arg_132_2[arg_133_1 + 1]

			if arg_132_3 then
				var_133_0 = i18n(var_133_0)
			end

			arg_133_2.name = arg_133_1

			setScrollText(arg_133_2:Find("mask/Text"), var_133_0)
		end

		return
	end)
	var_132_0:align(#arg_132_2)

	return
end

function LatestSkinShopLayer:SetSingleOptions(arg_134_1, arg_134_2, arg_134_3)
	for iter_134_0 = 0, arg_134_1.childCount - 1 do
		local var_134_0 = arg_134_1:GetChild(iter_134_0)

		self:SetOptionSelect(arg_134_1:GetChild(iter_134_0), iter_134_0 == self.filterValuesTemp[arg_134_2])

		if not arg_134_3 then
			onButton(self, var_134_0, function()
				self.filterValuesTemp[arg_134_2] = iter_134_0

				for iter_135_0 = 0, arg_134_1.childCount - 1 do
					self:SetOptionSelect(arg_134_1:GetChild(iter_135_0), iter_135_0 == iter_134_0)
				end

				return
			end, SFX_PANEL)
		end
	end

	return
end

function LatestSkinShopLayer:SetMultiOptions(arg_136_1, arg_136_2, arg_136_3)
	for iter_136_0 = 0, arg_136_1.childCount - 1 do
		local var_136_0 = arg_136_1:GetChild(iter_136_0)

		self:SetOptionSelect(arg_136_1:GetChild(iter_136_0), table.contains(self.filterValuesTemp[arg_136_2], iter_136_0))

		if not arg_136_3 then
			onButton(self, var_136_0, function()
				if iter_136_0 == 0 then
					self.filterValuesTemp[arg_136_2] = {
						0
					}

					for iter_137_0 = 0, arg_136_1.childCount - 1 do
						self:SetOptionSelect(arg_136_1:GetChild(iter_137_0), iter_137_0 == 0)
					end
				else
					table.removebyvalue(self.filterValuesTemp[arg_136_2], 0)

					if table.contains(self.filterValuesTemp[arg_136_2], iter_136_0) then
						table.removebyvalue(self.filterValuesTemp[arg_136_2], iter_136_0)
					else
						table.insert(self.filterValuesTemp[arg_136_2], iter_136_0)
					end

					local var_137_0 = true

					for iter_137_1 = 1, arg_136_1.childCount - 1 do
						if not table.contains(self.filterValuesTemp[arg_136_2], iter_137_1) and arg_136_1:GetChild(iter_137_1).gameObject.activeSelf then
							var_137_0 = false

							break
						end
					end

					if (#self.filterValuesTemp[arg_136_2] == 0 or nil) and true and arg_136_2 ~= "tagType" then
						self.filterValuesTemp[arg_136_2] = {
							0
						}
					end

					for iter_137_2 = 0, arg_136_1.childCount - 1 do
						self:SetOptionSelect(arg_136_1:GetChild(iter_137_2), table.contains(self.filterValuesTemp[arg_136_2], iter_137_2))
					end
				end

				return
			end, SFX_PANEL)
		end
	end

	return
end

function LatestSkinShopLayer:SetOptionSelect(arg_138_1, arg_138_2)
	setActive(arg_138_1:Find("selectedFrame"), arg_138_2)

	;(IsNil(arg_138_1:Find("Text")) and arg_138_1:Find("mask/Text"):GetComponent(typeof(Text)) or arg_138_1:Find("Text"):GetComponent(typeof(Text))).color = arg_138_2 and Color.New(1, 1, 1, 1) or Color.New(0, 0, 0, 0.5)

	return
end

function LatestSkinShopLayer:HideEmptyOptions(arg_139_1, arg_139_2)
	local var_139_0 = {
		typeType = {
			0
		},
		shipHaveType = {
			0
		},
		campType = {
			0
		},
		rarityType = {
			0
		},
		shipType = {
			0
		},
		tagType = {
			0
		}
	}

	for iter_139_0, iter_139_1 in ipairs(self.commodities) do
		local var_139_1 = ShipSkin.New({
			id = iter_139_1:getSkinId()
		})

		for iter_139_2, iter_139_3 in ipairs((self:GetSkinType(var_139_1))) do
			if not table.keyof(var_139_0.typeType, iter_139_3) then
				table.insert(var_139_0.typeType, iter_139_3)
			end
		end

		local var_139_2 = self:GetShipHave(var_139_1)

		if not table.keyof(var_139_0.shipHaveType, var_139_2) then
			table.insert(var_139_0.shipHaveType, var_139_2)
		end

		local var_139_3 = self:GetCampType(var_139_1)

		if not table.keyof(var_139_0.campType, var_139_3) then
			table.insert(var_139_0.campType, var_139_3)
		end

		local var_139_4 = self:GetRarityType(var_139_1)

		if not table.keyof(var_139_0.rarityType, var_139_4) then
			table.insert(var_139_0.rarityType, var_139_4)
		end

		local var_139_5 = self:GetShipType(var_139_1)

		if not table.keyof(var_139_0.shipType, var_139_5) then
			table.insert(var_139_0.shipType, var_139_5)
		end

		local var_139_6 = self:GetTagType(iter_139_1)

		if not table.keyof(var_139_0.tagType, var_139_6) then
			table.insert(var_139_0.tagType, var_139_6)
		end
	end

	for iter_139_4, iter_139_5 in pairs(var_139_0) do
		table.sort(iter_139_5, function(arg_140_0, arg_140_1)
			return arg_140_0 < arg_140_1
		end)
	end

	for iter_139_6 = 1, self.uiTypeOptions.childCount - 1 do
		setActive(self.uiTypeOptions:GetChild(iter_139_6), table.contains(var_139_0.typeType, iter_139_6))
	end

	for iter_139_7 = 1, self.uiShipHaveOptions.childCount - 1 do
		setActive(self.uiShipHaveOptions:GetChild(iter_139_7), table.contains(var_139_0.shipHaveType, iter_139_7))
	end

	for iter_139_8 = 1, self.uiCampOptions.childCount - 1 do
		setActive(self.uiCampOptions:GetChild(iter_139_8), table.contains(var_139_0.campType, iter_139_8))
	end

	for iter_139_9 = 1, self.uiRrarityOptions.childCount - 1 do
		setActive(self.uiRrarityOptions:GetChild(iter_139_9), table.contains(var_139_0.rarityType, iter_139_9))
	end

	for iter_139_10 = 1, self.uiShipTypeOptions.childCount - 1 do
		setActive(self.uiShipTypeOptions:GetChild(iter_139_10), table.contains(var_139_0.shipType, iter_139_10))
	end

	for iter_139_11 = 1, self.uiTagTypeOptions.childCount - 1 do
		setActive(self.uiTagTypeOptions:GetChild(iter_139_11), table.contains(var_139_0.tagType, iter_139_11))
	end

	return
end

function LatestSkinShopLayer:GetSkinType(arg_141_1)
	local var_141_0 = {}

	if arg_141_1:IsLive2d() or arg_141_1:IsLive2dPlus() then
		table.insert(var_141_0, 1)
	end

	if not arg_141_1:IsLive2d() and not arg_141_1:IsLive2dPlus() and not arg_141_1:IsSpine() and not arg_141_1:IsSpinePlus() then
		table.insert(var_141_0, 2)
	end

	if arg_141_1:IsSpine() or arg_141_1:IsSpinePlus() then
		table.insert(var_141_0, 3)
	end

	if arg_141_1:IsBG() then
		table.insert(var_141_0, 4)
	end

	if arg_141_1:IsDbg() then
		table.insert(var_141_0, 5)
	end

	if arg_141_1:isBgm() then
		table.insert(var_141_0, 6)
	end

	return var_141_0
end

function LatestSkinShopLayer:GetShipHave(arg_142_1)
	if arg_142_1:CantUse() then
		return 2
	else
		return 1
	end

	return
end

function LatestSkinShopLayer:GetCampType(arg_143_1)
	local var_143_0 = arg_143_1:GetDefaultShipConfig()

	if not var_143_0 then
		return 0
	end

	local var_143_1 = self:ToVShip(var_143_0):getNation()

	for iter_143_0, iter_143_1 in ipairs(ShipIndexCfg.camp) do
		for iter_143_2, iter_143_3 in ipairs(iter_143_1.types) do
			if iter_143_3 == Nation.LINK then
				if var_143_1 >= Nation.LINK then
					return iter_143_0 - 1
				end
			elseif var_143_1 == iter_143_3 then
				return iter_143_0 - 1
			end
		end
	end

	return 0
end

function LatestSkinShopLayer:GetRarityType(arg_144_1)
	local var_144_0 = arg_144_1:GetDefaultShipConfig()

	if not var_144_0 then
		return 0
	end

	local var_144_1 = self:ToVShip(var_144_0):getRarity()

	for iter_144_0, iter_144_1 in ipairs(ShipIndexCfg.rarity) do
		if table.contains(iter_144_1.types, var_144_1) then
			return iter_144_0 - 1
		end
	end

	return 0
end

function LatestSkinShopLayer:GetShipType(arg_145_1)
	local var_145_0 = arg_145_1:GetDefaultShipConfig()

	if not var_145_0 then
		return 0
	end

	local var_145_1 = self:ToVShip(var_145_0):getShipType()

	for iter_145_0, iter_145_1 in ipairs(ShipIndexCfg.type) do
		for iter_145_2, iter_145_3 in pairs(iter_145_1) do
			if table.keyof(iter_145_3, var_145_1) then
				return iter_145_0 - 1
			end
		end
	end

	return 0
end

function LatestSkinShopLayer:GetTagType(arg_146_1)
	local var_146_0 = NewShopSkinCard.GetTagId(arg_146_1, (table.contains(self.returnSkins, arg_146_1.id)))

	if var_146_0 > 0 then
		return var_146_0
	else
		return 0
	end

	return
end

function LatestSkinShopLayer:GetSkinClassify()
	self.classifyIds = {}
	self.classifyNames = {}

	local var_147_0 = {}
	local var_147_1 = {}

	for iter_147_0, iter_147_1 in ipairs(self.commodities) do
		local var_147_2 = self:GetShopTypeIdBySkinId(iter_147_1:getSkinId())
		local var_147_3

		if var_147_2 == 0 then
			var_147_3 = var_0_16 or var_147_2
		end

		var_147_1[var_147_3] = (var_147_1[var_147_3] or 0) + 1
	end

	local var_147_4 = {}

	for iter_147_2, iter_147_3 in ipairs(self.returnSkins) do
		var_147_4[iter_147_3] = true
	end

	if underscore.any(self.commodities, function(arg_148_0)
		return var_147_4[arg_148_0.id]
	end) then
		table.insert(var_147_0, var_0_14)
	end

	for iter_147_4, iter_147_5 in ipairs(pg.skin_page_template.all) do
		if iter_147_5 ~= var_0_17 and iter_147_5 ~= var_0_18 then
			if (var_147_1[iter_147_5] or 0) > 0 then
				table.insert(var_147_0, iter_147_5)
			end
		end
	end

	if self.mode == LatestSkinShopLayer.MODE_EXPERIENCE then
		table.insert(var_147_0, 1, var_0_13)
	end

	if self.mode == LatestSkinShopLayer.MODE_EXPERIENCE_FOR_ITEM then
		table.insert(var_147_0, 1, var_0_15)
	end

	table.insert(var_147_0, 1, var_0_12)

	self.classifyIds = var_147_0

	for iter_147_6, iter_147_7 in ipairs(self.classifyIds) do
		if iter_147_7 == var_0_12 then
			table.insert(self.classifyNames, i18n("shop_filter_all"))
		elseif iter_147_7 == var_0_13 or iter_147_7 == var_0_15 then
			table.insert(self.classifyNames, i18n("shop_filter_trial"))
		elseif iter_147_7 == var_0_14 then
			table.insert(self.classifyNames, i18n("shop_filter_retro"))
		else
			table.insert(self.classifyNames, pg.skin_page_template[iter_147_7].name)
		end
	end

	return
end

function LatestSkinShopLayer:GetShopTypeIdBySkinId(arg_149_1)
	self.shopTypeIdList = self.shopTypeIdList or {}

	if self.shopTypeIdList[arg_149_1] then
		return self.shopTypeIdList[arg_149_1]
	end

	for iter_149_0, iter_149_1 in pairs(pg.ship_skin_template.get_id_list_by_shop_type_id) do
		for iter_149_2, iter_149_3 in ipairs(iter_149_1) do
			self.shopTypeIdList[iter_149_3] = iter_149_0

			if iter_149_3 == arg_149_1 then
				return iter_149_0
			end
		end
	end

	return
end

function LatestSkinShopLayer:OnShopping(arg_150_1)
	if not self.showingCommodity then
		return
	end

	if self.purchaseView and self.purchaseView:GetLoaded() then
		self.purchaseView:Hide()
	end

	if self.showingCommodity.id == arg_150_1 then
		self:GetAllCommodities()
		self:Refresh(true)
	end

	return
end

function LatestSkinShopLayer:OnFurnitureUpdate(arg_151_1)
	if not self.showingCommodity then
		return
	end

	if Goods.ExistFurniture(self.showingCommodity.id) and Goods.Id2FurnitureId(self.showingCommodity.id) == arg_151_1 then
		self:GetAllCommodities()
		self:Refresh(true)
	end

	return
end

function LatestSkinShopLayer:CheckDownloadSkinList(arg_152_1)
	local var_152_0 = {}

	for iter_152_0, iter_152_1 in ipairs(self.commodities) do
		PaintingGroupConst.AddPaintingNameBySkinID(var_152_0, iter_152_1:getSkinId())
	end

	PaintingGroupConst.PaintingDownload({
		isShowBox = true,
		paintingNameList = var_152_0,
		finishFunc = arg_152_1
	})

	return
end

function LatestSkinShopLayer:willExit()
	self:ClearCards()
	ClearLScrollrect(self.scrollrect)
	pg.DynamicBgMgr.GetInstance():ClearBg(self:getUIName())

	if self.live2dChar then
		self.live2dChar:Dispose()

		self.live2dChar = nil
	end

	if self.voucherMsgBox then
		self.voucherMsgBox:Destroy()

		self.voucherMsgBox = nil
	end

	if self.purchaseView then
		self.purchaseView:Destroy()

		self.purchaseView = nil
	end

	for iter_153_0, iter_153_1 in pairs(self.downloads) do
		iter_153_1:Dispose()
	end

	self.downloads = {}

	self:ClearPainting()

	if self.interactionPreview then
		self.interactionPreview:Dispose()

		self.interactionPreview = nil
	end

	self:disposeEvent()
	self:ClearTimer()
	self:ReturnChar()
	self:UnOverlay()

	return
end

function LatestSkinShopLayer:onBackPressed()
	pg.m02:sendNotification(NewShopMainScene.CLOSE_VIEW)

	return
end

return LatestSkinShopLayer
