ys = ys or {}
ys.Battle.BattleScaleBullet = class("BattleScaleBullet", ys.Battle.BattleBullet)
ys.Battle.BattleScaleBullet.__name = "BattleScaleBullet"

local var_0_0 = ys.Battle.BattleScaleBullet

function ys.Battle.BattleScaleBullet.Ctor(arg_1_0)
	var_0_0.super.Ctor(arg_1_0)

	return
end

function ys.Battle.BattleScaleBullet.Update(arg_2_0, arg_2_1)
	var_0_0.super.Update(arg_2_0, arg_2_1)
	arg_2_0:updateModelScale()

	return
end

function ys.Battle.BattleScaleBullet.updateModelScale(arg_3_0)
	arg_3_0._tf.localScale.x = arg_3_0._bulletData:GetBoxSize().x * 2
	arg_3_0._tf.localScale = arg_3_0._tf.localScale

	return
end

return
