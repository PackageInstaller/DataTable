ys = ys or {}
ys.Battle.BattleScaleBullet = class("BattleScaleBullet", ys.Battle.BattleBullet)
ys.Battle.BattleScaleBullet.__name = "BattleScaleBullet"

local var_0_0 = ys.Battle.BattleScaleBullet

function ys.Battle.BattleScaleBullet.Ctor(arg_1_0)
	var_0_0.super.Ctor(arg_1_0)

	return
end

function ys.Battle.BattleScaleBullet:Update(arg_2_1)
	var_0_0.super.Update(self, arg_2_1)
	self:updateModelScale()

	return
end

function ys.Battle.BattleScaleBullet:updateModelScale()
	self._tf.localScale.x = self._bulletData:GetBoxSize().x * 2
	self._tf.localScale = self._tf.localScale

	return
end

return
