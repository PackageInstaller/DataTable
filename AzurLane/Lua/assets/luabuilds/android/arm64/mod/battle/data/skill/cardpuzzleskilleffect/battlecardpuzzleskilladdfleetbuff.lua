ys = ys or {}

local var_0_0 = class("BattleCardPuzzleSkillAddFleetBuff", ys.Battle.BattleCardPuzzleSkillEffect)

ys.Battle.BattleCardPuzzleSkillAddFleetBuff = var_0_0
var_0_0.__name = "BattleCardPuzzleSkillAddFleetBuff"

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	var_0_0.super.Ctor(arg_1_0, arg_1_1, arg_1_2)

	arg_1_0._fleetBuffID = arg_1_0._tempData.arg_list.fleet_buff_id
	arg_1_0._initStack = arg_1_0._tempData.arg_list.init_stack or 1

	return
end

function var_0_0.SkillEffectHandler(arg_2_0)
	arg_2_0:GetCardPuzzleComponent():GetBuffManager():AttachCardPuzzleBuff((var_0.Battle.BattleFleetBuffUnit.New(arg_2_0._fleetBuffID)))
	arg_2_0:Finale()

	return
end

return
