ys = ys or {}

local var_0_0 = ys
local var_0_2 = math
local BattleShotgunEmitter = class("BattleShotgunEmitter", ys.Battle.BattleBulletEmitter)

ys.Battle.BattleShotgunEmitter = BattleShotgunEmitter
BattleShotgunEmitter.__name = "BattleShotgunEmitter"

function BattleShotgunEmitter:Ctor(arg_1_1, arg_1_2, arg_1_3)
	var_0_0.Battle.BattleShotgunEmitter.super.Ctor(self, arg_1_1, arg_1_2, arg_1_3)

	self.PrimalIteration = self._nonDelayPrimalIteration

	return
end

function BattleShotgunEmitter:Fire(arg_2_1, arg_2_2, arg_2_3)
	self._angleRange = arg_2_3

	var_0_0.Battle.BattleShotgunEmitter.super.Fire(self, arg_2_1, arg_2_2)

	return
end

function BattleShotgunEmitter:GenerateBullet()
	self._delay = self._convertedDirBarrage[self._primalCounter].Delay

	self._spawnFunc(self._convertedDirBarrage[self._primalCounter].OffsetX, self._convertedDirBarrage[self._primalCounter].OffsetZ, self._isRandomAngle and (var_0_2.random() - 0.5) * var_0_2.random(self._angleRange) - self._angleRange / 2 or var_0_2.random(self._angleRange) - self._angleRange / 2, self._offsetPriority, self._target, self._primalCounter)
	self:Interation()

	return
end

return
