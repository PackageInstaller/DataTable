local EducateDatePanel = class("EducateDatePanel", import("...base.BaseSubView"))

function EducateDatePanel:getUIName()
	return "EducateDatePanel"
end

function EducateDatePanel:OnInit()
	self.timeTF = self._tf:Find("content/top/time")
	self.weekTF = self.timeTF:Find("week")
	self.dayTF = self.timeTF:Find("day")
	self.homeTF = self._tf:Find("content/top/home")

	setText(self.homeTF:Find("Text"), i18n("child_date_text1"))

	self.schoolTF = self._tf:Find("content/top/school")

	setText(self.schoolTF:Find("Text"), i18n("child_date_text2"))

	self.upgradeTF = self._tf:Find("content/top/upgrade")

	setText(self.upgradeTF:Find("Text"), i18n("child_date_text3"))

	self.dataTF = self._tf:Find("content/top/data")

	setText(self.dataTF:Find("Text"), i18n("child_date_text4"))

	self.newsBtn = self._tf:Find("content/bottom")

	onButton(self, self.newsBtn, function()
		self:emit(EducateBaseUI.EDUCATE_GO_SUBLAYER, Context.New({
			mediator = EducateNewsMediator,
			viewComponent = EducateNewsLayer
		}))

		return
	end, SFX_PANEL)
	onButton(self, self._tf:Find("content/back"), function()
		if self.contextData and self.contextData.isMain then
			self:emit(EducateBaseUI.EDUCATE_GO_SCENE, SCENE.NEW_EDUCATE_SELECT, {
				isTb1 = true
			})
		else
			self:emit(EducateBaseUI.ON_BACK)
		end

		return
	end, SFX_PANEL)

	self.targetSetDays = getProxy(EducateProxy):GetTaskProxy():GetTargetSetDays()

	self:Flush()

	return
end

function EducateDatePanel:Flush()
	if not self:GetLoaded() then
		return
	end

	self.curTime = getProxy(EducateProxy):GetCurTime()
	self.status = getProxy(EducateProxy):GetGameStatus()

	setActive(self.homeTF, self:isHomeShow())
	setActive(self.schoolTF, self:isSchoolShow())
	setActive(self.upgradeTF, self:isUpgradeShow())
	setActive(self.dataTF, self.status == EducateConst.STATUES_RESET)

	local var_5_0 = self:isTimeShow()

	setActive(self.timeTF, var_5_0)

	if var_5_0 then
		setText(self.weekTF, EducateHelper.GetShowMonthNumber(self.curTime.month) .. i18n("word_month") .. i18n("word_which_week", self.curTime.week))
		setText(self.dayTF, EducateHelper.GetWeekStrByNumber(self.curTime.day))
	end

	return
end

function EducateDatePanel:UpdateWeekDay(arg_6_1)
	if not self:GetLoaded() then
		return
	end

	local var_6_0 = EducateHelper.GetTimeAfterWeeks(getProxy(EducateProxy):GetCurTime(), 1)

	setText(self.weekTF, EducateHelper.GetShowMonthNumber(var_6_0.month) .. i18n("word_month") .. i18n("word_which_week", var_6_0.week))
	setText(self.dayTF, EducateHelper.GetWeekStrByNumber(arg_6_1))

	return
end

function EducateDatePanel:isHomeShow()
	return EducateHelper.IsSameDay(self.curTime, self.targetSetDays[1])
end

function EducateDatePanel:isSchoolShow()
	return EducateHelper.IsSameDay(self.curTime, self.targetSetDays[2])
end

function EducateDatePanel:isUpgradeShow()
	return EducateHelper.IsSameDay(self.curTime, self.targetSetDays[3]) or EducateHelper.IsSameDay(self.curTime, self.targetSetDays[4])
end

function EducateDatePanel:isTimeShow()
	return not isActive(self.homeTF) and not isActive(self.schoolTF) and not isActive(self.upgradeTF) and not isActive(self.dataTF)
end

return EducateDatePanel
