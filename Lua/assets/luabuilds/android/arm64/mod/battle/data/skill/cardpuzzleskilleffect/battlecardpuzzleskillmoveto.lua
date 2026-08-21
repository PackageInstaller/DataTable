ys = ys or {}

local var_0_2 = class("BattleCardPuzzleSkillMoveTo", ys.Battle.BattleCardPuzzleSkillEffect)

ys.Battle.BattleCardPuzzleSkillMoveTo = var_0_2
var_0_2.__name = "BattleCardPuzzleSkillMoveTo"

function var_0_2.Ctor(arg_1_0, arg_1_1)
	var_0_2.super.Ctor(arg_1_0, arg_1_1)

	return
end

function var_0_2.HoldForInput(arg_2_0)
	return false
end

function var_0_2.SkillEffectHandler(arg_3_0)
	local var_3_0 = arg_3_0:GetCardPuzzleComponent():TakeoverMovecontroller(arg_3_0._card:GetInputPoint(), function()
		arg_3_0:Finale()

		return
	end)

	return
end

function var_0_2.Finale(arg_5_0)
	var_0_2.super.Finale(arg_5_0)
	arg_5_0:GetCardPuzzleComponent():ReturnMovecontroller()

	return
end

return
