local HoloLivePtPage = class("HoloLivePtPage", import("...base.BaseActivityPage"))

function HoloLivePtPage:OnInit()
	self.taskProxy = getProxy(TaskProxy)
	self.activityProxy = getProxy(ActivityProxy)
	self.circleTF = self._tf:Find("CircleImg/Circle")
	self.startBtn = self._tf:Find("CircleImg/StartBtn")
	self.helpBtn1 = self._tf:Find("HelpBtn")
	self.taskPanel = self._tf:Find("AD")

	onButton(self, self.startBtn, function()
		if self.isTurning then
			return
		end

		self:emit(ActivityMediator.EVENT_OPERATION, {
			cmd = 1,
			activity_id = self.activity.id
		})

		return
	end, SFX_PANEL)
	onButton(self, self.helpBtn1, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.hololive_goodmorning.tip
		})

		return
	end, SFX_PANEL)

	return
end

function HoloLivePtPage:OnDataSetting()
	self.activityStartTime = self.activity.data1
	self.isGotFinalAward = self.activity.data2
	self.progressStep = self.activity.data3
	self.configID = self.activity:getConfig("config_id")
	self.configData = pg.activity_event_turning[self.configID]
	self.groupNum = self.configData.total_num
	self.maxday = math.clamp(pg.TimeMgr.GetInstance():DiffDay(self.activityStartTime, pg.TimeMgr.GetInstance():GetServerTime()) + 1, 1, self.configData.total_num)

	print("init data on setting:", tostring(self.maxday), tostring(self.isGotFinalAward), tostring(self.progressStep), tostring(self.activity.data4))

	return
end

function HoloLivePtPage:OnFirstFlush()
	self.curIndex = self.activity.data4

	if self.curIndex ~= 0 then
		self.curShipGroupID = self.configData.groupid_list[self.curIndex]
		self.curTaskIDList = self.configData.task_table[self.curIndex]
		self.curStoryID = self.configData.story_list[self.curIndex]
	end

	return
end

function HoloLivePtPage:OnUpdateFlush()
	if self.curIndex == 0 and self.activity.data4 > 0 then
		self.curIndex = self.activity.data4
		self.curShipGroupID = self.configData.groupid_list[self.curIndex]
		self.curTaskIDList = self.configData.task_table[self.curIndex]
		self.curStoryID = self.configData.story_list[self.curIndex]

		print("before rotate", tostring(self.curShipGroupID), tostring(self.curIndex), tostring(self.curStoryID))
		self:rotate()
	elseif self.activity.data4 > 0 then
		if self.activity.data4 <= self.groupNum then
			self.curIndex = self.activity.data4
			self.curShipGroupID = self.configData.groupid_list[self.curIndex]
			self.curTaskIDList = self.configData.task_table[self.curIndex]
			self.curStoryID = self.configData.story_list[self.curIndex]

			print("direct update", tostring(self.curShipGroupID), tostring(self.curIndex), tostring(self.curStoryID))
			self:updateTaskPanel()
		end
	elseif self.activity.data4 == 0 then
		self.curIndex = 0
		self.curShipGroupID = nil
		self.curTaskIDList = nil
		self.curStoryID = nil

		setActive(self.taskPanel, false)

		if self.progressStep > self.groupNum then
			self:lockTurnTable()
		end
	end

	self:checkAward()

	return
end

function HoloLivePtPage:onDestroy()
	LeanTween.cancel(go(self.circleTF))

	return
end

function HoloLivePtPage:rotate()
	self.isTurning = true

	LeanTween.value(go(self.circleTF), 0, 360 - 360 / pg.activity_event_turning[self.activity:getConfig("config_id")].total_num * ({
		6,
		0,
		4,
		2,
		5,
		3,
		1
	})[self.curIndex] + 8 * 360, 4):setEase(LeanTweenType.easeInOutCirc):setOnUpdate(System.Action_float(function(arg_9_0)
		self.circleTF.localEulerAngles = Vector3(0, 0, -arg_9_0)

		return
	end)):setOnComplete(System.Action(function()
		pg.NewStoryMgr.GetInstance():Play(self.curStoryID, function()
			self:updateTaskPanel()

			return
		end, true, true)

		self.isTurning = false

		return
	end))

	return
end

function HoloLivePtPage:updateTaskPanel()
	self.charImg = self.taskPanel:Find("CharImg")
	self.nameImg = self.charImg:Find("NameImg")
	self.dayText = self.taskPanel:Find("ProgressImg/day")
	self.taskItemTpl = self.taskPanel:Find("item")
	self.taskItemContainer = self.taskPanel:Find("items")
	self.backBtn = self.taskPanel:Find("BackBtn")
	self.countText = self.backBtn:Find("RedPoint/Text")
	self.helpBtn2 = self.taskPanel:Find("HelpBtn")

	LoadSpriteAtlasAsync("ui/activityuipage/hololivemorningpage", "img_char_" .. self.curShipGroupID, function(arg_13_0)
		if self.curShipGroupID == 17 then
			rtf(self.charImg).sizeDelta = Vector2(1058, 714)

			setImageSprite(self.charImg, arg_13_0)
		elseif self.curShipGroupID == 19 then
			rtf(self.charImg).sizeDelta = Vector2(1122, 714)

			setImageSprite(self.charImg, arg_13_0)
		elseif self.curShipGroupID == 21 then
			rtf(self.charImg).sizeDelta = Vector2(1044, 714)

			setImageSprite(self.charImg, arg_13_0)
		else
			setImageSprite(self.charImg, arg_13_0, true)
		end

		return
	end)
	LoadSpriteAtlasAsync("ui/activityuipage/hololivemorningpage", "img_name_" .. self.curShipGroupID, function(arg_14_0)
		setImageSprite(self.nameImg, arg_14_0, true)

		return
	end)
	setText(self.dayText, self.progressStep .. "/" .. self.configData.total_num)

	self.taskUIItemList = UIItemList.New(self.taskItemContainer, self.taskItemTpl)

	self.taskUIItemList:make(function(arg_15_0, arg_15_1, arg_15_2)
		if arg_15_0 == UIItemList.EventUpdate then
			local var_15_0 = arg_15_2:Find("item")
			local var_15_1 = self.taskProxy:getTaskById(self.curTaskIDList[arg_15_1 + 1]) or self.taskProxy:getFinishTaskById(self.curTaskIDList[arg_15_1 + 1])

			assert(var_15_1, "without this task by id: " .. self.curTaskIDList[arg_15_1 + 1])

			local var_15_2 = var_15_1:getConfig("award_display")[1]
			local var_15_3 = {
				type = var_15_2[1],
				id = var_15_2[2],
				count = var_15_2[3]
			}

			updateDrop(var_15_0, var_15_3)
			onButton(self, var_15_0, function()
				self:emit(BaseUI.ON_DROP, var_15_3)

				return
			end, SFX_PANEL)

			local var_15_4 = var_15_1:getProgress()
			local var_15_5 = var_15_1:getConfig("target_num")

			setText(arg_15_2:Find("description"), var_15_1:getConfig("desc") .. "(" .. var_15_4 .. "/" .. var_15_5 .. ")")
			setSlider(arg_15_2:Find("progress"), 0, var_15_5, var_15_4)

			local var_15_6 = arg_15_2:Find("go_btn")
			local var_15_7 = arg_15_2:Find("get_btn")
			local var_15_8 = arg_15_2:Find("got_btn")
			local var_15_9 = var_15_1:getTaskStatus()

			setActive(var_15_6, var_15_9 == 0)
			setActive(var_15_7, var_15_9 == 1)
			setActive(var_15_8, var_15_9 == 2)
			onButton(self, var_15_6, function()
				self:emit(ActivityMediator.ON_TASK_GO, var_15_1)

				return
			end, SFX_PANEL)
			onButton(self, var_15_7, function()
				self:emit(ActivityMediator.ON_TASK_SUBMIT, var_15_1)

				return
			end, SFX_PANEL)
		end

		return
	end)
	self.taskUIItemList:align(#self.curTaskIDList)

	local var_12_0 = true

	for iter_12_0, iter_12_1 in ipairs(self.curTaskIDList) do
		if (self.taskProxy:getTaskById(iter_12_1) or self.taskProxy:getFinishTaskById(iter_12_1)):getTaskStatus() ~= 2 then
			var_12_0 = false

			break
		end
	end

	if var_12_0 then
		local var_12_1 = pg.activity_event_turning[self.activity:getConfig("config_id")].story_task[self.progressStep][1]

		print("story", tostring(var_12_1))

		if var_12_1 then
			pg.NewStoryMgr.GetInstance():Play(var_12_1, nil)
		end
	end

	if self.maxday <= self.progressStep then
		var_12_0 = false
	end

	setActive(self.backBtn, var_12_0)

	if var_12_0 then
		setText(self.countText, tostring(self.maxday - self.progressStep))
	end

	setActive(self.taskPanel, true)
	onButton(self, self.backBtn, function()
		self:resetIndex()

		return
	end, SFX_CANCEL)
	onButton(self, self.helpBtn2, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.hololive_goodmorning.tip
		})

		return
	end, SFX_PANEL)

	return
end

function HoloLivePtPage:checkAward()
	if self.isGotFinalAward == 0 and self.progressStep == self.groupNum then
		if self.curTaskIDList then
			local var_21_0 = true

			for iter_21_0, iter_21_1 in ipairs(self.curTaskIDList) do
				if (self.taskProxy:getTaskById(iter_21_1) or self.taskProxy:getFinishTaskById(iter_21_1)):getTaskStatus() ~= 2 then
					var_21_0 = false

					break
				end
			end

			if var_21_0 and self.activity.data4 ~= 0 and self.activity.data3 == self.groupNum then
				self:emit(ActivityMediator.EVENT_OPERATION, {
					cmd = 2,
					activity_id = self.activity.id
				})
			end
		else
			self:emit(ActivityMediator.EVENT_OPERATION, {
				cmd = 1,
				activity_id = self.activity.id
			})
		end
	end

	return
end

function HoloLivePtPage:resetIndex()
	self:emit(ActivityMediator.EVENT_OPERATION, {
		cmd = 2,
		activity_id = self.activity.id
	})

	return
end

function HoloLivePtPage:lockTurnTable()
	self.finalTip = self._tf:Find("FinalTip")
	self.finalLock = self._tf:Find("CircleImg/FinalLock")

	setActive(self.finalTip, true)
	setActive(self.finalLock, true)

	self.tipImg = self._tf:Find("TipImg")

	setActive(self.tipImg, false)

	return
end

return HoloLivePtPage
