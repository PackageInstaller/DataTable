local var_0_0 = import("...StateBase")
local var_0_1 = class("DrawCardGameManager.DrawCardState", var_0_0)

local function var_0_2(arg_1_0)
	return string.format("game_chair_%s", arg_1_0)
end

local function var_0_3(arg_2_0, arg_2_1)
	return string.format("game_chair_%s_%d", arg_2_0, arg_2_1)
end

local function var_0_4(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	if arg_3_2 then
		local var_3_0 = arg_3_2[math.random(#arg_3_2)]
		local var_3_1 = var_0_3(arg_3_1, var_3_0)

		arg_3_0:DoAction(var_3_1, arg_3_3, false, 0.3)
		arg_3_0:PlayTalk(var_0_2(arg_3_1), var_3_1)
	else
		arg_3_3()
	end
end

local function var_0_5(arg_4_0)
	if DrawCardGameManager.debug then
		return {
			true,
			false
		}
	else
		local var_4_0 = math.random(arg_4_0)
		local var_4_1 = {}

		for iter_4_0 = 1, arg_4_0 do
			var_4_1[iter_4_0] = iter_4_0 == var_4_0
		end

		return var_4_1
	end
end

function var_0_1.Enter(arg_5_0, arg_5_1)
	arg_5_0.confirm = false

	var_0_1.super.Enter(arg_5_0, arg_5_1)

	arg_5_0.cards = var_0_5(2)

	local var_5_0 = arg_5_1:IsLittleChara() and "action1_1_game" or "action2_1_game"

	arg_5_1:DoAction(var_5_0, nil, true, 0)
	arg_5_1:PlayTalk(var_5_0)
end

function var_0_1.Exit(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_1:GetCurMainActor()

	arg_6_0:ClearSelectCardEfx(var_6_0)

	arg_6_0.select = nil
	arg_6_0.lastPlayActionTime = nil
end

local var_0_6 = {
	{
		select = {
			102,
			103
		},
		cancel = {
			101
		}
	},
	{
		select = {
			104,
			105
		},
		cancel = {
			101
		}
	},
	{
		select = {
			202,
			203
		},
		cancel = {
			201
		}
	}
}
local var_0_7 = 2

function var_0_1.OnPrepareDraw(arg_7_0, arg_7_1, arg_7_2)
	if arg_7_0.confirm then
		return arg_7_0.select
	end

	local var_7_0 = arg_7_0.lastPlayActionTime or 0
	local var_7_1 = Time.time

	if var_7_1 - var_7_0 <= var_0_7 then
		return arg_7_0.select
	end

	local var_7_2 = arg_7_1:GetCurMainActor()

	arg_7_0:SetSelectCardEfx(var_7_2, arg_7_2)

	local var_7_3 = nullable(var_0_6, arg_7_1.gameData.win + 1, "select")

	if var_7_3 then
		local var_7_4 = var_7_3[math.random(#var_7_3)]

		arg_7_1:DoAction(var_0_3("face", var_7_4), function()
			return
		end, false, 0.5)

		arg_7_0.lastPlayActionTime = var_7_1
	end

	return arg_7_2
end

function var_0_1.OnCancelDraw(arg_9_0, arg_9_1)
	if arg_9_0.confirm then
		return nil
	end

	local var_9_0 = arg_9_1:GetCurMainActor()

	arg_9_0:ClearSelectCardEfx(var_9_0)

	local var_9_1 = nullable(var_0_6, arg_9_1.gameData.win + 1, "cancel")

	var_0_4(arg_9_1, "face", var_9_1, function()
		local var_10_0 = arg_9_1:IsLittleChara() and "action1_1_game" or "action2_1_game"

		arg_9_1:DoAction(var_10_0, function()
			arg_9_1:PlayTalk(var_10_0)
		end, false, 0)
	end)

	return nil
end

function var_0_1.ClearSelectCardEfx(arg_12_0, arg_12_1)
	if not isNil(arg_12_0.selCardEfx) then
		arg_12_1:StopEffect(arg_12_0.selCardEfx)

		arg_12_0.selCardEfx = nil
	end
end

function var_0_1.SetSelectCardEfx(arg_13_0, arg_13_1, arg_13_2)
	arg_13_0:ClearSelectCardEfx(arg_13_1)

	local var_13_0 = string.format("card_%d", arg_13_2)
	local var_13_1
	local var_13_2 = arg_13_1:GetModelId() == "102003ui_custom" and "Effect/Scene/fx_x204_card_01" or "Effect/Scene/fx_x204_card_02"

	arg_13_0.selCardEfx = arg_13_1:PlayEffect(var_13_2, var_13_0, math.huge)
end

local var_0_8 = {
	{
		lose = {
			102
		},
		lose_matchpoint = {
			104
		},
		win = {
			101
		}
	},
	{
		lose = {
			102
		},
		lose_matchpoint = {
			104
		},
		win = {
			103
		}
	},
	{
		lose = {
			202
		},
		lose_matchpoint = {
			202
		},
		win = {
			201
		}
	}
}

function var_0_1.OnDrawCard(arg_14_0, arg_14_1, arg_14_2)
	arg_14_0.confirm = true

	local var_14_0 = arg_14_1:GetCurMainActor()

	arg_14_0:ClearSelectCardEfx(var_14_0)

	local var_14_1 = require("manager.posterGirl.tgame.DrawCardGame.States.Include").SettlementState
	local var_14_2 = arg_14_0.cards[arg_14_2]

	arg_14_1.gameData.lastRoundWin = var_14_2

	local var_14_3
	local var_14_4 = var_14_2 and "win" or arg_14_1.gameData.lose == 1 and "lose_matchpoint" or "lose"
	local var_14_5 = nullable(var_0_8, arg_14_1.gameData.win + 1, var_14_4)

	var_0_4(arg_14_1, "draw", var_14_5, function()
		arg_14_1:GoToState(var_14_1, var_14_2)
	end)

	return arg_14_2
end

function var_0_1.OnSelectCard(arg_16_0, arg_16_1, arg_16_2)
	if arg_16_2 == arg_16_0.select then
		arg_16_0.select = arg_16_0:OnDrawCard(arg_16_1, arg_16_2)
	elseif arg_16_2 then
		arg_16_0.select = arg_16_0:OnPrepareDraw(arg_16_1, arg_16_2)
	else
		arg_16_0.select = arg_16_0:OnCancelDraw(arg_16_1)
	end
end

var_0_1.events = {
	ON_PREPARE_DRAW_CARD = var_0_1.OnPrepareDraw,
	ON_CANCEL_DRAW_CARD = var_0_1.OnCancelDraw,
	ON_CONFIRM_DRAW_CARD = var_0_1.OnSelectCard
}

return var_0_1
