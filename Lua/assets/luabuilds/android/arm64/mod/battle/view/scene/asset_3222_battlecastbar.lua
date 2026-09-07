ys = ys or {}
ys.Battle.BattleCastBar = class("BattleCastBar")
ys.Battle.BattleCastBar.__name = "BattleCastBar"

local var_0_0 = ys.Battle.BattleCastBar

ys.Battle.BattleCastBar.OFFSET = Vector3(1.8, 2.3, 0)

function ys.Battle.BattleCastBar:Ctor(arg_1_1)
	self._castClockTF = arg_1_1
	self._castClockGO = self._castClockTF.gameObject
	self._castProgress = self._castClockTF:Find("cast_progress"):GetComponent(typeof(Image))
	self._interrupt = self._castClockTF:Find("interrupt")
	self._casting = self._castClockTF:Find("casting")
	self._danger = self._castClockTF:Find("danger")
	self._clockCG = self._castClockTF:GetComponent(typeof(CanvasGroup))

	return
end

function ys.Battle.BattleCastBar:Casting(arg_2_1, arg_2_2)
	LeanTween.cancel(self._castClockGO)

	self._castClockTF.localScale = Vector3(0.1, 0.1, 1)

	SetActive(self._castClockTF, true)
	SetActive(self._casting, true)
	SetActive(self._interrupt, false)
	LeanTween.scale(rtf(self._castClockGO), Vector3.New(1, 1, 1), 0.1):setEase(LeanTweenType.easeInBack)

	self._castFinishTime = pg.TimeMgr.GetInstance():GetCombatTime() + arg_2_1
	self._castDuration = arg_2_1

	LeanTween.rotate(rtf(self._danger), 360, 5):setLoopClamp()

	self._weapon = arg_2_2

	return
end

function ys.Battle.BattleCastBar:Interrupt(arg_3_1)
	self._weapon = nil

	if arg_3_1 then
		SetActive(self._casting, false)
		SetActive(self._interrupt, true)
	end

	LeanTween.cancel(go(self._danger))

	for iter_3_0 = 1, 2 do
		LeanTween.alphaCanvas(self._clockCG, 0.3, 0.3):setFrom(1):setDelay(0.3 * (iter_3_0 - 1))
		LeanTween.alphaCanvas(self._clockCG, 1, 0.3):setDelay(0.3 * iter_3_0)
	end

	LeanTween.scale(rtf(self._castClockGO), Vector3.New(0.1, 0.1, 1), 0.3):setEase(LeanTweenType.easeInBack):setDelay(1.25):setOnComplete(System.Action(function()
		SetActive(self._castClockTF, false)

		return
	end))

	return
end

function ys.Battle.BattleCastBar:GetCastingWeapon()
	return self._weapon
end

function ys.Battle.BattleCastBar:UpdateCastClockPosition(arg_6_1)
	self._castClockTF.position = arg_6_1 + var_0_0.OFFSET

	return
end

function ys.Battle.BattleCastBar:UpdateCastClock()
	self._castProgress.fillAmount = 1 - (self._castFinishTime - pg.TimeMgr.GetInstance():GetCombatTime()) / self._castDuration

	return
end

function ys.Battle.BattleCastBar:Dispose()
	self._weapon = nil

	Object.Destroy(self._castClockGO)

	self._castClockTF = nil
	self._castClockGO = nil
	self._castProgress = nil
	self._interrupt = nil
	self._casting = nil

	return
end

return
