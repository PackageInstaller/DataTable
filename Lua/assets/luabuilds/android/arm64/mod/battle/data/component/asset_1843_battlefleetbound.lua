ys = ys or {}

local var_0_0 = ys.Battle.BattleConfig
local BattleFleetBound = class("BattleFleetBound")

ys.Battle.BattleFleetBound = BattleFleetBound
BattleFleetBound.__name = "BattleFleetBound"

function BattleFleetBound:Ctor(arg_1_1)
	self._iff = arg_1_1

	return
end

function BattleFleetBound:Dispose()
	self._iff = nil

	return
end

function BattleFleetBound:GetBound()
	return self._upperBound, self._lowerBound, self._absoluteLeft, self._absoluteRight, self._bufferLeft, self._bufferRight
end

function BattleFleetBound:GetAbsoluteRight()
	return self._absoluteRight
end

function BattleFleetBound:ConfigAreaData(arg_5_1, arg_5_2)
	self._totalArea = setmetatable({}, {
		__index = arg_5_1
	})
	self._playerArea = setmetatable({}, {
		__index = arg_5_2
	})
	self._totalLeftBound = self._totalArea[1]
	self._totalRightBound = self._totalArea[1] + self._totalArea[3]
	self._totalUpperBound = self._totalArea[2] + self._totalArea[4]
	self._totalLowerBound = self._totalArea[2]
	self._upperBound = self._playerArea[2] + self._playerArea[4]
	self._lowerBound = self._playerArea[2]
	self._middleLine = self._playerArea[1] + self._playerArea[3]

	return
end

function BattleFleetBound:SwtichCommon()
	if self._iff == var_0_0.FRIENDLY_CODE then
		self._absoluteLeft = self._playerArea[1]
		self._absoluteRight = var_0_0.MaxRight
		self._bufferLeft = var_0_0.MaxLeft
		self._bufferRight = self._middleLine
	elseif self._iff == var_0_0.FOE_CODE then
		self._absoluteLeft = self._middleLine
		self._absoluteRight = self._totalRightBound
		self._bufferLeft = self._middleLine
		self._bufferRight = var_0_0.MaxRight
	end

	return
end

function BattleFleetBound:SwtichDuelAggressive()
	if self._iff == var_0_0.FRIENDLY_CODE then
		self._absoluteLeft = self._middleLine
		self._absoluteRight = self._totalRightBound
		self._bufferLeft = self._middleLine
		self._bufferRight = var_0_0.MaxRight
	elseif self._iff == var_0_0.FOE_CODE then
		self._absoluteLeft = self._playerArea[1]
		self._absoluteRight = var_0_0.MaxRight
		self._bufferLeft = var_0_0.MaxLeft
		self._bufferRight = self._middleLine
	end

	return
end

function BattleFleetBound:SwtichDBRGL()
	if self._iff == var_0_0.FRIENDLY_CODE then
		self._absoluteLeft = self._playerArea[1]
		self._absoluteRight = self._middleLine
		self._bufferLeft = var_0_0.MaxLeft
		self._bufferRight = var_0_0.MaxRight
	elseif self._iff == var_0_0.FOE_CODE then
		self._absoluteLeft = self._middleLine
		self._absoluteRight = self._totalRightBound
		self._bufferLeft = self._middleLine
		self._bufferRight = var_0_0.MaxRight
	end

	return
end

function BattleFleetBound:FixCardPuzzleInput(arg_9_1)
	arg_9_1:Set(math.clamp(arg_9_1.x, self._absoluteLeft, self._absoluteRight), 0, (math.clamp(arg_9_1.z, self._lowerBound, self._upperBound)))

	return
end

return
