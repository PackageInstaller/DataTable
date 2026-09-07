ys = ys or {}

local var_0_0 = ys

ys.Battle.BattleSubmarineFuncVO = class("BattleSubmarineFuncVO")
ys.Battle.BattleSubmarineFuncVO.__name = "BattleSubmarineFuncVO"

function ys.Battle.BattleSubmarineFuncVO:Ctor(arg_1_1)
	var_0_0.EventDispatcher.AttachEventDispatcher(self)

	self._current = arg_1_1
	self._defaultMax = arg_1_1
	self._active = true

	self:ResetMax()

	return
end

function ys.Battle.BattleSubmarineFuncVO:Update(arg_2_1)
	if self._active and self._current < self._max then
		if arg_2_1 - self._reloadStartTime >= self._max then
			self:ResetMax()

			self._current = self._max
			self._reloadStartTime = nil

			self:DispatchOverLoadChange()
		else
			self._current = arg_2_1 - self._reloadStartTime
		end
	end

	return
end

function ys.Battle.BattleSubmarineFuncVO.SetActive(arg_3_0, arg_3_1)
	arg_3_0._active = arg_3_1

	return
end

function ys.Battle.BattleSubmarineFuncVO:ResetCurrent()
	self._current = 0
	self._reloadStartTime = pg.TimeMgr.GetInstance():GetCombatTime()

	self:DispatchOverLoadChange()

	return
end

function ys.Battle.BattleSubmarineFuncVO:ResetMax()
	self._max = self._defaultMax

	return
end

function ys.Battle.BattleSubmarineFuncVO.SetMax(arg_6_0, arg_6_1)
	arg_6_0._max = arg_6_1

	return
end

function ys.Battle.BattleSubmarineFuncVO:GetMax()
	return self._max
end

function ys.Battle.BattleSubmarineFuncVO.GetTotal(arg_8_0)
	return 0
end

function ys.Battle.BattleSubmarineFuncVO:GetCurrent()
	return self._current
end

function ys.Battle.BattleSubmarineFuncVO:IsOverLoad()
	return self._current < self._max
end

function ys.Battle.BattleSubmarineFuncVO:DispatchOverLoadChange()
	self:DispatchEvent((var_0_0.Event.New(var_0_0.Battle.BattleEvent.OVER_LOAD_CHANGE)))

	return
end

function ys.Battle.BattleSubmarineFuncVO:Dispose()
	pg.TimeMgr.GetInstance():RemoveBattleTimer(self._focusTimer)

	self._focusTimer = nil

	var_0_0.EventDispatcher.DetachEventDispatcher(self)

	return
end

return
