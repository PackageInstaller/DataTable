ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle.BattleConst

math = var_0_10002
class = var_0_10003

local var_0_2 = var_0_10003("BattleShotgunEmitter", var_0.Battle.BattleBulletEmitter)

var_0.Battle.BattleShotgunEmitter = var_0_2
var_0_2.__name = "BattleShotgunEmitter"

function var_0_2.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	var_0.Battle.BattleShotgunEmitter.super.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)

	arg_1_0.PrimalIteration = arg_1_0._nonDelayPrimalIteration

	return
end

function var_0_2.Fire(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	arg_2_0._angleRange = arg_2_3

	var_0.Battle.BattleShotgunEmitter.super.Fire(arg_2_0, arg_2_1, arg_2_2)

	return
end

function var_0_2.GenerateBullet(arg_3_0)
	local var_3_0 = arg_3_0._convertedDirBarrage[arg_3_0._primalCounter].OffsetX

	arg_3_0._delay = var_1.Delay

	local var_3_1

	if arg_3_0._isRandomAngle then
		var_3_1 = (var_0_10002.random() - 0.5) * var_0_10002.random(arg_3_0._angleRange) - arg_3_0._angleRange / 2
	else
		var_3_1 = var_0_10002.random(arg_3_0._angleRange) - arg_3_0._angleRange / 2
	end

	arg_3_0._spawnFunc(var_3_0, var_1.OffsetZ, var_3_1, arg_3_0._offsetPriority, arg_3_0._target, arg_3_0._primalCounter)
	arg_3_0:Interation()

	return
end

return
