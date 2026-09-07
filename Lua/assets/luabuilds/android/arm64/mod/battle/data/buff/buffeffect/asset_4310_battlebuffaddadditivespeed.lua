ys = ys or {}

local BattleBuffAddAdditiveSpeed = class("BattleBuffAddAdditiveSpeed", ys.Battle.BattleBuffEffect)

ys.Battle.BattleBuffAddAdditiveSpeed = BattleBuffAddAdditiveSpeed
BattleBuffAddAdditiveSpeed.__name = "BattleBuffAddAdditiveSpeed"

function BattleBuffAddAdditiveSpeed:Ctor(arg_1_1)
	BattleBuffAddAdditiveSpeed.super.Ctor(self, arg_1_1)

	return
end

function BattleBuffAddAdditiveSpeed:SetArgs(arg_2_1, arg_2_2)
	self._singularity = self._tempData.arg_list.singularity or {
		x = 0,
		z = 0
	}
	self._casterGravity = self._tempData.arg_list.gravitationalCaster
	self._force = self._tempData.arg_list.force
	self._forceScalteRate = self._tempData.arg_list.scale_rate

	if not self._casterGravity then
		self._staticSingularity = Vector3.New(self._singularity.x, 0, self._singularity.z)
	else
		self._singularityOffset = Vector3.New(self._singularity.x * arg_2_2:GetCaster():GetIFF(), 0, self._singularity.z)
	end

	return
end

function BattleBuffAddAdditiveSpeed:onUpdate(arg_3_1, arg_3_2)
	local var_3_1 = pg.Tool.FilterY((self._casterGravity and arg_3_2:GetCaster():GetPosition() + self._singularityOffset or self._staticSingularity) - arg_3_1:GetPosition())
	local var_3_2 = var_3_1.normalized
	local var_3_3 = self._force

	if var_3_1.magnitude < 2 then
		var_3_3 = 1e-08
	elseif self._forceScalteRate then
		var_3_3 = math.min(var_3_1.magnitude, 1 / var_3_1.magnitude * var_3_3)
	end

	arg_3_1:SetAdditiveSpeed(var_3_2 * var_3_3)

	return
end

function BattleBuffAddAdditiveSpeed:onRemove(arg_4_1, arg_4_2)
	arg_4_1:RemoveAdditiveSpeed()

	return
end

return
