-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/annualactivity/model/AnnualActivityModel.lua

module("logic.extensions.annualactivity.model.AnnualActivityModel", package.seeall)

local AnnualActivityModel = class("AnnualActivityModel", BaseModel)

function AnnualActivityModel:ctor()
	self.viewOpenIndex = 1
	self.puzzleOpenIndex = 1
	self._posterInfos = nil
	self._taskInfos = nil
end

function AnnualActivityModel:onInit()
	AnnualActivityModel.super.onInit(self)
	self:onReset()
end

function AnnualActivityModel:onReset()
	self._posterInfos = nil
	self._taskInfos = nil
end

function AnnualActivityModel:getMainAllSubView()
	local list = {}

	for _, info in pairs(AnnualActivityController.GoldBarInfo) do
		if info and info.viewIndex and not string.nilorempty(info.viewName) then
			table.insert(list, info)
		end
	end

	if #list > 1 then
		table.sort(list, function(a, b)
			return a.viewIndex < b.viewIndex
		end)
	end

	return list
end

function AnnualActivityModel:getPuzzleAllCfgs(planId)
	local list = {}
	local allCfgs = AnnualActivityConfig.instance:getAnnualAllPosterCfgs(planId)

	for _, item in pairs(allCfgs or {}) do
		if item and checknumber(item.posterId) > 0 then
			table.insert(list, item)
		end
	end

	table.insert(list, {
		relativeOpenDays = 0,
		posterId = 99,
		puzzleName = lang("text_annual_desc_10")
	})

	if #list > 1 then
		table.sort(list, function(a, b)
			return a.posterId < b.posterId
		end)
	end

	return list
end

function AnnualActivityModel:getPuzzleIsOpen(actId, days)
	if checknumber(days) <= 0 then
		return true
	end

	local actCfg = ActivityDefineConfig.instance:getCfgById(GameEnum.ActivityType.AnnualActivity, actId)

	if actCfg == nil or string.nilorempty(actCfg.startTime) then
		return true
	end

	local startTime = GameUtil.string2time(actCfg.startTime) + days * 24 * 60 * 60

	if startTime <= ServerTime.now() then
		return true
	end

	local nowTime = GameUtil.time2date(startTime)
	local str = langPara("text_annual_desc_9", nowTime.month, nowTime.day)

	return false, str
end

function AnnualActivityModel:getPosterInfos(isReset)
	if isReset or self._posterInfos == nil then
		self._posterInfos = {}

		local data

		for i = 1, 4 do
			data = {}
			data.isReceive = false
			data.activationIds = {
				false,
				false,
				false,
				false,
				false,
				false,
				false,
				false,
				false,
				false,
				false,
				false
			}
			self._posterInfos[i] = data
		end
	end

	return self._posterInfos
end

function AnnualActivityModel:getTaskInfos()
	return self._taskInfos or {}
end

function AnnualActivityModel:getAnnualTaskCfgs(planId)
	local allTasks = AnnualActivityConfig.instance:getAnnualTaskCfgs(planId)

	if allTasks == nil then
		return {}
	end

	local list = {}
	local temp, stage

	for _, typeList in pairs(allTasks) do
		temp, stage = self:_getTaskCfgByType(typeList)

		if temp then
			table.insert(list, {
				cfg = temp,
				stage = stage
			})
		end
	end

	if #list > 1 then
		table.sort(list, function(a, b)
			if a.stage == b.stage then
				return a.cfg.taskId < b.cfg.taskId
			end

			return a.stage < b.stage
		end)
	end

	return list
end

function AnnualActivityModel:_getTaskCfgByType(typeList)
	if typeList then
		if not #typeList then
			local count = 0

			if count == 0 then
				return nil, nil
			end

			self._taskInfos = self._taskInfos or {}

			for i = 1, count do
				local taskId = typeList[i].taskId

				if self._taskInfos[taskId] == nil then
					return typeList[i], 2
				end

				if not self._taskInfos[taskId].isReceive then
					local stage = typeList[i].maxProgress <= checknumber(self._taskInfos[taskId].haveCount) and 1 or 2

					return typeList[i], stage
				end
			end

			return typeList[count], 3
		end
	end
end

function AnnualActivityModel:isAllPuzzleFinish()
	if self._posterInfos == nil then
		return false
	end

	for _, info in pairs(self._posterInfos) do
		if info and info.activationIds and not info.isReceive then
			for i = 1, #info.activationIds do
				if not info.activationIds[i] then
					return false
				end
			end
		end
	end

	return true
end

function AnnualActivityModel:getAnnualActivityRedpoint()
	local actId = AnnualActivityConfig.instance:getOpenActivityId()

	if checknumber(actId) <= 0 then
		return false
	end

	local value = GameUtil.getUserDayData("AnnualActivityRed")

	if checknumber(value) ~= 1 then
		return true
	end

	return RedPointModel.instance:isActiveByServer(224) or RedPointModel.instance:isActiveByServer(225)
end

function AnnualActivityModel:getAnnualPuzzleRedpoint()
	return RedPointModel.instance:isActiveByServer(225)
end

function AnnualActivityModel:getAnnualTaskRedpoint()
	return RedPointModel.instance:isActiveByServer(224)
end

function AnnualActivityModel:scPushPJGetPosterInfo(msg)
	self:getPosterInfos(true)

	if msg == nil or msg.posterInfos == nil then
		return
	end

	for _, info in pairs(msg.posterInfos) do
		if info and checknumber(info.posterId) > 0 then
			self._posterInfos[info.posterId].isReceive = info.bigPrizeGained

			if info.activatedJigsawIds and #info.activatedJigsawIds > 0 then
				for i = 1, #info.activatedJigsawIds do
					local index = checknumber(info.activatedJigsawIds[i])

					if self._posterInfos[info.posterId].activationIds then
						self._posterInfos[info.posterId].activationIds[index] = true
					end
				end
			end
		end
	end
end

function AnnualActivityModel:scPushPJActivateJigsaw(msg)
	self:getPosterInfos()

	if msg == nil or msg.posterId == nil or msg.jigsawId == nil then
		return
	end

	if self._posterInfos[msg.posterId] and self._posterInfos[msg.posterId].activationIds then
		self._posterInfos[msg.posterId].activationIds[msg.jigsawId] = true
	end
end

function AnnualActivityModel:scPushPJGainBigPrize(msg)
	self:getPosterInfos()

	if msg == nil or msg.posterId == nil then
		return
	end

	if self._posterInfos[msg.posterId] then
		self._posterInfos[msg.posterId].isReceive = true
	end
end

function AnnualActivityModel:scPushPJGetTaskInfo(msg)
	self._taskInfos = {}

	if msg == nil or msg.taskInfos == nil then
		return
	end

	for _, info in pairs(msg.taskInfos) do
		if info and checknumber(info.taskId) > 0 then
			self._taskInfos[info.taskId] = {}
			self._taskInfos[info.taskId].haveCount = info.curProgress
			self._taskInfos[info.taskId].isReceive = info.prizeGained
		end
	end
end

function AnnualActivityModel:scPushPJGainTaskPrize(msg)
	self._taskInfos = self._taskInfos or {}

	if msg == nil or msg.taskId == nil then
		return
	end

	if self._taskInfos[msg.taskId] == nil then
		self._taskInfos[msg.taskId] = {}
	end

	self._taskInfos[msg.taskId].isReceive = true
end

AnnualActivityModel.instance = AnnualActivityModel.New()

return AnnualActivityModel
