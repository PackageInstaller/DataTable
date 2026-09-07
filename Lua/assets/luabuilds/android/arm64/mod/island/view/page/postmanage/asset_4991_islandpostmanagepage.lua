local IslandPostManagePage = class("IslandPostManagePage", import("...base.IslandBasePage"))

IslandPostManagePage.PAGE_PROD = "prod"
IslandPostManagePage.PAGE_REST = "rest"
IslandPostManagePage.PAGE_COLLECTION = "collection"
IslandPostManagePage.EVENT_SHOW_SP_EVENT_TIP = "IslandPostManagePage:EVENT_SHOW_SP_EVENT_TIP"

function IslandPostManagePage:getUIName()
	return "IslandPostManageUI"
end

function IslandPostManagePage:OnLoaded()
	setText(self._tf:Find("top/title/Text"), i18n("island_post_manage"))

	local var_2_0 = self._tf:Find("Adapt/pages")

	self.pages = {}
	self.pages[IslandPostManagePage.PAGE_PROD] = IslandPostProdPanel.New(var_2_0, self.event, setmetatable({
		ShowMsgBox = function(arg_3_0, arg_3_1)
			self:ShowMsgBox(arg_3_1)

			return
		end
	}, {
		__index = self.contextData
	}))
	self.pages[IslandPostManagePage.PAGE_REST] = IslandPostRestPanel.New(var_2_0, self.event)
	self.pages[IslandPostManagePage.PAGE_COLLECTION] = IslandCollectionPanel.New(var_2_0, self.event, setmetatable({
		ShowMsgBox = function(arg_4_0, arg_4_1)
			self:ShowMsgBox(arg_4_1)

			return
		end
	}, {
		__index = self.contextData
	}))
	self.togglesTF = self._tf:Find("Adapt/types/content")

	setText(self.togglesTF:Find("prod/unsel"), i18n("island_post_produce"))
	setText(self.togglesTF:Find("prod/sel/content/Text"), i18n("island_post_produce"))
	setText(self.togglesTF:Find("rest/unsel"), i18n("island_post_operate"))
	setText(self.togglesTF:Find("rest/sel/content/Text"), i18n("island_post_operate"))
	setText(self.togglesTF:Find("collection/unsel"), i18n("island_chara_gather_tip"))
	setText(self.togglesTF:Find("collection/sel/content/Text"), i18n("island_chara_gather_tip"))

	self.signInNoticeTF = self._tf:Find("Adapt/signInBtn/notice")
	self.bookBtn = self._tf:Find("Adapt/book_btn")
	self.awardDisplayPanel = IslandAwardDisplayInMainPanel.New(self._tf, self.event)

	setText(self.bookBtn:Find("Text"), i18n("island_post_btn_set_meal"))
	setText(self._tf:Find("Adapt/signInBtn/Text"), i18n("island_post_btn_sign"))

	return
end

function IslandPostManagePage:OnInit()
	self:bind(IslandPostManagePage.EVENT_SHOW_SP_EVENT_TIP, function(arg_6_0, arg_6_1, arg_6_2)
		setParent(self._tf, pg.UIMgr.GetInstance().UIMain)
		self:ShowMsgBox({
			type = IslandMsgBox.TYPE_ISLAND_POST_EVENT,
			rest = arg_6_1,
			isNew = arg_6_2,
			onHide = function()
				setParent(self._tf, pg.UIMgr.GetInstance().OverlayMain)

				return
			end,
			onYes = function()
				self.pages[IslandPostManagePage.PAGE_REST]:TriggerEvent(arg_6_1.id)

				return
			end
		})

		return
	end)
	onButton(self, self.bookBtn, function()
		self:OpenPage(IslandSetMealHandbookPage)

		return
	end, SFX_PANEL)
	onButton(self, self._tf:Find("top/title/help"), function()
		self:ShowMsgBox({
			type = IslandMsgBox.TYPE_WHITOUT_BTN,
			content = i18n("island_helpbtn_commission")
		})

		return
	end, SFX_PANEL)
	onButton(self, self._tf:Find("top/back"), function()
		self:Hide()

		return
	end, SFX_PANEL)
	onButton(self, self._tf:Find("top/home"), function()
		self:emit(BaseUI.ON_HOME)

		return
	end, SFX_PANEL)
	onButton(self, self._tf:Find("Adapt/signInBtn"), function()
		self:Hide()
		self:emit(IslandBaseMediator.SWITCH_MAP, IslandConst.AGORA_MAP_ID, IslandConst.SIGNIN_SP)

		return
	end, SFX_PANEL)
	eachChild(self.togglesTF, function(arg_14_0)
		onToggle(self, arg_14_0, function(arg_15_0)
			if arg_15_0 then
				self.curPage = arg_14_0.name
				self.contextData.curPage = self.curPage

				self:SwitchPage()
			end

			return
		end, SFX_PANEL)

		return
	end)

	self.buildingIds = pg.island_set.post_manage_produce.key_value_varchar
	self.restIds = pg.island_set.post_manage_operate.key_value_varchar

	setActive(self.bookBtn, self:GetSelfIsland():GetAblityAgency():HasAbility(IslandAblityAgency.SET_MEAL_ID))

	return
end

function IslandPostManagePage:AddListeners()
	self:AddListener(GAME.ISLAND_START_DELEGATION_DONE, self.FlushProdPage)
	self:AddListener(GAME.ISLAND_FINISH_DELEGATION_DONE, self.OnFlushProdPageAndShipExpDone)
	self:AddListener(GAME.ISLAND_GET_DELEGATION_AWARD_DONE, self.OnFlushProdPageAndShipExpDone)
	self:AddListener(GAME.ISLAND_OPEN_RESTAURANT_DONE, self.FlushRestPage)
	self:AddListener(GAME.ISLAND_CLOSE_RESTAURANT_DONE, self.FlushRestPage)
	self:AddListener(IslandManageAgecny.ADD_RESTAURANT, self.FlushRestPage)
	self:AddListener(IslandManageAgecny.ADD_ASSISTANT, self.FlushRestPage)
	self:AddListener(IslandManageAgecny.ON_DAILY_REFRESH, self.FlushRestPage)
	self:AddListener(GAME.ISLAND_GET_AUTO_COLLECTION_DATA_DONE, self.OnGetCollctionData)
	self:AddListener(GAME.ISLAND_TAKE_AUTO_COLLECTION_DONE, self.OnGetCollctionDone)

	return
end

function IslandPostManagePage:RemoveListeners()
	self:RemoveListener(GAME.ISLAND_START_DELEGATION_DONE, self.FlushProdPage)
	self:RemoveListener(GAME.ISLAND_FINISH_DELEGATION_DONE, self.OnFlushProdPageAndShipExpDone)
	self:RemoveListener(GAME.ISLAND_GET_DELEGATION_AWARD_DONE, self.OnFlushProdPageAndShipExpDone)
	self:RemoveListener(GAME.ISLAND_OPEN_RESTAURANT_DONE, self.FlushRestPage)
	self:RemoveListener(GAME.ISLAND_CLOSE_RESTAURANT_DONE, self.FlushRestPage)
	self:RemoveListener(IslandManageAgecny.ADD_RESTAURANT, self.FlushRestPage)
	self:RemoveListener(IslandManageAgecny.ADD_ASSISTANT, self.FlushRestPage)
	self:RemoveListener(IslandManageAgecny.ON_DAILY_REFRESH, self.FlushRestPage)
	self:RemoveListener(GAME.ISLAND_GET_AUTO_COLLECTION_DATA_DONE, self.OnGetCollctionData)
	self:RemoveListener(GAME.ISLAND_TAKE_AUTO_COLLECTION_DONE, self.OnGetCollctionDone)

	return
end

function IslandPostManagePage:SwitchPage()
	for iter_18_0, iter_18_1 in pairs(self.pages) do
		if iter_18_0 == self.curPage then
			if self.curPage == IslandPostManagePage.PAGE_COLLECTION then
				pg.UIMgr.GetInstance():LoadingOn()
				self:emit(IslandMediator.GET_AUTO_COLLECTION_DATA, 1)
			else
				iter_18_1:ExecuteAction("Show")
			end
		else
			iter_18_1:ExecuteAction("Hide")
		end
	end

	return
end

function IslandPostManagePage:OnGetCollctionData(arg_19_1)
	self.pages[IslandPostManagePage.PAGE_COLLECTION]:ExecuteAction("Show", arg_19_1.data)
	PlayerPrefs.SetInt("IslandSignAutoCollectTime" .. tostring((getProxy(PlayerProxy):getPlayerId())), (pg.TimeMgr.GetInstance():GetServerTime()))
	self:FlushCollectionTip()
	pg.UIMgr.GetInstance():LoadingOff()

	return
end

function IslandPostManagePage:OnGetCollctionDone(arg_20_1)
	self.pages[IslandPostManagePage.PAGE_COLLECTION]:ExecuteAction("OnGetCollctionDone", arg_20_1)

	return
end

function IslandPostManagePage:OnShow()
	self:BlurPanel()
	triggerToggle(self.togglesTF:Find(self.contextData.curPage or IslandPostManagePage.PAGE_PROD), true)
	self:FlushTips()
	setActive(self.signInNoticeTF, getProxy(IslandProxy):GetIsland():GetSignInAgency():CanSignIn())

	return
end

function IslandPostManagePage:FlushTips()
	self:FlushProdTip()
	self:FlushRestTip()
	self:FlushCollectionTip()

	return
end

function IslandPostManagePage:FlushProdTip()
	local var_23_0 = IslandMainBtnTipHelper.IsPostProdTip()

	setActive(self.togglesTF:Find("prod/unsel/tip"), var_23_0)
	setActive(self.togglesTF:Find("prod/sel/tip"), var_23_0)

	return
end

function IslandPostManagePage:FlushRestTip()
	local var_24_0 = IslandMainBtnTipHelper.IsPostRestTip()

	setActive(self.togglesTF:Find("rest/unsel/tip"), var_24_0)
	setActive(self.togglesTF:Find("rest/sel/tip"), var_24_0)

	return
end

function IslandPostManagePage:FlushCollectionTip()
	local var_25_0 = IslandMainBtnTipHelper.IsPostCollectionTip()

	setActive(self.togglesTF:Find("collection/unsel/tip"), var_25_0)
	setActive(self.togglesTF:Find("collection/sel/tip"), var_25_0)

	return
end

function IslandPostManagePage:OnFlushProdPageAndShipExpDone(arg_26_1)
	if arg_26_1.addShipExpData then
		self.awardDisplayPanel:ExecuteAction("ShowAwards", {
			shipExp = true,
			icon = "island/IslandShipIcon/" .. IslandShip.StaticGetPrefab(arg_26_1.addShipExpData.addShipId),
			num = arg_26_1.addShipExpData.addExp
		})
	end

	self:FlushProdPage(arg_26_1)

	return
end

function IslandPostManagePage:FlushProdPage(arg_27_1)
	self:FlushProdTip()
	self.pages[IslandPostManagePage.PAGE_PROD]:ExecuteAction("FlushSlot", arg_27_1.slotId)

	return
end

function IslandPostManagePage:FlushRestPage()
	self:FlushRestTip()
	self.pages[IslandPostManagePage.PAGE_REST]:ExecuteAction("Flush")

	return
end

function IslandPostManagePage:OnHide()
	self:UnBlurPanel()

	if self.awardDisplayPanel then
		self.awardDisplayPanel:Hide()
	end

	return
end

function IslandPostManagePage:OnDisable()
	self:OnHide()

	return
end

function IslandPostManagePage:OnDestroy()
	self:UnBlurPanel()

	for iter_31_0, iter_31_1 in pairs(self.pages) do
		if iter_31_1 then
			iter_31_1:Destroy()

			iter_31_1 = nil
		end
	end

	if self.awardDisplayPanel then
		self.awardDisplayPanel:Destroy()

		self.awardDisplayPanel = nil
	end

	return
end

return IslandPostManagePage
