ys = ys or {}

local var_0_0 = pg
local var_0_1 = ys.Battle.BattleConst
local var_0_2 = ys.Battle.BattleDataFunction
local var_0_3 = math
local var_0_4 = class("BattleBulletEmitter")

ys.Battle.BattleBulletEmitter = var_0_4
var_0_4.__name = "BattleBulletEmitter"
var_0_4.STATE_ACTIVE = "ACTIVE"
var_0_4.STATE_STOP = "STOP"

function var_0_4.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0._spawnFunc = arg_1_1
	arg_1_0._stopFunc = arg_1_2
	arg_1_0._barrageID = arg_1_3
	arg_1_0._barrageTemp = var_0_2.GetBarrageTmpDataFromID(arg_1_3)
	arg_1_0._offsetPriority = arg_1_0._barrageTemp.offset_prioritise
	arg_1_0._isRandomAngle = arg_1_0._barrageTemp.random_angle
	arg_1_0._timerList = {}
	arg_1_0.PrimalIteration = arg_1_0._barrageTemp.delta_delay ~= 0 and arg_1_0._advancePrimalIteration or arg_1_0._barrageTemp.delay ~= 0 and arg_1_0._averagePrimalIteration or arg_1_0._nonDelayPrimalIteration
	arg_1_0._primalMax = arg_1_0._barrageTemp.primal_repeat + 1

	function arg_1_0.timerCb(arg_2_0)
		arg_1_0._timerList[arg_2_0](arg_1_0, arg_2_0)

		return
	end

	return
end

function var_0_4.Ready(arg_3_0)
	arg_3_0._state = arg_3_0.STATE_ACTIVE
	arg_3_0._seniorCounter = -1

	arg_3_0:ClearAllTimer()

	return
end

function var_0_4.Fire(arg_4_0, arg_4_1, arg_4_2)
	arg_4_0._target = arg_4_1
	arg_4_0._dir = arg_4_2 or var_0_1.UnitDir.RIGHT
	arg_4_0._convertedDirBarrage = arg_4_0._convertedDirBarrage or var_0_2.GetConvertedBarrageTableFromID(arg_4_0._barrageID, arg_4_0._dir)[arg_4_0._dir]

	arg_4_0:SeniorIteration()

	return
end

function var_0_4.Stop(arg_5_0)
	arg_5_0._state = arg_5_0.STATE_STOP
	arg_5_0._target = nil

	arg_5_0:ClearAllTimer()
	arg_5_0:_stopFunc()

	return
end

function var_0_4.Interrupt(arg_6_0)
	arg_6_0._state = arg_6_0.STATE_STOP
	arg_6_0._target = nil

	arg_6_0:ClearAllTimer()

	return
end

function var_0_4.Destroy(arg_7_0)
	arg_7_0._spawnFunc = nil
	arg_7_0._stopFunc = nil
	arg_7_0._convertedDirBarrage = nil

	if arg_7_0._timerList then
		arg_7_0:ClearAllTimer()
	end

	return
end

function var_0_4.GetState(arg_8_0)
	return arg_8_0._state
end

function var_0_4.ClearAllTimer(arg_9_0)
	for iter_9_0, iter_9_1 in pairs(arg_9_0._timerList) do
		var_0_0.TimeMgr.GetInstance():RemoveBattleTimer(iter_9_0)
	end

	arg_9_0._timerList = {}

	return
end

function var_0_4.GenerateBullet(arg_10_0)
	local var_10_0 = arg_10_0._convertedDirBarrage[arg_10_0._primalCounter]
	local var_10_1 = arg_10_0._convertedDirBarrage[arg_10_0._primalCounter].OffsetX

	arg_10_0._delay = arg_10_0._convertedDirBarrage[arg_10_0._primalCounter].Delay

	local var_10_2 = arg_10_0._isRandomAngle and (var_0_3.random() - 0.5) * var_10_0.Angle or var_10_0.Angle
	local var_10_3 = arg_10_0._spawnFunc(var_10_1, var_10_0.OffsetZ, var_10_2, arg_10_0._offsetPriority, arg_10_0._target, arg_10_0._primalCounter)

	if var_10_3 then
		var_10_3:SetBarrageTransformTempate((var_0_2.GenerateTransBarrage(arg_10_0._barrageID, arg_10_0._dir, arg_10_0._primalCounter)))
	end

	arg_10_0:Interation()

	return
end

function var_0_4.DelaySeniorFunc(arg_11_0, arg_11_1)
	var_0_0.TimeMgr.GetInstance():RemoveBattleTimer(arg_11_1)

	arg_11_0._timerList[arg_11_1] = nil

	arg_11_0:PrimalIteration()

	return
end

function var_0_4.SeniorIteration(arg_12_0)
	if arg_12_0._state ~= arg_12_0.STATE_ACTIVE then
		return
	end

	arg_12_0._seniorCounter = arg_12_0._seniorCounter + 1

	if arg_12_0._seniorCounter > arg_12_0._barrageTemp.senior_repeat then
		arg_12_0:Stop()
	else
		arg_12_0:InitParam()

		local var_12_0 = arg_12_0._seniorCounter == 0 and arg_12_0._barrageTemp.first_delay or arg_12_0._barrageTemp.senior_delay

		if var_12_0 > 0 then
			arg_12_0._timerList[var_0_0.TimeMgr.GetInstance():AddBattleTimer("spawnBullet", -1, var_12_0, arg_12_0.timerCb, true)] = arg_12_0.DelaySeniorFunc
		else
			arg_12_0:PrimalIteration()
		end
	end

	return
end

function var_0_4.InitParam(arg_13_0)
	arg_13_0._delay = arg_13_0._barrageTemp.delay
	arg_13_0._primalCounter = 1

	return
end

function var_0_4.Interation(arg_14_0)
	arg_14_0._primalCounter = arg_14_0._primalCounter + 1

	return
end

function var_0_4.SetTimeScale(arg_15_0, arg_15_1)
	if arg_15_0._timerList then
		for iter_15_0, iter_15_1 in pairs(arg_15_0._timerList) do
			iter_15_0:SetScale(arg_15_1)
		end
	end

	return
end

function var_0_4.DelayPrimalConst(arg_16_0, arg_16_1)
	arg_16_0:GenerateBullet()

	if arg_16_0._primalCounter > arg_16_0._primalMax then
		var_0_0.TimeMgr.GetInstance():RemoveBattleTimer(arg_16_1)

		arg_16_0._timerList[arg_16_1] = nil

		arg_16_0:SeniorIteration()
	end

	return
end

function var_0_4._averagePrimalIteration(arg_17_0)
	if arg_17_0._state ~= arg_17_0.STATE_ACTIVE then
		return
	end

	local var_17_0 = var_0_0.TimeMgr.GetInstance():AddBattleTimer("spawnBullet", -1, arg_17_0._delay, arg_17_0.timerCb, true)

	arg_17_0._timerList[var_17_0] = arg_17_0.DelayPrimalConst

	return
end

function var_0_4.DelayPrimalAdvance(arg_18_0, arg_18_1)
	var_0_0.TimeMgr.GetInstance():RemoveBattleTimer(arg_18_1)

	arg_18_0._timerList[arg_18_1] = nil

	arg_18_0:GenerateBullet()

	if arg_18_0._primalCounter > arg_18_0._primalMax then
		arg_18_0:SeniorIteration()
	else
		arg_18_0:PrimalIteration()
	end

	return
end

function var_0_4._advancePrimalIteration(arg_19_0)
	if arg_19_0._state ~= arg_19_0.STATE_ACTIVE then
		return
	end

	if arg_19_0._delay == 0 then
		arg_19_0:GenerateBullet()

		if arg_19_0._primalCounter > arg_19_0._primalMax then
			arg_19_0:SeniorIteration()
		else
			arg_19_0:PrimalIteration()
		end
	else
		local var_19_0 = var_0_0.TimeMgr.GetInstance():AddBattleTimer("spawnBullet", -1, arg_19_0._delay, arg_19_0.timerCb, true)

		arg_19_0._timerList[var_19_0] = arg_19_0.DelayPrimalAdvance
	end

	return
end

function var_0_4._nonDelayPrimalIteration(arg_20_0)
	if arg_20_0._state ~= arg_20_0.STATE_ACTIVE then
		return
	end

	arg_20_0:GenerateBullet()

	if arg_20_0._primalCounter > arg_20_0._primalMax then
		arg_20_0:SeniorIteration()
	else
		arg_20_0:PrimalIteration()
	end

	return
end

return
