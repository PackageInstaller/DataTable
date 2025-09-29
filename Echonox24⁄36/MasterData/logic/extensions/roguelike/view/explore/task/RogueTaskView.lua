-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/view/explore/task/RogueTaskView.lua

module("logic.extensions.roguelike.view.explore.task.RogueTaskView", package.seeall)

local M = class("RogueTaskView", ViewComponent)
local timeInterval = 20

function M:buildUI()
	self._btnTodayTask = self:getBtn("right_tab_content_-242000516")
	self._btnWeekTask = self:getBtn("right_tab_content_-1578871314")
	self._btnExtraTask = self:getBtn("right_tab_content_1651451756")
	self._btnLimitTimeTask = self:getBtn("right_tab_content_-1691267181")
	self._txtLimitTime1 = self:getText("rungroup_task_main_view_-929438657")
	self._togDayTask = self:getUIComponent("right_tab_content_-242000516", UIComponentType.SpaceXToggle)
	self._weekRedPoint = goutil.findChild(self._btnTodayTask.gameObject, "red_point")
	self._monthRedPoint = goutil.findChild(self._btnWeekTask.gameObject, "red_point")
	self._periodRedPoint = goutil.findChild(self._btnExtraTask.gameObject, "red_point")
	self._panelGo1 = self:getGo("task_main_view_-1109592363")
	self._taskScorll1 = LoopListHelper.New(self:getGo("task_main_view_-366142472"))

	self._taskScorll1:InitListView(0, self._updateTask1Data, self)

	self._taskScorllViewComp = self._taskScorll1:GetLoopListView()
	self._scroll = self:getUIComponent("task_main_view_-366142472", UIComponentType.ScrollRect)
	self._txtDoneNum = self:getText("task_main_view_-418970317")
	self._btnGetAll = self:getBtn("task_main_view_-842882604")
	self._txtTime = self:getText("rungroup_task_main_view_-929438657")
	self._photoCenterPointGo = self:getGo("task_main_view_1907143427")
	self._photoUnit = PhotoUnit.Get(self:getGo("task_main_view_-913050419"))

	self._photoUnit:clear()

	self._btnPhotoUnit = self:getBtn("task_main_view_773524558")
	self._talkGo = self:getGo("dialogue_-1584339662")
	self._txtTalk = self:getText("dialogue_-471327988")
	self._uiglobalTouchTrigger = Astral.UIGlobalTouchTrigger.Get(self.mainGO)
	self._txtDailyTask1 = goutil.findChildTextComponent(self._btnTodayTask.gameObject, "normal/Text1")
	self._txtDailyTask2 = goutil.findChildTextComponent(self._btnTodayTask.gameObject, "select/Text1")
	self._txtWeeklyTask1 = goutil.findChildTextComponent(self._btnWeekTask.gameObject, "normal/Text1")
	self._txtWeeklyTask2 = goutil.findChildTextComponent(self._btnWeekTask.gameObject, "select/Text1")
end

function M:destroyUI()
	self._btnTodayTask = nil
	self._btnWeekTask = nil
	self._btnExtraTask = nil
	self._btnLimitTimeTask = nil
	self._panelGo1 = nil

	self._taskScorll1:Dispose()

	self._taskScorll1 = nil
	self._taskScorllViewComp = nil
	self._scroll = nil
	self._txtDoneNum = nil
	self._btnGetAll = nil
	self._txtTime = nil
	self._togDayTask = nil
end

function M:bindEvents()
	self._btnTodayTask:AddClickListener(self._onClickTodayTask, self)
	self._btnWeekTask:AddClickListener(self._onClickWeekTask, self)
	self._btnExtraTask:AddClickListener(self._onClickExtraTask, self)
	self._btnLimitTimeTask:AddClickListener(self._onClickLimitTimeTask, self)
	self._btnGetAll:AddClickListener(self._onClickGetAll, self)
	GlobalDispatcher:addEventListener(EventType.UPDATA_TASKS, self._onUpdateTask, self)
	GlobalDispatcher:addEventListener(EventType.TASK_TAKE_REWARD_SUC, self._onUpdateTaskReward, self)
	self._uiglobalTouchTrigger:AddGlobalListener(self._onDoClickScreen, self)
	self._btnPhotoUnit:AddClickListener(self._onClickModel, self)
end

function M:unbindEvents()
	self._btnTodayTask:RemoveClickListener()
	self._btnWeekTask:RemoveClickListener()
	self._btnExtraTask:RemoveClickListener()
	self._btnLimitTimeTask:RemoveClickListener()
	self._btnGetAll:RemoveClickListener()
	GlobalDispatcher:removeEventListener(EventType.UPDATA_TASKS, self._onUpdateTask, self)
	GlobalDispatcher:removeEventListener(EventType.TASK_TAKE_REWARD_SUC, self._onUpdateTaskReward, self)
	self._btnPhotoUnit:RemoveClickListener()
	self._uiglobalTouchTrigger:RemoveGlobalListener()
end

function M:onEnter()
	self._itemCell = {}

	IconLoader.bindSpriteAtlas(IconType.DynSpriteAtlas_Task)

	self._remainSeconds = false

	TaskModel.instance:initPointDatByCfg()

	self._selectTaskType = TaskEnum.TaskType.RogueWeekly
	self._curTaskList = false

	self:_initBubble()
	self:_onClickTodayTask()
	RedDotModel.instance:createDotView({
		dotNode = self._weekRedPoint,
		keyList = {
			RedDotType.ERedDotKey.RUNGROUP_WEEK
		}
	})
	RedDotModel.instance:createDotView({
		dotNode = self._monthRedPoint,
		keyList = {
			RedDotType.ERedDotKey.RUNGROUP_MONTH
		}
	})
	RedDotModel.instance:createDotView({
		dotNode = self._periodRedPoint,
		keyList = {
			RedDotType.ERedDotKey.RUNGROUP_PERIOD
		}
	})
end

function M:onEnterFinished()
	return
end

function M:onExit()
	self._togDayTask.IsOn = true

	self:_playItemOpenAni(false)

	for _, shower in pairs(self._itemCell or {}) do
		shower:StopAni()
		shower:setAlpha(0)
	end

	self._itemCell = nil

	self._taskScorll1:ClearCells()

	self._selectTaskType = false
	self._curTaskList = false

	removetimer(self._updateTimer, self)
	goutil.setActive(self._talkGo, false)

	if not string.nilorempty(self._bubbleVoice) then
		CriwareAudioFacade.instance:stopSoundByName(self._bubbleVoice)
	end

	if self._photoUnit then
		self._photoUnit:clear()
	end

	self:_stopBubbleCounter()
	self:_stopCounter()
	IconLoader.unbindSpriteAtlas(IconType.DynSpriteAtlas_Task)
end

function M:_onUpdateTaskReward(key, bubbleType)
	if self._canShowBubble then
		self:showBubble(TaskEnum.BubbleFactor.GetPoint)
	end
end

function M:_onUpdateTask(key, resetPos)
	local tabId = TaskModel.instance:getTabIdByType(self._selectTaskType)
	local hasRewardBox = true

	if hasRewardBox then
		goutil.setActive(self._panelGo1, true)
	else
		goutil.setActive(self._panelGo1, false)
	end

	if tabId then
		self._curTaskList = TaskModel.instance:getTaskList(tabId)

		local tempList = self:_getCanRewardTask()

		goutil.setActive(self._btnGetAll.gameObject, #tempList > 0)

		if hasRewardBox then
			if resetPos then
				self._taskScorll1:ClearCells()
			end

			if self._curTaskList then
				local len = #self._curTaskList

				self._taskScorll1:SetListItemCount(len, resetPos)
			end

			if not resetPos then
				self._taskScorll1:RefreshAllShownItem()
			end

			local count = TaskUtil.getFinishCount(self._curTaskList)

			self._txtDoneNum.text = string.format(lang("tip_r_task_finish"), count)
			self._curPointList = TaskModel.instance:getPointList(tabId)

			if self._curPointList then
				local boxLen = #self._curPointList
			end
		end
	else
		printWarn("cloud not found task tabid with type:", self._selectTaskType)
	end

	self:_initLimitTask()
	RoguelikeModel.instance:checkRedPoint()
end

function getWeekNum()
	t = ServerTime.now()

	local weekNum = os.date("*t", t).wday - 1

	if weekNum == 0 then
		weekNum = 7
	end

	return weekNum
end

function getMonthDay(...)
	local time = ServerTime.now()
	local year = os.date("%Y", time)
	local month = os.date("%m", time) + 1
	local dayAmount = os.date("%d", os.time({
		day = 0,
		year = year,
		month = month
	}))

	return dayAmount
end

function getFutureTime(futureDays, _hour)
	local curTimestamp = ServerTime.now()
	local dayTimestamp = 86400
	local newTime = curTimestamp + dayTimestamp * futureDays
	local newDate = os.date("*t", newTime)

	return os.time({
		year = newDate.year,
		month = newDate.month,
		day = newDate.day,
		hour = _hour,
		minute = newDate.minute,
		second = newDate.second
	})
end

function getLastTime(datetype)
	local curTimestamp = ServerTime.now()
	local nowDate = os.date("*t", curTimestamp)
	local nowDay = nowDate.day
	local result

	if datetype == "TODAY" then
		local newDate = {
			hour = 24,
			second = 0,
			minute = 0,
			year = nowDate.year,
			month = nowDate.month,
			day = nowDate.day
		}

		result = os.time(newDate)
	elseif datetype == "WEEK" then
		local weekNum = 7 - getWeekNum()

		result = getFutureTime(weekNum + 1, 5)
	elseif datetype == "MONTH" then
		local totalDay = getMonthDay()
		local newDate = {
			hour = 5,
			second = 0,
			minute = 0,
			year = nowDate.year,
			month = nowDate.month,
			day = totalDay + 1
		}

		result = os.time(newDate)
	end

	return result - curTimestamp
end

function M:getWeekLastTime()
	return getLastTime("WEEK")
end

function M:_initLimitTask()
	self._limitTaskTime = false

	if self._selectTaskType == TaskEnum.TaskType.RogueWeekly then
		self._limitTaskTime = getLastTime("WEEK")
	elseif self._selectTaskType == TaskEnum.TaskType.RogueMonthly then
		self._limitTaskTime = getLastTime("MONTH")
	end

	if self._limitTaskTime then
		self:_startCounter()
	else
		self:_stopCounter()
	end

	self:_updateTimeView()
end

function M:_onClickTodayTask()
	self._selectTaskType = TaskEnum.TaskType.RogueWeekly

	self:_clickToUpdateTask()
end

function M:_onClickWeekTask()
	self._selectTaskType = TaskEnum.TaskType.RogueMonthly

	self:_clickToUpdateTask()
end

function M:_onClickExtraTask()
	self._selectTaskType = TaskEnum.TaskType.RogueFixed

	self:_clickToUpdateTask()
end

function M:_onClickLimitTimeTask()
	self._selectTaskType = TaskEnum.TaskType.Limited

	self:_clickToUpdateTask()
end

function M:_clickToUpdateTask()
	self._scroll.enabled = false
	self._needPlayItemCellOpenAni = true

	self:_onUpdateTask(nil, true)
	self:_playItemOpenAni(true)
end

function M:_onClickGetAll()
	self:_oneKeyGetAll()
end

function M:_onClickGetAll2()
	self:_oneKeyGetAll()
end

function M:_getCanRewardTask()
	local tempList = {}

	if self._curTaskList then
		for index, taskMo in ipairs(self._curTaskList) do
			if taskMo:canGetReward() and not taskMo:getIsFinish() then
				table.insert(tempList, taskMo:getTaskId())
			end
		end
	end

	return tempList
end

function M:_oneKeyGetAll()
	local tempList = self:_getCanRewardTask()

	if #tempList > 0 then
		RoguelikeAgent.instance:sendTakeRewardRequest(tempList)
	else
		FloatWordMgr.instance:show(lang("tip_task_no_finish_data"))
	end

	if self:_checkBackpackLimit() then
		local dialog = Dialog.showNotifyMessage(lang("tip_title"), lang("tip_warehouse_undercapacity"))

		dialog:setConfirmButtonText(lang("tip_common_sure"))
	end
end

function M:_updateScroeData(curIndex)
	if curIndex < 0 then
		return
	end

	curIndex = curIndex + 1

	local isEven = curIndex % 2 == 0

	if self._curPointList then
		local itemData = self._curPointList[curIndex]

		if itemData then
			local isLast = curIndex == #self._curPointList
			local shower = Astral.LuaComponentContainer.Add(item.gameObject, isEven and TaskPointItem1 or TaskPointItem2)

			shower:setCellData(itemData, curIndex, isLast)
		end
	end

	return item
end

function M:_updateTask1Data(curIndex)
	if curIndex < 0 then
		return
	end

	curIndex = curIndex + 1

	local item = self._taskScorll1:NewListViewItem("rungroup_task_item")

	if self._curTaskList then
		local itemData = self._curTaskList[curIndex]

		if itemData then
			local shower = Astral.LuaComponentContainer.Add(item.gameObject, RogueTaskItem)

			shower:setCellData(itemData, curIndex)
			shower:setGotoClick(self._clickGoto, self)

			self._itemCell[item.gameObject:GetInstanceID()] = shower

			if self._needPlayItemCellOpenAni then
				shower:setAlpha(0)
			else
				shower:setAlpha(1)
				shower:playOpenAni()
			end
		end
	end

	return item
end

function M:_playItemOpenAni(play)
	for _, tweener in ipairs(self._cacheTweenLst or {}) do
		if tweener then
			tweener:Kill(false)
		end
	end

	self._cacheTweenLst = {}

	local minIndex, maxIndex = self._taskScorll1:GetCurShowItemIndexRange()

	if play then
		local index = 1

		for i = minIndex, maxIndex do
			local isLast = i == maxIndex
			local loopItem = self._taskScorllViewComp:GetShownItemByItemIndex(i)

			if loopItem then
				local shower = self._itemCell[loopItem.gameObject:GetInstanceID()]

				shower:StopAni()
				shower:setAlpha(0)

				local delay = index * 0.07

				delay = delay > 1 and 1 or delay

				local tweenDelay = DoTweenUtil.DelayedCall(delay, function()
					shower:playOpenAni()
					shower:setAlpha(1)

					if isLast then
						self._needPlayItemCellOpenAni = false
						self._scroll.enabled = true
					end
				end)

				table.insert(self._cacheTweenLst, tweenDelay)

				index = index + 1
			end
		end

		for _, shower in pairs(self._itemCell or {}) do
			local showerIndex = shower:getIndex() - 1

			if showerIndex < minIndex or maxIndex < showerIndex then
				shower:StopAni()
				shower:setAlpha(1)
			end
		end
	else
		for _, shower in pairs(self._itemCell or {}) do
			shower:setAlpha(1)
		end

		self._cacheTweenLst = nil
		self._needPlayItemCellOpenAni = false
	end
end

function M:_clickGoto()
	self:close()
end

function M:_getNextMonthFirstDay()
	local nowData = ServerTime.nowDate()
	local curTimeTs = ServerTime.now()
	local month = nowData.month + 1

	if nowData.day == 1 and nowData.hour < 5 then
		month = nowData.month
	end

	local nextMonthFirstDayTS = os.time({
		hour = 5,
		min = 0,
		sec = 0,
		day = 1,
		year = nowData.year,
		month = month
	})
	local offset = nextMonthFirstDayTS - curTimeTs

	return offset
end

function M:_getLimitTime(labelCo)
	local canOnLine = false
	local beginT = false
	local endT = false
	local startTime = labelCo.startTime
	local endTime = labelCo.endTime
	local offsetTime = false

	if not string.nilorempty(startTime) then
		beginT = TimeUtil.instance:dateStr2TimeStamp(startTime)
	end

	if not string.nilorempty(endTime) then
		endT = TimeUtil.instance:dateStr2TimeStamp(endTime)
	end

	if beginT then
		if endT then
			if endT > ServerTime.now() and beginT <= ServerTime.now() then
				canOnLine = true
				offsetTime = endT - ServerTime.now()
			end
		elseif beginT <= ServerTime.now() then
			canOnLine = true
		end
	elseif endT then
		if endT > ServerTime.now() then
			canOnLine = true
			offsetTime = endT - ServerTime.now()
		end
	else
		canOnLine = true
	end

	return offsetTime, canOnLine
end

function M:_initBubble()
	local transform = self._photoCenterPointGo.transform
	local cutCenterPos = {
		transform.anchoredPosition.x,
		transform.anchoredPosition.y,
		transform.localScale.x,
		transform.localScale.y
	}
	local modleId = ConstConfig.instance:getNumValueByKey(ConstConfigKeyEnum.TaskModleId)

	goutil.setActive(self._talkGo, false)

	self._bubbleInterval = ConstConfig.instance:getNumValueByKey(ConstConfigKeyEnum.BubbleInterval) or 5
	self._canShowBubble = true
	self._min = ConstConfig.instance:getNumValueByKey(ConstConfigKeyEnum.BubbleMin) or 1
	self._max = ConstConfig.instance:getNumValueByKey(ConstConfigKeyEnum.BubbleMax) or 5
	self._rate = ConstConfig.instance:getNumValueByKey(ConstConfigKeyEnum.BubbleRate) or 1
	self._noClickCount = 0

	self:_startBubbleCounter()
end

function M:_startBubbleCounter()
	self:_stopBubbleCounter()
	Scheduler.addListener(1, self._onBubbleSecond, self, true)
end

function M:_stopBubbleCounter()
	Scheduler.removeListener(self._onBubbleSecond, self)
end

function M:_onBubbleSecond()
	self._noClickCount = self._noClickCount + 1

	if self._noClickCount >= timeInterval then
		self._noClickCount = 0

		self:showBubble(TaskEnum.BubbleFactor.NoAction)
	end
end

function M:showBubble(factor)
	do return end

	self._noClickCount = 0

	local bubbleCo = RoguelikeConfig.instance:getBubbleByFactor(factor)

	self._beginTime = Time.time

	if bubbleCo then
		goutil.setActive(self._talkGo, true)

		local text = bubbleCo.content

		self._txtTalk.text = text
		self._duration = Mathf.Clamp(self._rate * (string.utf8len(text) / 10), self._min, self._max)
		self._canShowBubble = false
		self._bubbleVoice = bubbleCo.voice
		self._oldAction = self._photoUnit:getAnimState()

		if not string.nilorempty(bubbleCo.actionName) then
			self._photoUnit:playOnce(bubbleCo.actionName)
		end

		if not string.nilorempty(self._bubbleVoice) then
			self._duration = -1

			CriwareAudioFacade.instance:playVoiceByName(self._bubbleVoice, nil, self.playVoiceFinish, self)
		end

		settimer(0, self._updateTimer, self)
	end
end

function M:playVoiceFinish()
	self:hideBubble()
end

function M:_updateTimer()
	if not self._beginTime then
		return
	end

	local time = Time.time - self._beginTime

	if self._bubbleInterval and self._bubbleInterval ~= 0 and time >= self._bubbleInterval then
		removetimer(self._updateTimer, self)

		self._canShowBubble = true
	elseif time >= self._duration and self._duration > 0 then
		self:hideBubble()
	end
end

function M:hideBubble()
	self._canShowBubble = true

	goutil.setActive(self._talkGo, false)

	if not string.nilorempty(self._bubbleVoice) then
		CriwareAudioFacade.instance:stopSoundByName(self._bubbleVoice)
	end

	if self._photoUnit then
		local curAction = self._photoUnit:getAnimState()

		if curAction ~= self._oldAction then
			self._photoUnit:play(self._oldAction)
		end
	end

	settimer(0, self._updateTimer, self)
end

function M:_onClickModel()
	return
end

function M:_onDoClickScreen()
	self._noClickCount = 0
end

function M:_startCounter()
	if not self._remainSeconds and not self._limitTaskTime then
		return
	end

	self:_stopCounter()
	Scheduler.addListener(1, self._onSecond, self, true)
end

function M:_stopCounter()
	Scheduler.removeListener(self._onSecond, self)
end

function M:_updateTimeView()
	if self._remainSeconds then
		local content = string.format(lang("tip_r_task_refresh"), self:_getTimeColor(self._remainSeconds), TextFormatter.formatFullTime(self._remainSeconds, true))

		self._txtTime.text = content
	end

	if self._limitTaskTime then
		local tabTime = string.format(lang("tip_r_task_left"), self:_getTimeColor(self._limitTaskTime), TextFormatter.formatFullTime(self._limitTaskTime, true))

		self._txtLimitTime1.text = tabTime
		self._txtTime.text = tabTime
	end

	goutil.setActive(self._txtLimitTime1.gameObject, self._limitTaskTime)
end

function M:_getTimeColor(secound)
	if secound then
		return secound > 3600 and "#FFFFFF" or "#ff3e48"
	end

	return "#FFFFFF"
end

function M:_onSecond()
	if self._remainSeconds then
		self._remainSeconds = self._remainSeconds - 1

		self:_updateTimeView()

		if self._remainSeconds <= 0 then
			self:_stopCounter()

			self._txtTime.text = ""
		end
	end

	if self._limitTaskTime then
		self._limitTaskTime = self._limitTaskTime - 1

		self:_updateTimeView()

		if self._limitTaskTime <= 0 then
			self:_stopCounter()

			self._txtLimitTime1.text = ""
		end
	end
end

function M:_checkBackpackLimit()
	local equipMaxCount = PlayerModel.instance:getBackpackLimit(GameEnum.ItemTypeEnum.EquipItemType, "EquipmentBackpackCapacity")
	local curEquipCount = ItemModel.instance:getItemCountByTS(GameEnum.ItemTypeEnum.EquipItemType, 0)
	local echoMaxCount = PlayerModel.instance:getBackpackLimit(GameEnum.ItemTypeEnum.EchoItemType, "EchoItemBackpackCapacity")
	local curEchoCount = ItemModel.instance:getItemCountByTS(GameEnum.ItemTypeEnum.EchoItemType, 0)

	if equipMaxCount <= curEquipCount or echoMaxCount <= curEchoCount then
		return true
	end

	return false
end

return M
