-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/Avatar\\AvatarMixins\\OpActivity\\ActivityDataSneakBattle.lua

local ActivityDataBase = require("Avatar/AvatarMixins/OpActivity/ActivityDataBase")
local ResNewPveIndex = require("ClientData/ResNewPveIndex")
local ResNewPveLevel = require("ClientData/ResNewPveLevel")
local ResNewPveStage = require("ClientData/ResNewPveStage")
local ResNewPveBuff = require("ClientData/ResNewPveBuff")
local ResRandClient = require("ClientData/ResRandClient")
local ResBattleConfig = require("ClientData/ResBattleConfig")
local ResNewPveShow = require("ClientData/ResNewPveShow")
local ResBattleTarget = require("ClientData/ResBattleTarget")
local ResNewPveMisc = require("ClientData/ResNewPveMisc")
local ResBattleFormationLimit = require("ClientData/ResBattleFormationLimit")
local ResBattleFormationLimitLib = require("ClientData/ResBattleFormationLimitLib")
local ResNewPveAchieve = require("ClientData/ResNewPveAchieve")
local ActivityDataSneakBattle = Class("ActivityDataSneakBattle", ActivityDataBase)

function ActivityDataSneakBattle:ctor(...)
	return
end

function ActivityDataSneakBattle:updateRoleData(roleData)
	local pveData = roleData.new_pve

	if pveData.week_best_record then
		self.bestRecord = pveData.week_best_record
	end

	local nowIndex = pveData.week_index
	local index = self.modeIndex
	local changeFlag = false

	if index and nowIndex ~= index then
		changeFlag = true
	end

	self.modeIndex = pveData.week_index

	if self.modeIndex and ResNewPveIndex[self.modeIndex] then
		self.type = ResNewPveIndex[self.modeIndex].type
	end

	if pveData.level and pveData.stage_data then
		self.nowSelectLevel = pveData.level or 1

		if pveData.stage_data then
			if not self.stageData then
				self.stageData = {}
			end

			for i, data in ipairs(pveData.stage_data) do
				local stage = data.stage

				self.stageData[stage] = data
			end
		end
	end

	self.curPassStage = pveData.cur_pass_stage or 0

	self:repRelicData()

	if changeFlag then
		self:onNewIndex()
	end

	self.needPopUp = pveData.need_popup
	self.lockedStage = pveData.reset_stage or 0
end

function ActivityDataSneakBattle:isInFrozenTime(...)
	local leftTime = self:getCurLeftTime()

	if leftTime <= 0 then
		return true
	end

	local freezeTime = self:getConfigFrozenTime()

	return leftTime <= freezeTime
end

function ActivityDataSneakBattle:getConfigFrozenTime(...)
	local freezeMinites = ResNewPveMisc[self.actObject.actId or 1309].freeze_time or 360

	return freezeMinites * 60
end

function ActivityDataSneakBattle:getEndTime(...)
	if self.serverData then
		return self.serverData.close_tick
	end
end

function ActivityDataSneakBattle:getCurLeftTime(...)
	return math.max(0, (self:getEndTime() or 0) - ClientUtils.getServerTime())
end

function ActivityDataSneakBattle:refreshUI(...)
	return
end

function ActivityDataSneakBattle:updateMgrData(mgrData)
	local pveData = mgrData.specdata.new_pve

	if pveData then
		self.serverData = pveData

		if self.modeIndex and ResNewPveIndex[self.modeIndex] then
			self.type = ResNewPveIndex[self.modeIndex].type
		end
	end
end

function ActivityDataSneakBattle:getSneakBattlePersistentData(type)
	local tYpe = type or self.type

	if tYpe then
		return CurAvatar:getSneakBattlePersistentData(tYpe)
	end
end

function ActivityDataSneakBattle:getStageResDataByLevel(level)
	if self.type and ResNewPveLevel[self.type] and ResNewPveLevel[self.type][level] then
		local libID = ResNewPveLevel[self.type][level].lib_id

		if libID and ResNewPveStage[libID] then
			return ResNewPveStage[libID]
		end
	end
end

function ActivityDataSneakBattle:getBuffResData(...)
	if self.modeIndex then
		local buffId = ResNewPveIndex[self.modeIndex].buff or 1

		return ResNewPveBuff[buffId]
	end
end

function ActivityDataSneakBattle:getMaxWeekAwardStage(level)
	if self.stageData then
		for index, data in pairs(self.stageData) do
			if level > data.awarded_level then
				return index
			end
		end
	end

	return 0
end

function ActivityDataSneakBattle:getLevelWeekAwardData(level, stage)
	if not level or not self.type or not ResNewPveLevel[self.type][level] then
		return
	end

	local libID = ResNewPveLevel[self.type][level].lib_id
	local passLevel = self.stageData[stage].awarded_level or 0
	local libIDs = {}

	for i = 1, level do
		if (passLevel < i or i == level) and ResNewPveLevel[self.type][i] and ResNewPveLevel[self.type][i].lib_id then
			table.insert(libIDs, ResNewPveLevel[self.type][i].lib_id)
		end
	end

	local awards = {}

	for k, v in ipairs(libIDs) do
		if ResNewPveStage[v] and ResNewPveStage[v][stage] and ResNewPveStage[v][stage].week_award then
			table.insert(awards, ResNewPveStage[v][stage].week_award)
		end
	end

	return awards, level <= passLevel
end

function ActivityDataSneakBattle:getLevelWeekAwardShow(level, stage)
	if not level or not stage then
		return {}
	end

	local awards, state = self:getLevelWeekAwardData(level, stage)

	if not awards or #awards == 0 then
		return {}
	end

	local showIds = {}
	local showNums = {}
	local visMap = {}

	for _, id in pairs(awards) do
		if ResRandClient[id] then
			for index, showId in ipairs(ResRandClient[id].show_ids) do
				if not visMap[showId] then
					table.insert(showIds, showId)

					local num = ResRandClient[id].show_nums[index] or 0

					table.insert(showNums, num)

					visMap[showId] = #showIds
				else
					local num = ResRandClient[id].show_nums[index] or 0
					local pos = visMap[showId]

					showNums[pos] = showNums[pos] + num
				end
			end
		end
	end

	return showIds, showNums, state
end

function ActivityDataSneakBattle:getStageCount(level)
	local stageData = self:getStageResDataByLevel(level)

	if stageData then
		return #stageData
	end
end

function ActivityDataSneakBattle:checkLevelUnlocked(level)
	local persisDentData = self:getSneakBattlePersistentData()
	local passLevel = 0
	local passStage = 0

	if persisDentData and persisDentData.passData then
		if persisDentData.passData.pass_level then
			passLevel = persisDentData.passData.pass_level
		end

		if persisDentData.passData.pass_stage then
			passStage = persisDentData.passData.pass_stage
		end
	end

	if not level then
		return
	end

	if level == 1 then
		return true
	end

	if level > passLevel + 1 then
		return false
	elseif level == passLevel + 1 then
		local stageCount = self:getStageCount(passLevel)

		return stageCount and passStage and stageCount == passStage
	else
		return true
	end
end

function ActivityDataSneakBattle:getLevelMaxProgress(level)
	if not level then
		return
	end

	local persisDentData = self:getSneakBattlePersistentData()
	local passLevel = 0
	local passStage = 0

	if persisDentData and persisDentData.passData then
		if persisDentData.passData.pass_level then
			passLevel = persisDentData.passData.pass_level
		end

		if persisDentData.passData.pass_stage then
			passStage = persisDentData.passData.pass_stage
		end
	end

	if level < passLevel then
		local count = self:getStageCount(level) or 0

		return count
	elseif level == passLevel then
		return passStage
	else
		return 0
	end
end

function ActivityDataSneakBattle:getLevelState(level)
	if not level then
		return {}
	end

	local data = {}

	data.unLock = self:checkLevelUnlocked(level)

	local persisDentData = self:getSneakBattlePersistentData()

	return data
end

local function sortAwardDataById(a, b)
	if not a or not b or not a.id or not b.id then
		return
	end

	return a.id < b.id
end

function ActivityDataSneakBattle:getTypeName(type)
	for i, data in pairs(ResNewPveIndex) do
		if data.type == type then
			return data.name
		end
	end
end

function ActivityDataSneakBattle:getAccomplishAwardData(type)
	local tYpe = type or self.type
	local tYpeName = self:getTypeName(tYpe) or ""

	if tYpe then
		local persisDentData = self:getSneakBattlePersistentData(tYpe)
		local passLevel = 0
		local passStage = 0
		local datas = {}

		if ResNewPveAchieve[tYpe] then
			for index, data in ipairs(ResNewPveAchieve[tYpe]) do
				local level = data.level
				local levelPsData

				if persisDentData then
					levelPsData = persisDentData[level]

					if persisDentData.passData then
						passLevel = persisDentData.passData.pass_level or 0
						passStage = persisDentData.passData.pass_stage or 0
					end
				end

				local newData = {}

				newData.award_id = data.award_id
				newData.got = persisDentData and persisDentData.achieveGot and persisDentData.achieveGot[index]

				if not newData.got then
					newData.got = false
				end

				newData.id = data.id
				newData.can = levelPsData and levelPsData.strongPassNum and data.strong_pass_num and levelPsData.strongPassNum >= data.strong_pass_num

				local levelName = self:getLevelName(level, tYpe)

				if data.desc then
					newData.desc = data.desc
				end

				newData.notClaimed = newData.can and not newData.got
				newData.sortIndex = level * 100 + data.strong_pass_num

				if not newData.notClaimed then
					newData.notClaimed = false
				end

				table.insert(datas, newData)
			end
		end

		return datas
	end

	return {}
end

function ActivityDataSneakBattle:getSortedAccomplishAwardData(type)
	if not type then
		return {}
	end

	local awardData = self:getAccomplishAwardData(type)

	if awardData then
		local function sortAward(a, b)
			if a.notClaimed ~= b.notClaimed then
				return a.notClaimed
			elseif a.got ~= b.got then
				return b.got
			else
				return a.sortIndex < b.sortIndex
			end
		end

		table.sort(awardData, sortAward)

		return awardData
	end
end

function ActivityDataSneakBattle:getNowLevelStageData(...)
	local stageData = {}
	local resStageData = self:getStageResDataByLevel(self.nowSelectLevel)

	if self.stageData and resStageData then
		for stage, data in ipairs(resStageData) do
			local oneStage = utils.deepcopy(data)

			if self.stageData[stage] then
				local svrData = self.stageData[stage]

				oneStage.weakPass = svrData.pass_type == 2
				oneStage.strongPass = svrData.pass_type == 1
				oneStage.limit = svrData.limit
				oneStage.formation = svrData.formation
				oneStage.canEnter = stage <= self.curPassStage + 1
				oneStage.canChange = self:checkCanChangeStage(stage)
			end

			table.insert(stageData, oneStage)
		end
	end

	return stageData
end

function ActivityDataSneakBattle:checkCanEnterStage(...)
	local stageData = self:getNowLevelStageData()

	if stageData and #stageData ~= 0 then
		for i, stage in ipairs(stageData) do
			if stage.need_limit and stage.need_limit == 1 and (not stage.limit or stage.limit == 0) then
				return false
			end
		end

		return true
	end
end

function ActivityDataSneakBattle:addHeroSneakState(heros, StageData)
	local stageData = StageData or self.stageData
	local visMap = {}

	if stageData then
		for stage, data in ipairs(stageData) do
			if data.formation then
				local heros = data.formation.hero

				for _, hero in ipairs(heros) do
					if hero.resid then
						visMap[hero.resid] = stage
					end
				end
			end
		end
	end

	if heros then
		for _, hero in ipairs(heros) do
			hero.canUse = 0
			hero.power = hero:getCapacity()

			if hero.id and visMap[hero.id] then
				hero.sneakState = 1
				hero.sneakStage = -visMap[hero.id]

				if visMap[hero.id] <= self.curPassStage then
					if visMap[hero.id] == self.lockedStage then
						hero.canUse = 1
					end
				else
					hero.canUse = 1
				end
			else
				hero.canUse = 1
				hero.sneakStage = 0
				hero.sneakState = 2
			end
		end
	end

	return heros
end

function ActivityDataSneakBattle:getAllLimitsResData(...)
	local limitIds = {}

	if self.modeIndex and ResNewPveIndex[self.modeIndex] then
		local libId = ResNewPveIndex[self.modeIndex].limit_lib_id or 1

		if libId and ResBattleFormationLimitLib[libId] then
			for _, data in pairs(ResBattleFormationLimitLib[libId]) do
				table.insert(limitIds, data.limit_id)
			end
		end
	end

	local limitDatas = {}

	for index, limitId in ipairs(limitIds) do
		if limitId and ResBattleFormationLimit[limitId] then
			table.insert(limitDatas, ResBattleFormationLimit[limitId])
		end
	end

	return limitDatas
end

function ActivityDataSneakBattle:getAllLimitsData(...)
	local visMap = {}

	if self.stageData then
		for stage, data in ipairs(self.stageData) do
			if data.limit and data.limit ~= 0 then
				visMap[data.limit] = stage
			end
		end
	end

	local data = {}
	local resData = self:getAllLimitsResData()

	for i, limit in ipairs(resData) do
		local oneLimit = utils.deepcopy(limit)

		if limit.id and visMap[limit.id] and visMap[limit.id] ~= 0 then
			oneLimit.stage = visMap[limit.id]
		else
			oneLimit.stage = 0
		end

		table.insert(data, oneLimit)
	end

	return data
end

function ActivityDataSneakBattle:getSortedLimitData(...)
	local data = self:getAllLimitsData()

	local function sortLimit(a, b)
		if a.stage ~= b.stage then
			if a.stage == 0 or b.stage == 0 then
				return a.stage > b.stage
			else
				return a.stage < b.stage
			end
		else
			return a.id < b.id
		end
	end

	table.sort(data, sortLimit)

	return data
end

function ActivityDataSneakBattle:getLimitResDataById(id)
	if id and ResBattleFormationLimit[id] then
		return ResBattleFormationLimit[id]
	end
end

function ActivityDataSneakBattle:cheakCanChangeLimit()
	return self.curPassStage == 0
end

function ActivityDataSneakBattle:checkHaveLimitStage(...)
	local stageData = self:getNowLevelStageData()

	if stageData then
		for stage, data in ipairs(stageData) do
			if data.need_limit and data.need_limit == 1 then
				return true
			end
		end
	end

	return false
end

function ActivityDataSneakBattle:getCanWearRelicsInSeakBattle(hero)
	local outsideRelics = {}

	if Const.SNEAK_BATTLE_OPEN then
		for gid, relic in pairs(CurAvatar.bagRelics) do
			if self.relicHeroDic and (not self.relicHeroDic[relic.id] or self.relicHeroDic[relic.id] == hero.id) and relic:isCanBeWear(hero) and relic.heroIdLimit then
				local outsideRelic = BaseObject.CopyObject(relic)

				table.insert(outsideRelics, outsideRelic)
			end
		end
	end

	return outsideRelics
end

function ActivityDataSneakBattle:repRelicData(...)
	if not self.relicHeroDic then
		self.relicHeroDic = {}
		self.heroRelicDic = {}

		RPC.newPveGetCurFormation()
	end
end

function ActivityDataSneakBattle:setRelicHeroDic(svrData)
	if svrData then
		for _, data in pairs(svrData.formation) do
			self.relicHeroDic[data.relic_id] = data.resid
			self.heroRelicDic[data.resid] = data.relic_id
		end
	end
end

function ActivityDataSneakBattle:getSneakBattleUnFilterHeroDic(...)
	local sneakBattleHeroDic = {}

	for gid, hero in pairs(CurAvatar.heroDic) do
		local wearedRelic

		if self.heroRelicDic then
			local wearedRelicId = self.heroRelicDic[hero.id]

			if wearedRelicId and CurAvatar.bagRelics[wearedRelicId] then
				wearedRelic = BaseObject.CopyObject(CurAvatar.bagRelics[wearedRelicId])
			end
		end

		local sneakBattleHero = utils.getCircleBattleHero(hero, wearedRelic, true)

		if sneakBattleHero then
			sneakBattleHeroDic[sneakBattleHero.gid] = sneakBattleHero
		end
	end

	return sneakBattleHeroDic
end

function ActivityDataSneakBattle:getSneakBattleHeroDic(...)
	local unFilterHeroDic = self:getSneakBattleUnFilterHeroDic()
	local bestHeroMap = {}

	for gid, hero in pairs(unFilterHeroDic) do
		if not bestHeroMap[hero.id] then
			bestHeroMap[hero.id] = gid
		else
			local preHero = unFilterHeroDic[bestHeroMap[hero.id]]

			if preHero then
				if hero.star > preHero.star then
					bestHeroMap[hero.id] = gid
				elseif hero.star == preHero.star then
					local power = hero:getCapacity()
					local prePower = preHero:getCapacity()

					if prePower < power then
						bestHeroMap[hero.id] = gid
					elseif power == prePower and gid < bestHeroMap[hero.id] then
						bestHeroMap[hero.id] = gid
					end
				end
			end
		end
	end

	local sneakBattleHeroDic = {}

	for gid, hero in pairs(unFilterHeroDic) do
		if gid == bestHeroMap[hero.id] then
			sneakBattleHeroDic[gid] = hero
		end
	end

	return sneakBattleHeroDic
end

function ActivityDataSneakBattle:getCircleBattleHeroList(...)
	local heroDic = self:getSneakBattleHeroDic()
	local heroList = {}

	for _, hero in pairs(heroDic) do
		table.insert(heroList, hero)
	end

	return self:addHeroSneakState(heroList)
end

function ActivityDataSneakBattle:getCanDragHero(stage)
	local sneakBattleHeroDic = self:getSneakBattleHeroDic()
	local heros = {}

	if sneakBattleHeroDic then
		local visMap = {}
		local recommendMap = {}

		if self.stageData then
			for index, data in ipairs(self.stageData) do
				if data.stage ~= stage and data.stage <= self.curPassStage then
					for i, hero in ipairs(data.formation.hero) do
						visMap[hero.resid] = true
					end
				end

				if data.stage == stage then
					for i, hero in ipairs(data.formation.hero) do
						recommendMap[hero.resid] = true
					end
				end
			end
		end

		for _, hero in pairs(sneakBattleHeroDic) do
			if not visMap[hero.id] then
				if recommendMap[hero.id] then
					hero.recommend = 1
				else
					hero.recommend = 0
				end

				table.insert(heros, hero)
			end
		end
	end

	return heros
end

function ActivityDataSneakBattle:getRemainderLimit(stage)
	local limitIds = {}

	for index, data in ipairs(self.stageData) do
		if stage < data.stage and data.limit and data.limit ~= 0 then
			table.insert(limitIds, data.limit)
		end
	end

	return limitIds
end

function ActivityDataSneakBattle:getTargetsByPveId(pve_id)
	if pve_id and ResBattleConfig[pve_id] then
		local targetId = ResBattleConfig[pve_id].target_id

		if targetId and ResBattleTarget[targetId] then
			local target = ResBattleTarget[targetId].targets

			return target
		end
	end
end

function ActivityDataSneakBattle:checkCanEnterNewLevel(Level)
	if self:isInFrozenTime() == true then
		return false
	end

	local persisDentData = self:getSneakBattlePersistentData()
	local passLevel = 0
	local passStage = 0
	local tick = ClientUtils.getServerTime()

	if persisDentData and persisDentData.passData then
		passLevel = persisDentData.passData.pass_level or 0
		passStage = persisDentData.passData.pass_stage or 0
		tick = persisDentData.passData.pass_tick
	end

	Level = Level or passLevel + 1

	if Level <= passLevel then
		return true
	elseif Level == passLevel + 1 then
		if Level == 1 then
			return true
		else
			local stageCount = self:getStageCount(passLevel)

			if stageCount and passStage and stageCount == passStage then
				if ClientUtils.isTickToday(tick) then
					local desc = ""
					local time = utils.calcShortTimeTxt(ClientUtils.getServerTimeNextDay() - ClientUtils.getServerTime())

					if ResNewPveShow and ResNewPveShow[13090002] then
						desc = string.gsub(ResNewPveShow[13090002].desc, "$1", time)
					end

					return false, desc
				else
					return true
				end
			end
		end
	else
		return false
	end
end

function ActivityDataSneakBattle:getLevelName(level, type)
	local tYpe = type or self.type

	if tYpe and ResNewPveLevel[tYpe] and ResNewPveLevel[tYpe][level] then
		return ResNewPveLevel[tYpe][level].level_name
	end
end

function ActivityDataSneakBattle:getStageName(level, stage)
	if level then
		local stageData = self:getStageResDataByLevel(level)

		if stageData and stage and stageData[stage] then
			return stageData[stage].stage_name
		end
	end
end

function ActivityDataSneakBattle:checkNeedToLowerLevel()
	if self.hadToLoverLevel then
		return
	end

	if self.nowSelectLevel == 1 then
		self.needShowToLowerLevel = false

		return
	end

	local stageCount = self:getStageCount(self.nowSelectLevel - 1)
	local passStage = self.stageData and self.stageData[stageCount] and self.stageData[stageCount].awarded_level or 100

	self.needShowToLowerLevel = passStage < self.nowSelectLevel - 1
end

function ActivityDataSneakBattle:checkCanReset(...)
	if not self.resetTick then
		return true
	else
		local nowTime = ClientUtils.getServerTime()
		local cd = ResNewPveMisc[self.actObject.actId or 1309].reset_cd

		return nowTime > self.resetTick + cd
	end
end

function ActivityDataSneakBattle:checkHaveFormationData(...)
	if self.stageData then
		for _, data in ipairs(self.stageData or {}) do
			if data and data.formation then
				if data.formation.hero and #data.formation.hero ~= 0 then
					return true
				end

				if data.formation.pet_id and data.formation.pet_id ~= 0 then
					return true
				end
			end
		end
	end

	return false
end

function ActivityDataSneakBattle:checkFinishOneLevel(...)
	if self.finishOneLevel then
		self.finishOneLevel = false

		local keyStr = Const.ACT_TYPE_SNEAK_BATTLE .. self.type
		local showData = CurAvatar:getClientUserData(keyStr)
		local endTime = self:getEndTime()

		if not showData.showFinishTime then
			showData.showFinishTime = {}
			showData.showFinishTime[self.nowSelectLevel] = endTime

			CurAvatar:setClientUserData(keyStr, showData)

			return true
		end

		if not showData.showFinishTime[self.nowSelectLevel] or showData.showFinishTime[self.nowSelectLevel] ~= endTime then
			showData.showFinishTime[self.nowSelectLevel] = endTime

			CurAvatar:setClientUserData(keyStr, showData)

			return true
		end
	end

	return false
end

function ActivityDataSneakBattle:getBuffEffectId(...)
	local buffResData = self:getBuffResData()

	if buffResData and buffResData.effect then
		return buffResData.effect
	end
end

function ActivityDataSneakBattle:checkshowNewStageAni(...)
	if self.showNewStageAni then
		self.showNewStageAni = false

		return true
	end

	return false
end

function ActivityDataSneakBattle:checkHaveLockedStage()
	if self.lockedStage and self.lockedStage ~= 0 then
		return true, self.lockedStage
	end

	return false
end

function ActivityDataSneakBattle:checkCanChangeStage(stage)
	if not stage then
		return
	end

	if stage > (self.curPassStage or 0) then
		return true
	end

	if self.lockedStage and self.lockedStage ~= 0 then
		return self.lockedStage == stage
	end

	return false
end

function ActivityDataSneakBattle:getRemainderStages(...)
	local stageDatas = self:getNowLevelStageData()
	local count = self:getStageCount()

	if count <= self.curPassStage then
		return {}
	end

	local stages = {}

	if stageDatas then
		for i = self.curPassStage + 1, count do
			table.insert(stages, stageData[i])
		end
	end
end

function ActivityDataSneakBattle:getAutoPreFormation()
	local stages = self:getRemainderStages()

	if stages and #stages ~= 0 then
		local formations = {}
		local ResNewPveAutoFormation = require("ClientData/ResNewPveAutoFormation")
		local careerData = {}

		for career_id, data in pairs(ResNewPveAutoFormation) do
			careerData[data.priority] = {}
			careerData[data.priority].career = career_id
			careerData[data.priority].num = data.need_num
		end

		local heros = self:getCanDragHero(self.curPassStage + 1)

		for i = 1, #stages do
			local stageData = stages[i]
			local limit

			if stageData.limit and ResBattleFormationLimit[stageData.limit] then
				limit = ResBattleFormationLimit[stageData.limit]
			end

			local remainderLimitIds = self:getRemainderLimit(stageData.stage)
			local remainderLimits = {}

			for index, id in pairs(remainderLimitIds) do
				if ResBattleFormationLimit[id] then
					table.insert(remainderLimits, ResBattleFormationLimit[id])
				end
			end

			if state then
				local data = {}

				data.stage = stageData.stage
				data.formation = formation

				table.insert(formations, data)

				for _, sHero in ipairs(formation) do
					for index, hero in ipairs(heros) do
						if hero == sHero then
							table.remove(heros, index)

							break
						end
					end
				end
			else
				return formations
			end
		end
	end
end

function ActivityDataSneakBattle:checkShowInherit(...)
	return self.needPopUp and self.needPopUp == 1
end

function ActivityDataSneakBattle:checkOneTypeAwardRedDot(type)
	local datas = self:getAccomplishAwardData(type)

	if datas then
		for _, data in ipairs(datas) do
			if data.can == true and data.got ~= true then
				return true
			end
		end
	end
end

function ActivityDataSneakBattle:getLevelCount(...)
	if self.type and ResNewPveLevel[self.type] then
		return #ResNewPveLevel[self.type]
	end
end

function ActivityDataSneakBattle:getAccomplishAwardAllTypeData()
	local typeCount = ResNewPveMisc[self.actObject.actId or 1309].max_type_num or 3
	local datas = {}

	for type = 1, typeCount do
		local oneData = {}

		for _, data in ipairs(ResNewPveIndex) do
			if data.type == type then
				oneData.name = data.name

				break
			end
		end

		oneData.type = type
		oneData.haveAward = self:checkOneTypeAwardRedDot(type)

		table.insert(datas, oneData)
	end

	return datas
end

function ActivityDataSneakBattle:checkAwardRedDot(...)
	if self:checkAccomplishAwardOpen() then
		local typeCount = ResNewPveMisc[self.actObject.actId or 1309].max_type_num or 3

		for type = 1, typeCount do
			if self:checkOneTypeAwardRedDot(type) then
				RedDotManager.setKeyState(UIConst.RD_HINT_SNEAK_BATTLE_AWARD, true)

				return
			end
		end
	end

	RedDotManager.setKeyState(UIConst.RD_HINT_SNEAK_BATTLE_AWARD, false)
end

function ActivityDataSneakBattle:checkNewSelectLevel(...)
	if self.needNewSelect then
		local keyStr = Const.ACT_TYPE_SNEAK_BATTLE .. self.type
		local showData = CurAvatar:getClientUserData(keyStr)

		showData[self.needNewSelect] = true

		CurAvatar:setClientUserData(keyStr, showData)
		RedDotManager.setKeyState(UIConst.RD_HINT_SNEAK_BATTLE_NEW_LEVEL, false)

		self.needNewSelect = nil
	end
end

function ActivityDataSneakBattle:checkNewLevelRedDot(...)
	if self:checkCanEnterNewLevel() then
		local passLevel = 0
		local persisDentData = self:getSneakBattlePersistentData()

		if persisDentData and persisDentData.passData then
			passLevel = persisDentData.passData.pass_level or 0
		end

		local newLevel = passLevel + 1

		if newLevel ~= 1 then
			local keyStr = Const.ACT_TYPE_SNEAK_BATTLE .. self.type
			local showData = CurAvatar:getClientUserData(keyStr)

			if showData and not showData[newLevel] then
				self.needNewSelect = newLevel

				RedDotManager.setKeyState(UIConst.RD_HINT_SNEAK_BATTLE_NEW_LEVEL, true)

				return
			end
		end
	end

	RedDotManager.setKeyState(UIConst.RD_HINT_SNEAK_BATTLE_NEW_LEVEL, false)
end

function ActivityDataSneakBattle:initCanWearRelicMap(...)
	self.canRelicHeroIdMap = {}
	self.canRelicHeroIdList = {}

	local heroDic = self:getSneakBattleHeroDic()

	if heroDic then
		for _, hero in pairs(heroDic) do
			local relics = self:getCanWearRelicsInSeakBattle(hero)

			if not self.heroRelicDic then
				return
			end

			if relics and #relics ~= 0 and (not self.heroRelicDic[hero.id] or self.heroRelicDic[hero.id] == 0) then
				self.canRelicHeroIdMap[hero.id] = true

				table.insert(self.canRelicHeroIdList, hero.id)
			end
		end
	end
end

function ActivityDataSneakBattle:checkHeroRelicRedDot(...)
	self:initCanWearRelicMap()

	if self.canRelicHeroIdList and #self.canRelicHeroIdList ~= 0 then
		RedDotManager.setKeyState(UIConst.RD_HINT_SNEAK_BATTLE_HERO_RELIC, true)
	else
		RedDotManager.setKeyState(UIConst.RD_HINT_SNEAK_BATTLE_HERO_RELIC, false)
	end
end

function ActivityDataSneakBattle:checkNew(...)
	if self.serverData == nil or self.serverData.close_tick == nil then
		return
	end

	self:checkAwardRedDot()
	self:checkNewLevelRedDot()
	self:checkHeroRelicRedDot()

	local result = RedDotManager.getKeyState(UIConst.RD_HINT_SNEAK_BATTLE)

	if self.actObject.redDotId then
		RedDotManager.setKeyState(self.actObject.redDotId, result)
	end

	return result
end

function ActivityDataSneakBattle:onNewDay(...)
	self:checkNew()
end

function ActivityDataSneakBattle:onNewIndex(...)
	local inSneakBattleFlag = false
	local relateUIs = {
		sneakBattleLevelMainDlg = true,
		sneakBattleResultFailDlg = true,
		sneakBattleStageInfoDlg = true,
		sneakBattleMainDlg = true,
		sneakBattleTeamSetDlg = true,
		sneakBattleInheritDlg = true,
		sneakBattleFinishiLevelDlg = true,
		sneakBattleResultWinDlg = true,
		sneakBattleAnnounceDlg = true,
		sneakBattleHeroInfoDlg = true,
		sneakBattleLimitDlg = true,
		sneakBattleHeroCheckDlg = true,
		sneakBattleAwardDlg = true
	}

	if GameFsm.isInState(Const.STATE_BATTLE) then
		local state = GameFsm.getCurState()

		if state.battleType == BattleConst.BATTLE_TYPE_SNEAK_BATTLE then
			inSneakBattleFlag = true
		end
	end

	if not inSneakBattleFlag then
		for uiName, v in pairs(relateUIs) do
			local ui = UIManager.tryGetUI(uiName)

			if ui and ui:getVisible() then
				inSneakBattleFlag = true

				break
			end
		end
	end

	local function yesFunc(...)
		for uiName, v in pairs(relateUIs) do
			local ui = UIManager.tryGetUI(uiName)

			if ui then
				ui:setVisible(false)
			end
		end

		local ui = UIManager.tryGetUI("activityGatherMainDlg")

		if ui then
			ui:onBtnsRefresh()
		end
	end

	if inSneakBattleFlag then
		if GameFsm.isInState(Const.STATE_BATTLE) then
			local state = GameFsm.getCurState()

			if state.battleType == BattleConst.BATTLE_TYPE_SNEAK_BATTLE then
				local ui = UIManager.tryGetUI("battleDragHeroDlg")

				if ui and ui.onBtnCloseClick then
					ui:onBtnCloseClick()
				end
			end

			yesFunc()
		else
			local msgContent = ClientUtils.getClientNotice(762)

			UIManager.showConfirm(UIConst.CONFIRM_ONEBTN, "", msgContent, yesFunc, nil, nil)
		end
	end
end

function ActivityDataSneakBattle:checkNextWeekOpen(...)
	local templateId = self.actObject.actId or 1309

	if ResNewPveMisc[templateId].next_week_can_open and ResNewPveMisc[templateId].next_week_can_open == 1 then
		return true
	else
		return false
	end
end

function ActivityDataSneakBattle:checkAccomplishAwardOpen(...)
	local templateId = self.actObject.actId or 1309

	if ResNewPveMisc[templateId].onceAward_can_open and ResNewPveMisc[templateId].onceAward_can_open == 1 then
		return true
	else
		return false
	end
end

function ActivityDataSneakBattle:checkRankOpen()
	local templateId = self.actObject.actId or 1309

	if ResNewPveMisc[templateId].rank_can_open and ResNewPveMisc[templateId].rank_can_open == 1 then
		return true
	else
		return false
	end
end

function ActivityDataSneakBattle:willEndCountDown(...)
	return 64800
end

return ActivityDataSneakBattle
