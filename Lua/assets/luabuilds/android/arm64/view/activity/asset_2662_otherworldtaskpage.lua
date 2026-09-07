local OtherWorldTaskPage = class("OtherWorldTaskPage")
local var_0_1 = 3
local var_0_2 = 1
local var_0_3 = "other_world_task_type_daily"
local var_0_4 = "other_world_task_type_main"
local var_0_5 = "other_world_task_type_repeat"
local var_0_6 = "other_world_task_get_all"
local var_0_7 = "other_world_task_go"
local var_0_8 = "other_world_task_got"
local var_0_9 = "other_world_task_get"
local var_0_10 = "other_world_task_tag_main"
local var_0_11 = "other_world_task_tag_daily"
local var_0_12 = "other_world_task_tag_all"

function OtherWorldTaskPage:Ctor(arg_1_1, arg_1_2, arg_1_3, arg_1_4)
	self.taskPage = arg_1_1
	self.contextData = arg_1_2
	self.taskItemTpl = findTF(arg_1_3, "taskItemTpl")
	self.iconTpl = findTF(arg_1_3, "IconTpl")
	self._event = arg_1_4

	setText(findTF(self.taskItemTpl, "btnGo/text"), i18n(var_0_7))
	setText(findTF(self.taskItemTpl, "btnGot/text"), i18n(var_0_8))
	setText(findTF(self.taskItemTpl, "btnGet/text"), i18n(var_0_9))
	setText(findTF(self.taskPage, "leftBtns/btnAll/text"), i18n(var_0_12))
	setText(findTF(self.taskPage, "leftBtns/btnMain/text"), i18n(var_0_10))
	setText(findTF(self.taskPage, "leftBtns/btnDaily/text"), i18n(var_0_11))
	setText(findTF(self.taskPage, "leftBtns/btnAll/text_selected"), i18n(var_0_12))
	setText(findTF(self.taskPage, "leftBtns/btnMain/text_selected"), i18n(var_0_10))
	setText(findTF(self.taskPage, "leftBtns/btnDaily/text_selected"), i18n(var_0_11))
	setText(findTF(self.taskPage, "btnGetAll/text"), i18n(var_0_6))
	setActive(self.taskItemTpl, false)
	setActive(self.iconTpl, false)

	self.enterTaskId = nil
	self.enterTaskIds = nil

	if self.contextData.task_id then
		self.enterTaskId = self.contextData.task_id or nil
	elseif self.contextData.task_ids then
		self.enterTaskIds = self.contextData.task_ids or nil
	end

	self.activityId = ActivityConst.OTHER_WORLD_TASK_ID
	self.hideTask = {}

	if pg.activity_template[self.activityId] then
		self.hideTask = pg.activity_template[self.activityId].config_client.hide_task or {}
	end

	self.btnGetAll = findTF(self.taskPage, "btnGetAll")
	self.taskTagPanel = findTF(self.taskPage, "taskTagPanel")
	self.taskListPanel = findTF(self.taskPage, "taskListPanel")
	self.scrollRect = findTF(self.taskPage, "taskListPanel/Content"):GetComponent("LScrollRect")

	function self.scrollRect.onUpdateItem(arg_2_0, arg_2_1)
		self:onUpdateTaskItem(arg_2_0, arg_2_1)

		return
	end

	self.btnAll = findTF(self.taskPage, "leftBtns/btnAll")
	self.btnDaily = findTF(self.taskPage, "leftBtns/btnDaily")
	self.btnMain = findTF(self.taskPage, "leftBtns/btnMain")

	onButton(self._event, self.btnAll, function()
		self:clearTagBtn()
		setActive(findTF(self.btnAll, "bg_selected"), true)
		setActive(findTF(self.btnAll, "text_selected"), true)
		setActive(findTF(self.btnAll, "text"), false)
		setImageColor(findTF(self.btnAll, "bg"), Color.New(1, 0.9882352941176471, 0.9098039215686274, 1))
		self:showTaskByType()

		return
	end, SFX_CONFIRM)
	onButton(self._event, self.btnDaily, function()
		self:clearTagBtn()
		setActive(findTF(self.btnDaily, "bg_selected"), true)
		setActive(findTF(self.btnDaily, "text_selected"), true)
		setActive(findTF(self.btnDaily, "text"), false)
		setImageColor(findTF(self.btnDaily, "bg"), Color.New(1, 0.9882352941176471, 0.9098039215686274, 1))
		self:showTaskByType(var_0_1)

		return
	end, SFX_CONFIRM)
	onButton(self._event, self.btnMain, function()
		self:clearTagBtn()
		setActive(findTF(self.btnMain, "bg_selected"), true)
		setActive(findTF(self.btnMain, "text_selected"), true)
		setActive(findTF(self.btnMain, "text"), false)
		setImageColor(findTF(self.btnMain, "bg"), Color.New(1, 0.9882352941176471, 0.9098039215686274, 1))
		self:showTaskByType(var_0_2)

		return
	end, SFX_CONFIRM)
	onButton(self._event, self.btnGetAll, function()
		self._event:emit(OtherWorldTaskMediator.SUBMIT_TASK_ALL, {
			activityId = self.activityId,
			ids = self.getAllTasks
		})

		return
	end, SFX_CONFIRM)

	self.iconTfs = {}
	self.awards = {}

	self:updateTask()
	triggerButton(self.btnAll, true)

	return
end

function OtherWorldTaskPage:showTaskByType(arg_7_1)
	self.tagType = arg_7_1
	self.showTasks = {}

	if arg_7_1 then
		for iter_7_0, iter_7_1 in ipairs(self.allDisplayTask) do
			if iter_7_1:getConfig("priority_type") == arg_7_1 then
				table.insert(self.showTasks, iter_7_1)
			end
		end
	else
		self.showTasks = self.allDisplayTask
	end

	if self.enterTaskId and self.enterTaskId > 0 then
		for iter_7_2 = 1, #self.showTasks do
			if self.showTasks[iter_7_2].id == self.enterTaskId then
				self.scrollIndex = iter_7_2
			end
		end
	end

	self.scrollRect:SetTotalCount(#self.showTasks, 0)

	if self.scrollIndex ~= nil then
		self.scrollRect:ScrollTo((self.scrollRect:HeadIndexToValue(self.scrollIndex - 1)))
	end

	return
end

function OtherWorldTaskPage:clearTagBtn()
	setActive(findTF(self.btnAll, "bg_selected"), false)
	setActive(findTF(self.btnDaily, "bg_selected"), false)
	setActive(findTF(self.btnMain, "bg_selected"), false)
	setActive(findTF(self.btnMain, "text_selected"), false)
	setActive(findTF(self.btnDaily, "text_selected"), false)
	setActive(findTF(self.btnAll, "text_selected"), false)
	setActive(findTF(self.btnMain, "text"), true)
	setActive(findTF(self.btnDaily, "text"), true)
	setActive(findTF(self.btnAll, "text"), true)
	setImageColor(findTF(self.btnMain, "bg"), Color.New(0.7372549019607844, 0.6352941176470588, 0.5882352941176471, 1))
	setImageColor(findTF(self.btnDaily, "bg"), Color.New(0.7372549019607844, 0.6352941176470588, 0.5882352941176471, 1))
	setImageColor(findTF(self.btnAll, "bg"), Color.New(0.7372549019607844, 0.6352941176470588, 0.5882352941176471, 1))

	return
end

function OtherWorldTaskPage:onUpdateTaskItem(arg_9_1, arg_9_2)
	if self.exitFlag then
		return
	end

	arg_9_1 = arg_9_1 + 1

	local var_9_0 = self.showTasks[arg_9_1]
	local var_9_1 = self.showTasks[arg_9_1].id
	local var_9_2 = self.showTasks[arg_9_1]:getProgress()
	local var_9_3 = self.showTasks[arg_9_1]:getConfig("ryza_icon")
	local var_9_4 = self.showTasks[arg_9_1]:isOver()
	local var_9_5 = self.showTasks[arg_9_1]:isFinish()
	local var_9_6 = self.showTasks[arg_9_1]:getTarget()
	local var_9_7 = self.showTasks[arg_9_1]:isCircle()
	local var_9_8 = self.showTasks[arg_9_1]:isDaily()
	local var_9_9 = self.showTasks[arg_9_1]:isSubmit()
	local var_9_10 = self.showTasks[arg_9_1]:getConfig("sub_type")
	local var_9_11 = self.showTasks[arg_9_1]:getConfig("type")
	local var_9_12 = self.showTasks[arg_9_1]:getConfig("priority_type")

	setScrollText(findTF(arg_9_2, "desc/text"), (self.showTasks[arg_9_1]:getConfig("desc")))

	if PLATFORM_CODE ~= PLATFORM_CH then
		-- block empty
	end

	if not var_9_4 then
		setText(findTF(arg_9_2, "progressDesc/text"), setColorStr(var_9_2, "#51382E") .. " / " .. setColorStr(var_9_6, "#51382E"))
	else
		setText(findTF(arg_9_2, "progressDesc/text"), "--/--")
	end

	setSlider(findTF(arg_9_2, "progressBar"), 0, 1, var_9_4 and 1 or var_9_2 / var_9_6)

	local var_9_13 = findTF(arg_9_2, "awardDisplay/viewport/content")

	if var_9_13.childCount < #pg.task_data_template[var_9_1].award_display then
		for iter_9_0 = 1, #pg.task_data_template[var_9_1].award_display - var_9_13.childCount do
			local var_9_14 = tf(Instantiate(self.iconTpl))

			setParent(var_9_14, var_9_13)
			setActive(var_9_14, true)
		end
	end

	for iter_9_1 = 1, var_9_13.childCount do
		local var_9_15 = var_9_13:GetChild(iter_9_1 - 1)

		if iter_9_1 <= #pg.task_data_template[var_9_1].award_display then
			local var_9_16 = {
				type = pg.task_data_template[var_9_1].award_display[iter_9_1][1],
				id = pg.task_data_template[var_9_1].award_display[iter_9_1][2],
				count = pg.task_data_template[var_9_1].award_display[iter_9_1][3]
			}

			updateDrop(var_9_15, var_9_16)
			onButton(self._event, var_9_15, function()
				self._event:emit(BaseUI.ON_DROP, var_9_16)

				return
			end, SFX_PANEL)
			setActive(var_9_15, true)
		else
			setActive(var_9_15, false)
		end
	end

	setActive(findTF(arg_9_2, "btnGo"), not var_9_4 and not var_9_5 and var_9_10 ~= 1006)
	setActive(findTF(arg_9_2, "btnGet"), not var_9_4 and var_9_5 and not var_9_9)
	setActive(findTF(arg_9_2, "btnGot"), var_9_5)
	setSlider(findTF(arg_9_2, "progressBar"), 0, 1, var_9_2 / var_9_6)
	setText(findTF(arg_9_2, "tag/text"), i18n(var_9_12 == var_0_1 and (var_9_11 == 16 and var_9_10 == 20 and var_0_5 or var_0_3) or var_0_4))
	onButton(self._event, findTF(arg_9_2, "btnGo"), function()
		self._event:emit(OtherWorldTaskMediator.TASK_GO, {
			taskVO = var_9_0
		})

		return
	end, SFX_CONFIRM)
	onButton(self._event, findTF(arg_9_2, "btnGet"), function()
		local var_12_0 = var_9_0:getConfig("priority_type")
		local var_12_1 = var_9_0:getConfig("sub_type")

		self._event:emit(OtherWorldTaskMediator.SUBMIT_TASK, {
			activityId = self.activityId,
			id = var_9_0.id
		})

		return
	end, SFX_CONFIRM)

	if arg_9_1 == 1 then
		self.scrollIndex = nil
	end

	if self.enterTaskId ~= nil and self.enterTaskId > 0 then
		if var_9_1 == self.enterTaskId then
			self.enterTaskId = nil
			self.scrollIndex = nil
		end
	elseif self.enterTaskIds and #self.enterTaskIds > 0 then
		for iter_9_2, iter_9_3 in ipairs(self.enterTaskIds) do
			if var_9_1 == iter_9_3 then
				self.enterTaskIds = nil
				self.scrollIndex = nil
			end
		end
	end

	return
end

function OtherWorldTaskPage:updateTask(arg_13_1)
	self.displayTask = {}
	self.allDisplayTask = {}

	local var_13_0 = getProxy(ActivityTaskProxy):getTaskById(self.activityId)

	self.getAllTasks = {}

	for iter_13_0 = 1, #var_13_0 do
		if not table.contains(self.hideTask, var_13_0[iter_13_0].id) then
			local var_13_1 = var_13_0[iter_13_0]:getProgress()
			local var_13_2 = var_13_0[iter_13_0]:getTarget()
			local var_13_3 = var_13_0[iter_13_0]:getConfig("priority_type")

			self.displayTask[var_13_3] = self.displayTask[var_13_3] or {}

			table.insert(self.displayTask[var_13_3], var_13_0[iter_13_0])
			table.insert(self.allDisplayTask, var_13_0[iter_13_0])

			if var_13_0[iter_13_0]:isFinish() and not var_13_0[iter_13_0]:isOver() then
				table.insert(self.getAllTasks, var_13_0[iter_13_0].id)
			end
		end
	end

	local var_13_4 = getProxy(ActivityProxy):getActivityById(self.activityId)
	local var_13_5 = {}

	if var_13_4 then
		var_13_5 = var_13_4.data1_list
	end

	if var_13_5 and #var_13_5 > 0 then
		for iter_13_1 = 1, #var_13_5 do
			local var_13_6 = ActivityTask.New(self.activityId, {
				progress = 0,
				id = var_13_5[iter_13_1]
			})

			var_13_6:setOver()

			local var_13_7 = var_13_6:getConfig("ryza_type")

			if var_13_7 > 0 then
				self.displayTask[var_13_7] = self.displayTask[var_13_7] or {}

				table.insert(self.displayTask[var_13_7], var_13_6)
				table.insert(self.allDisplayTask, var_13_6)
			end
		end
	end

	local function var_13_8(arg_14_0, arg_14_1)
		if arg_14_0:isOver() and not arg_14_1:isOver() then
			return false
		elseif not arg_14_0:isOver() and arg_14_1:isOver() then
			return true
		end

		if arg_14_0:isFinish() and not arg_14_1:isFinish() then
			return true
		elseif not arg_14_0:isFinish() and arg_14_1:isFinish() then
			return false
		end

		local var_14_0 = arg_14_0:getConfig("priority_type")
		local var_14_1 = arg_14_1:getConfig("priority_type")

		if var_14_0 == var_0_2 and var_14_1 == var_0_1 then
			return true
		elseif var_14_0 == var_0_1 and var_14_1 == var_0_2 then
			return false
		end

		if arg_14_0:isNew() and not arg_14_1:isNew() then
			return true
		elseif not arg_14_0:isNew() and arg_14_1:isNew() then
			return false
		end

		if arg_14_0.id > arg_14_1.id then
			return false
		elseif arg_14_0.id < arg_14_1.id then
			return true
		end

		return
	end

	for iter_13_2, iter_13_3 in pairs(self.displayTask) do
		table.sort(iter_13_3, var_13_8)
	end

	table.sort(self.allDisplayTask, var_13_8)

	if arg_13_1 then
		self:showTaskByType(self.tagType)
	end

	if #self.getAllTasks > 0 then
		setActive(self.btnGetAll, true)
	else
		setActive(self.btnGetAll, false)
	end

	return
end

function OtherWorldTaskPage:setActive(arg_15_1)
	setActive(self.taskPage, arg_15_1)

	return
end

function OtherWorldTaskPage:dispose()
	self.exitFlag = true

	for iter_16_0 = 1, #self.allDisplayTask do
		if self.allDisplayTask[iter_16_0]:isNew() then
			self.allDisplayTask[iter_16_0]:changeNew()
		end
	end

	return
end

return OtherWorldTaskPage
