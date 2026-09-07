local FeastTaskPage = class("FeastTaskPage", import("view.base.BaseSubView"))

FeastTaskPage.PAGE_PT = 1
FeastTaskPage.PAGE_TASK = 2

function FeastTaskPage:getUIName()
	return "FeastTaskPage"
end

function FeastTaskPage:OnLoaded()
	self.getAllBtn = self._tf:Find("main/getall")
	self.getAllTip = self.getAllBtn:Find("tip")
	self.levelTxt = self._tf:Find("main/level/Text"):GetComponent(typeof(Text))
	self.progressTxt = self._tf:Find("main/level/value/Text"):GetComponent(typeof(Text))
	self.progress = self._tf:Find("main/level/progress/bar")
	self.lastAwardItem = self._tf:Find("main/level/item")
	self.lastAwardLvTxt = self.lastAwardItem:Find("lock/Text"):GetComponent(typeof(Text))

	setText(self.lastAwardItem:Find("get"), i18n("feast_task_pt_get"))
	setText(self.lastAwardItem:Find("got"), i18n("feast_task_pt_got"))
	setText(self._tf:Find("main/tip"), i18n("feast_click_to_close"))
	setText(self._tf:Find("main/level/value/label"), i18n("feast_task_pt_label"))

	self.taskTip = self._tf:Find("main/toggles/task/tip")
	self.toggles = {
		self._tf:Find("main/toggles/pt"),
		self._tf:Find("main/toggles/task")
	}

	local var_2_0 = {}

	var_2_0[1] = self._tf:Find("main/pt/scrollrect"):GetComponent("LScrollRect")
	var_2_0[2] = self._tf:Find("main/task/scrollrect"):GetComponent("LScrollRect")
	self.scrollRects = var_2_0
	self.cardCls = {
		FeastPtCard,
		FeastTaskCard
	}
	self.cards = {
		{},
		{}
	}
	self.counts = {
		0,
		0
	}

	self:AddListener()

	return
end

function FeastTaskPage:AddListener()
	self:bind(FeastScene.ON_TASK_UPDATE, function(arg_4_0)
		if self:isShowing() then
			self:GenTaskData()
			self:UpdateLevel()

			if self.page == FeastTaskPage.PAGE_TASK then
				self:SwitchPage(self.page)
			end
		end

		return
	end)
	self:bind(FeastScene.ON_ACT_UPDATE, function(arg_5_0)
		if self:isShowing() then
			self:GenPtData()
			self:UpdateLevel()

			if self.page == FeastTaskPage.PAGE_PT then
				self:SwitchPage(self.page)
			end
		end

		return
	end)

	return
end

function FeastTaskPage:OnInit()
	for iter_6_0, iter_6_1 in ipairs(self.scrollRects) do
		function iter_6_1.onInitItem(arg_7_0)
			self:OnInitItem(iter_6_0, arg_7_0)

			return
		end

		function iter_6_1.onUpdateItem(arg_8_0, arg_8_1)
			self:OnUpdateItem(iter_6_0, arg_8_0, arg_8_1)

			return
		end
	end

	for iter_6_2, iter_6_3 in ipairs(self.toggles) do
		onToggle(self, iter_6_3, function(arg_9_0)
			if arg_9_0 then
				self:SwitchPage(iter_6_2)
			end

			return
		end, SFX_PANEL)
	end

	onButton(self, self._tf, function()
		self:Hide()

		return
	end, SFX_PANEL)
	onButton(self, self.getAllBtn, function()
		if self.page == FeastTaskPage.PAGE_TASK then
			self:GetAllForTask()
		elseif self.page == FeastTaskPage.PAGE_PT then
			self:GetAllForPt()
		end

		return
	end, SFX_PANEL)

	return
end

function FeastTaskPage:UpdateGetAllTip(arg_12_1)
	local var_12_0 = getProxy(FeastProxy)
	local var_12_1 = false

	if arg_12_1 == FeastTaskPage.PAGE_PT then
		var_12_1 = var_12_0:ShouldTipPt()
	elseif arg_12_1 == FeastTaskPage.PAGE_TASK then
		var_12_1 = var_12_0:ShouldTipFeastTask()
	end

	setActive(self.getAllTip, var_12_1)
	setActive(self.taskTip, var_12_0:ShouldTipFeastTask())

	return
end

function FeastTaskPage:GetAllForTask()
	local var_13_0 = {}
	local var_13_1 = getProxy(TaskProxy)

	for iter_13_0, iter_13_1 in ipairs(self.taskList) do
		local var_13_2 = var_13_1:getTaskById(iter_13_1)

		if var_13_2 and var_13_2:isFinish() and not var_13_2:isReceive() then
			table.insert(var_13_0, var_13_2)
		end
	end

	if #var_13_0 <= 0 then
		pg.TipsMgr.GetInstance():ShowTips(i18n("faest_nothing_to_get"))

		return
	end

	self:emit(FeastMediator.ON_SUBMIT_ONE_KEY, var_13_0)

	return
end

function FeastTaskPage:GetAllForPt()
	local var_14_0

	if not self.ptActData:CanGetAward() then
		pg.TipsMgr.GetInstance():ShowTips(i18n("faest_nothing_to_get"))

		do return end

		var_14_0 = {
			cmd = 4,
			activity_id = self.ptActData:GetId()
		}
	end

	var_14_0.arg1 = self.ptActData:GetCurrTarget()

	self:emit(FeastMediator.EVENT_PT_OPERATION, var_14_0)

	return
end

function FeastTaskPage:SwitchPage(arg_15_1)
	self.scrollRects[arg_15_1]:SetTotalCount(self.counts[arg_15_1] or 0)

	self.page = arg_15_1

	self:UpdateGetAllTip(arg_15_1)
	self:UpdateLevel()

	return
end

function FeastTaskPage:UpdateLevel()
	local var_16_0 = self.ptActData:GetCurrLevel()

	self.levelTxt.text = var_16_0

	local var_16_1 = 0
	local var_16_2 = 0

	if not self.ptActData:IsMaxLevel() then
		local var_16_3 = self.ptActData:GetPtTarget(var_16_0)

		var_16_2 = self.ptActData:GetNextLevelTarget()
		var_16_1 = self.ptActData.count
		var_16_1 = self.ptActData.count - var_16_3
		var_16_2 = var_16_2 - var_16_3
		var_16_1 = math.min(self.ptActData.count - var_16_3, var_16_2)
		self.progressTxt.text = self.ptActData.count - var_16_3 .. "/" .. var_16_2
	else
		var_16_2 = 1
		var_16_1 = 1
		self.progressTxt.text = "MAX"
	end

	setFillAmount(self.progress, var_16_1 / var_16_2)

	local var_16_4 = self.page == FeastTaskPage.PAGE_PT

	setActive(self.lastAwardItem, self.page == FeastTaskPage.PAGE_PT)

	if var_16_4 then
		self:UpdateLastAward()
	end

	return
end

function FeastTaskPage:UpdateLastAward()
	local var_17_0 = self.lastAwardItem:Find("award")
	local var_17_1 = self.ptActData:GetLastAward()

	updateDrop(var_17_0, var_17_1)

	local var_17_2 = self.ptActData.targets
	local var_17_3 = self.ptActData:GetDroptItemState(#self.ptActData.targets)

	self.lastAwardLvTxt.text = i18n("feast_task_pt_level", #self.ptActData.targets)

	setActive(self.lastAwardItem:Find("lock"), var_17_3 == ActivityPtData.STATE_LOCK)
	setActive(self.lastAwardItem:Find("get"), var_17_3 == ActivityPtData.STATE_CAN_GET)
	setActive(self.lastAwardItem:Find("got"), var_17_3 == ActivityPtData.STATE_GOT)
	onButton(self, var_17_0, function()
		if var_17_3 == ActivityPtData.STATE_CAN_GET then
			self:emit(FeastMediator.EVENT_PT_OPERATION, {
				cmd = 1,
				activity_id = self.ptActData:GetId(),
				arg1 = self.ptActData:GetPtTarget(#var_17_2)
			})
		else
			self:emit(BaseUI.ON_DROP, var_17_1)
		end

		return
	end, SFX_PANEL)

	return
end

function FeastTaskPage:Show()
	FeastTaskPage.super.Show(self)
	pg.UIMgr.GetInstance():BlurPanel(self._tf)
	self:GenPtData()
	self:GenTaskData()
	triggerToggle(self.toggles[FeastTaskPage.PAGE_PT], true)

	return
end

function FeastTaskPage:GenPtData()
	self.ptActData = getProxy(FeastProxy):GetPtActData()
	self.counts[FeastTaskPage.PAGE_PT] = #self.ptActData.targets

	return
end

function FeastTaskPage:GenTaskData()
	self.taskList = getProxy(FeastProxy):GetTaskList()

	local var_21_0 = getProxy(TaskProxy)

	table.sort(self.taskList, function(arg_22_0, arg_22_1)
		local var_22_0 = var_21_0:getTaskById(arg_22_0) or var_21_0:getFinishTaskById(arg_22_0)
		local var_22_1 = var_21_0:getTaskById(arg_22_1) or var_21_0:getFinishTaskById(arg_22_1)
		local var_22_2 = var_22_0:isReceive() and 1 or 0
		local var_22_3 = var_22_1:isReceive() and 1 or 0

		if var_22_2 == var_22_3 then
			local var_22_4 = var_22_0:IsActRoutineType() and 1 or 0
			local var_22_5 = var_22_1:IsActRoutineType() and 1 or 0

			if var_22_4 == var_22_5 then
				return arg_22_0 < arg_22_1
			else
				return var_22_5 < var_22_4
			end
		else
			return var_22_2 < var_22_3
		end

		return
	end)

	self.counts[FeastTaskPage.PAGE_TASK] = #self.taskList

	return
end

function FeastTaskPage:OnInitItem(arg_23_1, arg_23_2)
	self.cards[arg_23_1][arg_23_2] = self.cardCls[arg_23_1].New(arg_23_2, self)

	return
end

function FeastTaskPage:OnUpdateItem(arg_24_1, arg_24_2, arg_24_3)
	local var_24_0 = self.cards[arg_24_1][arg_24_3]

	if not self.cards[arg_24_1][arg_24_3] then
		self:OnInitItem(arg_24_1, arg_24_3)

		var_24_0 = self.cards[arg_24_1][arg_24_3]
	end

	local var_24_1

	if arg_24_1 == FeastTaskPage.PAGE_PT then
		var_24_1 = self.ptActData
	elseif arg_24_1 == FeastTaskPage.PAGE_TASK then
		var_24_1 = self.taskList[arg_24_2 + 1]
	end

	var_24_0:Flush(var_24_1, arg_24_2 + 1)

	return
end

function FeastTaskPage:Hide()
	FeastTaskPage.super.Hide(self)
	pg.UIMgr.GetInstance():UnOverlayPanel(self._tf, self._parentTf)

	return
end

function FeastTaskPage:OnDestroy()
	if self:isShowing() then
		self:Hide()
	end

	return
end

return FeastTaskPage
