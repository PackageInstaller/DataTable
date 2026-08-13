ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle.BattleConst

pg = var_0_10002

local var_0_2 = var_0_10002.effect_offset
local var_0_3 = var_0.Battle

class = var_0_10004
var_0_3.BattleShelterData = var_0_10004("BattleShelterData")
var_0.Battle.BattleShelterData.__name = "BattleShelterData"

local var_0_4 = var_0.Battle.BattleShelterData

function var_0_4.Ctor(arg_1_0, arg_1_1)
	arg_1_0._id = arg_1_1

	return
end

function var_0_4.SetIFF(arg_2_0, arg_2_1)
	arg_2_0._IFF = arg_2_1

	return
end

function var_0_4.SetArgs(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4, arg_3_5)
	arg_3_0._duration = arg_3_2
	arg_3_0._bulletType = var_0.Battle.BattleConst.BulletType.CANNON
	arg_3_0._count = arg_3_1
	arg_3_0._effect = arg_3_5
	arg_3_0._doWhenHit = "intercept"

	local function var_3_0(arg_4_0)
		if arg_4_0:GetType() == arg_3_0._bulletType then
			local var_4_0 = arg_3_0

			if var_1.IsWallActive(var_4_0) then
				local var_4_1 = arg_3_0

				var_1.DoWhenHit(var_4_1, arg_4_0)
			end
		end

		return arg_3_0._count > 0
	end

	local var_3_1 = {
		0,
		0,
		0
	}
	local var_3_2 = var_0.Battle.BattleDataProxy.GetInstance()

	arg_3_0._wall = var_8.SpawnWall(var_3_2, arg_3_0, var_3_0, arg_3_3, var_3_1)
	arg_3_0._centerPos = arg_3_4

	return
end

function var_0_4.SetStartTimeStamp(arg_5_0, arg_5_1)
	arg_5_0._startTimeStamp = arg_5_1

	return
end

function var_0_4.Update(arg_6_0, arg_6_1)
	if arg_6_1 - arg_6_0._startTimeStamp > arg_6_0._duration then
		arg_6_0._startTimeStamp = nil
	end

	return
end

function var_0_4.DoWhenHit(arg_7_0, arg_7_1)
	if not arg_7_1:GetIgnoreShield() then
		if arg_7_0._doWhenHit == "intercept" then
			arg_7_1:Intercepted()

			local var_7_0 = var_0.Battle.BattleDataProxy.GetInstance()

			var_2.RemoveBulletUnit(var_7_0, arg_7_1:GetUniqueID())

			arg_7_0._count = arg_7_0._count - 1
		elseif arg_7_0._doWhenHit == "reflect" and arg_7_0:GetIFF() ~= arg_7_1:GetIFF() then
			arg_7_1:Reflected()

			arg_7_0._count = arg_7_0._count - 1
		end
	end

	return
end

function var_0_4.GetUniqueID(arg_8_0)
	return arg_8_0._id
end

function var_0_4.GetIFF(arg_9_0)
	return arg_9_0._IFF
end

function var_0_4.GetFXID(arg_10_0)
	return arg_10_0._effect
end

function var_0_4.GetPosition(arg_11_0)
	return arg_11_0._centerPos
end

function var_0_4.Deactive(arg_12_0)
	local var_12_0 = var_0.Battle.BattleDataProxy.GetInstance()
	local var_12_1 = var_1.RemoveWall
	local var_12_2 = arg_12_0._wall

	var_12_1(var_12_0, var_4.GetUniqueID(var_12_2))

	return
end

function var_0_4.IsWallActive(arg_13_0)
	return arg_13_0._count > 0 and arg_13_0._startTimeStamp
end

return
