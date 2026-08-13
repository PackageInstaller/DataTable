ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle.BattleConfig
local var_0_2 = var_0.Battle.BattleConst
local var_0_3 = var_0.Battle.BattleBulletEvent
local var_0_4 = var_0.Battle.BattleFormulas
local var_0_5 = var_0.Battle

class = var_0_10006
var_0_5.BattleShrapnelBulletUnit = var_0_10006("BattleShrapnelBulletUnit", var_0.Battle.BattleBulletUnit)
var_0.Battle.BattleShrapnelBulletUnit.__name = "BattleShrapnelBulletUnit"

local var_0_6 = var_0.Battle.BattleShrapnelBulletUnit

var_0_6.STATE_NORMAL = "normal"
var_0_6.STATE_SPLIT = "split"
var_0_6.STATE_SPIN = "spin"
var_0_6.STATE_FINAL_SPLIT = "final_split"
var_0_6.STATE_EXPIRE = "expire"
var_0_6.STATE_PRIORITY = {
	[var_0_6.STATE_EXPIRE] = 5,
	[var_0_6.STATE_FINAL_SPLIT] = 4,
	[var_0_6.STATE_SPLIT] = 3,
	[var_0_6.STATE_SPIN] = 2,
	[var_0_6.STATE_NORMAL] = 1
}

function var_0_6.Ctor(arg_1_0, arg_1_1, arg_1_2)
	var_0_6.super.Ctor(arg_1_0, arg_1_1, arg_1_2)

	arg_1_0._splitCount = 0
	arg_1_0._cacheEmitter = {}

	arg_1_0:ChangeShrapnelState(arg_1_0.STATE_NORMAL)

	return
end

function var_0_6.Hit(arg_2_0, arg_2_1, arg_2_2)
	if arg_2_0:GetTemplate().extra_param.rangeAA then
		return
	end

	var_0_6.super.Hit(arg_2_0, arg_2_1, arg_2_2)

	arg_2_0._pierceCount = arg_2_0._pierceCount - 1

	return
end

function var_0_6.SplitFinishCount(arg_3_0)
	arg_3_0._splitCount = arg_3_0._splitCount + 1

	return
end

function var_0_6.IsAllSplitFinish(arg_4_0)
	return arg_4_0._splitCount >= #arg_4_0._tempData.extra_param.shrapnel
end

function var_0_6.SetTemplateData(arg_5_0, arg_5_1)
	var_0_6.super.SetTemplateData(arg_5_0, arg_5_1)

	arg_5_0._outbound = arg_5_0._tempData.out_bound

	return
end

function var_0_6.GetOutBound(arg_6_0)
	return arg_6_0._outbound
end

function var_0_6.Update(arg_7_0, arg_7_1)
	if arg_7_0._startCount == nil and arg_7_0._outbound == var_0_2.BulletOutBound.SHIFT_SPLIT then
		arg_7_0._startCount = arg_7_1
	end

	if arg_7_0._outbound == var_0_2.BulletOutBound.SHIFT_SPLIT then
		if arg_7_0._startCount == nil then
			arg_7_0._startCount = arg_7_1
		elseif arg_7_1 - arg_7_0._startCount > var_0_1.BULLET_SPLIT_SHIFT_DELAY then
			arg_7_0._outbound = var_0_2.BulletOutBound.SPLIT
		end
	end

	if arg_7_0._currentState == var_0_6.STATE_NORMAL then
		local var_7_0 = arg_7_0._verticalSpeed

		var_0_6.super.Update(arg_7_0, arg_7_1)

		if var_7_0 ~= 0 and var_7_0 * arg_7_0._verticalSpeed < 0 then
			arg_7_0:ChangeShrapnelState(var_0_6.STATE_SPLIT)
		end
	elseif arg_7_0._currentState == var_0_6.STATE_SPIN and (not arg_7_0._tempData.extra_param.lastTime or arg_7_1 - arg_7_0._spinStartTime > arg_7_0._tempData.extra_param.lastTime) then
		arg_7_0:ChangeShrapnelState(var_0_6.STATE_SPLIT)
	end

	return
end

function var_0_6.ChangeShrapnelState(arg_8_0, arg_8_1)
	if var_0_6.STATE_PRIORITY[arg_8_0._currentState] and var_2 >= var_0_6.STATE_PRIORITY[arg_8_1] then
		return
	end

	arg_8_0._currentState = arg_8_1

	if arg_8_0._currentState == var_0_6.STATE_SPIN then
		pg = var_3

		local var_8_0 = var_3.TimeMgr.GetInstance()

		arg_8_0._spinStartTime = var_3.GetCombatTime(var_8_0)
	elseif arg_8_0._currentState == var_0_6.STATE_SPLIT then
		arg_8_0:DispatchEvent(var_0.Event.New(var_0_3.SPLIT, {}))
	end

	return
end

function var_0_6.IsOutRange(arg_9_0, arg_9_1)
	if arg_9_0._currentState == var_0_6.STATE_NORMAL then
		return var_0_6.super.IsOutRange(arg_9_0, arg_9_1)
	else
		return false
	end

	return
end

function var_0_6.SetSrcHost(arg_10_0, arg_10_1)
	arg_10_0._srcHost = arg_10_1

	return
end

function var_0_6.GetSrcHost(arg_11_0)
	return arg_11_0._srcHost
end

function var_0_6.GetShrapnelParam(arg_12_0)
	return arg_12_0._tempData.extra_param
end

function var_0_6.GetCurrentState(arg_13_0)
	return arg_13_0._currentState
end

function var_0_6.SetSpawnPosition(arg_14_0, arg_14_1)
	local var_14_0 = arg_14_0:GetTemplate().extra_param
	local var_14_1 = arg_14_1

	if var_14_0.directHit then
		Clone = var_4
		var_14_1 = var_4(arg_14_0._explodePos)
	end

	var_0_6.super.SetSpawnPosition(arg_14_0, var_14_1)

	pg = var_4

	local var_14_2 = var_4.Tool.FilterY(arg_14_0._spawnPos)

	Vector3 = var_1_10005

	local var_14_3 = var_1_10005.Distance
	local var_14_4 = var_14_2

	pg = var_1_10008

	local var_14_5 = var_14_3(var_14_4, var_1_10008.Tool.FilterY(arg_14_0._explodePos))
	local var_14_7

	if var_14_0.flare then
		local var_14_6 = var_14_0.shrapnel[1].bullet_ID

		var_14_7 = var_0.Battle.BattleDataFunction.GetBulletTmpDataFromID(var_14_6).hit_type.time
		math = var_9

		local var_14_8 = var_9.abs
		local var_14_9

		if not var_7.extra_param.gravity then
			var_14_9 = -0.0005
		end

		local var_14_10 = 0.5 * var_14_8(var_14_9) * (var_14_7 * var_0_1.calcFPS)^2 - arg_14_0._spawnPos.y

		math = var_11
		arg_14_0._convertedVelocity = var_11.sqrt(-0.5 * arg_14_0._gravity * var_14_5 * var_14_5 / var_14_10)
		arg_14_0._verticalSpeed = var_14_10 / (var_14_5 / arg_14_0._convertedVelocity) - 0.5 * arg_14_0._gravity * var_11
	elseif var_14_0.rangeAA then
		local var_14_11 = var_0_1.AircraftHeight - arg_14_0._spawnPos.y
		local var_14_12 = 0.5 * arg_14_0._gravity

		math = var_14_7
		arg_14_0._velocity = var_14_7.sqrt(-var_14_12 * var_14_5 * var_14_5 / var_14_11)
		arg_14_0._verticalSpeed = var_14_11 / (var_14_5 / arg_14_0._velocity) - var_14_12 * var_8
		arg_14_0._velocity = var_0_4.ConvertBulletDataSpeed(arg_14_0._velocity)
	elseif arg_14_0._convertedVelocity ~= 0 and arg_14_0._explodePos.y ~= arg_14_0._spawnPos.y then
		local var_14_13 = var_14_5 / arg_14_0._convertedVelocity
		local var_14_14 = arg_14_0._explodePos.y - arg_14_0._spawnPos.y
		local var_14_15

		if not var_14_0.launchVrtSpeed then
			var_14_15 = var_14_14 / var_14_13 - 0.5 * arg_14_0._gravity * var_14_13
		end

		arg_14_0._verticalSpeed = var_14_15
	end

	return
end

function var_0_6.GetExplodePostion(arg_15_0)
	return arg_15_0._explodePos
end

function var_0_6.SetExplodePosition(arg_16_0, arg_16_1)
	Clone = var_1_10002
	arg_16_0._explodePos = var_1_10002(arg_16_1)
	arg_16_0._explodePos.y = var_0_1.BombDetonateHeight

	return
end

function var_0_6.CacheChildEimtter(arg_17_0, arg_17_1)
	table = var_1_10002

	var_1_10002.insert(arg_17_0._cacheEmitter, arg_17_1)

	return
end

function var_0_6.interruptChildEmitter(arg_18_0)
	ipairs = var_1_10001

	for iter_18_0, iter_18_1 in var_1_10001(arg_18_0._cacheEmitter) do
		iter_18_1:Destroy()
	end

	return
end

function var_0_6.Dispose(arg_19_0)
	arg_19_0:interruptChildEmitter()

	arg_19_0._cacheEmitter = nil

	var_0_6.super.Dispose(arg_19_0)

	return
end

return
