local var_0_0 = partialClass("MainHomeView", ReduxView)
local var_0_1 = 0

function var_0_0.AddMiddlePanelUILisener(arg_1_0)
	arg_1_0:AddBtnListener(arg_1_0.btn_changeChar, nil, function()
		OperationRecorder.RecordButtonTouch("poster_hero_change")
		arg_1_0:SwitchPosterGirlPanel(false)
		arg_1_0:Go("/changePoster", {
			lastView = "home"
		})
	end)
	arg_1_0:AddBtnListener(arg_1_0.btn_skin, nil, function()
		OperationRecorder.RecordButtonTouch("poster_skin")
		arg_1_0:SwitchPosterGirlPanel(false)
		arg_1_0:Go("/heroSkin", {
			heroID = arg_1_0.posterGirl_
		})
	end)
	arg_1_0:AddBtnListener(arg_1_0.btn_giftBtn_, nil, function()
		OperationRecorder.RecordButtonTouch("poster_gift")
		arg_1_0:SwitchPosterGirlPanel(false)
		arg_1_0:Go("/heroArchive", {
			pageID = 3,
			heroID = arg_1_0.posterGirl_
		})
	end)
	arg_1_0:AddBtnListener(arg_1_0.btn_infoBtn_, nil, function()
		OperationRecorder.RecordButtonTouch("poster_illustration")

		local var_5_0 = GameSetting.home_scene_interactive_describe and GameSetting.home_scene_interactive_describe.value or {}

		JumpTools.OpenPageByJump("gameHelpPro", {
			hideHomeBtn = 1,
			isPrefab = true,
			pages = var_5_0
		})
	end)
	arg_1_0:AddBtnListener(arg_1_0.btn_DlcBtn_, nil, function()
		if Time.realtimeSinceStartup < var_0_1 + 1 then
			return
		end

		OperationRecorder.RecordButtonTouch("poster_dlc")

		var_0_1 = Time.realtimeSinceStartup

		HomeSceneSettingAction.ChangeSceneTab(arg_1_0.skinId_)
	end)
	arg_1_0:AddBtnListener(arg_1_0.hideViewBtn_, nil, function()
		arg_1_0:SetPureMode(false)

		arg_1_0.isPureMode_ = true

		arg_1_0:RecordPureModeLog(true, PureModeConst.EnterMode.mode1)

		arg_1_0.params_.isPureMode = true
	end)
	arg_1_0:AddBtnListener(arg_1_0.showAniSkipBtn_, nil, function()
		manager.posterGirl:SkipDebut()
		HomeSceneSettingData:SetIsPlay(arg_1_0.skinId_)
	end)
	arg_1_0.bgmaskBtn_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.PointerDown, function(arg_9_0, arg_9_1)
		arg_1_0:RecordOperation(arg_1_0.bgmaskBtn_)
		arg_1_0:OnClickBg(arg_9_1)
	end)
	arg_1_0:SetListener(arg_1_0.bgmaskBtn_)
	arg_1_0:AddBtnListener(arg_1_0.btn_arrow_hide2Btn_, nil, function()
		arg_1_0:SetPureModeBtnActive(false, true)
		arg_1_0:RecordPureModeLog(false)
		arg_1_0:StopAllTimers()
		arg_1_0.subtitleBubble:SetVisible(false)

		arg_1_0.isPureMode_ = false

		JumpTools.OpenPageByJump("PureModeView", {
			enterType = PureModeConst.EnterMode.mode4
		})
	end)
end

function var_0_0.AddRightPanelUIListener(arg_11_0)
	arg_11_0:AddBtnListenerScale(arg_11_0.btnPreviewTask_, nil, function()
		JumpTools.OpenPageByJump("previewTaskMain")
	end)
	arg_11_0:AddBtnListenerScale(arg_11_0.btn_task, nil, function()
		OperationRecorder.RecordButtonTouch("homepage_task")
		JumpTools.GoToSystem("/task", {
			initNormalizedPosition = true,
			taskIndex = TaskConst.TASK_TYPE.DAILY
		}, ViewConst.SYSTEM_ID.TASK_PLOT)
	end)
	arg_11_0:AddBtnListenerScale(arg_11_0.btn_mail, nil, function()
		OperationRecorder.RecordButtonTouch("homepage_mail")

		local var_14_0 = handler(arg_11_0, function()
			JumpTools.GoToSystem("/mailBox")
		end)

		MailData.GetMailListFromServer(var_14_0)
		MailData.ClickMailBtn(manager.time:GetServerTime())
	end)
	arg_11_0:AddBtnListenerScale(arg_11_0.btn_menu, nil, function()
		OperationRecorder.RecordButtonTouch("homepage_function")
		JumpTools.OpenPageByJump("menuPop")
	end)
	arg_11_0:AddBtnListener(arg_11_0.btn_combat, nil, function()
		local var_17_0 = getData("SDK", "btn_homepage_combat")
		local var_17_1 = TimeMgr:GetServerTime()

		if var_17_0 == nil or not TimeMgr:IsSameDay(var_17_0, var_17_1) then
			saveData("SDK", "btn_homepage_combat", TimeMgr:GetServerTime())
			OperationRecorder.RecordButtonTouch("homepage_combat")
		end

		JumpTools.GoToSystem("/chapterMap", {
			chapterToggle = BattleConst.TOGGLE.MAIN
		}, ViewConst.SYSTEM_ID.BATTLE)
	end)
	arg_11_0:AddBtnListenerScale(arg_11_0.btn_goddess, nil, function()
		OperationRecorder.RecordButtonTouch("homepage_hero")
		HeroData:SetupHeroMainOpenStatus(true)
		JumpTools.GoToSystem("/newHero", {
			isEnter = true,
			type = HeroConst.HERO_DATA_TYPE.DEFAULT
		}, ViewConst.SYSTEM_ID.HERO)
	end)
	arg_11_0:AddBtnListenerScale(arg_11_0.btn_shop, nil, function()
		OperationRecorder.RecordButtonTouch("homepage_shop")
		JumpTools.GoToSystem("/rechargeEnter", nil, ViewConst.SYSTEM_ID.SHOP_ENTER)
	end)
	arg_11_0:AddBtnListenerScale(arg_11_0.btn_backPake, nil, function()
		OperationRecorder.RecordButtonTouch("homepage_warehouse")
		JumpTools.GoToSystem("/bag", nil, ViewConst.SYSTEM_ID.BAG)
	end)
	arg_11_0:AddBtnListenerScale(arg_11_0.btnGuild_, nil, function()
		if JumpTools.IsSystemOperationStoped(ViewConst.SYSTEM_ID.GUILD) then
			ShowTips("ERROR_FUNCTION_STOP")

			return nil
		end

		local var_21_0 = JumpTools.IsSystemLocked(ViewConst.SYSTEM_ID.GUILD)

		if var_21_0 then
			ShowTips(JumpTools.GetSystemLockedTip(ViewConst.SYSTEM_ID.GUILD, var_21_0))

			return
		end

		if GuildData:GetGuildInfo().id == nil then
			GuildAction.EnterGuild()
		else
			GuildAction.RequiredGuildInfo(function(arg_22_0)
				if isSuccess(arg_22_0.result) then
					JumpTools.OpenPageByJump("/guildEntrace/guildMain")
				else
					ShowTips(arg_22_0.result)
				end
			end)
		end
	end)
	arg_11_0:AddBtnListenerScale(arg_11_0.btn_dorm_, nil, function()
		local var_23_0 = JumpTools.IsSystemLocked(ViewConst.SYSTEM_ID.DORM)

		if var_23_0 then
			ShowTips(JumpTools.GetSystemLockedTip(ViewConst.SYSTEM_ID.DORM, var_23_0))

			return nil
		end

		local function var_23_1()
			manager.posterGirl:SetViewTag(PosterGirlConst.ViewTag.null)

			local var_24_0 = GameDisplayCfg.dorm_begin_story.value[1]

			if var_24_0 and not manager.story:IsStoryPlayed(var_24_0) then
				manager.story:StartStoryById(var_24_0, function(arg_25_0)
					JumpTools.OpenPageByJump("/dormChooseRoomView")
				end)
			else
				JumpTools.OpenPageByJump("/dormChooseRoomView")
			end

			OperationRecorder.RecordButtonTouch("homepage_backhome")
		end

		BackHomeDataManager:EnterBackHomeSystem(var_23_1)
	end)
	arg_11_0:AddBtnListenerScale(arg_11_0.btn_draw, nil, function()
		OperationRecorder.RecordButtonTouch("homepage_draw")
		JumpTools.GoToSystem("/draw", {
			isFirst = true
		}, ViewConst.SYSTEM_ID.DRAW)
	end)
	arg_11_0:AddBtnListenerScale(arg_11_0.btn_refund, nil, function()
		OperationAction.OpenOperationUrl("REFUND_URL", nil, nil, OperationConst.SCREEN_ORIENTATION.FORCE_VERTICAL)
	end)
end

function var_0_0.AddLeftPanelUIListener(arg_28_0)
	arg_28_0:AddBtnListener(arg_28_0.btn_message, nil, function()
		OperationRecorder.RecordButtonTouch("homepage_userinfo")
		OpenPageUntilLoaded("/userinfo", {
			page = "info"
		}, ViewConst.SYSTEM_ID.PLAYER_INFO)
	end)
	arg_28_0:AddBtnListener(arg_28_0.btn_callback, nil, function()
		local var_30_0 = ActivityConst.RECALL_MAIN

		ActivityRecallAction.RequestOpenRecallView(var_30_0, function()
			JumpTools.GoToSystem("/recallMain", nil)
		end)
	end)
	arg_28_0:AddBtnListenerScale(arg_28_0.btn_regression, nil, function()
		OperationRecorder.RecordButtonTouch("homepage_regression")
		RegressionActionNew.CheckRegressionStory({
			isEnter = true,
			Inited = false
		})
	end)
	arg_28_0:AddBtnListenerScale(arg_28_0.buttonNewbie_, nil, function()
		OperationRecorder.RecordButtonTouch("homepage_new_task")
		ActivityNewbieTools.GotoMainView()
	end)
	arg_28_0:AddBtnListenerScale(arg_28_0.btn_newbie_task, nil, function()
		OperationRecorder.RecordButtonTouch("homepage_study")
		ActivityNewbieTools.GotoNoobAdvanceTaskView()
	end)
	arg_28_0:AddBtnListenerScale(arg_28_0.advanceTestBtn_, nil, function()
		JumpTools.OpenPageByJump("advanceTestEntrace")
	end)
	arg_28_0:AddBtnListenerScale(arg_28_0.advanceMonsterTestBtn_, nil, function()
		JumpTools.GoToSystem("/advanceMonsterTestMainView")
	end)
	arg_28_0:AddBtnListenerScale(arg_28_0.momoTalkBtn_, nil, function()
		JumpTools.OpenPageByJump("momoTalkMainView", nil, ViewConst.SYSTEM_ID.MOMO_TALK)
	end)
	arg_28_0:AddBtnListenerScale(arg_28_0.btn_passport, nil, function()
		OperationRecorder.RecordButtonTouch("homepage_bp")

		if not PassportData:IsOpen() then
			ShowTips("NOT_IN_OPEN_TIME")

			return
		end

		JumpTools.OpenPageByJump("/passportMain", nil, ViewConst.SYSTEM_ID.PASSPORT_MAIN)
	end)
	arg_28_0:AddBtnListenerScale(arg_28_0.btn_gm, nil, function()
		JumpTools.GoToSystem("gm")
	end)
	arg_28_0:AddBtnListenerScale(arg_28_0.btn_heroInteractionGM, nil, function()
		JumpTools.GoToSystem("heroInteractionGM", {
			skinId = arg_28_0.skinId_
		})
	end)
	arg_28_0:AddBtnListener(arg_28_0.btn_story, nil, function()
		JumpTools.GoToSystem("/storylist")
	end)
	arg_28_0:AddBtnListenerScale(arg_28_0.btn_newServer, nil, function()
		JumpTools.OpenPageByJump("/activityNewServerMain")
	end)
	arg_28_0:AddBtnListenerScale(arg_28_0.btn_chat, nil, function()
		OperationRecorder.RecordButtonTouch("homepage_chat")
		JumpTools.GoToSystem("/chat", {
			chatToggleID = ChatConst.CHAT_CHANNEL_WORLD
		}, ViewConst.SYSTEM_ID.CHAT)
	end)
end

function var_0_0.AddUIListenersHome(arg_44_0)
	function arg_44_0.mutiTouchHelper_.OnIdle()
		manager.posterGirl:TouchHelpIdle()
	end

	function arg_44_0.mutiTouchHelper_.OnSingleDrag(arg_46_0, arg_46_1)
		manager.posterGirl:TouchHelpSingleDrag(arg_46_0, arg_46_1)
	end

	function arg_44_0.mutiTouchHelper_.OnMutiDrag(arg_47_0)
		manager.posterGirl:TouchHelpMutiDrag(arg_47_0)
	end

	function arg_44_0.mutiTouchHelper_.EndDrag()
		manager.posterGirl:EndDrag()
	end

	function arg_44_0.mutiTouchHelper_.OnClick(arg_49_0, arg_49_1)
		arg_44_0:OnTouchInteract(arg_49_1)
	end

	arg_44_0:AddBtnListener(arg_44_0.timeSwitchBtn_, nil, function()
		if Time.realtimeSinceStartup < var_0_1 + 1 then
			return
		end

		var_0_1 = Time.realtimeSinceStartup

		HomeSceneSettingAction.ChangeTimeScene()

		arg_44_0.updateBgm_ = true

		HomeSceneSettingData:SetIsSwitchTime(true)
		HomeSceneSettingData:SetIsTimeScene(false)
		OperationRecorder.RecordButtonTouch("poster_scene")
	end)
	arg_44_0:AddBtnListener(arg_44_0.weatherSwitchBtn_, nil, function()
		if Time.realtimeSinceStartup < var_0_1 + 1 then
			return
		end

		var_0_1 = Time.realtimeSinceStartup

		if manager.loadScene:GetCurWeather() == SceneConst.HOME_SCENE_WEATHER.SUNNY then
			manager.loadScene:SetSceneWeather(SceneConst.HOME_SCENE_WEATHER.RAINY)
		else
			manager.loadScene:SetSceneWeather(SceneConst.HOME_SCENE_WEATHER.SUNNY)
		end
	end)
	arg_44_0:AddBtnListener(arg_44_0.customCenterBtn_, nil, function()
		PlayerData:SetIsDeskMode(false)
		JumpTools.OpenPageByJump("/customCenter")
	end)
	arg_44_0:AddBtnListener(arg_44_0.btn_zuo01Btn_, nil, function()
		local var_53_0 = HomeSceneSettingData:GetCurScene()

		if not PosterGirlTools.CanInterruptCurAni() and not PosterGirlTools.IsLoopSwitch(var_53_0) then
			return
		end

		manager.posterGirl:SwipeToLeft()
		manager.posterGirl:EndDrag()
		arg_44_0:UpdatePosterGirlBtn()
	end)
	arg_44_0:AddBtnListener(arg_44_0.btn_youBtn_, nil, function()
		local var_54_0 = HomeSceneSettingData:GetCurScene()

		if not PosterGirlTools.CanInterruptCurAni() and not PosterGirlTools.IsLoopSwitch(var_54_0) then
			return
		end

		manager.posterGirl:SwipeToRight()
		manager.posterGirl:EndDrag()
		arg_44_0:UpdatePosterGirlBtn()
	end)
end
