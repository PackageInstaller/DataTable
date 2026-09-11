local QWorldMainHomeView = class("QWorldMainHomeView", ReduxView)

function QWorldMainHomeView:UIName()
	return "Widget/System/SandPlay/SandPlay_InScenes/SandPlay_InScenes_HUDUI"
end

function QWorldMainHomeView:UIParent()
	return manager.ui.uiMain.transform
end

function QWorldMainHomeView:Init()
	self:InitUI()
	self:AddUIListener()

	self.miniMapCom = self.miniMapGo_:GetComponent(typeof(QWorldMiniMapUI))
	self.trackerCom = self.trackerGo_:GetComponent(typeof(QWorldMultiTargetTracker))

	local var_3_0 = SandPlayMapCfg[QWorldMgr:GetMapId()]

	self.miniMapCom:Init("QWWorld/MiniMap/" .. var_3_0.small_map_path, var_3_0.small_map_size[1], var_3_0.small_map_size[2], var_3_0.small_map_rate, (Vector3.New(var_3_0.small_map_center[1], var_3_0.small_map_center[2], var_3_0.small_map_center[3])))

	self.questSideView_ = QWorldQuestSideView.New(self.gameObject_, self)
	self.rewardSideView_ = QWorldRewardSideView.New(self.gameObject_, self)
end

function QWorldMainHomeView:InitUI()
	self:BindCfgUI()

	self.doggleController = self.rootController_:GetController("doggleState")
	self.interactController = self.rootController_:GetController("InteractState")

	local var_4_0 = self.leftPanelTrans_:GetComponent("VerticalLayoutGroup")

	self.leftPanelSpacing_ = var_4_0.spacing
	var_4_0.enabled = false
	self.rewardPanelGo_.transform.anchorMin = Vector2(0, 1)
	self.rewardPanelGo_.transform.anchorMax = Vector2(0, 1)
	self.questContentGo_.transform.anchorMin = Vector2(0, 1)
	self.questContentGo_.transform.anchorMax = Vector2(0, 1)
	self.menuList = LuaList.New(handler(self, self.IndexMenuItem), self.menuObj_, QWorldMainMenuItemContainer)
end

function QWorldMainHomeView:GetPlayBackwardsAnimator()
	if self.fadeAnim then
		return {
			{
				self.rootAni_,
				"UI_SandPlay_right_cx 2",
				false
			}
		}
	else
		return {}
	end
end

function QWorldMainHomeView:AddUIListener()
	self:AddBtnListener(self.exitBtn_, nil, function()
		manager.notify:Invoke(QWORLD_OPEN_MAIN_VIEW, 0)
		QWorldMgr:ActivePlayerControl(false)
		ShowMessageBox({
			title = GetTips("PROMPT"),
			content = GetTips("SANDPLAY_EXIT_PROMPT"),
			OkCallback = function()
				QWorldData:ClearIsBack()
				self:ExitSandPlay()
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
	self:AddBtnListener(self.miniMapBtn_, nil, function()
		if not self:CheckCanInteract() then
			return
		end

		self.fadeAnim = true

		JumpTools.GoToSystem("/qWorldMaxMapView")
	end)
	self:AddBtnListener(self.exitInteractBtn_, nil, function()
		QWorldMgr:GetQWorldPerformMgr():MarkFuniturePerformWaitInterrupt()
	end)
	self:RegistEventListener(QWORLD_ENTER_PERFORM, function(arg_13_0, arg_13_1)
		if not arg_13_0 then
			self:ChangeDoddleState("doggle")
		elseif not arg_13_1 then
			self:ChangeDoddleState("exitInteract")
		end
	end)
	self:RegistEventListener(QWORLD_SYSTEM_OPEN, function(arg_14_0)
		self:RenderMenu()
	end)
	self:RegistEventListener(QWORLD_SYSTEM_CLOSE, function(arg_15_0)
		self:RenderMenu()
	end)
	self:RegistEventListener(QWORLD_INTERACTION_CHANGE, function(arg_16_0)
		self:ChangeInteractionMode(arg_16_0)
	end)
	self:RegistEventListener(STORY_AVG_HIDE_MAIN_UI, function(arg_17_0)
		if gameContext:GetLastOpenPage() == "qworldMainHome" then
			if arg_17_0 then
				self:OnBehind()
			else
				self:OnTop()
			end
		end
	end)
end

function QWorldMainHomeView:OnEnter()
	CursorTools.LuaSwitchCursor(false)
	manager.notify:Invoke(QWORLD_OPEN_MAIN_VIEW, 1)
	QWorldMgr:ActivePlayerControl(true)
	self.questSideView_:OnEnter()
	self.rewardSideView_:OnEnter()
	self:BindRedPoint()
	self:RefreshUI()
	self:OnQworldTrackUpdate()
	self:CheckAutoCookHaveGoldIsMax()
	ActivityQuizTools.CheckQuizActivityHint()
	self:RedEnvelopeClaimed()
	self:RenderMenu()
	self:ChangeInteractionMode(QWorldLuaBridge.GetInteractionMode())

	self.fadeAnim = false

	QWorldQuanzhouNotify:Process()
end

function QWorldMainHomeView:RedEnvelopeClaimed()
	if ActivityData:GetActivityIsOpen(ActivityConst.ACTIVITY_RED_ENVELOPE) and QWorldQuestTool.GetMainQuestStatus(10105) == QWorldQuestConst.MAIN_QUEST_STATUS.FINISH and manager.redPoint:getTipValue(RedPointConst.ACTIVITY_RED_ENVELOPE .. "_" .. ActivityConst.ACTIVITY_RED_ENVELOPE) >= 1 then
		QWorldData:AddHint(313581002)
	end
end

function QWorldMainHomeView:CheckAutoCookHaveGoldIsMax()
	if self.autoCookMaxGoldFlag_ or self.params_.isBack == true then
		return
	end

	if ActivityData:GetActivityIsOpen(ActivityConst.AUTO_COOK) then
		if ActivityAutoCookData:CheckWillRewardMaxToLimit() then
			self.autoCookMaxGoldFlag_ = true

			if ActivityAutoCookData:GetCurWeekCanGet() <= 0 then
				return
			end

			QWorldData:AddHint(313551003)
		else
			self:AddAutoCookTimer()
		end
	end
end

function QWorldMainHomeView:ExitSandPlay()
	LuaExchangeHelper.GoToMain()
end

function QWorldMainHomeView:OnEnterOver()
	self:StopCheckHintTimer()

	self.checkHintTimer_ = Timer.New(function()
		self:CheckHint()
	end, 1, 1)

	self.checkHintTimer_:Start()
end

function QWorldMainHomeView:CheckHint()
	local var_24_0 = QWorldMgr:GetQWorldHintMgr()

	if var_24_0 and not var_24_0.isPlayingQueue then
		var_24_0:DisplayNextHint()
	end
end

function QWorldMainHomeView:OnTop()
	manager.notify:Invoke(QWORLD_OPEN_MAIN_VIEW, 1)
	QWorldMgr:ActivePlayerControl(true)
	self.questSideView_:OnTop()
	self.rewardSideView_:OnTop()
	QWorldQuestGraph:DispatchQuestEvent(QWorldQuestConst.QUEST_EVENT.ON_BACK_MAIN_HOME, 0)
	self:OnQWorldMainQueueUpdate()
	self:CheckQWorldFunctionOpen()
	SetActive(self.miniMapGo_, true)

	if self.notifyTimer_ and QWorldNotifyQueue:HasNotifies() then
		QWorldNotifyQueue:UpdateNotifies()
	end

	self:ChangeInteractionMode(QWorldLuaBridge.GetInteractionMode())
end

function QWorldMainHomeView:OnBehind()
	manager.notify:Invoke(QWORLD_OPEN_MAIN_VIEW, 0)
	QWorldMgr:ActivePlayerControl(false)
	self.questSideView_:OnBehind()
	self.rewardSideView_:OnBehind()
	QWorldNotifyQueue:ClearInsignificantQueue()
	self:StopTimers()
end

function QWorldMainHomeView:OnExit()
	LuaForCursor.SwitchCursor(true)
	manager.notify:Invoke(QWORLD_OPEN_MAIN_VIEW, 0)
	QWorldMgr:ActivePlayerControl(false)
	self.questSideView_:OnExit()
	self.rewardSideView_:OnExit()
	QWorldMgr:GetQWorldHintMgr():StopTimerAndHideHint()
	self:UnBindRedPoint()
	self:StopCheckHintTimer()
	self:StopAutoCookTimer()
end

function QWorldMainHomeView:OnQWorldMainQuestUpdate(arg_28_1)
	return
end

function QWorldMainHomeView:OnQWorldQuestUpdateProgress()
	self.questSideView_:OnQWorldQuestUpdateProgress()
end

function QWorldMainHomeView:OnQWorldMainQueueUpdate()
	if not self.notifyTimer_ and QWorldNotifyQueue:HasNotifies() then
		self.notifyTimer_ = Timer.New(function()
			if QWorldNotifyQueue:HasNotifies() then
				QWorldNotifyQueue:UpdateNotifies()
			else
				self.notifyTimer_:Stop()

				self.notifyTimer_ = nil
			end
		end, 0.2, -1)

		self.notifyTimer_:Start()
	end
end

function QWorldMainHomeView:CheckQWorldFunctionOpen(arg_32_1)
	for iter_32_0, iter_32_1 in pairs(QWorldFunction) do
		if SandPlayFunctionOpenCfg[iter_32_0] and SandPlayFunctionOpenCfg[iter_32_0].map_id == QWorldMgr:GetMapId() then
			SetActive(self[iter_32_1], IsConditionAchieved(SandPlayFunctionOpenCfg[iter_32_0].condition_id))
		end
	end
end

function QWorldMainHomeView:EnableInteraction(arg_33_1)
	QWorldLuaBridge.ActiveMiniMap(arg_33_1)

	self.disableInteraction_ = not arg_33_1
end

function QWorldMainHomeView:CheckCanInteract()
	if self.disableInteraction_ then
		ShowTips("SANDPLAY_UI_DISABLE")

		return false
	end

	return true
end

function QWorldMainHomeView:UpdateLeftPanelLayout()
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.questContentGo_.transform)
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.rewardListGo_.transform)
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.rewardPanelGo_.transform)

	self.rewardPanelGo_.transform.anchoredPosition = self.questContentGo_.activeSelf and Vector2(self.rewardPanelGo_.transform.anchoredPosition.x, self.questContentGo_.transform.offsetMin.y - self.leftPanelSpacing_) or Vector2(self.rewardPanelGo_.transform.anchoredPosition.x, 0)
end

function QWorldMainHomeView:RefreshUI()
	return
end

function QWorldMainHomeView:RenderMenu()
	self.systemList = {}

	for iter_37_0, iter_37_1 in ipairs(SandPlayMapCfg[QWorldMgr:GetMapId()].system_list) do
		if SandPlaySystemCfg[iter_37_1].is_entrance == 1 and QWorldSystemData:IsSystemOpened(iter_37_1) then
			table.insert(self.systemList, iter_37_1)
		end
	end

	table.sort(self.systemList, function(arg_38_0, arg_38_1)
		local var_38_0 = SandPlaySystemCfg[arg_38_0]
		local var_38_1 = SandPlaySystemCfg[arg_38_1]

		if SandPlaySystemCfg[arg_38_0].sort == SandPlaySystemCfg[arg_38_1].sort then
			return var_38_0.id > var_38_1.id
		end

		return var_38_0.sort < var_38_1.sort
	end)
	self.menuList:StartScroll(#self.systemList)
end

function QWorldMainHomeView:IndexMenuItem(arg_39_1, arg_39_2)
	arg_39_2:Render(self, self.systemList[arg_39_1])
end

function QWorldMainHomeView:BindRedPoint()
	manager.redPoint:bindUIandKey(self.miniMapGo_.transform, RedPointConst.QWORLD_MINI_MAP)
end

function QWorldMainHomeView:UnBindRedPoint()
	manager.redPoint:unbindUIandKey(self.miniMapGo_.transform, RedPointConst.QWORLD_MINI_MAP)
end

function QWorldMainHomeView:ChangeDoddleState(arg_42_1)
	self.doggleController:SetSelectedState(arg_42_1)
end

function QWorldMainHomeView:Dispose()
	self.leftPanelSpacing_ = nil

	self:StopTimers()
	self.questSideView_:Dispose()
	self.rewardSideView_:Dispose()
	self.miniMapCom:Dispose()
	self.menuList:Dispose()
	QWorldMainHomeView.super.Dispose(self)
end

function QWorldMainHomeView:OnQworldTrackUpdate()
	self.trackerCom:UpdateTrack((QWorldMgr:GetQWorldEntityMgr():GetTrackEntityIds()))
end

function QWorldMainHomeView:StopTimers()
	if self.notifyTimer_ then
		QWorldNotifyQueue:HideNotifies()
		self.notifyTimer_:Stop()

		self.notifyTimer_ = nil
	end
end

function QWorldMainHomeView:AddAutoCookTimer()
	self:StopAutoCookTimer()

	self.autoCookTimer_ = Timer.New(function()
		if ActivityAutoCookData:CheckWillRewardMaxToLimit() then
			self.autoCookMaxGoldFlag_ = true

			self:StopAutoCookTimer()

			if ActivityAutoCookData:GetCurWeekCanGet() <= 0 then
				return
			end

			QWorldData:AddHint(313551003)
		end
	end, 5, -1)

	self.autoCookTimer_:Start()
end

function QWorldMainHomeView:ChangeInteractionMode(arg_48_1)
	if arg_48_1 == QWorldInteractionMode.FULL or arg_48_1 == QWorldInteractionMode.ONLY_CONTROL then
		self.interactController:SetSelectedState("Full")
	elseif arg_48_1 == QWorldInteractionMode.ONLY_CONTROL_RUN then
		self.interactController:SetSelectedState("Full")
	elseif arg_48_1 == QWorldInteractionMode.ONLY_CONTROL_WALK then
		self.interactController:SetSelectedState("OnlyMove")
	end
end

function QWorldMainHomeView:StopAutoCookTimer()
	if self.autoCookTimer_ then
		self.autoCookTimer_:Stop()

		self.autoCookTimer_ = nil
	end
end

function QWorldMainHomeView:StopCheckHintTimer()
	if self.checkHintTimer_ then
		self.checkHintTimer_:Stop()

		self.checkHintTimer_ = nil
	end
end

return QWorldMainHomeView
