local var_0_0 = {
	HZ07_lianliankan = LianLianKanBridge,
	HZ07_diaoyu1 = FishingGameBridge,
	HZ07_xueqiu1 = SnowballGameBridge,
	HZ07_tuanxue1 = PushSnowBallGameBridge,
	WT_RK = IdolTraineeCampBridge,
	HZ07_kaorou1 = BarbuceGameBridge,
	HZ07_jiali2 = TugGameBridge,
	HZ07_jiali1 = SpShootGameBridge,
	PinballGame = PinballBridge
}

function OnEnterMiniGameScene(arg_1_0)
	DormLuaBridge.CalcDormSpawnBounds()
	Dorm.Enter()
	LuaForUtil.UpdateCameraSetting()
	manager.uiInit()
	manager.windowBar:SetWhereTag("minigame")

	Dorm.storage = DormStorage.GetInstance()

	Dorm.storage:Reset()

	Dorm.sceneItemInfo = {}
	Dorm.subtitleViewStack = {}

	DormLuaBridge.RecordInfoFromDormTag()
	DormUtils.MapSceneItemTagInfo()
	DormCharacterActionManager:Init()
	DormCharacterInteractBehaviour:Init()

	DormMinigame.sceneName = arg_1_0
	DormMinigame.minigame, DormMinigame.nextMinigame = DormMinigame.nextMinigame
	DormMinigame.launchArgs, DormMinigame.nextLaunchArgs = DormMinigame.nextLaunchArgs

	local var_1_0 = nullable(DormMinigame.minigame, "Enter")

	if var_1_0 then
		var_1_0(DormMinigame.minigame, arg_1_0, DormMinigame.launchArgs)
	end
end

function OnExitMiniGameScene(arg_2_0, arg_2_1)
	DormMinigame.SetGlobalTimeScale(1)

	local var_2_0 = DormMinigame.minigame
	local var_2_1 = nullable(var_2_0, "Exit")

	if var_2_1 then
		var_2_1(var_2_0, arg_2_0, arg_2_1)
	end

	DormMinigame.launchArgs = nil
	Dorm.subtitleViewStack = nil
	DormMinigame.minigame = nil

	if arg_2_0 == DormMinigame.sceneName then
		DormMinigame.sceneName = nil
	end

	DormCharacterInteractBehaviour:Reset()
	DormCharacterActionManager:Reset()
	Dorm.storage:Reset()

	Dorm.sceneItemInfo = nil

	manager.windowBar:ClearWhereTag()
	DestroyLua()
	Dorm.Leave()
end

DormMinigame = {}

function DormMinigame.LaterBack()
	return {
		backTo = {
			sceneName = DormMinigame.sceneName,
			minigameClass = DormMinigame.minigame,
			kwargs = DormMinigame.launchArgs
		}
	}
end

function DormMinigame.Launch(arg_4_0, arg_4_1, arg_4_2)
	if LuaExchangeHelper.GetSceneIsHanding() then
		return
	end

	DormMinigame.nextMinigame = arg_4_1 or var_0_0[arg_4_0]
	DormMinigame.nextLaunchArgs = arg_4_2

	Dorm.LuaBridge.MiniGameBridge.Launch(arg_4_0)
	DestroyLua()
	gameContext:SetSystemLayer("battle")
end

function DormMinigame.Exit(arg_5_0)
	if LuaExchangeHelper.GetSceneIsHanding() then
		return
	end

	arg_5_0 = arg_5_0 or BACK_BAR

	local var_5_0
	local var_5_1

	if arg_5_0 == HOME_BAR then
		var_5_0, var_5_1 = nil
	else
		var_5_0 = nullable(DormMinigame.launchArgs, "activity")
		var_5_1 = nullable(DormMinigame.launchArgs, "backTo")
	end

	DestroyLua()

	if var_5_1 and var_5_1.sceneName then
		DormMinigame.Launch(var_5_1.sceneName, var_5_1.minigameClass, var_5_1.kwargs)
	else
		LuaExchangeHelper.GoToMain()

		if var_5_0 then
			ActivityTools.JumpBackToActivityMainViewByActivityID(var_5_0)
		else
			OpenPageUntilLoaded("/home")
		end
	end
end

function DormMinigame.AdjustCameraFOV(arg_6_0, arg_6_1)
	local var_6_0 = 1 / arg_6_0 / (Screen.width / Screen.height)
	local var_6_1 = arg_6_1 or manager.ui.mainCameraCom_.fieldOfView
	local var_6_2 = math.max(var_6_0 * var_6_1, var_6_1)

	manager.ui.mainCameraCom_.fieldOfView = var_6_2
end

function DormMinigame.GetCurBridgeCls()
	return DormMinigame.minigame
end

function DormMinigame.SetGlobalTimeScale(arg_8_0)
	Time.timeScale = arg_8_0
end
