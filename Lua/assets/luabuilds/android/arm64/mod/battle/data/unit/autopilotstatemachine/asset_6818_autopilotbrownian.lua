ys = ys or {}

local var_0_0 = ys
local AutoPilotBrownian = class("AutoPilotBrownian", ys.Battle.IPilot)

ys.Battle.AutoPilotBrownian = AutoPilotBrownian
AutoPilotBrownian.__name = "AutoPilotBrownian"

function AutoPilotBrownian:Ctor(...)
	AutoPilotBrownian.super.Ctor(self, ...)

	return
end

function AutoPilotBrownian:SetParameter(arg_2_1, arg_2_2)
	AutoPilotBrownian.super.SetParameter(self, arg_2_1, arg_2_2)

	self._randomPoint = {
		X1 = arg_2_1.X1,
		X2 = arg_2_1.X2,
		Z1 = arg_2_1.Z1,
		Z2 = arg_2_1.Z2
	}
	self._stop = arg_2_1.stopCount
	self._move = arg_2_1.moveCount
	self._random = arg_2_1.randomCount or 30

	return
end

function AutoPilotBrownian:Active(arg_3_1)
	self._stopCount = self._stop
	self._moveCount = 0
	self._randomCount = 0
	self._referencePoint = var_0_0.Battle.BattleFormulas.RandomPos(self._randomPoint)

	AutoPilotBrownian.super.Active(self, arg_3_1)

	return
end

function AutoPilotBrownian:GetDirection(arg_4_1)
	if self:IsExpired() then
		self:Finish()

		return Vector3.zero
	end

	self._moveCount = self._moveCount or 0

	if self._stop > self._stopCount then
		self._stopCount = self._stopCount + 1

		return Vector3.zero
	end

	local var_4_0 = self._referencePoint - arg_4_1

	if (self._referencePoint - arg_4_1).magnitude < 0.4 or self._randomCount > self._random then
		if self._move < self._moveCount then
			self._stopCount = 0
			self._moveCount = 0
		else
			self._randomCount = 0

			local var_4_1 = var_0_0.Battle.BattleFormulas.RandomPos(self._randomPoint)

			while Vector3.SqrDistance(var_4_1, arg_4_1) < 5 do
				var_4_1 = var_0_0.Battle.BattleFormulas.RandomPos(self._randomPoint)
			end

			self._referencePoint = var_4_1
		end

		return Vector3.zero
	else
		self._randomCount = self._randomCount + 1
		self._moveCount = self._moveCount + 1

		return var_4_0:SetNormalize()
	end

	return
end

return
