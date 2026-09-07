ys = ys or {}

local BattleCustomWarningLabel = class("BattleCustomWarningLabel")

ys.Battle.BattleCustomWarningLabel = BattleCustomWarningLabel
BattleCustomWarningLabel.__name = "BattleCustomWarningLabel"

function BattleCustomWarningLabel:Ctor(arg_1_1)
	self._go = arg_1_1
	self._tf = arg_1_1.transform
	self._expire = false

	return
end

function BattleCustomWarningLabel:ConfigData(arg_2_1)
	setText(self._tf:Find("text"), i18n(arg_2_1.dialogue))

	self._duration = arg_2_1.duration
	self._tf.anchorMin = Vector2((arg_2_1.x + 1) * 0.5, (arg_2_1.y + 1) * 0.5)
	self._tf.anchorMax = Vector2((arg_2_1.x + 1) * 0.5, (arg_2_1.y + 1) * 0.5)
	self._startTimeStamp = pg.TimeMgr.GetInstance():GetCombatTime()

	return
end

function BattleCustomWarningLabel:GetDuration()
	return self._duration
end

function BattleCustomWarningLabel:SetExpire()
	self._expire = true

	return
end

function BattleCustomWarningLabel:IsExpire()
	return self._expire
end

function BattleCustomWarningLabel:Update()
	if self._duration > 0 then
		if pg.TimeMgr.GetInstance():GetCombatTime() - self._startTimeStamp > self._duration then
			self:SetExpire()
		end
	end

	return
end

function BattleCustomWarningLabel:Dispose()
	Destroy(self._go)

	self._go = nil
	self._tf = nil

	return
end

return
