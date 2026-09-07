local IslandTaskPage = class("IslandTaskPage")
local var_0_1 = {
	5,
	6,
	7,
	8
}
local var_0_2 = 4

function IslandTaskPage:Ctor(arg_1_1, arg_1_2, arg_1_3, arg_1_4)
	self.taskPage = arg_1_1
	self.contextData = arg_1_2
	self.taskItemTpl = findTF(arg_1_3, "taskItemTpl")

	setActive(self.taskItemTpl, false)

	self.IconTpl = findTF(arg_1_3, "IconTpl")

	setActive(self.IconTpl, false)

	self._event = arg_1_4
	self.enterTaskId = nil
	self.enterTaskIds = nil

	if self.contextData.task_id then
		self.enterTaskId = self.contextData.task_id or nil
	elseif self.contextData.task_ids then
		self.enterTaskIds = self.contextData.task_ids or nil
	end

	self.activityId = ActivityConst.ISLAND_TASK_ID
	self.hideTask = pg.activity_template[self.activityId].config_client.hide_task or {}
	self.leanTweens = {}
	self.exitFlag = false
	self.btnGetAll = findTF(self.taskPage, "btnGetAll")
	self.taskTagPanel = findTF(self.taskPage, "taskTagPanel")
	self.taskListPanel = findTF(self.taskPage, "taskListPanel")
	self.scrollRect = findTF(self.taskPage, "taskListPanel/Content"):GetComponent("LScrollRect")
	self.taskDetailPanel = findTF(self.taskPage, "taskDetailPanel")
	self.detailTag = findTF(self.taskDetailPanel, "tag")
	self.detailTitleText = findTF(self.taskDetailPanel, "title/text")
	self.detailIcon = findTF(self.taskDetailPanel, "icon/image")
	self.detailDescText = findTF(self.taskDetailPanel, "desc/text")
	self.detaiProgressText = findTF(self.taskDetailPanel, "progress/text")
	self.detailAwardContent = findTF(self.taskDetailPanel, "awardDisplay/viewport/content")
	self.detailBtnGo = findTF(self.taskDetailPanel, "btnGo")
	self.detailBtnGet = findTF(self.taskDetailPanel, "btnGet")
	self.detailBtnSubmit = findTF(self.taskDetailPanel, "btnSubmit")
	self.detailBtnDetail = findTF(self.taskDetailPanel, "btnDetail")
	self.detailActive = findTF(self.taskDetailPanel, "active")

	for iter_1_0 = 1, var_0_2 do
		local var_1_0 = findTF(self.taskTagPanel, "btn" .. iter_1_0)

		if iter_1_0 <= #var_0_1 then
			setText(findTF(var_1_0, "off/text"), i18n(IslandTaskScene.add_tages[var_0_1[iter_1_0]]))
			setText(findTF(var_1_0, "on/text"), i18n(IslandTaskScene.add_tages[var_0_1[iter_1_0]]))
		else
			setActive(var_1_0, false)
		end
	end

	setText(findTF(self.taskDetailPanel, "desc/title"), i18n(IslandTaskScene.ryza_task_detail_content))
	setText(findTF(self.taskDetailPanel, "awardText/txt"), i18n(IslandTaskScene.ryza_task_detail_award))

	self.btnTags = {}

	for iter_1_1 = 1, var_0_2 do
		local var_1_1 = iter_1_1
		local var_1_3 = findTF(self.taskTagPanel, "btn" .. iter_1_1)

		onButton(self._event, var_1_3, function()
			if self.clickIndex then
				setActive(findTF(self.btnTags[self.clickIndex], "on"), false)

				if self.clickIndex == var_1_1 then
					self.clickIndex = nil
				else
					self.clickIndex = var_1_1

					setActive(findTF(self.btnTags[self.clickIndex], "on"), true)
				end
			else
				self.clickIndex = var_1_1

				setActive(findTF(self.btnTags[self.clickIndex], "on"), true)
			end

			if self.clickIndex then
				self.tagId = var_0_1[self.clickIndex] or nil
			end

			self:onClickTag(var_1_1)

			return
		end)
		table.insert(self.btnTags, var_1_3)
	end

	function self.scrollRect.onUpdateItem(arg_3_0, arg_3_1)
		self:onUpdateTaskItem(arg_3_0, arg_3_1)

		return
	end

	self.iconTfs = {}
	self.awards = {}

	onButton(self._event, self.btnGetAll, function()
		self._event:emit(IslandTaskMediator.SUBMIT_TASK_ALL, {
			activityId = self.activityId,
			ids = self.getAllTasks
		})

		return
	end, SOUND_BACK)
	onButton(self._event, self.detailBtnGo, function()
		self._event:emit(IslandTaskMediator.TASK_GO, {
			taskVO = Task.New(self.selectTask)
		})

		return
	end, SOUND_BACK)
	onButton(self._event, self.detailBtnSubmit, function()
		local var_6_0 = self.selectTask:getConfig("type")

		if self.selectTask:getConfig("sub_type") == 1006 then
			self._event:emit(IslandTaskScene.OPEN_SUBMIT, self.selectTask)
		else
			self._event:emit(IslandTaskMediator.SUBMIT_TASK, {
				activityId = self.activityId,
				id = self.selectTask.id
			})
		end

		return
	end, SOUND_BACK)
	onButton(self._event, self.detailBtnGet, function()
		local var_7_0 = self.selectTask:getConfig("type")

		if self.selectTask:getConfig("sub_type") == 1006 then
			self._event:emit(IslandTaskScene.OPEN_SUBMIT, self.selectTask)
		else
			self._event:emit(IslandTaskMediator.SUBMIT_TASK, {
				activityId = self.activityId,
				id = self.selectTask.id
			})
		end

		return
	end, SOUND_BACK)
	onButton(self._event, self.detailBtnDetail, function()
		if self.selectTask then
			local var_8_0 = tonumber(self.selectTask:getConfig("target_id_2"))

			if var_8_0 and var_8_0 > 0 then
				self._event:emit(IslandTaskMediator.SHOW_DETAIL, (AtelierMaterial.New({
					configId = var_8_0,
					count = self.selectTask:getConfig("target_num")
				})))
			end
		end

		return
	end, SOUND_BACK)
	self:updateTask()
	self:onClickTag()

	return
end

function IslandTaskPage:onUpdateTaskItem(arg_9_1, arg_9_2)
	if self.exitFlag then
		return
	end

	self.leanTweens[arg_9_2] = arg_9_2

	table.insert(self.leanTweens, arg_9_2)

	local var_9_0 = GetComponent(arg_9_2, typeof(CanvasGroup))

	var_9_0.alpha = 0

	LeanTween.value(arg_9_2, 0, 1, 0.3):setEase(LeanTweenType.linear):setOnUpdate(System.Action_float(function(arg_10_0)
		var_9_0.alpha = arg_10_0

		return
	end)):setOnComplete(System.Action(function()
		self.leanTweens[arg_9_2] = nil

		return
	end))

	arg_9_1 = arg_9_1 + 1

	local var_9_1 = self.showTasks[arg_9_1]
	local var_9_2 = self.showTasks[arg_9_1].id
	local var_9_3 = self.showTasks[arg_9_1]:getProgress()
	local var_9_4 = self.showTasks[arg_9_1]:getConfig("name")
	local var_9_5 = self.showTasks[arg_9_1]:getConfig("ryza_icon")
	local var_9_6 = self.showTasks[arg_9_1]:isOver()
	local var_9_7 = self.showTasks[arg_9_1]:isFinish()
	local var_9_8 = self.showTasks[arg_9_1]:isCircle()
	local var_9_9 = self.showTasks[arg_9_1]:isDaily()

	setActive(findTF(arg_9_2, "selected"), self.selectIndex == arg_9_1)
	setActive(findTF(arg_9_2, "typeNew"), var_9_1:isNew())
	setActive(findTF(arg_9_2, "typeCircle"), var_9_1:isCircle() or var_9_1:isDaily())
	setActive(findTF(arg_9_2, "finish"), var_9_6)
	setActive(findTF(arg_9_2, "mask"), var_9_6)
	setActive(findTF(arg_9_2, "complete"), not var_9_6 and var_9_7 and not var_9_8)
	setText(findTF(arg_9_2, "desc/text"), setColorStr(shortenString(var_9_4, 10), "#9D6B59"))

	if not var_9_5 or var_9_5 == 0 then
		var_9_5 = "attack"
	end

	setImageSprite(findTF(arg_9_2, "icon/image"), LoadSprite(IslandTaskScene.icon_atlas, var_9_5))
	onButton(self._event, tf(arg_9_2), function()
		if self.selectItem then
			setActive(findTF(self.selectItem, "selected"), false)
			setText(findTF(self.selectItem, "desc/text"), setColorStr(shortenString(self.selectTask:getConfig("name"), 10), "#9D6B59"))
		end

		setActive(findTF(arg_9_2, "selected"), true)
		setText(findTF(arg_9_2, "desc/text"), setColorStr(shortenString(var_9_4, 10), "#5C3E24"))

		self.selectIndex = arg_9_1
		self.selectItem = arg_9_2
		self.selectTask = var_9_1

		self:updateDetail()

		return
	end)

	if arg_9_1 == 1 then
		triggerButton(arg_9_2)

		self.scrollIndex = nil
	end

	if self.enterTaskId ~= nil and self.enterTaskId > 0 then
		if var_9_2 == self.enterTaskId then
			triggerButton(arg_9_2)

			self.enterTaskId = nil
			self.scrollIndex = nil
		end
	elseif self.enterTaskIds and #self.enterTaskIds > 0 then
		for iter_9_0, iter_9_1 in ipairs(self.enterTaskIds) do
			if var_9_2 == iter_9_1 then
				triggerButton(arg_9_2)

				self.enterTaskIds = nil
				self.scrollIndex = nil
			end
		end
	end

	return
end

function IslandTaskPage:updateTask(arg_13_1)
	self.displayTask = {}
	self.allDisplayTask = {}

	local var_13_0 = getProxy(ActivityTaskProxy):getTaskById(self.activityId)

	self.getAllTasks = {}

	for iter_13_0 = 1, #var_13_0 do
		local var_13_1 = var_13_0[iter_13_0]

		if not table.contains(self.hideTask, var_13_0[iter_13_0].id) then
			local var_13_2 = var_13_1:getProgress()
			local var_13_3 = var_13_1:getTarget()
			local var_13_4 = var_13_1:getConfig("ryza_type")

			if not var_13_4 or var_13_4 <= 0 then
				var_13_4 = 999
			end

			local var_13_5 = var_13_1:getConfig("type")

			if var_13_4 > 0 then
				self.displayTask[var_13_4] = self.displayTask[var_13_4] or {}

				table.insert(self.displayTask[var_13_4], var_13_1)
				table.insert(self.allDisplayTask, var_13_1)

				if not var_13_1:isFinish() or var_13_1:isOver() or var_13_1:getConfig("sub_type") == 1006 then
					-- block empty
				else
					table.insert(self.getAllTasks, var_13_0[iter_13_0].id)
				end
			end
		end
	end

	local var_13_6 = getProxy(ActivityProxy):getActivityById(self.activityId)
	local var_13_7 = {}

	if var_13_6 then
		var_13_7 = var_13_6.data1_list
	end

	if var_13_7 and #var_13_7 > 0 then
		for iter_13_1 = 1, #var_13_7 do
			local var_13_8 = ActivityTask.New(self.activityId, {
				progress = 0,
				id = var_13_7[iter_13_1]
			})

			var_13_8:setOver()

			local var_13_9 = var_13_8:getConfig("ryza_type")

			if var_13_9 > 0 then
				self.displayTask[var_13_9] = self.displayTask[var_13_9] or {}

				table.insert(self.displayTask[var_13_9], var_13_8)
				table.insert(self.allDisplayTask, var_13_8)
			end
		end
	end

	local function var_13_10(arg_14_0, arg_14_1)
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
		table.sort(iter_13_3, var_13_10)
	end

	table.sort(self.allDisplayTask, var_13_10)

	if arg_13_1 then
		self:onClickTag()
	end

	if #self.getAllTasks > 0 then
		setActive(self.btnGetAll, true)
	else
		setActive(self.btnGetAll, false)
	end

	return
end

function IslandTaskPage:updateDetail()
	local var_15_0 = self.showTasks[self.selectIndex]:getProgress()
	local var_15_1 = self.showTasks[self.selectIndex].target
	local var_15_2 = pg.task_data_template[self.showTasks[self.selectIndex].id]
	local var_15_3 = self.showTasks[self.selectIndex]:isFinish()
	local var_15_4 = self.showTasks[self.selectIndex]:isOver()
	local var_15_5 = self.showTasks[self.selectIndex]:isCircle()
	local var_15_6 = self.showTasks[self.selectIndex]:isSubmit()

	self.awards = pg.task_data_template[self.showTasks[self.selectIndex].id].award_display

	local var_15_7 = var_15_2.desc
	local var_15_8 = var_15_2.ryza_icon
	local var_15_9 = self.showTasks[self.selectIndex]:getConfig("sub_type")

	if not var_15_2.ryza_icon or var_15_8 == 0 then
		var_15_8 = "attack"
	end

	if not var_15_6 and var_15_1 < var_15_0 then
		var_15_0 = var_15_1
	end

	setText(self.detailDescText, var_15_7)

	if not var_15_4 then
		setText(self.detaiProgressText, setColorStr(var_15_0, "#C2695B") .. " / " .. setColorStr(var_15_1, "#9D6B59"))
	else
		setText(self.detaiProgressText, "--/--")
	end

	setText(self.detailTitleText, shortenString(var_15_2.name, 11))
	setActive(self.detailBtnDetail, var_15_9 == 1006 and not var_15_3 and not var_15_4)
	setActive(self.detailBtnGo, not var_15_4 and not var_15_3 and var_15_9 ~= 1006)
	setActive(self.detailBtnGet, not var_15_4 and var_15_3 and not var_15_6)
	setActive(self.detailBtnSubmit, not var_15_4 and var_15_3 and var_15_6)
	setActive(self.detailActive, not var_15_4 and not var_15_3 and not var_15_5)
	setImageSprite(self.detailIcon, LoadSprite(IslandTaskScene.icon_atlas, var_15_8))

	if #self.iconTfs < #self.awards then
		for iter_15_0 = 1, #self.awards - #self.iconTfs do
			local var_15_10 = tf(Instantiate(self.IconTpl))

			setParent(var_15_10, self.detailAwardContent)
			setActive(var_15_10, true)
			table.insert(self.iconTfs, var_15_10)
		end
	end

	for iter_15_1 = 1, #self.iconTfs do
		if iter_15_1 <= #self.awards then
			local var_15_11 = {
				type = self.awards[iter_15_1][1],
				id = self.awards[iter_15_1][2],
				count = self.awards[iter_15_1][3]
			}

			updateDrop(self.iconTfs[iter_15_1], var_15_11)
			onButton(self._event, self.iconTfs[iter_15_1], function()
				self._event:emit(BaseUI.ON_DROP, var_15_11)

				return
			end, SFX_PANEL)
			setActive(self.iconTfs[iter_15_1], true)
		else
			setActive(self.iconTfs[iter_15_1], false)
		end
	end

	return
end

function IslandTaskPage:onClickTag(arg_17_1)
	if self.tagId and self.tagId > 0 then
		if self.displayTask[self.tagId] and #self.displayTask[self.tagId] > 0 then
			self.showTasks = self.displayTask[self.tagId]
		else
			triggerButton(self.btnTags[arg_17_1])

			return
		end
	else
		self.showTasks = self.allDisplayTask
	end

	if self.enterTaskId and self.enterTaskId > 0 then
		for iter_17_0 = 1, #self.showTasks do
			if self.showTasks[iter_17_0].id == self.enterTaskId then
				self.scrollIndex = iter_17_0
			end
		end
	end

	self.scrollRect:SetTotalCount(#self.showTasks, 0)

	if self.scrollIndex ~= nil then
		self.scrollRect:ScrollTo((self.scrollRect:HeadIndexToValue(self.scrollIndex - 1)))
	end

	return
end

function IslandTaskPage:setActive(arg_18_1)
	setActive(self.taskPage, arg_18_1)

	return
end

function IslandTaskPage:dispose()
	self.exitFlag = true

	if self.leanTweens and #self.leanTweens > 0 then
		for iter_19_0, iter_19_1 in pairs(self.leanTweens) do
			if LeanTween.isTweening(iter_19_1) then
				LeanTween.cancel(iter_19_1)
			end
		end

		self.leanTweens = {}
	end

	for iter_19_2 = 1, #self.allDisplayTask do
		if self.allDisplayTask[iter_19_2]:isNew() then
			self.allDisplayTask[iter_19_2]:changeNew()
		end
	end

	return
end

return IslandTaskPage
