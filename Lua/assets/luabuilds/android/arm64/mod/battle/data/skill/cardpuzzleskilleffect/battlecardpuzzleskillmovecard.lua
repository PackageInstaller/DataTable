ys = ys or {}

local var_0_0 = ys.Battle.BattleFleetCardPuzzleCardManageComponent
local var_0_1 = class("BattleCardPuzzleSkillMoveCard", ys.Battle.BattleCardPuzzleSkillEffect)

ys.Battle.BattleCardPuzzleSkillMoveCard = var_0_1
var_0_1.__name = "BattleCardPuzzleSkillMoveCard"

function var_0_1.Ctor(arg_1_0, arg_1_1)
	var_0_1.super.Ctor(arg_1_0, arg_1_1)

	arg_1_0._moveFrom = arg_1_0._tempData.arg_list.move_from or 0
	arg_1_0._moveTo = arg_1_0._tempData.arg_list.move_to
	arg_1_0._moveID = arg_1_0._tempData.arg_list.move_ID_list
	arg_1_0._moveLabel = arg_1_0._tempData.arg_list.move_label_list
	arg_1_0._moveOP = arg_1_0._tempData.arg_list.move_op or var_0_0.FUNC_NAME_ADD
	arg_1_0._moveOther = arg_1_0._tempData.arg_list.move_other
	arg_1_0._moveAll = arg_1_0._tempData.arg_list.move_all
	arg_1_0._op = arg_1_0._tempData.arg_list.shuffle or 1

	return
end

function var_0_1.MoveCardAfterCast(arg_2_0)
	if arg_2_0._moveID or arg_2_0._moveLabel then
		return var_0_1.super.MoveCardAfterCast(arg_2_0)
	else
		return arg_2_0._moveTo
	end

	return
end

function var_0_1.SkillEffectHandler(arg_3_0)
	local var_3_0 = arg_3_0._card:GetClient()
	local var_3_1 = var_3_0:GetCardPileByIndex(arg_3_0._moveTo)
	local var_3_2 = var_3_0:GetCardPileByIndex(arg_3_0._moveFrom)

	if arg_3_0._moveID then
		for iter_3_0, iter_3_1 in ipairs((var_3_2:Search({
			value = arg_3_0._moveID,
			type = var_0_0.SEARCH_BY_ID,
			total = arg_3_0._moveAll
		}))) do
			var_3_1[arg_3_0._moveOP](var_3_1, iter_3_1)
			var_3_2:Remove(iter_3_1, arg_3_0._moveTo)
		end
	elseif arg_3_0._moveLabel then
		for iter_3_2, iter_3_3 in ipairs((var_3_2:Search({
			value = arg_3_0._moveLabel,
			type = var_0_0.SEARCH_BY_LABEL,
			total = arg_3_0._moveAll
		}))) do
			var_3_1[arg_3_0._moveOP](var_3_1, iter_3_3)
			var_3_2:Remove(iter_3_3, arg_3_0._moveTo)
		end
	elseif arg_3_0._moveOther then
		for iter_3_4, iter_3_5 in ipairs((var_3_2:GetCardList())) do
			if iter_3_5 ~= arg_3_0._card then
				var_3_1[arg_3_0._moveOP](var_3_1, iter_3_5)
				var_3_2:Remove(iter_3_5, arg_3_0._moveTo)
			end
		end
	else
		var_3_1[arg_3_0._moveOP](var_3_1, arg_3_0._card)
	end

	if arg_3_0._op == 1 then
		var_3_1:Shuffle()
	end

	arg_3_0:Finale()

	return
end

return
