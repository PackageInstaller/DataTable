ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle

class = var_0_10002
var_0_1.BattleBarrierBar = var_0_10002("BattleBarrierBar")
var_0.Battle.BattleBarrierBar.__name = "BattleBarrierBar"

local var_0_2 = var_0.Battle.BattleBarrierBar

Vector3 = var_2
var_0_2.OFFSET = var_2(1.8, 2.3, 0)

function var_0_2.Ctor(arg_1_0, arg_1_1)
	arg_1_0._barrierClockTF = arg_1_1
	arg_1_0._barrierClockGO = arg_1_0._barrierClockTF.gameObject

	local var_1_0 = arg_1_0._barrierClockTF
	local var_1_1 = var_2.Find(var_1_0, "shield_progress")
	local var_1_2 = var_2.GetComponent

	typeof = var_4
	Image = var_1_10005
	arg_1_0._castProgress = var_1_2(var_1_1, var_4(var_1_10005))

	local var_1_3 = arg_1_0._barrierClockTF

	arg_1_0._danger = var_2.Find(var_1_3, "danger")

	local var_1_4 = arg_1_0._barrierClockTF
	local var_1_5 = var_2.GetComponent

	typeof = var_4
	CanvasGroup = var_1_10005
	arg_1_0._clockCG = var_1_5(var_1_4, var_4(var_1_10005))

	return
end

function var_0_2.Shielding(arg_2_0, arg_2_1)
	local var_2_0 = arg_2_0._barrierClockTF

	Vector3 = var_1_10003
	var_2_0.localScale = var_1_10003(0.1, 0.1, 1)
	SetActive = var_2_0

	var_2_0(arg_2_0._barrierClockTF, true)

	LeanTween = var_2_0

	local var_2_1 = var_2_0.scale

	rtf = var_3

	local var_2_2 = var_3(arg_2_0._barrierClockGO)

	Vector3 = var_4

	local var_2_3 = var_2_1(var_2_2, var_4.New(1, 1, 1), 0.1)
	local var_2_4 = var_2.setEase

	LeanTweenType = var_4

	var_2_4(var_2_3, var_4.easeInBack)

	pg = var_2_4

	local var_2_5 = var_2_4.TimeMgr.GetInstance()

	arg_2_0._barrierFinishTime = var_2.GetCombatTime(var_2_5) + arg_2_1
	arg_2_0._barrierDuration = arg_2_1
	LeanTween = var_2

	local var_2_6 = var_2.rotate

	rtf = var_2_5

	local var_2_7 = var_2_6(var_2_5(arg_2_0._danger), 360, 5)

	var_2.setLoopClamp(var_2_7)

	return
end

function var_0_2.Interrupt(arg_3_0)
	LeanTween = var_1_10001

	local var_3_0 = var_1_10001.cancel

	go = var_1_10002

	var_3_0(var_1_10002(arg_3_0._danger))

	LeanTween = var_3_0

	local var_3_1 = var_3_0.scale

	rtf = var_2

	local var_3_2 = var_2(arg_3_0._barrierClockGO)

	Vector3 = var_3

	local var_3_3 = var_3_1(var_3_2, var_3.New(0.1, 0.1, 1), 0.3)
	local var_3_4 = var_1.setEase

	LeanTweenType = var_3

	local var_3_5 = var_3_4(var_3_3, var_3.easeInBack)
	local var_3_6 = var_1.setOnComplete

	System = var_3

	var_3_6(var_3_5, var_3.Action(function()
		SetActive = var_2_10000

		var_2_10000(arg_3_0._barrierClockTF, false)

		return
	end))

	return
end

function var_0_2.UpdateBarrierClockPosition(arg_5_0, arg_5_1)
	arg_5_0._barrierClockTF.position = arg_5_1 + var_0_2.OFFSET

	return
end

function var_0_2.UpdateBarrierClockProgress(arg_6_0)
	pg = var_1_10001

	local var_6_0 = var_1_10001.TimeMgr.GetInstance()
	local var_6_1 = var_1.GetCombatTime(var_6_0)

	arg_6_0._castProgress.fillAmount = (arg_6_0._barrierFinishTime - var_6_1) / arg_6_0._barrierDuration

	return
end

function var_0_2.Dispose(arg_7_0)
	Object = var_1_10001

	var_1_10001.Destroy(arg_7_0._barrierClockGO)

	arg_7_0._barrierClockTF = nil
	arg_7_0._barrierClockGO = nil
	arg_7_0._castProgress = nil

	return
end

return
