ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle.BattleFleetCardPuzzleCardManageComponent

class = var_0_10002

local var_0_2 = var_0_10002("BattleCardPuzzleSkillActiveCard", var_0.Battle.BattleCardPuzzleSkillEffect)

var_0.Battle.BattleCardPuzzleSkillActiveCard = var_0_2
var_0_2.__name = "BattleCardPuzzleSkillActiveCard"

function var_0_2.Ctor(arg_1_0, arg_1_1)
	var_0_2.super.Ctor(arg_1_0, arg_1_1)

	local var_1_0

	if not arg_1_0._tempData.arg_list.active_from then
		var_1_0 = 0
	end

	arg_1_0._activeFrom = var_1_0
	arg_1_0._activeID = arg_1_0._tempData.arg_list.active_ID_list
	arg_1_0._activeLabel = arg_1_0._tempData.arg_list.active_label_list
	arg_1_0._activeAll = arg_1_0._tempData.arg_list.active_all

	return
end

function var_0_2.SkillEffectHandler(arg_2_0)
	local var_2_0 = arg_2_0._card
	local var_2_1 = var_1.GetClient(var_2_0)
	local var_2_2 = var_1.GetCardPileByIndex(var_2_1, arg_2_0._activeFrom)
	local var_2_3 = {}
	local var_2_4

	if not arg_2_0._activeID then
		var_2_4 = arg_2_0._activeLabel
	end

	var_2_3.value = var_2_4
	var_2_3.total = arg_2_0._activeAll

	local var_2_5

	if not arg_2_0._activeID or not var_0_1.SEARCH_BY_ID then
		var_2_5 = var_0_1.SEARCH_BY_LABEL
	end

	var_2_3.type = var_2_5

	local var_2_6 = var_2_2:Search(var_2_3)

	ipairs = var_5

	for iter_2_0, iter_2_1 in var_5(var_2_6) do
		iter_2_1:Active()
	end

	arg_2_0:Finale()

	return
end

return
