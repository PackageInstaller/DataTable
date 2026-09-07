local StarsCityOmenTaskWindow = class("StarsCityOmenTaskWindow", import("view.base.BaseSubView"))

StarsCityOmenTaskWindow.SKIP_TYPE_SCENE = 2
StarsCityOmenTaskWindow.SKIP_TYPE_ACTIVITY = 3

function StarsCityOmenTaskWindow:Ctor(arg_1_1, arg_1_2, arg_1_3)
	StarsCityOmenTaskWindow.super.Ctor(self, arg_1_1, arg_1_2, arg_1_3)

	return
end

function StarsCityOmenTaskWindow:getUIName()
	return "StarsCityOmenTaskWindow"
end

function StarsCityOmenTaskWindow:OnLoaded()
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

function StarsCityOmenTaskWindow:OnInit()
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

function StarsCityOmenTaskWindow:Show(arg_8_1)
	StarsCityOmenTaskWindow.super.Show(self)
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

function StarsCityOmenTaskWindow:UpdateListItem(arg_9_1, arg_9_2)
	local var_9_0 = findTF(arg_9_2, "default")
	local var_9_1 = findTF(var_9_0, "tasks")
	local var_9_2 = findTF(arg_9_2, "lock")
	local var_9_3 = findTF(var_9_2, "desc")
	local var_9_4 = findTF(var_9_2, "lockText1")
	local var_9_5 = findTF(var_9_2, "lockText2")
	local var_9_6 = arg_9_1 + 1

	setText(findTF(var_9_0, "day"), "DAY " .. arg_9_1 + 1)

	for iter_9_0 = 0, var_9_1.childCount - 1 do
		self:UpdateTaskItem(arg_9_1 + 1, iter_9_0, (var_9_1:GetChild(iter_9_0)))
	end

	local var_9_7 = self:isTaskLock(arg_9_1 + 1)
	local var_9_8 = var_9_7 ~= 0

	setActive(var_9_2, var_9_7 ~= 0)

	GetOrAddComponent(var_9_0, typeof(CanvasGroup)).alpha = var_9_8 and 0.5 or 1

	switch(var_9_7, {
		function()
			local var_10_0, var_10_1 = self:getDate(self.month, self.day + var_9_6 - self.nday)

			setText(var_9_4:Find("Text"), i18n("OutPostOmenPage_task_tip1", var_10_0, var_10_1))
			setText(var_9_5:Find("Text"), i18n("OutPostOmenPage_task_tip1", var_10_0, var_10_1))
			setActive(var_9_3, false)
			setActive(var_9_4, true)
			setActive(var_9_5, true)

			return
		end,
		function()
			setText(var_9_3, i18n("OutPostOmenPage_task_tip2"))
			setActive(var_9_3, true)
			setActive(var_9_4, false)
			setActive(var_9_5, false)

			return
		end
	})

	return
end

function StarsCityOmenTaskWindow:UpdateTaskItem(arg_12_1, arg_12_2, arg_12_3)
	local var_12_0 = arg_12_3:Find("item")
	local var_12_1 = self.taskProxy:getTaskById(self.taskGroup[arg_12_1][arg_12_2 + 1]) or self.taskProxy:getFinishTaskById(self.taskGroup[arg_12_1][arg_12_2 + 1])
	local var_12_2 = pg.task_data_template[self.taskGroup[arg_12_1][arg_12_2 + 1]]
	local var_12_3 = arg_12_3:Find("got_mask")
	local var_12_4 = Drop.Create(pg.task_data_template[self.taskGroup[arg_12_1][arg_12_2 + 1]].award_display[1])

	updateDrop(var_12_0, var_12_4)
	onButton(self, var_12_0, function()
		self:emit(BaseUI.ON_DROP, var_12_4)

		return
	end, SFX_PANEL)

	local var_12_5 = var_12_1 and var_12_1:getProgress() or 0
	local var_12_6 = var_12_2.target_num

	setText(arg_12_3:Find("description"), var_12_2.desc)
	setSlider(arg_12_3:Find("progress"), 0, var_12_6, var_12_5)

	local var_12_7, var_12_8 = self:GetProgressColor()

	setText(arg_12_3:Find("progressText"), setColorStr(var_12_5, var_12_7) .. setColorStr("/" .. var_12_6, var_12_8))

	if var_12_1:getTaskStatus() == 2 then
		setActive(var_12_3, true)
	end

	return
end

function StarsCityOmenTaskWindow:getDate(arg_14_1, arg_14_2)
	local var_14_0 = pg.TimeMgr.GetInstance():CalcMonthDays(self.year, arg_14_1)

	if var_14_0 < arg_14_2 then
		arg_14_2 = arg_14_2 - var_14_0
		arg_14_1 = arg_14_1 + 1

		if arg_14_1 > 12 then
			arg_14_1 = 1
			self.year = self.year + 1
		end
	end

	return arg_14_1, arg_14_2
end

function StarsCityOmenTaskWindow:GetProgressColor()
	return "#FFFFFF", "#C3C3C3"
end

function StarsCityOmenTaskWindow:isTaskLock(arg_16_1)
	if arg_16_1 > self.nday then
		return 1
	end

	for iter_16_0 = 1, arg_16_1 - 1 do
		for iter_16_1, iter_16_2 in ipairs(self.taskGroup[iter_16_0]) do
			if (self.taskProxy:getTaskById(iter_16_2) or self.taskProxy:getFinishTaskById(iter_16_2)):getTaskStatus() ~= 2 then
				return 2
			end
		end
	end

	return 0
end

function StarsCityOmenTaskWindow:Hide()
	if self:isShowing() then
		StarsCityOmenTaskWindow.super.Hide(self)
		pg.UIMgr.GetInstance():UnOverlayPanel(self._tf, self._parentTf)
	end

	return
end

return StarsCityOmenTaskWindow
