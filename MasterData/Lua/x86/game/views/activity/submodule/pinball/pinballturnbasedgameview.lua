local PinballTurnBasedGameView = class("PinballTurnBasedGameView", ReduxView)

function PinballTurnBasedGameView:UIName()
	return "Widget/System/Activity_Hel/Activity_Hel_Pinball/Hel_Pinball_GamePlayUI"
end

function PinballTurnBasedGameView:UIParent()
	return manager.ui.uiMain.transform
end

function PinballTurnBasedGameView:Init()
	self:InitUI()
end

function PinballTurnBasedGameView:InitUI()
	self:BindCfgUI()
end

function PinballTurnBasedGameView:OnEnter()
	manager.windowBar:HideBar()
	Timer.New(function()
		self:UpdateBar()
	end, 2.5, 1):Start()
	PinballLuaBridge.InitTurnBasedPinballGame(self.UIRootGo_, (GetPinballDataForExchange()))
	PinballAction.RecordStartTime()
	self:OpenPhysicsRaycaster()

	self.timer_ = Timer.New(function()
		local var_7_0, var_7_1 = GuideTool.CheckWeakGuide(self.routeName_)

		if var_7_0 and self.currentUIState_ == "LOADEND" then
			self:RealCheckWeakGuide()
		end
	end, 1, -1):Start()
end

function PinballTurnBasedGameView:UpdateBar()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		INFO_BAR
	})
	manager.windowBar:RegistBackCallBack(function()
		ShowMessageBox({
			prefabPath = "Widget/System/Activity_Hel/Activity_Hel_Pinball/Hel_Pinball_Warning",
			title = GetTips("PROMPT"),
			content = GetTips("PINBALL_STAGE_GIVE_UP"),
			OkCallback = function()
				PinballLuaBridge.InterruptExitGame()
				PinballBridge:Enter(PinballGame, {
					isEnter = true,
					isEnterHome = true
				})
			end,
			CancelCallback = function()
				return
			end
		})

		return true
	end)
	manager.windowBar:RegistInfoCallBack(function()
		local var_12_0 = {}
		local var_12_1 = table.indexof(PinballData:GetDisplayStageList(), PinballAction.PlayingStageID)

		if PinballData:GetChallengeStageID() == PinballAction.PlayingStageID then
			var_12_0 = {
				"Widget/System/Activity_Hel/Description/HelDescription_07"
			}
		else
			var_12_0 = {
				"Widget/System/Activity_Hel/Description/HelDescription_01",
				"Widget/System/Activity_Hel/Description/HelDescription_02",
				"Widget/System/Activity_Hel/Description/HelDescription_03"
			}

			if var_12_1 >= 3 then
				table.insert(var_12_0, "Widget/System/Activity_Hel/Description/HelDescription_04")
			end

			if var_12_1 >= 6 then
				table.insert(var_12_0, "Widget/System/Activity_Hel/Description/HelDescription_05")
			end

			if var_12_1 >= 9 then
				table.insert(var_12_0, "Widget/System/Activity_Hel/Description/HelDescription_06")
			end
		end

		if var_12_0 then
			JumpTools.OpenPageByJump("gameHelpPro", {
				isPrefab = true,
				pages = var_12_0
			})
		end
	end)
end

function PinballTurnBasedGameView:OpenPhysicsRaycaster()
	self.raycaster = manager.ui.mainCamera.gameObject:GetComponent(typeof(PhysicsRaycaster))

	if isNil(self.raycaster) then
		self.raycaster = manager.ui.mainCamera.gameObject:AddComponent(typeof(PhysicsRaycaster))
	end

	self.raycaster.enabled = true
end

function PinballTurnBasedGameView:Dispose()
	if PinballBridge.hasSceneLoaded then
		PinballBridge:UnLoadScene()
	end

	PinballTurnBasedGameView.super.Dispose(self)
end

function PinballTurnBasedGameView:OnExit()
	manager.windowBar:HideBar()

	if self.timer_ then
		self.timer_:Stop()
	end
end

return PinballTurnBasedGameView
