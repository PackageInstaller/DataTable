ys = ys or {}
ys.Battle.BattleBuffClock = class("BattleBuffClock")
ys.Battle.BattleBuffClock.__name = "BattleBuffClock"

local var_0_0 = ys.Battle.BattleBuffClock

ys.Battle.BattleBuffClock.OFFSET = Vector3(1.8, 2.3, 0)
ys.Battle.BattleBuffClock.TYPE_INDEX = 3

function ys.Battle.BattleBuffClock.Ctor(arg_1_0, arg_1_1)
	arg_1_0._castClockTF = arg_1_1
	arg_1_0._castClockGO = arg_1_0._castClockTF.gameObject
	arg_1_0._bgList = arg_1_0._castClockTF:Find("bg")
	arg_1_0._danger = arg_1_0._castClockTF:Find("danger")
	arg_1_0._interrupt = arg_1_0._castClockTF:Find("interrupt")
	arg_1_0._casting = arg_1_0._castClockTF:Find("casting")
	arg_1_0._progressProtected = arg_1_0._castClockTF:Find("progress/protected")
	arg_1_0._progressInterrupt = arg_1_0._castClockTF:Find("progress/interrupt")
	arg_1_0._clockCG = arg_1_0._castClockTF:GetComponent(typeof(CanvasGroup))

	return
end

function ys.Battle.BattleBuffClock.switchToIndex(arg_2_0, arg_2_1, arg_2_2)
	for iter_2_0 = 1, var_0_0.TYPE_INDEX do
		SetActive(arg_2_1:Find(tostring(iter_2_0)), arg_2_2 == iter_2_0)
	end

	return
end

function ys.Battle.BattleBuffClock.IsActive(arg_3_0)
	return arg_3_0._buffEffect ~= nil
end

function ys.Battle.BattleBuffClock.Casting(arg_4_0, arg_4_1)
	LeanTween.cancel(arg_4_0._castClockGO)

	arg_4_0._castClockTF.localScale = Vector3(0.1, 0.1, 1)

	arg_4_0:switchToIndex(arg_4_0._bgList, arg_4_1.iconType)
	arg_4_0:switchToIndex(arg_4_0._danger, arg_4_1.iconType)
	arg_4_0:switchToIndex(arg_4_0._interrupt, arg_4_1.iconType)
	arg_4_0:switchToIndex(arg_4_0._casting, arg_4_1.iconType)
	SetActive(arg_4_0._progressInterrupt, arg_4_1.interrupt)
	SetActive(arg_4_0._progressProtected, not arg_4_1.interrupt)

	if arg_4_1.interrupt then
		arg_4_0._castProgress = arg_4_0._progressInterrupt:GetComponent(typeof(Image)) or arg_4_0._progressProtected:GetComponent(typeof(Image))

		SetActive(arg_4_0._castClockTF, true)
		SetActive(arg_4_0._casting, true)
		SetActive(arg_4_0._interrupt, false)
		LeanTween.scale(rtf(arg_4_0._castClockGO), Vector3.New(1, 1, 1), 0.1):setEase(LeanTweenType.easeInBack)
		LeanTween.rotate(rtf(arg_4_0._danger), 360, 5):setLoopClamp()

		arg_4_0._buffEffect = arg_4_1.buffEffect

		return
	end
end

function ys.Battle.BattleBuffClock.Interrupt(arg_5_0, arg_5_1)
	if arg_5_1.interrupt then
		SetActive(arg_5_0._casting, false)
		SetActive(arg_5_0._interrupt, true)
	end

	LeanTween.cancel(go(arg_5_0._danger))

	for iter_5_0 = 1, 2 do
		LeanTween.alphaCanvas(arg_5_0._clockCG, 0.3, 0.3):setFrom(1):setDelay(0.3 * (iter_5_0 - 1))
		LeanTween.alphaCanvas(arg_5_0._clockCG, 1, 0.3):setDelay(0.3 * iter_5_0)
	end

	LeanTween.scale(rtf(arg_5_0._castClockGO), Vector3.New(0.1, 0.1, 1), 0.3):setEase(LeanTweenType.easeInBack):setDelay(1.25):setOnComplete(System.Action(function()
		arg_5_0._buffEffect = nil

		SetActive(arg_5_0._castClockTF, false)

		return
	end))

	return
end

function ys.Battle.BattleBuffClock.UpdateCastClockPosition(arg_7_0, arg_7_1)
	arg_7_0._castClockTF.position = arg_7_1 + var_0_0.OFFSET

	return
end

function ys.Battle.BattleBuffClock.UpdateCastClock(arg_8_0)
	arg_8_0._castProgress.fillAmount = arg_8_0._buffEffect:GetCountProgress()

	return
end

function ys.Battle.BattleBuffClock.Dispose(arg_9_0)
	arg_9_0._buffEffect = nil

	Object.Destroy(arg_9_0._castClockGO)

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
