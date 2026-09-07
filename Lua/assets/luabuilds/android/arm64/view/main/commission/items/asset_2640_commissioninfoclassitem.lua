local CommissionInfoClassItem = class("CommissionInfoClassItem", import(".CommissionInfoItem"))

function CommissionInfoClassItem:OnFlush()
	local var_1_0 = getProxy(NavalAcademyProxy):getStudents()
	local var_1_1 = getProxy(NavalAcademyProxy):getSkillClassNum()
	local var_1_2 = table.getCount(var_1_0)
	local var_1_3 = 0

	_.each(_.values(var_1_0), function(arg_2_0)
		if arg_2_0:getFinishTime() <= pg.TimeMgr.GetInstance():GetServerTime() then
			var_1_3 = var_1_3 + 1
		end

		return
	end)

	self.finishedCounter.text = var_1_3
	self.ongoingCounter.text = var_1_2 - var_1_3
	self.leisureCounter.text = var_1_1 - var_1_2

	setActive(self.finishedCounterContainer, var_1_3 > 0)
	setActive(self.ongoingCounterContainer, var_1_3 < var_1_2)
	setActive(self.leisureCounterContainer, var_1_2 < var_1_1)
	setActive(self.goBtn, var_1_3 == 0)
	setActive(self.finishedBtn, var_1_3 > 0)

	self.list = var_1_0

	return
end

function CommissionInfoClassItem:UpdateListItem(arg_3_1, arg_3_2, arg_3_3)
	local var_3_0 = arg_3_3:Find("unlock/name_bg")

	if arg_3_2 then
		self:UpdateStudent(arg_3_2, arg_3_3)

		var_3_0.sizeDelta = Vector2(267, 45)
	else
		self:UpdateEmpty(arg_3_3)

		var_3_0.sizeDelta = Vector2(400, 45)
	end

	local var_3_1

	if arg_3_2 then
		::label_3_0::

		var_3_1 = arg_3_2:getFinishTime() <= pg.TimeMgr.GetInstance():GetServerTime()
	end

	setActive(arg_3_3:Find("unlock"), true)
	setActive(arg_3_3:Find("lock"), false)
	setActive(arg_3_3:Find("unlock/leisure"), not arg_3_2)
	setActive(arg_3_3:Find("unlock/ongoging"), arg_3_2 and not var_3_1)
	setActive(arg_3_3:Find("unlock/finished"), arg_3_2 and var_3_1)

	return
end

function CommissionInfoClassItem:UpdateStudent(arg_4_1, arg_4_2)
	local var_4_0 = arg_4_1:getShipVO()
	local var_4_1

	setText(arg_4_2:Find("unlock/name_bg/Text"), shortenString(arg_4_1:getSkillName(), 7))

	if pg.TimeMgr.GetInstance():GetServerTime() < arg_4_1:getFinishTime() then
		self:AddTimer(arg_4_1, arg_4_2)

		var_4_1 = arg_4_2:Find("unlock/ongoging/shipicon")
	else
		onButton(self, arg_4_2:Find("unlock/finished/finish_btn"), function()
			self:emit(CommissionInfoMediator.FINISH_CLASS, arg_4_1.id, Student.CANCEL_TYPE_AUTO)

			return
		end, SFX_PANEL)
		onButton(self, arg_4_2, function()
			triggerButton(arg_4_2:Find("unlock/finished/finish_btn"))

			return
		end, SFX_PANEL)

		var_4_1 = arg_4_2:Find("unlock/finished/shipicon")
	end

	updateShip(var_4_1, var_4_0)

	return
end

function CommissionInfoClassItem:AddTimer(arg_7_1, arg_7_2)
	self:RemoveTimer(arg_7_1)

	local var_7_0 = arg_7_2:Find("unlock/ongoging/time"):GetComponent(typeof(Text))
	local var_7_1 = arg_7_1:getFinishTime()

	self.timers[arg_7_1.id] = Timer.New(function()
		local var_8_0 = var_7_1 - pg.TimeMgr.GetInstance():GetServerTime()

		if var_8_0 <= 0 then
			self:RemoveTimer(arg_7_1)
			self:Update()
		else
			var_7_0.text = pg.TimeMgr.GetInstance():DescCDTime(var_8_0)
		end

		return
	end, 1, -1)

	self.timers[arg_7_1.id]:Start()
	self.timers[arg_7_1.id]:func()

	return
end

function CommissionInfoClassItem:RemoveTimer(arg_9_1)
	if self.timers[arg_9_1.id] then
		self.timers[arg_9_1.id]:Stop()

		self.timers[arg_9_1.id] = nil
	end

	return
end

function CommissionInfoClassItem:UpdateEmpty(arg_10_1)
	setText(arg_10_1:Find("unlock/name_bg/Text"), i18n("commission_idle"))
	onButton(self, arg_10_1:Find("unlock/leisure/go_btn"), function()
		self:emit(CommissionInfoMediator.ON_ACTIVE_CLASS)

		return
	end, SFX_PANEL)
	onButton(self, arg_10_1, function()
		self:OnSkip()

		return
	end, SFX_PANEL)

	return
end

function CommissionInfoClassItem:GetList()
	return self.list, (getProxy(NavalAcademyProxy):getSkillClassNum())
end

function CommissionInfoClassItem:OnSkip()
	self:emit(CommissionInfoMediator.ON_ACTIVE_CLASS)

	return
end

function CommissionInfoClassItem:OnFinishAll()
	self:emit(CommissionInfoMediator.FINISH_CLASS_ALL)

	return
end

return CommissionInfoClassItem
