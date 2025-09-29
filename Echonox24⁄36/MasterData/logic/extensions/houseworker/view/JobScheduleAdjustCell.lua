-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/houseworker/view/JobScheduleAdjustCell.lua

module("logic.extensions.houseworker.view.JobScheduleAdjustCell", package.seeall)

local M = class("JobScheduleAdjustCell", CellBaseComponent)
local ButtonAdapter = Astral.ButtonAdapter

function M:ctor(compContainer)
	self._compContainer = compContainer
	self._go = self._compContainer.gameObject
	self._trs = self._go.transform
	self._roleCompList = {}
	self._scheduleList = nil
	self._minuteTimer = SchedulerCtrl.New(self._refreshPerMinute, self)
end

function M:Awake()
	self:onInit()
end

function M:onEnter()
	self._minuteTimer:restart(60, true)
end

function M:onExit()
	self._minuteTimer:stop()
end

function M:onInit()
	self._viewElementsRegistry = ViewElementsRegistry.New(self._go)
	self._jobNameTxt = goutil.findChildTextComponent(self._go, "normal/Content1/txtHint1")
	self._rolePanelGoList = {}
	self._rolePanelGoList[1] = goutil.findChild(self._go, "normal/Content1/roleList/role_arrange_item1")
	self._rolePanelGoList[2] = goutil.findChild(self._go, "normal/Content1/roleList/role_arrange_item2")
	self._rolePanelGoList[3] = goutil.findChild(self._go, "normal/Content1/roleList/role_arrange_item3")
	self._lockGo = goutil.findChild(self._go, "lock")
	self._lockJobTxt = goutil.findChildTextComponent(self._go, "lock/txtCareer")
	self._lockLevelTxt = goutil.findChildTextComponent(self._go, "lock/txtUnlock")
	self._arrangeTimePanelGo = goutil.findChild(self._go, "normal/Content1/scheduleShow")
	self._holidayBtnGo = goutil.findChild(self._go, "normal/Content1/btnHoliday")
	self._shedulePanelGo = goutil.findChild(self._go, "normal/schedule_time_item")
	self._scheduleTimeItemView = Astral.LuaComponentContainer.Add(self._shedulePanelGo, LivingScheduleTimeItemView)
	self._adjustBtn = ButtonAdapter.Get(goutil.findChild(self._go, "normal/schedule_time_item/btnAdjust"))

	self._adjustBtn:AddClickListener(self._onClickAdjustSchedule, self)

	local txtAdjust = goutil.findChildTextComponent(self._adjustBtn.gameObject, "Text")

	txtAdjust.text = lang("tip_adjust_schedule")

	goutil.setActive(self._rolePanelGoList[1], true)
	goutil.setActive(self._rolePanelGoList[2], false)
	goutil.setActive(self._rolePanelGoList[3], false)
	goutil.setActive(self._arrangeTimePanelGo, true)
	goutil.setActive(self._holidayBtnGo, false)
	self:_initSheduleItems()
end

function M:_initSheduleItems()
	self._scheduleList = {}

	local workStatus = HouseEnum.WorkStatus

	self:_AddSheduleItem(workStatus.Sleep, "3&schedule_show_item_-1487730064")
	self:_AddSheduleItem(workStatus.Eat, "4&schedule_show_item_-1487730064")
	self:_AddSheduleItem(workStatus.Work, "5&schedule_show_item_-1487730064")
	self:_AddSheduleItem(workStatus.Rest, "6&schedule_show_item_-1487730064")
end

function M:_AddSheduleItem(workType, key)
	local sheduleItem = {}
	local itemGo = self._viewElementsRegistry:findUIElement(key)
	local sheduleRegistry = ViewElementsRegistry.New(itemGo)

	sheduleItem.timeText = sheduleRegistry:findUIElement("schedule_show_item_1138090368", UIComponentType.Text)
	sheduleItem.selectGo = sheduleRegistry:findUIElement("schedule_show_item_1241143300")
	self._scheduleList[workType] = sheduleItem
end

function M:setData(workerData, workerIndex)
	self._workerCo = workerData
	self._workerIndex = workerIndex
	self._jobNameTxt.text = self._workerCo.jobName

	self:_refreshCell()
	self:_refreshSchedule()
	self:_refreshScheduleStatus()
end

function M:_refreshCell()
	local isUnlock = HouseWorkerModel.instance:getIfJobUnlock(self._workerCo.jobCode)

	goutil.setActive(self._lockGo, not isUnlock)

	if not isUnlock then
		self._lockJobTxt.text = self._workerCo.jobName

		local unlockLevel = HouseWorkerModel.instance:getUnlockConditionByRoomTypeAndIndex(self._workerCo.roomType, self._workerCo.indexInRoom)

		self._lockLevelTxt.text = string.format("%s Lv.%d", self._workerCo.roomName, unlockLevel)
	end

	if not self._roleComp then
		local shower = Astral.LuaComponentContainer.Add(self._rolePanelGoList[1], HouseWorkerRoleCell)

		shower:setJobCodeAndIndex(self._workerCo.jobCode, self._workerIndex)
		shower:setClickCallBack(self._onClickHero, self)
		shower:refreshCell()

		self._roleComp = shower
	else
		self._roleComp:setJobCodeAndIndex(self._workerCo.jobCode, self._workerIndex)
		self._roleComp:refreshCell()
	end
end

function M:_refreshSchedule()
	self._scheduleTimeItemView:needShowTimeIdx(true)
	self._scheduleTimeItemView:showCurShedule(true)
	self._scheduleTimeItemView:onEnter()
	self._scheduleTimeItemView:setCanEdit(false)
	self._scheduleTimeItemView:setUnClickTypeList({
		HouseEnum.WorkStatus.Work
	})

	local jobData = HouseWorkerModel.instance:getScheduleByJobAndIndex(self._workerCo.jobCode, self._workerIndex)

	self._scheduleTimeItemView:setScheduleList(jobData.schedule)

	local timeList = LivingFacilitiesZoneController.instance:getScheduleTimeList(jobData.schedule)

	for i, sheduleItem in ipairs(self._scheduleList) do
		sheduleItem.timeText.text = langF("tip_work_s", timeList[i] or 0)
	end
end

function M:_refreshScheduleStatus()
	local jobData = HouseWorkerModel.instance:getScheduleByJobAndIndex(self._workerCo.jobCode, self._workerIndex)
	local heroId = jobData and jobData.hero
	local hasHero = heroId > 0
	local curWorkStatus

	if hasHero then
		curWorkStatus = HouseSceneUtil.getWorkStatusByHeroId(heroId)
	end

	for workStatus, scheduleItem in pairs(self._scheduleList) do
		goutil.setActive(scheduleItem.selectGo, hasHero and workStatus == curWorkStatus)
	end
end

function M:_onClickHero(jobCode, index)
	local info = {}

	info.jobCode = jobCode
	info.index = index
	info.maxSelectPerson = 3
	info.openType = HouseEnum.OpenType.Job

	GlobalDispatcher:addEventListener(EventType.HOUSE_HERO_SELECT_ENSURE, self._sendJobHeroChangeRequest, self)
	ViewMgr.instance:open(ViewName.JobWorkerSelect, info)
end

function M:_sendJobHeroChangeRequest(_, heroList)
	GlobalDispatcher:removeEventListener(EventType.HOUSE_HERO_SELECT_ENSURE, self._sendJobHeroChangeRequest, self)
	HouseAgent.instance:SendJobHeroChangeRequest(self._workerCo.jobCode, heroList)
end

function M:OnDestroy()
	GlobalDispatcher:removeEventListener(EventType.HOUSE_HERO_SELECT_ENSURE, self._sendJobHeroChangeRequest, self)
	self._adjustBtn:RemoveClickListener()

	self._scheduleList = nil

	self._minuteTimer:clear()

	self._minuteTimer = nil
end

function M:_onClickAdjustSchedule()
	local jobData = HouseWorkerModel.instance:getScheduleByJobAndIndex(self._workerCo.jobCode, self._workerIndex)
	local luaTable = {}

	luaTable.type = 1
	luaTable.data = jobData

	ViewMgr.instance:open(ViewName.LivingAdjustScheduleTip, luaTable)
end

function M:_refreshPerMinute()
	self:_refreshScheduleStatus()
end

return M
