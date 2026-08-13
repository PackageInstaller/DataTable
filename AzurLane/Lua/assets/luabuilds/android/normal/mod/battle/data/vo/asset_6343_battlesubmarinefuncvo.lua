ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle.BattleConfig
local var_0_2 = var_0.Battle.BattleVariable
local var_0_3 = var_0.Battle

class = var_0_10004
var_0_3.BattleSubmarineFuncVO = var_0_10004("BattleSubmarineFuncVO")
var_0.Battle.BattleSubmarineFuncVO.__name = "BattleSubmarineFuncVO"

local var_0_4 = var_0.Battle.BattleSubmarineFuncVO

function var_0_4.Ctor(arg_1_0, arg_1_1)
	var_0.EventDispatcher.AttachEventDispatcher(arg_1_0)

	arg_1_0._current = arg_1_1
	arg_1_0._defaultMax = arg_1_1
	arg_1_0._active = true

	arg_1_0:ResetMax()

	return
end

function var_0_4.Update(arg_2_0, arg_2_1)
	if arg_2_0._active and arg_2_0._current < arg_2_0._max then
		if arg_2_1 - arg_2_0._reloadStartTime >= arg_2_0._max then
			arg_2_0:ResetMax()

			arg_2_0._current = arg_2_0._max
			arg_2_0._reloadStartTime = nil

			arg_2_0:DispatchOverLoadChange()
		else
			arg_2_0._current = var_2
		end
	end

	return
end

function var_0_4.SetActive(arg_3_0, arg_3_1)
	arg_3_0._active = arg_3_1

	return
end

function var_0_4.ResetCurrent(arg_4_0)
	arg_4_0._current = 0
	pg = var_1

	local var_4_0 = var_1.TimeMgr.GetInstance()

	arg_4_0._reloadStartTime = var_1.GetCombatTime(var_4_0)

	arg_4_0:DispatchOverLoadChange()

	return
end

function var_0_4.ResetMax(arg_5_0)
	arg_5_0._max = arg_5_0._defaultMax

	return
end

function var_0_4.SetMax(arg_6_0, arg_6_1)
	arg_6_0._max = arg_6_1

	return
end

function var_0_4.GetMax(arg_7_0)
	return arg_7_0._max
end

function var_0_4.GetTotal(arg_8_0)
	return 0
end

function var_0_4.GetCurrent(arg_9_0)
	return arg_9_0._current
end

function var_0_4.IsOverLoad(arg_10_0)
	return arg_10_0._current < arg_10_0._max
end

function var_0_4.DispatchOverLoadChange(arg_11_0)
	local var_11_0 = var_0.Event.New(var_0.Battle.BattleEvent.OVER_LOAD_CHANGE)

	arg_11_0:DispatchEvent(var_11_0)

	return
end

function var_0_4.Dispose(arg_12_0)
	pg = var_1_10001

	local var_12_0 = var_1_10001.TimeMgr.GetInstance()

	var_1.RemoveBattleTimer(var_12_0, arg_12_0._focusTimer)

	arg_12_0._focusTimer = nil

	var_0.EventDispatcher.DetachEventDispatcher(arg_12_0)

	return
end

return
