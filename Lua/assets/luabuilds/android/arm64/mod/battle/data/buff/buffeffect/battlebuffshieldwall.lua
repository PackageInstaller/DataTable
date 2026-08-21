ys = ys or {}

local var_0_0 = ys
local var_0_1 = pg.effect_offset

ys.Battle.BattleBuffShieldWall = class("BattleBuffShieldWall", ys.Battle.BattleBuffEffect)
ys.Battle.BattleBuffShieldWall.__name = "BattleBuffShieldWall"

local var_0_2 = ys.Battle.BattleBuffShieldWall

function ys.Battle.BattleBuffShieldWall.Ctor(arg_1_0, arg_1_1)
	var_0_2.super.Ctor(arg_1_0, arg_1_1)

	return
end

function ys.Battle.BattleBuffShieldWall.SetArgs(arg_2_0, arg_2_1, arg_2_2)
	local var_2_0 = arg_2_0._tempData.arg_list

	arg_2_0._buffID = arg_2_2:GetID()
	arg_2_0._dir = arg_2_1:GetDirection()
	arg_2_0._count = var_2_0.count
	arg_2_0._bulletType = var_2_0.bulletType or var_0_0.Battle.BattleConst.BulletType.CANNON
	arg_2_0._doWhenHit = var_2_0.do_when_hit
	arg_2_0._unit = arg_2_1
	arg_2_0._dataProxy = var_0_0.Battle.BattleDataProxy.GetInstance()
	arg_2_0._centerPos = arg_2_1:GetPosition()
	arg_2_0._startTime = pg.TimeMgr.GetInstance():GetCombatTime()

	local function var_2_1(arg_3_0)
		return arg_2_0:onWallCld(arg_3_0)
	end

	local var_2_2 = arg_2_1:GetTemplate().scale / 50
	local var_2_3 = var_2_0.cld_list[1].box
	local var_2_4 = Clone(var_2_0.cld_list[1].offset)

	var_2_4[1] = arg_2_1:GetDirection() == var_0_0.Battle.BattleConst.UnitDir.LEFT and -var_2_4[1] * var_2_2 or var_2_4[1] * var_2_2
	arg_2_0._wall = arg_2_0._dataProxy:SpawnWall(arg_2_0, var_2_1, var_2_3, var_2_4)

	local var_2_5

	if var_0_1[var_2_0.effect] then
		local var_2_6 = arg_2_1:GetTemplate().fx_container[var_0_1[var_2_0.effect].container_index]
		local var_2_7 = Vector3(var_2_6[1], var_2_6[2], var_2_6[3])

		var_2_7:Add((Vector3(var_0_1[var_2_0.effect].offset[1], var_0_1[var_2_0.effect].offset[2], var_0_1[var_2_0.effect].offset[3])))

		var_2_5 = var_2_7
	end

	arg_2_0._centerPosFun = var_2_5 and function(arg_4_0)
		local var_4_0 = var_2_0.centerPosFun(arg_4_0):Add(var_2_5)

		var_4_0.x = (nil).x * arg_2_0._dir

		return var_4_0
	end or var_2_0.centerPosFun
	arg_2_0._currentTimeCount = 0

	if var_2_0.effect then
		arg_2_0._effectIndex = "BattleBuffShieldWall" .. arg_2_0._buffID .. arg_2_0._tempData.id

		local var_2_8 = var_2_5 and function(arg_5_0)
			return (var_2_0.centerPosFun(arg_5_0):Add(var_2_5))
		end or var_2_0.centerPosFun

		arg_2_0._unit = arg_2_1
		arg_2_0._evtData = {
			effect = var_2_0.effect,
			posFun = var_2_8,
			index = arg_2_0._effectIndex,
			rotationFun = var_2_0.rotationFun
		}

		arg_2_1:DispatchEvent(var_0_0.Event.New(var_0_0.Battle.BattleUnitEvent.ADD_EFFECT, arg_2_0._evtData))
	end

	return
end

function ys.Battle.BattleBuffShieldWall.onStack(arg_6_0, arg_6_1, arg_6_2)
	arg_6_0._count = arg_6_0._tempData.arg_list.count

	arg_6_0._unit:DispatchEvent(var_0_0.Event.New(var_0_0.Battle.BattleUnitEvent.ADD_EFFECT, arg_6_0._evtData))

	return
end

function ys.Battle.BattleBuffShieldWall.onUpdate(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	local var_7_0 = arg_7_1:GetPosition()

	if arg_7_0._centerPosFun then
		arg_7_0._currentTimeCount = arg_7_3.timeStamp - arg_7_0._startTime
		var_7_0 = arg_7_0._centerPosFun(arg_7_0._currentTimeCount):Mul(arg_7_1:GetTemplate().scale * 0.02):Add(var_7_0)
	end

	arg_7_0._centerPos = var_7_0

	return
end

function ys.Battle.BattleBuffShieldWall.onWallCld(arg_8_0, arg_8_1)
	if not arg_8_1:GetIgnoreShield() and arg_8_1:GetType() == arg_8_0._bulletType and arg_8_0._count > 0 then
		if arg_8_0._doWhenHit == "intercept" then
			arg_8_1:Intercepted()
			arg_8_0._dataProxy:RemoveBulletUnit(arg_8_1:GetUniqueID())

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

function ys.Battle.BattleBuffShieldWall.GetIFF(arg_9_0)
	return arg_9_0._unit:GetIFF()
end

function ys.Battle.BattleBuffShieldWall.GetPosition(arg_10_0)
	return arg_10_0._centerPos
end

function ys.Battle.BattleBuffShieldWall.IsWallActive(arg_11_0)
	return arg_11_0._count > 0
end

function ys.Battle.BattleBuffShieldWall.Deactive(arg_12_0)
	if arg_12_0._effectIndex then
		arg_12_0._unit:DispatchEvent(var_0_0.Event.New(var_0_0.Battle.BattleUnitEvent.DEACTIVE_EFFECT, {
			index = arg_12_0._effectIndex
		}))
	end

	if arg_12_0._unit:IsAlive() then
		arg_12_0._unit:TriggerBuff(var_0_0.Battle.BattleConst.BuffEffectType.ON_SHIELD_BROKEN, {
			shieldBuffID = arg_12_0._buffID
		})
	end

	return
end

function ys.Battle.BattleBuffShieldWall.Clear(arg_13_0)
	if arg_13_0._effectIndex then
		arg_13_0._unit:DispatchEvent(var_0_0.Event.New(var_0_0.Battle.BattleUnitEvent.CANCEL_EFFECT, {
			index = arg_13_0._effectIndex
		}))
	end

	arg_13_0._dataProxy:RemoveWall(arg_13_0._wall:GetUniqueID())

	return
end

return
