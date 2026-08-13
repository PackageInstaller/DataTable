class = var_0_10000

local var_0_0 = "IslandMinigameCore"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".IslandCore"))

function var_0_1.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	var_0_1.super.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)

	arg_1_0.showBalance = arg_1_3

	return
end

function var_0_1.SetIslandViewCoponent(arg_2_0, arg_2_1)
	arg_2_0.viewCoponent = arg_2_1

	return
end

function var_0_1.SetIsReconected(arg_3_0, arg_3_1)
	arg_3_0.isReconected = arg_3_1

	return
end

function var_0_1.OnInit(arg_4_0)
	arg_4_0:LoadMiniGameMainPage()

	return
end

function var_0_1.GetSceneLoader(arg_5_0)
	IslandMiniGameSceneLoader = var_1_10001

	return var_1_10001.New()
end

function var_0_1.Update(arg_6_0)
	if not arg_6_0:IsInit() then
		return
	end

	local var_6_0 = arg_6_0.controller

	var_1.Update(var_6_0)

	local var_6_1 = arg_6_0.view

	var_1.Update(var_6_1)

	if arg_6_0.callback then
		local var_6_2 = arg_6_0.view

		if var_1.IsLoaded(var_6_2) and arg_6_0.miniGameUILoaded then
			Timer = var_1

			local var_6_3 = var_1.New(function()
				local var_7_1

				if arg_6_0.isReconected then
					pg = var_7_1

					local var_7_0 = var_7_1.m02

					var_7_1 = var_7_1.sendNotification
					GAME = var_2_10003

					var_7_1(var_7_0, var_2_10003.PLAY_ROOM_ALL_LOAD_OVER)
				else
					pg = var_7_1

					local var_7_2 = var_7_1.m02
					local var_7_3 = var_0.sendNotification

					GAME = var_2_10003

					var_7_3(var_7_2, var_2_10003.PLAY_ROOM_LOAD_SCENE_COMPLETE)
				end

				return
			end, 2, 0)

			var_1.Start(var_6_3)
			arg_6_0.callback()

			arg_6_0.callback = nil
		end
	end

	if arg_6_0.initCallback then
		local var_6_4 = arg_6_0.view

		if var_1.IsInit(var_6_4) then
			arg_6_0.initCallback()

			arg_6_0.initCallback = nil
		end
	end

	return
end

function var_0_1.OnChangeMiniGameScene(arg_8_0, arg_8_1)
	if arg_8_1 then
		setActive = var_1_10002

		var_1_10002(arg_8_0.miniGameUI, true)

		local var_8_0 = arg_8_0.viewCoponent

		var_1_10002 = var_1_10002.OpenPage
		IslandCheaterTavernMainPage = var_1_10005

		local var_8_1 = arg_8_0.miniGameUI

		isReConnected = var_1_10007

		var_1_10002(var_8_0, var_1_10005, var_8_1, var_1_10007)

		onNextTick = var_1_10002

		var_1_10002(function()
			local var_9_0 = arg_8_0.view

			var_0.AfterCoreInit(var_9_0)

			if arg_8_0.isReconected then
				pg = var_0

				local var_9_1 = var_0.m02
				local var_9_2 = var_0.sendNotification

				GAME = var_2_10003

				var_9_2(var_9_1, var_2_10003.ISLAND_CHEATER_RECONECTING)
			end

			return
		end)
	else
		CheatTavernCameraMgr = var_1_10002
		var_1_10002.instance._mainCamera.enabled = false

		local var_8_2 = arg_8_0.viewCoponent
		local var_8_3 = var_2.OpenPage

		IslandCheaterTavernMainPage = var_1_10005

		local var_8_4 = arg_8_0.miniGameUI

		isReConnected = var_1_10007

		var_8_3(var_8_2, var_1_10005, var_8_4, var_1_10007)

		CheatTavernCameraMgr = var_8_3
		var_8_3.instance._mainCamera.enabled = true
	end

	return
end

function var_0_1.LoadMiniGameMainPage(arg_10_0)
	arg_10_0.miniGameUI = nil
	arg_10_0.miniGameUILoaded = false
	PoolMgr = var_1

	local var_10_0 = var_1.GetInstance()

	var_1.GetUI(var_10_0, arg_10_0:GetMiniGameUI(), true, function(arg_11_0)
		arg_10_0.miniGameUILoaded = true
		arg_10_0.miniGameUI = arg_11_0

		local var_11_0 = arg_10_0.viewCoponent

		var_1.SetUIParent(var_11_0, arg_10_0.miniGameUI)

		setActive = var_1

		var_1(arg_10_0.miniGameUI, false)

		return
	end)

	return
end

function var_0_1.GetMiniGameUI(arg_12_0)
	return "IslandCheaterTavernMainUI"
end

function var_0_1.Dispose(arg_13_0, arg_13_1)
	var_0_1.super.Dispose(arg_13_0, arg_13_1)

	GameObject = var_2

	var_2.Destroy(arg_13_0.miniGameUI)

	return
end

return var_0_1
