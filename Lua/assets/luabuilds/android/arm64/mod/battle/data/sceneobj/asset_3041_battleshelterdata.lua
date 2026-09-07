ys = ys or {}

local var_0_0 = ys

ys.Battle.BattleShelterData = class("BattleShelterData")
ys.Battle.BattleShelterData.__name = "BattleShelterData"

function ys.Battle.BattleShelterData.Ctor(arg_1_0, arg_1_1)
	arg_1_0._id = arg_1_1

	return
end

function ys.Battle.BattleShelterData.SetIFF(arg_2_0, arg_2_1)
	arg_2_0._IFF = arg_2_1

	return
end

function ys.Battle.BattleShelterData.SetArgs(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4, arg_3_5)
	arg_3_0._duration = arg_3_2
	arg_3_0._bulletType = var_0_0.Battle.BattleConst.BulletType.CANNON
	arg_3_0._count = arg_3_1
	arg_3_0._effect = arg_3_5
	arg_3_0._doWhenHit = "intercept"
	arg_3_0._wall = var_0_0.Battle.BattleDataProxy.GetInstance():SpawnWall(arg_3_0, function(arg_4_0)
		if arg_4_0:GetType() == arg_3_0._bulletType and arg_3_0:IsWallActive() then
			arg_3_0:DoWhenHit(arg_4_0)
		end

		return arg_3_0._count > 0
	end, arg_3_3, {
		0,
		0,
		0
	})
	arg_3_0._centerPos = arg_3_4

	return
end

function ys.Battle.BattleShelterData.SetStartTimeStamp(arg_5_0, arg_5_1)
	arg_5_0._startTimeStamp = arg_5_1

	return
end

function ys.Battle.BattleShelterData:Update(arg_6_1)
	if arg_6_1 - self._startTimeStamp > self._duration then
		self._startTimeStamp = nil
	end

	return
end

function ys.Battle.BattleShelterData:DoWhenHit(arg_7_1)
	if not arg_7_1:GetIgnoreShield() then
		if self._doWhenHit == "intercept" then
			arg_7_1:Intercepted()
			var_0_0.Battle.BattleDataProxy.GetInstance():RemoveBulletUnit(arg_7_1:GetUniqueID())

			self._count = self._count - 1
		elseif self._doWhenHit == "reflect" and self:GetIFF() ~= arg_7_1:GetIFF() then
			arg_7_1:Reflected()

			self._count = self._count - 1
		end
	end

	return
end

function ys.Battle.BattleShelterData:GetUniqueID()
	return self._id
end

function ys.Battle.BattleShelterData:GetIFF()
	return self._IFF
end

function ys.Battle.BattleShelterData:GetFXID()
	return self._effect
end

function ys.Battle.BattleShelterData:GetPosition()
	return self._centerPos
end

function ys.Battle.BattleShelterData:Deactive()
	var_0_0.Battle.BattleDataProxy.GetInstance():RemoveWall(self._wall:GetUniqueID())

	return
end

function ys.Battle.BattleShelterData:IsWallActive()
	return self._count > 0 and self._startTimeStamp
end

return
