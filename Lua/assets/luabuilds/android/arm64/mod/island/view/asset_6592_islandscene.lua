local IslandScene = class("IslandScene", import(".base.IslandBaseScene"))

IslandScene.ON_INVENTORY_FILTER = "IslandScene:ON_INVENTORY_FILTER"
IslandScene.ON_CHECK_ORDER_EXP_AWARD = "IslandScene:ON_CHECK_ORDER_EXP_AWARD"

function IslandScene:getUIName()
	return "IslandUI"
end

function IslandScene:preload(arg_2_1)
	seriesAsync({
		function(arg_3_0)
			IslandScene.super.preload(self, arg_3_0)

			return
		end,
		function(arg_4_0)
			IslandTaskActhelper.TriggerActTasks(arg_4_0)

			return
		end,
		function(arg_5_0)
			IslandTaskHelper.FixTaskLinksStory(arg_5_0)

			return
		end
	}, function()
		arg_2_1()

		return
	end)

	return
end

function IslandScene:loadingQueue()
	return function(arg_8_0)
		pg.SceneAnimMgr.GetInstance():CommonSceneChange("Dorm3DLoading", function(arg_9_0)
			return arg_8_0(arg_9_0)
		end)

		return
	end
end

function IslandScene:GetIsland()
	return getProxy(IslandProxy):GetIsland()
end

function IslandScene:init()
	self.visitorBtn = self._tf:Find("top/visitor")
	self.levelPanel = IslandLevelPanel.New(self._tf, self.event)
	self.taskTrackPanel = Island3dTaskTrackPanel.New(self._tf:Find("track_container"), self.event)
	self.awardDisplayPanel = IslandAwardDisplayInMainPanel.New(self._tf, self.event, setmetatable({
		needAdapt = true
	}, {
		__index = self.contextData
	}))
	self.btnContainer = IslandMainBtnContainer.New(self._tf:Find("top/btn_container"), self.event)

	return
end

function IslandScene:didEnter()
	onButton(self, self.visitorBtn, function()
		self:OpenPage(IslandVisitorPage)

		return
	end, SFX_PANEL)
	self:SetUp()

	self.contextData.resumeCallback = nil

	existCall(self.contextData.resumeCallback)

	return
end

function IslandScene:SetUp()
	seriesAsync({
		function(arg_15_0)
			self:SetDressUpIsEmpty(arg_15_0)

			return
		end
	}, function()
		self:StartCore()

		return
	end)

	return
end

function IslandScene:SetNameIfIsEmpty(arg_17_1)
	if not self:GetIsland():IsNew() then
		arg_17_1()

		return
	end

	local var_17_0 = IslandSetNamePage.New(self)

	var_17_0:ExecuteAction("Show", function()
		var_17_0:Destroy()
		arg_17_1()

		return
	end)

	return
end

function IslandScene:SetDressUpIsEmpty(arg_19_1)
	if not self:GetIsland():GetDressUpAgency():IsNew() then
		arg_19_1()

		return
	end

	self:OpenPage(IslandShipFirstDressupPage, arg_19_1)

	return
end

function IslandScene:AddListeners()
	self:AddListener(GAME.ISLAND_UPGRADE_DONE, self.OnUpgrade)
	self:AddListener(Island.EXP_ADD, self.OnExpChange)
	self:AddListener(GAME.ISLAND_SET_NAME_DONE, self.OnModifyName)
	self:AddListener(GAME.ISLAND_PROSPERITY_AWARD_DONE, self.OnGetProsperityAward)
	self:AddListener(IslandTaskAgency.TASK_ADDED, self.OnAddedTask)
	self:AddListener(IslandTaskAgency.TASK_UPDATED, self.OnUpdateTask)
	self:AddListener(IslandTaskAgency.TASK_REMOVED, self.OnRemoveTask)
	self:AddListener(IslandAchievementAgency.NEW_CAN_GET, self.OnNewAchievementCanGet)
	self:AddListener(GAME.ISLAND_FINISH_DELEGATION_DONE, self.OnFinishDelegation)
	self:AddListener(GAME.ISLAND_UNLOCK_TECH_DONE, self.OnUnlockTechnology)
	self:AddListener(IslandCharacterAgency.ADD_SHIP, self.OnAddShip)
	self:AddListener(IslandCharacterAgency.SHIP_LEVEL_UP, self.OnShipLevelUp)
	self:AddListener(IslandCharacterAgency.SHIP_GET_STATE, self.OnShipGetState)
	self:AddListener(IslandAblityAgency.UNLOCK_SYSTEM, self.OnUnlockSystem)
	self:AddListener(IslandVisitorAgency.PLAYER_ADD, self.OnVisitorNumChange)
	self:AddListener(IslandVisitorAgency.PLAYER_EXIT, self.OnVisitorNumChange)
	self:AddListener(ISLAND_EX_EVT.ENTER_EDIT_AGORA, self.OnAgoraEnterEditMode)
	self:AddListener(ISLAND_EX_EVT.EXIT_EDIT_AGORA, self.OnAgoraExitEditMode)
	self:AddListener(ISLAND_EX_EVT.TRIGGER_TASK, self.OnTriggerTask)
	self:AddListener(ISLAND_EX_EVT.SUBMIT_TASK, self.OnSubmitTask)
	self:AddListener(ISLAND_EX_EVT.ADD_TASK_PROGRESS, self.OnAddTaskProgress)
	self:AddListener(ISLAND_EX_EVT.PLAY_STORY, self.OnPlayStory)
	self:AddListener(ISLAND_EX_EVT.SWITCH_MAP, self.OnSwitchMap)
	self:AddListener(ISLAND_EX_EVT.SEEK_GAME_START, self.OnSeekGameStart)
	self:AddListener(ISLAND_EX_EVT.SEEK_GAME_END, self.OnSeekGameEnd)
	self:AddListener(ISLAND_EX_EVT.ENTER_FISH_POINT, self.OnEnterFishPoint)
	self:AddListener(ISLAND_EX_EVT.EXIT_FISH_POINT, self.OnExitFishPoint)
	self:AddListener(ISLAND_EX_EVT.APPROACH_OBJECT, self.OnApproachObject)
	self:AddListener(ISLAND_EX_EVT.PLAY_PERFORMANCE, self.OnPlayPerformance)
	self:AddListener(ISLAND_EX_EVT.SHOW_INTERACTION, self.OnShowInteraction)
	self:AddListener(ISLAND_EX_EVT.SWITCH_MAP_BY_POINT, self.OnSwitchMapByPoint)
	self:AddListener(ISLAND_EX_EVT.NAV_PATH, self.OnStartNavPath)
	self:AddListener(ISLAND_EX_EVT.NAV_PATH_DONE, self.OnNavPathDone)

	return
end

function IslandScene:RemoveListeners()
	self:RemoveListener(GAME.ISLAND_UPGRADE_DONE, self.OnUpgrade)
	self:RemoveListener(Island.EXP_ADD, self.OnExpChange)
	self:RemoveListener(GAME.ISLAND_SET_NAME_DONE, self.OnModifyName)
	self:RemoveListener(GAME.ISLAND_PROSPERITY_AWARD_DONE, self.OnGetProsperityAward)
	self:RemoveListener(IslandTaskAgency.TASK_ADDED, self.OnAddedTask)
	self:RemoveListener(IslandTaskAgency.TASK_UPDATED, self.OnUpdateTask)
	self:RemoveListener(IslandTaskAgency.TASK_REMOVED, self.OnRemoveTask)
	self:RemoveListener(IslandAchievementAgency.NEW_CAN_GET, self.OnNewAchievementCanGet)
	self:RemoveListener(GAME.ISLAND_FINISH_DELEGATION_DONE, self.OnFinishDelegation)
	self:RemoveListener(GAME.ISLAND_UNLOCK_TECH_DONE, self.OnUnlockTechnology)
	self:RemoveListener(IslandCharacterAgency.ADD_SHIP, self.OnAddShip)
	self:RemoveListener(IslandCharacterAgency.SHIP_LEVEL_UP, self.OnShipLevelUp)
	self:RemoveListener(IslandCharacterAgency.SHIP_GET_STATE, self.OnShipGetState)
	self:RemoveListener(IslandAblityAgency.UNLOCK_SYSTEM, self.OnUnlockSystem)
	self:RemoveListener(IslandVisitorAgency.PLAYER_ADD, self.OnVisitorNumChange)
	self:RemoveListener(IslandVisitorAgency.PLAYER_EXIT, self.OnVisitorNumChange)
	self:RemoveListener(ISLAND_EX_EVT.ENTER_EDIT_AGORA, self.OnAgoraEnterEditMode)
	self:RemoveListener(ISLAND_EX_EVT.EXIT_EDIT_AGORA, self.OnAgoraExitEditMode)
	self:RemoveListener(ISLAND_EX_EVT.TRIGGER_TASK, self.OnTriggerTask)
	self:RemoveListener(ISLAND_EX_EVT.SUBMIT_TASK, self.OnSubmitTask)
	self:RemoveListener(ISLAND_EX_EVT.ADD_TASK_PROGRESS, self.OnAddTaskProgress)
	self:RemoveListener(ISLAND_EX_EVT.PLAY_STORY, self.OnPlayStory)
	self:RemoveListener(ISLAND_EX_EVT.SWITCH_MAP, self.OnSwitchMap)
	self:RemoveListener(ISLAND_EX_EVT.SEEK_GAME_START, self.OnSeekGameStart)
	self:RemoveListener(ISLAND_EX_EVT.SEEK_GAME_END, self.OnSeekGameEnd)
	self:RemoveListener(ISLAND_EX_EVT.ENTER_FISH_POINT, self.OnEnterFishPoint)
	self:RemoveListener(ISLAND_EX_EVT.EXIT_FISH_POINT, self.OnExitFishPoint)
	self:RemoveListener(ISLAND_EX_EVT.APPROACH_OBJECT, self.OnApproachObject)
	self:RemoveListener(ISLAND_EX_EVT.PLAY_PERFORMANCE, self.OnPlayPerformance)
	self:RemoveListener(ISLAND_EX_EVT.SHOW_INTERACTION, self.OnShowInteraction)
	self:RemoveListener(ISLAND_EX_EVT.SWITCH_MAP_BY_POINT, self.OnSwitchMapByPoint)
	self:RemoveListener(ISLAND_EX_EVT.NAV_PATH, self.OnStartNavPath)
	self:RemoveListener(ISLAND_EX_EVT.NAV_PATH_DONE, self.OnNavPathDone)

	return
end

function IslandScene:OnEnterFishPoint()
	self:TryDisVisible()

	return
end

function IslandScene:OnExitFishPoint()
	self:TryVisible()

	return
end

function IslandScene:OnOpenAnimatonOpPage()
	self.btnContainer:ActiveOrDisactive(false)

	return
end

function IslandScene:OnCloseAnimatonOpPage()
	self.btnContainer:ActiveOrDisactive(true)

	return
end

function IslandScene:OnStartNavPath(arg_26_1)
	if arg_26_1 then
		pg.m02:sendNotification(GAME.STORY_UPDATE, {
			storyId = arg_26_1
		})
	end

	return
end

function IslandScene:OnNavPathDone(arg_27_1)
	self:GetIsland():DispatchEvent(IslandProxy.END_PATHFINDER)

	return
end

function IslandScene:OnExpChange()
	self.levelPanel:ExecuteAction("UpdateIslandInfo")

	return
end

function IslandScene:ShowExpAdd(arg_29_1, arg_29_2)
	self.levelPanel:ExecuteAction("ShowExpAdd", arg_29_1, arg_29_2)

	return
end

function IslandScene:OnSwitchMapByPoint(arg_30_1)
	self:GetIsland():SetLastExitPosition(arg_30_1.mapId, arg_30_1.position, arg_30_1.rotation)
	self:emit(IslandBaseMediator.SWITCH_MAP, arg_30_1.mapId)

	return
end

function IslandScene:OnShowInteraction(arg_31_1)
	IslandGuideChecker.CheckOnShowInteraction(arg_31_1)

	return
end

function IslandScene:OnPlayPerformance(arg_32_1)
	self:PlayPerformance(arg_32_1)

	return
end

function IslandScene:OnSeekGameStart()
	self:TryDisVisible()

	return
end

function IslandScene:OnSeekGameEnd()
	self:TryVisible()

	return
end

function IslandScene:OnSwitchMap(arg_35_1)
	self:emit(IslandBaseMediator.SWITCH_MAP, pg.island_world_objects[arg_35_1].mapId, arg_35_1)

	return
end

function IslandScene:OnPlayStory(arg_36_1)
	self:PlayStory(arg_36_1)

	return
end

function IslandScene:OnTriggerTask(arg_37_1)
	local var_37_0 = self:GetIsland():GetTaskAgency():GetFutureTask(arg_37_1)

	if var_37_0 and var_37_0:IsUnlock() then
		self:emit(IslandMediator.ON_ACCEPT_TASK, {
			arg_37_1
		})
	end

	return
end

function IslandScene:OnSubmitTask(arg_38_1)
	local var_38_0 = self:GetIsland():GetTaskAgency():GetTask(arg_38_1)

	if var_38_0 and var_38_0:IsFinish() then
		self:emit(IslandMediator.ON_SUBMIT_TASK, arg_38_1)
	end

	return
end

function IslandScene:OnAddTaskProgress(arg_39_1, arg_39_2)
	IslandTaskHelper.UpdateClientTaskProgress(arg_39_1, arg_39_2)

	return
end

function IslandScene:OnApproachObject(arg_40_1)
	IslandTaskHelper.OnApproach(arg_40_1)

	return
end

function IslandScene:OnUpdateTrackTask(arg_41_1, arg_41_2)
	if arg_41_2 == IslandTaskTrackCard.TYPES.MAIN then
		self.mainTraceTaskId = arg_41_1
	elseif arg_41_2 == IslandTaskTrackCard.TYPES.OTHER then
		self.otherTraceTaskId = arg_41_1
	end

	if self.mainTraceTaskId and self.mainTraceTaskId ~= 0 or self.otherTraceTaskId and self.otherTraceTaskId ~= 0 then
		self.taskTrackPanel:ExecuteAction("Show")
	end

	self.btnContainer:OnTrackTaskChange()

	return
end

function IslandScene:OnAddedTask(arg_42_1)
	self.btnContainer:OnTaskUpdate()

	return
end

function IslandScene:OnUpdateTask(arg_43_1)
	if self.mainTraceTaskId and self.mainTraceTaskId == arg_43_1.id then
		self.taskTrackPanel:ExecuteAction("UpdateProgress", IslandTaskTrackCard.TYPES.MAIN)
		self.btnContainer:OnTrackTaskChange()
	elseif self.otherTraceTaskId and self.otherTraceTaskId == arg_43_1.id then
		self.taskTrackPanel:ExecuteAction("UpdateProgress", IslandTaskTrackCard.TYPES.OTHER)
		self.btnContainer:OnTrackTaskChange()
	end

	self.btnContainer:OnTaskUpdate()

	return
end

function IslandScene:OnRemoveTask(arg_44_1)
	if self.mainTraceTaskId and self.mainTraceTaskId == arg_44_1.id then
		self.taskTrackPanel:ExecuteAction("RemoveTask", IslandTaskTrackCard.TYPES.MAIN)
		self.btnContainer:OnTrackTaskChange()
	elseif self.otherTraceTaskId and self.otherTraceTaskId == arg_44_1.id then
		self.taskTrackPanel:ExecuteAction("RemoveTask", IslandTaskTrackCard.TYPES.OTHER)
		self.btnContainer:OnTrackTaskChange()
	end

	self.btnContainer:OnTaskUpdate()

	return
end

function IslandScene:UpdateTaskInfo()
	local var_45_0 = self:GetIsland():GetTaskAgency():GetMainTraceTask()
	local var_45_1 = self:GetIsland():GetTaskAgency():GetTraceTask()

	if var_45_0 then
		self.mainTraceTaskId = var_45_0.id
	end

	if var_45_1 then
		self.otherTraceTaskId = var_45_1.id
	end

	if self.otherTraceTaskId and self.otherTraceTaskId ~= 0 or self.mainTraceTaskId and self.mainTraceTaskId ~= 0 then
		self.taskTrackPanel:ExecuteAction("Show")
	else
		self.taskTrackPanel:ExecuteAction("Hide")
	end

	self.btnContainer:OnTrackTaskChange()
	self.btnContainer:OnTaskUpdate()

	return
end

function IslandScene:OnSetUpCore(arg_46_1, arg_46_2)
	self.approachSpawnPointId = arg_46_2

	return
end

function IslandScene:OnAgoraEnterEditMode()
	setActive(self._tf, false)

	return
end

function IslandScene:OnAgoraExitEditMode()
	setActive(self._tf, true)

	return
end

function IslandScene:OnShipGetState(arg_49_1)
	self:ShowToast({
		type = IslandToast.TYPE_STATE,
		content = i18n("island_toast_status", arg_49_1.status:GetName(), (arg_49_1.ship:GetName()))
	})

	return
end

function IslandScene:OnShipLevelUp(arg_50_1)
	self:ShowToast({
		content = i18n("island_toast_level", arg_50_1:GetLevel(), (arg_50_1:GetName()))
	})

	return
end

function IslandScene:OnAddShip(arg_51_1)
	self:ShowToast({
		content = i18n("island_toast_ship", self:GetIsland():GetName(), (arg_51_1:GetName()))
	})

	return
end

function IslandScene:OnNewAchievementCanGet(arg_52_1)
	if not IslandMainBtnTipHelper.IsUnlock("achievement") then
		return
	end

	self:ShowToast({
		content = i18n("island_achv_finish_tip", arg_52_1:getConfig("name"))
	})

	return
end

function IslandScene:OnFinishDelegation()
	self.btnContainer:OnFinishDelegation()

	return
end

function IslandScene:OnUnlockTechnology()
	self.btnContainer:OnUnlockTechnology()

	return
end

function IslandScene:OnUpgrade(arg_55_1)
	self.levelPanel:ExecuteAction("UpdateTip")
	self.levelPanel:ExecuteAction("UpdateIslandInfo")
	seriesAsync({
		function(arg_56_0)
			self:OpenPage(IslandUpgradeDisplayPage, arg_55_1.dropData.abilitys, arg_56_0)

			return
		end,
		function(arg_57_0)
			self:DisplaySystemUnlock(arg_55_1.dropData.abilitys, arg_57_0)

			return
		end
	}, arg_55_1.callback)

	return
end

function IslandScene:OnModifyName()
	self.levelPanel:ExecuteAction("UpdateIslandInfo")

	return
end

function IslandScene:OnGetProsperityAward()
	self.levelPanel:ExecuteAction("UpdateTip")

	return
end

function IslandScene:OnUnlockSystem(arg_60_1)
	self.btnContainer:OnUnlockSystem(arg_60_1)
	switch(arg_60_1, {
		[pg.island_set.main_page_function_unlock.key_value_varchar[1]] = function()
			self.levelPanel:ExecuteAction("Show")

			return
		end,
		[pg.island_set.main_page_function_unlock.key_value_varchar[2]] = function()
			self.unlockTask = true

			self.taskTrackPanel:ExecuteAction("SetUnlock")
			self:UpdateTaskInfo()

			return
		end,
		[pg.island_set.main_page_function_unlock.key_value_varchar[3]] = function()
			setActive(self.visitorBtn, true)
			self:UpdateVisitorBtn()

			return
		end
	}, function()
		return
	end)

	return
end

function IslandScene:OnVisitorNumChange()
	self:UpdateVisitorBtn()

	return
end

function IslandScene:OnSceneLoaded()
	self:HandleAwardDisplay({})
	IslandScene.super.OnSceneLoaded(self)

	local var_66_0 = self:GetIsland():GetAblityAgency()

	if var_66_0:HasAbility(pg.island_set.main_page_function_unlock.key_value_varchar[1]) then
		self.levelPanel:ExecuteAction("Show")
	end

	self.unlockTask = var_66_0:HasAbility(pg.island_set.main_page_function_unlock.key_value_varchar[2])

	if self.unlockTask then
		self:UpdateTaskInfo()
	end

	local var_66_1 = var_66_0:HasAbility(pg.island_set.main_page_function_unlock.key_value_varchar[3])

	setActive(self.visitorBtn, var_66_1)

	if var_66_1 then
		self:UpdateVisitorBtn()
	end

	if self.approachSpawnPointId then
		self:OnApproachObject(self.approachSpawnPointId)

		self.approachSpawnPointId = nil
	end

	self:SequenceCheck()

	return
end

function IslandScene:SequenceCheck()
	seriesAsync({
		function(arg_68_0)
			if pg.NewStoryMgr.GetInstance():IsPlayed("ISLAND1001001_1") then
				arg_68_0()
			else
				self:PlayPerformance({
					name = "ISLANDPERFORMANCE1",
					callback = arg_68_0
				})
			end

			return
		end,
		function(arg_69_0)
			self:SeasonResetCheck(arg_69_0)

			return
		end,
		function(arg_70_0)
			local var_70_0, var_70_1, var_70_2 = self:GetIsland():GetSeasonAgency():IsShowResetTip()

			if var_70_0 then
				local var_70_3 = var_70_1 > 0 and i18n("island_season_window_end2", var_70_1) or i18n("island_season_window_end")

				self:ShowMsgbox({
					hideNo = true,
					type = IslandMsgBox.TYPE_SEASON_TIP,
					tipTitle = var_70_3,
					content = i18n("island_season_window_rule"),
					onHide = function()
						self:GetIsland():GetSeasonAgency():SetResetTipFlag(var_70_1)
						arg_70_0()

						return
					end
				})
			else
				arg_70_0()
			end

			return
		end,
		function(arg_72_0)
			local var_72_0 = self:GetIsland():GetTicketAgency():GetExpiredTickets()

			if #var_72_0 > 0 then
				self:emit(IslandMediator.REMOVE_EXPIRED_TICKETS, var_72_0, arg_72_0)
			else
				arg_72_0()
			end

			return
		end,
		function(arg_73_0)
			local var_73_0 = self:GetIsland():GetTicketAgency():GetExpireRemindTickets()

			if #var_73_0 > 0 then
				self:ShowMsgbox({
					hideNo = true,
					type = IslandMsgBox.TYPE_TICKET_EXPIRED,
					body = {
						type = IslandTicketExpiredMsgBoxWindow.TYPES.REMIND,
						tickets = var_73_0
					},
					onHide = function()
						self:GetIsland():GetTicketAgency():SetRemindFlag()
						arg_73_0()

						return
					end
				})
			else
				arg_73_0()
			end

			return
		end,
		function(arg_75_0)
			self:GetIsland():GetTaskAgency():TrySubmitAutoTasks(arg_75_0)

			return
		end,
		function(arg_76_0)
			self:GetIsland():GetTaskAgency():TryAcceptAutoTasks(arg_76_0)

			return
		end
	}, function()
		IslandGuideChecker.CheckOnLoaded(self:GetIsland():GetMapId())

		return
	end)

	return
end

function IslandScene:SeasonResetCheck(arg_78_1)
	local var_78_0, var_78_1 = IslandSeasonAgency.CheckReset()

	if var_78_0 then
		seriesAsync({
			function(arg_79_0)
				self:ShowMsgbox({
					hideNo = true,
					type = IslandMsgBox.TYPE_COMMON,
					content = i18n("island_season_reset"),
					onHide = arg_79_0
				})

				return
			end
		}, function()
			self:ShowMsgbox({
				type = IslandMsgBox.TYPE_SEASON_RESET,
				body = var_78_1,
				onHide = arg_78_1
			})

			return
		end)
	else
		arg_78_1()
	end

	return
end

function IslandScene:UpdateVisitorBtn()
	setText(self.visitorBtn:Find("num"), self:GetIsland():GetVisitorAgency():GetVisitorCnt())
	setText(self.visitorBtn:Find("Text"), i18n("island_visitor_button"))

	return
end

function IslandScene:UpdateMainAwardReward(arg_82_1)
	self.awardDisplayPanel:ExecuteAction("ShowAwards", arg_82_1)

	return
end

function IslandScene:OnUnloadScene()
	return
end

function IslandScene:OnVisible()
	self:UpdateTaskInfo()
	self.btnContainer:Flush()

	if not self:GetSubView(IslandStoryMgr):IsRunning() and not self.poppingQueue:AnyPlayerIsRunning() then
		IslandGuideChecker.CheckOnLoaded(self:GetIsland():GetMapId())
	end

	return
end

function IslandScene:willExit()
	if self.btnContainer then
		self.btnContainer:Dispose()

		self.btnContainer = nil
	end

	if self.levelPanel then
		self.levelPanel:Destroy()

		self.levelPanel = nil
	end

	if self.taskTrackPanel then
		self.taskTrackPanel:Destroy()

		self.taskTrackPanel = nil
	end

	if self.awardDisplayPanel then
		self.awardDisplayPanel:Destroy()

		self.awardDisplayPanel = nil
	end

	return
end

function IslandScene:onBackPressed()
	if self.sceneMgr:GetPage(IslandCheaterTavernMainPage) then
		pg.m02:sendNotification(IslandProxy.PRESS_BACK)

		return
	end

	IslandScene.super.onBackPressed(self)

	return
end

return IslandScene
