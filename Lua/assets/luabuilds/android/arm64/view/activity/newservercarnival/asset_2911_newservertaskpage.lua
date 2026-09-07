local NewServerTaskPage = class("NewServerTaskPage", import("...base.BaseSubView"))

function NewServerTaskPage:getUIName()
	return "NewServerTaskPage"
end

NewServerTaskPage.TYPE_ALL = 1
NewServerTaskPage.TYPE_DAILY = 2
NewServerTaskPage.TYPE_TARGET = 3
NewServerTaskPage.TXT_DESC = 1
NewServerTaskPage.TXT_CURRENT_NUM = 2
NewServerTaskPage.TXT_TARGET_NUM = 3

function NewServerTaskPage:OnInit()
	self:initData()
	self:initUI()
	self:addListener()
	self:onUpdateTask()

	return
end

function NewServerTaskPage:initData()
	self.activity = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_NEWSERVER_TASK)
	self.taskGroupList = self.activity:getConfig("config_data")
	self.taskProxy = getProxy(TaskProxy)
	self.page = NewServerTaskPage.TYPE_ALL

	return
end

function NewServerTaskPage:initUI()
	self.getAllBtn = self._tf:Find("get_all")
	self.extendTpl = self._tf:Find("extend_tpl")
	self.typeToggles = {
		self._tf:Find("types/all"),
		self._tf:Find("types/daily"),
		self._tf:Find("types/target")
	}
	self.content = self._tf:Find("view/content")
	self.taskGroupItemList = UIItemList.New(self.content, self.content:Find("tpl"))

	return
end

function NewServerTaskPage:addListener()
	onButton(self, self.getAllBtn, function()
		self:emit(NewServerCarnivalMediator.TASK_SUBMIT_ONESTEP, self.finishVOList)

		return
	end, SFX_PANEL)
	self.taskGroupItemList:make(function(arg_7_0, arg_7_1, arg_7_2)
		arg_7_1 = arg_7_1 + 1

		if arg_7_0 == UIItemList.EventUpdate then
			self:updateTaskGroup(arg_7_2, arg_7_1)
		end

		return
	end)

	for iter_5_0, iter_5_1 in ipairs(self.typeToggles) do
		onToggle(self, iter_5_1, function(arg_8_0)
			if arg_8_0 then
				if iter_5_0 == NewServerTaskPage.TYPE_ALL then
					self:filterAll()
				elseif iter_5_0 == NewServerTaskPage.TYPE_DAILY then
					self:filterDaily()
				elseif iter_5_0 == NewServerTaskPage.TYPE_TARGET then
					self:filterTarget()
				end

				self.page = iter_5_0
			end

			self:updataTaskList()

			return
		end)
	end

	return
end

function NewServerTaskPage:updateTaskGroup(arg_9_1, arg_9_2)
	local var_9_0 = arg_9_1:Find("info")
	local var_9_1 = {}

	for iter_9_0, iter_9_1 in ipairs(self.showVOGroup[arg_9_2]) do
		if not iter_9_1:isReceive() then
			table.insert(var_9_1, iter_9_1)
		end
	end

	triggerToggle(var_9_0, false)

	local var_9_2 = #var_9_1 > 0 and table.remove(var_9_1, 1) or self.showVOGroup[arg_9_2][#self.showVOGroup[arg_9_2]]

	SetCompomentEnabled(var_9_0, typeof(Toggle), #var_9_1 > 0)
	self:updateTaskDisplay(var_9_0, var_9_2)
	setActive(var_9_0:Find("toggle_mark"), #var_9_1 > 0)

	local var_9_3 = var_9_2:getTaskStatus()

	GetOrAddComponent(arg_9_1, typeof(CanvasGroup)).alpha = var_9_3 == 2 and 0.5 or 1

	setActive(var_9_0:Find("mask"), var_9_3 == 2)
	setActive(var_9_0:Find("bg/receive"), var_9_3 == 1)
	setActive(var_9_0:Find("tag/tag_daily"), var_9_2:getConfig("type") == Task.TYPE_ACTIVITY_ROUTINE)
	setActive(var_9_0:Find("tag/tag_target"), var_9_2:getConfig("type") ~= Task.TYPE_ACTIVITY_ROUTINE)
	onToggle(self, var_9_0, function(arg_10_0)
		if arg_10_0 then
			local var_10_0 = UIItemList.New(arg_9_1:Find("content"), self.extendTpl)

			var_10_0:make(function(arg_11_0, arg_11_1, arg_11_2)
				arg_11_1 = arg_11_1 + 1

				if arg_11_0 == UIItemList.EventUpdate then
					self:updateTaskDisplay(arg_11_2, var_9_1[arg_11_1])
				end

				return
			end)
			var_10_0:align(#var_9_1)
			scrollTo(self.content, 0, 1 - (arg_9_2 - 1) / (#self.showVOGroup + #var_9_1 - 4))
		else
			removeAllChildren(arg_9_1:Find("content"))
		end

		return
	end)

	return
end

function NewServerTaskPage:updateTaskDisplay(arg_12_1, arg_12_2)
	local var_12_0 = arg_12_2:getProgress()
	local var_12_1 = arg_12_2:getConfig("target_num")

	setSlider(arg_12_1:Find("Slider"), 0, var_12_1, var_12_0)

	local var_12_2 = arg_12_2:getConfig("award_display")[1]
	local var_12_3 = {
		type = var_12_2[1],
		id = var_12_2[2],
		count = var_12_2[3]
	}

	updateDrop(arg_12_1:Find("IconTpl"), var_12_3)
	onButton(self, arg_12_1:Find("IconTpl"), function()
		self:emit(BaseUI.ON_DROP, var_12_3)

		return
	end, SFX_PANEL)

	local var_12_4 = arg_12_2:getTaskStatus()

	setActive(arg_12_1:Find("go"), var_12_4 == 0)
	setActive(arg_12_1:Find("get"), var_12_4 == 1)
	setActive(arg_12_1:Find("got"), var_12_4 == 2)
	setText(arg_12_1:Find("desc"), setColorStr(arg_12_2:getConfig("desc"), self:getColor(NewServerTaskPage.TXT_DESC, var_12_4)))
	setText(arg_12_1:Find("Slider/Text"), setColorStr(var_12_0, self:getColor(NewServerTaskPage.TXT_CURRENT_NUM, var_12_4)) .. setColorStr("/" .. var_12_1, self:getColor(NewServerTaskPage.TXT_TARGET_NUM, var_12_4)))
	onButton(self, arg_12_1:Find("go"), function()
		self:emit(NewServerCarnivalMediator.TASK_GO, arg_12_2)

		return
	end, SFX_PANEL)
	onButton(self, arg_12_1:Find("get"), function()
		self:emit(NewServerCarnivalMediator.TASK_SUBMIT, arg_12_2)

		return
	end, SFX_CONFIRM)

	return
end

function NewServerTaskPage:getColor(arg_16_1, arg_16_2)
	if arg_16_1 == NewServerTaskPage.TXT_DESC then
		return arg_16_2 == 1 and "#63573c" or "#a1976e"
	elseif arg_16_1 == NewServerTaskPage.TXT_CURRENT_NUM then
		return arg_16_2 == 1 and "#219215" or "#65D559"
	elseif arg_16_1 == NewServerTaskPage.TXT_TARGET_NUM then
		return arg_16_2 == 1 and "#5c4212" or "#ae9363"
	end

	return
end

function NewServerTaskPage:filterAll()
	self.taskVOGroup = underscore.map(self.taskGroupList, function(arg_18_0)
		return underscore.map(arg_18_0, function(arg_19_0)
			assert(self.taskProxy:getTaskVO(arg_19_0), "without this task:" .. arg_19_0)

			return self.taskProxy:getTaskVO(arg_19_0)
		end)
	end)
	self.showVOGroup = self.taskVOGroup

	return
end

function NewServerTaskPage:filterDaily()
	self.taskVOGroup = underscore.map(self.taskGroupList, function(arg_21_0)
		return underscore.map(arg_21_0, function(arg_22_0)
			assert(self.taskProxy:getTaskVO(arg_22_0), "without this task:" .. arg_22_0)

			return self.taskProxy:getTaskVO(arg_22_0)
		end)
	end)
	self.showVOGroup = {}

	for iter_20_0, iter_20_1 in ipairs(self.taskVOGroup) do
		if iter_20_1[1]:getConfig("type") == Task.TYPE_ACTIVITY_ROUTINE then
			table.insert(self.showVOGroup, iter_20_1)
		end
	end

	return
end

function NewServerTaskPage:filterTarget()
	self.taskVOGroup = underscore.map(self.taskGroupList, function(arg_24_0)
		return underscore.map(arg_24_0, function(arg_25_0)
			assert(self.taskProxy:getTaskVO(arg_25_0), "without this task:" .. arg_25_0)

			return self.taskProxy:getTaskVO(arg_25_0)
		end)
	end)
	self.showVOGroup = {}

	for iter_23_0, iter_23_1 in ipairs(self.taskVOGroup) do
		if iter_23_1[1]:getConfig("type") ~= Task.TYPE_ACTIVITY_ROUTINE then
			table.insert(self.showVOGroup, iter_23_1)
		end
	end

	return
end

function NewServerTaskPage:updataTaskList()
	table.sort(self.showVOGroup, CompareFuncs({
		function(arg_27_0)
			for iter_27_0, iter_27_1 in ipairs(arg_27_0) do
				if iter_27_1:getTaskStatus() == 1 then
					return 0
				end
			end

			return underscore.all(arg_27_0, function(arg_28_0)
				return arg_28_0:isReceive()
			end) and 2 or 1
		end,
		function(arg_29_0)
			return arg_29_0[1]:getConfig("type") ~= Task.TYPE_ACTIVITY_ROUTINE and 1 or 0
		end,
		function(arg_30_0)
			return arg_30_0[1].id
		end
	}))
	self.taskGroupItemList:align(#self.showVOGroup)

	return
end

function NewServerTaskPage:onUpdateTask()
	triggerToggle(self.typeToggles[self.page], true)
	self:updataGetAllBtn()

	return
end

function NewServerTaskPage:updataGetAllBtn()
	self.finishVOList = {}

	for iter_32_0, iter_32_1 in ipairs(self.taskVOGroup) do
		for iter_32_2, iter_32_3 in ipairs(iter_32_1) do
			if iter_32_3:getTaskStatus() == 1 then
				table.insert(self.finishVOList, iter_32_3)
			end
		end
	end

	setActive(self.getAllBtn, #self.finishVOList > 0)

	return
end

function NewServerTaskPage:isTip()
	if self.finishVOList then
		return #self.finishVOList > 0
	else
		local var_33_0 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_NEWSERVER_TASK)

		if var_33_0 and not var_33_0:isEnd() then
			local var_33_1 = getProxy(TaskProxy)

			for iter_33_0, iter_33_1 in ipairs((var_33_0:getConfig("config_data"))) do
				for iter_33_2, iter_33_3 in ipairs(iter_33_1) do
					assert(var_33_1:getTaskVO(iter_33_3), "without this task:" .. iter_33_3)

					if var_33_1:getTaskVO(iter_33_3):getTaskStatus() == 1 then
						return true
					end
				end
			end
		end

		return false
	end

	return
end

function NewServerTaskPage:OnDestroy()
	return
end

return NewServerTaskPage
