ys = ys or {}

local var_0_0 = ys

ys.Battle.BattleStrayBulletFactory = singletonClass("BattleStrayBulletFactory", ys.Battle.BattleCannonBulletFactory)
ys.Battle.BattleStrayBulletFactory.__name = "BattleStrayBulletFactory"

local var_0_2 = ys.Battle.BattleStrayBulletFactory

function ys.Battle.BattleStrayBulletFactory.Ctor(arg_1_0)
	var_0_2.super.Ctor(arg_1_0)

	return
end

function ys.Battle.BattleStrayBulletFactory.MakeBullet(arg_2_0)
	return var_0_0.Battle.BattleStrayBullet.New()
end

return
