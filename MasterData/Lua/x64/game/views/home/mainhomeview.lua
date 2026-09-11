local var_0_0 = partialClass("MainHomeView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Main/HomeUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0:Init()
	self.clearTalkHandler = handler(self, self.ClearHomePosterTalk)

	self:InitUI()
	self:AddUIListeners()
end

function var_0_0:InitUI()
	self:BindCfgUI()

	self.page_ = {}
	self.clickCount_ = 0
	self.muteAudioHandler_ = handler(self, self.MuteAudio)
	self.shakingAniHandler_ = handler(self, self.ShakingAni)
	self.bannerView_ = BannerView.New(self, self.btnActivityGo_)
	self.activityEntraceView_ = ActivityEntraceView.New(self.activityListGo_)
	self.skinDrawEntraceView_ = ActivitySkinDrawEntraceView.New(self.skinDrawGo_)
	self.skinDiscountGiftEntranceView_ = SkinDiscountGiftEntranceView.New(self.skinDiscountGo_)
	self.subtitleBubble = MainHomeView_SubtitleBubble.New(self.talkBubbleGo_)
	self.socializeCon_ = self.conExCollection_:GetController("socialize")
	self.hideCon_ = self.conExCollection_:GetController("hide")
	self.sceneCon_ = self.conExCollection_:GetController("scene")
	self.skinDrawCon_ = self.conExCollection_:GetController("skinDraw")
	self.drawLockCon_ = self.conExCollection_:GetController("drawLocked")
	self.dormLockCon_ = self.conExCollection_:GetController("dormLocked")
	self.guildCon_ = self.conExCollection_:GetController("guildLocked")
	self.shopCon_ = self.conExCollection_:GetController("shopLocked")
	self.textLimit_ = self.chatTxt_.gameObject:GetComponent("TextExtension")
	self.mutiTouchHelper_ = self.btn_girl.gameObject:GetComponent("MutiTouchHelper")
	self.changedlcCon_ = self.conExCollection_:GetController("changedlcView")
	self.puremodeCon_ = self.conExCollection_:GetController("puremode")
	self.btn_zuoCon_ = self.btn_zuo01Controllerexcollection_:GetController("zuo01")
	self.btn_youCon_ = self.btn_youControllerexcollection_:GetController("you01")

	self:SwitchPosterGirlPanel(false)
	self.subtitleBubble:SetVisible(false)
	self.puremodeCon_:SetSelectedState("hide")
	self.changedlcCon_:SetSelectedState("hide")

	self.longTimeNoOpCheckCom_ = self.panelGo_:GetComponent("LongTimeNoOperation")

	LuaForUtil.SetNoOperationTime(self.panelGo_, 1000)
end

function var_0_0:AddTestBilliardGameBtn()
	local var_5_0 = GameObject.New("BilliardTestBtn", typeof(Button))

	var_5_0.transform.parent = self.transform_
	var_5_0.transform.localPosition = Vector3.zero
	var_5_0.transform.localScale = Vector3.New(2, 0.5, 1)

	local var_5_1 = GameObject.New("Text", typeof(Text))

	var_5_1.transform.parent = var_5_0.transform
	var_5_1.transform.localPosition = Vector3.zero
	var_5_1.transform.anchoredPosition = Vector3.zero
	var_5_1.transform.localScale = Vector3.New(1, 4, 1)

	local var_5_2 = var_5_1.gameObject:GetComponent(typeof(Text))

	var_5_2.text = "4.4主题活动入口"
	var_5_2.color = Color.black
	var_5_2.font = Asset.Load("Fonts/SourceHanSerifCN-Bold-3.0")

	var_5_2:SetSizeDelta(Vector2.New(100, 25))
	var_5_0.gameObject:AddComponent(typeof(Image))
	var_5_0.gameObject:GetComponent(typeof(Button)).onClick:AddListener(function()
		JumpTools.OpenPageByJump("/cowBoyHomeView")
	end)
end

local function var_0_2(arg_8_0)
	if arg_8_0.testContentRoot_ == nil or isNil(arg_8_0.testContentRoot_) then
		return
	end

	SetActive(arg_8_0.testContentRoot_.gameObject, true)

	if arg_8_0.testBtnAreaPrepared_ then
		return
	end

	arg_8_0.testBtnAreaPrepared_ = true
end

function var_0_0:AddUIListeners()
	var_0_2(self)
	self:AddMiddlePanelUILisener()
	self:AddLeftPanelUIListener()
	self:AddRightPanelUIListener()
	self:AddUIListenersHome()
end

function var_0_0:OnEnter()
	self:RegistEventListener(HOME_POSTER_TALK, handler(self, self.OnHomePosterTalk))
	self:RegistEventListener(INTERRUPT_HOME_POSTER_TALK, self.clearTalkHandler)
	self:RegistEventListener(PUREMODE_SHOW, handler(self, self.SetPureModeShow))
	self:RegistEventListener(PUREMODE_EXIT, handler(self, self.ExitPureMode))
	self:RegistEventListener(ON_POSTERGIRL_TRANSITION_END, handler(self, self.UpdatePosterGirlBtn))
	self:RegistEventListener(ON_POSTERGIRL_UNLOCK_SPEC_VIEW, handler(self, self.UpdatePosterGirlBtn))
	self:RegistEventListener(PURE_MODE_TIME_SET, handler(self, self.RefreshPureModeTime))
	self:RegistEventListener(HOME_BTN_VISIBE, handler(self, self.OnHomeBtnVisible))
	self:RegistEventListener(ON_GAME_IN, function(arg_11_0, ...)
		if self:IsTop() then
			manager.posterGirl:EnterMiniGame(arg_11_0, ...)
		end
	end)
	manager.ui:ShowBackground(false)
	self:CheckHomeSceneInteration(true)
	self:ClearHeroFilter()
	DormRedPointTools:RefreshIlluDanceNew()
end

function var_0_0:OnTop()
	if not self.wait_posetr_debut then
		self:OnTopFunc()
	end

	self:ClearHeroFilter()

	self.longTimeNoOpCheckCom_.enabled = true
end

function var_0_0:OnTopFunc()
	if self.params_.isPureMode == true then
		self.isPureMode_ = false

		self:SetPureMode(false, true)
		self:RecordPureModeLog(true, PureModeConst.EnterMode.mode5)
	elseif not gameContext:IsOpenRoute("PureModeView") then
		self:InitBar()
		PlayerData:SetIsDeskMode(false)
		self:SetPureMode(true)
	end

	RedPointAction.UpdateSDKRedPoint()

	self.isDoActionEnd_ = self:CheckNeedPopWindow()

	if self.isDoActionEnd_ then
		self.isBehind_ = false
	end

	self:UpdateActivityLoginRedPoint()
end

function var_0_0:OnUpdate()
	if self:IsTop() and not manager.story:IsPlay() and manager.posterGirl:GetViewTag() == PosterGirlConst.ViewTag.null then
		manager.posterGirl:SetViewTag(PosterGirlConst.ViewTag.home)
	end
end

function var_0_0:OnExit()
	self.updateBgm_ = nil
	self.wait_posetr_debut = false

	PlayerData:SetPosterGirlDebut(false)
	manager.posterGirl:SetViewTag(PosterGirlConst.ViewTag.null)
	manager.loadScene:StopSceneSoundEffect()
	manager.notify:RemoveListener(MUTE_MAIN_AUDIO, self.muteAudioHandler_)
	manager.notify:RemoveListener(SHAKING_MOBILE, self.shakingAniHandler_)
	self:RemoveAllEventListener()
	manager.windowBar:HideBar()
	manager.ui:ResetMainCamera()
	self:MuteAudio()

	for iter_15_0, iter_15_1 in pairs(self.page_) do
		iter_15_1:OnExit()
	end

	self.activityEntraceView_:OnExit()
	self.skinDrawEntraceView_:OnExit()
	self.skinDiscountGiftEntranceView_:OnExit()

	if not JumpTools.IsSystemLocked(ViewConst.SYSTEM_ID.CHAT) then
		ChatAction.EnterChatUI(2)
	end

	SetActive(self.btn_girl.gameObject, false)

	self.skinId_ = nil

	ItemTools.StopRefreshLimitRed()
	self:StopAllTimers()
	self:ClearHomePosterTalk()

	self.isHeroGiftOpen_ = nil
	self.params_.changePoster = nil

	AnimatorTools.Stop()
	self:UnBindRedPointUI()
end

function var_0_0:Dispose()
	self.muteAudioHandler_ = nil

	self.activityEntraceView_:Dispose()

	self.activityEntraceView_ = nil

	self.skinDrawEntraceView_:Dispose()

	self.skinDrawEntraceView_ = nil

	self.skinDiscountGiftEntranceView_:Dispose()

	self.skinDiscountGiftEntranceView_ = nil

	for iter_16_0, iter_16_1 in pairs(self.page_) do
		iter_16_1:Dispose()
	end

	self.page_ = nil

	self.subtitleBubble:Dispose()
	self:RemoveAllListeners()

	if self.bannerView_ then
		self.bannerView_:Dispose()

		self.bannerView_ = nil
	end

	if self.hideChangeBtnDelayTimer_ then
		self.hideChangeBtnDelayTimer_:Stop()

		self.hideChangeBtnDelayTimer_ = nil
	end

	self:RemovePosterTween()
	var_0_0.super.Dispose(self)
end

function var_0_0:OnEnterFunc()
	self:CheckIsNeedOpenWebPage()
	self:UpdateFollowGiftRedPoint()
	SurveyAction.UpdateSurveyRedPoint()
	ReduxFactory.GetInstance():OnMainHomeViewTop()
	self:RefreshPage()
	self:RefreshUserInfo()
	ItemTools.RefreshLimitRed()
	self:RefreshBanner()
	self:RefreshRealtimeUI()
	self:StartRefreshUITimer()
	self:UpdataOperationViewRedPoint()
	self:BindRedPointUI()
	self:UpdateShopBtnTag()
	self:RegistEventListener(PASSPORT_INIT, function()
		self:CheckPassportBtn()
	end)
	self:CheckPassportBtn()
	self:CheckMomoTalkBtn()
	self:UpdateChipRedPoint()
	self:UpdateFriendsRedPoint()
	self:UpdateOathRedPoint()
	PosterGirlTools.UpdateDlCBtnRed()
	SetActive(self.skinDrawRedPanel_, not JumpTools.IsSystemLocked(ViewConst.SYSTEM_ID.SKIN_DRAW))
	self:RefreshChat()
	SetActive(self.goNewbie_, not JumpTools.IsSystemLocked(2201) and not ActivityNewbieTools.IsFinishAllActivity())

	local var_17_0, var_17_1 = ActivityNewbieTools.CheckAdvanceTaskOpen()

	SetActive(self.btn_newbie_task.gameObject, var_17_0)

	if var_17_0 then
		local var_17_2 = ActivityNewbieTools.GetAdvanceTaskCfg(var_17_1)

		self.newbieAdvanceTaskTitle_.text = GetTips(NoobVersionCfg[var_17_2.versionID].noob_advance_task_title[var_17_2.index])
	end

	SetActive(self.btn_regression.gameObject, (RegressionDataNew:IsRegressionOpen()))
	SetActive(self.btn_newServer.gameObject, ActivityData:GetActivityIsOpen(ActivityConst.ACTIVITY_NEW_SERVER) and JumpTools.IsConditionLocked(NewServerCfg[ActivityConst.ACTIVITY_NEW_SERVER].open_condition[1]) == false)
	self:CheckLocked()
	self:CheckActivite()
	self.activityEntraceView_:OnEnter()
	self.skinDrawEntraceView_:OnEnter()
	self.skinDiscountGiftEntranceView_:OnEnter()
	BulletinData.SetIslogin(true)
	manager.rollTips:TryToCreatTips()
	manager.notify:RegistListener(MUTE_MAIN_AUDIO, self.muteAudioHandler_)
	manager.notify:RegistListener(SHAKING_MOBILE, self.shakingAniHandler_)

	if self:IsTop() then
		self:RefreshHide()
	end

	self:OnHomeBtnVisible(true)
	self:UpdatePosterGirlBtn()

	if self.params_.isHomeBack then
		self.isPureMode_ = false

		PlayerData:SetIsDeskMode(false)

		self.params_.isHomeBack = nil
	end

	if PlayerData:GetDeskMode() then
		self.animator_:Play("HomeUI_hide2")
	end

	if OperationAction.GetOperationUrl("REFUND_URL") == nil or _G.CHANNEL_MASTER_ID ~= 1 then
		SetActive(self.btn_refund.gameObject, false)
	else
		SetActive(self.btn_refund.gameObject, true)
	end
end

local var_0_3 = {
	Sign = {
		"sign",
		{
			check = true,
			activityID = ActivityConst.SIGN
		},
		ViewConst.SYSTEM_ID.SIGN
	},
	Praise = {
		"praise"
	},
	ActivityAdvertise = {
		"activityAdvertise"
	},
	ChatMuted = {
		"chatMuted"
	},
	RegressionNewGift = {
		"regressionNewGift"
	},
	Birthday = {
		"BirthdayPop"
	},
	AutoChess = {
		"autoChessQuitPopView",
		{
			gameType = AutoChessConst.GAME_TYPE.ONLINE,
			type = AutoChessConst.POP_TYPE.PVP_SYNC_RECONNECT,
			okCb = function()
				AutoChessMatchAction.ReconnectAutoChess()
			end
		}
	}
}

local function var_0_4(arg_20_0, arg_20_1, arg_20_2)
	if arg_20_2 then
		table.insert(arg_20_0, arg_20_1)
	end

	return arg_20_2
end

local function var_0_5(arg_21_0)
	return function()
		JumpTools.OpenPageByJump(unpack(arg_21_0))
	end
end

function var_0_0.CheckWeakGuide(arg_23_0)
	return
end

function var_0_0:GetSpecialCom(arg_24_1)
	if string.sub(arg_24_1[1], 3) == "activityEntraceView_" then
		local var_24_0 = self.activityEntraceView_.itemUiList_:GetItemByIndex(arg_24_1[2])

		if var_24_0 then
			return var_24_0.gameObject_
		end
	end
end

function var_0_0:CheckNeedPopWindow()
	if PlayerPrefs.GetInt("SkipMainHomeCheckPopEditor", 0) == 1 then
		return true
	end

	local var_25_0
	local var_25_1

	if manager.guide:IsPlaying() then
		SetActive(self.mask_, false)

		do return end

		var_25_0 = RechargeData:HaveMonthCard() and not RechargeData:IsSignToday()
		var_25_1 = ActivityBigMonthCardToggle:Check()
	end

	local var_25_2 = SignTools.IsCanSign()
	local var_25_3 = SurveyData:GetPraise()
	local var_25_4 = ChatData:IsMuted() and not ChatData:GetShowMutedTips()
	local var_25_5 = RegressionDataNew:CheckIsShowGift()
	local var_25_6 = ActivityAdvertiseTools.NeedShowAdvertise()
	local var_25_7 = BulletinData.CheckDailyLoginPopBulletin()
	local var_25_8, var_25_9, var_25_10 = ArchiveTools.NeedShowArchivePop()
	local var_25_11, var_25_12, var_25_13 = HomeSceneSettingData:IsNeedSceenCheck()
	local var_25_14 = not LuaHidTools.HasSetRemapNotice()
	local var_25_15 = BirthdayTools.IsShowBirthdayPop()
	local var_25_16 = AutoChessData:GetIsCanReconnectAutoChess()
	local var_25_17, var_25_18 = OathSupportData:HasNewContent()

	if var_25_0 or var_25_1 or var_25_2 or var_25_3 or var_25_5 or var_25_4 or var_25_6 or var_25_7 or var_25_8 or var_25_11 or var_25_14 or var_25_15 or var_25_16 then
		SetActive(self.mask_, true)
	else
		SetActive(self.mask_, false)
		self:RealCheckWeakGuide()
	end

	if self.needToPlayTalk_ and not var_25_2 and not var_25_3 and not var_25_1 then
		self:PlayHeroGreeting()

		self.needToPlayTalk_ = false
	end

	if self.params_.isFirstCheck then
		if var_25_2 or var_25_3 or var_25_1 then
			self.needToPlayTalk_ = true
		else
			self:PlayHeroGreeting()
		end

		manager.gc:Collect()
		Resources.UnloadUnusedAssets()

		self.params_.isFirstCheck = false
	end

	local var_25_19 = {}

	if not var_0_4(var_25_19, var_0_5(var_0_3.Sign), var_25_0 or var_25_1 or var_25_2) and not var_0_4(var_25_19, var_0_5(var_0_3.Praise), var_25_3) and not var_0_4(var_25_19, var_0_5(var_0_3.ActivityAdvertise), var_25_6) and not var_0_4(var_25_19, var_0_5({
		"bulletin",
		{
			bulletinID = var_25_7
		},
		ViewConst.SYSTEM_ID.ANNOUNCEMENT
	}), var_25_7) and not var_0_4(var_25_19, var_0_5(var_0_3.ChatMuted), var_25_4) and not var_0_4(var_25_19, var_0_5(var_0_3.RegressionNewGift), var_25_5) and not var_0_4(var_25_19, var_0_5({
		"archiveHomePop",
		{
			heroID = var_25_9,
			type = var_25_10
		}
	}), var_25_8) and not var_0_4(var_25_19, var_0_5({
		"homeChangeScenePop",
		{
			left = var_25_12,
			right = var_25_13
		}
	}), var_25_11) and not var_0_4(var_25_19, LuaHidTools.QueryRemapNotice, var_25_14) and not var_0_4(var_25_19, var_0_5(var_0_3.Birthday), var_25_15) and not var_0_4(var_25_19, var_25_18, var_25_17) then
		local var_25_20 = var_0_4(var_25_19, var_0_5(var_0_3.AutoChess), var_25_16)
	end

	self:StartShowTimer(var_25_19)

	return #var_25_19 <= 0
end

function var_0_0.UpdateActivityLoginRedPoint(arg_26_0)
	ActivityAutoCookAction.UpdateLoginRedPoint()
end

function var_0_0:RemovePosterTween()
	if self.posterTween_ then
		self.posterTween_:setOnComplete(nil):setOnUpdate(nil):setEase(nil)
		LeanTween.cancel(self.posterTween_.id)

		self.posterTween_ = nil
	end
end

function var_0_0:HideTimeline()
	if self.timelines_ then
		for iter_28_0, iter_28_1 in pairs(self.timelines_:GetComponentsInChildren(typeof(UnityEngine.Transform), true):ToTable()) do
			if iter_28_1.name ~= self.timelines_.name then
				SetActive(iter_28_1.gameObject, false)
			end
		end
	end
end

function var_0_0:OnClickBg(arg_29_1)
	if self.isHide_ and self:IsTop() then
		self:StartViewHideTimer()
	end

	self:OnTouchInteract(arg_29_1)
end

function var_0_0:OnTouchInteract(arg_30_1)
	local var_30_0 = self:AnySceneObjAcceptTouchInteract(arg_30_1)

	if isNil(var_30_0) then
		self:DelayToPlayMultiTouchInteraction()
	else
		var_30_0:OnPointerDown(arg_30_1)
	end
end

function var_0_0.AnySceneObjAcceptTouchInteract(arg_31_0, arg_31_1)
	if manager.ui.mainCamera:GetComponent("PhysicsRaycaster") and arg_31_1 then
		local var_31_0 = UnityEngine.Physics.RaycastAll((UnityEngine.Camera.main:ScreenPointToRay(arg_31_1.position)))
		local var_31_1 = {}

		for iter_31_0 = 0, var_31_0.Length - 1 do
			table.insert(var_31_1, var_31_0[iter_31_0])
		end

		table.sort(var_31_1, function(arg_32_0, arg_32_1)
			return arg_32_0.distance < arg_32_1.distance
		end)

		for iter_31_1, iter_31_2 in ipairs(var_31_1) do
			local var_31_2 = iter_31_2.transform:GetComponent("EventTrigger")

			if var_31_2 then
				return var_31_2
			end
		end
	end

	return nil
end

function var_0_0:OnHomeSignUpdate()
	self:CheckNeedPopWindow()
end

function var_0_0:OnChangeNickname(arg_34_1)
	self.name_.text = GetI18NText(arg_34_1.nick)
end

function var_0_0:OnHeroGiftReward()
	self:CheckHeroGiftActivite()
end

function var_0_0:ShowPosterGirlBtn()
	self:SwitchPosterGirlPanel(true)

	if self.hideChangeBtnDelayTimer_ ~= nil then
		self.hideChangeBtnDelayTimer_:Reset()
	else
		self.hideChangeBtnDelayTimer_ = Timer.New(handler(self, self.HidePosterGirlBtn), 3, 1)

		self.hideChangeBtnDelayTimer_:Start()
	end
end

function var_0_0:HidePosterGirlBtn()
	self:SwitchPosterGirlPanel(false)

	if self.hideChangeBtnDelayTimer_ ~= nil then
		self.hideChangeBtnDelayTimer_:Stop()

		self.hideChangeBtnDelayTimer_ = nil
	end
end

function var_0_0:SwitchPosterGirlPanel(arg_38_1)
	SetActive(self.changeGirlBtn, arg_38_1)
	SetActive(self.changeSkinBtn, arg_38_1)
	SetActive(self.btn_giftGo_, arg_38_1)

	local var_38_0 = false
	local var_38_1 = false

	if arg_38_1 then
		local var_38_2 = PlayerData:GetPosterGirlHeroSkinId()
		local var_38_3 = CustomCenterTools.GetDLCScene(var_38_2)

		if var_38_3 and HomeSceneSettingData:GetUsedState(var_38_3.special_scene_id) ~= SceneConst.HOME_SCENE_TYPE.LOCK and HomeSceneSettingCfg[var_38_3.special_scene_id].limit_display ~= 1 then
			SetActive(self.btn_DlcGo_, true)
		else
			SetActive(self.btn_DlcGo_, false)
		end

		local var_38_4 = manager.posterGirl:GetViewDirect()
		local var_38_5 = HomeSceneSettingData:GetCurScene()

		if PosterGirlTools.IsSkinSceneTzeroMode(var_38_2, var_38_5) and var_38_4 == PosterGirlConst.ViewDirect.center then
			SetActive(self.btn_infoGo_, true)
		else
			SetActive(self.btn_infoGo_, false)
		end

		var_38_0 = PosterGirlTools.HasTimeEffect(var_38_2, var_38_5)
		var_38_1 = PosterGirlTools.HasWeatherEffect(var_38_2, var_38_5)
	else
		SetActive(self.btn_infoGo_, false)
		SetActive(self.btn_DlcGo_, false)
	end

	SetActive(self.timeSwitchBtn_.gameObject, var_38_0)
	SetActive(self.weatherSwitchBtn_.gameObject, var_38_1)
end

function var_0_0:MuteAudio()
	HeroTools.StopTalk()

	if self.multiTouchTimer_ ~= nil then
		self.multiTouchTimer_:Stop()

		self.multiTouchTimer_ = nil
	end

	self.subtitleBubble:SetVisible(false)

	self.talking_ = false
end

function var_0_0.ShakingAni(arg_40_0)
	manager.posterGirl:DoShacking()
end

function var_0_0.OnHomeSceneChange(arg_41_0, arg_41_1, arg_41_2)
	manager.transition:OnlyShowEffect(true, function()
		manager.loadScene:ForceSetShouldLoadSceneName("home", function()
			if arg_41_0.OnlyShowEffectExiting_ then
				return
			end

			arg_41_0:MuteAudio()
			arg_41_0:SetCamera()
			manager.posterGirl:RefreshModel()
			manager.posterGirl:InitTouchHelp(arg_41_0.mutiTouchHelper_)

			if manager.posterGirl:CheckDebut() then
				manager.windowBar:HideBar()
				arg_41_0.sceneCon_:SetSelectedState("off")
			end

			arg_41_0:HidePosterGirlBtn()

			arg_41_0.OnlyShowEffectExiting_ = true

			manager.transition:OnlyShowEffect(false)

			arg_41_0.OnlyShowEffectExiting_ = false

			local var_43_0 = SettingData:GetHomeSceneSettingData()
			local var_43_1 = HomeSceneSettingCfg[HomeSceneSettingData:GetCurScene()]

			if var_43_0.home_scene_scene_bgm == 0 or var_43_1.default_music == 0 then
				-- block empty
			else
				if var_43_0.home_scene_scene_bgm == 1 and var_43_1.default_music ~= 0 and var_43_0.home_scene_scene_bgm == 1 and table.indexof(var_43_1.scene_setting, HomeSceneSettingConst.SETTING.SCENE_BGM) then
					IllustratedAction.QuerySetBgm(var_43_1.default_music)
				end

				PlayGameSetBGM()
			end

			manager.gc:Collect()
			Resources.UnloadUnusedAssets()
		end)
	end)
end

function var_0_0.SetCamera(arg_44_0)
	local var_44_0 = "home_" .. HomeSceneSettingData:GetCurScene()

	if CameraCfg[var_44_0] then
		manager.ui:SetMainCamera(var_44_0)
	else
		manager.ui:SetMainCamera("home")
	end
end

function var_0_0:CheckIsNeedPlayShowingAni()
	if self.params_.changePoster then
		self.params_.changePoster = nil

		if not self.assistantVoiceTime_ or Time.realtimeSinceStartup - self.assistantVoiceTime_ >= HeroConst.SET_ASSISTANT_VOICE_CD then
			self.assistantVoiceTime_ = Time.realtimeSinceStartup

			manager.posterGirl:DoShowing()
		end
	end
end

function var_0_0:CheckHomeSceneInteration()
	manager.windowBar:ClearWhereTag()
	self:SetCamera()

	self.isHide_ = false
	self.userData_ = PlayerData:GetPlayerInfo()
	self.skinId_ = PlayerData:GetPosterGirlHeroSkinId()
	self.posterGirl_ = SkinCfg[self.skinId_].hero

	self:RefreshPureModeTime()
	HeroAction.SelectSkinWithCallback(self.posterGirl_, self.skinId_, function()
		return
	end)

	if CustomCenterTools.IsRandomHero() and PlayerData:GetRandomHeroMode() == HomeSceneSettingConst.RANDOM_MODE.EACH_DAY then
		saveData("RandomData", "LastId_HERO", PlayerData:GetRandomHero())
	end

	if CustomCenterTools.IsRandomScene() and HomeSceneSettingData:GetRandomMode() == HomeSceneSettingConst.RANDOM_MODE.EACH_DAY then
		saveData("RandomData", "LastId_SCENE", HomeSceneSettingData:GetRandomScene())
	end

	PlayerAction.SaveHeroSkinIDAndSceneID(self.skinId_, (HomeSceneSettingData:GetCurScene()))

	if not manager.story:IsPlay() then
		manager.posterGirl:SetViewTag(PosterGirlConst.ViewTag.home)
		manager.posterGirl:InitTouchHelp(self.mutiTouchHelper_)
	end

	if not manager.guide:IsPlaying() and manager.posterGirl:CheckDebut() then
		self.wait_posetr_debut = true

		PlayerData:SetPosterGirlDebut(true)
		manager.windowBar:HideBar()
		self.sceneCon_:SetSelectedState("off")
		self:HideSceneMenuPanel(true)
		self.changedlcCon_:SetSelectedState("hide")
	else
		self.sceneCon_:SetSelectedState("on")
		self:OnEnterFunc()
		self:CheckIsNeedPlayShowingAni()
	end

	manager.loadScene:SetHomeSceneSoundEffect()

	local var_46_0 = PlayerData:GetPlayAssistantVoice()

	if var_46_0 and var_46_0[1] == self.posterGirl_ and not PlayerData:GetPosterGirlDebut() then
		if var_46_0[2] then
			HeroTools.PlayVoice(self.posterGirl_, "cloth")
		else
			manager.posterGirl:DoShowing()
		end
	end

	PlayerData:SetPlayAssistantVoice()
end

function var_0_0:OnHomeDebutOver()
	if self.wait_posetr_debut then
		self:OnEnterFunc()
		self:OnTopFunc()
	end

	self.sceneCon_:SetSelectedState("on")
	self:HideSceneMenuPanel(false)

	self.wait_posetr_debut = false

	PlayerData:SetPosterGirlDebut(false)
end

function var_0_0:HideSceneMenuPanel(arg_49_1)
	if self:IsOpenRoute("menuPop") then
		manager.notify:Invoke(HOME_HIDE_MENU_POP, arg_49_1)
	end
end

function var_0_0.PlayHeroGreeting(arg_50_0)
	manager.posterGirl:DoGreeting()
end

function var_0_0:DelayToPlayMultiTouchInteraction()
	self.clickCount_ = self.clickCount_ + 1

	if self.multiTouchTimer_ == nil then
		self.multiTouchTimer_ = Timer.New(function()
			if self.multiTouchTimer_ then
				self.multiTouchTimer_:Stop()

				self.multiTouchTimer_ = nil
			end

			if manager.posterGirl:GetMiniGameState() then
				return
			end

			local var_52_0 = HomeSceneSettingData:GetCurScene()

			if self.clickCount_ >= 3 then
				SDKTools.SendMessageToSDK("poster_touch", {
					touch_times = 3,
					position = 0,
					hero_id = self.skinId_,
					scene_id = var_52_0
				})
				manager.posterGirl:DoQuickTouch()
			else
				SDKTools.SendMessageToSDK("poster_touch", {
					touch_times = 1,
					position = 0,
					hero_id = self.skinId_,
					scene_id = var_52_0
				})
				manager.posterGirl:DoTouch()
			end

			self.clickCount_ = 0
		end, 0.5, 1)

		self.multiTouchTimer_:Start()
	end
end

function var_0_0:ClearHomePosterTalk()
	self.talking_ = false

	self.subtitleBubble:Clear()
end

function var_0_0:OnHomePosterTalk(arg_54_1, arg_54_2, arg_54_3)
	local var_54_0 = HeroVoiceDescCfg.GetConfig(arg_54_1, arg_54_2)

	if var_54_0 then
		self.talking_ = true

		local var_54_1 = var_54_0.hide_word == 1 or var_54_0.content == ""

		if not isNil(self.talkBubbleGo_) then
			var_54_1 = var_54_1 or self:RefreshTalkBubbleHide()
		end

		if var_54_1 then
			self.talking_ = false

			self.subtitleBubble:Clear()
		else
			self.talking_ = true

			self.subtitleBubble:SetBgStyleBySkin(arg_54_1)
			self.subtitleBubble:StartBubble(var_54_0.content, arg_54_3 / 1000, self.clearTalkHandler)
		end
	end
end

function var_0_0:OnHomeBtnVisible(arg_55_1)
	SetActive(self.panelGo_, arg_55_1)

	arg_55_1 = arg_55_1 and manager.posterGirl.actor:GetViewCnt() > 1

	self.changedlcCon_:SetSelectedState(arg_55_1 and "show" or "hide")

	if arg_55_1 then
		self:UpdatePosterGirlBtn()
	end
end

function var_0_0.ClearHeroFilter(arg_56_0)
	HeroData:SetupHeroMainOpenStatus(false)
	CommonFilterData:ClearFilter(Filter_Root_Define.Hero_Filter_List.filter_id)
end

function var_0_0:UpdatePosterGirlBtn()
	local var_57_0 = SettingData:GetGameSettingData().home_scene_dlc_btn == 0
	local var_57_1 = PosterGirlTools.CanInterruptCurAni()

	if not var_57_0 and var_57_1 and manager.posterGirl:CanSwipeToLeft() then
		self.btn_zuoCon_:SetSelectedState("enable")
	else
		self.btn_zuoCon_:SetSelectedState("disable")
	end

	if not var_57_0 and var_57_1 and manager.posterGirl:CanSwipeToRight() then
		self.btn_youCon_:SetSelectedState("enable")
	else
		self.btn_youCon_:SetSelectedState("disable")
	end
end

function var_0_0:OnBehind()
	self.isBehind_ = true
	self.longTimeNoOpCheckCom_.enabled = false

	self:StopViewHideTimer()
	self:SetPureModeBtnActive(false, false)
end

function var_0_0:SetPureModeShow()
	if manager.guide:IsPlaying() or manager.guide:IsPlayingWeaking() or not self.isDoActionEnd_ or not self:IsTop() then
		return
	end

	self:StopAllTimers()
	self:ClearHomePosterTalk()
	self:SetPureMode(false)
	self:SetPureModeBtnActive(false, true)
	JumpTools.OpenPageByJump("PureModeView", {
		enterType = (self.isPureMode_ or nil) and (PureModeConst.EnterMode.mode3 or PureModeConst.EnterMode.mode2)
	})

	if self.isPureMode_ then
		self:RecordPureModeLog(false)
	end
end

function var_0_0:RefreshPureModeTime()
	local var_60_0 = GameSetting.pure_mode_entry_time.value[PlayerData:GetPureModeData().pureModeTimeIndex]

	if var_60_0 and var_60_0 > 0 then
		LuaForUtil.SetNoOperationTime(self.panelGo_, var_60_0)
	end
end

function var_0_0:ExitPureMode()
	self:StartRefreshUITimer()
	self:CheckActivite()
end

return var_0_0
