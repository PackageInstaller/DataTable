-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mainui/view/MainUIView.lua

module("logic.extensions.mainui.view.MainUIView", package.seeall)

local M = class("MainUIView", ViewComponent)
local Input = Astral.ToLuaFramework.AsInputSystem.InputSystemToLua

function M:ctor()
	M.super.ctor(self)
end

function M:buildUI()
	IconLoader.bindSpriteAtlas(IconType.DynSpriteAtlas_MainView)

	self._canvasGroup = goutil.addComponentOnce(self.mainGO, ComponentType.CanvasGroup)
	self._guiAnimation = goutil.addComponentOnce(self.mainGO, typeof(Astral.GUITimelineAniLua))
	self._btnNewbieTask = self:getBtn("main_view_1493412868")
	self._btnQuery = self:getBtn("main_view_-1678395183")
	self._btnSpecialTraining = self:getBtn("main_view_2142196973")
	self._btnFirstCharge = self:getBtn("main_view_-33678510")
	self._btnSetting = self:getBtn("main_view_-664856437")
	self._btnChat = self:getBtn("main_view_-562107225")
	self._btnFriend = self:getBtn("main_view_-526096747")
	self._btnMail = self:getBtn("main_view_-1421616139")
	self._btnMonthSign = self:getBtn("main_view_-1069046096")

	local goHouseRoot = self:getGo("main_view_-118963500")

	self._btnHouse = self:getBtn("main_view_1289131066")
	self._goHouseBackLog = goutil.findChild(goHouseRoot, "normal/btnAgenda")
	self._goHouseHarvest = goutil.findChild(goHouseRoot, "normal/btnHarvest")
	self._btnRole = self:getBtn("main_view_-1248594333")
	self._goRedPointRole = goutil.findChild(self._btnRole.gameObject, "normal/Text1/red_point").gameObject
	self._btnBackpack = self:getBtn("main_view_-2139300647")
	self._goRedPointBackpack = goutil.findChild(self._btnBackpack.gameObject, "normal/Text1/red_point").gameObject
	self._goBackpackExpiredTime = self:getGo("main_view_-2106193041")
	self._txtBackpackExpiredTime = self:getText("main_view_656730419")
	self._btnRecruit = self:getBtn("main_view_-1137203673")
	self._btnStore = self:getBtn("main_view_2109388326")
	self._btnSurvey = self:getBtn("main_view_2107527400")
	self._btnSureyCopy = UIComponentType.ButtonAdapter(goutil.findChild(self._btnSurvey.gameObject, "else_click"))
	self._txtMainDungeonChapter = self:getText("main_view_-1992722154")
	self._animationRightDown = goutil.findChildComponent(self.mainGO, "content_node/rightDown", ComponentType.Animation)
	self._goFullEnergyPar = goutil.findChild(self.mainGO, "content_node/rightDown/energy/txtNum2/par")
	self._txtCurEnergy = self:getText("main_view_-1101787573")
	self._txtMaxEnergy = self:getText("main_view_-889931011")
	self._btnAddEnergy = self:getBtn("main_view_-1120640840")

	TextUtils.SetColor(self._txtMaxEnergy, MoneyUtil.MaxEnergyColor)
	self:_regLockStats(GameEnum.SystemEnum.Activity, self._btnSurvey.gameObject, goutil.findChild(self._btnSurvey.gameObject, "normal"), goutil.findChild(self._btnSurvey.gameObject, "lock"))
	self:_regLockStats(GameEnum.SystemEnum.House, goHouseRoot, goutil.findChild(goHouseRoot, "normal"), goutil.findChild(goHouseRoot, "lock"))
	self:_regLockStats(GameEnum.SystemEnum.RoleDepotUI, self._btnRole.gameObject, goutil.findChild(self._btnRole.gameObject, "normal"), goutil.findChild(self._btnRole.gameObject, "lock"))
	self:_regLockStats(GameEnum.SystemEnum.BackPack, self._btnBackpack.gameObject, goutil.findChild(self._btnBackpack.gameObject, "normal"), goutil.findChild(self._btnBackpack.gameObject, "lock"))
	self:_regLockStats(GameEnum.SystemEnum.Lottery, self._btnRecruit.gameObject, goutil.findChild(self._btnRecruit.gameObject, "normal"), goutil.findChild(self._btnRecruit.gameObject, "lock"))
	self:_regLockStats(GameEnum.SystemEnum.Store, self._btnStore.gameObject, goutil.findChild(self._btnStore.gameObject, "normal"), goutil.findChild(self._btnStore.gameObject, "lock"))
	self:_regLockStats(GameEnum.SystemEnum.NewbieTask, self._btnNewbieTask.gameObject, goutil.findChild(self._btnNewbieTask.gameObject, "normal"), goutil.findChild(self._btnNewbieTask.gameObject, "lock"))
	self:_regLockStats(GameEnum.SystemEnum.Setting, self._btnSetting.gameObject, goutil.findChild(self._btnSetting.gameObject, "normal"), goutil.findChild(self._btnSetting.gameObject, "lock"))
	self:_regLockStats(GameEnum.SystemEnum.MonthSignIn, self._btnMonthSign.gameObject, goutil.findChild(self._btnMonthSign.gameObject, "normal"), goutil.findChild(self._btnMonthSign.gameObject, "lock"))
	self:_regLockStats(GameEnum.SystemEnum.Chat, self._btnChat.gameObject, goutil.findChild(self._btnChat.gameObject, "normal"), goutil.findChild(self._btnChat.gameObject, "lock"))
	self:_regLockStats(GameEnum.SystemEnum.Friend, self._btnFriend.gameObject, goutil.findChild(self._btnFriend.gameObject, "normal"), goutil.findChild(self._btnFriend.gameObject, "lock"))
	self:_regLockStats(GameEnum.SystemEnum.Mail, self._btnMail.gameObject, goutil.findChild(self._btnMail.gameObject, "normal"), goutil.findChild(self._btnMail.gameObject, "lock"))
	RedDotModel.instance:createDotView({
		dotNode = goutil.findChild(self._btnNewbieTask.gameObject, "red_point").gameObject,
		keyList = {
			GameEnum.RedPointEnum.Newbie
		}
	})
	RedDotModel.instance:createDotView({
		dotNode = goutil.findChild(self:getGo("main_view_-1826764432").gameObject, "red_point"),
		keyList = {
			GameEnum.RedPointEnum.Achievement
		}
	})
	RedDotModel.instance:createDotView({
		dotNode = goutil.findChild(self._btnMail.gameObject, "red_point").gameObject,
		keyList = {
			GameEnum.RedPointEnum.Mail
		}
	})
	RedDotModel.instance:createDotView({
		dotNode = goutil.findChild(self._btnSpecialTraining.gameObject, "red_point").gameObject,
		keyList = {
			GameEnum.RedPointEnum.GrowthPlan
		}
	})
	RedDotModel.instance:createDotView({
		dotNode = goutil.findChild(self._btnFirstCharge.gameObject, "red_point"),
		keyList = {
			GameEnum.RedPointEnum.RechargeFirst,
			RedDotType.ERedDotKey.FIRST_RECHARGE
		}
	})
	RedDotModel.instance:createDotView({
		dotNode = goutil.findChild(self._btnStore.gameObject, "normal/Text1/red_point").gameObject,
		keyList = {
			GameEnum.RedPointEnum.RechargeAccumulate,
			GameEnum.RedPointEnum.MallFreeGiftBag,
			GameEnum.RedPointEnum.RechargeFirst
		}
	})
	RedDotModel.instance:createDotView({
		dotNode = goutil.findChild(self._btnMonthSign.gameObject, "red_point").gameObject,
		keyList = {
			GameEnum.RedPointEnum.MonthSignIn
		}
	})
end

function M:destroyUI()
	IconLoader.unbindSpriteAtlas(IconType.DynSpriteAtlas_MainView)

	self._lockStatsGroup = nil
end

function M:bindEvents()
	self._btnRole:AddClickListener(self._onClickRole, self)
	self._btnHouse:AddClickListener(self._onClickHouse, self)
	self._btnBackpack:AddClickListener(self._onClickBackpack, self)
	self._btnSetting:AddClickListener(self._onSettingView, self)
	self._btnMonthSign:AddClickListener(self._onClickMonthSign, self)
	self._btnChat:AddClickListener(self._clickChat, self)
	self._btnFriend:AddClickListener(self._onClickFriend, self)
	self._btnMail:AddClickListener(self._openMail, self)
	self._btnSurvey:AddClickListener(self._onClickSurvey, self)
	self._btnSureyCopy:AddClickListener(self._onClickSurvey, self)
	self._btnStore:AddClickListener(self._onClickStore, self)
	self._btnRecruit:AddClickListener(self._onClickRecruitBtn, self)
	self._btnNewbieTask:AddClickListener(self._onClickNewbieTask, self)
	self._btnAddEnergy:AddClickListener(self._onClickAddEnergy, self)
	self._btnQuery:AddClickListener(self._onClickQuery, self)
	self._btnSpecialTraining:AddClickListener(self._onClickSpecialTraining, self)
	self._btnFirstCharge:AddClickListener(self._onClickFirstCharge, self)
	GlobalDispatcher:addEventListener(EventType.APPLICATION_QUIT, self._onHandleOnApplication, self)
	self:registerLocalNotify(EventType.FW_VIEW_ANIMATION_DONE_EVENT, self._handleViewAniDoneEvent, self)
end

function M:unbindEvents()
	self._btnRole:RemoveClickListener()
	self._btnHouse:RemoveClickListener()
	self._btnBackpack:RemoveClickListener()
	self._btnSetting:RemoveClickListener()
	self._btnMonthSign:RemoveClickListener()
	self._btnChat:RemoveClickListener()
	self._btnFriend:RemoveClickListener()
	self._btnMail:RemoveClickListener()
	self._btnSurvey:RemoveClickListener()
	self._btnSureyCopy:RemoveClickListener()
	self._btnStore:RemoveClickListener()
	self._btnRecruit:RemoveClickListener()
	self._btnNewbieTask:RemoveClickListener()
	self._btnAddEnergy:RemoveClickListener()
	self._btnQuery:RemoveClickListener()
	self._btnSpecialTraining:RemoveClickListener()
	self._btnFirstCharge:RemoveClickListener()
	self:unregisterLocalNotify(EventType.FW_VIEW_ANIMATION_DONE_EVENT, self._handleViewAniDoneEvent, self)
end

function M:onEnter(openReasonType)
	self._isEnter = true

	AirtightRoomController.instance:setPreviewState(nil)
	self:_blockCanvasClick(false)
	ViewBlockMgr.instance:blockClick(true, ViewBlockKey.MainUI)
	goutil.setActive(self._btnQuery.gameObject, false)
	self:_handleOnSystemOpen()
	self:_playAnimation(true, openReasonType)
	self:_updateEnergy()
	self:_updateMainDungeonProgress()
	self:_refreshDungeonBtn()
	self:_setEvent(true)
	self:_refreshRedDot()

	if self._viewPresentor:getIsBackOpen() then
		local displayHero, displayHeroSkin = MainScenePerformUtil.getDisplayAdjutantHeroId()
		local forceSet = false
		local prefix = MainPerformEnum.AnimPrefix.Shafa
		local mixDuration
		local isChange = false

		MainScenePerformUtil.changeHeroReq(MainPerformEnum.ElementPointAdjutant, displayHero, displayHeroSkin, forceSet, prefix, mixDuration, isChange)
		MainScenePerformUtil.setBgHeroShow(true, true)
		MainScenePerformUtil.setElementShow(MainPerformEnum.ElementIdAirtightClock, true)
		MainScenePerformUtil.setElementShow(MainPerformEnum.ElementIdTelevision, true)
	end

	GlobalDispatcher:dispatchEvent(EventType.MAIN_SCENE_CLOCK_CHANGE_MODE, true)
	self:_refreshHouseHint()
	self:_handleSurveyBtnShow(nil, SurveyHtmlUtil.getSurveyDataOrigin())

	if not SpecialtrainingModel.instance:getReqDone() then
		SpecialtrainingAgent.instance:sendGrowthPlanRequest()
	end
end

function M:onEnterFinished()
	local hasPopUpData = MainPopController.instance:hasPopUpData()
	local isGuiding = GuideController.instance:isGuiding()

	SurveyHtmlUtil.requestSurveyData()

	if not ViewMgr.instance:isOpen(ViewName.ScenePicker) then
		ScenePickerViewFacade.instance:open()
	end

	GlobalDispatcher:dispatchEvent(EventType.SHOW_MAIN_VIEW_FINISH, true)

	if hasPopUpData or isGuiding then
		settimer(0.33, self._releaseBlockClick, self, false)
	else
		self:_releaseBlockClick()
	end
end

function M:onExit(closeReasonType)
	self._isEnter = false

	GlobalDispatcher:dispatchEvent(EventType.SHOW_MAIN_VIEW_FINISH, false)
	removetimer(self._releaseBlockClick, self)
	removetimer(self._releaseBlockCanvasClick, self)
	ViewBlockMgr.instance:blockClick(false, ViewBlockKey.MainUI)
	self:_blockCanvasClick(true)
	self:_playAnimation(false, closeReasonType)
	CriwareAudioFacade.instance:stopSoundById(CriwareAudioEnum.amb_changjing_haitan)
	SpaceX.RendererFeatureUtils.ToggleRendererFeature(false, RendererFeatureName.GLITCH)
	VolumeMgr.instance:turnOffUIPostProcessing(VolumeName.LoadMainView)
	self:_setEvent(false)
	removetimer(self._showAirtightTimePanel, self)

	self._isClickBtnQuery = false
end

function M:_setEvent(add)
	if add then
		GlobalDispatcher:addEventListener(EventType.ON_SYSTEM_OPEN, self._handleOnSystemOpen, self)
		GlobalDispatcher:addEventListener(EventType.NEWBIE_ALL_FINISH, self._handleNewbieAllFinish, self)
		GlobalDispatcher:addEventListener(EventType.ITEM_MODEL_CHANGED_ANY, self._handleItemModelChangedAny, self)
		GlobalDispatcher:addEventListener(EventType.ACTIVITY_ALL_REFRESH, self._handleOnSystemOpen, self)
		GlobalDispatcher:addEventListener(EventType.SIGN_IN_INFO_CHANGE, self._handleOnSystemOpen, self)
		GlobalDispatcher:addEventListener(EventType.ON_ARITIGHT_STATE_CHANGE, self._handleAritightStateChange, self)
		GlobalDispatcher:addEventListener(EventType.RED_DOT_UPDATE_EVENT, self._refreshRedDot, self)
		GlobalDispatcher:addEventListener(EventType.GET_SURVEY_LIST_EVENT, self._handleSurveyBtnShow, self)
		GlobalDispatcher:addEventListener(EventType.HOUSE_BACKLOG_NUM_CHANGE, self._handleHouseBackLogNumChange, self)
		GlobalDispatcher:addEventListener(EventType.HOUSE_HARVEST_REPORT_NUM_CHANGE, self._handleHouseHarvestReportNumChange, self)
		GlobalDispatcher:addEventListener(EventType.SPECIAL_TRAINING_UPDATESTAGE, self._refreshSpecialtrainBtn, self)
		GlobalDispatcher:addEventListener(EventType.FW_VIEW_CLOSING_EVENT, self._handleViewClose, self)
		GlobalDispatcher:addEventListener(EventType.STORE_FIRST_CHARGE, self._updateFirstBtn, self)
		GlobalDispatcher:addEventListener(EventType.STORE_RECHARGE_DATA_UPDATE, self._updateFirstBtn, self)
	else
		GlobalDispatcher:removeEventListener(EventType.ON_SYSTEM_OPEN, self._handleOnSystemOpen, self)
		GlobalDispatcher:removeEventListener(EventType.NEWBIE_ALL_FINISH, self._handleNewbieAllFinish, self)
		GlobalDispatcher:removeEventListener(EventType.ITEM_MODEL_CHANGED_ANY, self._handleItemModelChangedAny, self)
		GlobalDispatcher:removeEventListener(EventType.ACTIVITY_ALL_REFRESH, self._handleOnSystemOpen, self)
		GlobalDispatcher:removeEventListener(EventType.SIGN_IN_INFO_CHANGE, self._handleOnSystemOpen, self)
		GlobalDispatcher:removeEventListener(EventType.ON_ARITIGHT_STATE_CHANGE, self._handleAritightStateChange, self)
		GlobalDispatcher:removeEventListener(EventType.RED_DOT_UPDATE_EVENT, self._refreshRedDot, self)
		GlobalDispatcher:removeEventListener(EventType.GET_SURVEY_LIST_EVENT, self._handleSurveyBtnShow, self)
		GlobalDispatcher:removeEventListener(EventType.HOUSE_BACKLOG_NUM_CHANGE, self._handleHouseBackLogNumChange, self)
		GlobalDispatcher:removeEventListener(EventType.HOUSE_HARVEST_REPORT_NUM_CHANGE, self._handleHouseHarvestReportNumChange, self)
		GlobalDispatcher:removeEventListener(EventType.SPECIAL_TRAINING_UPDATESTAGE, self._refreshSpecialtrainBtn, self)
		GlobalDispatcher:removeEventListener(EventType.FW_VIEW_CLOSING_EVENT, self._handleViewClose, self)
		GlobalDispatcher:removeEventListener(EventType.STORE_FIRST_CHARGE, self._updateFirstBtn, self)
		GlobalDispatcher:removeEventListener(EventType.STORE_RECHARGE_DATA_UPDATE, self._updateFirstBtn, self)
	end
end

function M:_onHandleOnApplication()
	SpaceX.RendererFeatureUtils.ToggleRendererFeature(false, RendererFeatureName.GLITCH)
	GlobalDispatcher:removeEventListener(EventType.APPLICATION_QUIT, self._onHandleOnApplication, self)
end

function M:_handleViewClose(e, viewName, opTyp)
	removetimer(self._releaseBlockCanvasClick, self)

	if MainPopController.instance:hasPopUpData() then
		self:_blockCanvasClick(true)
		settimer(0.2, self._releaseBlockCanvasClick, self, false)
	elseif self._isEnter then
		self:_blockCanvasClick(false)
	end
end

function M:_handleOnSystemOpen()
	for key, objs in pairs(self._lockStatsGroup or {}) do
		local showOnLock = SystemOpenFacade.instance:isShowOnLock(key)
		local isOpen = SystemOpenFacade.instance:isOpen(key)

		if key == GameEnum.SystemEnum.House then
			showOnLock = false
			isOpen = false
		end

		goutil.setActive(objs.root, isOpen or showOnLock and not isOpen)

		if objs.audioTrigger then
			objs.audioTrigger:SetUnlockState(isOpen)
		end

		if objs.lock then
			goutil.setActive(objs.lock, not isOpen)
		end

		if objs.normal then
			goutil.setActive(objs.normal, isOpen)
		end
	end

	goutil.setActive(self._btnNewbieTask.gameObject, NewbieTaskModel.instance:isNewbieTaskActive(false))
	self:_refreshSpecialtrainBtn()
	self:_updateFirstBtn()
end

function M:_refreshRedDot()
	local isActive = RedDotModel.instance:getDotIsActive(GameEnum.RedPointEnum.Newbie)
	local redDotGO = goutil.findChild(self._btnNewbieTask.gameObject, "red_point").gameObject

	goutil.setActive(redDotGO, isActive)

	local hasHeroCanBreakLvUp = CharacterUtil.isHeroCanBrealLvUp()

	goutil.setActive(self._goRedPointRole, hasHeroCanBreakLvUp)

	local hasItemGift = MainBackpackModel.instance:isPropGiftRed()

	goutil.setActive(self._goRedPointBackpack, hasItemGift)

	local energyDrugExpiredStr = self:getEnergyDrugExpired()
	local showExpiredTxt = not string.nilorempty(energyDrugExpiredStr)

	if showExpiredTxt then
		self._txtBackpackExpiredTime.text = energyDrugExpiredStr
	end

	goutil.setActive(self._goBackpackExpiredTime, showExpiredTxt)
end

function M:_handleViewAniDoneEvent(key, tagName, reason)
	return
end

function M:_handleNewbieAllFinish(e)
	goutil.setActive(self._btnNewbieTask.gameObject, false)
end

function M:_handleItemModelChangedAny()
	self:_updateEnergy()
	self:_refreshRedDot()
end

function M:_playAnimation(open, reasonType)
	printWarn(string.format("mainui open[%s] reason[%s] backOpen[%s]", open, reasonType, self._viewPresentor:getIsBackOpen()), debug.traceback())
	self._guiAnimation:StopTimelineAni()

	if open then
		if not self._viewPresentor:getIsBackOpen() then
			self:_dealGuiBinding(true)
			self._guiAnimation:PlayAniByName("open")
		end

		settimer(0.5, self._showAirtightTimePanel, self, false)
	elseif reasonType ~= WindowType.WindowCloseReasonType.QuickCloseType then
		self:_dealGuiBinding(false)
		self._guiAnimation:PlayAniByName("close")
	end
end

function M:_dealGuiBinding(bind)
	if bind then
		if MainUIModel.instance:getLoginMark() then
			local displayHero, displaySkin = MainScenePerformUtil.getDisplayAdjutantHeroId()

			if displayHero and displayHero > 0 then
				CriwareAudioFacade.instance:playVoiceByName(string.format("speech_%s_meiri", displayHero))
			end

			local scene = SceneMgr.instance:getCurScene()

			if scene and scene:getSceneType() == SceneType.Room then
				local camGo = scene.camera:getCamGo()

				if camGo then
					local camAnimator = goutil.addComponentOnce(camGo, ComponentType.Animator)
					local bindingName = "Cam_Sit"

					self._guiAnimation:AddTrackBinding(bindingName, camAnimator, true, false)
				end
			end

			MainUIModel.instance:setLoginMark(false)
		end
	else
		self._guiAnimation:AddTrackBinding("Cam_Sit", nil, true, false)
	end
end

function M:_showAirtightTimePanel()
	self:localNotify(EventType.SHOW_LOCAL_ARITIGHT_PANEL, true)
end

function M:_updateEnergy()
	local curEnergy = ItemModel.instance:getItemCountByItemId(CommEnum.CurrencyCodeEnum.TlCode)
	local maxEnergy = PlayerModel.instance:getEnergyLimit()
	local isMaxEnergy = maxEnergy <= curEnergy

	self._txtCurEnergy.text = curEnergy

	TextUtils.SetColor(self._txtCurEnergy, isMaxEnergy and MoneyUtil.CurEnergyReachMaxColor or MoneyUtil.CurEnergyNormalColor)

	self._txtMaxEnergy.text = string.format("/%d", maxEnergy)

	local progress = curEnergy / maxEnergy

	progress = progress > 1 and 1 or progress

	self._animationRightDown:Stop()

	if isMaxEnergy then
		self._animationRightDown:Play("rightdown_anim")
	else
		AnimationUtils.ResetAnimation(self._animationRightDown)
		goutil.setActive(self._goFullEnergyPar, false)
	end
end

function M:_updateMainDungeonProgress()
	local latestChapterMo = DungeonMainLineChapterModel.instance:getLatestUnlockChapterMo(DungeonEnum.Difficulty.Easy)

	if not latestChapterMo then
		-- block empty
	end

	local dungeonIds = latestChapterMo:getNormalDungeonIds()
	local maxProgress = #dungeonIds
	local curProgress = latestChapterMo:getLastUnlockDungeonIndex()
	local dungeonId = dungeonIds[curProgress]
	local dungeonMo = DungeonMainLineChapterModel.instance:getDungeonMoById(dungeonId)

	self._txtMainDungeonChapter.text = dungeonMo and dungeonMo:getIndex() or nil
end

function M:_refreshDungeonBtn()
	local inTime = AirtightRoomController.instance:getIsInAirtightTime(nil, nil, nil, false)

	goutil.setActive(normalBanner, not inTime)
	goutil.setActive(aritightBanner, inTime)
end

function M:_surveyUpdate()
	local isShow = false

	self._actId = SurveyModel.instance:getCacheSurveyId()

	local activityData = ActivityModel.instance:getActivityById(self._actId)

	if activityData and activityData:getIsOpen() then
		local showOnLock = SystemOpenFacade.instance:isShowOnLock(GameEnum.SystemEnum.Survey)
		local isOpen = SystemOpenFacade.instance:isOpen(GameEnum.SystemEnum.Survey)

		self._surveyId = activityData:getConfigId()
		isShow = isOpen or showOnLock and not isOpen
	else
		isShow = false
	end

	return isShow
end

function M:_onClickAddEnergy()
	ToolTipsMgr.showHealthExchangeTips(self._topCurrencyGo)
end

function M:_onClickQuery()
	self._isClickBtnQuery = true

	SurveyHtmlUtil.requestSurveyData()
end

function M:_onClickSpecialTraining()
	local planId = SpecialtrainingModel.instance:getPlanId()

	if planId > 0 then
		ViewMgr.instance:open(ViewName.SpecialTraining)
	else
		ViewMgr.instance:open(ViewName.SpecialTrainingBanner)
	end
end

function M:_onClickFirstCharge()
	ViewMgr.instance:open(ViewName.FirstChargeView)
end

function M:_updateFirstBtn()
	local isOpen = SystemOpenFacade.instance:isOpen(GameEnum.SystemEnum.FirstRecharge)
	local curCredit = StoreRechargeModel.instance:getCurCredit()

	if curCredit < 0 and isOpen then
		StoreRechargeAgent.instance:sendGetRechargeInfoRequest()
	end

	local isShow = StoreRechargeModel.instance:isShowFirstCharge()

	goutil.setActive(self._btnFirstCharge.gameObject, isShow)

	if isShow then
		local isActive = StoreRechargeModel.instance:isShowFirstChargeRedPoint()

		GlobalDispatcher:dispatchEvent(EventType.RED_DOT_UPDATE_EVENT, {
			key = RedDotType.ERedDotKey.FIRST_RECHARGE,
			isActive = isActive
		})
	end
end

function M:_onClickStore()
	if not SystemOpenFacade.instance:isOpen(GameEnum.SystemEnum.Store, true) then
		return
	end

	StoreAgent.instance:sendGetMallListRequest(true)
end

function M:_onClickNewbieTask()
	if not NewbieTaskModel.instance:isNewbieTaskActive(true) then
		return
	end

	ViewMgr.instance:open(ViewName.NewbieTaskView)
end

function M:_openTeamMainView()
	ViewMgr.instance:open(ViewName.TeamMainViewViewPresentor)
end

function M:_onClickAlphaStar()
	self:close()
	ViewMgr.instance:open(ViewName.PlotTestDialogViewPresentor)
end

function M:_onClickRole()
	SDKManager.loganLogUnity("测试上报Unity日志" .. os.date())

	if not SystemOpenFacade.instance:isOpen(GameEnum.SystemEnum.RoleDepotUI, true) then
		return
	end

	CharacterSystemFacade.instance:showCharacterDepotView(true)
end

function M:_onClickHouse()
	if not SystemOpenFacade.instance:isOpen(GameEnum.SystemEnum.House, true) then
		return
	end

	MainUIModel.instance:setClickedHouseBtn(true)
	SceneFace.instance:enterHouseScene()
end

function M:_onClickBackpack()
	if not SystemOpenFacade.instance:isOpen(GameEnum.SystemEnum.BackPack, true) then
		return
	end

	ViewMgr.instance:open(ViewName.BackpackView)
end

function M:_onClickSurvey()
	if not SystemOpenFacade.instance:isOpen(GameEnum.SystemEnum.Activity, true) then
		return
	end

	ViewMgr.instance:open(ViewName.GameplayEntranceView)
end

function M:_openMail()
	if not SystemOpenFacade.instance:isOpen(GameEnum.SystemEnum.Mail, true) then
		return
	end

	ViewMgr.instance:open(ViewName.MailView)
end

function M:_onClickFriend()
	if not SystemOpenFacade.instance:isOpen(GameEnum.SystemEnum.Friend, true) then
		return
	end

	ViewMgr.instance:open(ViewName.FriendMain)
end

function M:_openNotice()
	NewNoticeController.instance:openNoticeView()
end

function M:_clickChat()
	if not SystemOpenFacade.instance:isOpen(GameEnum.SystemEnum.Chat, true) then
		return
	end

	ViewMgr.instance:open(ViewName.ChatMain, nil, true)
end

function M:_onSettingView()
	if not SystemOpenFacade.instance:isOpen(GameEnum.SystemEnum.Setting, true) then
		return
	end

	ViewMgr.instance:open(ViewName.MainSettingViewPresentor)
end

function M:_onClickMonthSign()
	if not SystemOpenFacade.instance:isOpen(GameEnum.SystemEnum.MonthSignIn, true) then
		return
	end

	ViewMgr.instance:open(ViewName.MonthSigninView)
end

function M:_onClickRecruitBtn()
	if not SystemOpenFacade.instance:isOpen(GameEnum.SystemEnum.Lottery, true) then
		return
	end

	RetrieveController.instance:enterScene()
end

function M:_regLockStats(key, root, objNormal, objLock)
	if not self._lockStatsGroup then
		self._lockStatsGroup = {}
	end

	local data = {}

	data.root = root.gameObject
	data.normal = objNormal and objNormal.gameObject or nil
	data.lock = objLock and objLock.gameObject or nil
	data.audioTrigger = root.gameObject:GetComponent(typeof(AudioClickTrigger))
	self._lockStatsGroup[key] = data
end

function M:_releaseBlockClick()
	ViewBlockMgr.instance:blockClick(false, ViewBlockKey.MainUI)
end

function M:_blockCanvasClick(block)
	self._canvasGroup.interactable = not block
end

function M:_releaseBlockCanvasClick()
	self:_blockCanvasClick(false)
end

function M:_handleAritightStateChange()
	self:_refreshDungeonBtn()
end

function M:_handleSurveyBtnShow(e, data)
	return
end

function M:_refreshHouseHint()
	if not MainUIModel.instance:getClickedHouseBtn() then
		HouseMainController.instance:initBackLogAndHarvestNum()
	end

	self:_refreshHouseBackLogHint()
	self:_refreshHouseHarvestHint()
end

function M:_refreshHouseBackLogHint()
	local backLogNum = HouseMainRoomModel.instance:getBackLogNum()

	if HouseModel.instance:getClickedBackLog() then
		local tradeFullNum = HouseMainRoomModel.instance:getBackLogTypNum(HouseMainEnum.BackLogTyp.tradeOrderFull)

		backLogNum = backLogNum - tradeFullNum
	end

	goutil.setActive(self._goHouseBackLog, backLogNum > 0)
end

function M:_refreshHouseHarvestHint()
	local harvestNum = HouseMainRoomModel.instance:getCanGainReportNum()

	goutil.setActive(self._goHouseHarvest, harvestNum > 0)
end

function M:_handleHouseBackLogNumChange()
	self:_refreshHouseBackLogHint()
end

function M:_handleHouseHarvestReportNumChange()
	self:_refreshHouseHarvestHint()
end

function M:_refreshSpecialtrainBtn()
	local isOpen = SystemOpenFacade.instance:isOpen(GameEnum.SystemEnum.Lottery)
	local isOpenNewLottery = SystemOpenFacade.instance:isOpen(GameEnum.SystemEnum.NewbieLottery)
	local planId = SpecialtrainingModel.instance:getPlanId()
	local state1Go = goutil.findChild(self._btnSpecialTraining.gameObject, "state1")
	local state2Go = goutil.findChild(self._btnSpecialTraining.gameObject, "state2")
	local heroIcon = goutil.findChildImageComponent(state1Go.gameObject, "icon")

	if planId > 0 then
		local iconName = SpecialtrainingConfig.instance:getTrainPlanCfg(planId).icon

		IconLoader.setSprite(heroIcon, IconType.DynSpriteAtlas_MainView, iconName)
	end

	goutil.setActive(state1Go, planId > 0)
	goutil.setActive(state2Go, planId == 0 and isOpenNewLottery)
	goutil.setActive(self._btnSpecialTraining.gameObject, isOpen and SpecialtrainingModel.instance:isShowInMainUI() and (state1Go.activeSelf or state2Go.activeSelf))
end

function M:getEnergyDrugExpired()
	local curTime = ServerTime.now() * 1000
	local uuid, expiredTime
	local _drugInBackPack = ItemModel.instance:getItemsByTS(GameEnum.ItemTypeEnum.PropItemType, GameEnum.PropSubTypeEnum.PowerProp)

	if _drugInBackPack and #_drugInBackPack > 0 then
		for k, v in pairs(_drugInBackPack) do
			if v:getCount() > 0 then
				local itemExpireTime = tonumber(v:getExpireTime())

				if itemExpireTime > 0 or curTime < itemExpireTime then
					local overwrite = expiredTime == nil or expiredTime and itemExpireTime < expiredTime

					if overwrite then
						expiredTime = itemExpireTime
						uuid = v:getUuid()
					end
				end
			end
		end
	end

	local str

	if expiredTime then
		local offset = expiredTime - curTime

		str = TextFormatter.format(FormatterEnum.EXPIRE_TIME, offset / 1000)
	end

	return str
end

return M
