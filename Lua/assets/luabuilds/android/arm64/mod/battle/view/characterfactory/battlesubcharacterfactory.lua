ys = ys or {}

local var_0_0 = singletonClass("BattleSubCharacterFactory", ys.Battle.BattlePlayerCharacterFactory)

ys.Battle.BattleSubCharacterFactory = var_0_0
var_0_0.__name = "BattleSubCharacterFactory"

function var_0_0.Ctor(arg_1_0)
	var_0_0.super.Ctor(arg_1_0)

	arg_1_0.ARROW_BAR_NAME = "EnemyArrowContainer/SubArrow"

	return
end

function var_0_0.MakeCharacter(arg_2_0)
	return var_0.Battle.BattleSubCharacter.New()
end

return
