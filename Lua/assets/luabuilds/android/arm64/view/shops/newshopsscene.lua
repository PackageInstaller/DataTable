local var_0_0 = class("NewShopsScene", import("..base.BaseUI"))

var_0_0.CATEGORY_ACTIVITY = 1
var_0_0.CATEGORY_MONTH = 2
var_0_0.CATEGORY_SUPPLY = 3
var_0_0.TYPE_ACTIVITY = 1
var_0_0.TYPE_SHOP_STREET = 2
var_0_0.TYPE_MILITARY_SHOP = 3
var_0_0.TYPE_QUOTA = 4
var_0_0.TYPE_SHAM_SHOP = 5
var_0_0.TYPE_FRAGMENT = 6
var_0_0.TYPE_GUILD = 7
var_0_0.TYPE_MEDAL = 8
var_0_0.TYPE_META = 9
var_0_0.TYPE_MINI_GAME = 10
var_0_0.CATEGORY2NAME = {
	[var_0_0.CATEGORY_ACTIVITY] = "activity",
	[var_0_0.CATEGORY_MONTH] = "month",
	[var_0_0.CATEGORY_SUPPLY] = "supply"
}
var_0_0.TYPE2NAME = {
	[var_0_0.TYPE_ACTIVITY] = i18n("activity_shop_title"),
	[var_0_0.TYPE_SHOP_STREET] = i18n("street_shop_title"),
	[var_0_0.TYPE_MILITARY_SHOP] = i18n("military_shop_title"),
	[var_0_0.TYPE_QUOTA] = i18n("quota_shop_title1"),
	[var_0_0.TYPE_SHAM_SHOP] = i18n("sham_shop_title"),
	[var_0_0.TYPE_FRAGMENT] = i18n("fragment_shop_title"),
	[var_0_0.TYPE_GUILD] = i18n("guild_shop_title"),
	[var_0_0.TYPE_MEDAL] = i18n("medal_shop_title"),
	[var_0_0.TYPE_META] = i18n("meta_shop_title"),
	[var_0_0.TYPE_MINI_GAME] = i18n("mini_game_shop_title")
}

local var_0_1 = {
	[var_0_0.CATEGORY_ACTIVITY] = {
		var_0_0.TYPE_ACTIVITY
	},
	[var_0_0.CATEGORY_MONTH] = {
		var_0_0.TYPE_QUOTA,
		var_0_0.TYPE_SHAM_SHOP,
		var_0_0.TYPE_MEDAL,
		var_0_0.TYPE_FRAGMENT
	},
	[var_0_0.CATEGORY_SUPPLY] = {
		var_0_0.TYPE_SHOP_STREET,
		var_0_0.TYPE_MILITARY_SHOP,
		var_0_0.TYPE_GUILD,
		var_0_0.TYPE_META,
		var_0_0.TYPE_MINI_GAME
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

function var_0_0.getUIName(arg_1_0)
	return "NewShopsUI"
end

function var_0_0.SetPlayer(arg_2_0, arg_2_1)
	arg_2_0.player = arg_2_1

	if arg_2_0.page then
		arg_2_0.page:SetPlayer(arg_2_1)
	end

	return
end

function var_0_0.SetShops(arg_3_0, arg_3_1)
	arg_3_0.shops = arg_3_1

	arg_3_0:SortActivityShops()

	return
end

function var_0_0.SortActivityShops(arg_4_0)
	for iter_4_0, iter_4_1 in pairs(arg_4_0.shops) do
		if iter_4_0 == var_0_0.TYPE_ACTIVITY then
			table.sort(iter_4_1, function(arg_5_0, arg_5_1)
				return arg_5_0:getStartTime() > arg_5_1:getStartTime()
			end)
		end
	end

	return
end

function var_0_0.SetShop(arg_6_0, arg_6_1, arg_6_2)
	if not arg_6_0.shops then
		return
	end

	local var_6_0 = arg_6_0.shops[arg_6_1]

	if arg_6_0.shops[arg_6_1] then
		for iter_6_0, iter_6_1 in ipairs(var_6_0) do
			if iter_6_1:IsSameKind(arg_6_2) then
				arg_6_0.shops[arg_6_1][iter_6_0] = arg_6_2

				break
			end
		end
	end

	return
end

function var_0_0.OnUpdateItems(arg_7_0, arg_7_1)
	arg_7_0.items = arg_7_1

	if arg_7_0.page then
		arg_7_0.page:SetItems(arg_7_1)
	end

	return
end

function var_0_0.OnUpdateShop(arg_8_0, arg_8_1, arg_8_2)
	arg_8_0:SetShop(arg_8_1, arg_8_2)

	if arg_8_0.page == arg_8_0.pages[arg_8_1] then
		arg_8_0.page:ExecuteAction("UpdateShop", arg_8_2)
	end

	return
end

function var_0_0.OnUpdateCommodity(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
	arg_9_0:SetShop(arg_9_1, arg_9_2)

	if arg_9_0.page == arg_9_0.pages[arg_9_1] then
		arg_9_0.page:ExecuteAction("UpdateCommodity", arg_9_2, arg_9_3)
	end

	return
end

function var_0_0.init(arg_10_0)
	arg_10_0.backBtn = arg_10_0._tf:Find("blur_panel/adapt/top/back_button")
	arg_10_0.frame = arg_10_0._tf:Find("blur_panel")
	arg_10_0.pageContainer = arg_10_0._tf:Find("frame/bg/pages")
	arg_10_0.stamp = arg_10_0._tf:Find("stamp")
	arg_10_0.switchBtn = arg_10_0._tf:Find("blur_panel/adapt/switch_btn")
	arg_10_0.skinBtn = arg_10_0._tf:Find("blur_panel/adapt/skin_btn")

	local var_10_0 = LOCK_SKIN_SHOP_ENTER and getProxy(PlayerProxy):getData().level < LOCK_SKIN_SHOP_ENTER_LEVEL

	setActive(arg_10_0.skinBtn, not var_10_0)

	local var_10_1 = arg_10_0._tf:Find("frame/bg/pages/scrollrect"):GetComponent("LScrollRect")
	local var_10_2 = arg_10_0._tf:Find("frame/bg/pages/scrollRectSpecial")

	setActive(go(var_10_1), true)
	setActive(var_10_2, false)

	arg_10_0.pages = {
		[var_0_0.TYPE_ACTIVITY] = ActivityShopPage.New(arg_10_0.pageContainer, arg_10_0.event, arg_10_0.contextData, var_10_1, var_10_2),
		[var_0_0.TYPE_SHOP_STREET] = StreetShopPage.New(arg_10_0.pageContainer, arg_10_0.event, arg_10_0.contextData, var_10_1),
		[var_0_0.TYPE_MILITARY_SHOP] = MilitaryShopPage.New(arg_10_0.pageContainer, arg_10_0.event, arg_10_0.contextData, var_10_1),
		[var_0_0.TYPE_GUILD] = GuildShopPage.New(arg_10_0.pageContainer, arg_10_0.event, arg_10_0.contextData, var_10_1),
		[var_0_0.TYPE_SHAM_SHOP] = ShamShopPage.New(arg_10_0.pageContainer, arg_10_0.event, arg_10_0.contextData, var_10_1),
		[var_0_0.TYPE_FRAGMENT] = FragmentShopPage.New(arg_10_0.pageContainer, arg_10_0.event, arg_10_0.contextData, var_10_1),
		[var_0_0.TYPE_META] = MetaShopPage.New(arg_10_0.pageContainer, arg_10_0.event, arg_10_0.contextData, var_10_1),
		[var_0_0.TYPE_MEDAL] = MedalShopPage.New(arg_10_0.pageContainer, arg_10_0.event, arg_10_0.contextData, var_10_1),
		[var_0_0.TYPE_QUOTA] = QuotaShopPage.New(arg_10_0.pageContainer, arg_10_0.event, arg_10_0.contextData, var_10_1),
		[var_0_0.TYPE_MINI_GAME] = MiniGameShopPage.New(arg_10_0.pageContainer, arg_10_0.event, arg_10_0.contextData, var_10_1)
	}
	arg_10_0.contextData.singleWindow = ShopSingleWindow.New(arg_10_0._tf, arg_10_0.event)
	arg_10_0.contextData.multiWindow = ShopMultiWindow.New(arg_10_0._tf, arg_10_0.event)
	arg_10_0.contextData.singleWindowForESkin = EquipmentSkinInfoUIForShopWindow.New(arg_10_0._tf, arg_10_0.event)
	arg_10_0.contextData.paintingView = ShopPaintingView.New(arg_10_0._tf:Find("paint/paint"), arg_10_0._tf:Find("frame/chat"))

	arg_10_0.contextData.paintingView:setSecretaryPos(arg_10_0._tf:Find("paint/secretaryPos"))

	arg_10_0.contextData.bgView = ShopBgView.New(arg_10_0._tf:Find("bg"))
	arg_10_0.recorder = {
		[var_0_0.CATEGORY_ACTIVITY] = false,
		[var_0_0.CATEGORY_MONTH] = false,
		[var_0_0.CATEGORY_SUPPLY] = false
	}
	arg_10_0.frameTr = arg_10_0._tf:Find("frame")
	arg_10_0.categoryUIList = UIItemList.New(arg_10_0._tf:Find("frame/bg/types"), arg_10_0._tf:Find("frame/bg/types/tpl"))
	arg_10_0.shopUIList = UIItemList.New(arg_10_0._tf:Find("frame/bg/shops"), arg_10_0._tf:Find("frame/bg/shops/tpl"))

	return
end

function var_0_0.didEnter(arg_11_0)
	onButton(arg_11_0, arg_11_0.backBtn, function()
		arg_11_0:closeView()

		return
	end, SFX_CANCEL)
	setActive(arg_11_0.stamp, getProxy(TaskProxy):mingshiTouchFlagEnabled())

	if LOCK_CLICK_MINGSHI then
		setActive(arg_11_0.stamp, false)
	end

	onButton(arg_11_0, arg_11_0.stamp, function()
		getProxy(TaskProxy):dealMingshiTouchFlag(4)

		return
	end, SFX_CONFIRM)
	onButton(arg_11_0, arg_11_0.switchBtn, function()
		local var_14_0 = ChargeScene.TYPE_DIAMOND

		if arg_11_0.contextData ~= nil and arg_11_0.contextData.chargePage ~= nil then
			var_14_0 = arg_11_0.contextData.chargePage
		end

		arg_11_0:emit(NewShopsMediator.GO_MALL, var_14_0)

		return
	end, SFX_CANCEL)
	onButton(arg_11_0, arg_11_0.skinBtn, function()
		arg_11_0:emit(NewShopsMediator.ON_SKIN_SHOP)

		return
	end, SFX_PANEL)
	arg_11_0:InitEntrances()
	arg_11_0:BlurView()

	arg_11_0.bulinTip = AprilFoolBulinSubView.ShowAprilFoolBulin(arg_11_0, arg_11_0.pageContainer, Vector2.New(-35, -90))

	return
end

function var_0_0.InitEntrances(arg_16_0)
	arg_16_0:InitCategory()
	arg_16_0:ActiveDefaultCategory()

	arg_16_0.shopType = nil
	arg_16_0.shopIndex = nil

	return
end

function var_0_0.InitCategory(arg_17_0)
	arg_17_0.categoryTrs = {}

	local var_17_0 = {
		var_0_0.CATEGORY_MONTH,
		var_0_0.CATEGORY_SUPPLY
	}
	local var_17_1 = arg_17_0.shops[var_0_0.TYPE_ACTIVITY] or {}

	if #var_17_1 > 0 then
		table.insert({
			var_0_0.CATEGORY_MONTH,
			var_0_0.CATEGORY_SUPPLY
		}, var_0_0.CATEGORY_ACTIVITY)
	end

	arg_17_0.categoryUIList:make(function(arg_18_0, arg_18_1, arg_18_2)
		if arg_18_0 == UIItemList.EventUpdate then
			arg_17_0:UpdateCategory(arg_18_2, var_17_0[arg_18_1 + 1], false)

			arg_17_0.categoryTrs[var_17_0[arg_18_1 + 1]] = arg_18_2
		end

		return
	end)
	arg_17_0.categoryUIList:align(#{
		var_0_0.CATEGORY_MONTH,
		var_0_0.CATEGORY_SUPPLY
	})

	return
end

local function var_0_3(arg_19_0, arg_19_1)
	local var_19_0 = arg_19_0:Find("label")
	local var_19_1 = arg_19_0:Find("selected/selected")
	local var_19_2 = arg_19_0:Find("lock"):GetComponent(typeof(Image))

	var_19_2.sprite = GetSpriteFromAtlas("ui/ShopsUI_atlas", var_0_0.CATEGORY2NAME[arg_19_1] .. "_lock")

	var_19_2:SetNativeSize()

	local var_19_3 = var_19_0:GetComponent(typeof(Image))

	var_19_3.sprite = GetSpriteFromAtlas("ui/ShopsUI_atlas", var_0_0.CATEGORY2NAME[arg_19_1])

	var_19_3:SetNativeSize()

	local var_19_4 = var_19_0:Find("en"):GetComponent(typeof(Image))

	var_19_4.sprite = GetSpriteFromAtlas("ui/ShopsUI_atlas", var_0_0.CATEGORY2NAME[arg_19_1] .. "_label")

	var_19_4:SetNativeSize()

	local var_19_5 = var_19_1:GetComponent(typeof(Image))

	var_19_5.sprite = GetSpriteFromAtlas("ui/ShopsUI_atlas", var_0_0.CATEGORY2NAME[arg_19_1] .. "_selected")

	var_19_5:SetNativeSize()

	local var_19_6 = var_19_1.parent:Find("en"):GetComponent(typeof(Image))

	var_19_6.sprite = GetSpriteFromAtlas("ui/ShopsUI_atlas", var_0_0.CATEGORY2NAME[arg_19_1] .. "_label_selected")

	var_19_6:SetNativeSize()

	return
end

function var_0_0.UpdateCategory(arg_20_0, arg_20_1, arg_20_2, arg_20_3)
	setActive(arg_20_1:Find("lock"), arg_20_3)
	setActive(arg_20_1:Find("label"), not arg_20_3)
	setActive(arg_20_1:Find("selected"), false)
	var_0_3(arg_20_1, arg_20_2)
	onToggle(arg_20_0, arg_20_1, function(arg_21_0)
		if arg_21_0 then
			arg_20_0:InitShops(arg_20_2)

			arg_20_0.category = arg_20_2

			arg_20_0:ActiveDefaultShop()
		end

		setActive(arg_20_1:Find("label"), not arg_20_3 and not arg_21_0)
		setActive(arg_20_1:Find("selected"), not arg_20_3 and arg_21_0)

		return
	end, SFX_PANEL)
	setToggleEnabled(arg_20_1, not arg_20_3)

	return
end

function var_0_0.InitShops(arg_22_0, arg_22_1)
	if arg_22_0.category and arg_22_0.category == arg_22_1 then
		return
	end

	local var_22_0 = var_0_1[arg_22_1]
	local var_22_1 = {}

	arg_22_0.displayShops = {}
	arg_22_0.prevBtn = nil

	for iter_22_0, iter_22_1 in pairs(var_22_0) do
		local var_22_2 = arg_22_0.shops[iter_22_1] or {}

		for iter_22_2, iter_22_3 in ipairs(var_22_2) do
			table.insert({}, {
				type = iter_22_1,
				index = iter_22_2
			})
		end
	end

	arg_22_0.shopUIList:make(function(arg_23_0, arg_23_1, arg_23_2)
		if arg_23_0 == UIItemList.EventUpdate then
			local var_23_0 = var_22_1[arg_23_1 + 1]
			local var_23_1 = arg_22_0.pages[var_22_1[arg_23_1 + 1].type]:CanOpen(var_22_1[arg_23_1 + 1], arg_22_0.player)

			setActive(arg_23_2:Find("unsel/lock"), not var_23_1)

			GetOrAddComponent(arg_23_2:Find("unsel/label"), "CanvasGroup").alpha = var_23_1 and 1 or 0.4

			arg_22_0:UpdateShop(arg_23_2, var_23_0)

			arg_22_0.displayShops[var_23_0.type] = arg_22_0.displayShops[var_23_0.type] or {}
			arg_22_0.displayShops[var_23_0.type][var_23_0.index] = arg_23_2
		end

		return
	end)
	arg_22_0.shopUIList:align(#{})

	return
end

local function var_0_4(arg_24_0, arg_24_1)
	setText(arg_24_0:Find("selected/Text"), var_0_0.TYPE2NAME[arg_24_1.type])
	setText(arg_24_0:Find("unsel/label"), var_0_0.TYPE2NAME[arg_24_1.type])

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
	setActive(arg_25_1:Find("unsel"), true)
	setActive(arg_25_1:Find("selected"), false)

	return
end

function var_0_0.UpdateShop(arg_27_0, arg_27_1, arg_27_2)
	var_0_4(arg_27_1, arg_27_2)

	local var_27_0 = arg_27_1:Find("selected")
	local var_27_1 = arg_27_1:Find("unsel")

	var_0_5(arg_27_0, arg_27_1, function()
		local var_28_0, var_28_1 = arg_27_0.pages[arg_27_2.type]:CanOpen(arg_27_0.shops[arg_27_2.type][arg_27_2.index], arg_27_0.player)

		if var_28_0 then
			if arg_27_0.page and not arg_27_0.page:GetLoaded() then
				return
			end

			if arg_27_0.page then
				arg_27_0.page:Hide()
			end

			arg_27_0.contextData.bgView:Init(arg_27_0.pages[arg_27_2.type]:GetBg(arg_27_0.shops[arg_27_2.type][arg_27_2.index]))
			arg_27_0.pages[arg_27_2.type]:ExecuteAction("SetUp", arg_27_0.shops[arg_27_2.type][arg_27_2.index], arg_27_0.player, arg_27_0.items)

			arg_27_0.page = arg_27_0.pages[arg_27_2.type]
			arg_27_0.contextData.activeShop = arg_27_2.type
			arg_27_0.recorder[arg_27_0.category] = arg_27_2

			return true
		else
			pg.TipsMgr.GetInstance():ShowTips(var_28_1)
		end

		return false
	end)

	return
end

function var_0_0.ActiveDefaultCategory(arg_29_0)
	local var_29_0 = arg_29_0.contextData.warp or arg_29_0.contextData.activeShop or var_0_0.TYPE_ACTIVITY

	if type(var_29_0) == "string" then
		var_29_0 = defaultValue(table.indexof(var_0_2, var_29_0), var_0_0.TYPE_ACTIVITY)
	end

	local var_29_1 = arg_29_0.contextData.index or 1

	if var_29_0 == var_0_0.TYPE_ACTIVITY and arg_29_0.contextData.actId then
		local var_29_2 = arg_29_0.shops[var_29_0] or {}

		for iter_29_0, iter_29_1 in ipairs(var_29_2) do
			if iter_29_1.activityId == arg_29_0.contextData.actId then
				var_29_1 = iter_29_0

				break
			end
		end

		goto label_29_0
	end

	::label_29_0::

	if var_29_0 == var_0_0.TYPE_ACTIVITY then
		if arg_29_0.shops[var_0_0.TYPE_ACTIVITY] then
			do
				local var_29_3 = arg_29_0.shops[var_0_0.TYPE_ACTIVITY] or {}

				if #var_29_3 <= 0 then
					var_29_0 = var_0_0.TYPE_SHOP_STREET
					var_29_1 = 1

					goto label_29_0
				end

				if var_29_0 == var_0_0.TYPE_ACTIVITY and arg_29_0.shops[var_0_0.TYPE_ACTIVITY] then
					local var_29_4 = arg_29_0.shops[var_0_0.TYPE_ACTIVITY] or {}

					if #var_29_4 > 0 and not arg_29_0.contextData.actId then
						local var_29_5 = arg_29_0.shops[var_29_0] or {}

						for iter_29_2, iter_29_3 in ipairs(var_29_5) do
							if arg_29_0.shops[var_29_0][1].activityId < iter_29_3.activityId then
								-- block empty
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

			assert(var_29_7 and arg_29_0.categoryTrs[var_29_7])

			arg_29_0.shopType = var_29_0
			arg_29_0.shopIndex = var_29_1

			triggerToggle(arg_29_0.categoryTrs[var_29_7], true)

			return
		end
	end
end

function var_0_0.ActiveDefaultShop(arg_30_0)
	local var_30_0
	local var_30_1

	if arg_30_0.recorder[arg_30_0.category] then
		var_30_1 = arg_30_0.recorder[arg_30_0.category].index
		var_30_0 = arg_30_0.recorder[arg_30_0.category].type
	else
		var_30_0, var_30_1 = arg_30_0.shopType, arg_30_0.shopIndex or 1
	end

	if not var_30_0 then
		var_30_2()

		return
	end

	local var_30_3, var_30_4 = arg_30_0.pages[var_30_0]:CanOpen(nil, arg_30_0.player)

	if var_30_3 and arg_30_0.displayShops[var_30_0] and arg_30_0.displayShops[var_30_0][var_30_1] then
		triggerButton(arg_30_0.displayShops[var_30_0][var_30_1])
	else
		if not var_30_3 then
			pg.TipsMgr.GetInstance():ShowTips(var_30_4)
		end

		var_30_2()
	end

	return
end

function var_0_0.onBackPressed(arg_32_0)
	if arg_32_0.contextData.singleWindow:GetLoaded() and arg_32_0.contextData.singleWindow:isShowing() then
		arg_32_0.contextData.singleWindow:Close()

		return
	end

	if arg_32_0.contextData.multiWindow:GetLoaded() and arg_32_0.contextData.multiWindow:isShowing() then
		arg_32_0.contextData.multiWindow:Close()

		return
	end

	if arg_32_0.contextData.singleWindowForESkin:GetLoaded() and arg_32_0.contextData.singleWindowForESkin:isShowing() then
		arg_32_0.contextData.singleWindowForESkin:Hide()

		return
	end

	var_0_0.super.onBackPressed(arg_32_0)

	return
end

function var_0_0.BlurView(arg_33_0)
	local var_33_0 = arg_33_0.frameTr:Find("bg/blur")

	pg.UIMgr.GetInstance():OverlayPanel(arg_33_0.frameTr, {
		pbList = {
			arg_33_0.frameTr:Find("bg"),
			var_33_0
		}
	})
	var_33_0:SetAsFirstSibling()

	return
end

function var_0_0.UnBlurView(arg_34_0)
	pg.UIMgr.GetInstance():UnOverlayPanel(arg_34_0.frameTr, arg_34_0._tf)

	return
end

function var_0_0.willExit(arg_35_0)
	if arg_35_0.bulinTip then
		arg_35_0.bulinTip:Destroy()

		arg_35_0.bulinTip = nil
	end

	for iter_35_0, iter_35_1 in pairs(arg_35_0.pages) do
		iter_35_1:Destroy()
	end

	arg_35_0:UnBlurView()
	arg_35_0.contextData.singleWindow:Destroy()
	arg_35_0.contextData.multiWindow:Destroy()
	arg_35_0.contextData.singleWindowForESkin:Destroy()
	arg_35_0.contextData.paintingView:Dispose()
	arg_35_0.contextData.bgView:Dispose()

	arg_35_0.contextData.singleWindow = nil
	arg_35_0.contextData.multiWindow = nil
	arg_35_0.contextData.singleWindowForESkin = nil
	arg_35_0.contextData.paintingView = nil
	arg_35_0.contextData.bgView = nil
	arg_35_0.pages = nil
	arg_35_0.bulinTip = nil

	return
end

return var_0_0
