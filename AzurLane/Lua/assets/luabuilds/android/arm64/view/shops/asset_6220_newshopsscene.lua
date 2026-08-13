class = var_0_10000

local var_0_0 = "NewShopsScene"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("..base.BaseUI"))

var_0_1.CATEGORY_ACTIVITY = 1
var_0_1.CATEGORY_MONTH = 2
var_0_1.CATEGORY_SUPPLY = 3
var_0_1.TYPE_ACTIVITY = 1
var_0_1.TYPE_SHOP_STREET = 2
var_0_1.TYPE_MILITARY_SHOP = 3
var_0_1.TYPE_QUOTA = 4
var_0_1.TYPE_SHAM_SHOP = 5
var_0_1.TYPE_FRAGMENT = 6
var_0_1.TYPE_GUILD = 7
var_0_1.TYPE_MEDAL = 8
var_0_1.TYPE_META = 9
var_0_1.TYPE_MINI_GAME = 10
var_0_1.CATEGORY2NAME = {
	[var_0_1.CATEGORY_ACTIVITY] = "activity",
	[var_0_1.CATEGORY_MONTH] = "month",
	[var_0_1.CATEGORY_SUPPLY] = "supply"
}

local var_0_2 = {}
local var_0_3 = var_0_1.TYPE_ACTIVITY

i18n = var_3
var_0_2[var_0_3] = var_3("activity_shop_title")

local var_0_4 = var_0_1.TYPE_SHOP_STREET

i18n = var_3
var_0_2[var_0_4] = var_3("street_shop_title")

local var_0_5 = var_0_1.TYPE_MILITARY_SHOP

i18n = var_3
var_0_2[var_0_5] = var_3("military_shop_title")

local var_0_6 = var_0_1.TYPE_QUOTA

i18n = var_3
var_0_2[var_0_6] = var_3("quota_shop_title1")

local var_0_7 = var_0_1.TYPE_SHAM_SHOP

i18n = var_3
var_0_2[var_0_7] = var_3("sham_shop_title")

local var_0_8 = var_0_1.TYPE_FRAGMENT

i18n = var_3
var_0_2[var_0_8] = var_3("fragment_shop_title")

local var_0_9 = var_0_1.TYPE_GUILD

i18n = var_3
var_0_2[var_0_9] = var_3("guild_shop_title")

local var_0_10 = var_0_1.TYPE_MEDAL

i18n = var_3
var_0_2[var_0_10] = var_3("medal_shop_title")

local var_0_11 = var_0_1.TYPE_META

i18n = var_3
var_0_2[var_0_11] = var_3("meta_shop_title")

local var_0_12 = var_0_1.TYPE_MINI_GAME

i18n = var_3
var_0_2[var_0_12] = var_3("mini_game_shop_title")
var_0_1.TYPE2NAME = var_0_2

local var_0_13 = {
	[var_0_1.CATEGORY_ACTIVITY] = {
		var_0_1.TYPE_ACTIVITY
	},
	[var_0_1.CATEGORY_MONTH] = {
		var_0_1.TYPE_QUOTA,
		var_0_1.TYPE_SHAM_SHOP,
		var_0_1.TYPE_MEDAL,
		var_0_1.TYPE_FRAGMENT
	},
	[var_0_1.CATEGORY_SUPPLY] = {
		var_0_1.TYPE_SHOP_STREET,
		var_0_1.TYPE_MILITARY_SHOP,
		var_0_1.TYPE_GUILD,
		var_0_1.TYPE_META,
		var_0_1.TYPE_MINI_GAME
	}
}
local var_0_14 = {
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

function var_0_1.getUIName(arg_1_0)
	return "NewShopsUI"
end

function var_0_1.SetPlayer(arg_2_0, arg_2_1)
	arg_2_0.player = arg_2_1

	if arg_2_0.page then
		local var_2_0 = arg_2_0.page

		var_2.SetPlayer(var_2_0, arg_2_1)
	end

	return
end

function var_0_1.SetShops(arg_3_0, arg_3_1)
	arg_3_0.shops = arg_3_1

	arg_3_0:SortActivityShops()

	return
end

function var_0_1.SortActivityShops(arg_4_0)
	pairs = var_1_10001

	for iter_4_0, iter_4_1 in var_1_10001(arg_4_0.shops) do
		if iter_4_0 == var_0_1.TYPE_ACTIVITY then
			table = var_6

			var_6.sort(iter_4_1, function(arg_5_0, arg_5_1)
				return arg_5_0:getStartTime() > arg_5_1:getStartTime()
			end)
		end
	end

	return
end

function var_0_1.SetShop(arg_6_0, arg_6_1, arg_6_2)
	if not arg_6_0.shops then
		return
	end

	if arg_6_0.shops[arg_6_1] then
		ipairs = var_1_10004

		for iter_6_0, iter_6_1 in var_1_10004(var_3) do
			if iter_6_1:IsSameKind(arg_6_2) then
				arg_6_0.shops[arg_6_1][iter_6_0] = arg_6_2

				break
			end
		end
	end

	return
end

function var_0_1.OnUpdateItems(arg_7_0, arg_7_1)
	arg_7_0.items = arg_7_1

	if arg_7_0.page then
		local var_7_0 = arg_7_0.page

		var_2.SetItems(var_7_0, arg_7_1)
	end

	return
end

function var_0_1.OnUpdateShop(arg_8_0, arg_8_1, arg_8_2)
	arg_8_0:SetShop(arg_8_1, arg_8_2)

	local var_8_0 = arg_8_0.pages[arg_8_1]

	if arg_8_0.page == var_8_0 then
		local var_8_1 = arg_8_0.page

		var_4.ExecuteAction(var_8_1, "UpdateShop", arg_8_2)
	end

	return
end

function var_0_1.OnUpdateCommodity(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
	arg_9_0:SetShop(arg_9_1, arg_9_2)

	local var_9_0 = arg_9_0.pages[arg_9_1]

	if arg_9_0.page == var_9_0 then
		local var_9_1 = arg_9_0.page

		var_5.ExecuteAction(var_9_1, "UpdateCommodity", arg_9_2, arg_9_3)
	end

	return
end

function var_0_1.init(arg_10_0)
	local var_10_0 = arg_10_0._tf

	arg_10_0.backBtn = var_1.Find(var_10_0, "blur_panel/adapt/top/back_button")

	local var_10_1 = arg_10_0._tf

	arg_10_0.frame = var_1.Find(var_10_1, "blur_panel")

	local var_10_2 = arg_10_0._tf

	arg_10_0.pageContainer = var_1.Find(var_10_2, "frame/bg/pages")

	local var_10_3 = arg_10_0._tf

	arg_10_0.stamp = var_1.Find(var_10_3, "stamp")

	local var_10_4 = arg_10_0._tf

	arg_10_0.switchBtn = var_1.Find(var_10_4, "blur_panel/adapt/switch_btn")

	local var_10_5 = arg_10_0._tf

	arg_10_0.skinBtn = var_1.Find(var_10_5, "blur_panel/adapt/skin_btn")
	LOCK_SKIN_SHOP_ENTER = var_10_7

	local var_10_7

	if var_10_7 then
		getProxy = var_10_7
		PlayerProxy = var_10_5

		local var_10_6 = var_10_7(var_10_5)

		var_10_7 = var_10_7.getData(var_10_6).level
		LOCK_SKIN_SHOP_ENTER_LEVEL = var_1_10002
		var_10_7 = var_10_7 < var_1_10002
	end

	setActive = var_1_10002

	var_1_10002(arg_10_0.skinBtn, not var_10_7)

	local var_10_8 = arg_10_0._tf
	local var_10_9 = var_2.Find(var_10_8, "frame/bg/pages/scrollrect")
	local var_10_10 = var_2.GetComponent(var_10_9, "LScrollRect")
	local var_10_11 = arg_10_0._tf
	local var_10_12 = var_3.Find(var_10_11, "frame/bg/pages/scrollRectSpecial")

	setActive = var_10_9
	go = var_6

	var_10_9(var_6(var_10_10), true)

	setActive = var_10_9

	var_10_9(var_10_12, false)

	local var_10_13 = {}
	local var_10_14 = var_0_1.TYPE_ACTIVITY

	ActivityShopPage = var_6
	var_10_13[var_10_14] = var_6.New(arg_10_0.pageContainer, arg_10_0.event, arg_10_0.contextData, var_10_10, var_10_12)

	local var_10_15 = var_0_1.TYPE_SHOP_STREET

	StreetShopPage = var_6
	var_10_13[var_10_15] = var_6.New(arg_10_0.pageContainer, arg_10_0.event, arg_10_0.contextData, var_10_10)

	local var_10_16 = var_0_1.TYPE_MILITARY_SHOP

	MilitaryShopPage = var_6
	var_10_13[var_10_16] = var_6.New(arg_10_0.pageContainer, arg_10_0.event, arg_10_0.contextData, var_10_10)

	local var_10_17 = var_0_1.TYPE_GUILD

	GuildShopPage = var_6
	var_10_13[var_10_17] = var_6.New(arg_10_0.pageContainer, arg_10_0.event, arg_10_0.contextData, var_10_10)

	local var_10_18 = var_0_1.TYPE_SHAM_SHOP

	ShamShopPage = var_6
	var_10_13[var_10_18] = var_6.New(arg_10_0.pageContainer, arg_10_0.event, arg_10_0.contextData, var_10_10)

	local var_10_19 = var_0_1.TYPE_FRAGMENT

	FragmentShopPage = var_6
	var_10_13[var_10_19] = var_6.New(arg_10_0.pageContainer, arg_10_0.event, arg_10_0.contextData, var_10_10)

	local var_10_20 = var_0_1.TYPE_META

	MetaShopPage = var_6
	var_10_13[var_10_20] = var_6.New(arg_10_0.pageContainer, arg_10_0.event, arg_10_0.contextData, var_10_10)

	local var_10_21 = var_0_1.TYPE_MEDAL

	MedalShopPage = var_6
	var_10_13[var_10_21] = var_6.New(arg_10_0.pageContainer, arg_10_0.event, arg_10_0.contextData, var_10_10)

	local var_10_22 = var_0_1.TYPE_QUOTA

	QuotaShopPage = var_6
	var_10_13[var_10_22] = var_6.New(arg_10_0.pageContainer, arg_10_0.event, arg_10_0.contextData, var_10_10)

	local var_10_23 = var_0_1.TYPE_MINI_GAME

	MiniGameShopPage = var_6
	var_10_13[var_10_23] = var_6.New(arg_10_0.pageContainer, arg_10_0.event, arg_10_0.contextData, var_10_10)
	arg_10_0.pages = var_10_13

	local var_10_24 = arg_10_0.contextData

	ShopSingleWindow = var_10_23
	var_10_24.singleWindow = var_10_23.New(arg_10_0._tf, arg_10_0.event)

	local var_10_25 = arg_10_0.contextData

	ShopMultiWindow = var_5
	var_10_25.multiWindow = var_5.New(arg_10_0._tf, arg_10_0.event)

	local var_10_26 = arg_10_0.contextData

	EquipmentSkinInfoUIForShopWindow = var_5
	var_10_26.singleWindowForESkin = var_5.New(arg_10_0._tf, arg_10_0.event)

	local var_10_27 = arg_10_0.contextData

	ShopPaintingView = var_5

	local var_10_28 = var_5.New
	local var_10_29 = arg_10_0._tf
	local var_10_30 = var_7.Find(var_10_29, "paint/paint")
	local var_10_31 = arg_10_0._tf

	var_10_27.paintingView = var_10_28(var_10_30, var_8.Find(var_10_31, "frame/chat"))

	local var_10_32 = arg_10_0.contextData.paintingView
	local var_10_33 = var_4.setSecretaryPos
	local var_10_34 = arg_10_0._tf

	var_10_33(var_10_32, var_7.Find(var_10_34, "paint/secretaryPos"))

	local var_10_35 = arg_10_0.contextData

	ShopBgView = var_5

	local var_10_36 = var_5.New
	local var_10_37 = arg_10_0._tf

	var_10_35.bgView = var_10_36(var_7.Find(var_10_37, "bg"))
	arg_10_0.recorder = {
		[var_0_1.CATEGORY_ACTIVITY] = false,
		[var_0_1.CATEGORY_MONTH] = false,
		[var_0_1.CATEGORY_SUPPLY] = false
	}

	local var_10_38 = arg_10_0._tf

	arg_10_0.frameTr = var_4.Find(var_10_38, "frame")
	UIItemList = var_4

	local var_10_39 = var_4.New
	local var_10_40 = arg_10_0._tf
	local var_10_41 = var_6.Find(var_10_40, "frame/bg/types")
	local var_10_42 = arg_10_0._tf

	arg_10_0.categoryUIList = var_10_39(var_10_41, var_7.Find(var_10_42, "frame/bg/types/tpl"))
	UIItemList = var_4

	local var_10_43 = var_4.New
	local var_10_44 = arg_10_0._tf
	local var_10_45 = var_6.Find(var_10_44, "frame/bg/shops")
	local var_10_46 = arg_10_0._tf

	arg_10_0.shopUIList = var_10_43(var_10_45, var_7.Find(var_10_46, "frame/bg/shops/tpl"))

	return
end

function var_0_1.didEnter(arg_11_0)
	onButton = var_1_10001

	local var_11_0 = arg_11_0
	local var_11_1 = arg_11_0.backBtn

	local function var_11_2()
		local var_12_0 = arg_11_0

		var_0.closeView(var_12_0)

		return
	end

	SFX_CANCEL = var_1_10006

	var_1_10001(var_11_0, var_11_1, var_11_2, var_1_10006)

	setActive = var_1_10001

	local var_11_3 = arg_11_0.stamp

	getProxy = var_11_1
	TaskProxy = var_1_10006

	local var_11_4 = var_11_1(var_1_10006)

	var_1_10001(var_11_3, var_4.mingshiTouchFlagEnabled(var_11_4))

	LOCK_CLICK_MINGSHI = var_1_10001

	if var_1_10001 then
		setActive = var_1_10001

		var_1_10001(arg_11_0.stamp, false)
	end

	onButton = var_1_10001

	local var_11_5 = arg_11_0
	local var_11_6 = arg_11_0.stamp

	local function var_11_7()
		getProxy = var_2_10000
		TaskProxy = var_2_10002

		local var_13_0 = var_2_10000(var_2_10002)

		var_0.dealMingshiTouchFlag(var_13_0, 4)

		return
	end

	SFX_CONFIRM = var_11_4

	var_1_10001(var_11_5, var_11_6, var_11_7, var_11_4)

	onButton = var_1_10001

	local var_11_8 = arg_11_0
	local var_11_9 = arg_11_0.switchBtn

	local function var_11_10()
		ChargeScene = var_2_10000

		local var_14_0 = var_2_10000.TYPE_DIAMOND

		if arg_11_0.contextData ~= nil and arg_11_0.contextData.chargePage ~= nil then
			var_14_0 = arg_11_0.contextData.chargePage
		end

		local var_14_1 = arg_11_0
		local var_14_2 = var_1.emit

		NewShopsMediator = var_2_10004

		var_14_2(var_14_1, var_2_10004.GO_MALL, var_14_0)

		return
	end

	SFX_CANCEL = var_11_4

	var_1_10001(var_11_8, var_11_9, var_11_10, var_11_4)

	onButton = var_1_10001

	local var_11_11 = arg_11_0
	local var_11_12 = arg_11_0.skinBtn

	local function var_11_13()
		local var_15_0 = arg_11_0
		local var_15_1 = var_0.emit

		NewShopsMediator = var_2_10003

		var_15_1(var_15_0, var_2_10003.ON_SKIN_SHOP)

		return
	end

	SFX_PANEL = var_11_4

	var_1_10001(var_11_11, var_11_12, var_11_13, var_11_4)
	arg_11_0:InitEntrances()
	arg_11_0:BlurView()

	AprilFoolBulinSubView = var_1

	local var_11_14 = var_1.ShowAprilFoolBulin
	local var_11_15 = arg_11_0
	local var_11_16 = arg_11_0.pageContainer

	Vector2 = var_11_13
	arg_11_0.bulinTip = var_11_14(var_11_15, var_11_16, var_11_13.New(-35, -90))

	return
end

function var_0_1.InitEntrances(arg_16_0)
	arg_16_0:InitCategory()
	arg_16_0:ActiveDefaultCategory()

	arg_16_0.shopType = nil
	arg_16_0.shopIndex = nil

	return
end

function var_0_1.InitCategory(arg_17_0)
	arg_17_0.categoryTrs = {}

	local var_17_0 = {
		var_0_1.CATEGORY_MONTH,
		var_0_1.CATEGORY_SUPPLY
	}
	local var_17_1

	if not arg_17_0.shops[var_0_1.TYPE_ACTIVITY] then
		var_17_1 = {}
	end

	if #var_17_1 > 0 then
		table = var_3

		var_3.insert(var_17_0, var_0_1.CATEGORY_ACTIVITY)
	end

	local var_17_2 = arg_17_0.categoryUIList

	var_3.make(var_17_2, function(arg_18_0, arg_18_1, arg_18_2)
		UIItemList = var_2_10003

		if arg_18_0 == var_2_10003.EventUpdate then
			local var_18_0 = var_17_0[arg_18_1 + 1]
			local var_18_1 = arg_17_0

			var_4.UpdateCategory(var_18_1, arg_18_2, var_18_0, false)

			arg_17_0.categoryTrs[var_18_0] = arg_18_2
		end

		return
	end)

	local var_17_3 = arg_17_0.categoryUIList

	var_3.align(var_17_3, #var_17_0)

	return
end

local function var_0_15(arg_19_0, arg_19_1)
	local var_19_0 = var_0_1.CATEGORY2NAME[arg_19_1]
	local var_19_1 = arg_19_0:Find("lock")
	local var_19_2 = arg_19_0:Find("label")
	local var_19_3 = arg_19_0
	local var_19_4 = arg_19_0.Find(var_19_3, "selected/selected")
	local var_19_5 = var_19_1
	local var_19_6 = var_19_1.GetComponent

	typeof = var_1_10009
	Image = var_1_10011

	local var_19_7 = var_19_6(var_19_5, var_1_10009(var_1_10011))

	GetSpriteFromAtlas = var_19_3
	var_19_7.sprite = var_19_3("ui/ShopsUI_atlas", var_19_0 .. "_lock")

	var_19_7:SetNativeSize()

	local var_19_8 = var_19_2
	local var_19_9 = var_19_2.GetComponent

	typeof = var_10
	Image = var_1_10012

	local var_19_10 = var_19_9(var_19_8, var_10(var_1_10012))

	GetSpriteFromAtlas = var_19_5
	var_19_10.sprite = var_19_5("ui/ShopsUI_atlas", var_19_0)

	var_19_10:SetNativeSize()

	local var_19_11 = var_19_2:Find("en")
	local var_19_12 = var_8.GetComponent

	typeof = var_11
	Image = var_1_10013

	local var_19_13 = var_19_12(var_19_11, var_11(var_1_10013))

	GetSpriteFromAtlas = var_19_8
	var_19_13.sprite = var_19_8("ui/ShopsUI_atlas", var_19_0 .. "_label")

	var_19_13:SetNativeSize()

	local var_19_14 = var_19_4
	local var_19_15 = var_19_4.GetComponent

	typeof = var_12
	Image = var_1_10014

	local var_19_16 = var_19_15(var_19_14, var_12(var_1_10014))

	GetSpriteFromAtlas = var_19_11
	var_19_16.sprite = var_19_11("ui/ShopsUI_atlas", var_19_0 .. "_selected")

	var_19_16:SetNativeSize()

	local var_19_17 = var_19_4.parent
	local var_19_18 = var_10.Find(var_19_17, "en")
	local var_19_19 = var_10.GetComponent

	typeof = var_13
	Image = var_1_10015

	local var_19_20 = var_19_19(var_19_18, var_13(var_1_10015))

	GetSpriteFromAtlas = var_19_14
	var_19_20.sprite = var_19_14("ui/ShopsUI_atlas", var_19_0 .. "_label_selected")

	var_19_20:SetNativeSize()

	return
end

function var_0_1.UpdateCategory(arg_20_0, arg_20_1, arg_20_2, arg_20_3)
	setActive = var_1_10004

	var_1_10004(arg_20_1:Find("lock"), arg_20_3)

	setActive = var_1_10004

	var_1_10004(arg_20_1:Find("label"), not arg_20_3)

	setActive = var_1_10004

	var_1_10004(arg_20_1:Find("selected"), false)
	var_0_15(arg_20_1, arg_20_2)

	onToggle = var_4

	local var_20_0 = arg_20_0
	local var_20_1 = arg_20_1

	local function var_20_2(arg_21_0)
		if arg_21_0 then
			local var_21_0 = arg_20_0

			var_2_10001.InitShops(var_21_0, arg_20_2)

			var_2_10001 = arg_20_0
			var_2_10001.category = arg_20_2

			local var_21_1 = arg_20_0

			var_2_10001.ActiveDefaultShop(var_21_1)
		end

		setActive = var_2_10001

		local var_21_2 = arg_20_1

		var_2_10001(var_3.Find(var_21_2, "label"), not arg_20_3 and not arg_21_0)

		setActive = var_2_10001

		local var_21_3 = arg_20_1

		var_2_10001(var_3.Find(var_21_3, "selected"), not arg_20_3 and arg_21_0)

		return
	end

	SFX_PANEL = var_9

	var_4(var_20_0, var_20_1, var_20_2, var_9)

	setToggleEnabled = var_4

	var_4(arg_20_1, not arg_20_3)

	return
end

function var_0_1.InitShops(arg_22_0, arg_22_1)
	if arg_22_0.category and arg_22_0.category == arg_22_1 then
		return
	end

	local var_22_0 = var_0_13[arg_22_1]
	local var_22_1 = {}

	arg_22_0.displayShops = {}
	arg_22_0.prevBtn = nil
	pairs = var_4

	for iter_22_0, iter_22_1 in var_4(var_22_0) do
		ipairs = var_1_10009

		local var_22_2

		if not arg_22_0.shops[iter_22_1] then
			var_22_2 = {}
		end

		for iter_22_2, iter_22_3 in var_1_10009(var_22_2) do
			table = var_1_10014

			var_1_10014.insert(var_22_1, {
				type = iter_22_1,
				index = iter_22_2
			})
		end
	end

	local var_22_3 = arg_22_0.shopUIList

	var_4.make(var_22_3, function(arg_23_0, arg_23_1, arg_23_2)
		UIItemList = var_2_10003

		if arg_23_0 == var_2_10003.EventUpdate then
			local var_23_0 = var_22_1[arg_23_1 + 1]
			local var_23_1 = arg_22_0.pages[var_23_0.type]
			local var_23_2 = var_4.CanOpen(var_23_1, var_23_0, arg_22_0.player)

			setActive = var_5

			var_5(arg_23_2:Find("unsel/lock"), not var_23_2)

			GetOrAddComponent = var_5
			var_5(arg_23_2:Find("unsel/label"), "CanvasGroup").alpha = var_23_2 and 1 or 0.4

			local var_23_3 = arg_22_0

			var_5.UpdateShop(var_23_3, arg_23_2, var_23_0)

			if not arg_22_0.displayShops[var_23_0.type] then
				arg_22_0.displayShops[var_23_0.type] = {}
			end

			arg_22_0.displayShops[var_23_0.type][var_23_0.index] = arg_23_2
		end

		return
	end)

	local var_22_4 = arg_22_0.shopUIList

	var_4.align(var_22_4, #var_22_1)

	return
end

local function var_0_16(arg_24_0, arg_24_1)
	local var_24_0 = var_0_1.TYPE2NAME[arg_24_1.type]

	setText = var_3

	var_3(arg_24_0:Find("selected/Text"), var_24_0)

	setText = var_3

	var_3(arg_24_0:Find("unsel/label"), var_24_0)

	return
end

local function var_0_17(arg_25_0, arg_25_1, arg_25_2)
	local var_25_0 = arg_25_1
	local var_25_1 = arg_25_1.Find(var_25_0, "unsel")
	local var_25_2 = arg_25_1:Find("selected")

	onButton = var_25_0

	local var_25_3 = arg_25_0
	local var_25_4 = arg_25_1

	local function var_25_5()
		if arg_25_0.prevBtn == arg_25_1 then
			return
		end

		if arg_25_2() then
			if arg_25_0.prevBtn then
				setActive = var_1

				local var_26_0 = arg_25_0.prevBtn

				var_1(var_3.Find(var_26_0, "unsel"), true)

				setActive = var_1

				local var_26_1 = arg_25_0.prevBtn

				var_1(var_3.Find(var_26_1, "selected"), false)
			end

			setActive = var_1

			var_1(var_25_1, false)

			setActive = var_1

			var_1(var_25_2, true)

			arg_25_0.prevBtn = arg_25_1
		end

		return
	end

	SFX_PANEL = var_1_10010

	var_25_0(var_25_3, var_25_4, var_25_5, var_1_10010)

	setActive = var_25_0

	var_25_0(var_25_1, true)

	setActive = var_25_0

	var_25_0(var_25_2, false)

	return
end

function var_0_1.UpdateShop(arg_27_0, arg_27_1, arg_27_2)
	var_0_16(arg_27_1, arg_27_2)

	local var_27_0 = arg_27_1:Find("selected")
	local var_27_1 = arg_27_1:Find("unsel")

	var_0_17(arg_27_0, arg_27_1, function()
		local var_28_0 = arg_27_0.shops[arg_27_2.type][arg_27_2.index]
		local var_28_1 = arg_27_0.pages[arg_27_2.type]
		local var_28_2, var_28_3 = var_1.CanOpen(var_28_1, var_28_0, arg_27_0.player)

		if var_28_2 then
			if arg_27_0.page then
				local var_28_4 = arg_27_0.page

				if not var_28_1.GetLoaded(var_28_4) then
					return
				end
			end

			if arg_27_0.page then
				local var_28_5 = arg_27_0.page

				var_28_1.Hide(var_28_5)
			end

			local var_28_6 = arg_27_0.contextData.bgView

			var_28_1.Init(var_28_6, var_1:GetBg(var_28_0))
			var_1:ExecuteAction("SetUp", var_28_0, arg_27_0.player, arg_27_0.items)

			var_28_1 = arg_27_0
			var_28_1.page = var_1
			var_28_1 = arg_27_0.contextData
			var_28_1.activeShop = arg_27_2.type
			var_28_1 = arg_27_0.recorder
			var_28_1[arg_27_0.category] = arg_27_2

			return true
		else
			pg = var_28_1

			local var_28_7 = var_28_1.TipsMgr.GetInstance()

			var_4.ShowTips(var_28_7, var_28_3)
		end

		return false
	end)

	return
end

function var_0_1.ActiveDefaultCategory(arg_29_0)
	local var_29_0

	if not arg_29_0.contextData.warp and not arg_29_0.contextData.activeShop then
		var_29_0 = var_0_1.TYPE_ACTIVITY
	end

	type = var_1_10002

	if var_1_10002(var_29_0) == "string" then
		table = var_2

		local var_29_1 = var_2.indexof(var_0_14, var_29_0)

		defaultValue = var_1_10003
		var_29_0 = var_1_10003(var_29_1, var_0_1.TYPE_ACTIVITY)
	end

	local var_29_2

	if not arg_29_0.contextData.index then
		var_29_2 = 1
	end

	if var_29_0 == var_0_1.TYPE_ACTIVITY and arg_29_0.contextData.actId then
		ipairs = var_3

		if not arg_29_0.shops[var_29_0] then
			var_1_10005 = {}
		end

		for iter_29_0, iter_29_1 in var_3(var_1_10005) do
			if iter_29_1.activityId == arg_29_0.contextData.actId then
				var_29_2 = iter_29_0

				break
			end
		end

		goto label_29_0
	end

	if var_29_0 == var_0_1.TYPE_ACTIVITY then
		if arg_29_0.shops[var_0_1.TYPE_ACTIVITY] then
			do
				local var_29_3

				if not arg_29_0.shops[var_0_1.TYPE_ACTIVITY] then
					var_29_3 = {}
				end

				if #var_29_3 <= 0 then
					var_29_0 = var_0_1.TYPE_SHOP_STREET
					var_29_2 = 1

					goto label_29_0
				end

				local var_29_7

				if var_29_0 == var_0_1.TYPE_ACTIVITY and arg_29_0.shops[var_0_1.TYPE_ACTIVITY] then
					local var_29_4

					if not arg_29_0.shops[var_0_1.TYPE_ACTIVITY] then
						var_29_4 = {}
					end

					local var_29_5 = #var_29_4

					if 0 < var_29_5 and not arg_29_0.contextData.actId then
						local var_29_6 = 1

						var_29_7 = arg_29_0.shops[var_29_0][var_29_6].activityId
						ipairs = var_1_10005

						local var_29_8

						if not arg_29_0.shops[var_29_0] then
							var_29_8 = {}
						end

						for iter_29_2, iter_29_3 in var_1_10005(var_29_8) do
							if var_29_7 < iter_29_3.activityId then
								local var_29_9 = iter_29_2
							end
						end
					end
				end
			end

			::label_29_0::

			local var_29_10

			pairs = var_29_7

			for iter_29_4, iter_29_5 in var_29_7(var_0_13) do
				table = iter_29_3

				if iter_29_3.contains(iter_29_5, var_29_0) then
					var_29_10 = iter_29_4

					break
				end
			end

			assert = var_4

			var_4(var_29_10 and arg_29_0.categoryTrs[var_29_10])

			arg_29_0.shopType = var_29_0
			arg_29_0.shopIndex = var_29_2
			triggerToggle = var_4

			var_4(arg_29_0.categoryTrs[var_29_10], true)

			return
		end
	end
end

function var_0_1.ActiveDefaultShop(arg_30_0)
	local var_30_0
	local var_30_1

	if arg_30_0.recorder[arg_30_0.category] then
		var_30_0, var_30_1 = arg_30_0.recorder[arg_30_0.category].type, var_3.index
	else
		var_30_0, var_30_1 = arg_30_0.shopType, arg_30_0.shopIndex or 1
	end

	local function var_30_2()
		local var_31_0

		pairs = var_2_10001

		for iter_31_0, iter_31_1 in var_2_10001(arg_30_0.displayShops) do
			pairs = var_2_10006

			for iter_31_2, iter_31_3 in var_2_10006(iter_31_1) do
				local var_31_1 = arg_30_0.pages[iter_31_0]

				if var_11.CanOpen(var_31_1, nil, arg_30_0.player) then
					var_31_0 = var_31_0 or iter_31_3
				end
			end
		end

		if var_31_0 then
			triggerButton = var_1

			var_1(var_31_0)
		end

		return
	end

	if not var_30_0 then
		var_30_2()

		return
	end

	local var_30_3 = arg_30_0.pages[var_30_0]
	local var_30_4, var_30_5 = var_4.CanOpen(var_30_3, nil, arg_30_0.player)

	if var_30_4 and arg_30_0.displayShops[var_30_0] and arg_30_0.displayShops[var_30_0][var_30_1] then
		triggerButton = var_30_3

		var_30_3(arg_30_0.displayShops[var_30_0][var_30_1])
	else
		if not var_30_4 then
			pg = var_30_3

			local var_30_6 = var_30_3.TipsMgr.GetInstance()

			var_6.ShowTips(var_30_6, var_30_5)
		end

		var_30_2()
	end

	return
end

function var_0_1.onBackPressed(arg_32_0)
	local var_32_0 = arg_32_0.contextData.singleWindow

	if var_1.GetLoaded(var_32_0) then
		local var_32_1 = arg_32_0.contextData.singleWindow

		if var_1.isShowing(var_32_1) then
			local var_32_2 = arg_32_0.contextData.singleWindow

			var_1.Close(var_32_2)

			return
		end
	end

	local var_32_3 = arg_32_0.contextData.multiWindow

	if var_1.GetLoaded(var_32_3) then
		local var_32_4 = arg_32_0.contextData.multiWindow

		if var_1.isShowing(var_32_4) then
			local var_32_5 = arg_32_0.contextData.multiWindow

			var_1.Close(var_32_5)

			return
		end
	end

	local var_32_6 = arg_32_0.contextData.singleWindowForESkin

	if var_1.GetLoaded(var_32_6) then
		local var_32_7 = arg_32_0.contextData.singleWindowForESkin

		if var_1.isShowing(var_32_7) then
			local var_32_8 = arg_32_0.contextData.singleWindowForESkin

			var_1.Hide(var_32_8)

			return
		end
	end

	var_0_1.super.onBackPressed(arg_32_0)

	return
end

function var_0_1.BlurView(arg_33_0)
	local var_33_0 = arg_33_0.frameTr
	local var_33_1 = var_1.Find(var_33_0, "bg/blur")

	pg = var_1_10002

	local var_33_2 = var_1_10002.UIMgr.GetInstance()
	local var_33_3 = var_2.OverlayPanel
	local var_33_4 = arg_33_0.frameTr
	local var_33_5 = {}
	local var_33_6 = {}
	local var_33_7 = arg_33_0.frameTr

	var_33_6[1] = var_8.Find(var_33_7, "bg")
	var_33_6[2] = var_33_1
	var_33_5.pbList = var_33_6

	var_33_3(var_33_2, var_33_4, var_33_5)
	var_33_1:SetAsFirstSibling()

	return
end

function var_0_1.UnBlurView(arg_34_0)
	pg = var_1_10001

	local var_34_0 = var_1_10001.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_34_0, arg_34_0.frameTr, arg_34_0._tf)

	return
end

function var_0_1.willExit(arg_35_0)
	if arg_35_0.bulinTip then
		local var_35_0 = arg_35_0.bulinTip

		var_1.Destroy(var_35_0)

		arg_35_0.bulinTip = nil
	end

	pairs = var_1

	for iter_35_0, iter_35_1 in var_1(arg_35_0.pages) do
		iter_35_1:Destroy()
	end

	arg_35_0:UnBlurView()

	local var_35_1 = arg_35_0.contextData.singleWindow

	var_1.Destroy(var_35_1)

	local var_35_2 = arg_35_0.contextData.multiWindow

	var_1.Destroy(var_35_2)

	local var_35_3 = arg_35_0.contextData.singleWindowForESkin

	var_1.Destroy(var_35_3)

	local var_35_4 = arg_35_0.contextData.paintingView

	var_1.Dispose(var_35_4)

	local var_35_5 = arg_35_0.contextData.bgView

	var_1.Dispose(var_35_5)

	arg_35_0.contextData.singleWindow = nil
	arg_35_0.contextData.multiWindow = nil
	arg_35_0.contextData.singleWindowForESkin = nil
	arg_35_0.contextData.paintingView = nil
	arg_35_0.contextData.bgView = nil
	arg_35_0.pages = nil
	arg_35_0.bulinTip = nil

	return
end

return var_0_1
