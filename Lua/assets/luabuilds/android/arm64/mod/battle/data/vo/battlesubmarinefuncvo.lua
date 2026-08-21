ys = ys or {}

local var_0_0 = ys

ys.Battle.BattleSubmarineFuncVO = class("BattleSubmarineFuncVO")
ys.Battle.BattleSubmarineFuncVO.__name = "BattleSubmarineFuncVO"

function ys.Battle.BattleSubmarineFuncVO.Ctor(arg_1_0, arg_1_1)
	var_0_0.EventDispatcher.AttachEventDispatcher(arg_1_0)

	arg_1_0._current = arg_1_1
	arg_1_0._defaultMax = arg_1_1
	arg_1_0._active = true

	arg_1_0:ResetMax()

	return
end

function ys.Battle.BattleSubmarineFuncVO.Update(arg_2_0, arg_2_1)
	if arg_2_0._active and arg_2_0._current < arg_2_0._max then
		if arg_2_1 - arg_2_0._reloadStartTime >= arg_2_0._max then
			arg_2_0:ResetMax()

			arg_2_0._current = arg_2_0._max
			arg_2_0._reloadStartTime = nil

			arg_2_0:DispatchOverLoadChange()
		else
			arg_2_0._current = arg_2_1 - arg_2_0._reloadStartTime
		end
	end

	return
end

function ys.Battle.BattleSubmarineFuncVO.SetActive(arg_3_0, arg_3_1)
	arg_3_0._active = arg_3_1

	return
end

function ys.Battle.BattleSubmarineFuncVO.ResetCurrent(arg_4_0)
	arg_4_0._current = 0
	arg_4_0._reloadStartTime = pg.TimeMgr.GetInstance():GetCombatTime()

	arg_4_0:DispatchOverLoadChange()

	return
end

function ys.Battle.BattleSubmarineFuncVO.ResetMax(arg_5_0)
	arg_5_0._max = arg_5_0._defaultMax

	return
end

function ys.Battle.BattleSubmarineFuncVO.SetMax(arg_6_0, arg_6_1)
	arg_6_0._max = arg_6_1

	return
end

function ys.Battle.BattleSubmarineFuncVO.GetMax(arg_7_0)
	return arg_7_0._max
end

function ys.Battle.BattleSubmarineFuncVO.GetTotal(arg_8_0)
	return 0
end

function ys.Battle.BattleSubmarineFuncVO.GetCurrent(arg_9_0)
	return arg_9_0._current
end

function ys.Battle.BattleSubmarineFuncVO.IsOverLoad(arg_10_0)
	return arg_10_0._current < arg_10_0._max
end

function ys.Battle.BattleSubmarineFuncVO.DispatchOverLoadChange(arg_11_0)
	arg_11_0:DispatchEvent((var_0_0.Event.New(var_0_0.Battle.BattleEvent.OVER_LOAD_CHANGE)))

	return
end

function ys.Battle.BattleSubmarineFuncVO.Dispose(arg_12_0)
	pg.TimeMgr.GetInstance():RemoveBattleTimer(arg_12_0._focusTimer)

	arg_12_0._focusTimer = nil

	var_0_0.EventDispatcher.DetachEventDispatcher(arg_12_0)

	return
end

return
