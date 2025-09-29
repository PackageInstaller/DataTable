-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/houseworker/view/JobScheduleAdjustTipsView.lua

module("logic.extensions.houseworker.view.JobScheduleAdjustTipsView", package.seeall)

local M = class("JobScheduleAdjustTipsView", ViewComponent)

function M:buildUI()
	self._scheduleTimeItemGo = self:getGo("0&schedule_time_item_1192295968")
	self._scheduleTimeItemView = Astral.LuaComponentContainer.Add(self._scheduleTimeItemGo, HouseScheduleItem)

	self._scheduleTimeItemView:needShowTimeIdx(true)

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
	self._heroHeadGoList = {}
	self._headViewList = {}
	self._moodCell = {}

	for i, schedule in ipairs(self._posHeadPanelGoList) do
		self._timeTextList[i] = goutil.findChildTextComponent(schedule, "lay/txtTime")
		self._selectList[i] = goutil.findChild(schedule, "select")
		self._clickList[i] = Astral.ButtonAdapter.GetFrom(schedule, "Click")
		self._nameTextList[i] = goutil.findChildTextComponent(schedule, "txtName")
		self._maxTimeGoList[i] = goutil.findChild(schedule, "lay/max")
		self._heroHeadGoList[i] = goutil.findChild(schedule, "hero_adjust_item")
		self._headViewList[i] = Astral.LuaComponentContainer.Add(self._heroHeadGoList[i], HouseWorkHeadCell)

		self._headViewList[i]:setWorkTypeShowStatus(false)

		self._moodCell[i] = Astral.LuaComponentContainer.Add(goutil.findChild(schedule, "mood"), HouseHeroMoodCell)
	end

	self._saveBtn = self:getBtn("room_adjust_workforce_view_-1104293914")
	self._adjustBtn = self:getBtn("room_adjust_workforce_view_-203393045")
end

function M:destroyUI()
	self._saveBtn = nil
	self._adjustBtn = nil

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
end

function M:unbindEvents()
	for i, v in ipairs(self._clickList) do
		v:RemoveClickListener()
	end

	self._saveBtn:RemoveClickListener()
	self._adjustBtn:RemoveClickListener()

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
		local moodVisible = false
		local hero = v.hero

		if hero and hero > 0 then
			local heroMO = HeroDepotModel.instance:getHeroInfoByID(hero)

			self._nameTextList[i].text = heroMO:getName()

			local heroFeatureMo = HeroHouseFeatureModel.instance:getFeatureMO(hero)

			if heroFeatureMo then
				self._moodCell[i]:updateMood(heroFeatureMo:getMood())

				moodVisible = true
			end
		else
			self._nameTextList[i].text = string.format(lang("tip_job_schedule_adjust_1"), i)
		end

		self._headViewList[i]:updatePanel(v)
		self._moodCell[i]:setVisible(moodVisible)
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
	local jobDataList = HouseWorkerModel.instance:getScheduleByJob(self._jobCode)
	local maxMood = HouseConfig.instance:getHouseConst("MoodMax").numValue
	local maxWorkTime = HouseConfig.instance:getHouseConst("WorkMaxTime").numValue
	local tempJobTimeList = {
		maxWorkTime,
		maxWorkTime,
		maxWorkTime
	}

	for i, v in ipairs(jobDataList) do
		local hero = v.hero

		if hero and hero > 0 then
			local heroFeatureMo = HeroHouseFeatureModel.instance:getFeatureMO(hero)

			if heroFeatureMo then
				local cost = heroFeatureMo:getMoodCost()
				local recover = heroFeatureMo:getMoodRecover()

				tempJobTimeList[i] = math.min(math.floor(24 * recover / (recover + cost)), maxMood / cost, maxWorkTime)
			end
		end
	end

	local jobTimeList = {
		0,
		0,
		0
	}
	local index = 1
	local count = 0

	for round = 1, 24 do
		for index = 1, 3 do
			if round <= tempJobTimeList[index] and count < 24 then
				jobTimeList[index] = jobTimeList[index] + 1
				count = count + 1
			end
		end
	end

	for i = 1, 3 do
		printWarn(jobTimeList[i])
	end

	local schedule = {}

	for i = 1, 3 do
		for j = 1, jobTimeList[i] do
			table.insert(schedule, i)
		end
	end

	if #schedule < 24 then
		for i = #schedule, 23 do
			table.insert(schedule, 0)
		end
	end

	self._scheduleTimeItemView:updateScheduleList(schedule)
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
	local maxTime = HouseConfig.instance:getHouseConst("WorkMaxTime").numValue

	for i, v in ipairs(workHoursList) do
		self._timeTextList[i].text = string.format(lang("tip_job_schedule_adjust_2"), v, maxTime)

		goutil.setActive(self._maxTimeGoList[i], v == maxTime)
	end
end

return M
