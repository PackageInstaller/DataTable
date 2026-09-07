ys = ys or {}
ys.Battle.BattleBarrierBar = class("BattleBarrierBar")
ys.Battle.BattleBarrierBar.__name = "BattleBarrierBar"

local var_0_0 = ys.Battle.BattleBarrierBar

ys.Battle.BattleBarrierBar.OFFSET = Vector3(1.8, 2.3, 0)

function ys.Battle.BattleBarrierBar:Ctor(arg_1_1)
	self._barrierClockTF = arg_1_1
	self._barrierClockGO = self._barrierClockTF.gameObject
	self._castProgress = self._barrierClockTF:Find("shield_progress"):GetComponent(typeof(Image))
	self._danger = self._barrierClockTF:Find("danger")
	self._clockCG = self._barrierClockTF:GetComponent(typeof(CanvasGroup))

	return
end

function ys.Battle.BattleBarrierBar:Shielding(arg_2_1)
	self._barrierClockTF.localScale = Vector3(0.1, 0.1, 1)

	SetActive(self._barrierClockTF, true)
	LeanTween.scale(rtf(self._barrierClockGO), Vector3.New(1, 1, 1), 0.1):setEase(LeanTweenType.easeInBack)

	self._barrierFinishTime = pg.TimeMgr.GetInstance():GetCombatTime() + arg_2_1
	self._barrierDuration = arg_2_1

	LeanTween.rotate(rtf(self._danger), 360, 5):setLoopClamp()

	return
end

function ys.Battle.BattleBarrierBar:Interrupt()
	LeanTween.cancel(go(self._danger))
	LeanTween.scale(rtf(self._barrierClockGO), Vector3.New(0.1, 0.1, 1), 0.3):setEase(LeanTweenType.easeInBack):setOnComplete(System.Action(function()
		SetActive(self._barrierClockTF, false)

		return
	end))

	return
end

function ys.Battle.BattleBarrierBar:UpdateBarrierClockPosition(arg_5_1)
	self._barrierClockTF.position = arg_5_1 + var_0_0.OFFSET

	return
end

function ys.Battle.BattleBarrierBar:UpdateBarrierClockProgress()
	self._castProgress.fillAmount = (self._barrierFinishTime - pg.TimeMgr.GetInstance():GetCombatTime()) / self._barrierDuration

	return
end

function ys.Battle.BattleBarrierBar:Dispose()
	Object.Destroy(self._barrierClockGO)

	self._barrierClockTF = nil
	self._barrierClockGO = nil
	self._castProgress = nil

	return
end

return
