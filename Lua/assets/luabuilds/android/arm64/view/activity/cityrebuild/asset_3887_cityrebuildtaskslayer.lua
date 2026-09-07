local CityRebuildTasksLayer = class("CityRebuildTasksLayer", import("view.base.BaseUI"))

function CityRebuildTasksLayer:getUIName()
	return "CityRebuildTasksUI"
end

function CityRebuildTasksLayer:init()
	self.bg = self:findTF("BG")
	self.Close = self.bg:Find("close")
	self.list = self.bg:Find("panel/list")
	self.frame = self.bg:Find("frame")
	self.white_closebtn = self:findTF("white_close")
	self.UIlist = UIItemList.New(self.list, self.frame)
	self.getall = self.bg:Find("get_all")

	return
end

function CityRebuildTasksLayer:didEnter()
	self:InitData()
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

function CityRebuildTasksLayer.ShouldShowTip()
	local var_7_0 = getProxy(TaskProxy)
	local var_7_1 = getProxy(ActivityProxy):getActivityById(ActivityConst.NINJA_CITY_SP_TASK)
	local var_7_2 = var_7_1:getConfig("config_data")

	if var_7_1.data3 then
		return false
	end

	local var_7_3 = var_7_1.data3

	if var_7_1.data3 == 0 or var_7_3 == nil then
		return false
	end

	for iter_7_0 = 1, #var_7_2[var_7_3] do
		if var_7_0:getTaskVO(var_7_2[var_7_3][iter_7_0]):getTaskStatus() == 1 then
			return true
		end
	end

	local var_7_4 = getProxy(ActivityProxy):getActivityById(ActivityConst.NINJA_CITY_NORMAL_ACTIVITY_TASK):getConfig("config_data")

	for iter_7_1 = 1, #var_7_4 do
		if var_7_0:getTaskVO(var_7_4[iter_7_1]):getTaskStatus() == 1 then
			return true
		end
	end

	return false
end

function CityRebuildTasksLayer:InitData()
	self.taskProxy = getProxy(TaskProxy)
	self.taskActivityId = ActivityConst.NINJA_CITY_SP_TASK
	self.taskActivityId_2 = ActivityConst.NINJA_CITY_NORMAL_ACTIVITY_TASK
	self.activity = getProxy(ActivityProxy):getActivityById(self.taskActivityId)
	self.activity_2 = getProxy(ActivityProxy):getActivityById(self.taskActivityId_2)
	self.data = self.activity:getConfig("config_data")
	self.data2 = self.activity_2:getConfig("config_data")

	updateActivityTaskStatus(self.activity)

	self.config_datas = {}
	self.nday = self.activity.data3

	if not self.config_datas then
		table.clean(self.config_datas)
	end

	for iter_8_0 = 1, #self.data[self.nday] do
		table.insert(self.config_datas, self.data[self.nday][iter_8_0])
	end

	for iter_8_1 = 1, #self.data2 do
		table.insert(self.config_datas, self.data2[iter_8_1])
	end

	self:OnSort()
	self:UpdateView()

	return
end

function CityRebuildTasksLayer:OnSort()
	self.config_data = {}

	if not self.config_data then
		table.clean(self.config_data)
	end

	for iter_9_0 = 1, #self.config_datas do
		self.tasks = self.taskProxy:getTaskVO(self.config_datas[iter_9_0])

		if self.tasks:getTaskStatus() == 1 then
			table.insert(self.config_data, self.config_datas[iter_9_0])
		end
	end

	for iter_9_1 = 1, #self.config_datas do
		self.tasks = self.taskProxy:getTaskVO(self.config_datas[iter_9_1])

		if self.tasks:getTaskStatus() == 0 then
			table.insert(self.config_data, self.config_datas[iter_9_1])
		end
	end

	for iter_9_2 = 1, #self.config_datas do
		self.tasks = self.taskProxy:getTaskVO(self.config_datas[iter_9_2])

		if self.tasks:getTaskStatus() == 2 then
			table.insert(self.config_data, self.config_datas[iter_9_2])
		end
	end

	return
end

function CityRebuildTasksLayer:UpdateView()
	setActive(self.getall, self.ShouldShowTip())
	self.UIlist:make(function(arg_11_0, arg_11_1, arg_11_2)
		if arg_11_0 == UIItemList.EventUpdate then
			self:UpdateList(arg_11_1, arg_11_2, self.config_data)
		end

		return
	end)
	self.UIlist:align(#self.config_data)

	return
end

function CityRebuildTasksLayer:GetAllAward()
	self.indexTask = 0

	local var_12_0 = getProxy(PlayerProxy)
	local var_12_1 = {}
	local var_12_2 = {}

	for iter_12_0, iter_12_1 in pairs(self.config_data) do
		self.taskvo = self.taskProxy:getFinishTaskById(self.config_data[iter_12_0])
		self.task = self.taskProxy:getTaskVO(self.config_data[iter_12_0])

		if self.task:getTaskStatus() == 1 then
			for iter_12_2 = 1, #self.data2 do
				if self.task.id == self.data2[iter_12_2] then
					table.insert(var_12_1, self.config_data[iter_12_0])
				end
			end

			for iter_12_3 = 1, #self.data[self.nday] do
				if self.task.id == self.data[self.nday][iter_12_3] then
					table.insert(var_12_2, self.task.id)
				end
			end
		end
	end

	for iter_12_4 = 1, #var_12_2 do
		self:emit(CityRebuildTasksMediator.ON_SUBMIT_TASK, var_12_2[iter_12_4])
	end

	self:emit(CityRebuildTasksMediator.ON_TASK_SUBMIT_ONESTEP, self.taskActivityId_2, var_12_1)

	return
end

function CityRebuildTasksLayer:UpdateList(arg_13_1, arg_13_2, arg_13_3)
	local var_13_0 = arg_13_2:Find("frame")
	local var_13_1 = self.taskProxy:getTaskVO(arg_13_3[arg_13_1 + 1])

	setText(arg_13_2:Find("desc"), var_13_1:getConfig("desc"))

	local var_13_2 = var_13_1:getProgress()
	local var_13_3 = var_13_1:getConfig("target_num")

	setText(arg_13_2:Find("progress"), setColorStr(var_13_2, "#000000") .. "/" .. var_13_3)
	setSlider(arg_13_2:Find("slider"), 0, var_13_3, var_13_2)
	self:updateAwards(var_13_1:getConfig("award_display"), arg_13_2:Find("awards"), (arg_13_2:GetChild(0)))

	local var_13_4 = arg_13_2:Find("go_btn")
	local var_13_5 = arg_13_2:Find("get_btn")
	local var_13_6 = arg_13_2:Find("got_btn")
	local var_13_7 = var_13_1:getTaskStatus()

	setActive(var_13_4, var_13_7 == 0)
	setActive(var_13_5, var_13_7 == 1)
	setActive(var_13_6, var_13_7 == 2)
	SetActive(arg_13_2:Find("tip"), var_13_7 == 1)
	onButton(self, var_13_5, function()
		for iter_14_0 = 1, #self.data[self.nday] do
			if var_13_1.id == self.data[self.nday][iter_14_0] then
				self:emit(CityRebuildTasksMediator.ON_SUBMIT_TASK, var_13_1.id)
			end
		end

		for iter_14_1 = 1, #self.data2 do
			if var_13_1.id == self.data2[iter_14_1] then
				self:emit(CityRebuildTasksMediator.ON_TASK_SUBMIT_ONESTEP, self.taskActivityId_2, {
					var_13_1.id
				})
			end
		end

		return
	end, SFX_PANEL)
	onButton(self, var_13_4, function()
		self:emit(CityRebuildTasksMediator.ON_TASK_GO, var_13_1)

		return
	end, SFX_PANEL)

	return
end

function CityRebuildTasksLayer:updateAwards(arg_16_1, arg_16_2, arg_16_3)
	local var_16_0 = _.slice(arg_16_1, 1, 3)

	for iter_16_0 = arg_16_2.childCount, #var_16_0 - 1 do
		cloneTplTo(arg_16_3, arg_16_2)
	end

	for iter_16_1 = 1, arg_16_2.childCount do
		local var_16_1 = arg_16_2:GetChild(iter_16_1 - 1)
		local var_16_2 = iter_16_1 <= #var_16_0

		setActive(var_16_1, iter_16_1 <= #var_16_0)

		if var_16_2 then
			local var_16_3 = {
				type = var_16_0[iter_16_1][1],
				id = var_16_0[iter_16_1][2],
				count = var_16_0[iter_16_1][3]
			}

			updateDrop(findTF(var_16_1, "mask"), var_16_3)
			onButton(self, var_16_1:Find("mask"), function()
				self:emit(BaseUI.ON_DROP, var_16_3)

				return
			end, SFX_PANEL)
		end
	end

	return
end

return CityRebuildTasksLayer
