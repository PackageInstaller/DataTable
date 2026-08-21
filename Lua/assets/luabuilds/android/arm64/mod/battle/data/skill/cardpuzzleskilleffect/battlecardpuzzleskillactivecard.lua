ys = ys or {}

local var_0_0 = ys.Battle.BattleFleetCardPuzzleCardManageComponent
local var_0_1 = class("BattleCardPuzzleSkillActiveCard", ys.Battle.BattleCardPuzzleSkillEffect)

ys.Battle.BattleCardPuzzleSkillActiveCard = var_0_1
var_0_1.__name = "BattleCardPuzzleSkillActiveCard"

function var_0_1.Ctor(arg_1_0, arg_1_1)
	var_0_1.super.Ctor(arg_1_0, arg_1_1)

	arg_1_0._activeFrom = arg_1_0._tempData.arg_list.active_from or 0
	arg_1_0._activeID = arg_1_0._tempData.arg_list.active_ID_list
	arg_1_0._activeLabel = arg_1_0._tempData.arg_list.active_label_list
	arg_1_0._activeAll = arg_1_0._tempData.arg_list.active_all

	return
end

function var_0_1.SkillEffectHandler(arg_2_0)
	local var_2_0 = arg_2_0._card:GetClient():GetCardPileByIndex(arg_2_0._activeFrom)
	local var_2_1 = {}

	var_2_1.value = arg_2_0._activeID or arg_2_0._activeLabel
	var_2_1.total = arg_2_0._activeAll

	if arg_2_0._activeID then
		var_2_1.type = var_0_0.SEARCH_BY_ID or var_0_0.SEARCH_BY_LABEL

		for iter_2_0, iter_2_1 in ipairs((var_2_0:Search(var_2_1))) do
			iter_2_1:Active()
		end

		arg_2_0:Finale()

		return
	end
end

return
