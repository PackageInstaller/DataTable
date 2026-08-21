ys = ys or {}

local var_0_1 = class("BattleKizunaJammingView")

ys.Battle.BattleKizunaJammingView = var_0_1
var_0_1.__name = "BattleKizunaJammingView"
var_0_1.COUNT = 3
var_0_1.EXPAND_DURATION = 5

function var_0_1.Ctor(arg_1_0, arg_1_1)
	arg_1_0._go = arg_1_1
	arg_1_0._tf = arg_1_1.transform
	arg_1_0._hitCount = 0

	return
end

function var_0_1.ConfigCallback(arg_2_0, arg_2_1)
	arg_2_0._callback = arg_2_1

	arg_2_0:init()

	return
end

function var_0_1.init(arg_3_0)
	arg_3_0.eventTriggers = {}
	arg_3_0._blocker = arg_3_0._tf:Find("KizunaAiBlocker")

	local var_3_0 = GetOrAddComponent(arg_3_0._blocker, "EventTriggerListener")

	arg_3_0.eventTriggers[var_3_0] = true

	var_3_0:AddPointDownFunc(function()
		arg_3_0._hitCount = arg_3_0._hitCount + 1

		if arg_3_0._hitCount >= var_0_1.COUNT then
			arg_3_0:Eliminate(true)
		else
			setActive(arg_3_0._blocker:Find("normal"), false)
			setActive(arg_3_0._blocker:Find("hitted"), true)
			LeanTween.cancel(go(arg_3_0._blocker))
			arg_3_0:ClickEase()
		end

		return
	end)
	var_3_0:AddPointUpFunc(function()
		if arg_3_0._hitCount < var_0_1.COUNT then
			setActive(arg_3_0._blocker:Find("normal"), true)
			setActive(arg_3_0._blocker:Find("hitted"), false)
		end

		return
	end)

	return
end

function var_0_1.Active(arg_6_0)
	LeanTween.scale(arg_6_0._blocker, Vector3(1, 1, 0), (1 - arg_6_0._blocker.localScale.x) * var_0_1.EXPAND_DURATION)

	return
end

function var_0_1.Pause(arg_7_0)
	LeanTween.cancel(go(arg_7_0._blocker))

	return
end

function var_0_1.ClickEase(arg_8_0)
	LeanTween.scale(arg_8_0._blocker, Vector3(arg_8_0._blocker.localScale.x - 0.05, arg_8_0._blocker.localScale.x - 0.05, 0), 0.03):setOnComplete(System.Action(function()
		arg_8_0:Active()

		return
	end))

	return
end

function var_0_1.Eliminate(arg_10_0, arg_10_1)
	LeanTween.cancel(go(arg_10_0._blocker))
	setActive(arg_10_0._blocker:Find("normal"), not arg_10_1)
	setActive(arg_10_0._blocker:Find("hitted"), arg_10_1)
	LeanTween.scale(arg_10_0._blocker, Vector3(0, 0, 0), 0.1):setOnComplete(System.Action(function()
		arg_10_0._callback()

		return
	end))

	return
end

function var_0_1.Dispose(arg_12_0)
	if arg_12_0.eventTriggers then
		for iter_12_0, iter_12_1 in pairs(arg_12_0.eventTriggers) do
			ClearEventTrigger(iter_12_0)
		end

		arg_12_0.eventTriggers = nil
	end

	LeanTween.cancel(go(arg_12_0._blocker))

	return
end

return
