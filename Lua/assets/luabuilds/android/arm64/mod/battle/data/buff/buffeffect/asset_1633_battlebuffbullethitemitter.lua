ys = ys or {}

local var_0_0 = ys

ys.Battle.BattleBuffBulletHitEmitter = class("BattleBuffBulletHitEmitter", ys.Battle.BattleBuffEffect)
ys.Battle.BattleBuffBulletHitEmitter.__name = "BattleBuffBulletHitEmitter"

function ys.Battle.BattleBuffBulletHitEmitter.Ctor(arg_1_0, arg_1_1)
	var_0_0.Battle.BattleBuffBulletHitEmitter.super.Ctor(arg_1_0, arg_1_1)

	return
end

function ys.Battle.BattleBuffBulletHitEmitter:SetArgs(arg_2_1, arg_2_2)
	self._number = self._tempData.arg_list.number
	self._rate = self._tempData.arg_list.rate or 10000
	self._hitEmitterArgs = self._tempData.arg_list

	return
end

function ys.Battle.BattleBuffBulletHitEmitter:onBulletCreate(arg_3_1, arg_3_2, arg_3_3)
	if var_0_0.Battle.BattleFormulas.IsHappen(self._rate) then
		assert(false, "子弹弹射功能已经屏蔽")
	end

	return
end

return
