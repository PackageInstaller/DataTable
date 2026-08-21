ys = ys or {}

local var_0_0 = ys

ys.Battle.BattleScaleBulletFactory = singletonClass("BattleScaleBulletFactory", ys.Battle.BattleCannonBulletFactory)
ys.Battle.BattleScaleBulletFactory.__name = "BattleScaleBulletFactory"

local var_0_2 = ys.Battle.BattleScaleBulletFactory

function ys.Battle.BattleScaleBulletFactory.Ctor(arg_1_0)
	var_0_2.super.Ctor(arg_1_0)

	return
end

function ys.Battle.BattleScaleBulletFactory.MakeBullet(arg_2_0)
	return var_0_0.Battle.BattleScaleBullet.New()
end

return
