ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys
class = var_0_10001

local var_0_1 = var_0_10001("BattleCardPuzzleSkillAddFleetBuff", var_0.Battle.BattleCardPuzzleSkillEffect)

var_0.Battle.BattleCardPuzzleSkillAddFleetBuff = var_0_1
var_0_1.__name = "BattleCardPuzzleSkillAddFleetBuff"

function var_0_1.Ctor(arg_1_0, arg_1_1, arg_1_2)
	var_0_1.super.Ctor(arg_1_0, arg_1_1, arg_1_2)

	arg_1_0._fleetBuffID = arg_1_0._tempData.arg_list.fleet_buff_id

	local var_1_0

	if not arg_1_0._tempData.arg_list.init_stack then
		var_1_0 = 1
	end

	arg_1_0._initStack = var_1_0

	return
end

function var_0_1.SkillEffectHandler(arg_2_0)
	local var_2_0 = arg_2_0:GetCardPuzzleComponent()
	local var_2_1 = var_1.GetBuffManager(var_2_0)
	local var_2_2 = var_0.Battle.BattleFleetBuffUnit.New(arg_2_0._fleetBuffID)

	var_2_1:AttachCardPuzzleBuff(var_2_2)
	arg_2_0:Finale()

	return
end

return
