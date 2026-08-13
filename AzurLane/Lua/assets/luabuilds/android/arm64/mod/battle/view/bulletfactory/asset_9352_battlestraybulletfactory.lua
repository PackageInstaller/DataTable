ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle.BattleConst.UnitType
local var_0_2 = var_0.Battle

singletonClass = var_0_10003
var_0_2.BattleStrayBulletFactory = var_0_10003("BattleStrayBulletFactory", var_0.Battle.BattleCannonBulletFactory)
var_0.Battle.BattleStrayBulletFactory.__name = "BattleStrayBulletFactory"

local var_0_3 = var_0.Battle.BattleStrayBulletFactory

function var_0_3.Ctor(arg_1_0)
	var_0_3.super.Ctor(arg_1_0)

	return
end

function var_0_3.MakeBullet(arg_2_0)
	return var_0.Battle.BattleStrayBullet.New()
end

return
