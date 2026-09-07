ys = ys or {}

local var_0_0 = pg
local var_0_1 = ys.Battle.BattleConst
local var_0_2 = ys.Battle.BattleDataFunction
local var_0_3 = math
local BattleBulletEmitter = class("BattleBulletEmitter")

ys.Battle.BattleBulletEmitter = BattleBulletEmitter
BattleBulletEmitter.__name = "BattleBulletEmitter"
BattleBulletEmitter.STATE_ACTIVE = "ACTIVE"
BattleBulletEmitter.STATE_STOP = "STOP"

function BattleBulletEmitter:Ctor(arg_1_1, arg_1_2, arg_1_3)
	self._spawnFunc = arg_1_1
	self._stopFunc = arg_1_2
	self._barrageID = arg_1_3
	self._barrageTemp = var_0_2.GetBarrageTmpDataFromID(arg_1_3)
	self._offsetPriority = self._barrageTemp.offset_prioritise
	self._isRandomAngle = self._barrageTemp.random_angle
	self._timerList = {}
	self.PrimalIteration = self._barrageTemp.delta_delay ~= 0 and self._advancePrimalIteration or self._barrageTemp.delay ~= 0 and self._averagePrimalIteration or self._nonDelayPrimalIteration
	self._primalMax = self._barrageTemp.primal_repeat + 1

	function self.timerCb(arg_2_0)
		self._timerList[arg_2_0](self, arg_2_0)

		return
	end

	return
end

function BattleBulletEmitter:Ready()
	self._state = self.STATE_ACTIVE
	self._seniorCounter = -1

	self:ClearAllTimer()

	return
end

function BattleBulletEmitter:Fire(arg_4_1, arg_4_2)
	self._target = arg_4_1
	self._dir = arg_4_2 or var_0_1.UnitDir.RIGHT
	self._convertedDirBarrage = self._convertedDirBarrage or var_0_2.GetConvertedBarrageTableFromID(self._barrageID, self._dir)[self._dir]

	self:SeniorIteration()

	return
end

function BattleBulletEmitter:Stop()
	self._state = self.STATE_STOP
	self._target = nil

	self:ClearAllTimer()
	self:_stopFunc()

	return
end

function BattleBulletEmitter:Interrupt()
	self._state = self.STATE_STOP
	self._target = nil

	self:ClearAllTimer()

	return
end

function BattleBulletEmitter:Destroy()
	self._spawnFunc = nil
	self._stopFunc = nil
	self._convertedDirBarrage = nil

	if self._timerList then
		self:ClearAllTimer()
	end

	return
end

function BattleBulletEmitter:GetState()
	return self._state
end

function BattleBulletEmitter:ClearAllTimer()
	for iter_9_0, iter_9_1 in pairs(self._timerList) do
		var_0_0.TimeMgr.GetInstance():RemoveBattleTimer(iter_9_0)
	end

	self._timerList = {}

	return
end

function BattleBulletEmitter:GenerateBullet()
	local var_10_0 = self._convertedDirBarrage[self._primalCounter]

	self._delay = self._convertedDirBarrage[self._primalCounter].Delay

	local var_10_3 = self._spawnFunc(self._convertedDirBarrage[self._primalCounter].OffsetX, var_10_0.OffsetZ, self._isRandomAngle and (var_0_3.random() - 0.5) * var_10_0.Angle or var_10_0.Angle, self._offsetPriority, self._target, self._primalCounter)

	if var_10_3 then
		var_10_3:SetBarrageTransformTempate((var_0_2.GenerateTransBarrage(self._barrageID, self._dir, self._primalCounter)))
	end

	self:Interation()

	return
end

function BattleBulletEmitter:DelaySeniorFunc(arg_11_1)
	var_0_0.TimeMgr.GetInstance():RemoveBattleTimer(arg_11_1)

	self._timerList[arg_11_1] = nil

	self:PrimalIteration()

	return
end

function BattleBulletEmitter:SeniorIteration()
	if self._state ~= self.STATE_ACTIVE then
		return
	end

	self._seniorCounter = self._seniorCounter + 1

	if self._seniorCounter > self._barrageTemp.senior_repeat then
		self:Stop()
	else
		self:InitParam()

		local var_12_0 = self._seniorCounter == 0 and self._barrageTemp.first_delay or self._barrageTemp.senior_delay

		if var_12_0 > 0 then
			self._timerList[var_0_0.TimeMgr.GetInstance():AddBattleTimer("spawnBullet", -1, var_12_0, self.timerCb, true)] = self.DelaySeniorFunc
		else
			self:PrimalIteration()
		end
	end

	return
end

function BattleBulletEmitter:InitParam()
	self._delay = self._barrageTemp.delay
	self._primalCounter = 1

	return
end

function BattleBulletEmitter:Interation()
	self._primalCounter = self._primalCounter + 1

	return
end

function BattleBulletEmitter:SetTimeScale(arg_15_1)
	if self._timerList then
		for iter_15_0, iter_15_1 in pairs(self._timerList) do
			iter_15_0:SetScale(arg_15_1)
		end
	end

	return
end

function BattleBulletEmitter:DelayPrimalConst(arg_16_1)
	self:GenerateBullet()

	if self._primalCounter > self._primalMax then
		var_0_0.TimeMgr.GetInstance():RemoveBattleTimer(arg_16_1)

		self._timerList[arg_16_1] = nil

		self:SeniorIteration()
	end

	return
end

function BattleBulletEmitter:_averagePrimalIteration()
	if self._state ~= self.STATE_ACTIVE then
		return
	end

	self._timerList[var_0_0.TimeMgr.GetInstance():AddBattleTimer("spawnBullet", -1, self._delay, self.timerCb, true)] = self.DelayPrimalConst

	return
end

function BattleBulletEmitter:DelayPrimalAdvance(arg_18_1)
	var_0_0.TimeMgr.GetInstance():RemoveBattleTimer(arg_18_1)

	self._timerList[arg_18_1] = nil

	self:GenerateBullet()

	if self._primalCounter > self._primalMax then
		self:SeniorIteration()
	else
		self:PrimalIteration()
	end

	return
end

function BattleBulletEmitter:_advancePrimalIteration()
	if self._state ~= self.STATE_ACTIVE then
		return
	end

	if self._delay == 0 then
		self:GenerateBullet()

		if self._primalCounter > self._primalMax then
			self:SeniorIteration()
		else
			self:PrimalIteration()
		end
	else
		self._timerList[var_0_0.TimeMgr.GetInstance():AddBattleTimer("spawnBullet", -1, self._delay, self.timerCb, true)] = self.DelayPrimalAdvance
	end

	return
end

function BattleBulletEmitter:_nonDelayPrimalIteration()
	if self._state ~= self.STATE_ACTIVE then
		return
	end

	self:GenerateBullet()

	if self._primalCounter > self._primalMax then
		self:SeniorIteration()
	else
		self:PrimalIteration()
	end

	return
end

return
