ys = ys or {}
ys.Battle.BattleTimerView = class("BattleTimerView")
ys.Battle.BattleTimerView.__name = "BattleTimerView"

function ys.Battle.BattleTimerView:Ctor(arg_1_1)
	self._go = arg_1_1
	self._timer = self._go.transform:Find("Text")
	self._blinker = self._timer:GetComponent(typeof(Animator))
	self._isBlink = false
	self._text = self._timer:GetComponent(typeof(Text))
	self.timeStr = ""

	return
end

function ys.Battle.BattleTimerView:SetActive(arg_2_1)
	setActive(self._go, arg_2_1)

	return
end

function ys.Battle.BattleTimerView:SetCountDownText(arg_3_1)
	if arg_3_1 <= 30 and not self._isBlink then
		self._blinker.enabled = true
		self._isBlink = true
	end

	local var_3_0 = self.formatTime(math.floor(arg_3_1))

	if var_3_0 == self.timeStr then
		return
	end

	self.timeStr = var_3_0
	self._text.text = var_3_0

	return
end

function ys.Battle.BattleTimerView.formatTime(arg_4_0)
	return string.format("%02u:%02u", math.floor(arg_4_0 / 60), arg_4_0 % 60)
end

function ys.Battle.BattleTimerView.Dispose(arg_5_0)
	return
end

return
