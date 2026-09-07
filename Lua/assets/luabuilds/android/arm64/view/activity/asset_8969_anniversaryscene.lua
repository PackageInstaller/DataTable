local AnniversaryScene = class("AnniversaryScene", import("..base.BaseUI"))

function AnniversaryScene:getUIName()
	return "AnniversaryUI"
end

function AnniversaryScene:setActivity(arg_2_1)
	self.activityVO = arg_2_1
	self.configData = self.activityVO:getConfig("config_data") or {}
	self.date = self.activityVO.data3
	self.currTaskId = self.activityVO.data2

	return
end

function AnniversaryScene:setTaskList(arg_3_1)
	self.taskVOs = arg_3_1

	return
end

function AnniversaryScene:getTaskById(arg_4_1)
	local var_4_0 = -1

	for iter_4_0, iter_4_1 in ipairs(self.configData) do
		for iter_4_2, iter_4_3 in pairs(iter_4_1) do
			if arg_4_1 == iter_4_3 then
				var_4_0 = iter_4_0
			end
		end
	end

	if var_4_0 ~= -1 then
		if var_4_0 < self.date then
			local var_4_1 = Task.New({
				submit_time = 2,
				id = arg_4_1
			})

			var_4_1.progress = var_4_1:getConfig("target_num")

			return var_4_1
		else
			return self.taskVOs[arg_4_1]
		end
	end

	return
end

function AnniversaryScene:init()
	self.backBtn = self._tf:Find("bg/top/back")
	self.mainPanel = self._tf:Find("bg/main")
	self.scrollRect = self.mainPanel:Find("scroll_rect")
	self.taskGorupContainer = self.mainPanel:Find("scroll_rect/content")
	self.taskGorupTpl = self:getTpl("taskGroup", self.taskGorupContainer)
	self.offset = Vector2(self.taskGorupTpl.rect.width / 2 + 30, self.taskGorupTpl.rect.height / 2 + 30)
	self.taskGroupDesc = self.taskGorupContainer:Find("taskGroup_desc")
	self.bottomPanel = self._tf:Find("bg/bottom")
	self.bottomTaskGroups = self.bottomPanel:Find("taskGroups")
	self.bottomBTpl = self:getTpl("bottom_task_tpl", self.bottomTaskGroups)
	self.startPosition = self.taskGorupContainer.localPosition
	self.titles = {}

	return
end

function AnniversaryScene:didEnter()
	onButton(self, self.backBtn, function()
		self:emit(AnniversaryScene.ON_BACK)

		return
	end, SFX_CANCEL)
	self:initScrollRect()

	return
end

local var_0_1 = 2

function AnniversaryScene:getRow(arg_8_1)
	return math.floor(arg_8_1 / var_0_1) * 2 + arg_8_1 % var_0_1
end

function AnniversaryScene:initScrollRect()
	local var_9_0 = self.configData

	self.taskGroupTFs = {}

	for iter_9_0 = 0, self:getRow(#self.configData) - 1 do
		for iter_9_1 = 0, var_0_1 - 1 do
			if iter_9_0 % 2 == 0 == (iter_9_1 % 2 == 0) then
				local var_9_2 = cloneTplTo(self.taskGorupTpl, self.taskGorupContainer)

				var_9_2.localPosition = Vector2(self.offset.x * iter_9_1, self.offset.y * iter_9_0 * -1)

				table.insert(self.taskGroupTFs, var_9_2)
			end
		end
	end

	self:updateTaskGroups()

	self.dateIndex = math.max(self.date, 1)

	self:addVerticalDrag(self.scrollRect, function()
		if self.dateIndex + 1 > #var_9_0 then
			return
		end

		self:moveToTaskGroup(self.dateIndex + 1)

		return
	end, function()
		if self.dateIndex - 1 < 1 then
			return
		end

		self:moveToTaskGroup(self.dateIndex - 1)

		return
	end)
	self:moveToTaskGroup(self.dateIndex, true)
	self:initBottomPanel()

	return
end

function AnniversaryScene:initBottomPanel()
	self.bottomTaskGroupTFs = {}

	for iter_12_0, iter_12_1 in ipairs(self.configData) do
		self.bottomTaskGroupTFs[iter_12_0] = cloneTplTo(self.bottomBTpl, self.bottomTaskGroups)

		self:updateBottomTaskGroup(iter_12_0)
	end

	return
end

function AnniversaryScene:updateBottomTaskGroup(arg_13_1)
	self.bottomTaskGroupTFs[arg_13_1]:GetComponent(typeof(Image)).sprite = GetSpriteFromAtlas("ui/anniversaryui_atlas", "part" .. arg_13_1)
	self.bottomTaskGroupTFs[arg_13_1]:Find("Image"):GetComponent(typeof(Image)).sprite = GetSpriteFromAtlas("ui/anniversaryui_atlas", "h_part" .. arg_13_1)

	triggerToggle(self.bottomTaskGroupTFs[arg_13_1], (_.all(self.configData[arg_13_1], function(arg_14_0)
		local var_14_0 = self:getTaskById(arg_14_0)

		return var_14_0 and var_14_0:isReceive()
	end)))

	return
end

function AnniversaryScene:updateTaskGroups()
	for iter_15_0, iter_15_1 in ipairs(self.configData) do
		if self.taskGroupTFs[iter_15_0] then
			self:updateTaskGroup(self.taskGroupTFs[iter_15_0], iter_15_0, iter_15_1)
		end
	end

	return
end

function AnniversaryScene:updateTaskGroup(arg_16_1, arg_16_2, arg_16_3)
	local var_16_0 = arg_16_1:Find("mask_lock")
	local var_16_1 = arg_16_1:Find("mask_prev_unfinish")

	arg_16_1:Find("icon"):GetComponent(typeof(Image)).sprite = GetSpriteFromAtlas("ui/anniversaryui_atlas", "lihui" .. arg_16_2)

	local var_16_2 = arg_16_2 > self.date
	local var_16_3 = false
	local var_16_4 = false

	if arg_16_2 > self.date then
		local var_16_5 = self.activityVO.data1 + (arg_16_2 - 1) * 0

		var_16_4 = self.activityVO.data1 + (arg_16_2 - 1) * 0 <= pg.TimeMgr.GetInstance():GetServerTime()

		setText(var_16_0:Find("Text"), (pg.TimeMgr.GetInstance():STimeDescC(var_16_5, "%m/%d")))
	else
		var_16_3 = _.all(arg_16_3, function(arg_17_0)
			local var_17_0 = self:getTaskById(arg_17_0)

			return var_17_0 and var_17_0:isReceive()
		end)
	end

	setActive(var_16_0, var_16_2 and not var_16_4)
	setActive(var_16_1, var_16_2 and var_16_4)
	setActive(arg_16_1:Find("completed"), var_16_3)

	return
end

function AnniversaryScene:updateTaskGroupDesc(arg_18_1)
	local var_18_0 = self.configData[arg_18_1]
	local var_18_1 = self.taskGroupDesc:Find("main/desc")

	var_18_1:Find("Image"):GetComponent(typeof(Image)).sprite = self.titles[arg_18_1] and self.titles[arg_18_1] or GetSpriteFromAtlas("ui/anniversaryui_atlas", "title" .. arg_18_1)

	local var_18_4 = self.taskGroupDesc:Find("main/task_list")

	setText(var_18_1, i18n("anniversary_task_title_" .. arg_18_1))

	local function var_18_5(arg_19_0, arg_19_1)
		local var_19_0 = self:getTaskById(arg_19_1) or Task.New({
			id = arg_19_1
		})

		setText(arg_19_0:Find("name"), var_19_0:getConfig("name"))
		setText(arg_19_0:Find("desc"), var_19_0:getConfig("desc"))
		onButton(self, arg_19_0:Find("confirm_btn"), function()
			if var_19_0:isReceive() then
				-- block empty
			elseif not var_19_0:isFinish() then
				self:emit(AnniversaryMediator.TO_TASK, var_19_0)
			elseif var_19_0:isFinish() then
				self:emit(AnniversaryMediator.ON_SUBMIT_TASK, arg_19_1)
			end

			return
		end, SFX_PANEL)
		setActive(arg_19_0:Find("confirm_btn/go"), not var_19_0:isFinish())
		setActive(arg_19_0:Find("confirm_btn/finished"), var_19_0:isReceive())
		setActive(arg_19_0:Find("confirm_btn/get"), var_19_0:isFinish() and not var_19_0:isReceive())

		local var_19_1 = arg_19_0:Find("icon")
		local var_19_2 = var_19_0:getConfig("award_display")[1]

		updateDrop(var_19_1, {
			type = var_19_2[1],
			id = var_19_2[2],
			count = var_19_2[3]
		})
		onButton(self, var_19_1, function()
			local var_21_0

			if var_19_2[1] == DROP_TYPE_RESOURCE then
				var_21_0 = id2ItemId(var_19_2[2])
			elseif var_19_2[1] == DROP_TYPE_ITEM then
				var_21_0 = var_19_2[2]
			end

			if var_21_0 then
				self:emit(AnniversaryScene.ON_ITEM, var_21_0)
			end

			return
		end, SFX_PANEL)

		arg_19_0:Find("slider"):GetComponent(typeof(Slider)).value = var_19_0:getProgress() / var_19_0:getConfig("target_num")

		setText(arg_19_0:Find("slider/Text"), var_19_0:getProgress() .. "/" .. var_19_0:getConfig("target_num"))

		return
	end

	self.ulist = UIItemList.New(var_18_4, (var_18_4:Find("task_tpl")))

	self.ulist:make(function(arg_22_0, arg_22_1, arg_22_2)
		if arg_22_0 == UIItemList.EventUpdate then
			var_18_5(arg_22_2, var_18_0[arg_22_1 + 1])
		end

		return
	end)
	self.ulist:align(#var_18_0)

	return
end

function AnniversaryScene:moveToTaskGroup(arg_23_1, arg_23_2, arg_23_3)
	if arg_23_3 then
		LeanTween.cancel(go(self.taskGroupDesc))
		LeanTween.cancel(go(self.taskGorupContainer))
	elseif LeanTween.isTweening(go(self.taskGroupDesc)) or LeanTween.isTweening(go(self.taskGorupContainer)) then
		return
	end

	local function var_23_0()
		self.dateIndex = arg_23_1

		return
	end

	if arg_23_1 > self.date then
		LeanTween.moveLocal(go(self.taskGorupContainer), Vector3(self.taskGorupContainer.localPosition.x, self.startPosition.y + (self:getRow(arg_23_1) - 1) * self.offset.y, 0), 0.2):setOnComplete(System.Action(var_23_0))

		self.taskGroupDesc.localScale = Vector3(0, 1, 1)
		self.overStep = true

		if self.dateIndex then
			triggerToggle(self.taskGroupTFs[self.dateIndex], false)
		end
	else
		if arg_23_2 or self.overStep then
			self.taskGroupDesc.localScale = Vector3(0, 1, 1)

			self:openAnim(arg_23_1, var_23_0)
			self:updateTaskGroupDesc(arg_23_1)
		elseif self.dateIndex then
			self:closeAnim(self.dateIndex, function()
				self:openAnim(arg_23_1, var_23_0)

				self.dateIndex = arg_23_1

				self:updateTaskGroupDesc(self.dateIndex)

				return
			end)
		end

		self.overStep = nil
	end

	return
end

function AnniversaryScene:openAnim(arg_26_1, arg_26_2)
	local var_26_0 = {}

	assert(arg_26_1, "index can not be nil" .. arg_26_1)

	local var_26_1 = self.taskGroupTFs[arg_26_1]
	local var_26_2 = self.startPosition.y + (self:getRow(arg_26_1) - 1) * self.offset.y
	local var_26_3 = self.taskGorupContainer.localPosition.x

	table.insert(var_26_0, function(arg_27_0)
		LeanTween.moveLocal(go(self.taskGorupContainer), Vector3(var_26_3, var_26_2, 0), 0.2):setOnComplete(System.Action(arg_27_0))

		return
	end)
	table.insert(var_26_0, function(arg_28_0)
		triggerToggle(var_26_1, true)
		LeanTween.rotate(go(var_26_1), Vector3(var_26_1.eulerAngles.x, 0, var_26_1.eulerAngles.z), 0.2):setFrom(Vector3(var_26_1.eulerAngles.x, -180, var_26_1.eulerAngles.z)):setOnComplete(System.Action(arg_28_0))

		return
	end)
	table.insert(var_26_0, function(arg_29_0)
		LeanTween.scale(self.taskGroupDesc, Vector3(1, 1, 1), 0.2):setFrom(Vector3(0, 1, 1)):setOnComplete(System.Action(arg_29_0))

		self.taskGroupDesc.position = var_26_1.position

		self.taskGroupDesc:SetAsLastSibling()
		var_26_1:SetAsLastSibling()

		return
	end)
	seriesAsync(var_26_0, arg_26_2)

	return
end

function AnniversaryScene:closeAnim(arg_30_1, arg_30_2)
	local var_30_0 = {}
	local var_30_1 = self.taskGroupTFs[arg_30_1]

	table.insert(var_30_0, function(arg_31_0)
		LeanTween.scale(self.taskGroupDesc, Vector3(0, 1, 1), 0.2):setFrom(Vector3(1, 1, 1)):setOnComplete(System.Action(arg_31_0))

		return
	end)
	table.insert(var_30_0, function(arg_32_0)
		LeanTween.rotate(go(var_30_1), Vector3(var_30_1.eulerAngles.x, 0, var_30_1.eulerAngles.z), 0.2):setFrom(Vector3(var_30_1.eulerAngles.x, -180, var_30_1.eulerAngles.z)):setOnComplete(System.Action(arg_32_0))

		return
	end)
	table.insert(var_30_0, function(arg_33_0)
		triggerToggle(var_30_1, false)
		arg_33_0()

		return
	end)
	seriesAsync(var_30_0, arg_30_2)

	return
end

function AnniversaryScene:addVerticalDrag(arg_34_1, arg_34_2, arg_34_3)
	local var_34_0 = GetOrAddComponent(arg_34_1, "EventTriggerListener")
	local var_34_1
	local var_34_2 = 0
	local var_34_3 = 50

	var_34_0:AddBeginDragFunc(function()
		var_34_2 = 0
		var_34_1 = nil

		return
	end)
	var_34_0:AddDragFunc(function(arg_36_0, arg_36_1)
		var_34_1 = var_34_1 or arg_36_1.position
		var_34_2 = arg_36_1.position.y - var_34_1.y

		return
	end)
	var_34_0:AddDragEndFunc(function(arg_37_0, arg_37_1)
		if var_34_2 < -var_34_3 then
			if arg_34_3 then
				arg_34_3()
			end
		elseif var_34_2 > var_34_3 and arg_34_2 then
			arg_34_2()
		end

		return
	end)

	return
end

function AnniversaryScene:willExit()
	return
end

return AnniversaryScene
