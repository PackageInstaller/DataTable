ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys
singletonClass = var_0_10001

local var_0_1 = var_0_10001("BattleSubCharacterFactory", var_0.Battle.BattlePlayerCharacterFactory)

var_0.Battle.BattleSubCharacterFactory = var_0_1
var_0_1.__name = "BattleSubCharacterFactory"

function var_0_1.Ctor(arg_1_0)
	var_0_1.super.Ctor(arg_1_0)

	arg_1_0.ARROW_BAR_NAME = "EnemyArrowContainer/SubArrow"

	return
end

function var_0_1.MakeCharacter(arg_2_0)
	return var_0.Battle.BattleSubCharacter.New()
end

return
