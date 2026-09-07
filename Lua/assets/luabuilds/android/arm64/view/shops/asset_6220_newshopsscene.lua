local NewShopsScene = class("NewShopsScene", import("..base.BaseUI"))

NewShopsScene.CATEGORY_ACTIVITY = 1
NewShopsScene.CATEGORY_MONTH = 2
NewShopsScene.CATEGORY_SUPPLY = 3
NewShopsScene.TYPE_ACTIVITY = 1
NewShopsScene.TYPE_SHOP_STREET = 2
NewShopsScene.TYPE_MILITARY_SHOP = 3
NewShopsScene.TYPE_QUOTA = 4
NewShopsScene.TYPE_SHAM_SHOP = 5
NewShopsScene.TYPE_FRAGMENT = 6
NewShopsScene.TYPE_GUILD = 7
NewShopsScene.TYPE_MEDAL = 8
NewShopsScene.TYPE_META = 9
NewShopsScene.TYPE_MINI_GAME = 10
NewShopsScene.CATEGORY2NAME = {
	[NewShopsScene.CATEGORY_ACTIVITY] = "activity",
	[NewShopsScene.CATEGORY_MONTH] = "month",
	[NewShopsScene.CATEGORY_SUPPLY] = "supply"
}
NewShopsScene.TYPE2NAME = {
	[NewShopsScene.TYPE_ACTIVITY] = i18n("activity_shop_title"),
	[NewShopsScene.TYPE_SHOP_STREET] = i18n("street_shop_title"),
	[NewShopsScene.TYPE_MILITARY_SHOP] = i18n("military_shop_title"),
	[NewShopsScene.TYPE_QUOTA] = i18n("quota_shop_title1"),
	[NewShopsScene.TYPE_SHAM_SHOP] = i18n("sham_shop_title"),
	[NewShopsScene.TYPE_FRAGMENT] = i18n("fragment_shop_title"),
	[NewShopsScene.TYPE_GUILD] = i18n("guild_shop_title"),
	[NewShopsScene.TYPE_MEDAL] = i18n("medal_shop_title"),
	[NewShopsScene.TYPE_META] = i18n("meta_shop_title"),
	[NewShopsScene.TYPE_MINI_GAME] = i18n("mini_game_shop_title")
}

local var_0_1 = {
	[NewShopsScene.CATEGORY_ACTIVITY] = {
		NewShopsScene.TYPE_ACTIVITY
	},
	[NewShopsScene.CATEGORY_MONTH] = {
		NewShopsScene.TYPE_QUOTA,
		NewShopsScene.TYPE_SHAM_SHOP,
		NewShopsScene.TYPE_MEDAL,
		NewShopsScene.TYPE_FRAGMENT
	},
	[NewShopsScene.CATEGORY_SUPPLY] = {
		NewShopsScene.TYPE_SHOP_STREET,
		NewShopsScene.TYPE_MILITARY_SHOP,
		NewShopsScene.TYPE_GUILD,
		NewShopsScene.TYPE_META,
		NewShopsScene.TYPE_MINI_GAME
	}
}
local var_0_2 = {
	"activity",
	"shopstreet",
	"supplies",
	"quota",
	"sham",
	"fragment",
	"guild",
	"medal",
	"meta",
	"minigame"
}

function NewShopsScene:getUIName()
	return "NewShopsUI"
end

function NewShopsScene:SetPlayer(arg_2_1)
	self.player = arg_2_1

	if self.page then
		self.page:SetPlayer(arg_2_1)
	end

	return
end

function NewShopsScene:SetShops(arg_3_1)
	self.shops = arg_3_1

	self:SortActivityShops()

	return
end

function NewShopsScene:SortActivityShops()
	for iter_4_0, iter_4_1 in pairs(self.shops) do
		if iter_4_0 == NewShopsScene.TYPE_ACTIVITY then
			table.sort(iter_4_1, function(arg_5_0, arg_5_1)
				return arg_5_0:getStartTime() > arg_5_1:getStartTime()
			end)
		end
	end

	return
end

function NewShopsScene:SetShop(arg_6_1, arg_6_2)
	if not self.shops then
		return
	end

	if self.shops[arg_6_1] then
		for iter_6_0, iter_6_1 in ipairs(self.shops[arg_6_1]) do
			if iter_6_1:IsSameKind(arg_6_2) then
				self.shops[arg_6_1][iter_6_0] = arg_6_2

				break
			end
		end
	end

	return
end

function NewShopsScene:OnUpdateItems(arg_7_1)
	self.items = arg_7_1

	if self.page then
		self.page:SetItems(arg_7_1)
	end

	return
end

function NewShopsScene:OnUpdateShop(arg_8_1, arg_8_2)
	self:SetShop(arg_8_1, arg_8_2)

	if self.page == self.pages[arg_8_1] then
		self.page:ExecuteAction("UpdateShop", arg_8_2)
	end

	return
end

function NewShopsScene:OnUpdateCommodity(arg_9_1, arg_9_2, arg_9_3)
	self:SetShop(arg_9_1, arg_9_2)

	if self.page == self.pages[arg_9_1] then
		self.page:ExecuteAction("UpdateCommodity", arg_9_2, arg_9_3)
	end

	return
end

function NewShopsScene:init()
	self.backBtn = self._tf:Find("blur_panel/adapt/top/back_button")
	self.frame = self._tf:Find("blur_panel")
	self.pageContainer = self._tf:Find("frame/bg/pages")
	self.stamp = self._tf:Find("stamp")
	self.switchBtn = self._tf:Find("blur_panel/adapt/switch_btn")
	self.skinBtn = self._tf:Find("blur_panel/adapt/skin_btn")

	setActive(self.skinBtn, not (LOCK_SKIN_SHOP_ENTER and getProxy(PlayerProxy):getData().level < LOCK_SKIN_SHOP_ENTER_LEVEL))

	local var_10_0 = self._tf:Find("frame/bg/pages/scrollrect"):GetComponent("LScrollRect")
	local var_10_1 = self._tf:Find("frame/bg/pages/scrollRectSpecial")

	setActive(go(var_10_0), true)
	setActive(var_10_1, false)

	self.pages = {
		[NewShopsScene.TYPE_ACTIVITY] = ActivityShopPage.New(self.pageContainer, self.event, self.contextData, var_10_0, var_10_1),
		[NewShopsScene.TYPE_SHOP_STREET] = StreetShopPage.New(self.pageContainer, self.event, self.contextData, var_10_0),
		[NewShopsScene.TYPE_MILITARY_SHOP] = MilitaryShopPage.New(self.pageContainer, self.event, self.contextData, var_10_0),
		[NewShopsScene.TYPE_GUILD] = GuildShopPage.New(self.pageContainer, self.event, self.contextData, var_10_0),
		[NewShopsScene.TYPE_SHAM_SHOP] = ShamShopPage.New(self.pageContainer, self.event, self.contextData, var_10_0),
		[NewShopsScene.TYPE_FRAGMENT] = FragmentShopPage.New(self.pageContainer, self.event, self.contextData, var_10_0),
		[NewShopsScene.TYPE_META] = MetaShopPage.New(self.pageContainer, self.event, self.contextData, var_10_0),
		[NewShopsScene.TYPE_MEDAL] = MedalShopPage.New(self.pageContainer, self.event, self.contextData, var_10_0),
		[NewShopsScene.TYPE_QUOTA] = QuotaShopPage.New(self.pageContainer, self.event, self.contextData, var_10_0),
		[NewShopsScene.TYPE_MINI_GAME] = MiniGameShopPage.New(self.pageContainer, self.event, self.contextData, var_10_0)
	}
	self.contextData.singleWindow = ShopSingleWindow.New(self._tf, self.event)
	self.contextData.multiWindow = ShopMultiWindow.New(self._tf, self.event)
	self.contextData.singleWindowForESkin = EquipmentSkinInfoUIForShopWindow.New(self._tf, self.event)
	self.contextData.paintingView = ShopPaintingView.New(self._tf:Find("paint/paint"), self._tf:Find("frame/chat"))

	self.contextData.paintingView:setSecretaryPos(self._tf:Find("paint/secretaryPos"))

	self.contextData.bgView = ShopBgView.New(self._tf:Find("bg"))
	self.recorder = {
		[NewShopsScene.CATEGORY_ACTIVITY] = false,
		[NewShopsScene.CATEGORY_MONTH] = false,
		[NewShopsScene.CATEGORY_SUPPLY] = false
	}
	self.frameTr = self._tf:Find("frame")
	self.categoryUIList = UIItemList.New(self._tf:Find("frame/bg/types"), self._tf:Find("frame/bg/types/tpl"))
	self.shopUIList = UIItemList.New(self._tf:Find("frame/bg/shops"), self._tf:Find("frame/bg/shops/tpl"))

	return
end

function NewShopsScene:didEnter()
	onButton(self, self.backBtn, function()
		self:closeView()

		return
	end, SFX_CANCEL)
	setActive(self.stamp, getProxy(TaskProxy):mingshiTouchFlagEnabled())

	if LOCK_CLICK_MINGSHI then
		setActive(self.stamp, false)
	end

	onButton(self, self.stamp, function()
		getProxy(TaskProxy):dealMingshiTouchFlag(4)

		return
	end, SFX_CONFIRM)
	onButton(self, self.switchBtn, function()
		self:emit(NewShopsMediator.GO_MALL, (self.contextData ~= nil and self.contextData.chargePage ~= nil or nil) and self.contextData.chargePage)

		return
	end, SFX_CANCEL)
	onButton(self, self.skinBtn, function()
		self:emit(NewShopsMediator.ON_SKIN_SHOP)

		return
	end, SFX_PANEL)
	self:InitEntrances()
	self:BlurView()

	self.bulinTip = AprilFoolBulinSubView.ShowAprilFoolBulin(self, self.pageContainer, Vector2.New(-35, -90))

	return
end

function NewShopsScene:InitEntrances()
	self:InitCategory()
	self:ActiveDefaultCategory()

	self.shopType = nil
	self.shopIndex = nil

	return
end

function NewShopsScene:InitCategory()
	self.categoryTrs = {}

	local var_17_0 = {
		NewShopsScene.CATEGORY_MONTH,
		NewShopsScene.CATEGORY_SUPPLY
	}

	if #(self.shops[NewShopsScene.TYPE_ACTIVITY] or {}) > 0 then
		table.insert(var_17_0, NewShopsScene.CATEGORY_ACTIVITY)
	end

	self.categoryUIList:make(function(arg_18_0, arg_18_1, arg_18_2)
		if arg_18_0 == UIItemList.EventUpdate then
			self:UpdateCategory(arg_18_2, var_17_0[arg_18_1 + 1], false)

			self.categoryTrs[var_17_0[arg_18_1 + 1]] = arg_18_2
		end

		return
	end)
	self.categoryUIList:align(#var_17_0)

	return
end

local function var_0_3(arg_19_0, arg_19_1)
	local var_19_0 = arg_19_0:Find("label")
	local var_19_1 = arg_19_0:Find("selected/selected")
	local var_19_2 = arg_19_0:Find("lock"):GetComponent(typeof(Image))

	var_19_2.sprite = GetSpriteFromAtlas("ui/ShopsUI_atlas", NewShopsScene.CATEGORY2NAME[arg_19_1] .. "_lock")

	var_19_2:SetNativeSize()

	local var_19_3 = var_19_0:GetComponent(typeof(Image))

	var_19_3.sprite = GetSpriteFromAtlas("ui/ShopsUI_atlas", NewShopsScene.CATEGORY2NAME[arg_19_1])

	var_19_3:SetNativeSize()

	local var_19_4 = var_19_0:Find("en"):GetComponent(typeof(Image))

	var_19_4.sprite = GetSpriteFromAtlas("ui/ShopsUI_atlas", NewShopsScene.CATEGORY2NAME[arg_19_1] .. "_label")

	var_19_4:SetNativeSize()

	local var_19_5 = var_19_1:GetComponent(typeof(Image))

	var_19_5.sprite = GetSpriteFromAtlas("ui/ShopsUI_atlas", NewShopsScene.CATEGORY2NAME[arg_19_1] .. "_selected")

	var_19_5:SetNativeSize()

	local var_19_6 = var_19_1.parent:Find("en"):GetComponent(typeof(Image))

	var_19_6.sprite = GetSpriteFromAtlas("ui/ShopsUI_atlas", NewShopsScene.CATEGORY2NAME[arg_19_1] .. "_label_selected")

	var_19_6:SetNativeSize()

	return
end

function NewShopsScene:UpdateCategory(arg_20_1, arg_20_2, arg_20_3)
	setActive(arg_20_1:Find("lock"), arg_20_3)
	setActive(arg_20_1:Find("label"), not arg_20_3)
	setActive(arg_20_1:Find("selected"), false)
	var_0_3(arg_20_1, arg_20_2)
	onToggle(self, arg_20_1, function(arg_21_0)
		if arg_21_0 then
			self:InitShops(arg_20_2)

			self.category = arg_20_2

			self:ActiveDefaultShop()
		end

		setActive(arg_20_1:Find("label"), not arg_20_3 and not arg_21_0)
		setActive(arg_20_1:Find("selected"), not arg_20_3 and arg_21_0)

		return
	end, SFX_PANEL)
	setToggleEnabled(arg_20_1, not arg_20_3)

	return
end

function NewShopsScene:InitShops(arg_22_1)
	if self.category and self.category == arg_22_1 then
		return
	end

	local var_22_0 = {}

	self.displayShops = {}
	self.prevBtn = nil

	for iter_22_0, iter_22_1 in pairs(var_0_1[arg_22_1]) do
		for iter_22_2, iter_22_3 in ipairs(self.shops[iter_22_1] or {}) do
			table.insert(var_22_0, {
				type = iter_22_1,
				index = iter_22_2
			})
		end
	end

	self.shopUIList:make(function(arg_23_0, arg_23_1, arg_23_2)
		if arg_23_0 == UIItemList.EventUpdate then
			local var_23_0 = var_22_0[arg_23_1 + 1]
			local var_23_1 = self.pages[var_22_0[arg_23_1 + 1].type]:CanOpen(var_22_0[arg_23_1 + 1], self.player)

			setActive(arg_23_2:Find("unsel/lock"), not var_23_1)

			GetOrAddComponent(arg_23_2:Find("unsel/label"), "CanvasGroup").alpha = var_23_1 and 1 or 0.4

			self:UpdateShop(arg_23_2, var_23_0)

			self.displayShops[var_23_0.type] = self.displayShops[var_23_0.type] or {}
			self.displayShops[var_23_0.type][var_23_0.index] = arg_23_2
		end

		return
	end)
	self.shopUIList:align(#var_22_0)

	return
end

local function var_0_4(arg_24_0, arg_24_1)
	setText(arg_24_0:Find("selected/Text"), NewShopsScene.TYPE2NAME[arg_24_1.type])
	setText(arg_24_0:Find("unsel/label"), NewShopsScene.TYPE2NAME[arg_24_1.type])

	return
end

local function var_0_5(arg_25_0, arg_25_1, arg_25_2)
	local var_25_0 = arg_25_1:Find("unsel")
	local var_25_1 = arg_25_1:Find("selected")

	onButton(arg_25_0, arg_25_1, function()
		if arg_25_0.prevBtn == arg_25_1 then
			return
		end

		if arg_25_2() then
			if arg_25_0.prevBtn then
				setActive(arg_25_0.prevBtn:Find("unsel"), true)
				setActive(arg_25_0.prevBtn:Find("selected"), false)
			end

			setActive(var_25_0, false)
			setActive(var_25_1, true)

			arg_25_0.prevBtn = arg_25_1
		end

		return
	end, SFX_PANEL)
	setActive(var_25_0, true)
	setActive(var_25_1, false)

	return
end

function NewShopsScene:UpdateShop(arg_27_1, arg_27_2)
	var_0_4(arg_27_1, arg_27_2)

	local var_27_0 = arg_27_1:Find("selected")
	local var_27_1 = arg_27_1:Find("unsel")

	var_0_5(self, arg_27_1, function()
		local var_28_0, var_28_1 = self.pages[arg_27_2.type]:CanOpen(self.shops[arg_27_2.type][arg_27_2.index], self.player)

		if var_28_0 then
			if self.page and not self.page:GetLoaded() then
				return
			end

			if self.page then
				self.page:Hide()
			end

			self.contextData.bgView:Init(self.pages[arg_27_2.type]:GetBg(self.shops[arg_27_2.type][arg_27_2.index]))
			self.pages[arg_27_2.type]:ExecuteAction("SetUp", self.shops[arg_27_2.type][arg_27_2.index], self.player, self.items)

			self.page = self.pages[arg_27_2.type]
			self.contextData.activeShop = arg_27_2.type
			self.recorder[self.category] = arg_27_2

			return true
		else
			pg.TipsMgr.GetInstance():ShowTips(var_28_1)
		end

		return false
	end)

	return
end

function NewShopsScene:ActiveDefaultCategory()
	local var_29_0 = self.contextData.warp or self.contextData.activeShop or NewShopsScene.TYPE_ACTIVITY

	if type(var_29_0) == "string" then
		var_29_0 = defaultValue(table.indexof(var_0_2, var_29_0), NewShopsScene.TYPE_ACTIVITY)
	end

	local var_29_1 = self.contextData.index or 1

	if var_29_0 == NewShopsScene.TYPE_ACTIVITY and self.contextData.actId then
		for iter_29_0, iter_29_1 in ipairs(self.shops[var_29_0] or {}) do
			if iter_29_1.activityId == self.contextData.actId then
				var_29_1 = iter_29_0

				break
			end
		end
	elseif var_29_0 == NewShopsScene.TYPE_ACTIVITY then
		if self.shops[NewShopsScene.TYPE_ACTIVITY] then
			if #(self.shops[NewShopsScene.TYPE_ACTIVITY] or {}) <= 0 then
				var_29_0 = NewShopsScene.TYPE_SHOP_STREET
				var_29_1 = 1
			elseif var_29_0 == NewShopsScene.TYPE_ACTIVITY and self.shops[NewShopsScene.TYPE_ACTIVITY] then
				if #(self.shops[NewShopsScene.TYPE_ACTIVITY] or {}) > 0 and not self.contextData.actId then
					for iter_29_2, iter_29_3 in ipairs(self.shops[var_29_0] or {}) do
						if self.shops[var_29_0][1].activityId < iter_29_3.activityId then
							-- block empty
						end
					end
				end
			end
		end
	end

	local var_29_7

	for iter_29_4, iter_29_5 in pairs(var_0_1) do
		if table.contains(iter_29_5, var_29_0) then
			var_29_7 = iter_29_4

			break
		end
	end

	assert(var_29_7 and self.categoryTrs[var_29_7])

	self.shopType = var_29_0
	self.shopIndex = var_29_1

	triggerToggle(self.categoryTrs[var_29_7], true)

	return
end

function NewShopsScene:ActiveDefaultShop()
	local var_30_0
	local var_30_1

	if self.recorder[self.category] then
		var_30_1 = self.recorder[self.category].index
		var_30_0 = self.recorder[self.category].type
	else
		var_30_0, var_30_1 = self.shopType, self.shopIndex or 1
	end

	local function var_30_2()
		local var_31_0

		for iter_31_0, iter_31_1 in pairs(self.displayShops) do
			for iter_31_2, iter_31_3 in pairs(iter_31_1) do
				if self.pages[iter_31_0]:CanOpen(nil, self.player) then
					var_31_0 = var_31_0 or iter_31_3
				end
			end
		end

		if var_31_0 then
			triggerButton(var_31_0)
		end

		return
	end

	if not var_30_0 then
		var_30_2()

		return
	end

	local var_30_3, var_30_4 = self.pages[var_30_0]:CanOpen(nil, self.player)

	if var_30_3 and self.displayShops[var_30_0] and self.displayShops[var_30_0][var_30_1] then
		triggerButton(self.displayShops[var_30_0][var_30_1])
	else
		if not var_30_3 then
			pg.TipsMgr.GetInstance():ShowTips(var_30_4)
		end

		var_30_2()
	end

	return
end

function NewShopsScene:onBackPressed()
	if self.contextData.singleWindow:GetLoaded() and self.contextData.singleWindow:isShowing() then
		self.contextData.singleWindow:Close()

		return
	end

	if self.contextData.multiWindow:GetLoaded() and self.contextData.multiWindow:isShowing() then
		self.contextData.multiWindow:Close()

		return
	end

	if self.contextData.singleWindowForESkin:GetLoaded() and self.contextData.singleWindowForESkin:isShowing() then
		self.contextData.singleWindowForESkin:Hide()

		return
	end

	NewShopsScene.super.onBackPressed(self)

	return
end

function NewShopsScene:BlurView()
	local var_33_0 = self.frameTr:Find("bg/blur")

	pg.UIMgr.GetInstance():OverlayPanel(self.frameTr, {
		pbList = {
			self.frameTr:Find("bg"),
			var_33_0
		}
	})
	var_33_0:SetAsFirstSibling()

	return
end

function NewShopsScene:UnBlurView()
	pg.UIMgr.GetInstance():UnOverlayPanel(self.frameTr, self._tf)

	return
end

function NewShopsScene:willExit()
	if self.bulinTip then
		self.bulinTip:Destroy()

		self.bulinTip = nil
	end

	for iter_35_0, iter_35_1 in pairs(self.pages) do
		iter_35_1:Destroy()
	end

	self:UnBlurView()
	self.contextData.singleWindow:Destroy()
	self.contextData.multiWindow:Destroy()
	self.contextData.singleWindowForESkin:Destroy()
	self.contextData.paintingView:Dispose()
	self.contextData.bgView:Dispose()

	self.contextData.singleWindow = nil
	self.contextData.multiWindow = nil
	self.contextData.singleWindowForESkin = nil
	self.contextData.paintingView = nil
	self.contextData.bgView = nil
	self.pages = nil
	self.bulinTip = nil

	return
end

return NewShopsScene
