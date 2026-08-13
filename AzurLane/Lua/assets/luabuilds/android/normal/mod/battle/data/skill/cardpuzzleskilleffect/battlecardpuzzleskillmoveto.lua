ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle.BattleDataFunction
local var_0_2 = var_0.Battle.BattleConst

class = var_0_10003

local var_0_3 = var_0_10003("BattleCardPuzzleSkillMoveTo", var_0.Battle.BattleCardPuzzleSkillEffect)

var_0.Battle.BattleCardPuzzleSkillMoveTo = var_0_3
var_0_3.__name = "BattleCardPuzzleSkillMoveTo"

function var_0_3.Ctor(arg_1_0, arg_1_1)
	var_0_3.super.Ctor(arg_1_0, arg_1_1)

	return
end

function var_0_3.HoldForInput(arg_2_0)
	return false
end

function var_0_3.SkillEffectHandler(arg_3_0)
	local var_3_0 = arg_3_0._card
	local var_3_1 = var_1.GetInputPoint(var_3_0)
	local var_3_2 = arg_3_0:GetCardPuzzleComponent()
	local var_3_3 = var_2.TakeoverMovecontroller(var_3_2, var_3_1, function()
		local var_4_0 = arg_3_0

		var_0.Finale(var_4_0)

		return
	end)

	return
end

function var_0_3.Finale(arg_5_0)
	var_0_3.super.Finale(arg_5_0)

	local var_5_0 = arg_5_0:GetCardPuzzleComponent()

	var_1.ReturnMovecontroller(var_5_0)

	return
end

return
