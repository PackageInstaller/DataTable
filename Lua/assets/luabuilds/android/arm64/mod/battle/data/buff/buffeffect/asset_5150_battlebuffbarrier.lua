ys = ys or {}

local var_0_0 = ys

ys.Battle.BattleBuffBarrier = class("BattleBuffBarrier", ys.Battle.BattleBuffEffect)
ys.Battle.BattleBuffBarrier.__name = "BattleBuffBarrier"

local var_0_2 = ys.Battle.BattleBuffBarrier

function ys.Battle.BattleBuffBarrier.Ctor(arg_1_0, arg_1_1)
	var_0_2.super.Ctor(arg_1_0, arg_1_1)

	return
end

function ys.Battle.BattleBuffBarrier:SetArgs(arg_2_1, arg_2_2)
	self._durability = self._tempData.arg_list.durability
	self._dir = arg_2_1:GetDirection()
	self._unit = arg_2_1
	self._dataProxy = var_0_0.Battle.BattleDataProxy.GetInstance()
	self._centerPos = arg_2_1:GetPosition()

	local var_2_0 = Clone(self._tempData.arg_list.cld_data.offset)

	if arg_2_1:GetDirection() == var_0_0.Battle.BattleConst.UnitDir.LEFT then
		var_2_0[1] = -var_2_0[1]
	end

	self._wall = self._dataProxy:SpawnWall(self, function(arg_3_0)
		self._dataProxy:HandleDamage(arg_3_0, self._unit)
		arg_3_0:Intercepted()
		self._dataProxy:RemoveBulletUnit(arg_3_0:GetUniqueID())

		return
	end, self._tempData.arg_list.cld_data.box, var_2_0)

	return
end

function ys.Battle.BattleBuffBarrier.onUpdate(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	arg_4_0._centerPos = arg_4_1:GetPosition()

	return
end

function ys.Battle.BattleBuffBarrier:onTakeDamage(arg_5_1, arg_5_2, arg_5_3)
	if self:damageCheck(arg_5_3) then
		self._durability = self._durability - arg_5_3.damage

		if self._durability > 0 then
			arg_5_3.damage = 0
		else
			arg_5_3.damage = -self._durability

			arg_5_2:SetToCancel()
		end
	end

	return
end

function ys.Battle.BattleBuffBarrier:onAttach(arg_6_1, arg_6_2, arg_6_3)
	if self._unit:IsBoss() then
		self._unit:BarrierStateChange(self._durability, arg_6_2:GetDuration())
	end

	return
end

function ys.Battle.BattleBuffBarrier:onRemove(arg_7_1, arg_7_2, arg_7_3)
	if self._unit:IsBoss() then
		self._unit:BarrierStateChange(0)
	end

	return
end

function ys.Battle.BattleBuffBarrier:GetIFF()
	return self._unit:GetIFF()
end

function ys.Battle.BattleBuffBarrier:GetPosition()
	return self._centerPos
end

function ys.Battle.BattleBuffBarrier:IsWallActive()
	return self._durability > 0
end

return
