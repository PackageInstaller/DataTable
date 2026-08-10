local var_0_0 = import("..T0GameManagerBase")
local var_0_1 = class("DrawCardGameManager", var_0_0)
local var_0_2 = import(".States.Include")

function var_0_1.Ctor(arg_1_0)
	var_0_1.super.Ctor(arg_1_0)

	arg_1_0.totalRound = 3
end

function var_0_1.Init(arg_2_0)
	if arg_2_0.init then
		return
	end

	arg_2_0.init = true

	var_0_1.super.Init(arg_2_0)

	arg_2_0.startTime = manager.time:GetServerTime()
	arg_2_0.gameData = {
		lose = 0,
		win = 0,
		recordData = {}
	}

	manager.posterGirl:OpenPhysicsRaycaster()

	arg_2_0.raycaster = manager.posterGirl.raycaster

	manager.posterGirl:RefreshOtherModel(605603, "605603ui_custom", PosterGirlDlcActor, 1)

	arg_2_0.actors = {
		arg_2_0:GetCurMainActor(),
		arg_2_0:GetCurExtraActor(1)
	}

	arg_2_0.actors[2]:SetActive(false)
	arg_2_0:GoToState(var_0_2.EnterState)
end

function var_0_1.BindActorState(arg_3_0, arg_3_1, arg_3_2)
	if arg_3_0.actorState == nil or arg_3_2 then
		var_0_1.super.BindActorState(arg_3_0, arg_3_1)
	end
end

function var_0_1.SwapActor(arg_4_0)
	manager.posterGirl:SwapExtraActorToMainActor(1)
	arg_4_0:BindActorState(arg_4_0:GetCurMainActor():GetCurrentState(), true)
end

function var_0_1.WillGameOver(arg_5_0)
	local var_5_0 = arg_5_0.gameData
	local var_5_1 = var_5_0.win == arg_5_0.totalRound
	local var_5_2 = var_5_0.lose == arg_5_0.totalRound

	return var_5_1 or var_5_2, var_5_1, var_5_2
end

function var_0_1.Reset(arg_6_0)
	if arg_6_0.init then
		manager.audio:StopVoice()
		manager.audio:PlayEffect("ui_scene_102003", "ui_scene_102003_chair_game_stop")

		arg_6_0.init = nil
		arg_6_0.gameData = nil

		if not isNil(arg_6_0.raycaster) then
			-- block empty
		end

		if not arg_6_0:IsLittleChara() then
			arg_6_0:SwapActor()
		end

		arg_6_0.actorState = nil

		arg_6_0.actors[2]:Dispose()

		arg_6_0.actors = nil
	end

	var_0_1.super.Reset(arg_6_0)
end

function var_0_1.IsLittleChara(arg_7_0)
	return arg_7_0:GetCurMainActor().modelId == "102003ui_custom"
end

function var_0_1.StartGame()
	var_0_1.super.StartGameImpl(var_0_1)
end

function var_0_1.GetStateName(arg_9_0)
	return PosterGirlConst.StateKay.drawCardMiniGame
end

var_0_1.GameResult = {
	Canceled = 3,
	Lose = 2,
	Win = 1
}

function var_0_1.ExitGame(arg_10_0, arg_10_1)
	local var_10_0 = manager.posterGirl.actor
	local var_10_1 = var_10_0:GetCurrentState()

	if var_10_1 and var_10_1.gameInst then
		local var_10_2 = var_10_1.gameInst

		var_10_0 = var_10_2.actors[1]

		var_10_2:OnExitSendMsgToSDK(arg_10_1 or var_0_1.GameResult.Canceled)
		var_10_2:Reset()
	end

	if var_10_0 then
		var_10_0:ChangeState(arg_10_0 or PosterGirlConst.StateKay.init)
	end

	var_10_0:SetSelfCamera(0, true)
	manager.notify:Invoke(HOME_BTN_VISIBE, true)
	manager.posterGirl:SetStateCanChange(true)
	manager.posterGirl:ExitMiniGame()
end

function var_0_1.OnExitSendMsgToSDK(arg_11_0, arg_11_1)
	local var_11_0 = PlayerData:GetPosterGirlHeroSkinId()
	local var_11_1 = HomeSceneSettingData:GetCurScene()

	SDKTools.SendMessageToSDK("activity_combat_over", {
		stage_id = 2,
		sys_id = 101,
		skin_id = var_11_0,
		scene_id = var_11_1,
		result = arg_11_1,
		start_time = arg_11_0.startTime,
		battle_times = arg_11_0.gameData.win + arg_11_0.gameData.lose,
		other_data = SDKTools.JsonEncode(arg_11_0.gameData.recordData)
	})
end

return var_0_1
