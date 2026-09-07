local SenrankaguraTaskPage = class("SenrankaguraTaskPage", import("...base.BaseActivityPage"))

function SenrankaguraTaskPage:OnInit()
	self.taskProxy = getProxy(TaskProxy)
	self.activityProxy = getProxy(ActivityProxy)

	self:findUI()

	return
end

function SenrankaguraTaskPage:OnDataSetting()
	self.configID = self.activity:getConfig("config_id")
	self.configData = pg.activity_event_turning[self.configID]
	self.groupNum = self.configData.total_num

	return
end

function SenrankaguraTaskPage:OnFirstFlush()
	return
end

function SenrankaguraTaskPage:OnUpdateFlush()
	local var_4_0 = self:getCurIndex()

	if self.markClickPos and self.markClickPos > 0 then
		print("有操作再更新任务面板")
		self:openTaskAni()
	elseif var_4_0 > 0 then
		if self.activity.data4 <= self.groupNum then
			print("直接更新任务面板")
			self:updateTaskPanel()
			setActive(self.posPanel, false)
			setActive(self.taskPanel, true)
		end
	elseif var_4_0 == 0 then
		self:updatePosPanel()
		setActive(self.posPanel, true)
		setActive(self.taskPanel, false)

		if self:getStep() > self.groupNum then
			-- block empty
		end
	end

	self:check()
	self:updateLogText()

	return
end

function SenrankaguraTaskPage:onDestroy()
	return
end

function SenrankaguraTaskPage:findUI()
	local var_6_0 = self._tf:Find("IconList")

	self.nameList = {
		"feiniao",
		"banjiu",
		"yan",
		"xuequan",
		"xuebugui",
		"zi",
		"xishao"
	}
	self.paintingList = {
		"asuka",
		"ikaruga",
		"homura",
		"yumi",
		"fubuki",
		"murasaki",
		"yuuyaki"
	}
	self.iconSpriteDict = {}

	for iter_6_0, iter_6_1 in ipairs(self.nameList) do
		local var_6_1 = getImageSprite((var_6_0:Find(iter_6_1)))

		self.iconSpriteDict[iter_6_0] = var_6_1
		self.iconSpriteDict[iter_6_1] = var_6_1
	end

	local var_6_2 = self._tf:Find("HXList")

	self.hxSpriteDict = {}

	for iter_6_2, iter_6_3 in ipairs({
		"feiniao",
		"yan",
		"xuequan",
		"xuebugui",
		"xishao"
	}) do
		self.hxSpriteDict[iter_6_3] = getImageSprite((var_6_2:Find(iter_6_3)))
	end

	self.hxPosDict = {
		feiniao = {
			x = -47,
			y = -7
		},
		yan = {
			x = 24,
			y = -176
		},
		xuequan = {
			x = -92,
			y = -126
		},
		xuebugui = {
			x = 5,
			y = 22
		},
		xishao = {
			x = -86,
			y = -21
		}
	}
	self.paintingPosDict = {
		feiniao = {
			x = 42,
			y = -22
		},
		banjiu = {
			x = 23,
			y = -8
		},
		yan = {
			x = -11,
			y = 20
		},
		xuequan = {
			x = 39,
			y = 30
		},
		xuebugui = {
			x = 26,
			y = 12
		},
		zi = {
			x = 46,
			y = 36
		},
		xishao = {
			x = 20,
			y = -1
		}
	}
	self.posPanel = self._tf:Find("PosPanel")
	self.finalLockTF = self.posPanel:Find("FinalAward/Lock")
	self.finalGotTF = self.posPanel:Find("FinalAward/Got")
	self.posTFList = {}

	local var_6_3 = self.posPanel:Find("PosList")

	for iter_6_4 = 1, #self.nameList do
		local var_6_4 = var_6_3:Find(iter_6_4)

		table.insert(self.posTFList, var_6_4)
		onButton(self, var_6_4:Find("Get"), function()
			local var_7_0 = self:getStep()

			if var_7_0 < self:getCurDayCount() and var_7_0 < self.groupNum then
				self.markClickPos = iter_6_4

				self:selectPos(iter_6_4)
			end

			return
		end, SFX_PANEL)
	end

	self.taskPanel = self._tf:Find("TaskPanel")
	self.paintingTF = self.taskPanel:Find("PaintingPanel/Main/Painting")
	self.paintingHXTF = self.taskPanel:Find("PaintingPanel/Main/HX")
	self.progressTFList = {}

	local var_6_5 = self.taskPanel:Find("Progress")

	for iter_6_5 = 1, #self.nameList do
		self.progressTFList[iter_6_5] = var_6_5:Find(iter_6_5)
	end

	self.taskTFList = {}
	self.taskTFList[1] = self.taskPanel:Find("Task1")
	self.taskTFList[2] = self.taskPanel:Find("Task2")
	self.logText = self._tf:Find("LogText")

	return
end

function SenrankaguraTaskPage:updatePosPanel()
	local var_8_0 = self.activity.data1_list

	for iter_8_0, iter_8_1 in ipairs(self.posTFList) do
		local var_8_1 = var_8_0[iter_8_0] > 0
		local var_8_2 = iter_8_1:Find("Got")

		setImageSprite(var_8_2:Find("Icon"), self.iconSpriteDict[var_8_0[iter_8_0]], true)
		setActive(var_8_2, var_8_1)
	end

	local var_8_3 = self:isGotFinalAward()

	setActive(self.finalGotTF, var_8_3)
	setActive(self.finalLockTF, not var_8_3)

	return
end

function SenrankaguraTaskPage:updateTaskPanel()
	self:updateTaskList()
	self:updateProgress()
	self:updatePainting()

	return
end

function SenrankaguraTaskPage:updateTaskList()
	local var_10_0 = self:getCurTaskIDList()

	for iter_10_0, iter_10_1 in ipairs(self.taskTFList) do
		local var_10_1 = self.taskProxy:getTaskVO(var_10_0[iter_10_0])

		setText(iter_10_1:Find("Desc"), var_10_1:getConfig("desc"))

		local var_10_2 = var_10_1:getProgress()
		local var_10_3 = var_10_1:getConfig("target_num")
		local var_10_4 = iter_10_1:Find("ProgressBar")

		setText(iter_10_1:Find("ProgressText"), var_10_2 .. "/" .. var_10_3)
		setSlider(var_10_4, 0, var_10_3, var_10_2)

		local var_10_5 = var_10_1:getTaskStatus()
		local var_10_6 = iter_10_1:Find("GetBtn")
		local var_10_7 = iter_10_1:Find("GotBtn")
		local var_10_8 = iter_10_1:Find("GoBtn")

		setActive(var_10_8, var_10_5 == 0)
		setActive(var_10_6, var_10_5 == 1)
		setActive(var_10_7, var_10_5 == 2)
		onButton(self, var_10_8, function()
			self:emit(ActivityMediator.ON_TASK_GO, var_10_1)

			return
		end, SFX_PANEL)
		onButton(self, var_10_6, function()
			self:emit(ActivityMediator.ON_TASK_SUBMIT, var_10_1)

			return
		end, SFX_PANEL)

		local var_10_9 = var_10_1:getConfig("award_display")[1]
		local var_10_10 = {
			type = var_10_9[1],
			id = var_10_9[2],
			count = var_10_9[3]
		}
		local var_10_11 = iter_10_1:Find("Icon")

		updateDrop(var_10_11, var_10_10)
		onButton(self, var_10_11, function()
			self:emit(BaseUI.ON_DROP, var_10_10)

			return
		end, SFX_PANEL)

		if self:isFinishedCurTaskList() then
			local var_10_12 = self.configData.story_task[self:getStep()][1]

			print("story", tostring(var_10_12))

			if var_10_12 then
				pg.NewStoryMgr.GetInstance():Play(var_10_12, nil)
			end
		end
	end

	return
end

function SenrankaguraTaskPage:updateProgress()
	local var_14_0 = self:getStep()

	for iter_14_0, iter_14_1 in ipairs(self.progressTFList) do
		local var_14_1 = iter_14_1:Find("Get")
		local var_14_2 = iter_14_1:Find("Doing")

		setActive(iter_14_1:Find("Got"), iter_14_0 < var_14_0)
		setActive(var_14_1, var_14_0 < iter_14_0)
		setActive(var_14_2, iter_14_0 == var_14_0)
	end

	return
end

function SenrankaguraTaskPage:updatePainting()
	local var_15_0 = self:getCurIndex()

	setImageSprite(self.paintingTF, LoadSprite("activitypainting/" .. self.paintingList[var_15_0], self.paintingList[var_15_0]), true)
	setLocalPosition(self.paintingTF, self.paintingPosDict[self.nameList[var_15_0]])

	if PLATFORM_CODE == PLATFORM_CH then
		if self.hxPosDict[self.nameList[var_15_0]] then
			setImageSprite(self.paintingHXTF, self.hxSpriteDict[self.nameList[var_15_0]], true)
			setLocalPosition(self.paintingHXTF, self.hxPosDict[self.nameList[var_15_0]])
			setActive(self.paintingHXTF, true)
		else
			setActive(self.paintingHXTF, false)
		end
	else
		setActive(self.paintingHXTF, false)
	end

	return
end

function SenrankaguraTaskPage:openTaskAni()
	local var_16_0 = self.posTFList[table.indexof(self.activity.data1_list, self:getCurIndex(), 1)]
	local var_16_1 = var_16_0:Find("Get")
	local var_16_2 = var_16_0:Find("Got")

	setImageAlpha(var_16_1, 1)
	setImageAlpha(var_16_2, 0)
	setActive(var_16_1, true)
	setActive(var_16_2, true)
	setActive(var_16_2:Find("Icon"), false)
	var_16_0:SetAsLastSibling()
	self:managedTween(LeanTween.value, nil, go(var_16_0), System.Action_float(function(arg_17_0)
		setImageAlpha(var_16_1, 1 - arg_17_0)
		setImageAlpha(var_16_2, arg_17_0)

		return
	end), 0, 1, 0.5):setOnComplete((System.Action(function()
		local var_18_0 = self.configData.story_list[self:getCurIndex()]

		if var_18_0 then
			pg.NewStoryMgr.GetInstance():Play(var_18_0, function()
				self:updateTaskPanel()
				setActive(self.posPanel, false)
				setActive(self.taskPanel, true)

				return
			end, true, true)
		else
			self:updateTaskPanel()
			setActive(self.posPanel, false)
			setActive(self.taskPanel, true)
		end

		self.markClickPos = nil

		return
	end)))

	self.tweenTF = var_16_0

	return
end

function SenrankaguraTaskPage:check()
	if not self:isGotFinalAward() then
		local var_20_0 = self:getStep()

		if var_20_0 <= self.groupNum and self:getCurTaskIDList() and self:isFinishedCurTaskList() then
			print("清除位置")
			self:resetPos()
		end

		if var_20_0 == self.groupNum and not self:getCurTaskIDList() then
			print("领取最终奖励")
			self:getFinalAward()
		end
	end

	return
end

function SenrankaguraTaskPage:isGotFinalAward()
	return self.activity.data2 > 0
end

function SenrankaguraTaskPage:getStep()
	return self.activity.data3
end

function SenrankaguraTaskPage:getCurIndex()
	return self.activity.data4
end

function SenrankaguraTaskPage:getCurTaskIDList()
	return self.configData.task_table[self:getCurIndex()]
end

function SenrankaguraTaskPage:isFinishedCurTaskList()
	return _.all(self:getCurTaskIDList(), function(arg_26_0)
		return self.taskProxy:getTaskVO(arg_26_0):getTaskStatus() == 2
	end)
end

function SenrankaguraTaskPage:getCurDayCount()
	return pg.TimeMgr.GetInstance():DiffDay(self.activity.data1, (pg.TimeMgr.GetInstance():GetServerTime())) + 1
end

function SenrankaguraTaskPage:getMaxDayCount()
	return (math.clamp(self:getCurDayCount(), 1, self.configData.total_num))
end

function SenrankaguraTaskPage:resetPos()
	self:emit(ActivityMediator.EVENT_OPERATION, {
		cmd = 2,
		activity_id = self.activity.id
	})

	return
end

function SenrankaguraTaskPage:selectPos(arg_30_1)
	self:emit(ActivityMediator.EVENT_OPERATION, {
		cmd = 1,
		activity_id = self.activity.id,
		arg1 = arg_30_1
	})

	return
end

function SenrankaguraTaskPage:getFinalAward()
	self:emit(ActivityMediator.EVENT_OPERATION, {
		cmd = 1,
		activity_id = self.activity.id
	})

	return
end

function SenrankaguraTaskPage:updateLogText()
	local var_32_0 = self.activity:getConfig("config_id")
	local var_32_1 = pg.TimeMgr.GetInstance():DiffDay(self.activity.data1, pg.TimeMgr.GetInstance():GetServerTime()) + 1
	local var_32_2 = ""

	local function var_32_3(arg_33_0)
		var_32_2 = var_32_2 .. arg_33_0 .. "\n"

		return
	end

	var_32_3("开始时间戳：" .. tostring(self.activity.data1))
	var_32_3("是否领取最终奖励：" .. tostring(self.activity.data2))
	var_32_3("当前进度：" .. tostring(self.activity.data3))
	var_32_3("抽到的索引：" .. tostring(self.activity.data4))
	var_32_3("抽到的位置-索引列表：" .. table.concat(self.activity.data1_list, "-"))
	var_32_3("活动开始到现在的天数：" .. tostring(var_32_1))
	var_32_3("活动的最大抽取次数：" .. tostring((math.clamp(var_32_1, 1, pg.activity_event_turning[var_32_0].total_num))))
	var_32_3("配置的总段数：" .. tostring(pg.activity_event_turning[var_32_0].total_num))
	var_32_3("配置的GroupID列表：" .. table.concat(pg.activity_event_turning[var_32_0].groupid_list, "-"))

	if self.activity.data4 > 0 then
		var_32_3("当前的GroupID：" .. tostring(pg.activity_event_turning[var_32_0][self.activity.data4]))
		var_32_3("当前的任务列表：" .. table.concat(pg.activity_event_turning[var_32_0].task_table[self.activity.data4], "-"))
		var_32_3("当前的剧情ID：" .. tostring(pg.activity_event_turning[var_32_0].story_list[self.activity.data4]))
	end

	setText(self.logText, "")
	print("")

	return
end

return SenrankaguraTaskPage
