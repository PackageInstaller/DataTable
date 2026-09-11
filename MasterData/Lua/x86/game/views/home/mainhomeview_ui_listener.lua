local var_0_0 = partialClass("MainHomeView", ReduxView)
local var_0_1 = 0

function var_0_0:AddMiddlePanelUILisener()
	self:AddBtnListener(self.btn_changeChar, nil, function()
		OperationRecorder.RecordButtonTouch("poster_hero_change")
		self:SwitchPosterGirlPanel(false)
		self:Go("/changePoster", {
			lastView = "home"
		})
	end)
	self:AddBtnListener(self.btn_skin, nil, function()
		OperationRecorder.RecordButtonTouch("poster_skin")
		self:SwitchPosterGirlPanel(false)
		self:Go("/heroSkin", {
			heroID = self.posterGirl_
		})
	end)
	self:AddBtnListener(self.btn_giftBtn_, nil, function()
		OperationRecorder.RecordButtonTouch("poster_gift")
		self:SwitchPosterGirlPanel(false)
		self:Go("/heroArchive", {
			pageID = 3,
			heroID = self.posterGirl_
		})
	end)
	self:AddBtnListener(self.btn_infoBtn_, nil, function()
		OperationRecorder.RecordButtonTouch("poster_illustration")
		JumpTools.OpenPageByJump("gameHelpPro", {
			hideHomeBtn = 1,
			isPrefab = true,
			pages = (GameSetting.home_scene_interactive_describe or nil) and (GameSetting.home_scene_interactive_describe.value or {})
		})
	end)
	self:AddBtnListener(self.btn_DlcBtn_, nil, function()
		if Time.realtimeSinceStartup < var_0_1 + 1 then
			return
		end

		OperationRecorder.RecordButtonTouch("poster_dlc")

		var_0_1 = Time.realtimeSinceStartup

		HomeSceneSettingAction.ChangeSceneTab(self.skinId_)
	end)
	self:AddBtnListener(self.hideViewBtn_, nil, function()
		self:SetPureMode(false)

		self.isPureMode_ = true

		self:RecordPureModeLog(true, PureModeConst.EnterMode.mode1)

		self.params_.isPureMode = true
	end)
	self:AddBtnListener(self.showAniSkipBtn_, nil, function()
		manager.posterGirl:SkipDebut()
		HomeSceneSettingData:SetIsPlay(self.skinId_)
	end)
	self.bgmaskBtn_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.PointerDown, function(arg_9_0, arg_9_1)
		self:RecordOperation(self.bgmaskBtn_)
		self:OnClickBg(arg_9_1)
	end)
	self:SetListener(self.bgmaskBtn_)
	self:AddBtnListener(self.btn_arrow_hide2Btn_, nil, function()
		self:SetPureModeBtnActive(false, true)
		self:RecordPureModeLog(false)
		self:StopAllTimers()
		self.subtitleBubble:SetVisible(false)

		self.isPureMode_ = false

		JumpTools.OpenPageByJump("PureModeView", {
			enterType = PureModeConst.EnterMode.mode4
		})
	end)
end

function var_0_0:AddRightPanelUIListener()
	self:AddBtnListenerScale(self.btnPreviewTask_, nil, function()
		JumpTools.OpenPageByJump("previewTaskMain")
	end)
	self:AddBtnListenerScale(self.btn_task, nil, function()
		OperationRecorder.RecordButtonTouch("homepage_task")
		JumpTools.GoToSystem("/task", {
			initNormalizedPosition = true,
			taskIndex = TaskConst.TASK_TYPE.DAILY
		}, ViewConst.SYSTEM_ID.TASK_PLOT)
	end)
	self:AddBtnListenerScale(self.btn_mail, nil, function()
		OperationRecorder.RecordButtonTouch("homepage_mail")
		MailData.GetMailListFromServer((handler(self, function()
			JumpTools.GoToSystem("/mailBox")
		end)))
		MailData.ClickMailBtn(manager.time:GetServerTime())
	end)
	self:AddBtnListenerScale(self.btn_menu, nil, function()
		OperationRecorder.RecordButtonTouch("homepage_function")
		JumpTools.OpenPageByJump("menuPop")
	end)
	self:AddBtnListener(self.btn_combat, nil, function()
		local var_17_0 = getData("SDK", "btn_homepage_combat")

		if var_17_0 == nil or not TimeMgr:IsSameDay(var_17_0, (TimeMgr:GetServerTime())) then
			saveData("SDK", "btn_homepage_combat", TimeMgr:GetServerTime())
			OperationRecorder.RecordButtonTouch("homepage_combat")
		end

		JumpTools.GoToSystem("/chapterMap", {
			chapterToggle = BattleConst.TOGGLE.MAIN
		}, ViewConst.SYSTEM_ID.BATTLE)
	end)
	self:AddBtnListenerScale(self.btn_goddess, nil, function()
		OperationRecorder.RecordButtonTouch("homepage_hero")
		HeroData:SetupHeroMainOpenStatus(true)
		JumpTools.GoToSystem("/newHero", {
			isEnter = true,
			type = HeroConst.HERO_DATA_TYPE.DEFAULT
		}, ViewConst.SYSTEM_ID.HERO)
	end)
	self:AddBtnListenerScale(self.btn_shop, nil, function()
		OperationRecorder.RecordButtonTouch("homepage_shop")
		JumpTools.GoToSystem("/rechargeEnter", nil, ViewConst.SYSTEM_ID.SHOP_ENTER)
	end)
	self:AddBtnListenerScale(self.btn_backPake, nil, function()
		OperationRecorder.RecordButtonTouch("homepage_warehouse")
		JumpTools.GoToSystem("/bag", nil, ViewConst.SYSTEM_ID.BAG)
	end)
	self:AddBtnListenerScale(self.btnGuild_, nil, function()
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
	self:AddBtnListenerScale(self.btn_dorm_, nil, function()
		local var_23_0 = JumpTools.IsSystemLocked(ViewConst.SYSTEM_ID.DORM)

		if var_23_0 then
			ShowTips(JumpTools.GetSystemLockedTip(ViewConst.SYSTEM_ID.DORM, var_23_0))

			return nil
		end

		BackHomeDataManager:EnterBackHomeSystem(function()
			manager.posterGirl:SetViewTag(PosterGirlConst.ViewTag.null)

			if GameDisplayCfg.dorm_begin_story.value[1] and not manager.story:IsStoryPlayed(GameDisplayCfg.dorm_begin_story.value[1]) then
				manager.story:StartStoryById(GameDisplayCfg.dorm_begin_story.value[1], function(arg_25_0)
					JumpTools.OpenPageByJump("/dormChooseRoomView")
				end)
			else
				JumpTools.OpenPageByJump("/dormChooseRoomView")
			end

			OperationRecorder.RecordButtonTouch("homepage_backhome")
		end)
	end)
	self:AddBtnListenerScale(self.btn_draw, nil, function()
		OperationRecorder.RecordButtonTouch("homepage_draw")
		JumpTools.GoToSystem("/draw", {
			isFirst = true
		}, ViewConst.SYSTEM_ID.DRAW)
	end)
	self:AddBtnListenerScale(self.btn_refund, nil, function()
		OperationAction.OpenOperationUrl("REFUND_URL", nil, nil, OperationConst.SCREEN_ORIENTATION.FORCE_VERTICAL)
	end)
end

function var_0_0:AddLeftPanelUIListener()
	self:AddBtnListener(self.btn_message, nil, function()
		OperationRecorder.RecordButtonTouch("homepage_userinfo")
		OpenPageUntilLoaded("/userinfo", {
			page = "info"
		}, ViewConst.SYSTEM_ID.PLAYER_INFO)
	end)
	self:AddBtnListener(self.btn_callback, nil, function()
		ActivityRecallAction.RequestOpenRecallView(ActivityConst.RECALL_MAIN, function()
			JumpTools.GoToSystem("/recallMain", nil)
		end)
	end)
	self:AddBtnListenerScale(self.btn_regression, nil, function()
		OperationRecorder.RecordButtonTouch("homepage_regression")
		RegressionActionNew.CheckRegressionStory({
			isEnter = true,
			Inited = false
		})
	end)
	self:AddBtnListenerScale(self.buttonNewbie_, nil, function()
		OperationRecorder.RecordButtonTouch("homepage_new_task")
		ActivityNewbieTools.GotoMainView()
	end)
	self:AddBtnListenerScale(self.btn_newbie_task, nil, function()
		OperationRecorder.RecordButtonTouch("homepage_study")
		ActivityNewbieTools.GotoNoobAdvanceTaskView()
	end)
	self:AddBtnListenerScale(self.advanceTestBtn_, nil, function()
		JumpTools.OpenPageByJump("advanceTestEntrace")
	end)
	self:AddBtnListenerScale(self.advanceMonsterTestBtn_, nil, function()
		JumpTools.GoToSystem("/advanceMonsterTestMainView")
	end)
	self:AddBtnListenerScale(self.momoTalkBtn_, nil, function()
		JumpTools.OpenPageByJump("momoTalkMainView", nil, ViewConst.SYSTEM_ID.MOMO_TALK)
	end)
	self:AddBtnListenerScale(self.btn_passport, nil, function()
		OperationRecorder.RecordButtonTouch("homepage_bp")

		if not PassportData:IsOpen() then
			ShowTips("NOT_IN_OPEN_TIME")

			return
		end

		JumpTools.OpenPageByJump("/passportMain", nil, ViewConst.SYSTEM_ID.PASSPORT_MAIN)
	end)
	self:AddBtnListenerScale(self.btn_gm, nil, function()
		JumpTools.GoToSystem("gm")
	end)
	self:AddBtnListenerScale(self.btn_heroInteractionGM, nil, function()
		JumpTools.GoToSystem("heroInteractionGM", {
			skinId = self.skinId_
		})
	end)
	self:AddBtnListener(self.btn_story, nil, function()
		JumpTools.GoToSystem("/storylist")
	end)
	self:AddBtnListenerScale(self.btn_newServer, nil, function()
		JumpTools.OpenPageByJump("/activityNewServerMain")
	end)
	self:AddBtnListenerScale(self.btn_chat, nil, function()
		OperationRecorder.RecordButtonTouch("homepage_chat")
		JumpTools.GoToSystem("/chat", {
			chatToggleID = ChatConst.CHAT_CHANNEL_WORLD
		}, ViewConst.SYSTEM_ID.CHAT)
	end)
end

function var_0_0:AddUIListenersHome()
	function self.mutiTouchHelper_.OnIdle()
		manager.posterGirl:TouchHelpIdle()
	end

	function self.mutiTouchHelper_.OnSingleDrag(arg_46_0, arg_46_1)
		manager.posterGirl:TouchHelpSingleDrag(arg_46_0, arg_46_1)
	end

	function self.mutiTouchHelper_.OnMutiDrag(arg_47_0)
		manager.posterGirl:TouchHelpMutiDrag(arg_47_0)
	end

	function self.mutiTouchHelper_.EndDrag()
		manager.posterGirl:EndDrag()
	end

	function self.mutiTouchHelper_.OnClick(arg_49_0, arg_49_1)
		self:OnTouchInteract(arg_49_1)
	end

	self:AddBtnListener(self.timeSwitchBtn_, nil, function()
		if Time.realtimeSinceStartup < var_0_1 + 1 then
			return
		end

		var_0_1 = Time.realtimeSinceStartup

		HomeSceneSettingAction.ChangeTimeScene()

		self.updateBgm_ = true

		HomeSceneSettingData:SetIsSwitchTime(true)
		HomeSceneSettingData:SetIsTimeScene(false)
		OperationRecorder.RecordButtonTouch("poster_scene")
	end)
	self:AddBtnListener(self.weatherSwitchBtn_, nil, function()
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
	self:AddBtnListener(self.customCenterBtn_, nil, function()
		PlayerData:SetIsDeskMode(false)
		JumpTools.OpenPageByJump("/customCenter")
	end)
	self:AddBtnListener(self.btn_zuo01Btn_, nil, function()
		if not PosterGirlTools.CanInterruptCurAni() and not PosterGirlTools.IsLoopSwitch((HomeSceneSettingData:GetCurScene())) then
			return
		end

		manager.posterGirl:SwipeToLeft()
		manager.posterGirl:EndDrag()
		self:UpdatePosterGirlBtn()
	end)
	self:AddBtnListener(self.btn_youBtn_, nil, function()
		if not PosterGirlTools.CanInterruptCurAni() and not PosterGirlTools.IsLoopSwitch((HomeSceneSettingData:GetCurScene())) then
			return
		end

		manager.posterGirl:SwipeToRight()
		manager.posterGirl:EndDrag()
		self:UpdatePosterGirlBtn()
	end)
end
