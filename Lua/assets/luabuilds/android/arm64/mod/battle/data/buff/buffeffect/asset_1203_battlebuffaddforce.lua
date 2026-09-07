ys = ys or {}

local BattleBuffAddForce = class("BattleBuffAddForce", ys.Battle.BattleBuffEffect)

ys.Battle.BattleBuffAddForce = BattleBuffAddForce
BattleBuffAddForce.__name = "BattleBuffAddForce"

function BattleBuffAddForce:Ctor(arg_1_1)
	BattleBuffAddForce.super.Ctor(self, arg_1_1)

	return
end

function BattleBuffAddForce:SetArgs(arg_2_1, arg_2_2)
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

function BattleBuffAddForce:onUpdate(arg_3_1, arg_3_2)
	local var_3_0 = self._casterGravity and arg_3_2:GetCaster():GetPosition() + self._singularityOffset or self._staticSingularity
	local var_3_1 = pg.Tool.FilterY(var_3_0 - arg_3_1:GetPosition())
	local var_3_2 = self._force

	if var_3_1.magnitude < 2 then
		var_3_2 = 1e-08
	elseif self._forceScalteRate then
		var_3_2 = math.min(var_3_1.magnitude, 1 / var_3_1.magnitude * var_3_2)
	end

	arg_3_1:SetUncontrollableSpeed(var_3_1, var_3_2, 1e-18)

	self._lastSingularityPos = var_3_0

	return
end

function BattleBuffAddForce:onAttach(arg_4_1, arg_4_2)
	return
end

function BattleBuffAddForce:onRemove(arg_5_1, arg_5_2)
	arg_5_1:SetUncontrollableSpeed(pg.Tool.FilterY(self._lastSingularityPos - arg_5_1:GetPosition()), 0.1, 0.1)

	return
end

return
