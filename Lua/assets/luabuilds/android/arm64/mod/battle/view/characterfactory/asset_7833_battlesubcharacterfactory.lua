ys = ys or {}

local var_0_0 = ys
local var_0_1 = singletonClass("BattleSubCharacterFactory", ys.Battle.BattlePlayerCharacterFactory)

ys.Battle.BattleSubCharacterFactory = var_0_1
var_0_1.__name = "BattleSubCharacterFactory"

function var_0_1.Ctor(arg_1_0)
	var_0_1.super.Ctor(arg_1_0)

	arg_1_0.ARROW_BAR_NAME = "EnemyArrowContainer/SubArrow"

	return
end

function var_0_1.MakeCharacter(arg_2_0)
	return var_0_0.Battle.BattleSubCharacter.New()
end

return
