ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle.BattleDataFunction

class = var_0_10002

local var_0_2 = var_0_10002("BattleKizunaJammingView")

var_0.Battle.BattleKizunaJammingView = var_0_2
var_0_2.__name = "BattleKizunaJammingView"
var_0_2.COUNT = 3
var_0_2.EXPAND_DURATION = 5

function var_0_2.Ctor(arg_1_0, arg_1_1)
	arg_1_0._go = arg_1_1
	arg_1_0._tf = arg_1_1.transform
	arg_1_0._hitCount = 0

	return
end

function var_0_2.ConfigCallback(arg_2_0, arg_2_1)
	arg_2_0._callback = arg_2_1

	arg_2_0:init()

	return
end

function var_0_2.init(arg_3_0)
	arg_3_0.eventTriggers = {}

	local var_3_0 = arg_3_0._tf

	arg_3_0._blocker = var_1.Find(var_3_0, "KizunaAiBlocker")
	GetOrAddComponent = var_1

	local var_3_1 = var_1(arg_3_0._blocker, "EventTriggerListener")

	arg_3_0.eventTriggers[var_3_1] = true

	var_3_1:AddPointDownFunc(function()
		arg_3_0._hitCount = arg_3_0._hitCount + 1

		if arg_3_0._hitCount >= var_0_2.COUNT then
			local var_4_0 = arg_3_0

			var_0.Eliminate(var_4_0, true)
		else
			setActive = var_0

			local var_4_1 = arg_3_0._blocker

			var_0(var_1.Find(var_4_1, "normal"), false)

			setActive = var_0

			local var_4_2 = arg_3_0._blocker

			var_0(var_1.Find(var_4_2, "hitted"), true)

			LeanTween = var_0

			local var_4_3 = var_0.cancel

			go = var_1

			var_4_3(var_1(arg_3_0._blocker))

			local var_4_4 = arg_3_0

			var_0.ClickEase(var_4_4)
		end

		return
	end)
	var_3_1:AddPointUpFunc(function()
		if arg_3_0._hitCount < var_0_2.COUNT then
			setActive = var_0

			local var_5_0 = arg_3_0._blocker

			var_0(var_1.Find(var_5_0, "normal"), true)

			setActive = var_0

			local var_5_1 = arg_3_0._blocker

			var_0(var_1.Find(var_5_1, "hitted"), false)
		end

		return
	end)

	return
end

function var_0_2.Active(arg_6_0)
	local var_6_0 = (1 - arg_6_0._blocker.localScale.x) * var_0_2.EXPAND_DURATION

	LeanTween = var_3

	local var_6_1 = var_3.scale
	local var_6_2 = arg_6_0._blocker

	Vector3 = var_1_10005

	var_6_1(var_6_2, var_1_10005(1, 1, 0), var_6_0)

	return
end

function var_0_2.Pause(arg_7_0)
	LeanTween = var_1_10001

	local var_7_0 = var_1_10001.cancel

	go = var_1_10002

	var_7_0(var_1_10002(arg_7_0._blocker))

	return
end

function var_0_2.ClickEase(arg_8_0)
	local var_8_0 = arg_8_0._blocker.localScale.x - 0.05

	LeanTween = var_1_10003

	local var_8_1 = var_1_10003.scale
	local var_8_2 = arg_8_0._blocker

	Vector3 = var_1_10005

	local var_8_3 = var_8_1(var_8_2, var_1_10005(var_8_0, var_8_0, 0), 0.03)
	local var_8_4 = var_3.setOnComplete

	System = var_5

	var_8_4(var_8_3, var_5.Action(function()
		local var_9_0 = arg_8_0

		var_0.Active(var_9_0)

		return
	end))

	return
end

function var_0_2.Eliminate(arg_10_0, arg_10_1)
	LeanTween = var_1_10002

	local var_10_0 = var_1_10002.cancel

	go = var_1_10003

	var_10_0(var_1_10003(arg_10_0._blocker))

	setActive = var_10_0

	local var_10_1 = arg_10_0._blocker

	var_10_0(var_3.Find(var_10_1, "normal"), not arg_10_1)

	setActive = var_10_0

	local var_10_2 = arg_10_0._blocker

	var_10_0(var_3.Find(var_10_2, "hitted"), arg_10_1)

	LeanTween = var_10_0

	local var_10_3 = var_10_0.scale
	local var_10_4 = arg_10_0._blocker

	Vector3 = var_4

	local var_10_5 = var_10_3(var_10_4, var_4(0, 0, 0), 0.1)
	local var_10_6 = var_2.setOnComplete

	System = var_4

	var_10_6(var_10_5, var_4.Action(function()
		arg_10_0._callback()

		return
	end))

	return
end

function var_0_2.Dispose(arg_12_0)
	if arg_12_0.eventTriggers then
		pairs = var_1

		for iter_12_0, iter_12_1 in var_1(arg_12_0.eventTriggers) do
			ClearEventTrigger = var_1_10006

			var_1_10006(iter_12_0)
		end

		arg_12_0.eventTriggers = nil
	end

	LeanTween = var_1

	local var_12_0 = var_1.cancel

	go = var_1_10002

	var_12_0(var_1_10002(arg_12_0._blocker))

	return
end

return
