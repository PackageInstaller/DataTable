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

function ys.Battle.BattleShelterData.Update(arg_6_0, arg_6_1)
	if arg_6_1 - arg_6_0._startTimeStamp > arg_6_0._duration then
		arg_6_0._startTimeStamp = nil
	end

	return
end

function ys.Battle.BattleShelterData.DoWhenHit(arg_7_0, arg_7_1)
	if not arg_7_1:GetIgnoreShield() then
		if arg_7_0._doWhenHit == "intercept" then
			arg_7_1:Intercepted()
			var_0_0.Battle.BattleDataProxy.GetInstance():RemoveBulletUnit(arg_7_1:GetUniqueID())

			arg_7_0._count = arg_7_0._count - 1
		elseif arg_7_0._doWhenHit == "reflect" and arg_7_0:GetIFF() ~= arg_7_1:GetIFF() then
			arg_7_1:Reflected()

			arg_7_0._count = arg_7_0._count - 1
		end
	end

	return
end

function ys.Battle.BattleShelterData.GetUniqueID(arg_8_0)
	return arg_8_0._id
end

function ys.Battle.BattleShelterData.GetIFF(arg_9_0)
	return arg_9_0._IFF
end

function ys.Battle.BattleShelterData.GetFXID(arg_10_0)
	return arg_10_0._effect
end

function ys.Battle.BattleShelterData.GetPosition(arg_11_0)
	return arg_11_0._centerPos
end

function ys.Battle.BattleShelterData.Deactive(arg_12_0)
	var_0_0.Battle.BattleDataProxy.GetInstance():RemoveWall(arg_12_0._wall:GetUniqueID())

	return
end

function ys.Battle.BattleShelterData.IsWallActive(arg_13_0)
	return arg_13_0._count > 0 and arg_13_0._startTimeStamp
end

return
