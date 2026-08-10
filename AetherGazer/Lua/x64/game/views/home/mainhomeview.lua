local var_0_0 = partialClass("MainHomeView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Main/HomeUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0.clearTalkHandler = handler(arg_3_0, arg_3_0.ClearHomePosterTalk)

	arg_3_0:InitUI()
	arg_3_0:AddUIListeners()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.page_ = {}
	arg_4_0.clickCount_ = 0
	arg_4_0.muteAudioHandler_ = handler(arg_4_0, arg_4_0.MuteAudio)
	arg_4_0.shakingAniHandler_ = handler(arg_4_0, arg_4_0.ShakingAni)
	arg_4_0.bannerView_ = BannerView.New(arg_4_0, arg_4_0.btnActivityGo_)
	arg_4_0.activityEntraceView_ = ActivityEntraceView.New(arg_4_0.activityListGo_)
	arg_4_0.skinDrawEntraceView_ = ActivitySkinDrawEntraceView.New(arg_4_0.skinDrawGo_)
	arg_4_0.skinDiscountGiftEntranceView_ = SkinDiscountGiftEntranceView.New(arg_4_0.skinDiscountGo_)
	arg_4_0.subtitleBubble = MainHomeView_SubtitleBubble.New(arg_4_0.talkBubbleGo_)
	arg_4_0.socializeCon_ = arg_4_0.conExCollection_:GetController("socialize")
	arg_4_0.hideCon_ = arg_4_0.conExCollection_:GetController("hide")
	arg_4_0.sceneCon_ = arg_4_0.conExCollection_:GetController("scene")
	arg_4_0.skinDrawCon_ = arg_4_0.conExCollection_:GetController("skinDraw")
	arg_4_0.drawLockCon_ = arg_4_0.conExCollection_:GetController("drawLocked")
	arg_4_0.dormLockCon_ = arg_4_0.conExCollection_:GetController("dormLocked")
	arg_4_0.guildCon_ = arg_4_0.conExCollection_:GetController("guildLocked")
	arg_4_0.shopCon_ = arg_4_0.conExCollection_:GetController("shopLocked")
	arg_4_0.textLimit_ = arg_4_0.chatTxt_.gameObject:GetComponent("TextExtension")
	arg_4_0.mutiTouchHelper_ = arg_4_0.btn_girl.gameObject:GetComponent("MutiTouchHelper")
	arg_4_0.changedlcCon_ = arg_4_0.conExCollection_:GetController("changedlcView")
	arg_4_0.puremodeCon_ = arg_4_0.conExCollection_:GetController("puremode")
	arg_4_0.btn_zuoCon_ = arg_4_0.btn_zuo01Controllerexcollection_:GetController("zuo01")
	arg_4_0.btn_youCon_ = arg_4_0.btn_youControllerexcollection_:GetController("you01")

	arg_4_0:SwitchPosterGirlPanel(false)
	arg_4_0.subtitleBubble:SetVisible(false)
	arg_4_0.puremodeCon_:SetSelectedState("hide")
	arg_4_0.changedlcCon_:SetSelectedState("hide")

	arg_4_0.longTimeNoOpCheckCom_ = arg_4_0.panelGo_:GetComponent("LongTimeNoOperation")

	LuaForUtil.SetNoOperationTime(arg_4_0.panelGo_, 1000)
end

function var_0_0.AddTestBilliardGameBtn(arg_5_0)
	local var_5_0 = GameObject.New("BilliardTestBtn", typeof(Button))

	var_5_0.transform.parent = arg_5_0.transform_
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

	local var_5_3 = var_5_0.gameObject:GetComponent(typeof(Button))

	var_5_0.gameObject:AddComponent(typeof(Image))
	var_5_3.onClick:AddListener(function()
		JumpTools.OpenPageByJump("/cowBoyHomeView")
	end)
end

local function var_0_1(arg_7_0, arg_7_1)
	local var_7_0 = Asset.Instantiate("Widget/System/Activity_Resident/Activity_Com/Activity_Com_btn01")

	var_7_0.transform:SetParent(arg_7_0.testContentRoot_, false)

	local var_7_1 = var_7_0.transform:Find("root/Btn01"):GetComponent("Button")

	var_7_0.transform:Find("root/Btn01/textbtnname"):GetComponent("Text").text = arg_7_1

	return var_7_1
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

function var_0_0.AddUIListeners(arg_9_0)
	var_0_2(arg_9_0)
	arg_9_0:AddMiddlePanelUILisener()
	arg_9_0:AddLeftPanelUIListener()
	arg_9_0:AddRightPanelUIListener()
	arg_9_0:AddUIListenersHome()
end

function var_0_0.OnEnter(arg_10_0)
	arg_10_0:RegistEventListener(HOME_POSTER_TALK, handler(arg_10_0, arg_10_0.OnHomePosterTalk))
	arg_10_0:RegistEventListener(INTERRUPT_HOME_POSTER_TALK, arg_10_0.clearTalkHandler)
	arg_10_0:RegistEventListener(PUREMODE_SHOW, handler(arg_10_0, arg_10_0.SetPureModeShow))
	arg_10_0:RegistEventListener(PUREMODE_EXIT, handler(arg_10_0, arg_10_0.ExitPureMode))
	arg_10_0:RegistEventListener(ON_POSTERGIRL_TRANSITION_END, handler(arg_10_0, arg_10_0.UpdatePosterGirlBtn))
	arg_10_0:RegistEventListener(ON_POSTERGIRL_UNLOCK_SPEC_VIEW, handler(arg_10_0, arg_10_0.UpdatePosterGirlBtn))
	arg_10_0:RegistEventListener(PURE_MODE_TIME_SET, handler(arg_10_0, arg_10_0.RefreshPureModeTime))
	arg_10_0:RegistEventListener(HOME_BTN_VISIBE, handler(arg_10_0, arg_10_0.OnHomeBtnVisible))
	arg_10_0:RegistEventListener(ON_GAME_IN, function(arg_11_0, ...)
		if arg_10_0:IsTop() then
			manager.posterGirl:EnterMiniGame(arg_11_0, ...)
		end
	end)
	manager.ui:ShowBackground(false)
	arg_10_0:CheckHomeSceneInteration(true)
	arg_10_0:ClearHeroFilter()
	DormRedPointTools:RefreshIlluDanceNew()
end

function var_0_0.OnTop(arg_12_0)
	if not arg_12_0.wait_posetr_debut then
		arg_12_0:OnTopFunc()
	end

	arg_12_0:ClearHeroFilter()

	arg_12_0.longTimeNoOpCheckCom_.enabled = true
end

function var_0_0.OnTopFunc(arg_13_0)
	if arg_13_0.params_.isPureMode == true then
		arg_13_0.isPureMode_ = false

		arg_13_0:SetPureMode(false, true)
		arg_13_0:RecordPureModeLog(true, PureModeConst.EnterMode.mode5)
	elseif not gameContext:IsOpenRoute("PureModeView") then
		arg_13_0:InitBar()
		PlayerData:SetIsDeskMode(false)
		arg_13_0:SetPureMode(true)
	end

	RedPointAction.UpdateSDKRedPoint()

	arg_13_0.isDoActionEnd_ = arg_13_0:CheckNeedPopWindow()

	if arg_13_0.isDoActionEnd_ then
		arg_13_0.isBehind_ = false
	end

	arg_13_0:UpdateActivityLoginRedPoint()
end

function var_0_0.OnUpdate(arg_14_0)
	if arg_14_0:IsTop() and not manager.story:IsPlay() and manager.posterGirl:GetViewTag() == PosterGirlConst.ViewTag.null then
		manager.posterGirl:SetViewTag(PosterGirlConst.ViewTag.home)
	end
end

function var_0_0.OnExit(arg_15_0)
	arg_15_0.updateBgm_ = nil
	arg_15_0.wait_posetr_debut = false

	PlayerData:SetPosterGirlDebut(false)
	manager.posterGirl:SetViewTag(PosterGirlConst.ViewTag.null)
	manager.loadScene:StopSceneSoundEffect()
	manager.notify:RemoveListener(MUTE_MAIN_AUDIO, arg_15_0.muteAudioHandler_)
	manager.notify:RemoveListener(SHAKING_MOBILE, arg_15_0.shakingAniHandler_)
	arg_15_0:RemoveAllEventListener()
	manager.windowBar:HideBar()
	manager.ui:ResetMainCamera()
	arg_15_0:MuteAudio()

	for iter_15_0, iter_15_1 in pairs(arg_15_0.page_) do
		iter_15_1:OnExit()
	end

	arg_15_0.activityEntraceView_:OnExit()
	arg_15_0.skinDrawEntraceView_:OnExit()
	arg_15_0.skinDiscountGiftEntranceView_:OnExit()

	if not JumpTools.IsSystemLocked(ViewConst.SYSTEM_ID.CHAT) then
		ChatAction.EnterChatUI(2)
	end

	SetActive(arg_15_0.btn_girl.gameObject, false)

	arg_15_0.skinId_ = nil

	ItemTools.StopRefreshLimitRed()
	arg_15_0:StopAllTimers()
	arg_15_0:ClearHomePosterTalk()

	arg_15_0.isHeroGiftOpen_ = nil
	arg_15_0.params_.changePoster = nil

	AnimatorTools.Stop()
	arg_15_0:UnBindRedPointUI()
end

function var_0_0.Dispose(arg_16_0)
	arg_16_0.muteAudioHandler_ = nil

	arg_16_0.activityEntraceView_:Dispose()

	arg_16_0.activityEntraceView_ = nil

	arg_16_0.skinDrawEntraceView_:Dispose()

	arg_16_0.skinDrawEntraceView_ = nil

	arg_16_0.skinDiscountGiftEntranceView_:Dispose()

	arg_16_0.skinDiscountGiftEntranceView_ = nil

	for iter_16_0, iter_16_1 in pairs(arg_16_0.page_) do
		iter_16_1:Dispose()
	end

	arg_16_0.page_ = nil

	arg_16_0.subtitleBubble:Dispose()
	arg_16_0:RemoveAllListeners()

	if arg_16_0.bannerView_ then
		arg_16_0.bannerView_:Dispose()

		arg_16_0.bannerView_ = nil
	end

	if arg_16_0.hideChangeBtnDelayTimer_ then
		arg_16_0.hideChangeBtnDelayTimer_:Stop()

		arg_16_0.hideChangeBtnDelayTimer_ = nil
	end

	arg_16_0:RemovePosterTween()
	var_0_0.super.Dispose(arg_16_0)
end

function var_0_0.OnEnterFunc(arg_17_0)
	arg_17_0:CheckIsNeedOpenWebPage()
	arg_17_0:UpdateFollowGiftRedPoint()
	SurveyAction.UpdateSurveyRedPoint()
	ReduxFactory.GetInstance():OnMainHomeViewTop()
	arg_17_0:RefreshPage()
	arg_17_0:RefreshUserInfo()
	ItemTools.RefreshLimitRed()
	arg_17_0:RefreshBanner()
	arg_17_0:RefreshRealtimeUI()
	arg_17_0:StartRefreshUITimer()
	arg_17_0:UpdataOperationViewRedPoint()
	arg_17_0:BindRedPointUI()
	arg_17_0:UpdateShopBtnTag()
	arg_17_0:RegistEventListener(PASSPORT_INIT, function()
		arg_17_0:CheckPassportBtn()
	end)
	arg_17_0:CheckPassportBtn()
	arg_17_0:CheckMomoTalkBtn()
	arg_17_0:UpdateChipRedPoint()
	arg_17_0:UpdateFriendsRedPoint()
	arg_17_0:UpdateOathRedPoint()
	PosterGirlTools.UpdateDlCBtnRed()
	SetActive(arg_17_0.skinDrawRedPanel_, not JumpTools.IsSystemLocked(ViewConst.SYSTEM_ID.SKIN_DRAW))
	arg_17_0:RefreshChat()

	local var_17_0 = not JumpTools.IsSystemLocked(2201) and not ActivityNewbieTools.IsFinishAllActivity()

	SetActive(arg_17_0.goNewbie_, var_17_0)

	local var_17_1, var_17_2 = ActivityNewbieTools.CheckAdvanceTaskOpen()

	SetActive(arg_17_0.btn_newbie_task.gameObject, var_17_1)

	if var_17_1 then
		local var_17_3 = ActivityNewbieTools.GetAdvanceTaskCfg(var_17_2)

		arg_17_0.newbieAdvanceTaskTitle_.text = GetTips(NoobVersionCfg[var_17_3.versionID].noob_advance_task_title[var_17_3.index])
	end

	local var_17_4 = RegressionDataNew:IsRegressionOpen()

	SetActive(arg_17_0.btn_regression.gameObject, var_17_4)

	local var_17_5 = ActivityData:GetActivityIsOpen(ActivityConst.ACTIVITY_NEW_SERVER)
	local var_17_6 = JumpTools.IsConditionLocked(NewServerCfg[ActivityConst.ACTIVITY_NEW_SERVER].open_condition[1]) == false

	SetActive(arg_17_0.btn_newServer.gameObject, var_17_5 and var_17_6)
	arg_17_0:CheckLocked()
	arg_17_0:CheckActivite()
	arg_17_0.activityEntraceView_:OnEnter()
	arg_17_0.skinDrawEntraceView_:OnEnter()
	arg_17_0.skinDiscountGiftEntranceView_:OnEnter()
	BulletinData.SetIslogin(true)
	manager.rollTips:TryToCreatTips()
	manager.notify:RegistListener(MUTE_MAIN_AUDIO, arg_17_0.muteAudioHandler_)
	manager.notify:RegistListener(SHAKING_MOBILE, arg_17_0.shakingAniHandler_)

	if arg_17_0:IsTop() then
		arg_17_0:RefreshHide()
	end

	arg_17_0:OnHomeBtnVisible(true)
	arg_17_0:UpdatePosterGirlBtn()

	if arg_17_0.params_.isHomeBack then
		arg_17_0.isPureMode_ = false

		PlayerData:SetIsDeskMode(false)

		arg_17_0.params_.isHomeBack = nil
	end

	if PlayerData:GetDeskMode() then
		arg_17_0.animator_:Play("HomeUI_hide2")
	end

	if OperationAction.GetOperationUrl("REFUND_URL") == nil or _G.CHANNEL_MASTER_ID ~= 1 then
		SetActive(arg_17_0.btn_refund.gameObject, false)
	else
		SetActive(arg_17_0.btn_refund.gameObject, true)
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

function var_0_0.GetSpecialCom(arg_24_0, arg_24_1)
	local var_24_0 = string.sub(arg_24_1[1], 3)
	local var_24_1 = arg_24_1[2]

	if var_24_0 == "activityEntraceView_" then
		local var_24_2 = arg_24_0.activityEntraceView_.itemUiList_:GetItemByIndex(var_24_1)

		if var_24_2 then
			return var_24_2.gameObject_
		end
	end
end

function var_0_0.CheckNeedPopWindow(arg_25_0)
	if PlayerPrefs.GetInt("SkipMainHomeCheckPopEditor", 0) == 1 then
		return true
	end

	if manager.guide:IsPlaying() then
		SetActive(arg_25_0.mask_, false)

		return
	end

	local var_25_0 = SignTools.IsCanSign()
	local var_25_1 = RechargeData:HaveMonthCard() and not RechargeData:IsSignToday()
	local var_25_2 = ActivityBigMonthCardToggle:Check()
	local var_25_3 = var_25_0
	local var_25_4 = SurveyData:GetPraise()
	local var_25_5 = ChatData:IsMuted() and not ChatData:GetShowMutedTips()
	local var_25_6 = RegressionDataNew:CheckIsShowGift()
	local var_25_7 = ActivityAdvertiseTools.NeedShowAdvertise()
	local var_25_8 = BulletinData.CheckDailyLoginPopBulletin()
	local var_25_9, var_25_10, var_25_11 = ArchiveTools.NeedShowArchivePop()
	local var_25_12, var_25_13, var_25_14 = HomeSceneSettingData:IsNeedSceenCheck()
	local var_25_15 = not LuaHidTools.HasSetRemapNotice()
	local var_25_16 = BirthdayTools.IsShowBirthdayPop()
	local var_25_17 = AutoChessData:GetIsCanReconnectAutoChess()
	local var_25_18, var_25_19 = OathSupportData:HasNewContent()

	if var_25_1 or var_25_2 or var_25_3 or var_25_4 or var_25_6 or var_25_5 or var_25_7 or var_25_8 or var_25_9 or var_25_12 or var_25_15 or var_25_16 or var_25_17 then
		SetActive(arg_25_0.mask_, true)
	else
		SetActive(arg_25_0.mask_, false)
		arg_25_0:RealCheckWeakGuide()
	end

	if arg_25_0.needToPlayTalk_ and not var_25_3 and not var_25_4 and not var_25_2 then
		arg_25_0:PlayHeroGreeting()

		arg_25_0.needToPlayTalk_ = false
	end

	if arg_25_0.params_.isFirstCheck then
		if var_25_3 or var_25_4 or var_25_2 then
			arg_25_0.needToPlayTalk_ = true
		else
			arg_25_0:PlayHeroGreeting()
		end

		manager.gc:Collect()
		Resources.UnloadUnusedAssets()

		arg_25_0.params_.isFirstCheck = false
	end

	local var_25_20 = {}

	if not var_0_4(var_25_20, var_0_5(var_0_3.Sign), var_25_1 or var_25_2 or var_25_3) and not var_0_4(var_25_20, var_0_5(var_0_3.Praise), var_25_4) and not var_0_4(var_25_20, var_0_5(var_0_3.ActivityAdvertise), var_25_7) and not var_0_4(var_25_20, var_0_5({
		"bulletin",
		{
			bulletinID = var_25_8
		},
		ViewConst.SYSTEM_ID.ANNOUNCEMENT
	}), var_25_8) and not var_0_4(var_25_20, var_0_5(var_0_3.ChatMuted), var_25_5) and not var_0_4(var_25_20, var_0_5(var_0_3.RegressionNewGift), var_25_6) and not var_0_4(var_25_20, var_0_5({
		"archiveHomePop",
		{
			heroID = var_25_10,
			type = var_25_11
		}
	}), var_25_9) and not var_0_4(var_25_20, var_0_5({
		"homeChangeScenePop",
		{
			left = var_25_13,
			right = var_25_14
		}
	}), var_25_12) and not var_0_4(var_25_20, LuaHidTools.QueryRemapNotice, var_25_15) and not var_0_4(var_25_20, var_0_5(var_0_3.Birthday), var_25_16) and not var_0_4(var_25_20, var_25_19, var_25_18) then
		local var_25_21 = var_0_4(var_25_20, var_0_5(var_0_3.AutoChess), var_25_17)
	end

	arg_25_0:StartShowTimer(var_25_20)

	return #var_25_20 <= 0
end

function var_0_0.UpdateActivityLoginRedPoint(arg_26_0)
	ActivityAutoCookAction.UpdateLoginRedPoint()
end

function var_0_0.RemovePosterTween(arg_27_0)
	if arg_27_0.posterTween_ then
		arg_27_0.posterTween_:setOnComplete(nil):setOnUpdate(nil):setEase(nil)
		LeanTween.cancel(arg_27_0.posterTween_.id)

		arg_27_0.posterTween_ = nil
	end
end

function var_0_0.HideTimeline(arg_28_0)
	if arg_28_0.timelines_ then
		local var_28_0 = arg_28_0.timelines_:GetComponentsInChildren(typeof(UnityEngine.Transform), true)

		for iter_28_0, iter_28_1 in pairs(var_28_0:ToTable()) do
			if iter_28_1.name ~= arg_28_0.timelines_.name then
				SetActive(iter_28_1.gameObject, false)
			end
		end
	end
end

function var_0_0.OnClickBg(arg_29_0, arg_29_1)
	if arg_29_0.isHide_ and arg_29_0:IsTop() then
		arg_29_0:StartViewHideTimer()
	end

	arg_29_0:OnTouchInteract(arg_29_1)
end

function var_0_0.OnTouchInteract(arg_30_0, arg_30_1)
	local var_30_0 = arg_30_0:AnySceneObjAcceptTouchInteract(arg_30_1)

	if isNil(var_30_0) then
		arg_30_0:DelayToPlayMultiTouchInteraction()
	else
		var_30_0:OnPointerDown(arg_30_1)
	end
end

function var_0_0.AnySceneObjAcceptTouchInteract(arg_31_0, arg_31_1)
	if manager.ui.mainCamera:GetComponent("PhysicsRaycaster") and arg_31_1 then
		local var_31_0 = arg_31_1.position
		local var_31_1 = UnityEngine.Camera.main:ScreenPointToRay(var_31_0)
		local var_31_2 = UnityEngine.Physics.RaycastAll(var_31_1)
		local var_31_3 = {}

		for iter_31_0 = 0, var_31_2.Length - 1 do
			table.insert(var_31_3, var_31_2[iter_31_0])
		end

		table.sort(var_31_3, function(arg_32_0, arg_32_1)
			return arg_32_0.distance < arg_32_1.distance
		end)

		for iter_31_1, iter_31_2 in ipairs(var_31_3) do
			local var_31_4 = iter_31_2.transform:GetComponent("EventTrigger")

			if var_31_4 then
				return var_31_4
			end
		end
	end

	return nil
end

function var_0_0.OnHomeSignUpdate(arg_33_0)
	arg_33_0:CheckNeedPopWindow()
end

function var_0_0.OnChangeNickname(arg_34_0, arg_34_1)
	arg_34_0.name_.text = GetI18NText(arg_34_1.nick)
end

function var_0_0.OnHeroGiftReward(arg_35_0)
	arg_35_0:CheckHeroGiftActivite()
end

function var_0_0.ShowPosterGirlBtn(arg_36_0)
	arg_36_0:SwitchPosterGirlPanel(true)

	if arg_36_0.hideChangeBtnDelayTimer_ ~= nil then
		arg_36_0.hideChangeBtnDelayTimer_:Reset()
	else
		arg_36_0.hideChangeBtnDelayTimer_ = Timer.New(handler(arg_36_0, arg_36_0.HidePosterGirlBtn), 3, 1)

		arg_36_0.hideChangeBtnDelayTimer_:Start()
	end
end

function var_0_0.HidePosterGirlBtn(arg_37_0)
	arg_37_0:SwitchPosterGirlPanel(false)

	if arg_37_0.hideChangeBtnDelayTimer_ ~= nil then
		arg_37_0.hideChangeBtnDelayTimer_:Stop()

		arg_37_0.hideChangeBtnDelayTimer_ = nil
	end
end

function var_0_0.SwitchPosterGirlPanel(arg_38_0, arg_38_1)
	SetActive(arg_38_0.changeGirlBtn, arg_38_1)
	SetActive(arg_38_0.changeSkinBtn, arg_38_1)
	SetActive(arg_38_0.btn_giftGo_, arg_38_1)

	local var_38_0 = false
	local var_38_1 = false

	if arg_38_1 then
		local var_38_2 = PlayerData:GetPosterGirlHeroSkinId()
		local var_38_3 = CustomCenterTools.GetDLCScene(var_38_2)

		if var_38_3 and HomeSceneSettingData:GetUsedState(var_38_3.special_scene_id) ~= SceneConst.HOME_SCENE_TYPE.LOCK and HomeSceneSettingCfg[var_38_3.special_scene_id].limit_display ~= 1 then
			SetActive(arg_38_0.btn_DlcGo_, true)
		else
			SetActive(arg_38_0.btn_DlcGo_, false)
		end

		local var_38_4 = manager.posterGirl:GetViewDirect()
		local var_38_5 = HomeSceneSettingData:GetCurScene()

		if PosterGirlTools.IsSkinSceneTzeroMode(var_38_2, var_38_5) and var_38_4 == PosterGirlConst.ViewDirect.center then
			SetActive(arg_38_0.btn_infoGo_, true)
		else
			SetActive(arg_38_0.btn_infoGo_, false)
		end

		var_38_0 = PosterGirlTools.HasTimeEffect(var_38_2, var_38_5)
		var_38_1 = PosterGirlTools.HasWeatherEffect(var_38_2, var_38_5)
	else
		SetActive(arg_38_0.btn_infoGo_, false)
		SetActive(arg_38_0.btn_DlcGo_, false)
	end

	SetActive(arg_38_0.timeSwitchBtn_.gameObject, var_38_0)
	SetActive(arg_38_0.weatherSwitchBtn_.gameObject, var_38_1)
end

function var_0_0.MuteAudio(arg_39_0)
	HeroTools.StopTalk()

	if arg_39_0.multiTouchTimer_ ~= nil then
		arg_39_0.multiTouchTimer_:Stop()

		arg_39_0.multiTouchTimer_ = nil
	end

	arg_39_0.subtitleBubble:SetVisible(false)

	arg_39_0.talking_ = false
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
			local var_43_1 = HomeSceneSettingData:GetCurScene()
			local var_43_2 = HomeSceneSettingCfg[var_43_1]
			local var_43_3 = var_43_2.scene_setting
			local var_43_4 = var_43_2.default_music

			if var_43_0.home_scene_scene_bgm == 0 or var_43_4 == 0 then
				-- block empty
			else
				if var_43_0.home_scene_scene_bgm == 1 and var_43_4 ~= 0 and var_43_0.home_scene_scene_bgm == 1 and table.indexof(var_43_3, HomeSceneSettingConst.SETTING.SCENE_BGM) then
					IllustratedAction.QuerySetBgm(var_43_4)
				end

				PlayGameSetBGM()
			end

			manager.gc:Collect()
			Resources.UnloadUnusedAssets()
		end)
	end)
end

function var_0_0.SetCamera(arg_44_0)
	local var_44_0 = HomeSceneSettingData:GetCurScene()
	local var_44_1 = "home_" .. var_44_0

	if CameraCfg[var_44_1] then
		manager.ui:SetMainCamera(var_44_1)
	else
		manager.ui:SetMainCamera("home")
	end
end

function var_0_0.CheckIsNeedPlayShowingAni(arg_45_0)
	local var_45_0 = false

	if arg_45_0.params_.changePoster then
		arg_45_0.params_.changePoster = nil

		if not arg_45_0.assistantVoiceTime_ or Time.realtimeSinceStartup - arg_45_0.assistantVoiceTime_ >= HeroConst.SET_ASSISTANT_VOICE_CD then
			arg_45_0.assistantVoiceTime_ = Time.realtimeSinceStartup

			manager.posterGirl:DoShowing()

			local var_45_1 = true
		end
	end
end

function var_0_0.CheckHomeSceneInteration(arg_46_0)
	manager.windowBar:ClearWhereTag()
	arg_46_0:SetCamera()

	arg_46_0.isHide_ = false
	arg_46_0.userData_ = PlayerData:GetPlayerInfo()
	arg_46_0.skinId_ = PlayerData:GetPosterGirlHeroSkinId()
	arg_46_0.posterGirl_ = SkinCfg[arg_46_0.skinId_].hero

	arg_46_0:RefreshPureModeTime()
	HeroAction.SelectSkinWithCallback(arg_46_0.posterGirl_, arg_46_0.skinId_, function()
		return
	end)

	if CustomCenterTools.IsRandomHero() and PlayerData:GetRandomHeroMode() == HomeSceneSettingConst.RANDOM_MODE.EACH_DAY then
		saveData("RandomData", "LastId_HERO", PlayerData:GetRandomHero())
	end

	if CustomCenterTools.IsRandomScene() and HomeSceneSettingData:GetRandomMode() == HomeSceneSettingConst.RANDOM_MODE.EACH_DAY then
		saveData("RandomData", "LastId_SCENE", HomeSceneSettingData:GetRandomScene())
	end

	local var_46_0 = HomeSceneSettingData:GetCurScene()

	PlayerAction.SaveHeroSkinIDAndSceneID(arg_46_0.skinId_, var_46_0)

	if not manager.story:IsPlay() then
		manager.posterGirl:SetViewTag(PosterGirlConst.ViewTag.home)
		manager.posterGirl:InitTouchHelp(arg_46_0.mutiTouchHelper_)
	end

	if not manager.guide:IsPlaying() and manager.posterGirl:CheckDebut() then
		arg_46_0.wait_posetr_debut = true

		PlayerData:SetPosterGirlDebut(true)
		manager.windowBar:HideBar()
		arg_46_0.sceneCon_:SetSelectedState("off")
		arg_46_0:HideSceneMenuPanel(true)
		arg_46_0.changedlcCon_:SetSelectedState("hide")
	else
		arg_46_0.sceneCon_:SetSelectedState("on")
		arg_46_0:OnEnterFunc()
		arg_46_0:CheckIsNeedPlayShowingAni()
	end

	manager.loadScene:SetHomeSceneSoundEffect()

	local var_46_1 = PlayerData:GetPlayAssistantVoice()

	if var_46_1 and var_46_1[1] == arg_46_0.posterGirl_ and not PlayerData:GetPosterGirlDebut() then
		if var_46_1[2] then
			HeroTools.PlayVoice(arg_46_0.posterGirl_, "cloth")
		else
			manager.posterGirl:DoShowing()
		end
	end

	PlayerData:SetPlayAssistantVoice()
end

function var_0_0.OnHomeDebutOver(arg_48_0)
	if arg_48_0.wait_posetr_debut then
		arg_48_0:OnEnterFunc()
		arg_48_0:OnTopFunc()
	end

	arg_48_0.sceneCon_:SetSelectedState("on")
	arg_48_0:HideSceneMenuPanel(false)

	arg_48_0.wait_posetr_debut = false

	PlayerData:SetPosterGirlDebut(false)
end

function var_0_0.HideSceneMenuPanel(arg_49_0, arg_49_1)
	if arg_49_0:IsOpenRoute("menuPop") then
		manager.notify:Invoke(HOME_HIDE_MENU_POP, arg_49_1)
	end
end

function var_0_0.PlayHeroGreeting(arg_50_0)
	manager.posterGirl:DoGreeting()
end

function var_0_0.DelayToPlayMultiTouchInteraction(arg_51_0)
	arg_51_0.clickCount_ = arg_51_0.clickCount_ + 1

	if arg_51_0.multiTouchTimer_ == nil then
		arg_51_0.multiTouchTimer_ = Timer.New(function()
			if arg_51_0.multiTouchTimer_ then
				arg_51_0.multiTouchTimer_:Stop()

				arg_51_0.multiTouchTimer_ = nil
			end

			if manager.posterGirl:GetMiniGameState() then
				return
			end

			local var_52_0 = HomeSceneSettingData:GetCurScene()

			if arg_51_0.clickCount_ >= 3 then
				SDKTools.SendMessageToSDK("poster_touch", {
					touch_times = 3,
					position = 0,
					hero_id = arg_51_0.skinId_,
					scene_id = var_52_0
				})
				manager.posterGirl:DoQuickTouch()
			else
				SDKTools.SendMessageToSDK("poster_touch", {
					touch_times = 1,
					position = 0,
					hero_id = arg_51_0.skinId_,
					scene_id = var_52_0
				})
				manager.posterGirl:DoTouch()
			end

			arg_51_0.clickCount_ = 0
		end, 0.5, 1)

		arg_51_0.multiTouchTimer_:Start()
	end
end

function var_0_0.ClearHomePosterTalk(arg_53_0)
	arg_53_0.talking_ = false

	arg_53_0.subtitleBubble:Clear()
end

function var_0_0.OnHomePosterTalk(arg_54_0, arg_54_1, arg_54_2, arg_54_3)
	local var_54_0 = HeroVoiceDescCfg.GetConfig(arg_54_1, arg_54_2)

	if var_54_0 then
		arg_54_0.talking_ = true

		local var_54_1 = false

		if var_54_0.hide_word == 1 or var_54_0.content == "" then
			var_54_1 = true
		end

		if not isNil(arg_54_0.talkBubbleGo_) then
			var_54_1 = var_54_1 or arg_54_0:RefreshTalkBubbleHide()
		end

		if var_54_1 then
			arg_54_0.talking_ = false

			arg_54_0.subtitleBubble:Clear()
		else
			arg_54_0.talking_ = true

			arg_54_0.subtitleBubble:SetBgStyleBySkin(arg_54_1)
			arg_54_0.subtitleBubble:StartBubble(var_54_0.content, arg_54_3 / 1000, arg_54_0.clearTalkHandler)
		end
	end
end

function var_0_0.OnHomeBtnVisible(arg_55_0, arg_55_1)
	SetActive(arg_55_0.panelGo_, arg_55_1)

	arg_55_1 = arg_55_1 and manager.posterGirl.actor:GetViewCnt() > 1

	arg_55_0.changedlcCon_:SetSelectedState(arg_55_1 and "show" or "hide")

	if arg_55_1 then
		arg_55_0:UpdatePosterGirlBtn()
	end
end

function var_0_0.ClearHeroFilter(arg_56_0)
	HeroData:SetupHeroMainOpenStatus(false)
	CommonFilterData:ClearFilter(Filter_Root_Define.Hero_Filter_List.filter_id)
end

function var_0_0.UpdatePosterGirlBtn(arg_57_0)
	local var_57_0 = SettingData:GetGameSettingData().home_scene_dlc_btn == 0
	local var_57_1 = PosterGirlTools.CanInterruptCurAni()

	if not var_57_0 and var_57_1 and manager.posterGirl:CanSwipeToLeft() then
		arg_57_0.btn_zuoCon_:SetSelectedState("enable")
	else
		arg_57_0.btn_zuoCon_:SetSelectedState("disable")
	end

	if not var_57_0 and var_57_1 and manager.posterGirl:CanSwipeToRight() then
		arg_57_0.btn_youCon_:SetSelectedState("enable")
	else
		arg_57_0.btn_youCon_:SetSelectedState("disable")
	end
end

function var_0_0.OnBehind(arg_58_0)
	arg_58_0.isBehind_ = true
	arg_58_0.longTimeNoOpCheckCom_.enabled = false

	arg_58_0:StopViewHideTimer()
	arg_58_0:SetPureModeBtnActive(false, false)
end

function var_0_0.SetPureModeShow(arg_59_0)
	if manager.guide:IsPlaying() or manager.guide:IsPlayingWeaking() or not arg_59_0.isDoActionEnd_ or not arg_59_0:IsTop() then
		return
	end

	arg_59_0:StopAllTimers()
	arg_59_0:ClearHomePosterTalk()
	arg_59_0:SetPureMode(false)
	arg_59_0:SetPureModeBtnActive(false, true)

	local var_59_0 = arg_59_0.isPureMode_ and PureModeConst.EnterMode.mode3 or PureModeConst.EnterMode.mode2

	JumpTools.OpenPageByJump("PureModeView", {
		enterType = var_59_0
	})

	if arg_59_0.isPureMode_ then
		arg_59_0:RecordPureModeLog(false)
	end
end

function var_0_0.RefreshPureModeTime(arg_60_0)
	local var_60_0 = PlayerData:GetPureModeData().pureModeTimeIndex
	local var_60_1 = GameSetting.pure_mode_entry_time.value[var_60_0]

	if var_60_1 and var_60_1 > 0 then
		LuaForUtil.SetNoOperationTime(arg_60_0.panelGo_, var_60_1)
	end
end

function var_0_0.ExitPureMode(arg_61_0)
	arg_61_0:StartRefreshUITimer()
	arg_61_0:CheckActivite()
end

return var_0_0
