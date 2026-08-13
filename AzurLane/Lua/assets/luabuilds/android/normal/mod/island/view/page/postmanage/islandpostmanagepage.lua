class = var_0_10000

local var_0_0 = "IslandPostManagePage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("...base.IslandBasePage"))

var_0_1.PAGE_PROD = "prod"
var_0_1.PAGE_REST = "rest"
var_0_1.PAGE_COLLECTION = "collection"
var_0_1.EVENT_SHOW_SP_EVENT_TIP = "IslandPostManagePage:EVENT_SHOW_SP_EVENT_TIP"

function var_0_1.getUIName(arg_1_0)
	return "IslandPostManageUI"
end

function var_0_1.OnLoaded(arg_2_0)
	setText = var_1_10001

	local var_2_0 = arg_2_0._tf
	local var_2_1 = var_2.Find(var_2_0, "top/title/Text")

	i18n = var_2_0

	var_1_10001(var_2_1, var_2_0("island_post_manage"))

	local var_2_2 = arg_2_0._tf
	local var_2_3 = var_1.Find(var_2_2, "Adapt/pages")

	arg_2_0.pages = {}

	local var_2_4 = arg_2_0.pages
	local var_2_5 = var_0_1.PAGE_PROD

	IslandPostProdPanel = var_4

	local var_2_6 = var_4.New
	local var_2_7 = var_2_3
	local var_2_8 = arg_2_0.event

	setmetatable = var_1_10007
	var_2_4[var_2_5] = var_2_6(var_2_7, var_2_8, var_1_10007({
		ShowMsgBox = function(arg_3_0, arg_3_1)
			local var_3_0 = arg_2_0

			var_2.ShowMsgBox(var_3_0, arg_3_1)

			return
		end
	}, {
		__index = arg_2_0.contextData
	}))

	local var_2_9 = arg_2_0.pages
	local var_2_10 = var_0_1.PAGE_REST

	IslandPostRestPanel = var_4
	var_2_9[var_2_10] = var_4.New(var_2_3, arg_2_0.event)

	local var_2_11 = arg_2_0.pages
	local var_2_12 = var_0_1.PAGE_COLLECTION

	IslandCollectionPanel = var_4

	local var_2_13 = var_4.New
	local var_2_14 = var_2_3
	local var_2_15 = arg_2_0.event

	setmetatable = var_7
	var_2_11[var_2_12] = var_2_13(var_2_14, var_2_15, var_7({
		ShowMsgBox = function(arg_4_0, arg_4_1)
			local var_4_0 = arg_2_0

			var_2.ShowMsgBox(var_4_0, arg_4_1)

			return
		end
	}, {
		__index = arg_2_0.contextData
	}))

	local var_2_16 = arg_2_0._tf

	arg_2_0.togglesTF = var_2.Find(var_2_16, "Adapt/types/content")
	setText = var_2

	local var_2_17 = arg_2_0.togglesTF
	local var_2_18 = var_3.Find(var_2_17, "prod/unsel")

	i18n = var_2_17

	var_2(var_2_18, var_2_17("island_post_produce"))

	setText = var_2

	local var_2_19 = arg_2_0.togglesTF
	local var_2_20 = var_3.Find(var_2_19, "prod/sel/content/Text")

	i18n = var_2_19

	var_2(var_2_20, var_2_19("island_post_produce"))

	setText = var_2

	local var_2_21 = arg_2_0.togglesTF
	local var_2_22 = var_3.Find(var_2_21, "rest/unsel")

	i18n = var_2_21

	var_2(var_2_22, var_2_21("island_post_operate"))

	setText = var_2

	local var_2_23 = arg_2_0.togglesTF
	local var_2_24 = var_3.Find(var_2_23, "rest/sel/content/Text")

	i18n = var_2_23

	var_2(var_2_24, var_2_23("island_post_operate"))

	setText = var_2

	local var_2_25 = arg_2_0.togglesTF
	local var_2_26 = var_3.Find(var_2_25, "collection/unsel")

	i18n = var_2_25

	var_2(var_2_26, var_2_25("island_chara_gather_tip"))

	setText = var_2

	local var_2_27 = arg_2_0.togglesTF
	local var_2_28 = var_3.Find(var_2_27, "collection/sel/content/Text")

	i18n = var_2_27

	var_2(var_2_28, var_2_27("island_chara_gather_tip"))

	local var_2_29 = arg_2_0._tf

	arg_2_0.signInNoticeTF = var_2.Find(var_2_29, "Adapt/signInBtn/notice")

	local var_2_30 = arg_2_0._tf

	arg_2_0.bookBtn = var_2.Find(var_2_30, "Adapt/book_btn")
	IslandAwardDisplayInMainPanel = var_2
	arg_2_0.awardDisplayPanel = var_2.New(arg_2_0._tf, arg_2_0.event)
	setText = var_2

	local var_2_31 = arg_2_0.bookBtn
	local var_2_32 = var_3.Find(var_2_31, "Text")

	i18n = var_2_31

	var_2(var_2_32, var_2_31("island_post_btn_set_meal"))

	setText = var_2

	local var_2_33 = arg_2_0._tf
	local var_2_34 = var_3.Find(var_2_33, "Adapt/signInBtn/Text")

	i18n = var_2_33

	var_2(var_2_34, var_2_33("island_post_btn_sign"))

	return
end

function var_0_1.OnInit(arg_5_0)
	arg_5_0:bind(var_0_1.EVENT_SHOW_SP_EVENT_TIP, function(arg_6_0, arg_6_1, arg_6_2)
		setParent = var_2_10003

		local var_6_0 = arg_5_0._tf

		pg = var_2_10005

		var_2_10003(var_6_0, var_2_10005.UIMgr.GetInstance().UIMain)

		local var_6_1 = arg_5_0
		local var_6_2 = var_3.ShowMsgBox
		local var_6_3 = {}

		IslandMsgBox = var_2_10006
		var_6_3.type = var_2_10006.TYPE_ISLAND_POST_EVENT
		var_6_3.rest = arg_6_1
		var_6_3.isNew = arg_6_2

		function var_6_3.onHide()
			setParent = var_3_10000

			local var_7_0 = arg_5_0._tf

			pg = var_3_10002

			var_3_10000(var_7_0, var_3_10002.UIMgr.GetInstance().OverlayMain)

			return
		end

		function var_6_3.onYes()
			local var_8_0 = arg_5_0.pages[var_0_1.PAGE_REST]

			var_0.TriggerEvent(var_8_0, arg_6_1.id)

			return
		end

		var_6_2(var_6_1, var_6_3)

		return
	end)

	onButton = var_1

	local var_5_0 = arg_5_0
	local var_5_1 = arg_5_0.bookBtn

	local function var_5_2()
		local var_9_0 = arg_5_0
		local var_9_1 = var_0.OpenPage

		IslandSetMealHandbookPage = var_2_10002

		var_9_1(var_9_0, var_2_10002)

		return
	end

	SFX_PANEL = var_1_10005

	var_1(var_5_0, var_5_1, var_5_2, var_1_10005)

	onButton = var_1

	local var_5_3 = arg_5_0
	local var_5_4 = arg_5_0._tf
	local var_5_5 = var_3.Find(var_5_4, "top/title/help")

	local function var_5_6()
		local var_10_0 = arg_5_0
		local var_10_1 = var_0.ShowMsgBox
		local var_10_2 = {}

		IslandMsgBox = var_2_10003
		var_10_2.type = var_2_10003.TYPE_WHITOUT_BTN
		i18n = var_3
		var_10_2.content = var_3("island_helpbtn_commission")

		var_10_1(var_10_0, var_10_2)

		return
	end

	SFX_PANEL = var_5

	var_1(var_5_3, var_5_5, var_5_6, var_5)

	onButton = var_1

	local var_5_7 = arg_5_0
	local var_5_8 = arg_5_0._tf
	local var_5_9 = var_3.Find(var_5_8, "top/back")

	local function var_5_10()
		local var_11_0 = arg_5_0

		var_0.Hide(var_11_0)

		return
	end

	SFX_PANEL = var_5

	var_1(var_5_7, var_5_9, var_5_10, var_5)

	onButton = var_1

	local var_5_11 = arg_5_0
	local var_5_12 = arg_5_0._tf
	local var_5_13 = var_3.Find(var_5_12, "top/home")

	local function var_5_14()
		local var_12_0 = arg_5_0
		local var_12_1 = var_0.emit

		BaseUI = var_2_10002

		var_12_1(var_12_0, var_2_10002.ON_HOME)

		return
	end

	SFX_PANEL = var_5

	var_1(var_5_11, var_5_13, var_5_14, var_5)

	onButton = var_1

	local var_5_15 = arg_5_0
	local var_5_16 = arg_5_0._tf
	local var_5_17 = var_3.Find(var_5_16, "Adapt/signInBtn")

	local function var_5_18()
		local var_13_0 = arg_5_0

		var_0.Hide(var_13_0)

		local var_13_1 = arg_5_0
		local var_13_2 = var_0.emit

		IslandBaseMediator = var_2_10002

		local var_13_3 = var_2_10002.SWITCH_MAP

		IslandConst = var_2_10003

		local var_13_4 = var_2_10003.AGORA_MAP_ID

		IslandConst = var_2_10004

		var_13_2(var_13_1, var_13_3, var_13_4, var_2_10004.SIGNIN_SP)

		return
	end

	SFX_PANEL = var_5

	var_1(var_5_15, var_5_17, var_5_18, var_5)

	eachChild = var_1

	var_1(arg_5_0.togglesTF, function(arg_14_0)
		onToggle = var_2_10001

		local var_14_0 = arg_5_0
		local var_14_1 = arg_14_0

		local function var_14_2(arg_15_0)
			if arg_15_0 then
				arg_5_0.curPage = arg_14_0.name
				arg_5_0.contextData.curPage = arg_5_0.curPage

				local var_15_0 = arg_5_0

				var_1.SwitchPage(var_15_0)
			end

			return
		end

		SFX_PANEL = var_2_10005

		var_2_10001(var_14_0, var_14_1, var_14_2, var_2_10005)

		return
	end)

	pg = var_1
	arg_5_0.buildingIds = var_1.island_set.post_manage_produce.key_value_varchar
	pg = var_1
	arg_5_0.restIds = var_1.island_set.post_manage_operate.key_value_varchar
	setActive = var_1

	local var_5_19 = arg_5_0.bookBtn
	local var_5_20 = arg_5_0:GetSelfIsland()
	local var_5_21 = var_3.GetAblityAgency(var_5_20)
	local var_5_22 = var_3.HasAbility

	IslandAblityAgency = var_5

	var_1(var_5_19, var_5_22(var_5_21, var_5.SET_MEAL_ID))

	return
end

function var_0_1.AddListeners(arg_16_0)
	local var_16_0 = arg_16_0
	local var_16_1 = arg_16_0.AddListener

	GAME = var_1_10003

	var_16_1(var_16_0, var_1_10003.ISLAND_START_DELEGATION_DONE, arg_16_0.FlushProdPage)

	local var_16_2 = arg_16_0
	local var_16_3 = arg_16_0.AddListener

	GAME = var_3

	var_16_3(var_16_2, var_3.ISLAND_FINISH_DELEGATION_DONE, arg_16_0.OnFlushProdPageAndShipExpDone)

	local var_16_4 = arg_16_0
	local var_16_5 = arg_16_0.AddListener

	GAME = var_3

	var_16_5(var_16_4, var_3.ISLAND_GET_DELEGATION_AWARD_DONE, arg_16_0.OnFlushProdPageAndShipExpDone)

	local var_16_6 = arg_16_0
	local var_16_7 = arg_16_0.AddListener

	GAME = var_3

	var_16_7(var_16_6, var_3.ISLAND_OPEN_RESTAURANT_DONE, arg_16_0.FlushRestPage)

	local var_16_8 = arg_16_0
	local var_16_9 = arg_16_0.AddListener

	GAME = var_3

	var_16_9(var_16_8, var_3.ISLAND_CLOSE_RESTAURANT_DONE, arg_16_0.FlushRestPage)

	local var_16_10 = arg_16_0
	local var_16_11 = arg_16_0.AddListener

	IslandManageAgecny = var_3

	var_16_11(var_16_10, var_3.ADD_RESTAURANT, arg_16_0.FlushRestPage)

	local var_16_12 = arg_16_0
	local var_16_13 = arg_16_0.AddListener

	IslandManageAgecny = var_3

	var_16_13(var_16_12, var_3.ADD_ASSISTANT, arg_16_0.FlushRestPage)

	local var_16_14 = arg_16_0
	local var_16_15 = arg_16_0.AddListener

	IslandManageAgecny = var_3

	var_16_15(var_16_14, var_3.ON_DAILY_REFRESH, arg_16_0.FlushRestPage)

	local var_16_16 = arg_16_0
	local var_16_17 = arg_16_0.AddListener

	GAME = var_3

	var_16_17(var_16_16, var_3.ISLAND_GET_AUTO_COLLECTION_DATA_DONE, arg_16_0.OnGetCollctionData)

	local var_16_18 = arg_16_0
	local var_16_19 = arg_16_0.AddListener

	GAME = var_3

	var_16_19(var_16_18, var_3.ISLAND_TAKE_AUTO_COLLECTION_DONE, arg_16_0.OnGetCollctionDone)

	return
end

function var_0_1.RemoveListeners(arg_17_0)
	local var_17_0 = arg_17_0
	local var_17_1 = arg_17_0.RemoveListener

	GAME = var_1_10003

	var_17_1(var_17_0, var_1_10003.ISLAND_START_DELEGATION_DONE, arg_17_0.FlushProdPage)

	local var_17_2 = arg_17_0
	local var_17_3 = arg_17_0.RemoveListener

	GAME = var_3

	var_17_3(var_17_2, var_3.ISLAND_FINISH_DELEGATION_DONE, arg_17_0.OnFlushProdPageAndShipExpDone)

	local var_17_4 = arg_17_0
	local var_17_5 = arg_17_0.RemoveListener

	GAME = var_3

	var_17_5(var_17_4, var_3.ISLAND_GET_DELEGATION_AWARD_DONE, arg_17_0.OnFlushProdPageAndShipExpDone)

	local var_17_6 = arg_17_0
	local var_17_7 = arg_17_0.RemoveListener

	GAME = var_3

	var_17_7(var_17_6, var_3.ISLAND_OPEN_RESTAURANT_DONE, arg_17_0.FlushRestPage)

	local var_17_8 = arg_17_0
	local var_17_9 = arg_17_0.RemoveListener

	GAME = var_3

	var_17_9(var_17_8, var_3.ISLAND_CLOSE_RESTAURANT_DONE, arg_17_0.FlushRestPage)

	local var_17_10 = arg_17_0
	local var_17_11 = arg_17_0.RemoveListener

	IslandManageAgecny = var_3

	var_17_11(var_17_10, var_3.ADD_RESTAURANT, arg_17_0.FlushRestPage)

	local var_17_12 = arg_17_0
	local var_17_13 = arg_17_0.RemoveListener

	IslandManageAgecny = var_3

	var_17_13(var_17_12, var_3.ADD_ASSISTANT, arg_17_0.FlushRestPage)

	local var_17_14 = arg_17_0
	local var_17_15 = arg_17_0.RemoveListener

	IslandManageAgecny = var_3

	var_17_15(var_17_14, var_3.ON_DAILY_REFRESH, arg_17_0.FlushRestPage)

	local var_17_16 = arg_17_0
	local var_17_17 = arg_17_0.RemoveListener

	GAME = var_3

	var_17_17(var_17_16, var_3.ISLAND_GET_AUTO_COLLECTION_DATA_DONE, arg_17_0.OnGetCollctionData)

	local var_17_18 = arg_17_0
	local var_17_19 = arg_17_0.RemoveListener

	GAME = var_3

	var_17_19(var_17_18, var_3.ISLAND_TAKE_AUTO_COLLECTION_DONE, arg_17_0.OnGetCollctionDone)

	return
end

function var_0_1.SwitchPage(arg_18_0)
	pairs = var_1_10001

	for iter_18_0, iter_18_1 in var_1_10001(arg_18_0.pages) do
		if iter_18_0 == arg_18_0.curPage then
			if arg_18_0.curPage == var_0_1.PAGE_COLLECTION then
				pg = var_6

				local var_18_0 = var_6.UIMgr.GetInstance()

				var_6.LoadingOn(var_18_0)

				local var_18_1 = arg_18_0
				local var_18_2 = arg_18_0.emit

				IslandMediator = var_1_10008

				var_18_2(var_18_1, var_1_10008.GET_AUTO_COLLECTION_DATA, 1)
			else
				iter_18_1:ExecuteAction("Show")
			end
		else
			iter_18_1:ExecuteAction("Hide")
		end
	end

	return
end

function var_0_1.OnGetCollctionData(arg_19_0, arg_19_1)
	local var_19_0 = arg_19_0.pages[var_0_1.PAGE_COLLECTION]

	var_2.ExecuteAction(var_19_0, "Show", arg_19_1.data)

	pg = var_2

	local var_19_1 = var_2.TimeMgr.GetInstance()
	local var_19_2 = var_2.GetServerTime(var_19_1)

	getProxy = var_19_1
	PlayerProxy = var_4

	local var_19_3 = var_19_1(var_4)
	local var_19_4 = var_3.getPlayerId(var_19_3)
	local var_19_5 = "IslandSignAutoCollectTime"

	tostring = var_5

	local var_19_6 = var_19_5 .. var_5(var_19_4)

	PlayerPrefs = var_5

	var_5.SetInt(var_19_6, var_19_2)
	arg_19_0:FlushCollectionTip()

	pg = var_5

	local var_19_7 = var_5.UIMgr.GetInstance()

	var_5.LoadingOff(var_19_7)

	return
end

function var_0_1.OnGetCollctionDone(arg_20_0, arg_20_1)
	local var_20_0 = arg_20_0.pages[var_0_1.PAGE_COLLECTION]

	var_2.ExecuteAction(var_20_0, "OnGetCollctionDone", arg_20_1)

	return
end

function var_0_1.OnShow(arg_21_0)
	arg_21_0:BlurPanel()

	triggerToggle = var_1

	local var_21_0 = arg_21_0.togglesTF
	local var_21_1 = var_2.Find
	local var_21_2

	if not arg_21_0.contextData.curPage then
		var_21_2 = var_0_1.PAGE_PROD
	end

	var_1(var_21_1(var_21_0, var_21_2), true)
	arg_21_0:FlushTips()

	setActive = var_1

	local var_21_3 = arg_21_0.signInNoticeTF

	getProxy = var_3
	IslandProxy = var_21_2

	local var_21_4 = var_3(var_21_2)
	local var_21_5 = var_3.GetIsland(var_21_4)
	local var_21_6 = var_3.GetSignInAgency(var_21_5)

	var_1(var_21_3, var_3.CanSignIn(var_21_6))

	return
end

function var_0_1.FlushTips(arg_22_0)
	arg_22_0:FlushProdTip()
	arg_22_0:FlushRestTip()
	arg_22_0:FlushCollectionTip()

	return
end

function var_0_1.FlushProdTip(arg_23_0)
	IslandMainBtnTipHelper = var_1_10001

	local var_23_0 = var_1_10001.IsPostProdTip()

	setActive = var_1_10002

	local var_23_1 = arg_23_0.togglesTF

	var_1_10002(var_3.Find(var_23_1, "prod/unsel/tip"), var_23_0)

	setActive = var_1_10002

	local var_23_2 = arg_23_0.togglesTF

	var_1_10002(var_3.Find(var_23_2, "prod/sel/tip"), var_23_0)

	return
end

function var_0_1.FlushRestTip(arg_24_0)
	IslandMainBtnTipHelper = var_1_10001

	local var_24_0 = var_1_10001.IsPostRestTip()

	setActive = var_1_10002

	local var_24_1 = arg_24_0.togglesTF

	var_1_10002(var_3.Find(var_24_1, "rest/unsel/tip"), var_24_0)

	setActive = var_1_10002

	local var_24_2 = arg_24_0.togglesTF

	var_1_10002(var_3.Find(var_24_2, "rest/sel/tip"), var_24_0)

	return
end

function var_0_1.FlushCollectionTip(arg_25_0)
	IslandMainBtnTipHelper = var_1_10001

	local var_25_0 = var_1_10001.IsPostCollectionTip()

	setActive = var_1_10002

	local var_25_1 = arg_25_0.togglesTF

	var_1_10002(var_3.Find(var_25_1, "collection/unsel/tip"), var_25_0)

	setActive = var_1_10002

	local var_25_2 = arg_25_0.togglesTF

	var_1_10002(var_3.Find(var_25_2, "collection/sel/tip"), var_25_0)

	return
end

function var_0_1.OnFlushProdPageAndShipExpDone(arg_26_0, arg_26_1)
	if arg_26_1.addShipExpData then
		local var_26_0 = {}
		local var_26_1 = arg_26_1.addShipExpData.addShipId
		local var_26_2 = arg_26_1.addShipExpData.addExp

		IslandShip = var_1_10005

		local var_26_3 = var_1_10005.StaticGetPrefab(var_26_1)
		local var_26_4 = "island/IslandShipIcon/" .. var_26_3
		local var_26_5 = arg_26_0.awardDisplayPanel

		var_7.ExecuteAction(var_26_5, "ShowAwards", {
			shipExp = true,
			icon = var_26_4,
			num = var_26_2
		})
	end

	arg_26_0:FlushProdPage(arg_26_1)

	return
end

function var_0_1.FlushProdPage(arg_27_0, arg_27_1)
	arg_27_0:FlushProdTip()

	local var_27_0 = arg_27_0.pages[var_0_1.PAGE_PROD]

	var_2.ExecuteAction(var_27_0, "FlushSlot", arg_27_1.slotId)

	return
end

function var_0_1.FlushRestPage(arg_28_0)
	arg_28_0:FlushRestTip()

	local var_28_0 = arg_28_0.pages[var_0_1.PAGE_REST]

	var_1.ExecuteAction(var_28_0, "Flush")

	return
end

function var_0_1.OnHide(arg_29_0)
	arg_29_0:UnBlurPanel()

	if arg_29_0.awardDisplayPanel then
		local var_29_0 = arg_29_0.awardDisplayPanel

		var_1.Hide(var_29_0)
	end

	return
end

function var_0_1.OnDisable(arg_30_0)
	arg_30_0:OnHide()

	return
end

function var_0_1.OnDestroy(arg_31_0)
	arg_31_0:UnBlurPanel()

	pairs = var_1

	for iter_31_0, iter_31_1 in var_1(arg_31_0.pages) do
		if iter_31_1 then
			iter_31_1:Destroy()

			iter_31_1 = nil
		end
	end

	if arg_31_0.awardDisplayPanel then
		local var_31_0 = arg_31_0.awardDisplayPanel

		var_1.Destroy(var_31_0)

		arg_31_0.awardDisplayPanel = nil
	end

	return
end

return var_0_1
