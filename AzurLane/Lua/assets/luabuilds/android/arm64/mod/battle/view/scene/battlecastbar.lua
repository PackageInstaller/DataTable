ys = ys or {}
ys.Battle.BattleCastBar = class("BattleCastBar")
ys.Battle.BattleCastBar.__name = "BattleCastBar"

local var_0_0 = ys.Battle.BattleCastBar

ys.Battle.BattleCastBar.OFFSET = Vector3(1.8, 2.3, 0)

function ys.Battle.BattleCastBar.Ctor(arg_1_0, arg_1_1)
	arg_1_0._castClockTF = arg_1_1
	arg_1_0._castClockGO = arg_1_0._castClockTF.gameObject
	arg_1_0._castProgress = arg_1_0._castClockTF:Find("cast_progress"):GetComponent(typeof(Image))
	arg_1_0._interrupt = arg_1_0._castClockTF:Find("interrupt")
	arg_1_0._casting = arg_1_0._castClockTF:Find("casting")
	arg_1_0._danger = arg_1_0._castClockTF:Find("danger")
	arg_1_0._clockCG = arg_1_0._castClockTF:GetComponent(typeof(CanvasGroup))

	return
end

function ys.Battle.BattleCastBar.Casting(arg_2_0, arg_2_1, arg_2_2)
	LeanTween.cancel(arg_2_0._castClockGO)

	arg_2_0._castClockTF.localScale = Vector3(0.1, 0.1, 1)

	SetActive(arg_2_0._castClockTF, true)
	SetActive(arg_2_0._casting, true)
	SetActive(arg_2_0._interrupt, false)
	LeanTween.scale(rtf(arg_2_0._castClockGO), Vector3.New(1, 1, 1), 0.1):setEase(LeanTweenType.easeInBack)

	arg_2_0._castFinishTime = pg.TimeMgr.GetInstance():GetCombatTime() + arg_2_1
	arg_2_0._castDuration = arg_2_1

	LeanTween.rotate(rtf(arg_2_0._danger), 360, 5):setLoopClamp()

	arg_2_0._weapon = arg_2_2

	return
end

function ys.Battle.BattleCastBar.Interrupt(arg_3_0, arg_3_1)
	arg_3_0._weapon = nil

	if arg_3_1 then
		SetActive(arg_3_0._casting, false)
		SetActive(arg_3_0._interrupt, true)
	end

	LeanTween.cancel(go(arg_3_0._danger))

	for iter_3_0 = 1, 2 do
		LeanTween.alphaCanvas(arg_3_0._clockCG, 0.3, 0.3):setFrom(1):setDelay(0.3 * (iter_3_0 - 1))
		LeanTween.alphaCanvas(arg_3_0._clockCG, 1, 0.3):setDelay(0.3 * iter_3_0)
	end

	LeanTween.scale(rtf(arg_3_0._castClockGO), Vector3.New(0.1, 0.1, 1), 0.3):setEase(LeanTweenType.easeInBack):setDelay(1.25):setOnComplete(System.Action(function()
		SetActive(arg_3_0._castClockTF, false)

		return
	end))

	return
end

function ys.Battle.BattleCastBar.GetCastingWeapon(arg_5_0)
	return arg_5_0._weapon
end

function ys.Battle.BattleCastBar.UpdateCastClockPosition(arg_6_0, arg_6_1)
	arg_6_0._castClockTF.position = arg_6_1 + var_0_0.OFFSET

	return
end

function ys.Battle.BattleCastBar.UpdateCastClock(arg_7_0)
	arg_7_0._castProgress.fillAmount = 1 - (arg_7_0._castFinishTime - pg.TimeMgr.GetInstance():GetCombatTime()) / arg_7_0._castDuration

	return
end

function ys.Battle.BattleCastBar.Dispose(arg_8_0)
	arg_8_0._weapon = nil

	Object.Destroy(arg_8_0._castClockGO)

	arg_8_0._castClockTF = nil
	arg_8_0._castClockGO = nil
	arg_8_0._castProgress = nil
	arg_8_0._interrupt = nil
	arg_8_0._casting = nil

	return
end

return
