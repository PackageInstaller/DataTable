ys = ys or {}

local BattleKizunaJammingView = class("BattleKizunaJammingView")

ys.Battle.BattleKizunaJammingView = BattleKizunaJammingView
BattleKizunaJammingView.__name = "BattleKizunaJammingView"
BattleKizunaJammingView.COUNT = 3
BattleKizunaJammingView.EXPAND_DURATION = 5

function BattleKizunaJammingView:Ctor(arg_1_1)
	self._go = arg_1_1
	self._tf = arg_1_1.transform
	self._hitCount = 0

	return
end

function BattleKizunaJammingView:ConfigCallback(arg_2_1)
	self._callback = arg_2_1

	self:init()

	return
end

function BattleKizunaJammingView:init()
	self.eventTriggers = {}
	self._blocker = self._tf:Find("KizunaAiBlocker")

	local var_3_0 = GetOrAddComponent(self._blocker, "EventTriggerListener")

	self.eventTriggers[var_3_0] = true

	var_3_0:AddPointDownFunc(function()
		self._hitCount = self._hitCount + 1

		if self._hitCount >= BattleKizunaJammingView.COUNT then
			self:Eliminate(true)
		else
			setActive(self._blocker:Find("normal"), false)
			setActive(self._blocker:Find("hitted"), true)
			LeanTween.cancel(go(self._blocker))
			self:ClickEase()
		end

		return
	end)
	var_3_0:AddPointUpFunc(function()
		if self._hitCount < BattleKizunaJammingView.COUNT then
			setActive(self._blocker:Find("normal"), true)
			setActive(self._blocker:Find("hitted"), false)
		end

		return
	end)

	return
end

function BattleKizunaJammingView:Active()
	LeanTween.scale(self._blocker, Vector3(1, 1, 0), (1 - self._blocker.localScale.x) * BattleKizunaJammingView.EXPAND_DURATION)

	return
end

function BattleKizunaJammingView:Pause()
	LeanTween.cancel(go(self._blocker))

	return
end

function BattleKizunaJammingView:ClickEase()
	LeanTween.scale(self._blocker, Vector3(self._blocker.localScale.x - 0.05, self._blocker.localScale.x - 0.05, 0), 0.03):setOnComplete(System.Action(function()
		self:Active()

		return
	end))

	return
end

function BattleKizunaJammingView:Eliminate(arg_10_1)
	LeanTween.cancel(go(self._blocker))
	setActive(self._blocker:Find("normal"), not arg_10_1)
	setActive(self._blocker:Find("hitted"), arg_10_1)
	LeanTween.scale(self._blocker, Vector3(0, 0, 0), 0.1):setOnComplete(System.Action(function()
		self._callback()

		return
	end))

	return
end

function BattleKizunaJammingView:Dispose()
	if self.eventTriggers then
		for iter_12_0, iter_12_1 in pairs(self.eventTriggers) do
			ClearEventTrigger(iter_12_0)
		end

		self.eventTriggers = nil
	end

	LeanTween.cancel(go(self._blocker))

	return
end

return
