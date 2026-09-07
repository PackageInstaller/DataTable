local HolidayVillaTasksLayer = class("HolidayVillaTasksLayer", import("view.base.BaseUI"))

function HolidayVillaTasksLayer:getUIName()
	return "HolidayVillaTasksUI"
end

function HolidayVillaTasksLayer:init()
	self.white_closebtn = self._tf:Find("white_close")
	self.bg = self._tf:Find("BG")
	self.Close = self.bg:Find("close")
	self.list = self.bg:Find("panel/list")
	self.frame = self.bg:Find("frame")
	self.UIlist = UIItemList.New(self.list, self.frame)
	self.getall = self.bg:Find("get_all")

	return
end

function HolidayVillaTasksLayer.ShouldShowTip()
	local var_3_0 = getProxy(TaskProxy)
	local var_3_1 = getProxy(ActivityProxy):getActivityById(ActivityConst.HOLIDAY_TASK):getConfig("config_data")

	for iter_3_0 = 1, #var_3_1 do
		if var_3_0:getTaskVO(var_3_1[iter_3_0]):getTaskStatus() == 1 then
			return true
		end
	end

	return false
end

function HolidayVillaTasksLayer:didEnter()
	self:InitData()
	self:SortData()
	setActive(self.frame, false)
	onButton(self, self.Close, function()
		self:closeView()

		return
	end, SFX_PANEL)
	onButton(self, self.white_closebtn, function()
		self:closeView()

		return
	end, SFX_PANEL)
	onButton(self, self.getall, function()
		self:GetAllAward()

		return
	end)
	setText(self.getall:Find("Text"), i18n("other_world_task_get_all"))
	pg.UIMgr.GetInstance():BlurPanel(self._tf)

	return
end

function HolidayVillaTasksLayer:UpdateView()
	for iter_8_0 = 1, #self.config_client do
		for iter_8_1 = 1, #self.config_client[iter_8_0] do
			self.task = self.taskProxy:getTaskVO(self.config_client[iter_8_0][iter_8_1])
			self.isGottask = self:ISGot(self.task, self.config_client[iter_8_0][iter_8_1])

			if self.isGottask ~= 2 then
				table.insert(self.config_data, self.config_client[iter_8_0][iter_8_1])

				break
			elseif self.isGottask == 2 and iter_8_1 == #self.config_client[iter_8_0] then
				table.insert(self.config_data, self.config_client[iter_8_0][iter_8_1])
			end
		end
	end

	self:SortData()
	setActive(self.getall, self.ShouldShowTip())
	self.UIlist:make(function(arg_9_0, arg_9_1, arg_9_2)
		if arg_9_0 == UIItemList.EventUpdate then
			self:UpdateList(arg_9_1, arg_9_2, self.config_data)
		end

		return
	end)
	self.UIlist:align(#self.config_data)

	return
end

function HolidayVillaTasksLayer:SortData()
	local var_10_0 = {}
	local var_10_1 = {}
	local var_10_2 = {}

	for iter_10_0 = 1, #self.config_data do
		self.taskvo = self.taskProxy:getFinishTaskById(self.config_data[iter_10_0])
		self.task = self.taskProxy:getTaskVO(self.config_data[iter_10_0])

		if self.task:getTaskStatus() == 1 then
			table.insert(var_10_0, self.config_data[iter_10_0])
		elseif self.task:getTaskStatus() == 0 then
			table.insert(var_10_2, self.config_data[iter_10_0])
		elseif self.task:getTaskStatus() == 2 then
			table.insert(var_10_1, self.config_data[iter_10_0])
		end
	end

	for iter_10_1 = 1, #self.config_data do
		table.remove(self.config_data)
	end

	for iter_10_2 = 1, #var_10_0 do
		table.insert(self.config_data, var_10_0[iter_10_2])
	end

	for iter_10_3 = 1, #var_10_2 do
		table.insert(self.config_data, var_10_2[iter_10_3])
	end

	for iter_10_4 = 1, #var_10_1 do
		table.insert(self.config_data, var_10_1[iter_10_4])
	end

	return
end

function HolidayVillaTasksLayer:GetAllAward()
	local var_11_0 = getProxy(PlayerProxy)
	local var_11_1 = {}

	for iter_11_0, iter_11_1 in pairs(self.config_data) do
		self.taskvo = self.taskProxy:getFinishTaskById(self.config_data[iter_11_0])
		self.task = self.taskProxy:getTaskVO(self.config_data[iter_11_0])

		if self.task:getTaskStatus() == 1 then
			table.insert(var_11_1, self.config_data[iter_11_0])
		end
	end

	self:emit(HolidayVillaTasksMediator.ON_TASK_SUBMIT_ONESTEP, self.taskActivityId, var_11_1)

	return
end

function HolidayVillaTasksLayer:ISGot(arg_12_1, arg_12_2)
	return self.taskProxy:getTaskVO(arg_12_2):getTaskStatus()
end

function HolidayVillaTasksLayer:InitData()
	self.taskActivityId = ActivityConst.HOLIDAY_TASK
	self.taskProxy = getProxy(TaskProxy)
	self.activity = getProxy(ActivityProxy):getActivityById(self.taskActivityId)
	self.config_data = {}

	if #self.config_data == 0 then
		-- block empty
	else
		for iter_13_0 = 1, #self.config_data do
			table.remove(self.config_data)
		end
	end

	self.config_client = self.activity:getConfig("config_client").task

	self:UpdateView()

	return
end

function HolidayVillaTasksLayer:UpdateList(arg_14_1, arg_14_2, arg_14_3)
	local var_14_0 = arg_14_2:Find("frame")
	local var_14_1 = self.taskProxy:getTaskVO(arg_14_3[arg_14_1 + 1])

	setText(arg_14_2:Find("desc"), var_14_1:getConfig("desc"))

	local var_14_2 = var_14_1:getProgress()
	local var_14_3 = var_14_1:getConfig("target_num")

	setText(arg_14_2:Find("progress"), var_14_2 .. "/" .. var_14_3)
	setSlider(arg_14_2:Find("slider"), 0, var_14_3, var_14_2)
	self:updateAwards(var_14_1:getConfig("award_display"), arg_14_2:Find("awards"), (arg_14_2:GetChild(0)))

	local var_14_4 = arg_14_2:Find("go_btn")
	local var_14_5 = arg_14_2:Find("get_btn")
	local var_14_6 = arg_14_2:Find("got_btn")

	setText(arg_14_2:Find("go_btn/text"), i18n("other_world_task_go"))
	setText(arg_14_2:Find("get_btn/text"), i18n("other_world_task_get"))
	setText(arg_14_2:Find("got_btn/text"), i18n("other_world_task_got"))

	local var_14_7 = var_14_1:getTaskStatus()

	setActive(var_14_4, var_14_7 == 0)
	setActive(var_14_5, var_14_7 == 1)
	setActive(var_14_6, var_14_7 == 2)
	SetActive(arg_14_2:Find("tip"), var_14_7 == 1)
	onButton(self, var_14_5, function()
		self:emit(HolidayVillaTasksMediator.ON_TASK_SUBMIT_ONESTEP, self.taskActivityId, {
			var_14_1.id
		})

		return
	end, SFX_PANEL)
	onButton(self, var_14_4, function()
		self:emit(HolidayVillaTasksMediator.ON_TASK_GO, var_14_1)

		return
	end, SFX_PANEL)

	return
end

function HolidayVillaTasksLayer:updateAwards(arg_17_1, arg_17_2, arg_17_3)
	local var_17_0 = _.slice(arg_17_1, 1, 3)

	for iter_17_0 = arg_17_2.childCount, #var_17_0 - 1 do
		cloneTplTo(arg_17_3, arg_17_2)
	end

	for iter_17_1 = 1, arg_17_2.childCount do
		local var_17_1 = arg_17_2:GetChild(iter_17_1 - 1)
		local var_17_2 = iter_17_1 <= #var_17_0

		setActive(var_17_1, iter_17_1 <= #var_17_0)

		if var_17_2 then
			local var_17_3 = {
				type = var_17_0[iter_17_1][1],
				id = var_17_0[iter_17_1][2],
				count = var_17_0[iter_17_1][3]
			}

			updateDrop(findTF(var_17_1, "mask"), var_17_3)
			onButton(self, var_17_1:Find("mask"), function()
				self:emit(BaseUI.ON_ITEM, var_17_3)

				return
			end, SFX_PANEL)
		end
	end

	return
end

return HolidayVillaTasksLayer
