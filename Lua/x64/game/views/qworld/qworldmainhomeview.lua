local var_0_0 = class("QWorldMainHomeView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/SandPlay/SandPlay_InScenes/SandPlay_InScenes_HUDUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListener()

	arg_3_0.miniMapCom = arg_3_0.miniMapGo_:GetComponent(typeof(QWorldMiniMapUI))
	arg_3_0.trackerCom = arg_3_0.trackerGo_:GetComponent(typeof(QWorldMultiTargetTracker))

	local var_3_0 = QWorldMgr:GetMapId()
	local var_3_1 = SandPlayMapCfg[var_3_0]
	local var_3_2 = "QWWorld/MiniMap/" .. var_3_1.small_map_path
	local var_3_3 = Vector3.New(var_3_1.small_map_center[1], var_3_1.small_map_center[2], var_3_1.small_map_center[3])

	arg_3_0.miniMapCom:Init(var_3_2, var_3_1.small_map_size[1], var_3_1.small_map_size[2], var_3_1.small_map_rate, var_3_3)

	arg_3_0.questSideView_ = QWorldQuestSideView.New(arg_3_0.gameObject_, arg_3_0)
	arg_3_0.rewardSideView_ = QWorldRewardSideView.New(arg_3_0.gameObject_, arg_3_0)
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.doggleController = arg_4_0.rootController_:GetController("doggleState")
	arg_4_0.interactController = arg_4_0.rootController_:GetController("InteractState")

	local var_4_0 = arg_4_0.leftPanelTrans_:GetComponent("VerticalLayoutGroup")

	arg_4_0.leftPanelSpacing_ = var_4_0.spacing
	var_4_0.enabled = false
	arg_4_0.rewardPanelGo_.transform.anchorMin = Vector2(0, 1)
	arg_4_0.rewardPanelGo_.transform.anchorMax = Vector2(0, 1)
	arg_4_0.questContentGo_.transform.anchorMin = Vector2(0, 1)
	arg_4_0.questContentGo_.transform.anchorMax = Vector2(0, 1)
	arg_4_0.menuList = LuaList.New(handler(arg_4_0, arg_4_0.IndexMenuItem), arg_4_0.menuObj_, QWorldMainMenuItemContainer)
end

function var_0_0.GetPlayBackwardsAnimator(arg_5_0)
	if arg_5_0.fadeAnim then
		return {
			{
				arg_5_0.rootAni_,
				"UI_SandPlay_right_cx 2",
				false
			}
		}
	else
		return {}
	end
end

function var_0_0.AddUIListener(arg_6_0)
	arg_6_0:AddBtnListener(arg_6_0.exitBtn_, nil, function()
		manager.notify:Invoke(QWORLD_OPEN_MAIN_VIEW, 0)
		QWorldMgr:ActivePlayerControl(false)
		ShowMessageBox({
			title = GetTips("PROMPT"),
			content = GetTips("SANDPLAY_EXIT_PROMPT"),
			OkCallback = function()
				QWorldData:ClearIsBack()
				arg_6_0:ExitSandPlay()
			end,
			CancelCallback = function()
				manager.notify:Invoke(QWORLD_OPEN_MAIN_VIEW, 1)
				QWorldMgr:ActivePlayerControlWithMain(true)
			end,
			MaskCallback = function()
				manager.notify:Invoke(QWORLD_OPEN_MAIN_VIEW, 1)
				QWorldMgr:ActivePlayerControlWithMain(true)
			end
		})
	end)
	arg_6_0:AddBtnListener(arg_6_0.miniMapBtn_, nil, function()
		if not arg_6_0:CheckCanInteract() then
			return
		end

		arg_6_0.fadeAnim = true

		JumpTools.GoToSystem("/qWorldMaxMapView")
	end)
	arg_6_0:AddBtnListener(arg_6_0.exitInteractBtn_, nil, function()
		QWorldMgr:GetQWorldPerformMgr():MarkFuniturePerformWaitInterrupt()
	end)
	arg_6_0:RegistEventListener(QWORLD_ENTER_PERFORM, function(arg_13_0, arg_13_1)
		if not arg_13_0 then
			arg_6_0:ChangeDoddleState("doggle")
		elseif not arg_13_1 then
			arg_6_0:ChangeDoddleState("exitInteract")
		end
	end)
	arg_6_0:RegistEventListener(QWORLD_SYSTEM_OPEN, function(arg_14_0)
		arg_6_0:RenderMenu()
	end)
	arg_6_0:RegistEventListener(QWORLD_SYSTEM_CLOSE, function(arg_15_0)
		arg_6_0:RenderMenu()
	end)
	arg_6_0:RegistEventListener(QWORLD_INTERACTION_CHANGE, function(arg_16_0)
		arg_6_0:ChangeInteractionMode(arg_16_0)
	end)
	arg_6_0:RegistEventListener(STORY_AVG_HIDE_MAIN_UI, function(arg_17_0)
		if gameContext:GetLastOpenPage() == "qworldMainHome" then
			if arg_17_0 then
				arg_6_0:OnBehind()
			else
				arg_6_0:OnTop()
			end
		end
	end)
end

function var_0_0.OnEnter(arg_18_0)
	CursorTools.LuaSwitchCursor(false)
	manager.notify:Invoke(QWORLD_OPEN_MAIN_VIEW, 1)
	QWorldMgr:ActivePlayerControl(true)
	arg_18_0.questSideView_:OnEnter()
	arg_18_0.rewardSideView_:OnEnter()
	arg_18_0:BindRedPoint()
	arg_18_0:RefreshUI()
	arg_18_0:OnQworldTrackUpdate()
	arg_18_0:CheckAutoCookHaveGoldIsMax()
	ActivityQuizTools.CheckQuizActivityHint()
	arg_18_0:RedEnvelopeClaimed()
	arg_18_0:RenderMenu()
	arg_18_0:ChangeInteractionMode(QWorldLuaBridge.GetInteractionMode())

	arg_18_0.fadeAnim = false

	QWorldQuanzhouNotify:Process()
end

function var_0_0.RedEnvelopeClaimed(arg_19_0)
	if ActivityData:GetActivityIsOpen(ActivityConst.ACTIVITY_RED_ENVELOPE) and QWorldQuestTool.GetMainQuestStatus(10105) == QWorldQuestConst.MAIN_QUEST_STATUS.FINISH and manager.redPoint:getTipValue(RedPointConst.ACTIVITY_RED_ENVELOPE .. "_" .. ActivityConst.ACTIVITY_RED_ENVELOPE) >= 1 then
		QWorldData:AddHint(313581002)
	end
end

function var_0_0.CheckAutoCookHaveGoldIsMax(arg_20_0)
	if arg_20_0.autoCookMaxGoldFlag_ or arg_20_0.params_.isBack == true then
		return
	end

	if ActivityData:GetActivityIsOpen(ActivityConst.AUTO_COOK) then
		if ActivityAutoCookData:CheckWillRewardMaxToLimit() then
			arg_20_0.autoCookMaxGoldFlag_ = true

			if ActivityAutoCookData:GetCurWeekCanGet() <= 0 then
				return
			end

			QWorldData:AddHint(313551003)
		else
			arg_20_0:AddAutoCookTimer()
		end
	end
end

function var_0_0.ExitSandPlay(arg_21_0)
	LuaExchangeHelper.GoToMain()
end

function var_0_0.OnEnterOver(arg_22_0)
	arg_22_0:StopCheckHintTimer()

	arg_22_0.checkHintTimer_ = Timer.New(function()
		arg_22_0:CheckHint()
	end, 1, 1)

	arg_22_0.checkHintTimer_:Start()
end

function var_0_0.CheckHint(arg_24_0)
	local var_24_0 = QWorldMgr:GetQWorldHintMgr()

	if var_24_0 and not var_24_0.isPlayingQueue then
		var_24_0:DisplayNextHint()
	end
end

function var_0_0.OnTop(arg_25_0)
	manager.notify:Invoke(QWORLD_OPEN_MAIN_VIEW, 1)
	QWorldMgr:ActivePlayerControl(true)
	arg_25_0.questSideView_:OnTop()
	arg_25_0.rewardSideView_:OnTop()
	QWorldQuestGraph:DispatchQuestEvent(QWorldQuestConst.QUEST_EVENT.ON_BACK_MAIN_HOME, 0)
	arg_25_0:OnQWorldMainQueueUpdate()
	arg_25_0:CheckQWorldFunctionOpen()
	SetActive(arg_25_0.miniMapGo_, true)

	if arg_25_0.notifyTimer_ and QWorldNotifyQueue:HasNotifies() then
		QWorldNotifyQueue:UpdateNotifies()
	end

	arg_25_0:ChangeInteractionMode(QWorldLuaBridge.GetInteractionMode())
end

function var_0_0.OnBehind(arg_26_0)
	manager.notify:Invoke(QWORLD_OPEN_MAIN_VIEW, 0)
	QWorldMgr:ActivePlayerControl(false)
	arg_26_0.questSideView_:OnBehind()
	arg_26_0.rewardSideView_:OnBehind()
	QWorldNotifyQueue:ClearInsignificantQueue()
	arg_26_0:StopTimers()
end

function var_0_0.OnExit(arg_27_0)
	LuaForCursor.SwitchCursor(true)
	manager.notify:Invoke(QWORLD_OPEN_MAIN_VIEW, 0)
	QWorldMgr:ActivePlayerControl(false)
	arg_27_0.questSideView_:OnExit()
	arg_27_0.rewardSideView_:OnExit()
	QWorldMgr:GetQWorldHintMgr():StopTimerAndHideHint()
	arg_27_0:UnBindRedPoint()
	arg_27_0:StopCheckHintTimer()
	arg_27_0:StopAutoCookTimer()
end

function var_0_0.OnQWorldMainQuestUpdate(arg_28_0, arg_28_1)
	return
end

function var_0_0.OnQWorldQuestUpdateProgress(arg_29_0)
	arg_29_0.questSideView_:OnQWorldQuestUpdateProgress()
end

function var_0_0.OnQWorldMainQueueUpdate(arg_30_0)
	if not arg_30_0.notifyTimer_ and QWorldNotifyQueue:HasNotifies() then
		arg_30_0.notifyTimer_ = Timer.New(function()
			if QWorldNotifyQueue:HasNotifies() then
				QWorldNotifyQueue:UpdateNotifies()
			else
				arg_30_0.notifyTimer_:Stop()

				arg_30_0.notifyTimer_ = nil
			end
		end, 0.2, -1)

		arg_30_0.notifyTimer_:Start()
	end
end

function var_0_0.CheckQWorldFunctionOpen(arg_32_0, arg_32_1)
	for iter_32_0, iter_32_1 in pairs(QWorldFunction) do
		local var_32_0 = SandPlayFunctionOpenCfg[iter_32_0]

		if var_32_0 and var_32_0.map_id == QWorldMgr:GetMapId() then
			SetActive(arg_32_0[iter_32_1], IsConditionAchieved(var_32_0.condition_id))
		end
	end
end

function var_0_0.EnableInteraction(arg_33_0, arg_33_1)
	QWorldLuaBridge.ActiveMiniMap(arg_33_1)

	arg_33_0.disableInteraction_ = not arg_33_1
end

function var_0_0.CheckCanInteract(arg_34_0)
	if arg_34_0.disableInteraction_ then
		ShowTips("SANDPLAY_UI_DISABLE")

		return false
	end

	return true
end

function var_0_0.UpdateLeftPanelLayout(arg_35_0)
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_35_0.questContentGo_.transform)
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_35_0.rewardListGo_.transform)
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_35_0.rewardPanelGo_.transform)

	if arg_35_0.questContentGo_.activeSelf then
		arg_35_0.rewardPanelGo_.transform.anchoredPosition = Vector2(arg_35_0.rewardPanelGo_.transform.anchoredPosition.x, arg_35_0.questContentGo_.transform.offsetMin.y - arg_35_0.leftPanelSpacing_)
	else
		arg_35_0.rewardPanelGo_.transform.anchoredPosition = Vector2(arg_35_0.rewardPanelGo_.transform.anchoredPosition.x, 0)
	end
end

function var_0_0.RefreshUI(arg_36_0)
	return
end

function var_0_0.RenderMenu(arg_37_0)
	local var_37_0 = SandPlayMapCfg[QWorldMgr:GetMapId()].system_list

	arg_37_0.systemList = {}

	for iter_37_0, iter_37_1 in ipairs(var_37_0) do
		if SandPlaySystemCfg[iter_37_1].is_entrance == 1 and QWorldSystemData:IsSystemOpened(iter_37_1) then
			table.insert(arg_37_0.systemList, iter_37_1)
		end
	end

	table.sort(arg_37_0.systemList, function(arg_38_0, arg_38_1)
		local var_38_0 = SandPlaySystemCfg[arg_38_0]
		local var_38_1 = SandPlaySystemCfg[arg_38_1]

		if var_38_0.sort == var_38_1.sort then
			return var_38_0.id > var_38_1.id
		end

		return var_38_0.sort < var_38_1.sort
	end)
	arg_37_0.menuList:StartScroll(#arg_37_0.systemList)
end

function var_0_0.IndexMenuItem(arg_39_0, arg_39_1, arg_39_2)
	arg_39_2:Render(arg_39_0, arg_39_0.systemList[arg_39_1])
end

function var_0_0.BindRedPoint(arg_40_0)
	manager.redPoint:bindUIandKey(arg_40_0.miniMapGo_.transform, RedPointConst.QWORLD_MINI_MAP)
end

function var_0_0.UnBindRedPoint(arg_41_0)
	manager.redPoint:unbindUIandKey(arg_41_0.miniMapGo_.transform, RedPointConst.QWORLD_MINI_MAP)
end

function var_0_0.ChangeDoddleState(arg_42_0, arg_42_1)
	arg_42_0.doggleController:SetSelectedState(arg_42_1)
end

function var_0_0.Dispose(arg_43_0)
	arg_43_0.leftPanelSpacing_ = nil

	arg_43_0:StopTimers()
	arg_43_0.questSideView_:Dispose()
	arg_43_0.rewardSideView_:Dispose()
	arg_43_0.miniMapCom:Dispose()
	arg_43_0.menuList:Dispose()
	var_0_0.super.Dispose(arg_43_0)
end

function var_0_0.OnQworldTrackUpdate(arg_44_0)
	local var_44_0 = QWorldMgr:GetQWorldEntityMgr():GetTrackEntityIds()

	arg_44_0.trackerCom:UpdateTrack(var_44_0)
end

function var_0_0.StopTimers(arg_45_0)
	if arg_45_0.notifyTimer_ then
		QWorldNotifyQueue:HideNotifies()
		arg_45_0.notifyTimer_:Stop()

		arg_45_0.notifyTimer_ = nil
	end
end

function var_0_0.AddAutoCookTimer(arg_46_0)
	arg_46_0:StopAutoCookTimer()

	arg_46_0.autoCookTimer_ = Timer.New(function()
		if ActivityAutoCookData:CheckWillRewardMaxToLimit() then
			arg_46_0.autoCookMaxGoldFlag_ = true

			arg_46_0:StopAutoCookTimer()

			if ActivityAutoCookData:GetCurWeekCanGet() <= 0 then
				return
			end

			QWorldData:AddHint(313551003)
		end
	end, 5, -1)

	arg_46_0.autoCookTimer_:Start()
end

function var_0_0.ChangeInteractionMode(arg_48_0, arg_48_1)
	if arg_48_1 == QWorldInteractionMode.FULL or arg_48_1 == QWorldInteractionMode.ONLY_CONTROL then
		arg_48_0.interactController:SetSelectedState("Full")
	elseif arg_48_1 == QWorldInteractionMode.ONLY_CONTROL_RUN then
		arg_48_0.interactController:SetSelectedState("Full")
	elseif arg_48_1 == QWorldInteractionMode.ONLY_CONTROL_WALK then
		arg_48_0.interactController:SetSelectedState("OnlyMove")
	end
end

function var_0_0.StopAutoCookTimer(arg_49_0)
	if arg_49_0.autoCookTimer_ then
		arg_49_0.autoCookTimer_:Stop()

		arg_49_0.autoCookTimer_ = nil
	end
end

function var_0_0.StopCheckHintTimer(arg_50_0)
	if arg_50_0.checkHintTimer_ then
		arg_50_0.checkHintTimer_:Stop()

		arg_50_0.checkHintTimer_ = nil
	end
end

return var_0_0
