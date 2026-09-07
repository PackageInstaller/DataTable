local SenrankaguraMedalScene = class("SenrankaguraMedalScene", import("..base.BaseUI"))
local var_0_1
local var_0_2
local var_0_3 = 4
local var_0_4 = "shan_luan_task_help"
local var_0_5 = "shan_luan_task_help"

function SenrankaguraMedalScene:getUIName()
	return "SenrankaguraMedalUI"
end

function SenrankaguraMedalScene.GetTaskCountAble()
	local var_2_0
	local var_2_1

	if not getProxy(ActivityProxy):getActivityById(ActivityConst.SENRANKAGURA_TASK_ID) then
		do return false end

		var_2_0 = {}
		var_2_1 = 0
	end

	for iter_2_0, iter_2_1 in ipairs(pg.activity_template[ActivityConst.SENRANKAGURA_TASK_ID].config_client.player_task) do
		for iter_2_2, iter_2_3 in ipairs(iter_2_1) do
			table.insert(var_2_0, iter_2_3)
		end
	end

	local function var_2_3(arg_3_0)
		if not arg_3_0 then
			return true
		end

		local var_3_0 = getProxy(TaskProxy):getTaskById(arg_3_0)

		if not var_3_0 and not getProxy(TaskProxy):getFinishTaskById(arg_3_0) then
			return false
		end

		local var_3_1 = pg.task_data_template[arg_3_0].activity_client_config.before

		if var_3_0 and var_3_0:getTaskStatus() <= 0 then
			return false
		end

		return var_2_3(var_3_1)
	end

	for iter_2_4 = 1, #var_2_0 do
		local var_2_4 = getProxy(TaskProxy):getTaskById(var_2_0[iter_2_4])

		if var_2_4 then
			if var_2_4:getTaskStatus() == 1 then
				if not pg.task_data_template[var_2_0[iter_2_4]].activity_client_config.before then
					var_2_1 = var_2_1 + 1
				elseif var_2_3(pg.task_data_template[var_2_0[iter_2_4]].activity_client_config.before) then
					var_2_1 = var_2_1 + 1
				end
			end
		end
	end

	return var_2_1 > 0, var_2_1
end

function SenrankaguraMedalScene:init()
	self.activityId = ActivityConst.SENRANKAGURA_TASK_ID
	self.taskActivity = getProxy(ActivityProxy):getActivityById(self.activityId)
	self.taskIds = pg.activity_template[self.activityId].config_client.player_task
	self.taskCount = 0
	self.allTasksIds = {}

	for iter_4_0, iter_4_1 in ipairs(self.taskIds) do
		self.taskCount = self.taskCount + #iter_4_1

		for iter_4_2, iter_4_3 in ipairs(iter_4_1) do
			table.insert(self.allTasksIds, iter_4_3)
		end
	end

	self.openTaskFlag = self.contextData.task
	self.buffs = pg.activity_template[self.activityId].config_client.buff
	self.ptId = pg.activity_template[self.activityId].config_client.pt_id
	self.ptName = pg.player_resource[self.ptId].name
	self.ptMaxNum = #self.allTasksIds
	var_0_1 = #self.taskIds
	var_0_2 = #self.buffs
	self.taskListDatas = {}

	for iter_4_4 = 1, #self.taskIds do
		local var_4_0 = {}

		for iter_4_5, iter_4_6 in ipairs(self.taskIds[iter_4_4]) do
			self:initTaskListIds(iter_4_6, var_4_0)
		end

		self:sortListDatas(var_4_0)
		table.insert(self.taskListDatas, var_4_0)
	end

	local var_4_1 = findTF(self._tf, "ad")

	self.btnDetail = findTF(var_4_1, "btnDetail")
	self.btnBack = findTF(var_4_1, "frame/btnBack")
	self.btnHelp = findTF(var_4_1, "frame/btnHelp")
	self.btnHome = findTF(var_4_1, "frame/btnHome")
	self.hxTf = findTF(var_4_1, "hx")

	setActive(self.hxTf, PLATFORM_CODE == PLATFORM_CH)
	onButton(self, self.btnDetail, function()
		if self:getMedalGetAble() then
			pg.m02:sendNotification(GAME.ACTIVITY_OPERATION, {
				cmd = 1,
				activity_id = ActivityConst.SENRANKAGURA_MEDAL_ID
			})
		elseif self.taskActivity then
			self:openDetailPane()
		else
			pg.TipsMgr.GetInstance():ShowTips(i18n("challenge_end_tip"))
		end

		return
	end, SOUND_BACK)
	onButton(self, self.btnBack, function()
		self:closeView()

		return
	end, SOUND_BACK)
	onButton(self, self.btnHome, function()
		self:emit(BaseUI.ON_HOME)

		return
	end, SFX_CONFIRM)
	onButton(self, self.btnHelp, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip[var_0_4].tip
		})

		return
	end, SFX_CONFIRM)

	self.btnPlayers = {}

	for iter_4_7 = 1, var_0_1 do
		local var_4_3 = findTF(var_4_1, "player/" .. iter_4_7)

		GetComponent(findTF(var_4_3, "img"), typeof(Image)).alphaHitTestMinimumThreshold = 0.5

		if self.taskActivity then
			onButton(self, var_4_3, function()
				self:openTaskPanel(iter_4_7)

				return
			end, SFX_CONFIRM)
		end

		setActive(findTF(var_4_3, "redTip"), false)
		table.insert(self.btnPlayers, var_4_3)
	end

	local var_4_4 = findTF(self._tf, "pop")

	self.detailPanel = findTF(var_4_4, "detailPanel")

	setActive(self.detailPanel, false)
	self:initDetailPanel()

	self.taskPanel = findTF(var_4_4, "taskPanel")

	setActive(self.taskPanel, false)
	self:initTaskPanel()

	self.submitPanel = findTF(var_4_4, "submitPanel")

	setActive(self.submitPanel, false)
	self:initSubmitPanel()

	return
end

function SenrankaguraMedalScene:didEnter()
	self:updateUI()

	if self.taskActivity and self.openTaskFlag then
		self.openTaskFlag = false

		self:openTaskPanel()
	end

	return
end

function SenrankaguraMedalScene:updateUI()
	local var_11_0 = self:getMedalGetAble()

	setActive(findTF(self.btnDetail, "detail"), not var_11_0 and self.taskActivity)
	setActive(findTF(self.btnDetail, "get"), var_11_0)

	local var_11_1 = getProxy(ActivityProxy):getActivityById(ActivityConst.SENRANKAGURA_MEDAL_ID)
	local var_11_2 = var_11_1:GetPicturePuzzleIds()

	for iter_11_0 = 1, #self.btnPlayers do
		setActive(findTF(self.btnPlayers[iter_11_0], "medal/icon"), table.contains(var_11_1.data2_list, var_11_2[iter_11_0]))
		setActive(findTF(self.btnPlayers[iter_11_0], "img/got"), table.contains(var_11_1.data2_list, var_11_2[iter_11_0]))
	end

	local var_11_3 = getProxy(ActivityProxy):getActivityById(ActivityConst.SENRANKAGURA_MEDAL_ID)

	for iter_11_1 = 1, #var_11_3.data1_list do
		if not false and not table.contains(var_11_3.data2_list, var_11_3.data1_list[iter_11_1]) then
			pg.m02:sendNotification(GAME.MEMORYBOOK_UNLOCK, {
				id = var_11_3.data1_list[iter_11_1],
				actId = var_11_3.id
			})
		end
	end

	if self.taskActivity then
		local var_11_5 = self:getGetAbleTask()
		local var_11_6 = {}

		for iter_11_2 = 1, #self.taskIds do
			for iter_11_3, iter_11_4 in ipairs(self.taskIds[iter_11_2]) do
				if table.contains(var_11_5, iter_11_4) then
					var_11_6[iter_11_2] = not var_11_6[iter_11_2] and 1 or var_11_6[iter_11_2] + 1
				end
			end
		end

		for iter_11_5 = 1, #self.btnPlayers do
			setActive(findTF(self.btnPlayers[iter_11_5], "redTip"), var_11_6[iter_11_5] ~= nil)
		end

		self:updateDetailPanel()
		self:updateTask()
	end

	return
end

function SenrankaguraMedalScene:getMedalGetAble()
	local var_12_0 = getProxy(ActivityProxy):getActivityById(ActivityConst.SENRANKAGURA_MEDAL_ID)

	if #var_12_0.data2_list == #var_12_0:GetPicturePuzzleIds() and var_12_0.data1 ~= 1 then
		return true
	end

	return false
end

function SenrankaguraMedalScene:openDetailPane()
	setActive(self.detailPanel, true)

	return
end

function SenrankaguraMedalScene:initDetailPanel()
	self.detailSlider = findTF(self.detailPanel, "ad/progressSlider")
	self.detailClose = findTF(self.detailPanel, "ad/btnClose")

	onButton(self, findTF(self.detailPanel, "ad/black"), function()
		setActive(self.detailPanel, false)

		return
	end, SOUND_BACK)
	onButton(self, self.detailClose, function()
		setActive(self.detailPanel, false)

		return
	end)

	self.detailProgressTipContent = findTF(self.detailPanel, "ad/progressDetail")
	self.detailProgressTipTpl = findTF(self.detailPanel, "ad/progressDetail/tipTpl")

	setActive(self.detailProgressTipTpl, false)

	local var_14_0 = findTF(self.detailPanel, "ad/progressDetail").sizeDelta.x

	self.medalTfs = {}

	for iter_14_0 = 1, var_0_1 do
		table.insert(self.medalTfs, findTF(self.detailPanel, "ad/medals/" .. iter_14_0))
	end

	for iter_14_1 = 1, var_0_2 do
		local var_14_1 = tf(instantiate(self.detailProgressTipTpl))

		setImageSprite(findTF(var_14_1, "num"), GetSpriteFromAtlas("ui/senrankaguramedalui_atlas", "buff_" .. iter_14_1), true)
		setImageSprite(findTF(var_14_1, "count"), GetSpriteFromAtlas("ui/senrankaguramedalui_atlas", "buff_count_" .. iter_14_1), true)

		var_14_1.anchoredPosition = Vector3(self.buffs[iter_14_1].pt[1] / self.ptMaxNum * var_14_0, 0, 0)

		SetParent(var_14_1, self.detailProgressTipContent)
		SetActive(var_14_1, true)
	end

	self.detailBuffTfs = {}

	for iter_14_2 = 1, var_0_3 do
		table.insert(self.detailBuffTfs, (findTF(self.detailPanel, "ad/buff/" .. iter_14_2)))
	end

	self.detailProgressDesc = findTF(self.detailPanel, "ad/progressDesc")
	self.detailLevelDesc = findTF(self.detailPanel, "ad/levelDesc")

	return
end

function SenrankaguraMedalScene:updateDetailPanel()
	local var_17_0 = self:getPtNum()
	local var_17_1 = self:getBuildLv(var_17_0)
	local var_17_2

	if var_17_1 ~= 0 then
		var_17_2 = self.buffs[var_17_1].benefit
	end

	for iter_17_0 = 1, var_0_3 do
		setText(findTF(self.detailBuffTfs[iter_17_0], "desc"), var_17_2 and pg.benefit_buff_template[var_17_2[iter_17_0]].desc or i18n("shan_luan_task_buff_default"))
	end

	setSlider(self.detailSlider, 0, self.ptMaxNum, var_17_0)

	local var_17_4 = getProxy(ActivityProxy):getActivityById(ActivityConst.SENRANKAGURA_MEDAL_ID)
	local var_17_6 = var_17_4:GetPicturePuzzleIds()

	for iter_17_1 = 1, #self.medalTfs do
		setActive(findTF(self.medalTfs[iter_17_1], "icon"), table.contains(var_17_4.data2_list, var_17_6[iter_17_1]))
	end

	setText(findTF(self.detailProgressDesc, "desc"), i18n("shan_luan_task_progress_tip", self:getTaskCompleteCount() .. "/" .. self.taskCount))
	setText(findTF(self.detailLevelDesc, "desc"), i18n("shan_luan_task_level_tip", "Lv." .. var_17_1))

	return
end

function SenrankaguraMedalScene:getTaskCompleteCount()
	local var_18_0 = 0

	for iter_18_0, iter_18_1 in ipairs((self:getActiveTask())) do
		if self:getTask(iter_18_1):getTaskStatus() == 2 then
			var_18_0 = var_18_0 + 1
		else
			print()
		end
	end

	return var_18_0
end

function SenrankaguraMedalScene:getPtNum()
	local var_19_0 = 0

	var_19_0 = self.ptId and (getProxy(PlayerProxy):getData()[self.ptName] or 0) or getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_BUILDING_BUFF_2):GetBuildingLevelSum()

	if var_19_0 > self.ptMaxNum then
		var_19_0 = self.ptMaxNum
	end

	return var_19_0
end

function SenrankaguraMedalScene:getBuildLv(arg_20_1)
	local var_20_0 = 0

	for iter_20_0 = #self.buffs, 1, -1 do
		var_20_0 = arg_20_1 >= self.buffs[iter_20_0].pt[1] and var_20_0 < iter_20_0 and iter_20_0 or var_20_0
	end

	return var_20_0
end

function SenrankaguraMedalScene:initTaskListIds(arg_21_1, arg_21_2)
	local var_21_1 = pg.task_data_template[arg_21_1].activity_client_config.special or false
	local var_21_2 = {
		id = arg_21_1,
		before = pg.task_data_template[arg_21_1].activity_client_config.before,
		special = var_21_1
	}

	for iter_21_0, iter_21_1 in ipairs(arg_21_2) do
		for iter_21_2, iter_21_3 in ipairs(iter_21_1) do
			if iter_21_3.id == pg.task_data_template[arg_21_1].activity_client_config.before then
				table.insert(iter_21_1, var_21_2)

				return
			elseif iter_21_3.before == arg_21_1 then
				table.insert(iter_21_1, var_21_2)

				return
			end
		end
	end

	table.insert(arg_21_2, {
		var_21_2
	})

	return
end

function SenrankaguraMedalScene:initTaskPanel()
	onButton(self, findTF(self.taskPanel, "ad/frame/btnBack"), function()
		setActive(self.taskPanel, false)

		return
	end, SOUND_BACK)
	onButton(self, findTF(self.taskPanel, "ad/frame/btnHome"), function()
		self:emit(BaseUI.ON_HOME)

		return
	end, SFX_CONFIRM)
	onButton(self, findTF(self.taskPanel, "ad/frame/btnHelp"), function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip[var_0_5].tip
		})

		return
	end, SFX_CONFIRM)

	self.taskTagTfs = {}

	local var_22_0 = findTF(self.taskPanel, "ad/tag/content")
	local var_22_1 = findTF(self.taskPanel, "ad/tag/content/tagTpl")

	setActive(var_22_1, false)

	for iter_22_0 = 1, var_0_1 do
		local var_22_2 = iter_22_0
		local var_22_3 = tf(instantiate(var_22_1))

		setImageSprite(findTF(var_22_3, "icon"), GetSpriteFromAtlas("ui/senrankaguramedalui_atlas", "player_icon_" .. iter_22_0), true)
		SetParent(var_22_3, var_22_0)
		setActive(var_22_3, true)
		table.insert(self.taskTagTfs, var_22_3)
		onButton(self, var_22_3, function()
			self:taskSelectTag(var_22_2, true)

			return
		end, SFX_CONFIRM)
	end

	self.taskButtonTpl = findTF(self.taskPanel, "ad/taskButtonTpl")
	self.taskList = {}

	local var_22_4 = findTF(self.taskPanel, "ad/task/content")

	self.taskDragTf = findTF(self.taskPanel, "ad/task/drag")

	local var_22_5 = findTF(self.taskPanel, "ad/taskTpl")
	local var_22_6 = findTF(self.taskPanel, "ad/taskButtonTpl")

	setActive(var_22_5, false)
	setActive(var_22_6, false)

	self.taskGroups = {}

	for iter_22_1 = 1, var_0_1 do
		local var_22_7 = {}

		for iter_22_2 = 1, #self.taskListDatas[iter_22_1] do
			local var_22_8 = tf(instantiate(var_22_5))

			setParent(var_22_8, var_22_4)
			setActive(var_22_8, true)

			local var_22_9 = {}

			for iter_22_3, iter_22_4 in ipairs(self.taskListDatas[iter_22_1][iter_22_2]) do
				local var_22_10 = tf(instantiate(var_22_6))

				var_22_10.anchoredPosition = Vector2(iter_22_4.pos[1] * 325 + iter_22_4.pos[2] * 90, iter_22_4.pos[2] * 190)

				if iter_22_4.special then
					if iter_22_4.pos[2] ~= 0 then
						setImageSprite(findTF(var_22_10, "get"), GetSpriteFromAtlas("ui/senrankaguramedalui_atlas", "task_get_" .. 4), true)
						setImageSprite(findTF(var_22_10, "got"), GetSpriteFromAtlas("ui/senrankaguramedalui_atlas", "task_got_" .. 4), true)
					else
						setImageSprite(findTF(var_22_10, "get"), GetSpriteFromAtlas("ui/senrankaguramedalui_atlas", "task_get_" .. 2), true)
						setImageSprite(findTF(var_22_10, "got"), GetSpriteFromAtlas("ui/senrankaguramedalui_atlas", "task_got_" .. 2), true)
					end
				elseif not iter_22_4.special and iter_22_4.pos[2] ~= 0 then
					setImageSprite(findTF(var_22_10, "get"), GetSpriteFromAtlas("ui/senrankaguramedalui_atlas", "task_get_" .. 3), true)
					setImageSprite(findTF(var_22_10, "got"), GetSpriteFromAtlas("ui/senrankaguramedalui_atlas", "task_got_" .. 3), true)
				end

				setActive(var_22_10, true)
				SetParent(var_22_10, var_22_8)
				table.insert(var_22_9, {
					tf = var_22_10,
					data = iter_22_4
				})
				onButton(self, var_22_10, function()
					self:openSubmitPanel(iter_22_4)

					return
				end, SFX_CONFIRM)
			end

			var_22_7.listTf = var_22_8
			var_22_7.taskDic = var_22_9
		end

		table.insert(self.taskGroups, var_22_7)
	end

	self.taskButtonTpl = findTF(self.taskPanel, "ad/buttonTpl")
	self.taskBtnGetAll = findTF(self.taskPanel, "ad/btnGetAll")

	onButton(self, self.taskBtnGetAll, function()
		local var_28_0 = self:getGetAbleTask()

		if var_28_0 and #var_28_0 > 0 then
			self:emit(SenrankaguraMedalMediator.SUBMIT_TASK_ALL, var_28_0)
		end

		return
	end, SFX_CONFIRM)

	return
end

function SenrankaguraMedalScene:updateTask()
	for iter_29_0 = 1, #self.taskGroups do
		for iter_29_1, iter_29_2 in ipairs(self.taskGroups[iter_29_0].taskDic) do
			local var_29_0 = self:getTask(iter_29_2.data.id)

			setActive(findTF(iter_29_2.tf, "lock"), false)
			setActive(findTF(iter_29_2.tf, "getAble"), false)
			setActive(findTF(iter_29_2.tf, "get"), false)
			setActive(findTF(iter_29_2.tf, "got"), false)

			if var_29_0 then
				if self:checkTaskBeforeComplete(var_29_0:getConfig("activity_client_config").before) then
					if var_29_0:getTaskStatus() == 0 then
						setActive(findTF(iter_29_2.tf, "get"), true)
					elseif var_29_0:getTaskStatus() == 1 then
						setActive(findTF(iter_29_2.tf, "get"), true)
						setActive(findTF(iter_29_2.tf, "getAble"), true)
					elseif var_29_0:getTaskStatus() == 2 then
						setActive(findTF(iter_29_2.tf, "got"), true)
					end
				else
					setActive(findTF(iter_29_2.tf, "lock"), true)
					setActive(findTF(iter_29_2.tf, "get"), true)
				end
			else
				setActive(findTF(iter_29_2.tf, "lock"), true)
				setActive(findTF(iter_29_2.tf, "get"), true)
			end
		end
	end

	if #self:getGetAbleTask() > 0 then
		setActive(self.taskBtnGetAll, true)
	else
		setActive(self.taskBtnGetAll, false)
	end

	for iter_29_3 = 1, #self.taskGroups do
		for iter_29_4, iter_29_5 in ipairs(self.taskGroups[iter_29_3].taskDic) do
			local var_29_2 = iter_29_5.data.pos
			local var_29_3 = iter_29_5.tf

			setActive(findTF(iter_29_5.tf, "line/back"), false)
			setActive(findTF(var_29_3, "line/bottom"), false)
			setActive(findTF(var_29_3, "line/top"), false)
			var_29_3:SetAsFirstSibling()

			if not iter_29_5.data.before then
				setActive(findTF(var_29_3, "line"), false)
			else
				local var_29_4 = self:getTaskPos(iter_29_5.data.before)
				local var_29_5 = self:getTask(iter_29_5.data.before)
				local var_29_6 = self:checkTaskBeforeComplete(iter_29_5.data.before) and Color.New(0.9921568627450981, 0.9647058823529412, 0.8666666666666667) or Color.New(0.48627450980392156, 0.35294117647058826, 0.2901960784313726)

				if var_29_4[1] < var_29_2[1] then
					setActive(findTF(var_29_3, "line/back"), true)
					setImageColor(findTF(var_29_3, "line/back"), var_29_6)
				elseif var_29_4[2] < var_29_2[2] then
					setActive(findTF(var_29_3, "line/bottom"), true)
					setImageColor(findTF(var_29_3, "line/bottom"), var_29_6)
				else
					setActive(findTF(var_29_3, "line/top"), true)
					setImageColor(findTF(var_29_3, "line/top"), var_29_6)
				end

				setActive(findTF(var_29_3, "line"), true)
			end
		end
	end

	return
end

function SenrankaguraMedalScene:checkTaskBeforeComplete(arg_30_1)
	if not arg_30_1 then
		return true
	end

	local var_30_0 = self:getTaskGroupData(arg_30_1).before
	local var_30_1 = self:getTask(arg_30_1)

	if not var_30_1 then
		return true
	end

	if var_30_1:getTaskStatus() == 0 then
		return false
	end

	if var_30_1:getTaskStatus() >= 1 then
		return self:checkTaskBeforeComplete(var_30_0)
	end

	return true
end

function SenrankaguraMedalScene:getTaskGroupData(arg_31_1)
	for iter_31_0 = 1, #self.taskGroups do
		for iter_31_1, iter_31_2 in ipairs(self.taskGroups[iter_31_0].taskDic) do
			if iter_31_2.data.id == arg_31_1 then
				return iter_31_2.data
			end
		end
	end

	return nil
end

function SenrankaguraMedalScene:getTaskPos(arg_32_1)
	for iter_32_0 = 1, #self.taskGroups do
		for iter_32_1, iter_32_2 in ipairs(self.taskGroups[iter_32_0].taskDic) do
			if iter_32_2.data.id == arg_32_1 then
				return iter_32_2.data.pos
			end
		end
	end

	return nil
end

function SenrankaguraMedalScene:getTask(arg_33_1)
	local var_33_0 = getProxy(TaskProxy)
	local var_33_1 = var_33_0:getTaskById(arg_33_1)

	if var_33_1 then
		return var_33_1
	end

	local var_33_3 = var_33_0:getFinishTaskById(arg_33_1)

	if var_33_3 then
		return var_33_3
	end

	return nil
end

function SenrankaguraMedalScene:getGetAbleTask()
	local var_34_0 = {}
	local var_34_1 = getProxy(TaskProxy)
	local var_34_2 = self:getActiveTask()

	for iter_34_0 = 1, #var_34_2 do
		local var_34_3 = var_34_1:getTaskById(var_34_2[iter_34_0])

		if var_34_3 and var_34_3:getTaskStatus() == 1 then
			table.insert(var_34_0, var_34_3.id)
		end
	end

	return var_34_0
end

function SenrankaguraMedalScene:getActiveTask()
	local var_35_0 = {}

	for iter_35_0 = 1, #self.taskGroups do
		for iter_35_1, iter_35_2 in ipairs(self.taskGroups[iter_35_0].taskDic) do
			if not iter_35_2.data.before then
				table.insert(var_35_0, iter_35_2.data.id)
			elseif self:checkTaskBeforeComplete(iter_35_2.data.before) then
				table.insert(var_35_0, iter_35_2.data.id)
			end
		end
	end

	return var_35_0
end

function SenrankaguraMedalScene:taskSelectTag(arg_36_1, arg_36_2)
	local var_36_0 = 0

	if self.currentSelectIndex then
		var_36_0 = math.abs(self.currentSelectIndex - arg_36_1)
	end

	self.currentSelectIndex = arg_36_1
	self.currentSelectTag = self.taskTagTfs[arg_36_1]
	self.currentTaskDatas = self.taskListDatas[arg_36_1]

	for iter_36_0 = 1, #self.taskTagTfs do
		setActive(findTF(self.taskTagTfs[iter_36_0], "select"), self.currentSelectTag == self.taskTagTfs[iter_36_0])
	end

	self.taskScrollRect = GetComponent(findTF(self.taskPanel, "ad/task"), typeof(ScrollRect))

	local var_36_1 = Vector2(self.taskScrollRect.normalizedPosition.x, self.taskScrollRect.normalizedPosition.y)

	if arg_36_2 then
		if LeanTween.isTweening(go(self._tf)) then
			LeanTween.cancel(go(self._tf))
		end

		LeanTween.value(go(self._tf), self.taskScrollRect.normalizedPosition.y, (var_0_1 - 1 - (arg_36_1 - 1)) / (var_0_1 - 1), 0.3 + var_36_0 * 0.1):setOnUpdate(System.Action_float(function(arg_37_0)
			var_36_1.y = arg_37_0
			self.taskScrollRect.normalizedPosition = var_36_1

			self.taskScrollRect.onValueChanged:Invoke(var_36_1)

			return
		end))
	else
		scrollTo(self.taskScrollRect, 0, (var_0_1 - 1 - (arg_36_1 - 1)) / (var_0_1 - 1))
	end

	return
end

function SenrankaguraMedalScene:openTaskPanel(arg_38_1)
	arg_38_1 = arg_38_1 or 1

	self:taskSelectTag(arg_38_1, false)
	setActive(self.taskPanel, true)

	return
end

function SenrankaguraMedalScene:sortListDatas(arg_39_1)
	local var_39_0

	local function var_39_1(arg_40_0)
		for iter_40_0, iter_40_1 in ipairs(var_39_0) do
			if iter_40_1[1] == arg_40_0[1] and iter_40_1[2] == arg_40_0[2] then
				return false
			end
		end

		return true
	end

	local function var_39_2(arg_41_0, arg_41_1)
		for iter_41_0, iter_41_1 in ipairs(arg_41_1) do
			if iter_41_1.id == arg_41_0 then
				return iter_41_1
			end
		end

		return
	end

	for iter_39_0 = 1, #arg_39_1 do
		var_39_0 = {}

		for iter_39_1 = 1, #arg_39_1[iter_39_0] do
			local var_39_4
			local var_39_5 = arg_39_1[iter_39_0][iter_39_1]

			if not arg_39_1[iter_39_0][iter_39_1].before then
				var_39_4 = {
					0,
					0
				}
			elseif var_39_5.before then
				local var_39_6 = var_39_2(var_39_5.before, arg_39_1[iter_39_0])

				assert(var_39_6, "找不到前置id.." .. var_39_5.before)

				local var_39_7 = var_39_6.pos
				local var_39_8 = {
					var_39_6.pos[1] + 1,
					var_39_6.pos[2]
				}

				for iter_39_2 = 1, 10 do
					if var_39_1(var_39_8) then
						break
					else
						if iter_39_2 == 1 then
							var_39_8[1] = var_39_8[1] - 1
						end

						var_39_8[2] = var_39_8[2] > 0 and var_39_8[2] * -1 or math.abs(var_39_8[2]) + 1

						if var_39_7[2] - var_39_8[2] > 1 then
							var_39_6.pos = {
								var_39_8[1],
								var_39_8[2]
							}
							var_39_8[1] = var_39_8[1] + 1
						end
					end

					assert(iter_39_2 ~= 10, "任务分支超过10个")
				end

				var_39_4 = var_39_8
			end

			var_39_5.pos = var_39_4

			table.insert(var_39_0, var_39_4)
		end
	end

	return
end

function SenrankaguraMedalScene:openSubmitPanel(arg_42_1)
	setActive(self.submitPanel, true)
	setImageSprite(findTF(self.submitPanel, "icon/img"), GetSpriteFromAtlas("ui/senrankaguramedalui_atlas", "player_icon_" .. self.currentSelectIndex), true)

	local var_42_0 = self:getTask(arg_42_1.id)
	local var_42_1 = self:checkTaskBeforeComplete(arg_42_1.before)

	if var_42_0 then
		self.selectTask = var_42_0

		setText(findTF(self.submitPanel, "taskDesc"), var_42_0:getConfig("desc"))
		setText(findTF(self.submitPanel, "img/taskName"), var_42_0:getConfig("name"))
		setText(findTF(self.submitPanel, "progress/taskProgress"), setColorStr(var_42_0:getProgress(), "#C2695B") .. "/" .. setColorStr(var_42_0:getConfig("target_num"), "#9D6B59"))
		self:setSubmitAward((var_42_0:getConfig("award_display")))
		setActive(self.submitGo, var_42_0:getTaskStatus() == 0 or not var_42_1)
		setActive(self.submitGet, var_42_0:getTaskStatus() == 1 and var_42_1)
		setActive(self.submitGot, var_42_0:getTaskStatus() == 2)
	end

	return
end

function SenrankaguraMedalScene:initSubmitPanel()
	self.submitGet = findTF(self.submitPanel, "get")
	self.submitGot = findTF(self.submitPanel, "got")
	self.submitGo = findTF(self.submitPanel, "go")
	self.submitbtnBack = findTF(self.submitPanel, "back")
	self.submitDisplayContent = findTF(self.submitPanel, "itemDisplay/viewport/content")
	self.submitItemTpl = findTF(self.submitPanel, "itemDisplay/viewport/content/item")

	setActive(self.submitItemTpl, false)

	self.submitItemDesc = findTF(self.submitPanel, "itemDesc")
	self.submitItems = {}

	onButton(self, findTF(self.submitPanel, "black"), function()
		setActive(self.submitPanel, false)

		return
	end, SOUND_BACK)
	onButton(self, self.submitbtnBack, function()
		setActive(self.submitPanel, false)

		return
	end, SOUND_BACK)
	onButton(self, self.submitGet, function()
		if self.selectTask then
			self:emit(SenrankaguraMedalMediator.SUBMIT_TASK, self.selectTask.id)
		end

		setActive(self.submitPanel, false)

		return
	end, SOUND_BACK)
	onButton(self, self.submitGo, function()
		setActive(self.submitPanel, false)

		if self.selectTask then
			self:emit(SenrankaguraMedalMediator.TASK_GO, self.selectTask)
		end

		return
	end, SOUND_BACK)
	setText(findTF(self.submitPanel, "bg/txtDesc"), i18n("ryza_task_detail_content"))
	setText(findTF(self.submitPanel, "bg/txtAward"), i18n("ryza_task_detail_award"))

	return
end

function SenrankaguraMedalScene:setSubmitAward(arg_48_1)
	if #self.submitItems < #arg_48_1 then
		for iter_48_0 = 1, #arg_48_1 - #self.submitItems do
			local var_48_0 = tf(instantiate(self.submitItemTpl))

			setParent(var_48_0, self.submitDisplayContent)
			table.insert(self.submitItems, var_48_0)
		end
	end

	for iter_48_1 = 1, #self.submitItems do
		if iter_48_1 <= #arg_48_1 then
			local var_48_1 = {
				type = arg_48_1[iter_48_1][1],
				id = arg_48_1[iter_48_1][2],
				count = arg_48_1[iter_48_1][3]
			}

			updateDrop(self.submitItems[iter_48_1], var_48_1)
			onButton(self, self.submitItems[iter_48_1], function()
				self:emit(BaseUI.ON_DROP, var_48_1)

				return
			end, SFX_PANEL)
			setActive(self.submitItems[iter_48_1], true)
		else
			setActive(self.submitItems[iter_48_1], false)
		end
	end

	return
end

function SenrankaguraMedalScene:willExit()
	if LeanTween.isTweening(go(self._tf)) then
		LeanTween.cancel(go(self._tf))
	end

	return
end

return SenrankaguraMedalScene
