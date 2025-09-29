-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/livingfacilities/view/LivingAdjustScheduleTipView.lua

module("logic.extensions.livingfacilities.view.LivingAdjustScheduleTipView", package.seeall)

local M = class("LivingAdjustScheduleTipView", ViewComponent)

function M:buildUI()
	self._scheduleTimeItemGo = self:getGo("schedule_time_item_1192295968")
	self._scheduleTimeItemView = Astral.LuaComponentContainer.Add(self._scheduleTimeItemGo, LivingScheduleTimeItemView)

	self._scheduleTimeItemView:needShowTimeIdx(true)

	self._scheduleList = {
		self:getGo("6&schedule_show_item_-1487730064"),
		self:getGo("7&schedule_show_item_-1487730064"),
		self:getGo("8&schedule_show_item_-1487730064"),
		self:getGo("9&schedule_show_item_-1487730064")
	}
	self._timeTextList = {}
	self._selectList = {}
	self._clickList = {}

	for i, schedule in ipairs(self._scheduleList) do
		local timeText = goutil.findChildTextComponent(schedule, "txtScheduleTime")
		local select = goutil.findChild(schedule, "select")
		local clickGo = goutil.findChild(schedule, "Click")
		local click = Astral.UIClickTrigger.Get(clickGo)

		table.insert(self._timeTextList, timeText)
		table.insert(self._selectList, select)
		table.insert(self._clickList, click)

		local maskGO = goutil.findChild(schedule, "imgMask")

		goutil.setActive(maskGO, i == 3)

		local imgColor = i == 3 and "#616161" or "#9B9B9B"
		local imgWorkType = goutil.findChildImageComponent(schedule, "imgWorkType")

		imgWorkType.color = parsecolor(imgColor)

		local txtColor = i == 3 and "#515151" or "#9B9B9B"
		local txtWorkType = goutil.findChildTextComponent(schedule, "txtWorkType")

		txtWorkType.color = parsecolor(txtColor)
	end

	self._headItem = self:getGo("hero_adjust_item_-1292290203")
	self._headItemView = Astral.LuaComponentContainer.Add(self._headItem, HouseWorkHeadCell)

	self._headItemView:setWorkTypeShowStatus(false)

	self._saveBtn = self:getBtn("room_adjust_schedule_view_626796544")
	self._adjustBtn = self:getBtn("room_adjust_schedule_view_-1144333802")
end

function M:destroyUI()
	self._saveBtn = nil
	self._adjustBtn = nil
end

function M:bindEvents()
	self._saveBtn:AddClickListener(self._onClickSave, self)
	self._adjustBtn:AddClickListener(self._onClickAdjust, self)

	for scheduleType, click in ipairs(self._clickList) do
		click:AddClickListener(function()
			self:_onClickScheduleType(scheduleType)
		end, self)
	end
end

function M:unbindEvents()
	self._saveBtn:RemoveClickListener()
	self._adjustBtn:RemoveClickListener()

	for scheduleType, click in ipairs(self._clickList) do
		click:RemoveClickListener()
	end
end

function M:_setEvent(add)
	if add then
		HouseDispatcher:addEventListener(HouseEventType.LIVE_SCHEDULE_REFRESH, self._refreshScheduleView, self)
	else
		HouseDispatcher:removeEventListener(HouseEventType.LIVE_SCHEDULE_REFRESH, self._refreshScheduleView, self)
	end
end

function M:onEnter()
	local luaTable = self:getFirstParam()

	self._dataType = luaTable.type
	self._data = luaTable.data

	self._scheduleTimeItemView:onEnter()
	self:_onClickScheduleType(HouseEnum.WorkStatus.Sleep)
	self._scheduleTimeItemView:setCanEdit(true)

	local schedule

	if self._dataType == 1 then
		schedule = self._data.schedule or {}

		self._headItemView:updatePanel(self._data)
	elseif self._dataType == 2 then
		local scheduleNO = HouseWorkerModel.instance:getScheduleByHeroId(self._data.heroId)

		schedule = scheduleNO.schedule

		local data = {}

		data.hero = self._data.heroId
		data.schedule = schedule

		self._headItemView:updatePanel(data)
	end

	self._scheduleTimeItemView:setScheduleList(schedule)
	self:_refreshScheduleView(nil, schedule)
	self._scheduleTimeItemView:setScheduleModifyCallback(self._onModifySchedule, self)
end

function M:onExit()
	self._scheduleTimeItemView:onExit()
end

function M:_onClickSave()
	local closeView = false
	local schedule = self._scheduleTimeItemView:getScheduleList()

	if not LivingFacilitiesZoneController.instance:judgeRestScheduleMinHours(schedule, true) then
		return
	end

	if self._dataType == 2 then
		LivingFacilitiesAgent.instance:sendSetScheduleRequest(self._data.heroId, schedule)

		closeView = true
	else
		LivingFacilitiesAgent.instance:sendSetRestScheduleRequest(self._data.job, self._data.index, schedule)

		closeView = true
	end

	if closeView then
		self:_onClickClose()
	end
end

function M:_onClickAdjust()
	local resetList = {
		HouseEnum.WorkStatus.Sleep,
		HouseEnum.WorkStatus.Sleep,
		HouseEnum.WorkStatus.Sleep,
		HouseEnum.WorkStatus.Sleep,
		HouseEnum.WorkStatus.Sleep,
		HouseEnum.WorkStatus.Sleep,
		HouseEnum.WorkStatus.Eat,
		HouseEnum.WorkStatus.Eat
	}
	local count = 0
	local schedule = self._scheduleTimeItemView:getScheduleList()

	for i, type in ipairs(schedule) do
		if type ~= HouseEnum.WorkStatus.Work then
			count = count + 1
			schedule[i] = resetList[count] or HouseEnum.WorkStatus.Rest
		end
	end

	self._scheduleTimeItemView:setScheduleList(schedule)
	self:_refreshScheduleView(nil, schedule)
end

function M:_onClickClose()
	self:close()
end

function M:_onClickScheduleType(scheduleType)
	if scheduleType == HouseEnum.WorkStatus.Work then
		FloatWordMgr.instance:show(lang("tip_adjust_work_schedule"))

		return
	end

	self._scheduleType = scheduleType

	self._scheduleTimeItemView:setScheduleType(self._scheduleType)
	self._scheduleTimeItemView:setUnClickTypeList({
		HouseEnum.WorkStatus.Work
	})
	self:_refreshScheduleSelectView()
end

function M:_refreshScheduleSelectView()
	for i, select in ipairs(self._selectList) do
		goutil.setActive(select, i == self._scheduleType)
	end
end

function M:refreshScheduleType()
	for i, select in ipairs(self._selectList) do
		goutil.setActive(select, i == self._scheduleType)
	end
end

function M:_refreshScheduleView(e, schedule)
	local timeList = LivingFacilitiesZoneController.instance:getScheduleTimeList(schedule)

	for i, timeText in ipairs(self._timeTextList) do
		timeText.text = langF("tip_work_s", timeList[i] or 0)
	end
end

function M:_onModifySchedule(scheduleList)
	local typeCount = {}

	for _, type in pairs(scheduleList) do
		if typeCount[type] == nil then
			typeCount[type] = 1
		else
			typeCount[type] = typeCount[type] + 1
		end
	end

	for i, timeText in ipairs(self._timeTextList) do
		timeText.text = langF("tip_work_s", typeCount[i] or 0)
	end
end

return M
