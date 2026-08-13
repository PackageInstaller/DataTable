ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle.BattleFleetCardPuzzleCardManageComponent

class = var_0_10002

local var_0_2 = var_0_10002("BattleCardPuzzleSkillCreateCard", var_0.Battle.BattleCardPuzzleSkillEffect)

var_0.Battle.BattleCardPuzzleSkillCreateCard = var_0_2
var_0_2.__name = "BattleCardPuzzleSkillCreateCard"
var_0_2.MOVE_OP_Add = "Add"
var_0_2.MOVE_OP_BOTTOM = "Bottom"

function var_0_2.Ctor(arg_1_0, arg_1_1)
	var_0_2.super.Ctor(arg_1_0, arg_1_1)

	arg_1_0._cardID = arg_1_0._tempData.arg_list.card_id
	arg_1_0._moveTo = arg_1_0._tempData.arg_list.move_to

	local var_1_0

	if not arg_1_0._tempData.arg_list.move_op then
		var_1_0 = var_0_1.FUNC_NAME_ADD
	end

	arg_1_0._moveOP = var_1_0

	local var_1_1

	if not arg_1_0._tempData.arg_list.shuffle then
		var_1_1 = 1
	end

	arg_1_0._op = var_1_1

	return
end

function var_0_2.SkillEffectHandler(arg_2_0)
	local var_2_0 = arg_2_0._card
	local var_2_1 = var_1.GetClient(var_2_0)
	local var_2_2 = var_1.GenerateCard(var_2_1, arg_2_0._cardID)

	var_1:GetCardPileByIndex(arg_2_0._moveTo)[arg_2_0._moveOP](var_3, var_2_2)

	if arg_2_0._op == 1 then
		var_3:Shuffle()
	end

	arg_2_0:Finale()

	return
end

return
