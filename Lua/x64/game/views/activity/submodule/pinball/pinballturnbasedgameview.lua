local var_0_0 = class("PinballTurnBasedGameView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Activity_Hel/Activity_Hel_Pinball/Hel_Pinball_GamePlayUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()
end

function var_0_0.OnEnter(arg_5_0)
	manager.windowBar:HideBar()
	Timer.New(function()
		arg_5_0:UpdateBar()
	end, 2.5, 1):Start()

	local var_5_0 = GetPinballDataForExchange()

	PinballLuaBridge.InitTurnBasedPinballGame(arg_5_0.UIRootGo_, var_5_0)
	PinballAction.RecordStartTime()
	arg_5_0:OpenPhysicsRaycaster()

	arg_5_0.timer_ = Timer.New(function()
		local var_7_0, var_7_1 = GuideTool.CheckWeakGuide(arg_5_0.routeName_)

		if var_7_0 and arg_5_0.currentUIState_ == "LOADEND" then
			arg_5_0:RealCheckWeakGuide()
		end
	end, 1, -1):Start()
end

function var_0_0.UpdateBar(arg_8_0)
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
		local var_12_1 = PinballData:GetChallengeStageID() == PinballAction.PlayingStageID
		local var_12_2 = table.indexof(PinballData:GetDisplayStageList(), PinballAction.PlayingStageID)

		if var_12_1 then
			var_12_0 = {
				"Widget/System/Activity_Hel/Description/HelDescription_07"
			}
		else
			var_12_0 = {
				"Widget/System/Activity_Hel/Description/HelDescription_01",
				"Widget/System/Activity_Hel/Description/HelDescription_02",
				"Widget/System/Activity_Hel/Description/HelDescription_03"
			}

			if var_12_2 >= 3 then
				table.insert(var_12_0, "Widget/System/Activity_Hel/Description/HelDescription_04")
			end

			if var_12_2 >= 6 then
				table.insert(var_12_0, "Widget/System/Activity_Hel/Description/HelDescription_05")
			end

			if var_12_2 >= 9 then
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

function var_0_0.OpenPhysicsRaycaster(arg_13_0)
	arg_13_0.raycaster = manager.ui.mainCamera.gameObject:GetComponent(typeof(PhysicsRaycaster))

	if isNil(arg_13_0.raycaster) then
		arg_13_0.raycaster = manager.ui.mainCamera.gameObject:AddComponent(typeof(PhysicsRaycaster))
	end

	arg_13_0.raycaster.enabled = true
end

function var_0_0.Dispose(arg_14_0)
	if PinballBridge.hasSceneLoaded then
		PinballBridge:UnLoadScene()
	end

	var_0_0.super.Dispose(arg_14_0)
end

function var_0_0.OnExit(arg_15_0)
	manager.windowBar:HideBar()

	if arg_15_0.timer_ then
		arg_15_0.timer_:Stop()
	end
end

return var_0_0
