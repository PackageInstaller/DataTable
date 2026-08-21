-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/Avatar\\AvatarMixins\\OpActivity\\ActivityDataSeasonTower.lua

local ActivityDataBase = require("Avatar/AvatarMixins/OpActivity/ActivityDataBase")
local ResOpActTowerGroup = require("ClientData/ResOpActTowerGroup")
local ResOpActTowerMisc = require("ClientData/ResOpActTowerMisc")
local ResOpActTower = require("ClientData/ResOpActTower")
local ResOpActTowerStage = require("ClientData/ResOpActTowerStage")
local ResOpActTowerScoreAward = require("ClientData/ResOpActTowerScoreAward")
local OtherPlayer = require("Common/Object/OtherPlayer")
local UserData = require("Helper/UserData")
local ResOpActTowerBossAward = require("ClientData/ResOpActTowerBossAward")
local ResOpActTowerScoreAchieveAward = require("ClientData/ResOpActTowerScoreAchieveAward")
local ResOpActTowerBuff = require("ClientData/ResOpActTowerBuff")
local ActivityDataSeasonTower = Class("ActivityDataSeasonTower", ActivityDataBase)

function ActivityDataSeasonTower:ctor()
	self.serverData = {}
	self.clientData = {}
	self.towerLayer = {}
	self.thisWeekConfig = {}
	self.towerRoleData = {}
	self.towerAddSweepData = {}
	self.score = 0
	self.scoreAward = {}
	self.startTime = 0
	self.endTime = 0
	self.allOverTime = 0
	self.cachedTowerLocked = {}
	self.sysBuffs = {}
	self.towerBuffs = {}
	self.timerRefreshBuff = Timer.New(Slot(self.refreshTowerBuffData, self), 1800, -1)
	self.buffCache = {}
end

function ActivityDataSeasonTower:updateClientData(actId)
	self.actId = actId
	self.clientGroupData = ResOpActTowerGroup[actId]
	self.clientStageData = ResOpActTowerStage[actId]
	self.clientTowerData = ResOpActTower[actId]
	self.miscData = ResOpActTowerMisc[actId]
	self.hookItemId = self.miscData.deposit_addon_id
	self.RECOVERY_INTERVAL = self.miscData.recover_time * 60
	self.RECOVERY_NUM = self.miscData.recover_add
	self.ENERGT_MAX = self.miscData.energy_max
	self.SWEEP_MAX = self.miscData.limit_layer

	if self.clientTowerData[1] then
		self.limitTowerEnable = true
	else
		self.limitTowerEnable = false
	end

	for _, scoreInfo in pairs(ResOpActTowerScoreAward[self.actId] or {}) do
		if scoreInfo.achieve_award_id then
			scoreInfo.achieve_rand_id = ResOpActTowerScoreAchieveAward[scoreInfo.achieve_award_id].achieve_award_id
		end
	end
end

local GROUP_TOWER_START_ID = 100

function ActivityDataSeasonTower:updateMgrData(opActivityMgrItem)
	self.mgrData = opActivityMgrItem.specdata.tower
	self.season = self.mgrData.season
	self.group = self.mgrData.group

	if not self.clientGroupData[self.group] then
		self.group = 1
	end

	self.thisWeekConfig = {}

	for index, info in ipairs(self.clientGroupData[self.group].limit_group) do
		self.thisWeekConfig[index + GROUP_TOWER_START_ID] = info
	end

	self.startTime = self.mgrData.open_time
	self.endTime = self.mgrData.wind_time
	self.allOverTime = self.mgrData.end_time

	if self.season ~= self.roleSeason then
		self.towerLayer = {}
		self.towerRoleData = {}
		self.score = 0
		self.scoreAward = {}
	end

	self.playerUid = CurAvatar.uid

	self:refreshTowerBuffData()
	self.timerRefreshBuff:Restart()
	self:initClientBuffCache()
end

function ActivityDataSeasonTower:updateSystemData(systemItem)
	return
end

function ActivityDataSeasonTower:updateRoleData(roleData)
	self.roleSeason = roleData.tower.season
	self.lastEnergyTick = roleData.tower.last_energy_tick
	self.energy = roleData.tower.energy

	if self.season == nil or self.season == self.roleSeason then
		self.towerLayer = {}
		self.towerRoleData = {}

		for index, tInfo in ipairs(roleData.tower.item) do
			local towerId = tInfo.tower_id

			self.towerLayer[tInfo.tower_id] = tInfo.max_layer

			local newInfo = {}

			newInfo.needSetBuff = tInfo.need_set_buff
			newInfo.layer = tInfo.max_layer
			newInfo.score = tInfo.score
			newInfo.bossMaxHp = tInfo.boss_max_hp
			self.towerRoleData[towerId] = newInfo
		end
	end

	self.sweepBaseLayer = roleData.tower.sweep_layer
	self.score = roleData.tower.score
	self.scoreAward = ClientUtils.getBitsDictFromByteString(roleData.tower.score_awarded)
	self.achieveAward = CurAvatar.serasonTowerAchieveAward or {}
	self.bonus = roleData.tower.deposit_item
	self.bonusTime = roleData.tower.deposit_time
	self.bonusMaxTime = roleData.tower.deposit_end_time
	self.lastGetTick = roleData.tower.last_get_tick
	self.lastAchieveAward = ClientUtils.getBitsDictFromByteString(roleData.tower.last_achieve_awarded)
	self.extraItemDropSpeed = roleData.tower.item_speed_addon
end

function ActivityDataSeasonTower:getTowerBuffs(towerId)
	local buffs = {}

	if self.towerBuffs[towerId] then
		for _, buffInfo in ipairs(self.towerBuffs[towerId]) do
			if buffInfo[3] and buffInfo[3] > 0 then
				table.insert(buffs, buffInfo)
			end
		end
	end

	for _, buffId in ipairs(self.sysBuffs) do
		table.insert(buffs, {
			0,
			[3] = buffId
		})
	end

	return buffs
end

function ActivityDataSeasonTower:getTowerBuffMaster(towerId, layer)
	local towerBuffData = self.towerBuffs[towerId]

	if towerBuffData then
		for _, buffInfo in ipairs(towerBuffData) do
			if buffInfo[1] == layer then
				return buffInfo[2], buffInfo[3]
			end
		end
	end
end

function ActivityDataSeasonTower:getRemainOpenTime()
	return self.endTime - ClientUtils.getServerTime()
end

function ActivityDataSeasonTower:getFreezeOpenTime()
	return self.allOverTime - ClientUtils.getServerTime()
end

function ActivityDataSeasonTower:willEnd()
	local remOpenTime = self:getRemainOpenTime()

	if remOpenTime > 0 then
		local remFreezeTime = self:getFreezeOpenTime()

		return remFreezeTime <= 86400
	end
end

function ActivityDataSeasonTower:willEndCountDown()
	return 86400 - (self.allOverTime - self.endTime)
end

function ActivityDataSeasonTower:isDataValid()
	if self.endTime and self.allOverTime and ClientUtils.getServerTime() > self.allOverTime then
		return false
	end

	return true
end

function ActivityDataSeasonTower:checkScoreAchieveNew()
	for index, achieInfo in ipairs(ResOpActTowerScoreAward[self.actId]) do
		if self.score >= achieInfo.score_need and not self.scoreAward[index] then
			return true
		end
	end
end

function ActivityDataSeasonTower:checkNew()
	if self:checkScoreAchieveNew() then
		return true
	end

	local enableTowerId = self:getEnableTowerList()

	for _, towerId in ipairs(enableTowerId) do
		local newFlyBuff = self:getTowerBuffNewFly(towerId)

		if newFlyBuff then
			return true
		end

		local newGetBuff = self:getTowerBuffNewGet(towerId)

		if newGetBuff then
			return true
		end
	end

	local hasItem = self:getHookBonusNum()

	if hasItem > 0 then
		if self:getRemainOpenTime() < 0 and self:getFreezeOpenTime() > 0 then
			return true
		end

		if ClientUtils.getServerTime() - self.lastGetTick > 43200 then
			return true
		end
	end
end

function ActivityDataSeasonTower:isOver()
	return
end

function ActivityDataSeasonTower:getEnergy()
	if self.lastEnergyTick then
		local passedTime = math.max(0, ClientUtils.getServerTime() - self.lastEnergyTick)

		return math.min(self.ENERGT_MAX, self.energy + math.floor(passedTime / self.RECOVERY_INTERVAL) * self.RECOVERY_NUM)
	end

	return 0
end

function ActivityDataSeasonTower:isTowerSweeped()
	local firstId = 1 + GROUP_TOWER_START_ID
	local roleData = self.towerRoleData[firstId]

	if roleData then
		return roleData.layer > 0
	end

	return false
end

function ActivityDataSeasonTower:getCanSweepMaxLayer(towerId)
	if not self.limitTowerEnable then
		local roleData = self.towerRoleData[towerId]

		if roleData then
			return math.min(self.SWEEP_MAX, self.sweepBaseLayer + (self.towerAddSweepData[towerId] or 0))
		end
	end

	return 0
end

function ActivityDataSeasonTower:getGroupTowerData()
	local groupTowerData = {}

	for index, info in ipairs(self.clientGroupData[self.group].limit_group) do
		local towerId = index + GROUP_TOWER_START_ID

		table.insert(groupTowerData, self:getTowerData(towerId))
	end

	return groupTowerData
end

function ActivityDataSeasonTower:getTowerData(towerId)
	local oneGroupData = {}
	local baseGroupData = self:getOneTowerData(towerId)

	baseGroupData.locked = self:isTowerLocked(towerId)

	table.insert(oneGroupData, baseGroupData)

	if (self.towerLayer[towerId] or 0) >= #self.clientStageData[towerId] then
		if self.cachedTowerLocked[towerId] == false then
			CurAvatar:addNewDataCache(Const.NEW_DATA_CACHE_SEASON_TOWER, towerId - GROUP_TOWER_START_ID)

			self.cachedTowerLocked[towerId] = true
		end

		for _, lockTower in ipairs(baseGroupData.lockTower) do
			if self.limitTowerEnable then
				table.insert(oneGroupData, self:getOneTowerData(lockTower))
			end
		end

		baseGroupData.isFinish = true
	else
		self.cachedTowerLocked[towerId] = false
	end

	return oneGroupData
end

Const.SEASON_TOWER_TYPE_LIMIT = 1
Const.SEASON_TOWER_TYPE_GROUP = 2

function ActivityDataSeasonTower:getOneTowerData(towerId)
	local towerData = {}

	towerData.towerId = towerId
	towerData.stageData = self.clientStageData[towerId]
	towerData.towerConfig = self.clientTowerData[towerId]
	towerData.towerType = self.clientTowerData[towerId].type

	if towerData.towerType == Const.SEASON_TOWER_TYPE_GROUP then
		local weekConfig = self.thisWeekConfig[towerId]

		towerData.weekConfig = weekConfig
		towerData.teamLimit = weekConfig.group_limit
		towerData.lockTower = {
			weekConfig.first,
			weekConfig.second
		}
	end

	towerData.passedLayer = self.towerLayer[towerId] or 0
	towerData.isOver = towerData.passedLayer >= #towerData.stageData
	towerData.towerRoleData = self.towerRoleData[towerId]

	return towerData
end

function ActivityDataSeasonTower:getParentTowerId(towerId)
	if self.clientTowerData[towerId] and self.clientTowerData[towerId].type == Const.SEASON_TOWER_TYPE_GROUP then
		return towerId
	else
		for pTowerId, weekConfig in pairs(self.thisWeekConfig or {}) do
			if weekConfig.first == towerId or weekConfig.second == towerId then
				return pTowerId
			end
		end
	end
end

function ActivityDataSeasonTower:getTowerName(towerId, levelId)
	local levelName = ""
	local data1 = ResOpActTowerStage[towerId] and ResOpActTowerStage[towerId][levelId] or nil

	if data1 then
		levelName = data1.name
	end

	local towerConfig = self.clientTowerData[towerId] or {}

	if towerConfig.type == Const.SEASON_TOWER_TYPE_GROUP then
		local weekConfig = self.thisWeekConfig[towerId]

		if weekConfig then
			return weekConfig.name .. " " .. levelName or levelName
		end
	else
		return towerConfig.name .. " " .. levelName or levelName
	end
end

function ActivityDataSeasonTower:isTowerLocked(towerId)
	if self:getRemainOpenTime() < 0 then
		return true, nil
	end

	towerId = self:getParentTowerId(towerId)

	local towerConfig = self.clientTowerData[towerId]

	if towerConfig.day_limit then
		local nextDay = 0
		local todayLast = Const.TIME_ONE_DAY - (ClientUtils.getServerTime() - ClientUtils.getServerTimeTodayStart())
		local day = math.floor((ClientUtils.getServerTime() - self.startTime) / Const.TIME_ONE_DAY) + 1

		for _, datNum in ipairs(towerConfig.day_limit) do
			if datNum == day then
				local isLast = false
				local continueDay = 0

				for index = 1, 10 do
					local has = false

					for _, newNum in ipairs(towerConfig.day_limit) do
						if newNum == datNum + index then
							has = true

							break
						end
					end

					if has then
						continueDay = index
					else
						break
					end
				end

				if datNum + continueDay == towerConfig.day_limit[#towerConfig.day_limit] then
					isLast = true
				end

				if isLast then
					return false, math.min(self:getRemainOpenTime(), todayLast + Const.TIME_ONE_DAY * continueDay), true
				else
					return false, todayLast + Const.TIME_ONE_DAY * continueDay, false
				end
			elseif day < datNum and nextDay == 0 then
				nextDay = datNum
			end
		end

		return true, todayLast + Const.TIME_ONE_DAY * (nextDay - day - 1)
	else
		return false, nil
	end
end

function ActivityDataSeasonTower:refreshTowerBuffData()
	if self.playerUid == CurAvatar.uid then
		local enableTowerId = self:getEnableTowerList()

		if #enableTowerId > 0 then
			RPC.opActTowerGetBuff(self.actObject.opId, enableTowerId, 1, 1)
		end
	elseif self.timerRefreshBuff then
		self.timerRefreshBuff:Stop()
	end
end

function ActivityDataSeasonTower:getEnableTowerList()
	local enableTowerId = {}
	local towerData = self:getGroupTowerData()

	for index, groupData in ipairs(towerData) do
		local baseGroupData = groupData[1]

		if not baseGroupData.locked then
			if baseGroupData.isFinish and groupData[2] and groupData[3] then
				table.insert(enableTowerId, groupData[2].towerId)
				table.insert(enableTowerId, groupData[3].towerId)
			else
				table.insert(enableTowerId, baseGroupData.towerId)
			end
		end
	end

	return enableTowerId
end

function ActivityDataSeasonTower:onOpActTowerGetBuffResp(item, sys_buff_id)
	local sysAddScore = 0

	self.sysBuffs = {}

	for _, buffId in ipairs(sys_buff_id) do
		table.insert(self.sysBuffs, buffId)

		if ResOpActTowerBuff[buffId] and ResOpActTowerBuff[buffId].sweep_addon then
			sysAddScore = sysAddScore + ResOpActTowerBuff[buffId].sweep_addon
		end
	end

	for _, buffInfo in ipairs(item) do
		local thisTowerScore = sysAddScore
		local towerId = buffInfo.tower_id
		local newBuffs = {}

		for _, layerInfo in ipairs(buffInfo.layer) do
			local otherPlayer = OtherPlayer()

			otherPlayer:initDataByCommonData(layerInfo.buff.role_simple_comm)

			otherPlayer.updateTick = layerInfo.update_time

			table.insert(newBuffs, {
				layerInfo.layer,
				otherPlayer,
				layerInfo.buff.buff_id
			})

			if ResOpActTowerBuff[layerInfo.buff.buff_id] and ResOpActTowerBuff[layerInfo.buff.buff_id].sweep_addon then
				thisTowerScore = thisTowerScore + ResOpActTowerBuff[layerInfo.buff.buff_id].sweep_addon
			end
		end

		self.towerBuffs[towerId] = newBuffs
		self.towerAddSweepData[towerId] = thisTowerScore
	end

	self.actObject:checkNew()

	local activitySeasonTowerChooseDlg = UIManager.tryGetUI("activitySeasonTowerChooseDlg")

	if activitySeasonTowerChooseDlg then
		activitySeasonTowerChooseDlg:onNewRefresh()
	end

	local activitySeasonTowerInfoDlg = UIManager.tryGetUI("activitySeasonTowerInfoDlg")

	if activitySeasonTowerInfoDlg then
		activitySeasonTowerInfoDlg:onNewRefresh()
	end
end

function ActivityDataSeasonTower:onOpActTowerUpdateBuffNotify(buffInfo)
	local towerId = buffInfo.tower_id
	local newBuffs = self.towerBuffs[towerId] or {}
	local setLayer = false

	for _, layerInfo in ipairs(buffInfo.layer) do
		local otherPlayer = OtherPlayer()

		otherPlayer:initDataByCommonData(layerInfo.buff.role_simple_comm)

		otherPlayer.updateTick = layerInfo.update_time

		for _, hasInfo in ipairs(newBuffs) do
			if hasInfo[1] == layerInfo.layer then
				hasInfo[2] = otherPlayer
				hasInfo[3] = layerInfo.buff.buff_id
				setLayer = layerInfo.layer

				break
			end
		end

		if not setLayer then
			table.insert(newBuffs, {
				layerInfo.layer,
				otherPlayer,
				layerInfo.buff.buff_id
			})

			setLayer = layerInfo.layer

			if ResOpActTowerBuff[layerInfo.buff.buff_id] and ResOpActTowerBuff[layerInfo.buff.buff_id].sweep_addon then
				self.towerAddSweepData[towerId] = (self.towerAddSweepData[towerId] or 0) + ResOpActTowerBuff[layerInfo.buff.buff_id].sweep_addon
			end
		end
	end

	self.towerBuffs[towerId] = newBuffs

	if setLayer then
		local infoDlg = UIManager.tryGetUI("activitySeasonTowerInfoDlg")

		if infoDlg then
			infoDlg:onOpActTowerUpdateBuffNotify(towerId, setLayer)
		end
	end
end

local BASE_RATE = 100000

function ActivityDataSeasonTower:getHookBonus(container)
	container = container or {}

	if self.bonus then
		local num = tonumber(self.bonus.num)

		if self.bonus and self.bonus.id > 0 and num >= BASE_RATE then
			local preNum = 0

			if container[self.bonus.id] then
				preNum = container[self.bonus.id][1] or 0
			end

			container[self.bonus.id] = {
				preNum + math.floor(num / BASE_RATE),
				self.actObject
			}
		end
	end

	return container
end

function ActivityDataSeasonTower:getDepositValue()
	local dropValue = 0

	for towerId, passedLayer in pairs(self.towerLayer or {}) do
		local stageData = self.clientStageData[towerId] or {}

		stageData = stageData[passedLayer] or {}

		if stageData.hour_drop_count then
			dropValue = dropValue + stageData.hour_drop_count
		end
	end

	dropValue = dropValue + (self.extraItemDropSpeed or 0)

	return dropValue
end

function ActivityDataSeasonTower:getHookBonusNum()
	local num = 0

	if self.bonus then
		num = tonumber(self.bonus.num)

		if num and self.bonus.id > 0 then
			num = num / BASE_RATE
		end

		local hookTime = math.min(ClientUtils.getServerTime(), self.bonusMaxTime) - self.bonusTime

		if hookTime > 0 then
			local dropValue = self:getDepositValue()

			num = num + hookTime / 3600 * dropValue
		end

		num = math.floor(num)
	end

	return num
end

function ActivityDataSeasonTower:initClientBuffCache()
	local buffs = UserData.getClientData(Const.USER_KEY_SEAON_TOWER_BUFF) or {}
	local season = buffs.season

	if season ~= self.season then
		self.buffCache = {}
		self.buffCache.season = self.season
	else
		self.buffCache = buffs
	end

	self.actObject:checkNew()
end

function ActivityDataSeasonTower:getTowerBuffNew(towerId)
	if self:getTowerBuffNewFly(towerId) then
		return true
	end

	if self:getTowerBuffNewGet(towerId) then
		return true
	end

	return false
end

function ActivityDataSeasonTower:getTowerBuffNewFly(towerId)
	local buffs = self:getTowerBuffs(towerId)
	local nowBuff = self.buffCache[towerId] or {}
	local nowFlyBuffs = nowBuff[1] or {}
	local newBuffs = {}

	for _, buff in ipairs(buffs) do
		local buffId = buff[3]

		if buffId and buffId > 0 then
			local has = false

			for _, rbuff in ipairs(nowFlyBuffs) do
				if rbuff == buffId then
					has = true

					break
				end
			end

			if not has then
				table.insert(newBuffs, buff)
			end
		end
	end

	if #newBuffs == 0 then
		return nil
	else
		return newBuffs
	end
end

function ActivityDataSeasonTower:getTowerBuffNewGet(towerId)
	local buffs = self:getTowerBuffs(towerId)
	local nowBuff = self.buffCache[towerId] or {}
	local nowGetBuffs = nowBuff[2] or {}
	local newBuffs = {}

	for _, buff in ipairs(buffs) do
		local buffId = buff[3]

		if buffId and buffId > 0 then
			local has = false

			for _, rbuff in ipairs(nowGetBuffs) do
				if rbuff == buffId then
					has = true

					break
				end
			end

			if not has then
				table.insert(newBuffs, buff)
			end
		end
	end

	if #newBuffs == 0 then
		return nil
	else
		return newBuffs
	end
end

function ActivityDataSeasonTower:saveTowerBuffNewFly(towerId)
	local buffs = self:getTowerBuffs(towerId)
	local newFlyBuffs = {}

	for _, buff in ipairs(buffs) do
		local buffId = buff[3]

		if buffId and buffId > 0 then
			table.insert(newFlyBuffs, buffId)
		end
	end

	if not self.buffCache[towerId] then
		self.buffCache[towerId] = {}
	end

	self.buffCache[towerId][1] = newFlyBuffs

	UserData.setClientData(Const.USER_KEY_SEAON_TOWER_BUFF, self.buffCache)
end

function ActivityDataSeasonTower:saveTowerBuffNewGet(towerId)
	local buffs = self:getTowerBuffs(towerId)
	local newGetBuffs = {}

	for _, buff in ipairs(buffs) do
		local buffId = buff[3]

		if buffId and buffId > 0 then
			table.insert(newGetBuffs, buffId)
		end
	end

	if not self.buffCache[towerId] then
		self.buffCache[towerId] = {}
	end

	self.buffCache[towerId][2] = newGetBuffs

	UserData.setClientData(Const.USER_KEY_SEAON_TOWER_BUFF, self.buffCache)
	self.actObject:checkNew()

	local activitySeasonTowerInfoDlg = UIManager.tryGetUI("activitySeasonTowerInfoDlg")

	if activitySeasonTowerInfoDlg then
		activitySeasonTowerInfoDlg:onNewRefresh()
	end

	local activitySeasonTowerChooseDlg = UIManager.tryGetUI("activitySeasonTowerChooseDlg")

	if activitySeasonTowerChooseDlg then
		activitySeasonTowerChooseDlg:onNewRefresh()
	end
end

function ActivityDataSeasonTower:getEnergyInfo()
	return "Atlas/CommonAtlas/IconAtlas/ItemBagAtlas/08", "128", self:getEnergy(), 1
end

function ActivityDataSeasonTower:getCachedTowerRule(towerId)
	local nowBuff = self.buffCache[towerId] or {}
	local nowGetBuffs = nowBuff[3]

	if nowGetBuffs == 1 then
		return false
	else
		return true
	end
end

function ActivityDataSeasonTower:saveTowerRuleCached(towerId)
	if not self.buffCache[towerId] then
		self.buffCache[towerId] = {}
	end

	self.buffCache[towerId][3] = 1

	UserData.setClientData(Const.USER_KEY_SEAON_TOWER_BUFF, self.buffCache)
end

function ActivityDataSeasonTower:hasLimitTower()
	return self.limitTowerEnable
end

function ActivityDataSeasonTower:getScoreNextProgress()
	local preScore = 0

	for index, achieInfo in ipairs(ResOpActTowerScoreAward[self.actId]) do
		if not self.scoreAward[index] then
			return achieInfo.score_need, math.min(1, (self.score - preScore) / (achieInfo.score_need - preScore))
		else
			preScore = achieInfo.score_need
		end
	end

	return nil, 1
end

function ActivityDataSeasonTower:getBossMaxHp(towerId, layer)
	local stageData = self.clientStageData[towerId] or {}

	stageData = stageData[layer]

	local towerData = self.towerRoleData[towerId]

	if towerData and stageData then
		local bossConfig = ResOpActTowerBossAward[stageData.boss_id]

		if layer > (self.towerLayer[towerId] or 0) + 1 then
			return 0
		elseif layer == (self.towerLayer[towerId] or 0) + 1 then
			local bossMaxHp = towerData.bossMaxHp or 0

			if bossConfig then
				return math.floor(bossMaxHp / bossConfig.item_per_hp)
			end
		elseif bossConfig then
			return bossConfig.max_score or 0
		end
	end

	return 0
end

function ActivityDataSeasonTower:getBossScoreByHp(hp, towerId, layer)
	local stageData = self.clientStageData[towerId] or {}

	stageData = stageData[layer]

	if stageData then
		local bossConfig = ResOpActTowerBossAward[stageData.boss_id]

		if bossConfig then
			return math.floor(hp / bossConfig.item_per_hp)
		end
	end

	return 0
end

return ActivityDataSeasonTower
