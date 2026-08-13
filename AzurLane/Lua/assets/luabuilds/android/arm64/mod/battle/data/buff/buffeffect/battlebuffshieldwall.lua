ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys
pg = var_0_10001

local var_0_1 = var_0_10001.effect_offset
local var_0_2 = var_0.Battle

class = var_0_10003
var_0_2.BattleBuffShieldWall = var_0_10003("BattleBuffShieldWall", var_0.Battle.BattleBuffEffect)
var_0.Battle.BattleBuffShieldWall.__name = "BattleBuffShieldWall"

local var_0_3 = var_0.Battle.BattleBuffShieldWall

function var_0_3.Ctor(arg_1_0, arg_1_1)
	var_0_3.super.Ctor(arg_1_0, arg_1_1)

	return
end

function var_0_3.SetArgs(arg_2_0, arg_2_1, arg_2_2)
	local var_2_0 = arg_2_0._tempData.arg_list

	arg_2_0._buffID = arg_2_2:GetID()
	arg_2_0._dir = arg_2_1:GetDirection()
	arg_2_0._count = var_2_0.count

	local var_2_1

	if not var_2_0.bulletType then
		var_2_1 = var_0.Battle.BattleConst.BulletType.CANNON
	end

	arg_2_0._bulletType = var_2_1
	arg_2_0._doWhenHit = var_2_0.do_when_hit
	arg_2_0._unit = arg_2_1
	arg_2_0._dataProxy = var_0.Battle.BattleDataProxy.GetInstance()
	arg_2_0._centerPos = arg_2_1:GetPosition()
	pg = var_4

	local var_2_2 = var_4.TimeMgr.GetInstance()

	arg_2_0._startTime = var_4.GetCombatTime(var_2_2)

	local function var_2_3(arg_3_0)
		local var_3_0 = arg_2_0

		return var_1.onWallCld(var_3_0, arg_3_0)
	end

	local var_2_4 = arg_2_1:GetTemplate().scale / 50
	local var_2_5 = var_2_0.cld_list[1].box

	Clone = var_1_10008

	local var_2_6 = var_1_10008(var_6.offset)

	if arg_2_1:GetDirection() == var_0.Battle.BattleConst.UnitDir.LEFT then
		var_2_6[1] = -var_2_6[1] * var_2_4
	else
		var_2_6[1] = var_2_6[1] * var_2_4
	end

	local var_2_7 = arg_2_0._dataProxy

	arg_2_0._wall = var_9.SpawnWall(var_2_7, arg_2_0, var_2_3, var_2_5, var_2_6)

	local var_2_8

	if var_0_1[var_2_0.effect] then
		local var_2_9 = var_10.container_index

		Vector3 = var_12

		local var_2_10 = var_12(var_10.offset[1], var_10.offset[2], var_10.offset[3])
		local var_2_11 = arg_2_1:GetTemplate().fx_container[var_2_9]

		Vector3 = var_14

		local var_2_12 = var_14(var_2_11[1], var_2_11[2], var_2_11[3])

		var_14.Add(var_2_12, var_2_10)

		var_2_8 = var_14
	end

	if var_2_8 then
		function arg_2_0._centerPosFun(arg_4_0)
			local var_4_0
			local var_4_1 = var_2_0.centerPosFun(arg_4_0)

			var_1.x = var_2.Add(var_4_1, var_2_8).x * arg_2_0._dir

			return var_1
		end
	else
		arg_2_0._centerPosFun = var_2_0.centerPosFun
	end

	arg_2_0._currentTimeCount = 0

	if var_2_0.effect then
		arg_2_0._effectIndex = "BattleBuffShieldWall" .. arg_2_0._buffID .. arg_2_0._tempData.id

		local var_2_13

		if var_2_8 then
			function var_2_13(arg_5_0)
				local var_5_0
				local var_5_1 = var_2_0.centerPosFun(arg_5_0)

				return (var_2.Add(var_5_1, var_2_8))
			end
		else
			var_2_13 = var_2_0.centerPosFun
		end

		arg_2_0._unit = arg_2_1
		arg_2_0._evtData = {
			effect = var_2_0.effect,
			posFun = var_2_13,
			index = arg_2_0._effectIndex,
			rotationFun = var_2_0.rotationFun
		}

		arg_2_1:DispatchEvent(var_0.Event.New(var_0.Battle.BattleUnitEvent.ADD_EFFECT, arg_2_0._evtData))
	end

	return
end

function var_0_3.onStack(arg_6_0, arg_6_1, arg_6_2)
	arg_6_0._count = arg_6_0._tempData.arg_list.count

	local var_6_0 = arg_6_0._unit

	var_3.DispatchEvent(var_6_0, var_0.Event.New(var_0.Battle.BattleUnitEvent.ADD_EFFECT, arg_6_0._evtData))

	return
end

function var_0_3.onUpdate(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	local var_7_0 = arg_7_1:GetPosition()
	local var_7_1 = arg_7_1:GetTemplate().scale * 0.02
	local var_7_2 = arg_7_3.timeStamp

	if arg_7_0._centerPosFun then
		arg_7_0._currentTimeCount = var_7_2 - arg_7_0._startTime

		local var_7_3 = arg_7_0._centerPosFun(arg_7_0._currentTimeCount)
		local var_7_4 = var_7.Mul(var_7_3, var_7_1)

		var_7_0 = var_7.Add(var_7_4, var_7_0)
	end

	arg_7_0._centerPos = var_7_0

	return
end

function var_0_3.onWallCld(arg_8_0, arg_8_1)
	if not arg_8_1:GetIgnoreShield() and arg_8_1:GetType() == arg_8_0._bulletType and arg_8_0._count > 0 then
		if arg_8_0._doWhenHit == "intercept" then
			arg_8_1:Intercepted()

			local var_8_0 = arg_8_0._dataProxy

			var_2.RemoveBulletUnit(var_8_0, arg_8_1:GetUniqueID())

			arg_8_0._count = arg_8_0._count - 1
		elseif arg_8_0._doWhenHit == "reflect" and arg_8_0:GetIFF() ~= arg_8_1:GetIFF() then
			arg_8_1:Reflected()

			arg_8_0._count = arg_8_0._count - 1
		end

		if arg_8_0._count <= 0 then
			arg_8_0:Deactive()
		end
	end

	return arg_8_0._count > 0
end

function var_0_3.GetIFF(arg_9_0)
	local var_9_0 = arg_9_0._unit

	return var_1.GetIFF(var_9_0)
end

function var_0_3.GetPosition(arg_10_0)
	return arg_10_0._centerPos
end

function var_0_3.IsWallActive(arg_11_0)
	return arg_11_0._count > 0
end

function var_0_3.Deactive(arg_12_0)
	if arg_12_0._effectIndex then
		local var_12_0 = {
			index = arg_12_0._effectIndex
		}
		local var_12_1 = arg_12_0._unit

		var_2.DispatchEvent(var_12_1, var_0.Event.New(var_0.Battle.BattleUnitEvent.DEACTIVE_EFFECT, var_12_0))
	end

	local var_12_2 = arg_12_0._unit

	if var_1.IsAlive(var_12_2) then
		local var_12_3 = arg_12_0._unit

		var_1.TriggerBuff(var_12_3, var_0.Battle.BattleConst.BuffEffectType.ON_SHIELD_BROKEN, {
			shieldBuffID = arg_12_0._buffID
		})
	end

	return
end

function var_0_3.Clear(arg_13_0)
	if arg_13_0._effectIndex then
		local var_13_0 = {
			index = arg_13_0._effectIndex
		}
		local var_13_1 = arg_13_0._unit

		var_2.DispatchEvent(var_13_1, var_0.Event.New(var_0.Battle.BattleUnitEvent.CANCEL_EFFECT, var_13_0))
	end

	local var_13_2 = arg_13_0._dataProxy
	local var_13_3 = var_1.RemoveWall
	local var_13_4 = arg_13_0._wall

	var_13_3(var_13_2, var_4.GetUniqueID(var_13_4))

	return
end

return
