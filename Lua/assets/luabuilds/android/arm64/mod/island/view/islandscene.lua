local var_0_0 = class("IslandScene", import(".base.IslandBaseScene"))

var_0_0.ON_INVENTORY_FILTER = "IslandScene:ON_INVENTORY_FILTER"
var_0_0.ON_CHECK_ORDER_EXP_AWARD = "IslandScene:ON_CHECK_ORDER_EXP_AWARD"

function var_0_0.getUIName(arg_1_0)
	return "IslandUI"
end

function var_0_0.preload(arg_2_0, arg_2_1)
	seriesAsync({
		function(arg_3_0)
			var_0_0.super.preload(arg_2_0, arg_3_0)

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

function var_0_0.loadingQueue(arg_7_0)
	return function(arg_8_0)
		pg.SceneAnimMgr.GetInstance():CommonSceneChange("Dorm3DLoading", function(arg_9_0)
			return arg_8_0(arg_9_0)
		end)

		return
	end
end

function var_0_0.GetIsland(arg_10_0)
	return getProxy(IslandProxy):GetIsland()
end

function var_0_0.init(arg_11_0)
	arg_11_0.visitorBtn = arg_11_0._tf:Find("top/visitor")
	arg_11_0.levelPanel = IslandLevelPanel.New(arg_11_0._tf, arg_11_0.event)
	arg_11_0.taskTrackPanel = Island3dTaskTrackPanel.New(arg_11_0._tf:Find("track_container"), arg_11_0.event)
	arg_11_0.awardDisplayPanel = IslandAwardDisplayInMainPanel.New(arg_11_0._tf, arg_11_0.event, setmetatable({
		needAdapt = true
	}, {
		__index = arg_11_0.contextData
	}))
	arg_11_0.btnContainer = IslandMainBtnContainer.New(arg_11_0._tf:Find("top/btn_container"), arg_11_0.event)

	return
end

function var_0_0.didEnter(arg_12_0)
	onButton(arg_12_0, arg_12_0.visitorBtn, function()
		arg_12_0:OpenPage(IslandVisitorPage)

		return
	end, SFX_PANEL)
	arg_12_0:SetUp()

	arg_12_0.contextData.resumeCallback = nil

	existCall(arg_12_0.contextData.resumeCallback)

	return
end

function var_0_0.SetUp(arg_14_0)
	seriesAsync({
		function(arg_15_0)
			arg_14_0:SetDressUpIsEmpty(arg_15_0)

			return
		end
	}, function()
		arg_14_0:StartCore()

		return
	end)

	return
end

function var_0_0.SetNameIfIsEmpty(arg_17_0, arg_17_1)
	if not arg_17_0:GetIsland():IsNew() then
		arg_17_1()

		return
	end

	local var_17_0 = IslandSetNamePage.New(arg_17_0)

	var_17_0:ExecuteAction("Show", function()
		var_17_0:Destroy()
		arg_17_1()

		return
	end)

	return
end

function var_0_0.SetDressUpIsEmpty(arg_19_0, arg_19_1)
	if not arg_19_0:GetIsland():GetDressUpAgency():IsNew() then
		arg_19_1()

		return
	end

	arg_19_0:OpenPage(IslandShipFirstDressupPage, arg_19_1)

	return
end

function var_0_0.AddListeners(arg_20_0)
	arg_20_0:AddListener(GAME.ISLAND_UPGRADE_DONE, arg_20_0.OnUpgrade)
	arg_20_0:AddListener(Island.EXP_ADD, arg_20_0.OnExpChange)
	arg_20_0:AddListener(GAME.ISLAND_SET_NAME_DONE, arg_20_0.OnModifyName)
	arg_20_0:AddListener(GAME.ISLAND_PROSPERITY_AWARD_DONE, arg_20_0.OnGetProsperityAward)
	arg_20_0:AddListener(IslandTaskAgency.TASK_ADDED, arg_20_0.OnAddedTask)
	arg_20_0:AddListener(IslandTaskAgency.TASK_UPDATED, arg_20_0.OnUpdateTask)
	arg_20_0:AddListener(IslandTaskAgency.TASK_REMOVED, arg_20_0.OnRemoveTask)
	arg_20_0:AddListener(IslandAchievementAgency.NEW_CAN_GET, arg_20_0.OnNewAchievementCanGet)
	arg_20_0:AddListener(GAME.ISLAND_FINISH_DELEGATION_DONE, arg_20_0.OnFinishDelegation)
	arg_20_0:AddListener(GAME.ISLAND_UNLOCK_TECH_DONE, arg_20_0.OnUnlockTechnology)
	arg_20_0:AddListener(IslandCharacterAgency.ADD_SHIP, arg_20_0.OnAddShip)
	arg_20_0:AddListener(IslandCharacterAgency.SHIP_LEVEL_UP, arg_20_0.OnShipLevelUp)
	arg_20_0:AddListener(IslandCharacterAgency.SHIP_GET_STATE, arg_20_0.OnShipGetState)
	arg_20_0:AddListener(IslandAblityAgency.UNLOCK_SYSTEM, arg_20_0.OnUnlockSystem)
	arg_20_0:AddListener(IslandVisitorAgency.PLAYER_ADD, arg_20_0.OnVisitorNumChange)
	arg_20_0:AddListener(IslandVisitorAgency.PLAYER_EXIT, arg_20_0.OnVisitorNumChange)
	arg_20_0:AddListener(ISLAND_EX_EVT.ENTER_EDIT_AGORA, arg_20_0.OnAgoraEnterEditMode)
	arg_20_0:AddListener(ISLAND_EX_EVT.EXIT_EDIT_AGORA, arg_20_0.OnAgoraExitEditMode)
	arg_20_0:AddListener(ISLAND_EX_EVT.TRIGGER_TASK, arg_20_0.OnTriggerTask)
	arg_20_0:AddListener(ISLAND_EX_EVT.SUBMIT_TASK, arg_20_0.OnSubmitTask)
	arg_20_0:AddListener(ISLAND_EX_EVT.ADD_TASK_PROGRESS, arg_20_0.OnAddTaskProgress)
	arg_20_0:AddListener(ISLAND_EX_EVT.PLAY_STORY, arg_20_0.OnPlayStory)
	arg_20_0:AddListener(ISLAND_EX_EVT.SWITCH_MAP, arg_20_0.OnSwitchMap)
	arg_20_0:AddListener(ISLAND_EX_EVT.SEEK_GAME_START, arg_20_0.OnSeekGameStart)
	arg_20_0:AddListener(ISLAND_EX_EVT.SEEK_GAME_END, arg_20_0.OnSeekGameEnd)
	arg_20_0:AddListener(ISLAND_EX_EVT.ENTER_FISH_POINT, arg_20_0.OnEnterFishPoint)
	arg_20_0:AddListener(ISLAND_EX_EVT.EXIT_FISH_POINT, arg_20_0.OnExitFishPoint)
	arg_20_0:AddListener(ISLAND_EX_EVT.APPROACH_OBJECT, arg_20_0.OnApproachObject)
	arg_20_0:AddListener(ISLAND_EX_EVT.PLAY_PERFORMANCE, arg_20_0.OnPlayPerformance)
	arg_20_0:AddListener(ISLAND_EX_EVT.SHOW_INTERACTION, arg_20_0.OnShowInteraction)
	arg_20_0:AddListener(ISLAND_EX_EVT.SWITCH_MAP_BY_POINT, arg_20_0.OnSwitchMapByPoint)
	arg_20_0:AddListener(ISLAND_EX_EVT.NAV_PATH, arg_20_0.OnStartNavPath)
	arg_20_0:AddListener(ISLAND_EX_EVT.NAV_PATH_DONE, arg_20_0.OnNavPathDone)

	return
end

function var_0_0.RemoveListeners(arg_21_0)
	arg_21_0:RemoveListener(GAME.ISLAND_UPGRADE_DONE, arg_21_0.OnUpgrade)
	arg_21_0:RemoveListener(Island.EXP_ADD, arg_21_0.OnExpChange)
	arg_21_0:RemoveListener(GAME.ISLAND_SET_NAME_DONE, arg_21_0.OnModifyName)
	arg_21_0:RemoveListener(GAME.ISLAND_PROSPERITY_AWARD_DONE, arg_21_0.OnGetProsperityAward)
	arg_21_0:RemoveListener(IslandTaskAgency.TASK_ADDED, arg_21_0.OnAddedTask)
	arg_21_0:RemoveListener(IslandTaskAgency.TASK_UPDATED, arg_21_0.OnUpdateTask)
	arg_21_0:RemoveListener(IslandTaskAgency.TASK_REMOVED, arg_21_0.OnRemoveTask)
	arg_21_0:RemoveListener(IslandAchievementAgency.NEW_CAN_GET, arg_21_0.OnNewAchievementCanGet)
	arg_21_0:RemoveListener(GAME.ISLAND_FINISH_DELEGATION_DONE, arg_21_0.OnFinishDelegation)
	arg_21_0:RemoveListener(GAME.ISLAND_UNLOCK_TECH_DONE, arg_21_0.OnUnlockTechnology)
	arg_21_0:RemoveListener(IslandCharacterAgency.ADD_SHIP, arg_21_0.OnAddShip)
	arg_21_0:RemoveListener(IslandCharacterAgency.SHIP_LEVEL_UP, arg_21_0.OnShipLevelUp)
	arg_21_0:RemoveListener(IslandCharacterAgency.SHIP_GET_STATE, arg_21_0.OnShipGetState)
	arg_21_0:RemoveListener(IslandAblityAgency.UNLOCK_SYSTEM, arg_21_0.OnUnlockSystem)
	arg_21_0:RemoveListener(IslandVisitorAgency.PLAYER_ADD, arg_21_0.OnVisitorNumChange)
	arg_21_0:RemoveListener(IslandVisitorAgency.PLAYER_EXIT, arg_21_0.OnVisitorNumChange)
	arg_21_0:RemoveListener(ISLAND_EX_EVT.ENTER_EDIT_AGORA, arg_21_0.OnAgoraEnterEditMode)
	arg_21_0:RemoveListener(ISLAND_EX_EVT.EXIT_EDIT_AGORA, arg_21_0.OnAgoraExitEditMode)
	arg_21_0:RemoveListener(ISLAND_EX_EVT.TRIGGER_TASK, arg_21_0.OnTriggerTask)
	arg_21_0:RemoveListener(ISLAND_EX_EVT.SUBMIT_TASK, arg_21_0.OnSubmitTask)
	arg_21_0:RemoveListener(ISLAND_EX_EVT.ADD_TASK_PROGRESS, arg_21_0.OnAddTaskProgress)
	arg_21_0:RemoveListener(ISLAND_EX_EVT.PLAY_STORY, arg_21_0.OnPlayStory)
	arg_21_0:RemoveListener(ISLAND_EX_EVT.SWITCH_MAP, arg_21_0.OnSwitchMap)
	arg_21_0:RemoveListener(ISLAND_EX_EVT.SEEK_GAME_START, arg_21_0.OnSeekGameStart)
	arg_21_0:RemoveListener(ISLAND_EX_EVT.SEEK_GAME_END, arg_21_0.OnSeekGameEnd)
	arg_21_0:RemoveListener(ISLAND_EX_EVT.ENTER_FISH_POINT, arg_21_0.OnEnterFishPoint)
	arg_21_0:RemoveListener(ISLAND_EX_EVT.EXIT_FISH_POINT, arg_21_0.OnExitFishPoint)
	arg_21_0:RemoveListener(ISLAND_EX_EVT.APPROACH_OBJECT, arg_21_0.OnApproachObject)
	arg_21_0:RemoveListener(ISLAND_EX_EVT.PLAY_PERFORMANCE, arg_21_0.OnPlayPerformance)
	arg_21_0:RemoveListener(ISLAND_EX_EVT.SHOW_INTERACTION, arg_21_0.OnShowInteraction)
	arg_21_0:RemoveListener(ISLAND_EX_EVT.SWITCH_MAP_BY_POINT, arg_21_0.OnSwitchMapByPoint)
	arg_21_0:RemoveListener(ISLAND_EX_EVT.NAV_PATH, arg_21_0.OnStartNavPath)
	arg_21_0:RemoveListener(ISLAND_EX_EVT.NAV_PATH_DONE, arg_21_0.OnNavPathDone)

	return
end

function var_0_0.OnEnterFishPoint(arg_22_0)
	arg_22_0:TryDisVisible()

	return
end

function var_0_0.OnExitFishPoint(arg_23_0)
	arg_23_0:TryVisible()

	return
end

function var_0_0.OnOpenAnimatonOpPage(arg_24_0)
	arg_24_0.btnContainer:ActiveOrDisactive(false)

	return
end

function var_0_0.OnCloseAnimatonOpPage(arg_25_0)
	arg_25_0.btnContainer:ActiveOrDisactive(true)

	return
end

function var_0_0.OnStartNavPath(arg_26_0, arg_26_1)
	if arg_26_1 then
		pg.m02:sendNotification(GAME.STORY_UPDATE, {
			storyId = arg_26_1
		})
	end

	return
end

function var_0_0.OnNavPathDone(arg_27_0, arg_27_1)
	arg_27_0:GetIsland():DispatchEvent(IslandProxy.END_PATHFINDER)

	return
end

function var_0_0.OnExpChange(arg_28_0)
	arg_28_0.levelPanel:ExecuteAction("UpdateIslandInfo")

	return
end

function var_0_0.ShowExpAdd(arg_29_0, arg_29_1, arg_29_2)
	arg_29_0.levelPanel:ExecuteAction("ShowExpAdd", arg_29_1, arg_29_2)

	return
end

function var_0_0.OnSwitchMapByPoint(arg_30_0, arg_30_1)
	arg_30_0:GetIsland():SetLastExitPosition(arg_30_1.mapId, arg_30_1.position, arg_30_1.rotation)
	arg_30_0:emit(IslandBaseMediator.SWITCH_MAP, arg_30_1.mapId)

	return
end

function var_0_0.OnShowInteraction(arg_31_0, arg_31_1)
	IslandGuideChecker.CheckOnShowInteraction(arg_31_1)

	return
end

function var_0_0.OnPlayPerformance(arg_32_0, arg_32_1)
	arg_32_0:PlayPerformance(arg_32_1)

	return
end

function var_0_0.OnSeekGameStart(arg_33_0)
	arg_33_0:TryDisVisible()

	return
end

function var_0_0.OnSeekGameEnd(arg_34_0)
	arg_34_0:TryVisible()

	return
end

function var_0_0.OnSwitchMap(arg_35_0, arg_35_1)
	arg_35_0:emit(IslandBaseMediator.SWITCH_MAP, pg.island_world_objects[arg_35_1].mapId, arg_35_1)

	return
end

function var_0_0.OnPlayStory(arg_36_0, arg_36_1)
	arg_36_0:PlayStory(arg_36_1)

	return
end

function var_0_0.OnTriggerTask(arg_37_0, arg_37_1)
	local var_37_0 = arg_37_0:GetIsland():GetTaskAgency():GetFutureTask(arg_37_1)

	if var_37_0 and var_37_0:IsUnlock() then
		arg_37_0:emit(IslandMediator.ON_ACCEPT_TASK, {
			arg_37_1
		})
	end

	return
end

function var_0_0.OnSubmitTask(arg_38_0, arg_38_1)
	local var_38_0 = arg_38_0:GetIsland():GetTaskAgency():GetTask(arg_38_1)

	if var_38_0 and var_38_0:IsFinish() then
		arg_38_0:emit(IslandMediator.ON_SUBMIT_TASK, arg_38_1)
	end

	return
end

function var_0_0.OnAddTaskProgress(arg_39_0, arg_39_1, arg_39_2)
	IslandTaskHelper.UpdateClientTaskProgress(arg_39_1, arg_39_2)

	return
end

function var_0_0.OnApproachObject(arg_40_0, arg_40_1)
	IslandTaskHelper.OnApproach(arg_40_1)

	return
end

function var_0_0.OnUpdateTrackTask(arg_41_0, arg_41_1, arg_41_2)
	if arg_41_2 == IslandTaskTrackCard.TYPES.MAIN then
		arg_41_0.mainTraceTaskId = arg_41_1
	elseif arg_41_2 == IslandTaskTrackCard.TYPES.OTHER then
		arg_41_0.otherTraceTaskId = arg_41_1
	end

	if arg_41_0.mainTraceTaskId and arg_41_0.mainTraceTaskId ~= 0 or arg_41_0.otherTraceTaskId and arg_41_0.otherTraceTaskId ~= 0 then
		arg_41_0.taskTrackPanel:ExecuteAction("Show")
	end

	arg_41_0.btnContainer:OnTrackTaskChange()

	return
end

function var_0_0.OnAddedTask(arg_42_0, arg_42_1)
	arg_42_0.btnContainer:OnTaskUpdate()

	return
end

function var_0_0.OnUpdateTask(arg_43_0, arg_43_1)
	if arg_43_0.mainTraceTaskId and arg_43_0.mainTraceTaskId == arg_43_1.id then
		arg_43_0.taskTrackPanel:ExecuteAction("UpdateProgress", IslandTaskTrackCard.TYPES.MAIN)
		arg_43_0.btnContainer:OnTrackTaskChange()
	elseif arg_43_0.otherTraceTaskId and arg_43_0.otherTraceTaskId == arg_43_1.id then
		arg_43_0.taskTrackPanel:ExecuteAction("UpdateProgress", IslandTaskTrackCard.TYPES.OTHER)
		arg_43_0.btnContainer:OnTrackTaskChange()
	end

	arg_43_0.btnContainer:OnTaskUpdate()

	return
end

function var_0_0.OnRemoveTask(arg_44_0, arg_44_1)
	if arg_44_0.mainTraceTaskId and arg_44_0.mainTraceTaskId == arg_44_1.id then
		arg_44_0.taskTrackPanel:ExecuteAction("RemoveTask", IslandTaskTrackCard.TYPES.MAIN)
		arg_44_0.btnContainer:OnTrackTaskChange()
	elseif arg_44_0.otherTraceTaskId and arg_44_0.otherTraceTaskId == arg_44_1.id then
		arg_44_0.taskTrackPanel:ExecuteAction("RemoveTask", IslandTaskTrackCard.TYPES.OTHER)
		arg_44_0.btnContainer:OnTrackTaskChange()
	end

	arg_44_0.btnContainer:OnTaskUpdate()

	return
end

function var_0_0.UpdateTaskInfo(arg_45_0)
	local var_45_0 = arg_45_0:GetIsland():GetTaskAgency():GetMainTraceTask()
	local var_45_1 = arg_45_0:GetIsland():GetTaskAgency():GetTraceTask()

	if var_45_0 then
		arg_45_0.mainTraceTaskId = var_45_0.id
	end

	if var_45_1 then
		arg_45_0.otherTraceTaskId = var_45_1.id
	end

	if arg_45_0.otherTraceTaskId and arg_45_0.otherTraceTaskId ~= 0 or arg_45_0.mainTraceTaskId and arg_45_0.mainTraceTaskId ~= 0 then
		arg_45_0.taskTrackPanel:ExecuteAction("Show")
	else
		arg_45_0.taskTrackPanel:ExecuteAction("Hide")
	end

	arg_45_0.btnContainer:OnTrackTaskChange()
	arg_45_0.btnContainer:OnTaskUpdate()

	return
end

function var_0_0.OnSetUpCore(arg_46_0, arg_46_1, arg_46_2)
	arg_46_0.approachSpawnPointId = arg_46_2

	return
end

function var_0_0.OnAgoraEnterEditMode(arg_47_0)
	setActive(arg_47_0._tf, false)

	return
end

function var_0_0.OnAgoraExitEditMode(arg_48_0)
	setActive(arg_48_0._tf, true)

	return
end

function var_0_0.OnShipGetState(arg_49_0, arg_49_1)
	arg_49_0:ShowToast({
		type = IslandToast.TYPE_STATE,
		content = i18n("island_toast_status", arg_49_1.status:GetName(), (arg_49_1.ship:GetName()))
	})

	return
end

function var_0_0.OnShipLevelUp(arg_50_0, arg_50_1)
	arg_50_0:ShowToast({
		content = i18n("island_toast_level", arg_50_1:GetLevel(), (arg_50_1:GetName()))
	})

	return
end

function var_0_0.OnAddShip(arg_51_0, arg_51_1)
	arg_51_0:ShowToast({
		content = i18n("island_toast_ship", arg_51_0:GetIsland():GetName(), (arg_51_1:GetName()))
	})

	return
end

function var_0_0.OnNewAchievementCanGet(arg_52_0, arg_52_1)
	if not IslandMainBtnTipHelper.IsUnlock("achievement") then
		return
	end

	arg_52_0:ShowToast({
		content = i18n("island_achv_finish_tip", arg_52_1:getConfig("name"))
	})

	return
end

function var_0_0.OnFinishDelegation(arg_53_0)
	arg_53_0.btnContainer:OnFinishDelegation()

	return
end

function var_0_0.OnUnlockTechnology(arg_54_0)
	arg_54_0.btnContainer:OnUnlockTechnology()

	return
end

function var_0_0.OnUpgrade(arg_55_0, arg_55_1)
	arg_55_0.levelPanel:ExecuteAction("UpdateTip")
	arg_55_0.levelPanel:ExecuteAction("UpdateIslandInfo")
	seriesAsync({
		function(arg_56_0)
			arg_55_0:OpenPage(IslandUpgradeDisplayPage, arg_55_1.dropData.abilitys, arg_56_0)

			return
		end,
		function(arg_57_0)
			arg_55_0:DisplaySystemUnlock(arg_55_1.dropData.abilitys, arg_57_0)

			return
		end
	}, arg_55_1.callback)

	return
end

function var_0_0.OnModifyName(arg_58_0)
	arg_58_0.levelPanel:ExecuteAction("UpdateIslandInfo")

	return
end

function var_0_0.OnGetProsperityAward(arg_59_0)
	arg_59_0.levelPanel:ExecuteAction("UpdateTip")

	return
end

function var_0_0.OnUnlockSystem(arg_60_0, arg_60_1)
	arg_60_0.btnContainer:OnUnlockSystem(arg_60_1)
	switch(arg_60_1, {
		[pg.island_set.main_page_function_unlock.key_value_varchar[1]] = function()
			arg_60_0.levelPanel:ExecuteAction("Show")

			return
		end,
		[pg.island_set.main_page_function_unlock.key_value_varchar[2]] = function()
			arg_60_0.unlockTask = true

			arg_60_0.taskTrackPanel:ExecuteAction("SetUnlock")
			arg_60_0:UpdateTaskInfo()

			return
		end,
		[pg.island_set.main_page_function_unlock.key_value_varchar[3]] = function()
			setActive(arg_60_0.visitorBtn, true)
			arg_60_0:UpdateVisitorBtn()

			return
		end
	}, function()
		return
	end)

	return
end

function var_0_0.OnVisitorNumChange(arg_65_0)
	arg_65_0:UpdateVisitorBtn()

	return
end

function var_0_0.OnSceneLoaded(arg_66_0)
	arg_66_0:HandleAwardDisplay({})
	var_0_0.super.OnSceneLoaded(arg_66_0)

	local var_66_0 = arg_66_0:GetIsland():GetAblityAgency()

	if var_66_0:HasAbility(pg.island_set.main_page_function_unlock.key_value_varchar[1]) then
		arg_66_0.levelPanel:ExecuteAction("Show")
	end

	arg_66_0.unlockTask = var_66_0:HasAbility(pg.island_set.main_page_function_unlock.key_value_varchar[2])

	if arg_66_0.unlockTask then
		arg_66_0:UpdateTaskInfo()
	end

	local var_66_1 = var_66_0:HasAbility(pg.island_set.main_page_function_unlock.key_value_varchar[3])

	setActive(arg_66_0.visitorBtn, var_66_1)

	if var_66_1 then
		arg_66_0:UpdateVisitorBtn()
	end

	if arg_66_0.approachSpawnPointId then
		arg_66_0:OnApproachObject(arg_66_0.approachSpawnPointId)

		arg_66_0.approachSpawnPointId = nil
	end

	arg_66_0:SequenceCheck()

	return
end

function var_0_0.SequenceCheck(arg_67_0)
	seriesAsync({
		function(arg_68_0)
			if pg.NewStoryMgr.GetInstance():IsPlayed("ISLAND1001001_1") then
				arg_68_0()
			else
				arg_67_0:PlayPerformance({
					name = "ISLANDPERFORMANCE1",
					callback = arg_68_0
				})
			end

			return
		end,
		function(arg_69_0)
			arg_67_0:SeasonResetCheck(arg_69_0)

			return
		end,
		function(arg_70_0)
			local var_70_0, var_70_1, var_70_2 = arg_67_0:GetIsland():GetSeasonAgency():IsShowResetTip()

			if var_70_0 then
				local var_70_3 = var_70_1 > 0 and i18n("island_season_window_end2", var_70_1) or i18n("island_season_window_end")

				arg_67_0:ShowMsgbox({
					hideNo = true,
					type = IslandMsgBox.TYPE_SEASON_TIP,
					tipTitle = var_70_3,
					content = i18n("island_season_window_rule"),
					onHide = function()
						arg_67_0:GetIsland():GetSeasonAgency():SetResetTipFlag(var_70_1)
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
			local var_72_0 = arg_67_0:GetIsland():GetTicketAgency():GetExpiredTickets()

			if #var_72_0 > 0 then
				arg_67_0:emit(IslandMediator.REMOVE_EXPIRED_TICKETS, var_72_0, arg_72_0)
			else
				arg_72_0()
			end

			return
		end,
		function(arg_73_0)
			local var_73_0 = arg_67_0:GetIsland():GetTicketAgency():GetExpireRemindTickets()

			if #var_73_0 > 0 then
				arg_67_0:ShowMsgbox({
					hideNo = true,
					type = IslandMsgBox.TYPE_TICKET_EXPIRED,
					body = {
						type = IslandTicketExpiredMsgBoxWindow.TYPES.REMIND,
						tickets = var_73_0
					},
					onHide = function()
						arg_67_0:GetIsland():GetTicketAgency():SetRemindFlag()
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
			arg_67_0:GetIsland():GetTaskAgency():TrySubmitAutoTasks(arg_75_0)

			return
		end,
		function(arg_76_0)
			arg_67_0:GetIsland():GetTaskAgency():TryAcceptAutoTasks(arg_76_0)

			return
		end
	}, function()
		IslandGuideChecker.CheckOnLoaded(arg_67_0:GetIsland():GetMapId())

		return
	end)

	return
end

function var_0_0.SeasonResetCheck(arg_78_0, arg_78_1)
	local var_78_0, var_78_1 = IslandSeasonAgency.CheckReset()

	if var_78_0 then
		seriesAsync({
			function(arg_79_0)
				arg_78_0:ShowMsgbox({
					hideNo = true,
					type = IslandMsgBox.TYPE_COMMON,
					content = i18n("island_season_reset"),
					onHide = arg_79_0
				})

				return
			end
		}, function()
			arg_78_0:ShowMsgbox({
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

function var_0_0.UpdateVisitorBtn(arg_81_0)
	setText(arg_81_0.visitorBtn:Find("num"), arg_81_0:GetIsland():GetVisitorAgency():GetVisitorCnt())
	setText(arg_81_0.visitorBtn:Find("Text"), i18n("island_visitor_button"))

	return
end

function var_0_0.UpdateMainAwardReward(arg_82_0, arg_82_1)
	arg_82_0.awardDisplayPanel:ExecuteAction("ShowAwards", arg_82_1)

	return
end

function var_0_0.OnUnloadScene(arg_83_0)
	return
end

function var_0_0.OnVisible(arg_84_0)
	arg_84_0:UpdateTaskInfo()
	arg_84_0.btnContainer:Flush()

	if not arg_84_0:GetSubView(IslandStoryMgr):IsRunning() and not arg_84_0.poppingQueue:AnyPlayerIsRunning() then
		IslandGuideChecker.CheckOnLoaded(arg_84_0:GetIsland():GetMapId())
	end

	return
end

function var_0_0.willExit(arg_85_0)
	if arg_85_0.btnContainer then
		arg_85_0.btnContainer:Dispose()

		arg_85_0.btnContainer = nil
	end

	if arg_85_0.levelPanel then
		arg_85_0.levelPanel:Destroy()

		arg_85_0.levelPanel = nil
	end

	if arg_85_0.taskTrackPanel then
		arg_85_0.taskTrackPanel:Destroy()

		arg_85_0.taskTrackPanel = nil
	end

	if arg_85_0.awardDisplayPanel then
		arg_85_0.awardDisplayPanel:Destroy()

		arg_85_0.awardDisplayPanel = nil
	end

	return
end

function var_0_0.onBackPressed(arg_86_0)
	if arg_86_0.sceneMgr:GetPage(IslandCheaterTavernMainPage) then
		pg.m02:sendNotification(IslandProxy.PRESS_BACK)

		return
	end

	var_0_0.super.onBackPressed(arg_86_0)

	return
end

return var_0_0
