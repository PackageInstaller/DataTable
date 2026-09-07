ys = ys or {}
ys.Battle.BattleStrayBulletUnit = class("BattleStrayBulletUnit", ys.Battle.BattleBulletUnit)
ys.Battle.BattleStrayBulletUnit.__name = "BattleStrayBulletUnit"

local var_0_0 = ys.Battle.BattleStrayBulletUnit

function ys.Battle.BattleStrayBulletUnit.Ctor(arg_1_0, arg_1_1, arg_1_2)
	var_0_0.super.Ctor(arg_1_0, arg_1_1, arg_1_2)

	return
end

function ys.Battle.BattleStrayBulletUnit.SetExplodePosition(arg_2_0, arg_2_1)
	arg_2_0._explodePos = arg_2_1

	return
end

function ys.Battle.BattleStrayBulletUnit:GetExplodePostion()
	return self._explodePos
end

return
