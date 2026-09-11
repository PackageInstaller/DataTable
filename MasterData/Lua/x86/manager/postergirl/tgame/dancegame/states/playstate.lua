local var_0_0 = class("DrawCardGameManager.PlayState", (import("...StateBase")))
local var_0_1 = {
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
local var_0_2 = {
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

local function var_0_3(arg_1_0)
	if arg_1_0 >= 3 or arg_1_0 <= 0 then
		return 1
	else
		return arg_1_0 + 1
	end
end

local function var_0_4(arg_2_0, arg_2_1, arg_2_2)
	if arg_2_2 then
		return string.format("action1_2_%s_%d_game", arg_2_0, arg_2_1)
	end

	return string.format("game_sofa_%s_%d", arg_2_0, arg_2_1)
end

local function var_0_5(arg_3_0)
	return arg_3_0[math.random(#arg_3_0)]
end

local function var_0_6(arg_4_0, arg_4_1, arg_4_2, arg_4_3, arg_4_4)
	if arg_4_2 then
		local var_4_0 = var_0_4(arg_4_1, var_0_5(arg_4_2), arg_4_4)

		arg_4_0:DoAction(var_4_0, arg_4_3, true)

		return var_4_0
	else
		arg_4_3()
	end
end

function var_0_0:Enter(arg_5_1, arg_5_2)
	self.startPlay = false
	self.gameInst = arg_5_1
	arg_5_1.lastInput = Time.time
	self.choice = arg_5_2

	var_0_0.super.Enter(self, arg_5_1)

	arg_5_1.lastAction = var_0_6(arg_5_1, "dance", var_0_1[arg_5_2], nil, true)

	self:StartUpdate()
end

function var_0_0:Exit(arg_6_1)
	var_0_0.super.Exit(self, arg_6_1)
	self:StopUpdate()
	arg_6_1:SetAllGuideEffect(false)
end

function var_0_0:StopUpdate()
	if self.updateScheduler then
		self.updateScheduler:Stop()

		self.updateScheduler = nil
	end
end

function var_0_0:StartUpdate()
	self:StopUpdate()

	self.updateScheduler = FrameTimer.New(function()
		self:Update()
	end, 1, -1)

	self.updateScheduler:Start()
end

local var_0_7 = 0.2
local var_0_8 = 10

function var_0_0:Update()
	local var_10_0 = Time.time - self.gameInst.lastInput

	self.gameInst:UpdateAllGuideEffect(not self.startPlay and var_10_0 >= var_0_7)

	if var_10_0 >= var_0_8 then
		self.gameInst.lastInput = Time.time

		self:IdleToNextAction()
	end
end

function var_0_0:IdleToNextAction()
	local var_11_0 = self.gameInst

	self.gameInst:GoToState(require("manager.posterGirl.tgame.DanceGame.States.Include").ActionState, string.format("action1_2_dance_%s_%d_game", var_0_5(var_0_1[self.choice]), 2), function()
		var_11_0:GoToState(var_0_0, var_0_3(self.choice))
	end)
end

function var_0_0:PlayAction(arg_13_1)
	local var_13_0 = self.gameInst
	local var_13_1 = string.format("%s_%d", "game_sofa_touch", arg_13_1)

	self.gameInst:GoToState(require("manager.posterGirl.tgame.DanceGame.States.Include").ActionState, var_13_1, function()
		var_13_0:DoAction("action1_2_game", function()
			var_13_0:GoToState(var_0_0, var_0_3(self.choice))
		end, true)
	end)
	self.gameInst:PlayTalk("game_sofa_touch", var_13_1)
end

local var_0_9 = {
	head = 1,
	breast = 2,
	butt = 3
}

function var_0_0:OnDanceTouch(arg_16_1, arg_16_2)
	if not arg_16_1:CheckInRange(arg_16_2) then
		return
	end

	local var_16_0 = nullable(var_0_2, self.choice, arg_16_2)

	if var_16_0 then
		if self.gameInst.recordData[arg_16_1.lastAction] then
			self.gameInst.recordData[arg_16_1.lastAction][var_0_9[arg_16_2]] = self.gameInst.recordData[arg_16_1.lastAction][var_0_9[arg_16_2]] + 1
		end

		self:PlayAction(var_16_0[math.random(#var_16_0)])
	end
end

var_0_0.events = {
	ON_TOUCH_FINISH = var_0_0.OnDanceTouch
}

return var_0_0
