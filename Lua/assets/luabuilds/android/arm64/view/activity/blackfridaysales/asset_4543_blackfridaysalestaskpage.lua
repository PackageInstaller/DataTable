local BlackFridaySalesTaskPage = class("BlackFridaySalesTaskPage", import("...base.BaseSubView"))

function BlackFridaySalesTaskPage:getUIName()
	return "BlackFridaySalesTaskPage"
end

BlackFridaySalesTaskPage.TYPE_ALL = 1
BlackFridaySalesTaskPage.TYPE_DAILY = 2
BlackFridaySalesTaskPage.TYPE_TARGET = 3
BlackFridaySalesTaskPage.TXT_DESC = 1
BlackFridaySalesTaskPage.TXT_CURRENT_NUM = 2
BlackFridaySalesTaskPage.TXT_TARGET_NUM = 3

function BlackFridaySalesTaskPage:OnInit()
	self:initData()
	self:initUI()
	self:addListener()
	self:onUpdateTask()

	return
end

function BlackFridaySalesTaskPage:initData()
	for iter_3_0, iter_3_1 in ipairs((getProxy(ActivityProxy):getActivitiesByType(ActivityConst.ACTIVITY_TYPE_TASKS))) do
		if iter_3_1:getConfig("config_client").blackFriday then
			self.activity = iter_3_1

			break
		end
	end

	self.taskGroupList = self.activity:getConfig("config_client").taskGroup
	self.taskProxy = getProxy(TaskProxy)
	self.page = BlackFridaySalesTaskPage.TYPE_ALL

	return
end

function BlackFridaySalesTaskPage:initUI()
	self.getAllBtn = self._tf:Find("get_all")
	self.extendTpl = self._tf:Find("extend_tpl")
	self.content = self._tf:Find("view/content")
	self.taskGroupItemList = UIItemList.New(self.content, self.content:Find("tpl"))

	setActive(self.getAllBtn, false)

	return
end

function BlackFridaySalesTaskPage:addListener()
	onButton(self, self.getAllBtn, function()
		self:emit(BlackFridaySalesMediator.TASK_SUBMIT_ONESTEP, self.finishVOList)

		return
	end, SFX_PANEL)
	self.taskGroupItemList:make(function(arg_7_0, arg_7_1, arg_7_2)
		arg_7_1 = arg_7_1 + 1

		if arg_7_0 == UIItemList.EventUpdate then
			self:updateTaskGroup(arg_7_2, arg_7_1)
		end

		return
	end)

	return
end

function BlackFridaySalesTaskPage:updateTaskGroup(arg_8_1, arg_8_2)
	local var_8_0 = arg_8_1:Find("info")
	local var_8_1 = {}

	for iter_8_0, iter_8_1 in ipairs(self.showVOGroup[arg_8_2]) do
		if not iter_8_1:isReceive() then
			table.insert(var_8_1, iter_8_1)
		end
	end

	triggerToggle(var_8_0, false)

	local var_8_2 = #var_8_1 > 0 and table.remove(var_8_1, 1) or self.showVOGroup[arg_8_2][#self.showVOGroup[arg_8_2]]

	SetCompomentEnabled(var_8_0, typeof(Toggle), #var_8_1 > 0)
	self:updateTaskDisplay(var_8_0, var_8_2)
	setActive(var_8_0:Find("toggle_mark"), #var_8_1 > 0)

	local var_8_3 = var_8_2:getTaskStatus()

	GetOrAddComponent(arg_8_1, typeof(CanvasGroup)).alpha = var_8_3 == 2 and 0.5 or 1

	setActive(var_8_0:Find("mask"), var_8_3 == 2)
	setActive(var_8_0:Find("bg/receive"), var_8_3 == 1)
	onToggle(self, var_8_0, function(arg_9_0)
		if arg_9_0 then
			local var_9_0 = UIItemList.New(arg_8_1:Find("content"), self.extendTpl)

			var_9_0:make(function(arg_10_0, arg_10_1, arg_10_2)
				arg_10_1 = arg_10_1 + 1

				if arg_10_0 == UIItemList.EventUpdate then
					self:updateTaskDisplay(arg_10_2, var_8_1[arg_10_1])
				end

				return
			end)
			var_9_0:align(#var_8_1)
			scrollTo(self.content, 0, 1 - (arg_8_2 - 1) / (#self.showVOGroup + #var_8_1 - 4))
		else
			removeAllChildren(arg_8_1:Find("content"))
		end

		return
	end)

	return
end

function BlackFridaySalesTaskPage:updateTaskDisplay(arg_11_1, arg_11_2)
	local var_11_0 = arg_11_2:getProgress()
	local var_11_1 = arg_11_2:getConfig("target_num")

	setSlider(arg_11_1:Find("Slider"), 0, var_11_1, var_11_0)

	local var_11_2 = arg_11_2:getConfig("award_display")[1]
	local var_11_3 = {
		type = var_11_2[1],
		id = var_11_2[2],
		count = var_11_2[3]
	}

	updateDrop(arg_11_1:Find("IconTpl"), var_11_3)
	onButton(self, arg_11_1:Find("IconTpl"), function()
		self:emit(BaseUI.ON_DROP, var_11_3)

		return
	end, SFX_PANEL)

	local var_11_4 = arg_11_2:getTaskStatus()

	setActive(arg_11_1:Find("go"), var_11_4 == 0)
	setActive(arg_11_1:Find("get"), var_11_4 == 1)
	setActive(arg_11_1:Find("got"), var_11_4 == 2)
	setText(arg_11_1:Find("desc"), setColorStr(arg_11_2:getConfig("desc"), self:getColor(BlackFridaySalesTaskPage.TXT_DESC, var_11_4)))
	setText(arg_11_1:Find("Slider/Text"), setColorStr(var_11_0, self:getColor(BlackFridaySalesTaskPage.TXT_CURRENT_NUM, var_11_4)) .. setColorStr("/" .. var_11_1, self:getColor(BlackFridaySalesTaskPage.TXT_TARGET_NUM, var_11_4)))
	onButton(self, arg_11_1:Find("go"), function()
		self:emit(BlackFridaySalesMediator.TASK_GO, arg_11_2)

		return
	end, SFX_PANEL)
	onButton(self, arg_11_1:Find("get"), function()
		self:emit(BlackFridaySalesMediator.TASK_SUBMIT, arg_11_2)

		return
	end, SFX_CONFIRM)

	return
end

function BlackFridaySalesTaskPage:getColor(arg_15_1, arg_15_2)
	if arg_15_1 == BlackFridaySalesTaskPage.TXT_DESC then
		return arg_15_2 == 1 and "#393a3c" or "#ffffff"
	elseif arg_15_1 == BlackFridaySalesTaskPage.TXT_CURRENT_NUM then
		return "#30ec80"
	elseif arg_15_1 == BlackFridaySalesTaskPage.TXT_TARGET_NUM then
		return "#393a3c"
	end

	return
end

function BlackFridaySalesTaskPage:filterAll()
	self.taskVOGroup = underscore.map(self.taskGroupList, function(arg_17_0)
		return underscore.map(arg_17_0, function(arg_18_0)
			assert(self.taskProxy:getTaskVO(arg_18_0), "without this task:" .. arg_18_0)

			return self.taskProxy:getTaskVO(arg_18_0)
		end)
	end)
	self.showVOGroup = self.taskVOGroup

	return
end

function BlackFridaySalesTaskPage:updataTaskList()
	table.sort(self.showVOGroup, CompareFuncs({
		function(arg_20_0)
			for iter_20_0, iter_20_1 in ipairs(arg_20_0) do
				if iter_20_1:getTaskStatus() == 1 then
					return 0
				end
			end

			return underscore.all(arg_20_0, function(arg_21_0)
				return arg_21_0:isReceive()
			end) and 2 or 1
		end,
		function(arg_22_0)
			return arg_22_0[1].id
		end
	}))
	self.taskGroupItemList:align(#self.showVOGroup)

	return
end

function BlackFridaySalesTaskPage:onUpdateTask()
	self:filterAll()
	self:updataTaskList()
	self:updataGetAllBtn()

	return
end

function BlackFridaySalesTaskPage:updataGetAllBtn()
	return
end

function BlackFridaySalesTaskPage:isTip()
	if self.finishVOList then
		return #self.finishVOList > 0
	else
		local var_25_0

		for iter_25_0, iter_25_1 in ipairs((getProxy(ActivityProxy):getActivitiesByType(ActivityConst.ACTIVITY_TYPE_TASKS))) do
			if iter_25_1:getConfig("config_client").blackFriday then
				var_25_0 = iter_25_1

				break
			end
		end

		if var_25_0 and not var_25_0:isEnd() then
			local var_25_1 = getProxy(TaskProxy)

			for iter_25_2, iter_25_3 in ipairs(var_25_0:getConfig("config_client").taskGroup) do
				for iter_25_4, iter_25_5 in ipairs(iter_25_3) do
					assert(var_25_1:getTaskVO(iter_25_5), "without this task:" .. iter_25_5)

					if var_25_1:getTaskVO(iter_25_5):getTaskStatus() == 1 then
						return true
					end
				end
			end
		end

		return false
	end

	return
end

function BlackFridaySalesTaskPage:OnDestroy()
	return
end

return BlackFridaySalesTaskPage
