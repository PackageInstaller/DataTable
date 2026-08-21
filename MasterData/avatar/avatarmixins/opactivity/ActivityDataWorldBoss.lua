-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/Avatar\\AvatarMixins\\OpActivity\\ActivityDataWorldBoss.lua

local ActivityDataBase = require("Avatar/AvatarMixins/OpActivity/ActivityDataBase")
local ResOpActivityPlotDetail = require("ClientData/ResOpActivityPlotDetail")
local ResWorldBossMisc = require("ClientData/ResWorldBossMisc")
local ResOpActivityPlotAchieve = require("ClientData/ResOpActivityPlotAchieve")
local WorldBossCommon = require("Logic/WorldBoss/WorldBossCommon")
local ResWorldBossIndex = require("ClientData/ResWorldBossIndex")
local ResWorldBossAchieve = require("ClientData/ResWorldBossAchieve")
local ActivityDataWorldBoss = Class("ActivityDataWorldBoss", ActivityDataBase)

function ActivityDataWorldBoss:ctor()
	self.clientData = {}
	self.serverData = {}
end

function ActivityDataWorldBoss:updateClientData(actId)
	self.actId = actId
	self.clientData = ResOpActivityPlotDetail[actId] or {}

	WorldBossCommon.setCurBossActId(self.actId)
end

function ActivityDataWorldBoss:updateSystemData(systemItem)
	return
end

function ActivityDataWorldBoss:_initServerData(systemItem)
	if CurAvatar.needRefreshWorldBoss == true and self.serverData and self.serverData.week_index and self.serverData.week_index ~= systemItem.specdata.world_boss.week_index then
		CurAvatar.needRefreshWorldBoss = nil
	end

	self.serverData = systemItem.specdata.world_boss

	if self.worldBossData == nil then
		-- block empty
	end

	self:refreshState()
	self:registEndEvent()
end

function ActivityDataWorldBoss:updateMgrData(opActivityMgrItem)
	if opActivityMgrItem.state == Const.OPACT_STATE_OPEN then
		self:_initServerData(opActivityMgrItem)
	end
end

function ActivityDataWorldBoss:updateRoleData(roleData, isUpdate)
	self.worldBossData = roleData.world_boss.world_boss

	if isUpdate == true then
		WorldBossCommon.refreshWorldBossActData()
	end
end

function ActivityDataWorldBoss:onStateChange(opActState)
	if opActState == Const.OPACT_STATE_OPEN then
		-- block empty
	elseif opActState == Const.OPACT_STATE_CLOSE then
		self.worldBossData = nil
	elseif opActState == Const.OPACT_STATE_FREEZE then
		-- block empty
	end
end

function ActivityDataWorldBoss:getLimitId(...)
	return ResWorldBossMisc[1].condition_id
end

function ActivityDataWorldBoss:getCurBossInfo(...)
	return WorldBossCommon.getCurBossInfo(self.serverData.boss_type)
end

local UIS = {
	"worldBossMainDlg",
	"worldBossAnnounceDlg"
}

function ActivityDataWorldBoss:refreshState(...)
	self:_checkNew()

	for i, name in ipairs(UIS) do
		local ui = UIManager.getUI(name, nil, false)

		if ui and ui.refreshUI then
			ui:refreshUI()
		end
	end
end

function ActivityDataWorldBoss:checkNew(...)
	return self:_checkNew()
end

function ActivityDataWorldBoss:willEnd()
	local leftTime = WorldBossCommon.getCurBossLeftTime()

	if leftTime > WorldBossCommon.getConfigFrozenTime() and leftTime - WorldBossCommon.getConfigFrozenTime() <= self:willEndCountDown() then
		return true
	else
		return false
	end
end

function ActivityDataWorldBoss:willEndCountDown()
	return 64800
end

local uis = {
	"mainMenu",
	"mainStageDlg"
}

function ActivityDataWorldBoss:_checkNew(...)
	if self.serverData.close_tick == nil then
		return
	end

	self:checkBattleTimes()

	local result = RedDotManager.getKeyState(UIConst.RD_HINT_WORLDBOSS)

	if self.actObject.redDotId then
		RedDotManager.setKeyState(self.actObject.redDotId, result)
	end

	for _, name in ipairs(uis) do
		local mainMenu = UIManager.tryGetUI(name)

		if mainMenu then
			mainMenu:onRefresh()
		end
	end

	return result
end

function ActivityDataWorldBoss:checkBattleTimes(...)
	if self.worldBossData then
		local left, total = WorldBossCommon.getLeftBattleTimes()
		local result = left > 0

		result = result and WorldBossCommon.isInFrozenTime() == false

		RedDotManager.setKeyState(UIConst.RD_HINT_WORLDBOSS_CHALLENGE, result)

		local left1 = WorldBossCommon.getLeftEliteBattleTimes()
		local result1 = left1 > 0

		result1 = result1 and result

		RedDotManager.setKeyState(UIConst.RD_HINT_ELITE_WORLDBOSS_CHALLENGE, result1)
	end
end

function ActivityDataWorldBoss:doSthWhenEnd(...)
	local curLeftTime = WorldBossCommon.getCurBossLeftTime()

	if curLeftTime < 86400 then
		self:_resetRoleData()
		self:_resetSysData()
		self:registEndEvent()
	end

	self:refreshState()

	CurAvatar.needRefreshWorldBoss = true

	local ui = UIManager.getUI("worldBossMainDlg", nil, false)

	if ui then
		ui:checkRefresh()
	end
end

function ActivityDataWorldBoss:getEndTime(...)
	if self.serverData then
		return self.serverData.close_tick
	end
end

function ActivityDataWorldBoss:_resetRoleData(...)
	if self.worldBossData then
		self.worldBossData.max_score = 0
		self.worldBossData.sum_score = 0
		self.worldBossData.day_times = ResWorldBossMisc[1].init_times
	end
end

function ActivityDataWorldBoss:_resetSysData(...)
	if self.serverData then
		local nextBossInfo = WorldBossCommon.getNextBossInfo()

		self.serverData.week_index = self.serverData.week_index + 1
		self.serverData.boss_type = nextBossInfo.type
		self.serverData.close_tick = self.serverData.close_tick + 604800

		local info = ResWorldBossIndex[self.serverData.week_index + 1] or {}

		self.serverData.next_boss_type = info and info.type or nil
	end
end

function ActivityDataWorldBoss:getWorldBossRoleData(...)
	return self.worldBossData
end

function ActivityDataWorldBoss:getSumScore(...)
	if self.worldBossData then
		return tonumber(self.worldBossData.sum_score) or 0
	end

	return 0
end

function ActivityDataWorldBoss:getMaxScore(...)
	if self.worldBossData then
		return tonumber(self.worldBossData.max_score) or 0
	end

	return 0
end

function ActivityDataWorldBoss:getEliteMaxScore(...)
	if self.worldBossData then
		return tonumber(self.worldBossData.team_two_max_score) or 0
	end

	return 0
end

function ActivityDataWorldBoss:getDayTimes(...)
	if self.worldBossData then
		return self.worldBossData.day_times
	end

	return 0
end

function ActivityDataWorldBoss:getEliteTimes(...)
	if self.worldBossData then
		return self.worldBossData.team_two_times or 0
	end

	return 0
end

function ActivityDataWorldBoss:getEliteTotalTimes()
	local totalTime = 0

	for i, v in ipairs(ResWorldBossAchieve) do
		for _, d in ipairs(v) do
			local time = d.award_ticket or 0

			totalTime = totalTime + time
		end
	end

	return totalTime
end

function ActivityDataWorldBoss:getEliteAchieveInfo()
	local totalTimes = 0
	local curTimes = 0
	local achieves = {}
	local serverAchieve

	if self.worldBossData and self.worldBossData.achieve then
		serverAchieve = self.worldBossData.achieve or nil
	end

	local idx = 0

	for _, achieveInfo in ipairs(ResWorldBossAchieve) do
		for i, v in ipairs(achieveInfo) do
			idx = idx + 1
			achieves[idx] = {}
			achieves[idx].rule = v.desc

			local time = v.award_ticket or 0

			totalTimes = totalTimes + time
			achieves[idx].totalTimes = v.award_ticket
			achieves[idx].curTimes = 0

			if serverAchieve then
				for index, value in ipairs(serverAchieve) do
					if value.type == v.type then
						achieves[idx].curTimes = value.progress >= v.index and v.award_ticket or 0
						curTimes = curTimes + achieves[idx].curTimes
					end
				end
			end
		end
	end

	return curTimes, achieves
end

function ActivityDataWorldBoss:getEliteAchieves(...)
	if self.worldBossData then
		return self.worldBossData.achieves or nil
	end

	return nil
end

function ActivityDataWorldBoss:newDayRefreshDailyTimes()
	if self.worldBossData then
		self.worldBossData.day_times = math.min(ResWorldBossMisc[1].times_limit, self.worldBossData.day_times + ResWorldBossMisc[1].day_free_times)
	end
end

function ActivityDataWorldBoss:getHardLevel(bossId)
	if self.worldBossData and self.worldBossData.boss_item and self.worldBossData.boss_item[bossId] then
		return self.worldBossData.boss_item[bossId].hard or 1
	end

	return 1
end

function ActivityDataWorldBoss:getReplayId(...)
	if self.worldBossData then
		return self.worldBossData.replay_id
	end
end

function ActivityDataWorldBoss:getReplayId2(...)
	if self.worldBossData then
		return self.worldBossData.replay_id2
	end
end

function ActivityDataWorldBoss:checkQuickFightOpen()
	if self.worldBossData then
		return self.worldBossData.hard_times >= ResWorldBossMisc[1].hard_time_limit
	end

	return false
end

function ActivityDataWorldBoss:checkEliteModeOpen()
	if Const.ELITE_WORLDBOSS_OPEN then
		local bossInfo = WorldBossCommon.getCurBossInfo()

		if bossInfo.hard < 3 then
			return false
		end

		if self.worldBossData and self.worldBossData.achieve and #self.worldBossData.achieve >= 1 then
			return true
		end
	end

	return false
end

function ActivityDataWorldBoss:checkShowEliteMode()
	if Const.ELITE_WORLDBOSS_OPEN then
		local bossInfo = WorldBossCommon.getCurBossInfo()

		if bossInfo.hard < 3 then
			return false
		end

		if self.worldBossData then
			local num1 = self.worldBossData.day_times or 0
			local num2 = self.worldBossData.team_two_times or 0

			return num1 > 0 and num2 > 0
		end
	end

	return false
end

function ActivityDataWorldBoss:registEndEvent(...)
	ActivityDataWorldBoss.super.registEndEvent(self)

	if self.serverData.close_tick == nil then
		return
	end

	local leftToFrozenTime = WorldBossCommon.getFrozenTime()

	if leftToFrozenTime >= 0 then
		ClientTimerManager.startGlobalTimer("activity_worldBoss_frozen" .. self.actObject.actId, leftToFrozenTime, Slot(self.refreshState, self))
	end

	local leftEndTime = WorldBossCommon.getCurBossLeftTime()
	local leftTipTime = leftEndTime - 86400

	if leftTipTime > 0 then
		ClientTimerManager.startGlobalTimer("activity_worldBoss_Tip_End" .. self.actObject.actId, leftTipTime, Slot(self.refreshState, self))
	end
end

function ActivityDataWorldBoss:unRegistEndEvent(...)
	ActivityDataWorldBoss.super.unRegistEndEvent(self)
	ClientTimerManager.stopGlobalTimer("activity_worldBoss_frozen" .. self.actObject.actId)
	ClientTimerManager.stopGlobalTimer("activity_worldBoss_Tip_End" .. self.actObject.actId)
end

return ActivityDataWorldBoss
