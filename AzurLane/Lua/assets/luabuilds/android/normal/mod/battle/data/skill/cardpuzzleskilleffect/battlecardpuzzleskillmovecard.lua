ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle.BattleFleetCardPuzzleCardManageComponent

class = var_0_10002

local var_0_2 = var_0_10002("BattleCardPuzzleSkillMoveCard", var_0.Battle.BattleCardPuzzleSkillEffect)

var_0.Battle.BattleCardPuzzleSkillMoveCard = var_0_2
var_0_2.__name = "BattleCardPuzzleSkillMoveCard"

function var_0_2.Ctor(arg_1_0, arg_1_1)
	var_0_2.super.Ctor(arg_1_0, arg_1_1)

	local var_1_0

	if not arg_1_0._tempData.arg_list.move_from then
		var_1_0 = 0
	end

	arg_1_0._moveFrom = var_1_0
	arg_1_0._moveTo = arg_1_0._tempData.arg_list.move_to
	arg_1_0._moveID = arg_1_0._tempData.arg_list.move_ID_list
	arg_1_0._moveLabel = arg_1_0._tempData.arg_list.move_label_list

	local var_1_1

	if not arg_1_0._tempData.arg_list.move_op then
		var_1_1 = var_0_1.FUNC_NAME_ADD
	end

	arg_1_0._moveOP = var_1_1
	arg_1_0._moveOther = arg_1_0._tempData.arg_list.move_other
	arg_1_0._moveAll = arg_1_0._tempData.arg_list.move_all

	local var_1_2

	if not arg_1_0._tempData.arg_list.shuffle then
		var_1_2 = 1
	end

	arg_1_0._op = var_1_2

	return
end

function var_0_2.MoveCardAfterCast(arg_2_0)
	if arg_2_0._moveID or arg_2_0._moveLabel then
		return var_0_2.super.MoveCardAfterCast(arg_2_0)
	else
		return arg_2_0._moveTo
	end

	return
end

function var_0_2.SkillEffectHandler(arg_3_0)
	local var_3_0 = arg_3_0._card
	local var_3_1 = var_1.GetClient(var_3_0)
	local var_3_2 = var_1.GetCardPileByIndex(var_3_1, arg_3_0._moveTo)
	local var_3_3 = var_1:GetCardPileByIndex(arg_3_0._moveFrom)

	if arg_3_0._moveID then
		local var_3_4 = {
			value = arg_3_0._moveID,
			type = var_0_1.SEARCH_BY_ID,
			total = arg_3_0._moveAll
		}
		local var_3_5 = var_3_3
		local var_3_6 = var_3_3.Search(var_3_5, var_3_4)

		ipairs = var_3_5

		for iter_3_0, iter_3_1 in var_3_5(var_3_6) do
			var_3_2[arg_3_0._moveOP](var_3_2, iter_3_1)
			var_3_3:Remove(iter_3_1, arg_3_0._moveTo)
		end
	elseif arg_3_0._moveLabel then
		local var_3_7 = {
			value = arg_3_0._moveLabel,
			type = var_0_1.SEARCH_BY_LABEL,
			total = arg_3_0._moveAll
		}
		local var_3_8 = var_3_3
		local var_3_9 = var_3_3.Search(var_3_8, var_3_7)

		ipairs = var_3_8

		for iter_3_2, iter_3_3 in var_3_8(var_3_9) do
			var_3_2[arg_3_0._moveOP](var_3_2, iter_3_3)
			var_3_3:Remove(iter_3_3, arg_3_0._moveTo)
		end
	elseif arg_3_0._moveOther then
		local var_3_10 = var_3_3
		local var_3_11 = var_3_3.GetCardList(var_3_10)

		ipairs = var_3_10

		for iter_3_4, iter_3_5 in var_3_10(var_3_11) do
			if iter_3_5 ~= arg_3_0._card then
				var_3_2[arg_3_0._moveOP](var_3_2, iter_3_5)
				var_3_3:Remove(iter_3_5, arg_3_0._moveTo)
			end
		end
	else
		var_3_2[arg_3_0._moveOP](var_3_2, arg_3_0._card)
	end

	if arg_3_0._op == 1 then
		var_3_2:Shuffle()
	end

	arg_3_0:Finale()

	return
end

return
