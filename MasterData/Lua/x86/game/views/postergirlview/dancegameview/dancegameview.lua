local DanceGameView = class("DanceGameView", ReduxView)

function DanceGameView:UIName()
	return "Widget/System/Main_T0SceneGame/102003/102003_DanceMachineUI"
end

function DanceGameView:UIParent()
	return manager.ui.uiMain.transform
end

function DanceGameView:OnCtor()
	return
end

local var_0_1 = {
	ToFrontCamPos = 4,
	DragInteract = 6,
	ToBackCamPos = 5
}

function DanceGameView:Init()
	self:InitUI()
	self:AddUIListener()

	self.btnControll = self.btnmodControllerexcollection_:GetController("sel")
end

function DanceGameView:InitUI()
	self:BindCfgUI()

	self.cutsceneSubView = TZeroGameChangeView.BaseView.New(self.cutsceneSubView_)
	self.subtitleBubble = MainHomeView_SubtitleBubble.New(self.talkBubbleGo_)
end

function DanceGameView:OnEnter()
	manager.windowBar:HideBar()
	self:RegisterEvents()

	self.gameInst = self.params_.gameInst
	self.modeIndex = 3

	self:RefreshMode()
	self:ShowRotateTips()
	self:StartViewHideTimer()
	self:SetVisible(false)
	self:GotoFront()
	self.subtitleBubble:OnEnter()
end

function DanceGameView:SetVisible(arg_7_1)
	SetActive(self.panel_, arg_7_1)
end

function DanceGameView:GetVisible()
	return self.panel_.activeInHierarchy
end

function DanceGameView:OnTop()
	if not self.cutsceneSubView:IsDuringCutscene() then
		self:ChangeBar()
	end

	self.subtitleBubble:Clear()
end

function DanceGameView:OnBehind()
	manager.windowBar:HideBar()
end

function DanceGameView:OnExit()
	DanceGameView.super.OnExit(self)
	self:SetCameraInputMode(1)
	self:StopTime()
	self.subtitleBubble:OnExit()
	self.cutsceneSubView:OnExit()
	self:RemoveAllEventListener()
end

function DanceGameView:RegisterEvents()
	self:RegistEventListener(INTERRUPT_HOME_POSTER_TALK, handler(self, self.ClearHomePosterTalk))
	self:RegistEventListener("POSTERGIRL_T0_MINIGAME_ENTER_STATE", function(...)
		self:OnMinigameEnterState(...)
	end)
end

function DanceGameView:HideRotateTips()
	SetActive(self.arrowAni_.gameObject, false)
end

function DanceGameView:ShowRotateTips()
	SetActive(self.arrowAni_.gameObject, true)
	self.arrowAni_:Play("DanceMachineUI_arrow", 0, 0)
end

function DanceGameView:OnMinigameEnterState(arg_16_1, arg_16_2)
	if isa(arg_16_1, require("manager.posterGirl.tgame.DanceGame.States.Include").PlayState) then
		self:SetVisible(true)
		self:StartViewHideTimer()
	else
		self:SetVisible(false)
	end
end

function DanceGameView:OnEnterAnimationFinish(arg_17_1)
	self.cutsceneSubView:StartCutscene(arg_17_1, function()
		self:ChangeBar()
	end)

	return true
end

function DanceGameView:StartViewHideTimer()
	self:StopTime()
	self:HideRotateTips()

	self.gameInst.lastInput = Time.time
	self.viewHideTimer_ = Timer.New(function()
		self:ShowRotateTips()
		self:StopTime()
	end, 5, 1)

	self.viewHideTimer_:Start()
end

function DanceGameView:AddUIListener()
	self:AddBtnListener(self.btnresetBtn_, nil, function()
		self:GotoFront()

		if self.gameInst.recordData[self.gameInst.lastAction] then
			self.gameInst.recordData[self.gameInst.lastAction][var_0_1.ToFrontCamPos] = self.gameInst.recordData[self.gameInst.lastAction][var_0_1.ToFrontCamPos] + 1
		end
	end)
	self:AddBtnListener(self.btnconvertBtn_, nil, function()
		self:GotoBack()

		if self.gameInst.recordData[self.gameInst.lastAction] then
			self.gameInst.recordData[self.gameInst.lastAction][var_0_1.ToBackCamPos] = self.gameInst.recordData[self.gameInst.lastAction][var_0_1.ToBackCamPos] + 1
		end
	end)
	self.trigger_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.PointerDown, LuaHelper.EventTriggerAction1(function(arg_24_0, arg_24_1)
		self:StartViewHideTimer()
	end))
	self.trigger_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.BeginDrag, LuaHelper.EventTriggerAction1(function(arg_25_0, arg_25_1)
		local var_25_0 = self:AnySceneObjAcceptDragInteract(arg_25_1)

		if not isNil(var_25_0) then
			self.draggingSceneObjTrigger = var_25_0

			LuaHelper.SendOnBeginDragToHandler(var_25_0, arg_25_1)

			if self.gameInst.recordData[self.gameInst.lastAction] then
				self.gameInst.recordData[self.gameInst.lastAction][var_0_1.DragInteract] = self.gameInst.recordData[self.gameInst.lastAction][var_0_1.DragInteract] + 1
			end
		end
	end))
	self.trigger_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.Drag, LuaHelper.EventTriggerAction1(function(arg_26_0, arg_26_1)
		if not isNil(self.draggingSceneObjTrigger) then
			LuaHelper.SendOnDragToHandler(self.draggingSceneObjTrigger, arg_26_1)
		else
			self:RotateCamera(arg_26_1)
		end
	end))
	self.trigger_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.EndDrag, LuaHelper.EventTriggerAction1(function(arg_27_0, arg_27_1)
		if not isNil(self.draggingSceneObjTrigger) then
			LuaHelper.SendOnEndDragToHandler(self.draggingSceneObjTrigger, arg_27_1)
		end

		self.draggingSceneObjTrigger = nil
	end))
	self:SetListener(self.trigger_)
	self:AddBtnListener(self.btnmodBtn_, nil, function()
		self.modeIndex = self.modeIndex == 2 and 3 or 2

		self:RefreshMode()
		manager.posterGirl.actor.cameraManager_:TweenCamComposerToCenter(nil)
	end)
end

local function var_0_2(arg_29_0, arg_29_1, arg_29_2)
	for iter_29_0 = 1, arg_29_0.Length do
		if arg_29_0[iter_29_0 - 1].enabled or arg_29_2 then
			local var_29_0 = arg_29_0[iter_29_0 - 1]:GetType():GetInterfaces()

			for iter_29_1 = 1, var_29_0.Length do
				if tostring(var_29_0[iter_29_1 - 1]) == arg_29_1 then
					return arg_29_0[iter_29_0 - 1]
				end
			end
		end
	end

	return nil
end

function DanceGameView:AnySceneObjAcceptDragInteract(arg_30_1)
	if manager.ui.mainCamera:GetComponent("PhysicsRaycaster") and arg_30_1 then
		local var_30_0 = UnityEngine.Physics.RaycastAll((UnityEngine.Camera.main:ScreenPointToRay(arg_30_1.position)))
		local var_30_1 = {}

		for iter_30_0 = 0, var_30_0.Length - 1 do
			table.insert(var_30_1, var_30_0[iter_30_0])
		end

		table.sort(var_30_1, function(arg_31_0, arg_31_1)
			return arg_31_0.distance < arg_31_1.distance
		end)

		for iter_30_1, iter_30_2 in ipairs(var_30_1) do
			local var_30_2 = var_0_2(iter_30_2.transform:GetComponentsInParent(typeof(UnityEngine.MonoBehaviour)), "UnityEngine.EventSystems.IDragHandler", false)

			if var_30_2 and var_30_2.gameObject.tag ~= "Obstacle" then
				return var_30_2
			end
		end
	end

	return nil
end

function DanceGameView:RefreshMode()
	self.btnControll:SetSelectedState(self.modeIndex == 2 and "mod2" or "mod1")
	self:SetCameraInputMode(self.modeIndex)
end

function DanceGameView:RotateCamera(arg_33_1)
	manager.posterGirl.actor.cameraManager_:RotateCamera((arg_33_1.delta / Time.deltaTime / 1000).x, (arg_33_1.delta / Time.deltaTime / 1000).y)
end

function DanceGameView:GotoFront()
	self:SetCameraUseCfg(manager.posterGirl.actor, 3)
end

function DanceGameView:GotoBack()
	self:SetCameraUseCfg(manager.posterGirl.actor, 4)
end

function DanceGameView:SetCameraUseCfg(arg_36_1, arg_36_2)
	arg_36_1.cameraManager_:TweenAllCamToCameraPosByCfgID(arg_36_2, 2, 3)
end

function DanceGameView:SetCameraInputMode(arg_37_1)
	manager.posterGirl.actor:SetCameraInputMode(arg_37_1)
end

function DanceGameView:ChangeBar()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		INFO_BAR
	})
	manager.windowBar:RegistBackCallBack(function()
		manager.windowBar:HideBar()
		self:Back()
	end)
	manager.windowBar:SetGameHelpKey({
		view = "gameHelpPro",
		type = "jump",
		params = {
			isPrefab = true,
			pages = GameSetting.brahma_t0_desc2.value
		}
	})
end

function DanceGameView:StopTime()
	if self.viewHideTimer_ then
		self.viewHideTimer_:Stop()

		self.viewHideTimer_ = nil
	end
end

function DanceGameView:Dispose()
	self.cutsceneSubView:Dispose()
	self.subtitleBubble:Dispose()
	DanceGameView.super.Dispose(self)
end

function DanceGameView:GetPlayBackwardsAnimator()
	return self.cutsceneSubView:GetPlayBackwardsAnimator(DanceGameManager.ExitGame)
end

function DanceGameView:ClearHomePosterTalk()
	self.subtitleBubble:Clear()
end

return DanceGameView
