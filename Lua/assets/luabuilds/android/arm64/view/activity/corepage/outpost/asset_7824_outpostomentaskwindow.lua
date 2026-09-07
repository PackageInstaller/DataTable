local OutPostOmenTaskWindow = class("OutPostOmenTaskWindow", import("view.base.BaseSubView"))

OutPostOmenTaskWindow.SKIP_TYPE_SCENE = 2
OutPostOmenTaskWindow.SKIP_TYPE_ACTIVITY = 3

function OutPostOmenTaskWindow:Ctor(arg_1_1, arg_1_2, arg_1_3)
	OutPostOmenTaskWindow.super.Ctor(self, arg_1_1, arg_1_2, arg_1_3)

	return
end

function OutPostOmenTaskWindow:getUIName()
	return "OutPostOmenTaskWindow"
end

function OutPostOmenTaskWindow:OnLoaded()
	self.bg = self._tf:Find("bg")
	self.btnClose = self._tf:Find("window/btnClose")

	onButton(self, self.btnClose, function()
		self:Hide()

		return
	end, SOUND_BACK)
	onButton(self, self.bg, function()
		self:Hide()

		return
	end, SOUND_BACK)

	return
end

function OutPostOmenTaskWindow:OnInit()
	self.page = findTF(self._tf, "window")
	self.list = findTF(self.page, "list/Viewport/Content")
	self.list_tpl = findTF(self.page, "list_tpl")
	self.uilist = UIItemList.New(self.list, self.list_tpl)

	self.uilist:make(function(arg_7_0, arg_7_1, arg_7_2)
		if arg_7_0 == UIItemList.EventUpdate then
			self:UpdateListItem(arg_7_1, arg_7_2)
		end

		return
	end)

	self.year, self.month, self.day = ChineseCalendar.GetCurrYearMonthDay((pg.TimeMgr.GetInstance():GetServerTime()))

	return
end

function OutPostOmenTaskWindow:Show(arg_8_1)
	OutPostOmenTaskWindow.super.Show(self)
	pg.UIMgr.GetInstance():BlurPanel(self._tf, {
		staticBlur = true
	})

	self.activity = arg_8_1
	self.nday = self.activity:getNDay()
	self.taskProxy = getProxy(TaskProxy)
	self.taskGroup = self.activity:getConfig("config_client").unlock_task

	self.uilist:align(#self.taskGroup)

	return
end

function OutPostOmenTaskWindow:UpdateListItem(arg_9_1, arg_9_2)
	local var_9_0 = findTF(arg_9_2, "default")
	local var_9_1 = findTF(var_9_0, "tasks")
	local var_9_2 = findTF(arg_9_2, "lock")
	local var_9_3 = findTF(var_9_2, "desc")
	local var_9_4 = arg_9_1 + 1

	setText(findTF(var_9_0, "day"), "DAY " .. arg_9_1 + 1)

	for iter_9_0 = 0, var_9_1.childCount - 1 do
		self:UpdateTaskItem(arg_9_1 + 1, iter_9_0, (var_9_1:GetChild(iter_9_0)))
	end

	local var_9_5 = self:isTaskLock(arg_9_1 + 1)
	local var_9_6 = var_9_5 ~= 0

	setActive(var_9_2, var_9_5 ~= 0)

	GetOrAddComponent(var_9_0, typeof(CanvasGroup)).alpha = var_9_6 and 0.5 or 1

	switch(var_9_5, {
		function()
			local var_10_0, var_10_1 = self:getDate(self.month, self.day + var_9_4 - self.nday)

			setText(var_9_3, i18n("OutPostOmenPage_task_tip1", var_10_0, var_10_1))

			return
		end,
		function()
			setText(var_9_3, i18n("OutPostOmenPage_task_tip2"))

			return
		end
	})

	return
end

function OutPostOmenTaskWindow:GetProgressColor()
	return nil
end

function OutPostOmenTaskWindow:UpdateTaskItem(arg_13_1, arg_13_2, arg_13_3)
	local var_13_0 = arg_13_3:Find("item")
	local var_13_1 = self.taskProxy:getTaskById(self.taskGroup[arg_13_1][arg_13_2 + 1]) or self.taskProxy:getFinishTaskById(self.taskGroup[arg_13_1][arg_13_2 + 1])
	local var_13_2 = pg.task_data_template[self.taskGroup[arg_13_1][arg_13_2 + 1]]
	local var_13_3 = Drop.Create(pg.task_data_template[self.taskGroup[arg_13_1][arg_13_2 + 1]].award_display[1])

	updateDrop(var_13_0, var_13_3)
	onButton(self, var_13_0, function()
		self:emit(BaseUI.ON_DROP, var_13_3)

		return
	end, SFX_PANEL)

	local var_13_4 = var_13_1 and var_13_1:getProgress() or 0
	local var_13_5 = var_13_2.target_num

	setText(arg_13_3:Find("description"), var_13_2.desc)
	setSlider(arg_13_3:Find("progress"), 0, var_13_5, var_13_4)

	local var_13_6, var_13_7 = OutPostOmenTaskWindow:GetProgressColor()

	var_13_4 = var_13_6 and setColorStr(var_13_4, var_13_6) or var_13_4
	var_13_5 = var_13_7 and setColorStr(var_13_5, var_13_7) or var_13_5

	setText(arg_13_3:Find("progressText"), var_13_4 .. "/" .. var_13_5)

	return
end

function OutPostOmenTaskWindow:getDate(arg_15_1, arg_15_2)
	local var_15_0 = pg.TimeMgr.GetInstance():CalcMonthDays(self.year, arg_15_1)

	if var_15_0 < arg_15_2 then
		arg_15_2 = arg_15_2 - var_15_0
		arg_15_1 = arg_15_1 + 1

		if arg_15_1 > 12 then
			arg_15_1 = 1
			self.year = self.year + 1
		end
	end

	return arg_15_1, arg_15_2
end

function OutPostOmenTaskWindow:GetProgressColor()
	return nil
end

function OutPostOmenTaskWindow:isTaskLock(arg_17_1)
	if arg_17_1 > self.nday then
		return 1
	end

	for iter_17_0 = 1, arg_17_1 - 1 do
		for iter_17_1, iter_17_2 in ipairs(self.taskGroup[iter_17_0]) do
			if (self.taskProxy:getTaskById(iter_17_2) or self.taskProxy:getFinishTaskById(iter_17_2)):getTaskStatus() ~= 2 then
				return 2
			end
		end
	end

	return 0
end

function OutPostOmenTaskWindow:Hide()
	if self:isShowing() then
		OutPostOmenTaskWindow.super.Hide(self)
		pg.UIMgr.GetInstance():UnOverlayPanel(self._tf, self._parentTf)
	end

	return
end

return OutPostOmenTaskWindow
