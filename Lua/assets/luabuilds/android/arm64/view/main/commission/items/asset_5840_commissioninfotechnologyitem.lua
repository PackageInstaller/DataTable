local CommissionInfoTechnologyItem = class("CommissionInfoTechnologyItem", import(".CommissionInfoItem"))

function CommissionInfoTechnologyItem:Ctor(arg_1_1, arg_1_2)
	CommissionInfoTechnologyItem.super.Ctor(self, arg_1_1, arg_1_2)

	self.commingTF = self._tf:Find("comming")
	self.techFrame = self._tf:Find("frame")
	self.lockTF = self._tf:Find("lock")

	setActive(self.lockTF, false)
	setText(self.lockTF:Find("Text"), i18n("commission_label_unlock_tech_tip"))

	return
end

function CommissionInfoTechnologyItem:CanOpen()
	return getProxy(PlayerProxy):getData().level >= 30 and not LOCK_TECHNOLOGY
end

function CommissionInfoTechnologyItem:Init()
	if LOCK_TECHNOLOGY then
		setActive(self._tf:Find("frame"), false)
		setActive(self.lockTF, false)
		setActive(self.commingTF, true)
	else
		setActive(self._tf:Find("frame"), true)
		setActive(self.lockTF, false)
		setActive(self.commingTF, false)

		local var_3_0 = self:CanOpen()

		setActive(self.lockTF, not var_3_0)
		setGray(self.toggle, not var_3_0, true)
		setActive(self.foldFlag, false)
		setActive(self.goBtn, var_3_0)
		CommissionInfoTechnologyItem.super.Init(self)
	end

	return
end

function CommissionInfoTechnologyItem:OnFlush()
	self.list = {}

	local var_4_0 = {
		ongoing = 0,
		finished = 0,
		leisure = TechnologyConst.QUEUE_TOTAL_COUNT + 1
	}

	for iter_4_0, iter_4_1 in ipairs((getProxy(TechnologyProxy):getPlanningTechnologys())) do
		if iter_4_1:isCompleted() then
			var_4_0.leisure = var_4_0.leisure - 1
			var_4_0.finished = var_4_0.finished + 1
		elseif iter_4_1:isActivate() then
			var_4_0.leisure = var_4_0.leisure - 1
			var_4_0.ongoing = var_4_0.ongoing + 1
		end
	end

	eachChild(self._tf:Find("frame/counter"), function(arg_5_0)
		setActive(arg_5_0, var_4_0[arg_5_0.name] > 0)
		setText(arg_5_0:Find("Text"), var_4_0[arg_5_0.name])

		return
	end)
	setActive(self.goBtn, var_4_0.finished == 0)
	setActive(self.finishedBtn, var_4_0.finished > 0)

	return
end

function CommissionInfoTechnologyItem:UpdateListItem(arg_6_1, arg_6_2, arg_6_3)
	local var_6_0 = arg_6_2
	local var_6_1 = pg.TimeMgr.GetInstance():GetServerTime()
	local var_6_2 = arg_6_2:getConfig("time")

	if arg_6_2.time == 0 then
		setText(arg_6_3:Find("unlock/desc/name_bg/Text"), i18n("commission_idle"))
		onButton(self, arg_6_3:Find("unlock/leisure/go_btn"), function()
			self:OnSkip()

			return
		end, SFX_PANEL)
		onButton(self, arg_6_3, function()
			self:OnSkip()

			return
		end, SFX_PANEL)
	elseif var_6_1 < arg_6_2.time - var_6_2 then
		self:UpdateTechnology(arg_6_3, arg_6_2)
		setText(arg_6_3:Find("unlock/ongoging/time"), pg.TimeMgr.GetInstance():DescCDTime(var_6_2))
	elseif var_6_1 < arg_6_2.time then
		self:UpdateTechnology(arg_6_3, arg_6_2)
		self:AddTimer(arg_6_2, arg_6_3)
	else
		self:UpdateTechnology(arg_6_3, arg_6_2)

		if arg_6_2:finishCondition() then
			local var_6_3 = arg_6_3:Find("unlock/finished/finish_btn")

			onButton(self, var_6_3, function()
				self:emit(CommissionInfoMediator.ON_TECH_FINISHED, {
					id = var_6_0.id,
					pool_id = var_6_0.poolId
				})

				return
			end, SFX_PANEL)
			onButton(self, arg_6_3, function()
				triggerButton(var_6_3)

				return
			end, SFX_PANEL)
		else
			setText(arg_6_3:Find("unlock/ongoging/time"), "00:00:00")
		end
	end

	setActive(arg_6_3:Find("unlock"), true)
	setActive(arg_6_3:Find("lock"), false)
	setActive(arg_6_3:Find("unlock/leisure"), not arg_6_2:isActivate())
	setActive(arg_6_3:Find("unlock/ongoging"), arg_6_2:isActivate() and not arg_6_2:isCompleted())
	setActive(arg_6_3:Find("unlock/finished"), arg_6_2:isCompleted())
	setActive(arg_6_3:Find("unlock/desc/task_bg"), arg_6_2:isActivate() and arg_6_2:getConfig("condition") > 0)

	return
end

function CommissionInfoTechnologyItem:AddTimer(arg_11_1, arg_11_2)
	local var_11_0 = arg_11_2:Find("unlock/ongoging/time"):GetComponent(typeof(Text))

	self.timers[arg_11_1.id] = Timer.New(function()
		local var_12_0 = arg_11_1:getFinishTime() - pg.TimeMgr.GetInstance():GetServerTime()

		if var_12_0 > 0 then
			var_11_0.text = pg.TimeMgr.GetInstance():DescCDTime(var_12_0)
		else
			self:RemoveTimer(arg_11_1)
			self:OnFlush()
			self:UpdateList()
		end

		return
	end, 1, -1)

	self.timers[arg_11_1.id]:Start()
	self.timers[arg_11_1.id].func()

	return
end

function CommissionInfoTechnologyItem:RemoveTimer(arg_13_1)
	if self.timers[arg_13_1.id] then
		self.timers[arg_13_1.id]:Stop()

		self.timers[arg_13_1.id] = nil
	end

	return
end

function CommissionInfoTechnologyItem:UpdateTechnology(arg_14_1, arg_14_2)
	setText(arg_14_1:Find("unlock/desc/name_bg/Text"), arg_14_2:getConfig("name"))

	local var_14_0 = arg_14_2:getConfig("condition")

	if var_14_0 > 0 then
		local var_14_1 = getProxy(TaskProxy):getTaskVO(var_14_0)

		setText(arg_14_1:Find("unlock/desc/task_bg/Text"), shortenString(var_14_1:getConfig("desc") .. "(" .. var_14_1:getProgress() .. "/" .. var_14_1:getConfig("target_num") .. ")", 10))
	end

	return
end

function CommissionInfoTechnologyItem:GetList()
	return self.list, (pg.SystemOpenMgr.GetInstance():isOpenSystem(getProxy(PlayerProxy):getRawData().level, "TechnologyMediator") or nil) and (TechnologyConst.QUEUE_TOTAL_COUNT + 1 or 0)
end

function CommissionInfoTechnologyItem:OnSkip()
	self:emit(CommissionInfoMediator.ON_ACTIVE_TECH)

	return
end

function CommissionInfoTechnologyItem:OnFinishAll()
	local var_17_0 = getProxy(TechnologyProxy)

	if var_17_0.queue[1] and var_17_0.queue[1]:isCompleted() then
		self:emit(CommissionInfoMediator.ON_TECH_QUEUE_FINISH)
	else
		local var_17_1 = var_17_0:getActivateTechnology()

		self:emit(CommissionInfoMediator.ON_TECH_FINISHED, {
			id = var_17_1.id,
			pool_id = var_17_1.poolId
		})
	end

	return
end

return CommissionInfoTechnologyItem
