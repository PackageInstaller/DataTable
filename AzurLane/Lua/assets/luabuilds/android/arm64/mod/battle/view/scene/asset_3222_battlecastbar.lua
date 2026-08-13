ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle

class = var_0_10002
var_0_1.BattleCastBar = var_0_10002("BattleCastBar")
var_0.Battle.BattleCastBar.__name = "BattleCastBar"

local var_0_2 = var_0.Battle.BattleCastBar

Vector3 = var_2
var_0_2.OFFSET = var_2(1.8, 2.3, 0)

function var_0_2.Ctor(arg_1_0, arg_1_1)
	arg_1_0._castClockTF = arg_1_1
	arg_1_0._castClockGO = arg_1_0._castClockTF.gameObject

	local var_1_0 = arg_1_0._castClockTF
	local var_1_1 = var_2.Find(var_1_0, "cast_progress")
	local var_1_2 = var_2.GetComponent

	typeof = var_5
	Image = var_1_10007
	arg_1_0._castProgress = var_1_2(var_1_1, var_5(var_1_10007))

	local var_1_3 = arg_1_0._castClockTF

	arg_1_0._interrupt = var_2.Find(var_1_3, "interrupt")

	local var_1_4 = arg_1_0._castClockTF

	arg_1_0._casting = var_2.Find(var_1_4, "casting")

	local var_1_5 = arg_1_0._castClockTF

	arg_1_0._danger = var_2.Find(var_1_5, "danger")

	local var_1_6 = arg_1_0._castClockTF
	local var_1_7 = var_2.GetComponent

	typeof = var_5
	CanvasGroup = var_1_10007
	arg_1_0._clockCG = var_1_7(var_1_6, var_5(var_1_10007))

	return
end

function var_0_2.Casting(arg_2_0, arg_2_1, arg_2_2)
	LeanTween = var_1_10003

	var_1_10003.cancel(arg_2_0._castClockGO)

	local var_2_0 = arg_2_0._castClockTF

	Vector3 = var_1_10004
	var_2_0.localScale = var_1_10004(0.1, 0.1, 1)
	SetActive = var_2_0

	var_2_0(arg_2_0._castClockTF, true)

	SetActive = var_2_0

	var_2_0(arg_2_0._casting, true)

	SetActive = var_2_0

	var_2_0(arg_2_0._interrupt, false)

	LeanTween = var_2_0

	local var_2_1 = var_2_0.scale

	rtf = var_5

	local var_2_2 = var_5(arg_2_0._castClockGO)

	Vector3 = var_6

	local var_2_3 = var_2_1(var_2_2, var_6.New(1, 1, 1), 0.1)
	local var_2_4 = var_3.setEase

	LeanTweenType = var_6

	var_2_4(var_2_3, var_6.easeInBack)

	pg = var_2_4

	local var_2_5 = var_2_4.TimeMgr.GetInstance()

	arg_2_0._castFinishTime = var_3.GetCombatTime(var_2_5) + arg_2_1
	arg_2_0._castDuration = arg_2_1
	LeanTween = var_3

	local var_2_6 = var_3.rotate

	rtf = var_2_5

	local var_2_7 = var_2_6(var_2_5(arg_2_0._danger), 360, 5)

	var_3.setLoopClamp(var_2_7)

	arg_2_0._weapon = arg_2_2

	return
end

function var_0_2.Interrupt(arg_3_0, arg_3_1)
	arg_3_0._weapon = nil

	if arg_3_1 then
		SetActive = var_2

		var_2(arg_3_0._casting, false)

		SetActive = var_2

		var_2(arg_3_0._interrupt, true)
	end

	LeanTween = var_2

	local var_3_0 = var_2.cancel

	go = var_1_10004

	var_3_0(var_1_10004(arg_3_0._danger))

	for iter_3_0 = 1, 2 do
		LeanTween = var_6

		local var_3_1 = var_6.alphaCanvas(arg_3_0._clockCG, 0.3, 0.3)
		local var_3_2 = var_6.setFrom(var_3_1, 1)

		var_6.setDelay(var_3_2, 0.3 * (iter_3_0 - 1))

		LeanTween = var_6

		local var_3_3 = var_6.alphaCanvas(arg_3_0._clockCG, 1, 0.3)

		var_6.setDelay(var_3_3, 0.3 * iter_3_0)
	end

	LeanTween = var_2

	local var_3_4 = var_2.scale

	rtf = var_4

	local var_3_5 = var_4(arg_3_0._castClockGO)

	Vector3 = iter_3_0

	local var_3_6 = var_3_4(var_3_5, iter_3_0.New(0.1, 0.1, 1), 0.3)
	local var_3_7 = var_2.setEase

	LeanTweenType = var_5

	local var_3_8 = var_3_7(var_3_6, var_5.easeInBack)
	local var_3_9 = var_2.setDelay(var_3_8, 1.25)
	local var_3_10 = var_2.setOnComplete

	System = var_5

	var_3_10(var_3_9, var_5.Action(function()
		SetActive = var_2_10000

		var_2_10000(arg_3_0._castClockTF, false)

		return
	end))

	return
end

function var_0_2.GetCastingWeapon(arg_5_0)
	return arg_5_0._weapon
end

function var_0_2.UpdateCastClockPosition(arg_6_0, arg_6_1)
	arg_6_0._castClockTF.position = arg_6_1 + var_0_2.OFFSET

	return
end

function var_0_2.UpdateCastClock(arg_7_0)
	pg = var_1_10001

	local var_7_0 = var_1_10001.TimeMgr.GetInstance()
	local var_7_1 = var_1.GetCombatTime(var_7_0)

	arg_7_0._castProgress.fillAmount = 1 - (arg_7_0._castFinishTime - var_7_1) / arg_7_0._castDuration

	return
end

function var_0_2.Dispose(arg_8_0)
	arg_8_0._weapon = nil
	Object = var_1

	var_1.Destroy(arg_8_0._castClockGO)

	arg_8_0._castClockTF = nil
	arg_8_0._castClockGO = nil
	arg_8_0._castProgress = nil
	arg_8_0._interrupt = nil
	arg_8_0._casting = nil

	return
end

return
