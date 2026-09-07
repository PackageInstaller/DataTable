local ClueTasksLayer = class("ClueTasksLayer", import("view.base.BaseUI"))

function ClueTasksLayer:getUIName()
	return "ClueTasksUI"
end

function ClueTasksLayer:init()
	self.white_closebtn = self._tf:Find("white_close")
	self.bg = self._tf:Find("BG")
	self.Close = self.bg:Find("close")
	self.list = self.bg:Find("panel/list")
	self.frame = self.bg:Find("frame")
	self.UIlist = UIItemList.New(self.list, self.frame)
	self.getall = self.bg:Find("get_all")

	return
end

function ClueTasksLayer.ShouldShowTip()
	local var_3_0 = getProxy(TaskProxy)
	local var_3_1 = getProxy(ActivityProxy):getActivityById(ActivityConst.Valleyhospital_TASK):getConfig("config_data")

	for iter_3_0 = 1, #var_3_1 do
		if var_3_0:getTaskVO(var_3_1[iter_3_0]):getTaskStatus() == 1 then
			return true
		end
	end

	return false
end

function ClueTasksLayer:didEnter()
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
	self:UpdateView()
	onButton(self, self.getall, function()
		self:GetAllAward()

		return
	end)
	setText(self.getall:Find("Text"), i18n("other_world_task_get_all"))
	pg.UIMgr.GetInstance():BlurPanel(self._tf)

	return
end

function ClueTasksLayer:UpdateView()
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

function ClueTasksLayer:GetAllAward()
	local var_10_0 = getProxy(PlayerProxy)
	local var_10_1 = {}

	for iter_10_0, iter_10_1 in pairs(self.config_data) do
		self.taskvo = self.taskProxy:getFinishTaskById(self.config_data[iter_10_0])
		self.task = self.taskProxy:getTaskVO(self.config_data[iter_10_0])

		if self.task:getTaskStatus() == 1 then
			table.insert(var_10_1, self.config_data[iter_10_0])
		end
	end

	self:emit(ClueTasksMediator.ON_TASK_SUBMIT_ONESTEP, self.taskActivityId, var_10_1)

	return
end

function ClueTasksLayer:InitData()
	self.taskActivityId = ActivityConst.Valleyhospital_TASK
	self.taskProxy = getProxy(TaskProxy)
	self.activity = getProxy(ActivityProxy):getActivityById(self.taskActivityId)
	self.config_data = self.activity:getConfig("config_data")

	return
end

function ClueTasksLayer:UpdateList(arg_12_1, arg_12_2, arg_12_3)
	local var_12_0 = arg_12_2:Find("frame")
	local var_12_1 = self.taskProxy:getTaskVO(arg_12_3[arg_12_1 + 1])

	setText(arg_12_2:Find("desc"), var_12_1:getConfig("desc"))

	local var_12_2 = var_12_1:getProgress()
	local var_12_3 = var_12_1:getConfig("target_num")

	setText(arg_12_2:Find("progress"), var_12_2 .. "/" .. var_12_3)
	setSlider(arg_12_2:Find("slider"), 0, var_12_3, var_12_2)
	self:updateAwards(var_12_1:getConfig("award_display"), arg_12_2:Find("awards"), (arg_12_2:GetChild(0)))

	local var_12_4 = arg_12_2:Find("go_btn")
	local var_12_5 = arg_12_2:Find("get_btn")
	local var_12_6 = arg_12_2:Find("got_btn")
	local var_12_7 = var_12_1:getTaskStatus()

	setActive(var_12_4, var_12_7 == 0)
	setActive(var_12_5, var_12_7 == 1)
	setActive(var_12_6, var_12_7 == 2)
	SetActive(arg_12_2:Find("tip"), var_12_7 == 1)
	onButton(self, var_12_5, function()
		self:emit(ClueTasksMediator.ON_TASK_SUBMIT_ONESTEP, self.taskActivityId, {
			var_12_1.id
		})

		return
	end, SFX_PANEL)
	onButton(self, var_12_4, function()
		self:emit(ClueTasksMediator.ON_TASK_GO, var_12_1)

		return
	end, SFX_PANEL)

	return
end

function ClueTasksLayer:updateAwards(arg_15_1, arg_15_2, arg_15_3)
	local var_15_0 = _.slice(arg_15_1, 1, 3)

	for iter_15_0 = arg_15_2.childCount, #var_15_0 - 1 do
		cloneTplTo(arg_15_3, arg_15_2)
	end

	for iter_15_1 = 1, arg_15_2.childCount do
		local var_15_1 = arg_15_2:GetChild(iter_15_1 - 1)
		local var_15_2 = iter_15_1 <= #var_15_0

		setActive(var_15_1, iter_15_1 <= #var_15_0)

		if var_15_2 then
			local var_15_3 = {
				type = var_15_0[iter_15_1][1],
				id = var_15_0[iter_15_1][2],
				count = var_15_0[iter_15_1][3]
			}

			updateDrop(findTF(var_15_1, "mask"), var_15_3)
			onButton(self, var_15_1:Find("mask"), function()
				self:emit(BaseUI.ON_DROP, var_15_3)

				return
			end, SFX_PANEL)
		end
	end

	return
end

return ClueTasksLayer
