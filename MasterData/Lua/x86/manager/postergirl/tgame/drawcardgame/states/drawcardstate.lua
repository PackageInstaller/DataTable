local var_0_0 = class("DrawCardGameManager.DrawCardState", (import("...StateBase")))

local function var_0_1(arg_1_0)
	return string.format("game_chair_%s", arg_1_0)
end

local function var_0_2(arg_2_0, arg_2_1)
	return string.format("game_chair_%s_%d", arg_2_0, arg_2_1)
end

local function var_0_3(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	if arg_3_2 then
		local var_3_0 = var_0_2(arg_3_1, arg_3_2[math.random(#arg_3_2)])

		arg_3_0:DoAction(var_3_0, arg_3_3, false, 0.3)
		arg_3_0:PlayTalk(var_0_1(arg_3_1), var_3_0)
	else
		arg_3_3()
	end
end

local function var_0_4(arg_4_0)
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

function var_0_0:Enter(arg_5_1)
	self.confirm = false

	var_0_0.super.Enter(self, arg_5_1)

	self.cards = var_0_4(2)

	local var_5_0 = arg_5_1:IsLittleChara() and "action1_1_game" or "action2_1_game"

	arg_5_1:DoAction(var_5_0, nil, true, 0)
	arg_5_1:PlayTalk(var_5_0)
end

function var_0_0:Exit(arg_6_1)
	self:ClearSelectCardEfx((arg_6_1:GetCurMainActor()))

	self.select = nil
	self.lastPlayActionTime = nil
end

local var_0_5 = {
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
local var_0_6 = 2

function var_0_0:OnPrepareDraw(arg_7_1, arg_7_2)
	if self.confirm then
		return self.select
	end

	local var_7_0 = Time.time

	if Time.time - (self.lastPlayActionTime or 0) <= var_0_6 then
		return self.select
	end

	self:SetSelectCardEfx(arg_7_1:GetCurMainActor(), arg_7_2)

	local var_7_1 = nullable(var_0_5, arg_7_1.gameData.win + 1, "select")

	if var_7_1 then
		arg_7_1:DoAction(var_0_2("face", var_7_1[math.random(#var_7_1)]), function()
			return
		end, false, 0.5)

		self.lastPlayActionTime = var_7_0
	end

	return arg_7_2
end

function var_0_0:OnCancelDraw(arg_9_1)
	if self.confirm then
		return nil
	end

	self:ClearSelectCardEfx((arg_9_1:GetCurMainActor()))
	var_0_3(arg_9_1, "face", nullable(var_0_5, arg_9_1.gameData.win + 1, "cancel"), function()
		local var_10_0 = arg_9_1:IsLittleChara() and "action1_1_game" or "action2_1_game"

		arg_9_1:DoAction(var_10_0, function()
			arg_9_1:PlayTalk(var_10_0)
		end, false, 0)
	end)

	return nil
end

function var_0_0:ClearSelectCardEfx(arg_12_1)
	if not isNil(self.selCardEfx) then
		arg_12_1:StopEffect(self.selCardEfx)

		self.selCardEfx = nil
	end
end

function var_0_0:SetSelectCardEfx(arg_13_1, arg_13_2)
	self:ClearSelectCardEfx(arg_13_1)

	self.selCardEfx = arg_13_1:PlayEffect(arg_13_1:GetModelId() == "102003ui_custom" and "Effect/Scene/fx_x204_card_01" or "Effect/Scene/fx_x204_card_02", string.format("card_%d", arg_13_2), math.huge)
end

local var_0_7 = {
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

function var_0_0:OnDrawCard(arg_14_1, arg_14_2)
	self.confirm = true

	self:ClearSelectCardEfx((arg_14_1:GetCurMainActor()))

	local var_14_0 = require("manager.posterGirl.tgame.DrawCardGame.States.Include").SettlementState
	local var_14_1 = self.cards[arg_14_2]

	arg_14_1.gameData.lastRoundWin = self.cards[arg_14_2]

	var_0_3(arg_14_1, "draw", nullable(var_0_7, arg_14_1.gameData.win + 1, var_14_1 and "win" or arg_14_1.gameData.lose == 1 and "lose_matchpoint" or "lose"), function()
		arg_14_1:GoToState(var_14_0, var_14_1)
	end)

	return arg_14_2
end

function var_0_0:OnSelectCard(arg_16_1, arg_16_2)
	self.select = arg_16_2 == self.select and self:OnDrawCard(arg_16_1, arg_16_2) or arg_16_2 and self:OnPrepareDraw(arg_16_1, arg_16_2) or self:OnCancelDraw(arg_16_1)
end

var_0_0.events = {
	ON_PREPARE_DRAW_CARD = var_0_0.OnPrepareDraw,
	ON_CANCEL_DRAW_CARD = var_0_0.OnCancelDraw,
	ON_CONFIRM_DRAW_CARD = var_0_0.OnSelectCard
}

return var_0_0
