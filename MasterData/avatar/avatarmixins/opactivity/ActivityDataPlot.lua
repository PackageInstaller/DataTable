-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/Avatar\\AvatarMixins\\OpActivity\\ActivityDataPlot.lua

local ActivityDataBase = require("Avatar/AvatarMixins/OpActivity/ActivityDataBase")
local ResOpActivityPlotDetail = require("ClientData/ResOpActivityPlotDetail")
local ResOpActivityPlotStage = require("ClientData/ResOpActivityPlotStage")
local ResOpActivityPlotAchieve = require("ClientData/ResOpActivityPlotAchieve")
local ResOpActivityPlotMisc = require("ClientData/ResOpActivityPlotMisc")
local ResBattleConfig = require("ClientData/ResBattleConfig")
local ResBattleTarget = require("ClientData/ResBattleTarget")
local ActivityDataPlot = Class("ActivityDataPlot", ActivityDataBase)

function ActivityDataPlot:ctor()
	self.finishNodeInfo = {}
	self.sweepNodeInfo = {}
	self.passTimeInfo = {}
	self.achieveNodeInfo = {}
	self.totalSweepCount = 0
end

function ActivityDataPlot:updateClientData(actId)
	self.actId = actId
	self.clientData = ResOpActivityPlotDetail[actId] or {}
	self.miscData = ResOpActivityPlotMisc[actId] or {}
	self.needCareShopItem = self.miscData.shop_need_money

	if self.needCareShopItem then
		self.needMoneyCount = self.miscData.shop_money_count

		if not self.itemReddotInited then
			CurAvatar:registerItemChangedCallBack(self.needCareShopItem, Slot(self.CurAvatarCheckNew, self))

			self.itemReddotInited = true
		end
	end

	self.needSweepItem = self.miscData.cost_item_id

	if self.needSweepItem then
		self.sweepRedDotCount = self.miscData.cost_item_count

		if not self.itemSweepReddotInited then
			CurAvatar:registerItemChangedCallBack(self.needSweepItem, Slot(self.sweepCheckNew, self))

			self.itemSweepReddotInited = true
		end
	end
end

function ActivityDataPlot:updateRoleData(roleData, isUpdate)
	local preLevel = self:getNextSelectNode()

	self.finishNodeInfo = {}

	for _, info in ipairs(roleData.plot.record) do
		self.finishNodeInfo[info.index] = info.star
		self.sweepNodeInfo[info.index] = info.counter.count
		self.passTimeInfo[info.index] = info.min_battle_time
	end

	self.achieveNodeInfo = ClientUtils.getBitsDictFromByteString(roleData.plot.award.bits)
	self.totalSweepCount = roleData.plot.counter.count

	if isUpdate then
		local newLevel = self:getNextSelectNode()

		if preLevel < newLevel then
			CurAvatar:addNewDataCache(Const.NEW_DATA_CACHE_PLOT, newLevel)
		end
	end

	self:refreshRelatedDlg()
end

function ActivityDataPlot:refreshRelatedDlg()
	local activityPlotInfoDlg = UIManager.tryGetUI("activityPlotInfoDlg")

	if activityPlotInfoDlg then
		activityPlotInfoDlg:updateActivityData()
	end

	local activityPlotBattleDlg = UIManager.tryGetUI("activityPlotBattleDlg")

	if activityPlotBattleDlg then
		activityPlotBattleDlg:updateActivityData()
	end

	local activityPlotAchieveDlg = UIManager.tryGetUI("activityPlotAchieveDlg")

	if activityPlotAchieveDlg then
		activityPlotAchieveDlg:updateActivityData()
	end
end

function ActivityDataPlot:isAchieveFinished(index)
	local achData = ResOpActivityPlotAchieve[self.actId][index]
	local nodeNum = achData.target_index

	if nodeNum then
		local nowStar = self.finishNodeInfo[nodeNum]

		if nowStar and nowStar >= achData.star then
			return true
		else
			return false
		end
	elseif self.totalSweepCount and self.totalSweepCount >= achData.sweep_num then
		return true
	else
		return false
	end
end

function ActivityDataPlot:getSweepInfo(index)
	local achData = ResOpActivityPlotAchieve[self.actId][index]

	if achData.sweep_num then
		return {
			self.totalSweepCount,
			achData.sweep_num
		}
	end
end

function ActivityDataPlot:isAchieveGot(index)
	return self.achieveNodeInfo[index]
end

function ActivityDataPlot:CurAvatarCheckNew()
	CurAvatar:checkPlotShopNew()
	self.actObject:refreshUI()
end

function ActivityDataPlot:sweepCheckNew()
	self.actObject:checkNew()
	self.actObject:refreshUI()
end

function ActivityDataPlot:hasSweepItem()
	if not self.needSweepItem then
		return false
	end

	local nowCount = CurAvatar:getItemNumById(self.needSweepItem)

	if nowCount >= self.sweepRedDotCount then
		for stageId, stageInfo in ipairs(ResOpActivityPlotStage[self.actId]) do
			if stageInfo.stage_type == Const.ACT_TYPE_PLOT_MODE_BATTLE then
				for levelId, levelData in ipairs(self.clientData) do
					if levelData.stage == stageId and self:isLevelPassed(levelId) and self:getNowSweepCount(levelId) < (levelData.sweep_max_num or 0) then
						return true
					end
				end
			end
		end
	end

	return false
end

function ActivityDataPlot:needSeenToday()
	if self.actId then
		local newLevel = self:getNextSelectNode(true)
		local state = self:getLevelState(newLevel)

		if state == Const.COMMON_STATE_NEXT or state == Const.COMMON_STATE_NML then
			return true
		end
	end

	return false
end

function ActivityDataPlot:hasBattleToFight()
	if self.actId then
		local nextLevel = self:getNextSelectNode(nil, Const.ACT_TYPE_PLOT_MODE_BATTLE)

		if not self:isLevelPassed(nextLevel) then
			return true
		end
	end

	if self:hasSweepItem() then
		return true
	end

	return false
end

function ActivityDataPlot:hasMoney()
	if not self.needCareShopItem then
		return false
	end

	local nowCount = CurAvatar:getItemNumById(self.needCareShopItem)

	return nowCount >= self.needMoneyCount
end

function ActivityDataPlot:hasAchieveToGet(...)
	for achIndex, achInfo in ipairs(ResOpActivityPlotAchieve[self.actId]) do
		if self:isAchieveFinished(achIndex) and not self:isAchieveGot(achIndex) then
			return true
		end
	end

	return false
end

function ActivityDataPlot:checkNew()
	if self:needSeenToday() then
		return true
	end

	if self:hasBattleToFight() then
		return true
	end

	if self:hasMoney() then
		return true
	end

	if self:hasAchieveToGet() then
		return true
	end

	return false
end

function ActivityDataPlot:getLevelTargetStar(levelId)
	return self.finishNodeInfo[levelId] or 0
end

function ActivityDataPlot:isLevelTargetComplete(levelId)
	if self.finishNodeInfo[levelId] then
		local levelData = self.clientData[levelId]
		local needNum = 0

		if levelData and levelData.battle_id then
			local battleConfig = ResBattleConfig[levelData.battle_id]

			if battleConfig and battleConfig.target_id then
				local targetData = ResBattleTarget[battleConfig.target_id]

				if targetData and targetData.targets then
					needNum = #targetData.targets
				end
			end
		end

		if needNum > self.finishNodeInfo[levelId] then
			return false
		else
			return true
		end
	else
		return false
	end
end

function ActivityDataPlot:isLevelPassed(levelId)
	if self.finishNodeInfo[levelId] then
		return true
	else
		return false
	end
end

function ActivityDataPlot:getStageUnlockedTime(stageId)
	for levelId, levelData in ipairs(self.clientData) do
		if levelData.stage == stageId then
			return self:getLevelUnlockedTime(levelId)
		end
	end

	return 0
end

local OneDaySeconds = 86400

function ActivityDataPlot:getLevelUnlockedTime(levelId)
	local levelData = self.clientData[levelId]

	if levelData and levelData.unlock_day > 1 then
		if self.actObject.startTime and not self.startDayTime then
			self.startDayTime = ClientUtils.getServerTimeTodayStart(self.actObject.startTime)
		end

		if self.startDayTime then
			return self.startDayTime + (levelData.unlock_day - 1) * OneDaySeconds
		end
	end

	return 0
end

function ActivityDataPlot:isLevelLocked(levelId)
	return ClientUtils.getServerTime() < self:getLevelUnlockedTime(levelId)
end

function ActivityDataPlot:getStageState(stageId)
	local hasFinished = false

	for levelId, levelData in ipairs(self.clientData) do
		if levelData.stage == stageId then
			if self:isLevelPassed(levelId) then
				hasFinished = true
			elseif self:isLevelLocked(levelId) then
				return Const.COMMON_STATE_LOCK
			elseif hasFinished or levelData.pre_index == nil or self:isLevelPassed(levelData.pre_index) then
				return Const.COMMON_STATE_NEXT
			else
				return Const.COMMON_STATE_NML
			end
		end
	end

	return Const.COMMON_STATE_COMPLETE
end

function ActivityDataPlot:getLevelState(levelId)
	local levelData = self.clientData[levelId] or {}

	if self:isLevelLocked(levelId) then
		return Const.COMMON_STATE_LOCK
	elseif self:isLevelTargetComplete(levelId) then
		return Const.COMMON_STATE_COMPLETE
	elseif self:isLevelPassed(levelId) then
		return Const.COMMON_STATE_PASSED
	elseif levelData.pre_index == nil or self:isLevelPassed(levelData.pre_index) then
		return Const.COMMON_STATE_NEXT
	else
		return Const.COMMON_STATE_NML
	end
end

function ActivityDataPlot:getNextSelectNode(includeLock, needMode)
	needMode = needMode or Const.ACT_TYPE_PLOT_MODE_STORY

	local nextLevel = 1
	local nextStage = 1

	for stageId, stageInfo in ipairs(ResOpActivityPlotStage[self.actId]) do
		if stageInfo.stage_type == needMode then
			for levelId, levelData in ipairs(self.clientData) do
				if levelData.stage == stageId then
					if self:isLevelPassed(levelId) then
						nextStage = stageId
						nextLevel = levelId
					elseif self:isLevelLocked(levelId) then
						if includeLock then
							return levelId, stageId
						else
							return nextLevel, nextStage
						end
					else
						return levelId, stageId
					end
				end
			end
		end
	end

	return nextLevel, nextStage
end

function ActivityDataPlot:getNowSweepCount(index)
	return self.sweepNodeInfo[index] or 0
end

function ActivityDataPlot:getPassTimeByIndex(index)
	return self.passTimeInfo[index] or 0
end

return ActivityDataPlot
