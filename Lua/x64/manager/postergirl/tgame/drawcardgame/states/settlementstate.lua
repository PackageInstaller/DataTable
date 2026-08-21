local var_0_0 = import("...StateBase")
local var_0_1 = class("DrawCardGameManager.SettlementState", var_0_0)

local function var_0_2(arg_1_0, arg_1_1, arg_1_2)
	if arg_1_1 then
		arg_1_0:DoAction("game_chair_lose_201", arg_1_2)
		arg_1_0:PlayTalk("game_chair_lose")
	elseif arg_1_0:IsLittleChara() then
		arg_1_0:DoAction("game_chair_end_101", arg_1_2)
		arg_1_0:PlayTalk("game_chair_end", "game_chair_end_101")
	else
		arg_1_0:DoAction("game_chair_end_201", function()
			arg_1_0:SwapActor()
			arg_1_0.actors[2]:SetActive(false)
			arg_1_0:DoActionByActor(arg_1_0.actors[1], "game_chair_end_102", arg_1_2)
			arg_1_0:PlayTalk("game_chair_end", "game_chair_end_102")
		end)
		arg_1_0:PlayTalk("game_chair_end", "game_chair_end_201")
	end
end

local function var_0_3(arg_3_0, arg_3_1, arg_3_2)
	local var_3_0
	local var_3_1

	if arg_3_1 then
		var_3_0 = "game_chair_lose"
		var_3_1 = arg_3_0.gameData.win
	else
		var_3_0 = "game_chair_win"
		var_3_1 = arg_3_0.gameData.lose
	end

	local var_3_2 = arg_3_0:IsLittleChara() and 1 or 2
	local var_3_3 = string.format("%s_%d%02d", var_3_0, var_3_2, var_3_1)

	arg_3_0:DoAction(var_3_3, arg_3_2)
	arg_3_0:PlayTalk(var_3_0, var_3_3)
end

local function var_0_4(arg_4_0, arg_4_1)
	return deferred.new(function(arg_5_0)
		local var_5_0
		local var_5_1, var_5_2 = arg_4_0:WillGameOver()

		local function var_5_3()
			arg_5_0:resolve()
		end

		if var_5_1 then
			var_0_2(arg_4_0, var_5_2, var_5_3)
		else
			var_0_3(arg_4_0, arg_4_1, var_5_3)
		end
	end)
end

local function var_0_5(arg_7_0, arg_7_1)
	if arg_7_1 then
		arg_7_0.gameData.win = arg_7_0.gameData.win + 1
	else
		arg_7_0.gameData.lose = arg_7_0.gameData.lose + 1
	end

	table.insert(arg_7_0.gameData.recordData, arg_7_1 and 1 or 0)
end

function var_0_1.Enter(arg_8_0, arg_8_1, arg_8_2)
	local var_8_0 = require("manager.posterGirl.tgame.DrawCardGame.States.Include")

	var_0_1.super.Enter(arg_8_0, arg_8_1)
	var_0_5(arg_8_1, arg_8_2)

	arg_8_0.progress = 0

	manager.notify:Invoke(REFRESH_DRAW_CARD_INFO, arg_8_1.gameData, true)
	manager.posterGirl.actor:GetHeroTimelineMgr():SetCallbackByTime("game_chair_lose_102", 21.5, function()
		manager.notify:Invoke(DRAW_CARD_TIPS, true, 1)
	end)
	manager.posterGirl.actor:GetHeroTimelineMgr():SetCallbackByTime("game_chair_lose_201", 18, function()
		manager.notify:Invoke(DRAW_CARD_TIPS, true, 2)
	end)
	deferred.all({
		var_0_4(arg_8_1, arg_8_2),
		arg_8_0:Wait(arg_8_1, arg_8_2)
	}):next(function()
		manager.notify:Invoke(REFRESH_DRAW_CARD_INFO, arg_8_1.gameData)

		local var_11_0, var_11_1 = arg_8_1:WillGameOver()

		if var_11_0 then
			local var_11_2 = var_8_0.ExitState

			arg_8_1:GoToState(var_11_2, var_11_1)
		elseif arg_8_1.gameData.win == arg_8_1.totalRound - 1 and arg_8_1.gameData.matchPoint == nil then
			local var_11_3 = var_8_0.MatchPointPerformanceState

			arg_8_1:GoToState(var_11_3)
		else
			local var_11_4 = var_8_0.DrawCardState

			arg_8_1:GoToState(var_11_4)
		end

		if arg_8_0.waitInput then
			arg_8_0.waitInput = nil
		end
	end, function(arg_12_0)
		for iter_12_0, iter_12_1 in ipairs(arg_12_0) do
			Debug.LogError(iter_12_1)
		end
	end)
end

function var_0_1.Exit(arg_13_0, arg_13_1)
	arg_13_0:StopDragSoundFX()

	arg_13_0.progress = 1
end

function var_0_1.Wait(arg_14_0, arg_14_1, arg_14_2)
	local var_14_0 = arg_14_1.gameData

	if not arg_14_2 or var_14_0.win <= 1 then
		return nil
	end

	if arg_14_0.waitInput == nil then
		arg_14_0.waitInput = deferred.new()
	end

	return arg_14_0.waitInput
end

local var_0_6 = {
	game_chair_lose_102 = 27.2,
	game_chair_lose_201 = 23
}
local var_0_7 = 2.966667

function var_0_1.OnDragFinish(arg_15_0, arg_15_1)
	local var_15_0 = manager.posterGirl.actor:GetHeroTimelineMgr():_GetTimeline().actionName_

	if var_0_6[var_15_0] then
		manager.posterGirl.actor:GetHeroTimelineMgr():JumpToTime(var_0_6[var_15_0], true)
		manager.posterGirl.actor:GetHeroTimelineMgr():JumpToTime(var_0_6[var_15_0] - var_0_7)
	end

	arg_15_0:StopDragSoundFX()
	manager.notify:Invoke(DRAW_CARD_TIPS, false)

	if arg_15_0.waitInput then
		arg_15_0.waitInput:resolve()

		arg_15_0.waitInput = nil
	end
end

var_0_1.DRAG_PLAY_SOUND_FX = 0.2
var_0_1.DRAG_STOP_SOUND_FX = 0.15

function var_0_1.OnDragInProgress(arg_16_0, arg_16_1, arg_16_2)
	if manager.posterGirl.actor:GetHeroTimelineMgr():_GetTimeline().actionName_ ~= "game_chair_lose_102" then
		return
	end

	local var_16_0 = math.abs(arg_16_2 - arg_16_0.progress) / Time.deltaTime

	if var_16_0 > var_0_1.DRAG_PLAY_SOUND_FX then
		arg_16_0:StartDragSoundFX()
	elseif var_16_0 < var_0_1.DRAG_STOP_SOUND_FX then
		arg_16_0:StopDragSoundFX()
	end

	arg_16_0.progress = arg_16_2
end

function var_0_1.OnDragEnd(arg_17_0, arg_17_1)
	arg_17_0:StopDragSoundFX()
end

function var_0_1.StartDragSoundFX(arg_18_0)
	if not arg_18_0.playDragFx then
		manager.audio:PlayEffect("ui_scene_102003", "ui_scene_102003_chair_game_lose_102_loop")

		arg_18_0.playDragFx = true
	end
end

function var_0_1.StopDragSoundFX(arg_19_0)
	if arg_19_0.playDragFx then
		manager.audio:PlayEffect("ui_scene_102003", "ui_scene_102003_chair_game_lose_102_loop_stop")

		arg_19_0.playDragFx = false
	end
end

var_0_1.events = {
	ON_DRAG_FINISH = var_0_1.OnDragFinish,
	ON_DRAG_IN_PROGRESS = var_0_1.OnDragInProgress,
	ON_DRAG_END = var_0_1.OnDragEnd
}

return var_0_1
