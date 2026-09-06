-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/achievement/model/AchievementModel.lua

module("logic.extensions.achievement.model.AchievementModel", package.seeall)

local AchievementModel = class("AchievementModel", BaseModel)

function AchievementModel:ctor()
	return
end

function AchievementModel:onInit()
	self:onReset()
end

function AchievementModel:onReset()
	self._achievements = {}
	self._allRootProgress = {}
	self._progresses = {}
end

function AchievementModel:onLoadAllAchievementRes(msg)
	self._achievements = {}

	for _, achievement in ipairs(msg.achievementList) do
		self._achievements[achievement.defineId] = achievement
	end

	self:_updateProgresses()

	self._levelPrizeGainState = checknumber(msg.levelPrizeGainState)

	print("self._levelPrizeGainState = " .. self._levelPrizeGainState)
end

function AchievementModel:onGainAchievementPrize(id)
	local msg = self:getAchivementMsg(id)

	if msg ~= nil then
		msg.gainPrize = true
	end
end

function AchievementModel:onOneKeyGain()
	for _, msg in pairs(self._achievements) do
		msg.gainPrize = true
	end
end

function AchievementModel:onGainLevelPrize(prizeId)
	self._levelPrizeGainState = GameUtil.setBitByDigit(self._levelPrizeGainState, prizeId - 1, true)
end

function AchievementModel:handleGetAchievementRes(mos)
	if FuncOpenModel.instance:getFuncIsOpen(44) then
		self._needShowMos = self._needShowMos or {}

		for _, mo in ipairs(mos) do
			table.insert(self._needShowMos, mo)
		end
	end
end

function AchievementModel:enQueueNeedShow()
	local t = {}

	if self._needShowMos ~= nil and #self._needShowMos > 0 then
		for _, v in ipairs(self._needShowMos) do
			table.insert(t, v)
		end
	end

	self._needShowMos = {}

	return t
end

function AchievementModel:getIsNeedShowTips()
	return self._needShowMos ~= nil and #self._needShowMos > 0
end

function AchievementModel:_updateProgresses()
	self._progresses = {}

	local t = AchievementConfig.instance:getCfgsMap()

	self._allRootProgress = {}

	for root, v in pairs(t) do
		for leaf, u in pairs(v) do
			for _, cfg in ipairs(u) do
				local isNeedShow = self:isNeedShow(cfg.id)

				if isNeedShow then
					self._progresses[root] = self._progresses[root] or {}
					self._allRootProgress.totalProgress = checknumber(self._allRootProgress.totalProgress) + 1
					self._progresses[root].totalProgress = checknumber(self._progresses[root].totalProgress) + 1

					if self:getAchivementIsFinished(cfg.id) then
						self._progresses[root].curProgress = checknumber(self._progresses[root].curProgress) + 1
						self._allRootProgress.curProgress = checknumber(self._allRootProgress.curProgress) + 1
					end
				end
			end
		end
	end
end

function AchievementModel:getAchivementIsFinished(id)
	local msg = self:getAchivementMsg(id)

	if msg ~= nil and checknumber(msg.achieveTime) > 0 then
		return true
	end

	local cur, total = self:getAchivementProgress(id)

	return total <= cur and total >= 1
end

function AchievementModel:getAchivementProgress(id)
	local cur, total = 0, 0
	local cfg = AchievementConfig.instance:getCfgById(id)

	if cfg ~= nil then
		total = checknumber(cfg.maxNum)
	end

	return (self._achievements[id] ~= nil or nil) and self._achievements[id].curProgress, total
end

function AchievementModel:getAchivementCanReceivePrize(id)
	if self._achievements[id] ~= nil then
		return self._achievements[id].gainPrize ~= true
	end

	return false
end

function AchievementModel:getAchivementMsg(id)
	if self._achievements[id] ~= nil then
		return self._achievements[id]
	end

	return nil
end

function AchievementModel:getProgress(root)
	if root == 0 then
		return self._allRootProgress
	elseif root > 0 then
		return self._progresses[root]
	end
end

function AchievementModel:getTotalProgress()
	local total = 0

	for k, v in pairs(self._progresses) do
		total = total + v.totalProgress
	end

	return total
end

function AchievementModel:getLevelProgress()
	local cur = checknumber(self._allRootProgress.curProgress)
	local total = 0
	local lv = 0
	local cfgs = AchievementConfig.instance:getLvCfgList()

	table.sort(cfgs, function(a, b)
		return a.level < b.level
	end)

	for i = #cfgs, 1, -1 do
		if cur >= cfgs[i].needPoint then
			lv = cfgs[i].level

			break
		end
	end

	local cfg = AchievementConfig.instance:getLvCfg(lv)
	local nextCfg = AchievementConfig.instance:getLvCfg(lv + 1)

	if cfg ~= nil then
		cur = cur - cfg.needPoint
		total = nextCfg ~= nil and nextCfg.needPoint - cfg.needPoint or 0
	end

	return lv, cur, total
end

function AchievementModel:getIsReceivedAllPrize()
	local t = AchievementConfig.instance:getLvCfgList()

	for _, v in ipairs(t) do
		if not self:getLevelPrizeGained(v.level) then
			return false
		end
	end

	return true
end

function AchievementModel:isNeedShow(id)
	local status = self:getAchievementStatus(id)
	local isNeedShow = false

	if status == 3 or status == 1 then
		isNeedShow = true
	else
		local isHasEnd = self:isHasEndOfTask(id)

		isNeedShow = not isHasEnd
	end

	return isNeedShow
end

function AchievementModel:isHasEndOfTask(id)
	local isHasEnd = true
	local data = AchievementConfig.instance:getCfgById(id)

	if data then
		local timePeriod = GameUtil.getTimePeriod(nil, data.endTime)

		isHasEnd = timePeriod ~= GameUtil.inTimePeriod
	end

	return isHasEnd
end

function AchievementModel:getLevelPrizeGained(prizeId)
	prizeId = prizeId - 1

	return GameUtil.isBitOpenByDigit(self._levelPrizeGainState, prizeId)
end

function AchievementModel:getOverallAchievements()
	local list = AchievementConfig.instance:getCfgsList()
	local t = {}

	for _, v in ipairs(list) do
		if self:isNeedShow(v.id) then
			table.insert(t, v)
		end
	end

	table.sort(t, AchievementModel.sortAchievement)

	return t
end

function AchievementModel:getLevelPrizeStatus(level)
	local lv, cur, total = self:getLevelProgress()

	if self:getIsReceivedAllPrize() then
		return 1
	end

	if level <= lv then
		return self:getLevelPrizeGained(level) and 1 or 3
	else
		return 2
	end
end

function AchievementModel:getAchievementStatus(id)
	local msg = self:getAchivementMsg(id)

	if msg == nil then
		return 2
	end

	local isFinished = self:getAchivementIsFinished(id)
	local isReceived = msg.gainPrize == true

	if not isFinished then
		return 2
	elseif isReceived then
		return 1
	else
		return 3
	end
end

function AchievementModel:getIsRed(root, leaf)
	if not self._achievements or #self._achievements == 0 then
		return false
	else
		for id, achievement in pairs(self._achievements) do
			local cfg = AchievementConfig.instance:getCfgById(id)
			local isNeedShow = self:isNeedShow(id)

			if isNeedShow and cfg ~= nil and cfg.root == root and (cfg.leaf == leaf or leaf == 0) and self:getAchievementStatus(id) == 3 then
				return true
			end
		end

		if root == 0 then
			local lv, cur, total = self:getLevelProgress()
			local isRed = false

			for i = 1, lv do
				if not self:getLevelPrizeGained(i) then
					isRed = true

					break
				end
			end

			return isRed
		end

		return false
	end
end

function AchievementModel.sortAchievement(a, b)
	local statusA = AchievementModel.instance:getAchievementStatus(a.id)
	local statusB = AchievementModel.instance:getAchievementStatus(b.id)

	if statusA ~= statusB then
		return statusB < statusA
	else
		local msgA = AchievementModel.instance:getAchivementMsg(a.id)
		local msgB = AchievementModel.instance:getAchivementMsg(b.id)
		local timeA = msgA ~= nil and math.max(0, checknumber(msgA.achieveTime)) or 0
		local timeB = msgB ~= nil and math.max(0, checknumber(msgB.achieveTime)) or 0

		if timeB ~= timeA then
			return timeB < timeA
		else
			local curA, totalA = AchievementModel.instance:getAchivementProgress(a.id)
			local curB, totalB = AchievementModel.instance:getAchivementProgress(b.id)

			if totalA > 0 then
				if not (curA / totalA) then
					local progressA = 0

					if totalB > 0 then
						if not (curB / totalB) then
							local progressB = 0

							if progressB ~= progressA then
								return progressB < progressA
							elseif a.maxNum ~= b.maxNum then
								return a.maxNum < b.maxNum
							else
								return a.id < b.id
							end
						end
					end
				end
			end
		end
	end
end

AchievementModel.instance = AchievementModel.New()

return AchievementModel
