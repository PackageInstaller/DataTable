local var_0_0 = import("...StateBase")
local var_0_1 = class("DrawCardGameManager.PlayState", var_0_0)
local var_0_2 = {
	{
		101
	},
	{
		102
	},
	{
		103
	}
}
local var_0_3 = {
	{
		head = {
			101
		},
		breast = {
			102
		},
		butt = {
			103
		}
	},
	{
		head = {
			104
		},
		breast = {
			105
		},
		butt = {
			106
		}
	},
	{
		head = {
			107
		},
		breast = {
			108
		},
		butt = {
			109
		}
	}
}

local function var_0_4(arg_1_0)
	if arg_1_0 >= 3 or arg_1_0 <= 0 then
		return 1
	else
		return arg_1_0 + 1
	end
end

local function var_0_5(arg_2_0, arg_2_1, arg_2_2)
	if arg_2_2 then
		return string.format("action1_2_%s_%d_game", arg_2_0, arg_2_1)
	end

	return string.format("game_sofa_%s_%d", arg_2_0, arg_2_1)
end

local function var_0_6(arg_3_0)
	return arg_3_0[math.random(#arg_3_0)]
end

local function var_0_7(arg_4_0, arg_4_1, arg_4_2, arg_4_3, arg_4_4)
	if arg_4_2 then
		local var_4_0 = var_0_6(arg_4_2)
		local var_4_1 = var_0_5(arg_4_1, var_4_0, arg_4_4)

		arg_4_0:DoAction(var_4_1, arg_4_3, true)

		return var_4_1
	else
		arg_4_3()
	end
end

function var_0_1.Enter(arg_5_0, arg_5_1, arg_5_2)
	arg_5_0.startPlay = false
	arg_5_0.gameInst = arg_5_1
	arg_5_1.lastInput = Time.time
	arg_5_0.choice = arg_5_2

	var_0_1.super.Enter(arg_5_0, arg_5_1)

	arg_5_1.lastAction = var_0_7(arg_5_1, "dance", var_0_2[arg_5_2], nil, true)

	arg_5_0:StartUpdate()
end

function var_0_1.Exit(arg_6_0, arg_6_1)
	var_0_1.super.Exit(arg_6_0, arg_6_1)
	arg_6_0:StopUpdate()
	arg_6_1:SetAllGuideEffect(false)
end

function var_0_1.StopUpdate(arg_7_0)
	if arg_7_0.updateScheduler then
		arg_7_0.updateScheduler:Stop()

		arg_7_0.updateScheduler = nil
	end
end

function var_0_1.StartUpdate(arg_8_0)
	arg_8_0:StopUpdate()

	arg_8_0.updateScheduler = FrameTimer.New(function()
		arg_8_0:Update()
	end, 1, -1)

	arg_8_0.updateScheduler:Start()
end

local var_0_8 = 0.2
local var_0_9 = 10

function var_0_1.Update(arg_10_0)
	local var_10_0 = arg_10_0.gameInst
	local var_10_1 = Time.time - var_10_0.lastInput
	local var_10_2 = not arg_10_0.startPlay and var_10_1 >= var_0_8

	var_10_0:UpdateAllGuideEffect(var_10_2)

	if var_10_1 >= var_0_9 then
		var_10_0.lastInput = Time.time

		arg_10_0:IdleToNextAction()
	end
end

function var_0_1.IdleToNextAction(arg_11_0)
	local var_11_0 = arg_11_0.gameInst
	local var_11_1 = require("manager.posterGirl.tgame.DanceGame.States.Include").ActionState
	local var_11_2 = var_0_6(var_0_2[arg_11_0.choice])
	local var_11_3 = 2
	local var_11_4 = string.format("action1_2_dance_%s_%d_game", var_11_2, var_11_3)

	var_11_0:GoToState(var_11_1, var_11_4, function()
		var_11_0:GoToState(var_0_1, var_0_4(arg_11_0.choice))
	end)
end

function var_0_1.PlayAction(arg_13_0, arg_13_1)
	local var_13_0 = arg_13_0.gameInst
	local var_13_1 = require("manager.posterGirl.tgame.DanceGame.States.Include").ActionState
	local var_13_2 = "game_sofa_touch"
	local var_13_3 = string.format("%s_%d", var_13_2, arg_13_1)

	var_13_0:GoToState(var_13_1, var_13_3, function()
		var_13_0:DoAction("action1_2_game", function()
			var_13_0:GoToState(var_0_1, var_0_4(arg_13_0.choice))
		end, true)
	end)
	var_13_0:PlayTalk(var_13_2, var_13_3)
end

local var_0_10 = {
	head = 1,
	breast = 2,
	butt = 3
}

function var_0_1.OnDanceTouch(arg_16_0, arg_16_1, arg_16_2)
	if not arg_16_1:CheckInRange(arg_16_2) then
		return
	end

	local var_16_0 = nullable(var_0_3, arg_16_0.choice, arg_16_2)

	if var_16_0 then
		local var_16_1 = arg_16_0.gameInst.recordData[arg_16_1.lastAction]

		if var_16_1 then
			var_16_1[var_0_10[arg_16_2]] = var_16_1[var_0_10[arg_16_2]] + 1
		end

		local var_16_2 = var_16_0[math.random(#var_16_0)]

		arg_16_0:PlayAction(var_16_2)
	end
end

var_0_1.events = {
	ON_TOUCH_FINISH = var_0_1.OnDanceTouch
}

return var_0_1
