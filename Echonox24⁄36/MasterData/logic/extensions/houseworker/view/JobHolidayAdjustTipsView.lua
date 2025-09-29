-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/houseworker/view/JobHolidayAdjustTipsView.lua

module("logic.extensions.houseworker.view.JobHolidayAdjustTipsView", package.seeall)

local M = class("JobHolidayAdjustTipsView", ViewComponent)

function M:buildUI()
	self._scheduleTimeItemGo = self:getGo("0&schedule_time_item_1192295968")
	self._scheduleTimeItemView = Astral.LuaComponentContainer.Add(self._scheduleTimeItemGo, HouseScheduleItem)
	self._posHeadPanelGoList = {
		self:getGo("1&role_arrange_item2_-72565010"),
		self:getGo("2&role_arrange_item2_-72565010"),
		self:getGo("3&role_arrange_item2_-72565010")
	}
	self._timeTextList = {}
	self._selectList = {}
	self._clickList = {}
	self._nameTextList = {}
	self._maxTimeGoList = {}
	self._warningTxtList = {}
	self._heroHeadGoList = {}
	self._headViewList = {}

	for i, schedule in ipairs(self._posHeadPanelGoList) do
		self._timeTextList[i] = goutil.findChildTextComponent(schedule, "txtTime")
		self._selectList[i] = goutil.findChild(schedule, "select")
		self._clickList[i] = Astral.ButtonAdapter.GetFrom(schedule, "Click")
		self._nameTextList[i] = goutil.findChildTextComponent(schedule, "txtName")
		self._maxTimeGoList[i] = goutil.findChild(schedule, "Max")
		self._warningTxtList[i] = goutil.findChildTextComponent(schedule, "Max/txtMax")
		self._warningTxtList[i].text = lang("tip_need_vacation")
		self._heroHeadGoList[i] = goutil.findChild(schedule, "hero_adjust_item")
		self._headViewList[i] = Astral.LuaComponentContainer.Add(self._heroHeadGoList[i], HouseWorkHeadCell)

		self._headViewList[i]:setWorkTypeShowStatus(false)
	end

	self._saveBtn = self:getBtn("room_adjust_workforce_tips_649053589")
	self._adjustBtn = self:getBtn("room_adjust_workforce_tips_1801616792")
	self._closeBtn = self:getBtn("room_adjust_workforce_tips_-634889809")
end

function M:destroyUI()
	self._saveBtn = nil
	self._adjustBtn = nil
	self._closeBtn = nil

	self._scheduleTimeItemView:OnDestroy()
end

function M:bindEvents()
	for i, v in ipairs(self._clickList) do
		v:AddClickListener(function()
			self:_onClickSchedulePosition(i)
		end)
	end

	self._saveBtn:AddClickListener(self._onClickSave, self)
	self._adjustBtn:AddClickListener(self._onClickAdjust, self)
	self._closeBtn:AddClickListener(self._onClickClose, self)
end

function M:unbindEvents()
	for i, v in ipairs(self._clickList) do
		v:RemoveClickListener()
	end

	self._saveBtn:RemoveClickListener()
	self._adjustBtn:RemoveClickListener()
	self._closeBtn:RemoveClickListener()

	for scheduleType, click in ipairs(self._clickList) do
		click:RemoveClickListener()
	end
end

function M:onEnter()
	local info = self:getFirstParam()

	self._jobCode = info.jobCode

	self._scheduleTimeItemView:onEnter()

	self._selectSchedulePos = 1

	self._scheduleTimeItemView:setCanEdit(true)
	self._scheduleTimeItemView:setScheduleChangeCallBack(self._onScheduleChange, self)
	self:_initTopHeadList()
	self:_refreshTimeSchedule()
end

function M:_refreshTimeSchedule()
	local schedule = {}

	for i = 1, 24 do
		schedule[i] = 0
	end

	local heroList = {}

	for i = 1, 3 do
		heroList[i] = 0
	end

	local jobDataList = HouseWorkerModel.instance:getScheduleByJob(self._jobCode)

	for i, v in ipairs(jobDataList) do
		heroList[v.index] = v.hero

		for i1, v1 in ipairs(v.schedule) do
			if v1 == HouseEnum.WorkStatus.Work then
				schedule[i1] = i
			end
		end
	end

	self._scheduleTimeItemView:setScheduleList(schedule, heroList)
	self:_onClickSchedulePosition(self._selectSchedulePos)
end

function M:_initTopHeadList()
	local jobDataList = HouseWorkerModel.instance:getScheduleByJob(self._jobCode)

	for i, v in ipairs(jobDataList) do
		local hero = v.hero

		if hero and hero > 0 then
			local heroMO = HeroDepotModel.instance:getHeroInfoByID(hero)

			self._nameTextList[i].text = heroMO:getName()
		else
			self._nameTextList[i].text = string.format("%d号位", i)
		end

		self._headViewList[i]:updatePanel(v)
	end
end

function M:onExit()
	self._scheduleTimeItemView:onExit()
end

function M:_onClickSave()
	HouseAgent.instance:SendSetWorkScheduleRequest(self._jobCode, self._scheduleTimeItemView:getSchedule())
	self:close()
end

function M:_onClickAdjust()
	return
end

function M:_onClickClose()
	self:close()
end

function M:_onClickSchedulePosition(schedulePos)
	self._selectSchedulePos = schedulePos

	self._scheduleTimeItemView:setScheduleType(self._selectSchedulePos)
	self:refreshSchedulePos()
end

function M:refreshSchedulePos()
	for i, select in ipairs(self._selectList) do
		goutil.setActive(select, i == self._selectSchedulePos)
	end
end

function M:_onScheduleChange(workHoursList)
	for i, v in ipairs(workHoursList) do
		self._timeTextList[i].text = string.format("排班:%d/%d小时", v, HouseConfig.instance:getHouseConst("WorkMaxTime").numValue)

		goutil.setActive(self._maxTimeGoList[i], v == HouseConfig.instance:getHouseConst("WorkMaxTime").numValue)
	end
end

return M
