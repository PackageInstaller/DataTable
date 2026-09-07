local VoteExchangeScene = class("VoteExchangeScene", import("view.base.BaseUI"))

function VoteExchangeScene:getUIName()
	return "VoteExchangeUI"
end

function VoteExchangeScene:init()
	self.closeBtn = self._tf:Find("blur_panel/adapt/top/back_btn")
	self.dailyTask = self._tf:Find("left/task/slider/bar")
	self.dailyTaskTxt = self._tf:Find("left/task/Text"):GetComponent(typeof(Text))
	self.timeTxt = self._tf:Find("right/title/Text/Text"):GetComponent(typeof(Text))
	self.dailyTaskGoBtn = self._tf:Find("left/go")
	self.totalCntTxt = self._tf:Find("right/total/Text"):GetComponent(typeof(Text))
	self.uiItemList = UIItemList.New(self._tf:Find("right/view/content"), self._tf:Find("right/view/content/tpl"))
	self.taskContainer = self._tf:Find("right/view")
	self.emptyTr = self._tf:Find("right/empty")

	setText(self._tf:Find("left/bg/Text"), i18n("vote_lable_daily_task_title"))

	local var_2_0 = string.split(i18n("vote_lable_daily_task_tip"), "$1")

	setText(self._tf:Find("left/task/desc/label1"), var_2_0[1])
	setText(self._tf:Find("left/task/desc/labe2"), var_2_0[2])
	setText(self._tf:Find("right/title/Text"), i18n("vote_lable_task_title"))
	setText(self.emptyTr:Find("Image/Text"), i18n("vote_lable_task_list_is_empty"))

	return
end

function VoteExchangeScene:didEnter()
	assert(self.contextData.voteGroup)
	onButton(self, self.dailyTaskGoBtn, function()
		self:emit(VoteExchangeMediator.GO_TASK)

		return
	end, SFX_PANEL)
	onButton(self, self.closeBtn, function()
		self:emit(VoteExchangeScene.ON_CLOSE)

		return
	end, SFX_PANEL)

	self.taskList = self:GetTaskList()
	self.dailyTaskList = self:GetDailyTaskList()

	self:Flush()

	return
end

function VoteExchangeScene:Flush()
	self:UpdateDailyTask()
	self:UpdateTitle()
	self:UpdateTicket()
	self:UpdateTaskList()

	return
end

function VoteExchangeScene:UpdateTitle()
	self.timeTxt.text = self.contextData.voteGroup:getConfig("name") .. " " .. self.contextData.voteGroup:getTimeDesc()

	return
end

function VoteExchangeScene:GetActivity()
	local var_8_0

	for iter_8_0, iter_8_1 in ipairs((getProxy(ActivityProxy):getActivitiesByType(ActivityConst.ACTIVITY_TYPE_VOTE))) do
		if iter_8_1:getConfig("config_id") == self.contextData.voteGroup.configId then
			var_8_0 = iter_8_1

			break
		end
	end

	return var_8_0
end

function VoteExchangeScene:UpdateTicket()
	local var_9_0 = self:GetActivity()

	self.totalCntTxt.text = var_9_0 and var_9_0.data3 .. "/" .. self.contextData.voteGroup:getConfig("ticket_period") or ""

	return
end

function VoteExchangeScene:GetTaskList()
	local var_10_0 = self:GetActivity()

	if var_10_0 and var_10_0.data3 >= self.contextData.voteGroup:getConfig("ticket_period") then
		return {}
	end

	local var_10_1 = Clone(self.contextData.voteGroup:getConfig("task_period"))
	local var_10_2 = getProxy(TaskProxy)

	for iter_10_0 = #var_10_1, 1, -1 do
		for iter_10_1 = #var_10_1[iter_10_0], 1, -1 do
			local var_10_3 = var_10_2:getTaskById(var_10_1[iter_10_0][iter_10_1]) or var_10_2:getFinishTaskById(var_10_1[iter_10_0][iter_10_1])

			if not var_10_3 or var_10_3:isFinish() and var_10_3:isReceive() then
				table.remove(var_10_1[iter_10_0], iter_10_1)
			end
		end

		if #var_10_1[iter_10_0] <= 0 then
			table.remove(var_10_1, iter_10_0)
		end
	end

	return var_10_1
end

function VoteExchangeScene:GetDailyTaskList()
	return (self.contextData.voteGroup:getConfig("task_daily"))
end

function VoteExchangeScene:UpdateDailyTask()
	local var_12_0 = 0
	local var_12_1 = getProxy(TaskProxy)

	for iter_12_0, iter_12_1 in ipairs(self.dailyTaskList) do
		local var_12_2 = var_12_1:getTaskById(iter_12_1) or var_12_1:getFinishTaskById(iter_12_1)

		if var_12_2 and var_12_2:isFinish() and var_12_2:isReceive() then
			var_12_0 = var_12_0 + 1
		end
	end

	self.dailyTaskTxt.text = var_12_0 .. "/" .. #self.dailyTaskList

	setFillAmount(self.dailyTask, var_12_0 / #self.dailyTaskList)

	return
end

function VoteExchangeScene:UpdateTaskList()
	self.uiItemList:make(function(arg_14_0, arg_14_1, arg_14_2)
		if arg_14_0 == UIItemList.EventUpdate then
			self:UpdateTaskCard(self.taskList[arg_14_1 + 1], arg_14_2)
		end

		return
	end)
	self.uiItemList:align(#self.taskList)

	local var_13_0 = #self.taskList <= 0

	setActive(self.emptyTr, #self.taskList <= 0)
	setActive(self.taskContainer, not var_13_0)

	return
end

function VoteExchangeScene:UpdateTaskCard(arg_15_1, arg_15_2)
	local var_15_0 = UIItemList.New(arg_15_2:Find("content"), arg_15_2:Find("content/extend_tpl"))

	var_15_0:make(function(arg_16_0, arg_16_1, arg_16_2)
		if arg_16_0 == UIItemList.EventUpdate then
			self:UpdateTaskDesc(arg_15_1[arg_16_1 + 2], arg_16_2)
		end

		return
	end)
	var_15_0:align(#arg_15_1 - 1)
	self:UpdateTaskDesc(arg_15_1[1], arg_15_2:Find("info"))

	return
end

function VoteExchangeScene:UpdateTaskDesc(arg_17_1, arg_17_2)
	local var_17_0 = getProxy(TaskProxy):getTaskById(arg_17_1)

	var_17_0 = var_17_0 or getProxy(TaskProxy):getFinishTaskById(arg_17_1)

	assert(var_17_0, arg_17_1)

	local var_17_1 = var_17_0:isFinish()
	local var_17_2 = var_17_0:isReceive()
	local var_17_3 = arg_17_2:Find("go")
	local var_17_4 = arg_17_2:Find("get")

	setActive(var_17_3, not var_17_1)
	setActive(arg_17_2:Find("got"), var_17_1 and var_17_2)
	setActive(var_17_4, var_17_1 and not var_17_2)

	local var_17_5 = var_17_0:getConfig("award_display")

	updateDrop(arg_17_2:Find("IconTpl"), {
		type = var_17_5[1][1],
		id = var_17_5[1][2],
		count = var_17_5[1][3]
	})

	local var_17_6 = var_17_0:getProgress()
	local var_17_7 = var_17_0:getConfig("target_num")

	setText(arg_17_2:Find("Text"), var_17_6 .. "/" .. var_17_7)
	setText(arg_17_2:Find("desc"), var_17_0:getConfig("desc"))
	setFillAmount(arg_17_2:Find("Slider/Fill"), var_17_6 / var_17_7)
	onButton(self, var_17_3, function()
		self:emit(VoteExchangeMediator.SKIP_TASK, var_17_0)

		return
	end, SFX_PANEL)
	onButton(self, var_17_4, function()
		self:emit(VoteExchangeMediator.SUBMIT_TASK, var_17_0.id)

		return
	end, SFX_PANEL)

	return
end

function VoteExchangeScene:onBackPressed()
	VoteExchangeScene.super.onBackPressed(self)

	return
end

function VoteExchangeScene:willExit()
	return
end

return VoteExchangeScene
