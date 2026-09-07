local EducateCalendarLayer = class("EducateCalendarLayer", import(".base.EducateBaseUI"))

function EducateCalendarLayer:getUIName()
	return "EducateCalendarUI"
end

function EducateCalendarLayer:init()
	self.calendarTF = self._tf:Find("anim_root/calendar")
	self.monthTF = self.calendarTF:Find("month")

	setText(self.monthTF:Find("Text"), i18n("word_month"))

	self.weekTF = self.calendarTF:Find("week/week")
	self.curTime = getProxy(EducateProxy):GetCurTime()
	self.anim = self._tf:Find("anim_root"):GetComponent(typeof(Animation))
	self.animEvent = self._tf:Find("anim_root"):GetComponent(typeof(DftAniEvent))

	self.animEvent:SetEndEvent(function()
		self:emit(EducateCalendarLayer.ON_CLOSE)

		return
	end)
	self.animEvent:SetTriggerEvent(function()
		local var_4_0 = EducateHelper.GetTimeAfterWeeks(self.curTime, 1)

		setText(self.monthTF, (EducateHelper.GetShowMonthNumber(var_4_0.month)))
		setText(self.weekTF, (i18n("word_which_week", var_4_0.week)))

		return
	end)

	return
end

function EducateCalendarLayer:didEnter()
	self:OverlayPanel(self._tf, {
		groupDelta = 1
	})
	setText(self.monthTF, (EducateHelper.GetShowMonthNumber(self.curTime.month)))
	setText(self.weekTF, (i18n("word_which_week", self.curTime.week)))

	return
end

function EducateCalendarLayer:onBackPressed()
	return
end

function EducateCalendarLayer:willExit()
	self:UnOverlayPanel(self._tf)

	if self.contextData.onExit then
		self.contextData.onExit()
	end

	return
end

return EducateCalendarLayer
