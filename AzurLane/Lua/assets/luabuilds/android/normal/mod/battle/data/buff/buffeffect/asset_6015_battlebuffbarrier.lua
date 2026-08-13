ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys
pg = var_0_10001

local var_0_1 = var_0_10001.effect_offset
local var_0_2 = var_0.Battle

class = var_0_10003
var_0_2.BattleBuffBarrier = var_0_10003("BattleBuffBarrier", var_0.Battle.BattleBuffEffect)
var_0.Battle.BattleBuffBarrier.__name = "BattleBuffBarrier"

local var_0_3 = var_0.Battle.BattleBuffBarrier

function var_0_3.Ctor(arg_1_0, arg_1_1)
	var_0_3.super.Ctor(arg_1_0, arg_1_1)

	return
end

function var_0_3.SetArgs(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0._durability = arg_2_0._tempData.arg_list.durability
	arg_2_0._dir = arg_2_1:GetDirection()
	arg_2_0._unit = arg_2_1
	arg_2_0._dataProxy = var_0.Battle.BattleDataProxy.GetInstance()
	arg_2_0._centerPos = arg_2_1:GetPosition()

	local function var_2_0(arg_3_0)
		local var_3_0 = arg_2_0._dataProxy

		var_1.HandleDamage(var_3_0, arg_3_0, arg_2_0._unit)
		arg_3_0:Intercepted()

		local var_3_1 = arg_2_0._dataProxy

		var_1.RemoveBulletUnit(var_3_1, arg_3_0:GetUniqueID())

		return
	end

	local var_2_1 = var_3.cld_data.box

	Clone = var_1_10007

	local var_2_2 = var_1_10007(var_5.offset)

	if arg_2_1:GetDirection() == var_0.Battle.BattleConst.UnitDir.LEFT then
		var_2_2[1] = -var_2_2[1]
	end

	local var_2_3 = arg_2_0._dataProxy

	arg_2_0._wall = var_8.SpawnWall(var_2_3, arg_2_0, var_2_0, var_2_1, var_2_2)

	return
end

function var_0_3.onUpdate(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	local var_4_0 = arg_4_3.timeStamp

	arg_4_0._centerPos = arg_4_1:GetPosition()

	return
end

function var_0_3.onTakeDamage(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	if arg_5_0:damageCheck(arg_5_3) then
		local var_5_0 = arg_5_3.damage

		arg_5_0._durability = arg_5_0._durability - var_5_0

		if arg_5_0._durability > 0 then
			arg_5_3.damage = 0
		else
			arg_5_3.damage = -arg_5_0._durability

			arg_5_2:SetToCancel()
		end
	end

	return
end

function var_0_3.onAttach(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	local var_6_0 = arg_6_0._unit

	if var_4.IsBoss(var_6_0) then
		local var_6_1 = arg_6_0._unit

		var_4.BarrierStateChange(var_6_1, arg_6_0._durability, arg_6_2:GetDuration())
	end

	return
end

function var_0_3.onRemove(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	local var_7_0 = arg_7_0._unit

	if var_4.IsBoss(var_7_0) then
		local var_7_1 = arg_7_0._unit

		var_4.BarrierStateChange(var_7_1, 0)
	end

	return
end

function var_0_3.GetIFF(arg_8_0)
	local var_8_0 = arg_8_0._unit

	return var_1.GetIFF(var_8_0)
end

function var_0_3.GetPosition(arg_9_0)
	return arg_9_0._centerPos
end

function var_0_3.IsWallActive(arg_10_0)
	return arg_10_0._durability > 0
end

return
