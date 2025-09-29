-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/houseworker/model/HouseWorkerModel.lua

module("logic.extensions.houseworker.model.HouseWorkerModel", package.seeall)

local M = class("HouseWorkerModel", BaseModel)
local WorkStatus = HouseEnum.WorkStatus

function M:ctor()
	M.super.ctor(self)
end

function M:onInit()
	local data = HouseConfig.instance:getConfigList(ConfigName.HouseWorker)

	self._roomConfigList = {}

	for i, v in ipairs(data) do
		if not self._roomConfigList[v.houseIndex] then
			self._roomConfigList[v.houseIndex] = {
				v
			}
		else
			table.insert(self._roomConfigList[v.houseIndex], v)
		end
	end

	for k, v in pairs(self._roomConfigList) do
		table.sort(v, function(configA, configB)
			return configA.jobCode < configB.jobCode
		end)
	end

	self._filterIdxs = {}

	self:onReset()
end

function M:onReset()
	self._jobSchedule = {}

	table.clear(self._filterIdxs)
	HouseAgent.instance:_onReset()
end

function M:getKey(job, index)
	return tonumber(string.format("%02d%02d", job, index))
end

function M:initJobScheduleByAgent(scheduleList)
	for i, jobConfigList in ipairs(self._roomConfigList) do
		for i1, jobConfig in ipairs(jobConfigList) do
			for positionIndex = 1, 3 do
				local schedule = {}

				schedule.roomId = jobConfig.zoneId
				schedule.job = jobConfig.jobCode
				schedule.index = positionIndex
				schedule.hero = 0
				schedule.schedule = HouseConfig.instance:getHouseConst("defaultSchedule" .. positionIndex).numValues
				schedule.bunk = 0

				local key = self:getKey(schedule.job, schedule.index)

				self._jobSchedule[key] = schedule
			end
		end
	end

	for i, v in ipairs(scheduleList) do
		if not v.hero then
			v.hero = 0
		end

		local key = self:getKey(v.job, v.index)

		self._jobSchedule[key] = v
	end
end

function M:updateJobScheduleByChangeHero(schedule)
	for i, v in ipairs(schedule) do
		if not v.hero then
			v.hero = 0
		end

		local key = self:getKey(v.job, v.index)

		self._jobSchedule[key].hero = v.hero
	end
end

function M:updateJobScheduleBySetSchedule(schedule)
	for i, v in ipairs(schedule) do
		local key = self:getKey(v.job, v.index)

		for i1, v1 in ipairs(v.schedule) do
			self._jobSchedule[key].schedule[i1] = v1
		end
	end
end

function M:updateScheduleByHeroScheduleChange(hero, schedule)
	local jobSchedule = self:getScheduleByHeroId(hero)

	for i, v in pairs(schedule) do
		jobSchedule.schedule[i] = v
	end
end

function M:updateScheduleByWorkerScheduleChange(job, index, schedule)
	local key = self:getKey(job, index)

	for i, v in ipairs(schedule) do
		self._jobSchedule[key].schedule[i] = v
	end
end

function M:updateJobSchedule(schedule)
	for i, v in ipairs(schedule) do
		if not v.hero then
			v.hero = 0
		end

		local key = self:getKey(v.job, v.index)

		self._jobSchedule[key] = v
	end

	local sceneFlow = SceneFace.instance:getCurSceneFlow()

	sceneFlow.unitMgr:updatePlayerUnit()
end

function M:getScheduleByJob(job)
	local list = {}

	for i, v in pairs(self._jobSchedule) do
		if v.job == job then
			table.insert(list, v)
		end
	end

	table.sort(list, function(scheduleA, scheduleB)
		return scheduleA.index < scheduleB.index
	end)

	return list
end

function M:getScheduleByJobAndIndex(job, index)
	for i, v in pairs(self._jobSchedule) do
		if v.job == job and v.index == index then
			return v
		end
	end

	return false
end

function M:getScheduleByJobAndIndexAndRoomId(job, index, roomId)
	for i, v in pairs(self._jobSchedule) do
		if v.job == job and v.index == index and v.roomId == roomId then
			return v
		end
	end

	return false
end

function M:getScheduleIndexByJobAndIndex(job, index)
	for i, v in pairs(self._jobSchedule) do
		if v.job == job and v.index == index then
			return i
		end
	end

	return false
end

function M:getScheduleByHeroId(heroId)
	for i, v in pairs(self._jobSchedule) do
		if v.hero == heroId then
			return v
		end
	end
end

function M:getAllScheduleWithHero()
	local list = {}

	for _, schedule in pairs(self._jobSchedule) do
		if schedule.hero and schedule.hero ~= 0 then
			table.insert(list, schedule)
		end
	end

	return list
end

function M:getAllWorkHeroWithoutBunk()
	local heroList = HouseFurnitureModel.instance:getHerosWithBunk()
	local list = {}

	for _, schedule in pairs(self._jobSchedule) do
		local heroId = schedule.hero

		if heroId and heroId > 0 and not table.indexof(heroList, heroId) then
			table.insert(list, heroId)
		end
	end

	return list
end

function M:getAllWorkHero()
	local tempData = BaseListModel.New()

	for _, schedule in pairs(self._jobSchedule) do
		if schedule.hero and schedule.hero ~= 0 then
			local heroData = HeroDepotModel.instance:getHeroInfoByID(schedule.hero)

			tempData:addMo(heroData)
		end
	end

	return tempData
end

function M:getRoomConfigByIndex(index)
	return self._roomConfigList[index]
end

function M:getJobConfigByJobCode(jobCode)
	for i, roomConfig in ipairs(self._roomConfigList) do
		for j, jobConfig in ipairs(roomConfig) do
			if jobConfig.jobCode == jobCode then
				return jobConfig
			end
		end
	end
end

function M:getJobConfigListByRoomId(roomId)
	local cfgList = {}

	for i, roomConfig in ipairs(self._roomConfigList) do
		for j, jobConfig in ipairs(roomConfig) do
			if jobConfig.zoneId == roomId then
				table.insert(cfgList, jobConfig)
			end
		end
	end

	return cfgList
end

function M:getAllRoomConfig()
	return self._roomConfigList
end

function M:getAllUnlockRoomConfig()
	local roomConfigList = {}

	for i, jobList in ipairs(self._roomConfigList) do
		if jobList[1].roomType == HouseEnum.WorkType.Shelter then
			if HouseMainRoomModel.instance:getRoomOpenTyp(jobList[1].zoneId) == HouseMainEnum.RoomOpenTyp.OpenActive then
				table.insert(roomConfigList, jobList)
			end
		else
			table.insert(roomConfigList, jobList)
		end
	end

	return roomConfigList
end

function M:getIsShelterRoomUnlock(roomId)
	return HouseMainRoomModel.instance:getRoomOpenTyp(roomId) > 2
end

function M:changeJobHero(heroId, jobCode, index, roomId)
	local list = {}
	local schedule = self:getScheduleByHeroId(heroId)

	if schedule then
		local newSchedule = {}

		newSchedule.roomId = schedule.roomId
		newSchedule.job = schedule.job
		newSchedule.index = schedule.index
		newSchedule.hero = 0
		newSchedule.schedule = schedule.schedule
		newSchedule.bunk = schedule.bunk

		table.insert(list, newSchedule)
	end

	local schedule = self:getScheduleByJobAndIndexAndRoomId(jobCode, index, roomId)

	if schedule then
		local newSchedule = {}

		newSchedule.roomId = schedule.roomId
		newSchedule.job = schedule.job
		newSchedule.index = schedule.index
		newSchedule.hero = heroId
		newSchedule.schedule = schedule.schedule
		newSchedule.bunk = schedule.bunk

		table.insert(list, newSchedule)
	else
		for i = 1, 3 do
			local newSchedule = {}

			newSchedule.roomId = roomId
			newSchedule.job = jobCode
			newSchedule.index = i

			if i == index then
				newSchedule.hero = heroId
			else
				newSchedule.hero = 0
			end

			newSchedule.schedule = HouseConfig.instance:getHouseConst("defaultSchedule" .. i).numValues
			newSchedule.bunk = 0

			table.insert(list, newSchedule)
		end
	end

	HouseAgent.instance:sendSetJobScheduleRequest(list)
end

function M:getMoodDepartValueList()
	if not self._moodDepartValueList then
		self._moodDepartValueList = {}

		local moodStr = HouseConfig.instance:getHouseConst("MoodProductivityAdd").strValue

		moodStr = moodStr.sub(moodStr, 2, -2)

		local moodAddList = string.split(moodStr, ",")

		for i, v in ipairs(moodAddList) do
			moodDepart = string.split(v, ":")

			table.insert(self._moodDepartValueList, tonumber(moodDepart[1]))
		end
	end

	return self._moodDepartValueList
end

function M:getMoodInterval(mood)
	for i, v in ipairs(self:getMoodDepartValueList()) do
		if v < mood then
			return i
		end
	end

	return 3
end

function M:getCurrWorkingHero(jobCode)
	local dTable = os.date("*t", ServerTime.nowServerLook())
	local hour = dTable.hour
	local scheduleList = self:getScheduleByJob(jobCode)

	for _, schedule in ipairs(scheduleList) do
		local curWorkStatus = schedule.schedule[hour + 1]
		local heroId = checknumber(schedule.hero)

		if curWorkStatus == WorkStatus.Work and heroId > 0 then
			return heroId
		end
	end
end

function M:getIfJobCanSettled(jobCode)
	local jobConfig = self:getJobConfigByJobCode(jobCode)

	if jobConfig.roomType == HouseEnum.RoomType.Shelter then
		return not HouseMainUtil.isRoomNotSetting(jobConfig.zoneId)
	end

	return self:getIfJobUnlock(jobCode)
end

function M:getUnlockJobCountByRoomType(roomType)
	local level = self:getLevelByHouseType(roomType)

	if roomType == HouseEnum.RoomType.Supervisor then
		local houseCo = SupervisorConfig.instance:getConfigByLevel(level)

		return houseCo.jobCount
	elseif roomType == HouseEnum.RoomType.Manufacturing then
		local houseCo = ManufactureConfig.instance:getConfigByKey(ConfigName.HouseManufacture, level)

		return houseCo.jobCount
	elseif roomType == HouseEnum.RoomType.Trading then
		local houseCo = TradingConfig.instance:getHouseCoByLevel(level)

		return houseCo.jobCount
	elseif roomType == HouseEnum.RoomType.Shelter then
		return 1
	end
end

function M:getIfJobUnlock(jobCode)
	local jobConfig = self:getJobConfigByJobCode(jobCode)
	local unlockCount = self:getUnlockJobCountByRoomType(jobConfig.roomType)

	return unlockCount >= jobConfig.indexInRoom
end

function M:getLevelByHouseType(roomType)
	if roomType == HouseEnum.RoomType.Supervisor then
		return SupervisorModel.instance:getSupervisorLv()
	elseif roomType == HouseEnum.RoomType.Manufacturing then
		return ManufactureModel.instance:getLv()
	elseif roomType == HouseEnum.RoomType.Trading then
		return TradingModel.instance:getTradePostMo():getLevel()
	elseif roomType == HouseEnum.RoomType.Shelter then
		return 1
	end
end

function M:getUnlockConditionByRoomTypeAndIndex(roomType, index)
	local level = 10

	if roomType == HouseEnum.RoomType.Supervisor then
		local houseData = SupervisorConfig.instance:getConfigList(ConfigName.HouseManager)

		for i, houseCo in ipairs(houseData) do
			if index <= houseCo.jobCount then
				level = i

				break
			end
		end
	elseif roomType == HouseEnum.RoomType.Manufacturing then
		local houseData = ManufactureConfig.instance:getConfigList(ConfigName.HouseManufacture)

		for i, houseCo in ipairs(houseData) do
			if index <= houseCo.jobCount then
				level = i

				break
			end
		end
	elseif roomType == HouseEnum.RoomType.Trading then
		local houseCo = TradingConfig.instance:getHouseCoByLevel(level)
		local houseData = TradingConfig.instance:getTradeHouseConfigData()

		for i, houseCo in ipairs(houseData) do
			if index <= houseCo.jobCount then
				level = i

				break
			end
		end
	end

	return level
end

function M:getSortType(openType)
	if openType == HouseEnum.OpenType.Job then
		return CommEnum.HeroHouseSortType.HouseSkill
	else
		return CommEnum.HeroHouseSortType.Mood
	end
end

function M:getAscending(openType, sortType)
	if openType == HouseEnum.OpenType.Dorm and sortType == CommEnum.HeroHouseSortType.Mood then
		return true
	end

	return false
end

function M:getFilters()
	return {
		CommEnum.HeroHouseFilterType.NoSettled,
		CommEnum.HeroHouseFilterType.Supervisor,
		CommEnum.HeroHouseFilterType.Manufacturing,
		CommEnum.HeroHouseFilterType.Trading,
		CommEnum.HeroHouseFilterType.Shelter,
		CommEnum.HeroHouseFilterType.Living,
		CommEnum.HeroHouseFilterType.NormalTime,
		CommEnum.HeroHouseFilterType.SecretTime
	}
end

function M:setFilterIdxs(idxs)
	table.clear(self._filterIdxs)
	table.insertto(self._filterIdxs, idxs)
end

function M:getFilterIdxs()
	return self._filterIdxs
end

M.instance = M.New()

return M
