local var_0_0 = class("IslandMinigameCore", import(".IslandCore"))

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	var_0_0.super.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)

	arg_1_0.showBalance = arg_1_3

	return
end

function var_0_0.SetIslandViewCoponent(arg_2_0, arg_2_1)
	arg_2_0.viewCoponent = arg_2_1

	return
end

function var_0_0.SetIsReconected(arg_3_0, arg_3_1)
	arg_3_0.isReconected = arg_3_1

	return
end

function var_0_0.OnInit(arg_4_0)
	arg_4_0:LoadMiniGameMainPage()

	return
end

function var_0_0.GetSceneLoader(arg_5_0)
	return IslandMiniGameSceneLoader.New()
end

function var_0_0.Update(arg_6_0)
	if not arg_6_0:IsInit() then
		return
	end

	arg_6_0.controller:Update()
	arg_6_0.view:Update()

	if arg_6_0.callback and arg_6_0.view:IsLoaded() and arg_6_0.miniGameUILoaded then
		Timer.New(function()
			if arg_6_0.isReconected then
				pg.m02:sendNotification(GAME.PLAY_ROOM_ALL_LOAD_OVER)
			else
				pg.m02:sendNotification(GAME.PLAY_ROOM_LOAD_SCENE_COMPLETE)
			end

			return
		end, 2, 0):Start()
		arg_6_0.callback()

		arg_6_0.callback = nil
	end

	if arg_6_0.initCallback and arg_6_0.view:IsInit() then
		arg_6_0.initCallback()

		arg_6_0.initCallback = nil
	end

	return
end

function var_0_0.OnChangeMiniGameScene(arg_8_0, arg_8_1)
	if arg_8_1 then
		setActive(arg_8_0.miniGameUI, true)
		arg_8_0.viewCoponent:OpenPage(IslandCheaterTavernMainPage, arg_8_0.miniGameUI, isReConnected)
		onNextTick(function()
			arg_8_0.view:AfterCoreInit()

			if arg_8_0.isReconected then
				pg.m02:sendNotification(GAME.ISLAND_CHEATER_RECONECTING)
			end

			return
		end)
	else
		CheatTavernCameraMgr.instance._mainCamera.enabled = false

		arg_8_0.viewCoponent:OpenPage(IslandCheaterTavernMainPage, arg_8_0.miniGameUI, isReConnected)

		CheatTavernCameraMgr.instance._mainCamera.enabled = true
	end

	return
end

function var_0_0.LoadMiniGameMainPage(arg_10_0)
	arg_10_0.miniGameUI = nil
	arg_10_0.miniGameUILoaded = false

	PoolMgr.GetInstance():GetUI(arg_10_0:GetMiniGameUI(), true, function(arg_11_0)
		arg_10_0.miniGameUILoaded = true
		arg_10_0.miniGameUI = arg_11_0

		arg_10_0.viewCoponent:SetUIParent(arg_10_0.miniGameUI)
		setActive(arg_10_0.miniGameUI, false)

		return
	end)

	return
end

function var_0_0.GetMiniGameUI(arg_12_0)
	return "IslandCheaterTavernMainUI"
end

function var_0_0.Dispose(arg_13_0, arg_13_1)
	var_0_0.super.Dispose(arg_13_0, arg_13_1)
	GameObject.Destroy(arg_13_0.miniGameUI)

	return
end

return var_0_0
