ys = ys or {}

local var_0_0 = ys
local AutoPilotRelativeBrownian = class("AutoPilotRelativeBrownian", ys.Battle.IPilot)

ys.Battle.AutoPilotRelativeBrownian = AutoPilotRelativeBrownian
AutoPilotRelativeBrownian.__name = "AutoPilotRelativeBrownian"

function AutoPilotRelativeBrownian:Ctor(...)
	AutoPilotRelativeBrownian.super.Ctor(self, ...)

	return
end

function AutoPilotRelativeBrownian:SetParameter(arg_2_1, arg_2_2)
	AutoPilotRelativeBrownian.super.SetParameter(self, arg_2_1, arg_2_2)

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

function AutoPilotRelativeBrownian:Active(arg_3_1)
	self._stopCount = self._stop
	self._moveCount = 0
	self._randomCount = 0

	local var_3_0 = Clone(arg_3_1:GetPosition())

	self._relativePoint = {
		X1 = self._randomPoint.X1 + var_3_0.x,
		X2 = self._randomPoint.X2 + var_3_0.x,
		Z1 = self._randomPoint.Z1 + var_3_0.z,
		Z2 = self._randomPoint.Z2 + var_3_0.z
	}
	self._referencePoint = var_0_0.Battle.BattleFormulas.RandomPos(self._relativePoint)

	AutoPilotRelativeBrownian.super.Active(self, arg_3_1)

	return
end

function AutoPilotRelativeBrownian:GetDirection(arg_4_1)
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

			local var_4_1 = var_0_0.Battle.BattleFormulas.RandomPos(self._relativePoint)

			while Vector3.SqrDistance(var_4_1, arg_4_1) < 5 do
				var_4_1 = var_0_0.Battle.BattleFormulas.RandomPos(self._relativePoint)
			end

			self._referencePoint = var_4_1
		end

		return Vector3.zero
	else
		self._randomCount = self._randomCount + 1
		self._moveCount = self._moveCount + 1

		return var_4_0.normalized
	end

	return
end

return
