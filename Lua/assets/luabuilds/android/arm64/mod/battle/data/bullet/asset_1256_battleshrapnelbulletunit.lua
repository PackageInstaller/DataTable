ys = ys or {}

local var_0_0 = ys
local var_0_1 = ys.Battle.BattleConfig
local var_0_2 = ys.Battle.BattleConst
local var_0_3 = ys.Battle.BattleBulletEvent
local var_0_4 = ys.Battle.BattleFormulas

ys.Battle.BattleShrapnelBulletUnit = class("BattleShrapnelBulletUnit", ys.Battle.BattleBulletUnit)
ys.Battle.BattleShrapnelBulletUnit.__name = "BattleShrapnelBulletUnit"

local var_0_5 = ys.Battle.BattleShrapnelBulletUnit

ys.Battle.BattleShrapnelBulletUnit.STATE_NORMAL = "normal"
ys.Battle.BattleShrapnelBulletUnit.STATE_SPLIT = "split"
ys.Battle.BattleShrapnelBulletUnit.STATE_SPIN = "spin"
ys.Battle.BattleShrapnelBulletUnit.STATE_FINAL_SPLIT = "final_split"
ys.Battle.BattleShrapnelBulletUnit.STATE_EXPIRE = "expire"
ys.Battle.BattleShrapnelBulletUnit.STATE_PRIORITY = {
	[ys.Battle.BattleShrapnelBulletUnit.STATE_EXPIRE] = 5,
	[ys.Battle.BattleShrapnelBulletUnit.STATE_FINAL_SPLIT] = 4,
	[ys.Battle.BattleShrapnelBulletUnit.STATE_SPLIT] = 3,
	[ys.Battle.BattleShrapnelBulletUnit.STATE_SPIN] = 2,
	[ys.Battle.BattleShrapnelBulletUnit.STATE_NORMAL] = 1
}

function ys.Battle.BattleShrapnelBulletUnit:Ctor(arg_1_1, arg_1_2)
	var_0_5.super.Ctor(self, arg_1_1, arg_1_2)

	self._splitCount = 0
	self._cacheEmitter = {}

	self:ChangeShrapnelState(self.STATE_NORMAL)

	return
end

function ys.Battle.BattleShrapnelBulletUnit:Hit(arg_2_1, arg_2_2)
	if self:GetTemplate().extra_param.rangeAA then
		return
	end

	var_0_5.super.Hit(self, arg_2_1, arg_2_2)

	self._pierceCount = self._pierceCount - 1

	return
end

function ys.Battle.BattleShrapnelBulletUnit:SplitFinishCount()
	self._splitCount = self._splitCount + 1

	return
end

function ys.Battle.BattleShrapnelBulletUnit:IsAllSplitFinish()
	return self._splitCount >= #self._tempData.extra_param.shrapnel
end

function ys.Battle.BattleShrapnelBulletUnit:SetTemplateData(arg_5_1)
	var_0_5.super.SetTemplateData(self, arg_5_1)

	self._outbound = self._tempData.out_bound

	return
end

function ys.Battle.BattleShrapnelBulletUnit:GetOutBound()
	return self._outbound
end

function ys.Battle.BattleShrapnelBulletUnit:Update(arg_7_1)
	if self._startCount == nil and self._outbound == var_0_2.BulletOutBound.SHIFT_SPLIT then
		self._startCount = arg_7_1
	end

	if self._outbound == var_0_2.BulletOutBound.SHIFT_SPLIT then
		if self._startCount == nil then
			self._startCount = arg_7_1
		elseif arg_7_1 - self._startCount > var_0_1.BULLET_SPLIT_SHIFT_DELAY then
			self._outbound = var_0_2.BulletOutBound.SPLIT
		end
	end

	if self._currentState == var_0_5.STATE_NORMAL then
		var_0_5.super.Update(self, arg_7_1)

		if self._verticalSpeed ~= 0 and self._verticalSpeed * self._verticalSpeed < 0 then
			self:ChangeShrapnelState(var_0_5.STATE_SPLIT)
		end
	elseif self._currentState == var_0_5.STATE_SPIN and (not self._tempData.extra_param.lastTime or arg_7_1 - self._spinStartTime > self._tempData.extra_param.lastTime) then
		self:ChangeShrapnelState(var_0_5.STATE_SPLIT)
	end

	return
end

function ys.Battle.BattleShrapnelBulletUnit:ChangeShrapnelState(arg_8_1)
	if var_0_5.STATE_PRIORITY[self._currentState] and var_0_5.STATE_PRIORITY[self._currentState] >= var_0_5.STATE_PRIORITY[arg_8_1] then
		return
	end

	self._currentState = arg_8_1

	if self._currentState == var_0_5.STATE_SPIN then
		self._spinStartTime = pg.TimeMgr.GetInstance():GetCombatTime()
	elseif self._currentState == var_0_5.STATE_SPLIT then
		self:DispatchEvent(var_0_0.Event.New(var_0_3.SPLIT, {}))
	end

	return
end

function ys.Battle.BattleShrapnelBulletUnit:IsOutRange(arg_9_1)
	if self._currentState == var_0_5.STATE_NORMAL then
		return var_0_5.super.IsOutRange(self, arg_9_1)
	else
		return false
	end

	return
end

function ys.Battle.BattleShrapnelBulletUnit.SetSrcHost(arg_10_0, arg_10_1)
	arg_10_0._srcHost = arg_10_1

	return
end

function ys.Battle.BattleShrapnelBulletUnit:GetSrcHost()
	return self._srcHost
end

function ys.Battle.BattleShrapnelBulletUnit:GetShrapnelParam()
	return self._tempData.extra_param
end

function ys.Battle.BattleShrapnelBulletUnit:GetCurrentState()
	return self._currentState
end

function ys.Battle.BattleShrapnelBulletUnit:SetSpawnPosition(arg_14_1)
	local var_14_0 = self:GetTemplate().extra_param

	var_0_5.super.SetSpawnPosition(self, (var_14_0.directHit or nil) and Clone(self._explodePos))

	local var_14_2 = Vector3.Distance(pg.Tool.FilterY(self._spawnPos), pg.Tool.FilterY(self._explodePos))

	if var_14_0.flare then
		local var_14_3 = var_0_0.Battle.BattleDataFunction.GetBulletTmpDataFromID(var_14_0.shrapnel[1].bullet_ID)

		self._convertedVelocity = math.sqrt(-0.5 * self._gravity * var_14_2 * var_14_2 / (0.5 * math.abs(var_14_3.extra_param.gravity or -0.0005) * (var_14_3.hit_type.time * var_0_1.calcFPS)^2 - self._spawnPos.y))
		self._verticalSpeed = (0.5 * math.abs(var_14_3.extra_param.gravity or -0.0005) * (var_14_3.hit_type.time * var_0_1.calcFPS)^2 - self._spawnPos.y) / (var_14_2 / self._convertedVelocity) - 0.5 * self._gravity * (var_14_2 / self._convertedVelocity)
	elseif var_14_0.rangeAA then
		self._velocity = math.sqrt(-(0.5 * self._gravity) * var_14_2 * var_14_2 / (var_0_1.AircraftHeight - self._spawnPos.y))
		self._verticalSpeed = (var_0_1.AircraftHeight - self._spawnPos.y) / (var_14_2 / self._velocity) - 0.5 * self._gravity * (var_14_2 / self._velocity)
		self._velocity = var_0_4.ConvertBulletDataSpeed(self._velocity)
	elseif self._convertedVelocity ~= 0 and self._explodePos.y ~= self._spawnPos.y then
		self._verticalSpeed = var_14_0.launchVrtSpeed or (self._explodePos.y - self._spawnPos.y) / (var_14_2 / self._convertedVelocity) - 0.5 * self._gravity * (var_14_2 / self._convertedVelocity)
	end

	return
end

function ys.Battle.BattleShrapnelBulletUnit:GetExplodePostion()
	return self._explodePos
end

function ys.Battle.BattleShrapnelBulletUnit:SetExplodePosition(arg_16_1)
	self._explodePos = Clone(arg_16_1)
	self._explodePos.y = var_0_1.BombDetonateHeight

	return
end

function ys.Battle.BattleShrapnelBulletUnit:CacheChildEimtter(arg_17_1)
	table.insert(self._cacheEmitter, arg_17_1)

	return
end

function ys.Battle.BattleShrapnelBulletUnit:interruptChildEmitter()
	for iter_18_0, iter_18_1 in ipairs(self._cacheEmitter) do
		iter_18_1:Destroy()
	end

	return
end

function ys.Battle.BattleShrapnelBulletUnit:Dispose()
	self:interruptChildEmitter()

	self._cacheEmitter = nil

	var_0_5.super.Dispose(self)

	return
end

return
