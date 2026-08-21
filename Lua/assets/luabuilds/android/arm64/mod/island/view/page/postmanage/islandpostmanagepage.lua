local var_0_0 = class("IslandPostManagePage", import("...base.IslandBasePage"))

var_0_0.PAGE_PROD = "prod"
var_0_0.PAGE_REST = "rest"
var_0_0.PAGE_COLLECTION = "collection"
var_0_0.EVENT_SHOW_SP_EVENT_TIP = "IslandPostManagePage:EVENT_SHOW_SP_EVENT_TIP"

function var_0_0.getUIName(arg_1_0)
	return "IslandPostManageUI"
end

function var_0_0.OnLoaded(arg_2_0)
	setText(arg_2_0._tf:Find("top/title/Text"), i18n("island_post_manage"))

	local var_2_0 = arg_2_0._tf:Find("Adapt/pages")

	arg_2_0.pages = {}
	arg_2_0.pages[var_0_0.PAGE_PROD] = IslandPostProdPanel.New(var_2_0, arg_2_0.event, setmetatable({
		ShowMsgBox = function(arg_3_0, arg_3_1)
			arg_2_0:ShowMsgBox(arg_3_1)

			return
		end
	}, {
		__index = arg_2_0.contextData
	}))
	arg_2_0.pages[var_0_0.PAGE_REST] = IslandPostRestPanel.New(var_2_0, arg_2_0.event)
	arg_2_0.pages[var_0_0.PAGE_COLLECTION] = IslandCollectionPanel.New(var_2_0, arg_2_0.event, setmetatable({
		ShowMsgBox = function(arg_4_0, arg_4_1)
			arg_2_0:ShowMsgBox(arg_4_1)

			return
		end
	}, {
		__index = arg_2_0.contextData
	}))
	arg_2_0.togglesTF = arg_2_0._tf:Find("Adapt/types/content")

	setText(arg_2_0.togglesTF:Find("prod/unsel"), i18n("island_post_produce"))
	setText(arg_2_0.togglesTF:Find("prod/sel/content/Text"), i18n("island_post_produce"))
	setText(arg_2_0.togglesTF:Find("rest/unsel"), i18n("island_post_operate"))
	setText(arg_2_0.togglesTF:Find("rest/sel/content/Text"), i18n("island_post_operate"))
	setText(arg_2_0.togglesTF:Find("collection/unsel"), i18n("island_chara_gather_tip"))
	setText(arg_2_0.togglesTF:Find("collection/sel/content/Text"), i18n("island_chara_gather_tip"))

	arg_2_0.signInNoticeTF = arg_2_0._tf:Find("Adapt/signInBtn/notice")
	arg_2_0.bookBtn = arg_2_0._tf:Find("Adapt/book_btn")
	arg_2_0.awardDisplayPanel = IslandAwardDisplayInMainPanel.New(arg_2_0._tf, arg_2_0.event)

	setText(arg_2_0.bookBtn:Find("Text"), i18n("island_post_btn_set_meal"))
	setText(arg_2_0._tf:Find("Adapt/signInBtn/Text"), i18n("island_post_btn_sign"))

	return
end

function var_0_0.OnInit(arg_5_0)
	arg_5_0:bind(var_0_0.EVENT_SHOW_SP_EVENT_TIP, function(arg_6_0, arg_6_1, arg_6_2)
		setParent(arg_5_0._tf, pg.UIMgr.GetInstance().UIMain)
		arg_5_0:ShowMsgBox({
			type = IslandMsgBox.TYPE_ISLAND_POST_EVENT,
			rest = arg_6_1,
			isNew = arg_6_2,
			onHide = function()
				setParent(arg_5_0._tf, pg.UIMgr.GetInstance().OverlayMain)

				return
			end,
			onYes = function()
				arg_5_0.pages[var_0_0.PAGE_REST]:TriggerEvent(arg_6_1.id)

				return
			end
		})

		return
	end)
	onButton(arg_5_0, arg_5_0.bookBtn, function()
		arg_5_0:OpenPage(IslandSetMealHandbookPage)

		return
	end, SFX_PANEL)
	onButton(arg_5_0, arg_5_0._tf:Find("top/title/help"), function()
		arg_5_0:ShowMsgBox({
			type = IslandMsgBox.TYPE_WHITOUT_BTN,
			content = i18n("island_helpbtn_commission")
		})

		return
	end, SFX_PANEL)
	onButton(arg_5_0, arg_5_0._tf:Find("top/back"), function()
		arg_5_0:Hide()

		return
	end, SFX_PANEL)
	onButton(arg_5_0, arg_5_0._tf:Find("top/home"), function()
		arg_5_0:emit(BaseUI.ON_HOME)

		return
	end, SFX_PANEL)
	onButton(arg_5_0, arg_5_0._tf:Find("Adapt/signInBtn"), function()
		arg_5_0:Hide()
		arg_5_0:emit(IslandBaseMediator.SWITCH_MAP, IslandConst.AGORA_MAP_ID, IslandConst.SIGNIN_SP)

		return
	end, SFX_PANEL)
	eachChild(arg_5_0.togglesTF, function(arg_14_0)
		onToggle(arg_5_0, arg_14_0, function(arg_15_0)
			if arg_15_0 then
				arg_5_0.curPage = arg_14_0.name
				arg_5_0.contextData.curPage = arg_5_0.curPage

				arg_5_0:SwitchPage()
			end

			return
		end, SFX_PANEL)

		return
	end)

	arg_5_0.buildingIds = pg.island_set.post_manage_produce.key_value_varchar
	arg_5_0.restIds = pg.island_set.post_manage_operate.key_value_varchar

	setActive(arg_5_0.bookBtn, arg_5_0:GetSelfIsland():GetAblityAgency():HasAbility(IslandAblityAgency.SET_MEAL_ID))

	return
end

function var_0_0.AddListeners(arg_16_0)
	arg_16_0:AddListener(GAME.ISLAND_START_DELEGATION_DONE, arg_16_0.FlushProdPage)
	arg_16_0:AddListener(GAME.ISLAND_FINISH_DELEGATION_DONE, arg_16_0.OnFlushProdPageAndShipExpDone)
	arg_16_0:AddListener(GAME.ISLAND_GET_DELEGATION_AWARD_DONE, arg_16_0.OnFlushProdPageAndShipExpDone)
	arg_16_0:AddListener(GAME.ISLAND_OPEN_RESTAURANT_DONE, arg_16_0.FlushRestPage)
	arg_16_0:AddListener(GAME.ISLAND_CLOSE_RESTAURANT_DONE, arg_16_0.FlushRestPage)
	arg_16_0:AddListener(IslandManageAgecny.ADD_RESTAURANT, arg_16_0.FlushRestPage)
	arg_16_0:AddListener(IslandManageAgecny.ADD_ASSISTANT, arg_16_0.FlushRestPage)
	arg_16_0:AddListener(IslandManageAgecny.ON_DAILY_REFRESH, arg_16_0.FlushRestPage)
	arg_16_0:AddListener(GAME.ISLAND_GET_AUTO_COLLECTION_DATA_DONE, arg_16_0.OnGetCollctionData)
	arg_16_0:AddListener(GAME.ISLAND_TAKE_AUTO_COLLECTION_DONE, arg_16_0.OnGetCollctionDone)

	return
end

function var_0_0.RemoveListeners(arg_17_0)
	arg_17_0:RemoveListener(GAME.ISLAND_START_DELEGATION_DONE, arg_17_0.FlushProdPage)
	arg_17_0:RemoveListener(GAME.ISLAND_FINISH_DELEGATION_DONE, arg_17_0.OnFlushProdPageAndShipExpDone)
	arg_17_0:RemoveListener(GAME.ISLAND_GET_DELEGATION_AWARD_DONE, arg_17_0.OnFlushProdPageAndShipExpDone)
	arg_17_0:RemoveListener(GAME.ISLAND_OPEN_RESTAURANT_DONE, arg_17_0.FlushRestPage)
	arg_17_0:RemoveListener(GAME.ISLAND_CLOSE_RESTAURANT_DONE, arg_17_0.FlushRestPage)
	arg_17_0:RemoveListener(IslandManageAgecny.ADD_RESTAURANT, arg_17_0.FlushRestPage)
	arg_17_0:RemoveListener(IslandManageAgecny.ADD_ASSISTANT, arg_17_0.FlushRestPage)
	arg_17_0:RemoveListener(IslandManageAgecny.ON_DAILY_REFRESH, arg_17_0.FlushRestPage)
	arg_17_0:RemoveListener(GAME.ISLAND_GET_AUTO_COLLECTION_DATA_DONE, arg_17_0.OnGetCollctionData)
	arg_17_0:RemoveListener(GAME.ISLAND_TAKE_AUTO_COLLECTION_DONE, arg_17_0.OnGetCollctionDone)

	return
end

function var_0_0.SwitchPage(arg_18_0)
	for iter_18_0, iter_18_1 in pairs(arg_18_0.pages) do
		if iter_18_0 == arg_18_0.curPage then
			if arg_18_0.curPage == var_0_0.PAGE_COLLECTION then
				pg.UIMgr.GetInstance():LoadingOn()
				arg_18_0:emit(IslandMediator.GET_AUTO_COLLECTION_DATA, 1)
			else
				iter_18_1:ExecuteAction("Show")
			end
		else
			iter_18_1:ExecuteAction("Hide")
		end
	end

	return
end

function var_0_0.OnGetCollctionData(arg_19_0, arg_19_1)
	arg_19_0.pages[var_0_0.PAGE_COLLECTION]:ExecuteAction("Show", arg_19_1.data)
	PlayerPrefs.SetInt("IslandSignAutoCollectTime" .. tostring((getProxy(PlayerProxy):getPlayerId())), (pg.TimeMgr.GetInstance():GetServerTime()))
	arg_19_0:FlushCollectionTip()
	pg.UIMgr.GetInstance():LoadingOff()

	return
end

function var_0_0.OnGetCollctionDone(arg_20_0, arg_20_1)
	arg_20_0.pages[var_0_0.PAGE_COLLECTION]:ExecuteAction("OnGetCollctionDone", arg_20_1)

	return
end

function var_0_0.OnShow(arg_21_0)
	arg_21_0:BlurPanel()

	local var_21_0 = arg_21_0.contextData.curPage or var_0_0.PAGE_PROD

	triggerToggle(arg_21_0.togglesTF:Find(var_21_0), true)
	arg_21_0:FlushTips()
	setActive(arg_21_0.signInNoticeTF, getProxy(IslandProxy):GetIsland():GetSignInAgency():CanSignIn())

	return
end

function var_0_0.FlushTips(arg_22_0)
	arg_22_0:FlushProdTip()
	arg_22_0:FlushRestTip()
	arg_22_0:FlushCollectionTip()

	return
end

function var_0_0.FlushProdTip(arg_23_0)
	local var_23_0 = IslandMainBtnTipHelper.IsPostProdTip()

	setActive(arg_23_0.togglesTF:Find("prod/unsel/tip"), var_23_0)
	setActive(arg_23_0.togglesTF:Find("prod/sel/tip"), var_23_0)

	return
end

function var_0_0.FlushRestTip(arg_24_0)
	local var_24_0 = IslandMainBtnTipHelper.IsPostRestTip()

	setActive(arg_24_0.togglesTF:Find("rest/unsel/tip"), var_24_0)
	setActive(arg_24_0.togglesTF:Find("rest/sel/tip"), var_24_0)

	return
end

function var_0_0.FlushCollectionTip(arg_25_0)
	local var_25_0 = IslandMainBtnTipHelper.IsPostCollectionTip()

	setActive(arg_25_0.togglesTF:Find("collection/unsel/tip"), var_25_0)
	setActive(arg_25_0.togglesTF:Find("collection/sel/tip"), var_25_0)

	return
end

function var_0_0.OnFlushProdPageAndShipExpDone(arg_26_0, arg_26_1)
	if arg_26_1.addShipExpData then
		arg_26_0.awardDisplayPanel:ExecuteAction("ShowAwards", {
			shipExp = true,
			icon = "island/IslandShipIcon/" .. IslandShip.StaticGetPrefab(arg_26_1.addShipExpData.addShipId),
			num = arg_26_1.addShipExpData.addExp
		})
	end

	arg_26_0:FlushProdPage(arg_26_1)

	return
end

function var_0_0.FlushProdPage(arg_27_0, arg_27_1)
	arg_27_0:FlushProdTip()
	arg_27_0.pages[var_0_0.PAGE_PROD]:ExecuteAction("FlushSlot", arg_27_1.slotId)

	return
end

function var_0_0.FlushRestPage(arg_28_0)
	arg_28_0:FlushRestTip()
	arg_28_0.pages[var_0_0.PAGE_REST]:ExecuteAction("Flush")

	return
end

function var_0_0.OnHide(arg_29_0)
	arg_29_0:UnBlurPanel()

	if arg_29_0.awardDisplayPanel then
		arg_29_0.awardDisplayPanel:Hide()
	end

	return
end

function var_0_0.OnDisable(arg_30_0)
	arg_30_0:OnHide()

	return
end

function var_0_0.OnDestroy(arg_31_0)
	arg_31_0:UnBlurPanel()

	for iter_31_0, iter_31_1 in pairs(arg_31_0.pages) do
		if iter_31_1 then
			iter_31_1:Destroy()

			iter_31_1 = nil
		end
	end

	if arg_31_0.awardDisplayPanel then
		arg_31_0.awardDisplayPanel:Destroy()

		arg_31_0.awardDisplayPanel = nil
	end

	return
end

return var_0_0
