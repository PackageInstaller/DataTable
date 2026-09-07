ys = ys or {}
ys.Battle.BattleBuffClock = class("BattleBuffClock")
ys.Battle.BattleBuffClock.__name = "BattleBuffClock"

local var_0_0 = ys.Battle.BattleBuffClock

ys.Battle.BattleBuffClock.OFFSET = Vector3(1.8, 2.3, 0)
ys.Battle.BattleBuffClock.TYPE_INDEX = 3

function ys.Battle.BattleBuffClock:Ctor(arg_1_1)
	self._castClockTF = arg_1_1
	self._castClockGO = self._castClockTF.gameObject
	self._bgList = self._castClockTF:Find("bg")
	self._danger = self._castClockTF:Find("danger")
	self._interrupt = self._castClockTF:Find("interrupt")
	self._casting = self._castClockTF:Find("casting")
	self._progressProtected = self._castClockTF:Find("progress/protected")
	self._progressInterrupt = self._castClockTF:Find("progress/interrupt")
	self._clockCG = self._castClockTF:GetComponent(typeof(CanvasGroup))

	return
end

function ys.Battle.BattleBuffClock.switchToIndex(arg_2_0, arg_2_1, arg_2_2)
	for iter_2_0 = 1, var_0_0.TYPE_INDEX do
		SetActive(arg_2_1:Find(tostring(iter_2_0)), arg_2_2 == iter_2_0)
	end

	return
end

function ys.Battle.BattleBuffClock:IsActive()
	return self._buffEffect ~= nil
end

function ys.Battle.BattleBuffClock:Casting(arg_4_1)
	LeanTween.cancel(self._castClockGO)

	self._castClockTF.localScale = Vector3(0.1, 0.1, 1)

	self:switchToIndex(self._bgList, arg_4_1.iconType)
	self:switchToIndex(self._danger, arg_4_1.iconType)
	self:switchToIndex(self._interrupt, arg_4_1.iconType)
	self:switchToIndex(self._casting, arg_4_1.iconType)
	SetActive(self._progressInterrupt, arg_4_1.interrupt)
	SetActive(self._progressProtected, not arg_4_1.interrupt)

	if arg_4_1.interrupt then
		self._castProgress = self._progressInterrupt:GetComponent(typeof(Image)) or self._progressProtected:GetComponent(typeof(Image))
	end

	SetActive(self._castClockTF, true)
	SetActive(self._casting, true)
	SetActive(self._interrupt, false)
	LeanTween.scale(rtf(self._castClockGO), Vector3.New(1, 1, 1), 0.1):setEase(LeanTweenType.easeInBack)
	LeanTween.rotate(rtf(self._danger), 360, 5):setLoopClamp()

	self._buffEffect = arg_4_1.buffEffect

	return
end

function ys.Battle.BattleBuffClock:Interrupt(arg_5_1)
	if arg_5_1.interrupt then
		SetActive(self._casting, false)
		SetActive(self._interrupt, true)
	end

	LeanTween.cancel(go(self._danger))

	for iter_5_0 = 1, 2 do
		LeanTween.alphaCanvas(self._clockCG, 0.3, 0.3):setFrom(1):setDelay(0.3 * (iter_5_0 - 1))
		LeanTween.alphaCanvas(self._clockCG, 1, 0.3):setDelay(0.3 * iter_5_0)
	end

	LeanTween.scale(rtf(self._castClockGO), Vector3.New(0.1, 0.1, 1), 0.3):setEase(LeanTweenType.easeInBack):setDelay(1.25):setOnComplete(System.Action(function()
		self._buffEffect = nil

		SetActive(self._castClockTF, false)

		return
	end))

	return
end

function ys.Battle.BattleBuffClock:UpdateCastClockPosition(arg_7_1)
	self._castClockTF.position = arg_7_1 + var_0_0.OFFSET

	return
end

function ys.Battle.BattleBuffClock:UpdateCastClock()
	self._castProgress.fillAmount = self._buffEffect:GetCountProgress()

	return
end

function ys.Battle.BattleBuffClock:Dispose()
	self._buffEffect = nil

	Object.Destroy(self._castClockGO)

	self._castClockTF = nil
	self._castClockGO = nil
	self._castProgress = nil
	self._interrupt = nil
	self._casting = nil
	self._bgList = nil
	self._danger = nil
	self._progressInterrupt = nil
	self._progressProtected = nil

	return
end

return
