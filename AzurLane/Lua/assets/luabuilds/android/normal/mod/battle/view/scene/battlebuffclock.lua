ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle

class = var_0_10002
var_0_1.BattleBuffClock = var_0_10002("BattleBuffClock")
var_0.Battle.BattleBuffClock.__name = "BattleBuffClock"

local var_0_2 = var_0.Battle.BattleBuffClock

Vector3 = var_2
var_0_2.OFFSET = var_2(1.8, 2.3, 0)
var_0_2.TYPE_INDEX = 3

function var_0_2.Ctor(arg_1_0, arg_1_1)
	arg_1_0._castClockTF = arg_1_1
	arg_1_0._castClockGO = arg_1_0._castClockTF.gameObject

	local var_1_0 = arg_1_0._castClockTF

	arg_1_0._bgList = var_2.Find(var_1_0, "bg")

	local var_1_1 = arg_1_0._castClockTF

	arg_1_0._danger = var_2.Find(var_1_1, "danger")

	local var_1_2 = arg_1_0._castClockTF

	arg_1_0._interrupt = var_2.Find(var_1_2, "interrupt")

	local var_1_3 = arg_1_0._castClockTF

	arg_1_0._casting = var_2.Find(var_1_3, "casting")

	local var_1_4 = arg_1_0._castClockTF

	arg_1_0._progressProtected = var_2.Find(var_1_4, "progress/protected")

	local var_1_5 = arg_1_0._castClockTF

	arg_1_0._progressInterrupt = var_2.Find(var_1_5, "progress/interrupt")

	local var_1_6 = arg_1_0._castClockTF
	local var_1_7 = var_2.GetComponent

	typeof = var_4
	CanvasGroup = var_1_10005
	arg_1_0._clockCG = var_1_7(var_1_6, var_4(var_1_10005))

	return
end

function var_0_2.switchToIndex(arg_2_0, arg_2_1, arg_2_2)
	for iter_2_0 = 1, var_0_2.TYPE_INDEX do
		local var_2_0 = arg_2_1
		local var_2_1 = arg_2_1.Find

		tostring = var_1_10009

		local var_2_2 = var_2_1(var_2_0, var_1_10009(iter_2_0))

		SetActive = var_2_0

		var_2_0(var_2_2, arg_2_2 == iter_2_0)
	end

	return
end

function var_0_2.IsActive(arg_3_0)
	return arg_3_0._buffEffect ~= nil
end

function var_0_2.Casting(arg_4_0, arg_4_1)
	LeanTween = var_1_10002

	var_1_10002.cancel(arg_4_0._castClockGO)

	local var_4_0 = arg_4_0._castClockTF

	Vector3 = var_3
	var_4_0.localScale = var_3(0.1, 0.1, 1)

	local var_4_1 = arg_4_1.iconType

	arg_4_0:switchToIndex(arg_4_0._bgList, var_4_1)
	arg_4_0:switchToIndex(arg_4_0._danger, var_4_1)
	arg_4_0:switchToIndex(arg_4_0._interrupt, var_4_1)
	arg_4_0:switchToIndex(arg_4_0._casting, var_4_1)

	SetActive = var_3

	var_3(arg_4_0._progressInterrupt, arg_4_1.interrupt)

	SetActive = var_3

	var_3(arg_4_0._progressProtected, not arg_4_1.interrupt)

	if arg_4_1.interrupt then
		local var_4_2 = arg_4_0._progressInterrupt
		local var_4_3 = var_4_3.GetComponent

		typeof = var_5
		Image = var_6

		if not var_4_3(var_4_2, var_5(var_6)) then
			local var_4_4 = arg_4_0._progressProtected

			var_4_3 = var_4_3.GetComponent
			typeof = var_5
			Image = var_6
			var_4_3 = var_4_3(var_4_4, var_5(var_6))
		end

		arg_4_0._castProgress = var_4_3
		SetActive = var_4_3

		var_4_3(arg_4_0._castClockTF, true)

		SetActive = var_4_3

		var_4_3(arg_4_0._casting, true)

		SetActive = var_4_3

		var_4_3(arg_4_0._interrupt, false)

		LeanTween = var_4_3

		local var_4_5 = var_4_3.scale

		rtf = var_4

		local var_4_6 = var_4(arg_4_0._castClockGO)

		Vector3 = var_5

		local var_4_7 = var_4_5(var_4_6, var_5.New(1, 1, 1), 0.1)
		local var_4_8 = var_3.setEase

		LeanTweenType = var_5

		var_4_8(var_4_7, var_5.easeInBack)

		LeanTween = var_4_8

		local var_4_9 = var_4_8.rotate

		rtf = var_4_7

		local var_4_10 = var_4_9(var_4_7(arg_4_0._danger), 360, 5)

		var_3.setLoopClamp(var_4_10)

		arg_4_0._buffEffect = arg_4_1.buffEffect

		return
	end
end

function var_0_2.Interrupt(arg_5_0, arg_5_1)
	if arg_5_1.interrupt then
		SetActive = var_2

		var_2(arg_5_0._casting, false)

		SetActive = var_2

		var_2(arg_5_0._interrupt, true)
	end

	LeanTween = var_2

	local var_5_0 = var_2.cancel

	go = var_1_10003

	var_5_0(var_1_10003(arg_5_0._danger))

	for iter_5_0 = 1, 2 do
		LeanTween = var_1_10006

		local var_5_1 = var_1_10006.alphaCanvas(arg_5_0._clockCG, 0.3, 0.3)
		local var_5_2 = var_1_10006.setFrom(var_5_1, 1)

		var_1_10006.setDelay(var_5_2, 0.3 * (iter_5_0 - 1))

		LeanTween = var_1_10006

		local var_5_3 = var_1_10006.alphaCanvas(arg_5_0._clockCG, 1, 0.3)

		var_1_10006.setDelay(var_5_3, 0.3 * iter_5_0)
	end

	LeanTween = var_2

	local var_5_4 = var_2.scale

	rtf = var_3

	local var_5_5 = var_3(arg_5_0._castClockGO)

	Vector3 = var_4

	local var_5_6 = var_5_4(var_5_5, var_4.New(0.1, 0.1, 1), 0.3)
	local var_5_7 = var_2.setEase

	LeanTweenType = var_4

	local var_5_8 = var_5_7(var_5_6, var_4.easeInBack)
	local var_5_9 = var_2.setDelay(var_5_8, 1.25)
	local var_5_10 = var_2.setOnComplete

	System = var_4

	var_5_10(var_5_9, var_4.Action(function()
		local var_6_0 = arg_5_0

		var_6_0._buffEffect = nil
		SetActive = var_6_0

		var_6_0(arg_5_0._castClockTF, false)

		return
	end))

	return
end

function var_0_2.UpdateCastClockPosition(arg_7_0, arg_7_1)
	arg_7_0._castClockTF.position = arg_7_1 + var_0_2.OFFSET

	return
end

function var_0_2.UpdateCastClock(arg_8_0)
	local var_8_0 = arg_8_0._castProgress
	local var_8_1 = arg_8_0._buffEffect

	var_8_0.fillAmount = var_2.GetCountProgress(var_8_1)

	return
end

function var_0_2.Dispose(arg_9_0)
	arg_9_0._buffEffect = nil
	Object = var_1

	var_1.Destroy(arg_9_0._castClockGO)

	arg_9_0._castClockTF = nil
	arg_9_0._castClockGO = nil
	arg_9_0._castProgress = nil
	arg_9_0._interrupt = nil
	arg_9_0._casting = nil
	arg_9_0._bgList = nil
	arg_9_0._danger = nil
	arg_9_0._progressInterrupt = nil
	arg_9_0._progressProtected = nil

	return
end

return
