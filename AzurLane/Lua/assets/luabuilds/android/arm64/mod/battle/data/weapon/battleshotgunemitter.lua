ys = ys or {}

local var_0_1 = math
local var_0_2 = class("BattleShotgunEmitter", ys.Battle.BattleBulletEmitter)

ys.Battle.BattleShotgunEmitter = var_0_2
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
	local var_3_0 = arg_3_0._convertedDirBarrage[arg_3_0._primalCounter]
	local var_3_1 = arg_3_0._convertedDirBarrage[arg_3_0._primalCounter].OffsetX

	arg_3_0._delay = arg_3_0._convertedDirBarrage[arg_3_0._primalCounter].Delay

	local var_3_2 = arg_3_0._isRandomAngle and (var_0_1.random() - 0.5) * var_0_1.random(arg_3_0._angleRange) - arg_3_0._angleRange / 2 or var_0_1.random(arg_3_0._angleRange) - arg_3_0._angleRange / 2

	arg_3_0._spawnFunc(var_3_1, var_3_0.OffsetZ, var_3_2, arg_3_0._offsetPriority, arg_3_0._target, arg_3_0._primalCounter)
	arg_3_0:Interation()

	return
end

return
