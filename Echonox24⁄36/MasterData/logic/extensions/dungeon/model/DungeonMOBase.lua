-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dungeon/model/DungeonMOBase.lua

module("logic.extensions.dungeon.model.DungeonMOBase", package.seeall)

local M = class("DungeonMOBase")

function M:ctor()
	return
end

function M:initByConfig(co)
	self._co = co
	self._id = co.id
	self._type = co.type
	self._index = co.index
	self._pointCost = co.pointCost
	self._name = co.name
	self._desc = co.desc
	self._mainRewardShow = co.mainRewardShow
	self._firstPassReward = co.firstPassReward
	self._normalReward = co.normalReward
	self._starRequire = co.starRequire
	self._plotBeforeBattle = co.plotBeforeBattle
	self._plotAfterBattle = co.plotAfterBattle
	self._plotAfterReady = co.plotAfterReady
	self._scoreGroup = co.scoreGroup
	self._passed = false
	self._star = {}
	self._isPlotNode = false
	self._tips = co.tips
	self._failTips = co.failtips
	self._chapterCO = nil

	MonsterConfig.instance:loadDungeonMonsterConfig(self._id)
end

function M:initByPlotConfig(co)
	self._co = co
	self._id = co.id
	self._type = co.type
	self._index = co.index
	self._plotBeforeBattle = co.plotBeforeBattle
	self._name = co.name
	self._desc = co.desc
	self._firstPassReward = co.firstPassReward
	self._passed = false
	self._star = {}
	self._isPlotNode = true
end

function M:initByAgent(data)
	self:initByData(data)
end

function M:initByData(data)
	if not data then
		return
	end

	local starNum = data.stars

	self._star[1] = starNum % 2 == 1
	self._star[2] = starNum % 4 >= 2
	self._star[3] = starNum % 8 >= 4
	self._multipliable = data.multipliable
	self._passed = true
end

function M:getId()
	return self._id
end

function M:getDungeonCO()
	return self._co
end

function M:getDungeonBattleCode()
	return self._co.levelID
end

function M:getIndex()
	return self._index
end

function M:getType()
	return self._type
end

function M:getName()
	return self._name
end

function M:getPointCost()
	return self._pointCost
end

function M:getDesc()
	return self._desc
end

function M:getEnemyIds()
	if self._enemyIds == nil then
		local levelCo = BattleConfig.instance:getBattleLevelCO(self:getDungeonBattleCode())

		if not levelCo then
			return
		end

		self._enemyIds = {}

		for _, group in pairs(levelCo.monsterGroupList) do
			if group.refreshType ~= 4 then
				for _, monster in pairs(group.monsterList) do
					local monsterCO = levelCo.monsters[monster.monsterId]

					if (monsterCO.battleCamp == BattleEnum.MonsterCampType.NORMAL or monsterCO.battleCamp == BattleEnum.MonsterCampType.FRIEND) and not TableUtil.contains(self._enemyIds, monster.monsterId) then
						table.insert(self._enemyIds, monster.monsterId)
					end
				end
			end
		end
	end

	return self._enemyIds
end

function M:getMainRewardShow()
	return self._mainRewardShow
end

function M:getStarRequire()
	return self._starRequire
end

function M:getPlotBeforeBattle()
	return self._plotBeforeBattle
end

function M:getPlotAfterBattle()
	return self._plotAfterBattle
end

function M:getHavePlot()
	return self._plotAfterBattle ~= 0 or self._plotBeforeBattle ~= 0 or self._plotAfterReady ~= 0
end

function M:getScoreGroup()
	return self._scoreGroup
end

function M:hasPassed()
	return self._passed
end

function M:getStar()
	return self._star
end

function M:getStarCount()
	local count = 0

	for i, v in pairs(self._star) do
		if v then
			count = count + 1
		end
	end

	return count
end

function M:getFristPassReward()
	return self._firstPassReward
end

function M:getNormalReward()
	return self._normalReward
end

function M:getAllFirstPassReward()
	local rewardCO = RewardConfig.instance:getRewardCfgByCode(self._firstPassReward)
	local rewardList = {}

	if not rewardCO then
		return rewardList
	end

	for i, v in ipairs(rewardCO.reward and rewardCO.reward or {}) do
		if not v.pool then
			table.insert(rewardList, v)
		end
	end

	for i, v in ipairs(rewardCO.randomReward1 and rewardCO.randomReward1 or {}) do
		table.insert(rewardList, v)
	end

	for i, v in ipairs(rewardCO.randomReward2 and rewardCO.randomReward2 or {}) do
		table.insert(rewardList, v)
	end

	for i, v in ipairs(rewardCO.randomReward3 and rewardCO.randomReward3 or {}) do
		table.insert(rewardList, v)
	end

	return rewardList
end

function M:getAllNormalPassReward()
	local rewardList = {}

	if not self._normalReward then
		return rewardList
	end

	for _, rewardCode in ipairs(self._normalReward) do
		local rewardCO = RewardConfig.instance:getRewardCfgByCode(rewardCode)

		if rewardCO and rewardCO.rewardShow then
			for i, v in ipairs(rewardCO.rewardShow[1]) do
				table.insert(rewardList, v)
			end

			for i, v in ipairs(rewardCO.rewardShow[2]) do
				table.insert(rewardList, v)
			end
		end
	end

	return rewardList
end

function M:getImportantPassReward()
	local rewardList = {}

	if not self._normalReward then
		return rewardList
	end

	for _, rewardCode in ipairs(self._normalReward) do
		local rewardCO = RewardConfig.instance:getRewardCfgByCode(rewardCode)

		if rewardCO and rewardCO.rewardShow then
			for i, v in ipairs(rewardCO.rewardShow[1]) do
				table.insert(rewardList, v)
			end
		end
	end

	return rewardList
end

function M:setPreDungeonId(id)
	self._preDungeonId = id
end

function M:getPreDungeonId()
	return self._preDungeonId
end

function M:getIsUnlock()
	if DungeonModel.instance:getAllDungeonUnlock() then
		return true
	end

	return false
end

function M:setChapterIdAndDifficulty(index)
	if index then
		self._chapterId = math.floor(index / 100)
		self._difficulty = index % 100
	end
end

function M:getChapterId()
	return self._chapterId
end

function M:getChapterCo()
	if self._chapterCO == nil then
		self._chapterCO = DungeonConfig.instance:getChapterCO(self:getType(), self:getChapterId())
	end

	return self._chapterCO
end

function M:getDifficulty()
	return self._difficulty
end

function M:getIsPlotNode()
	return self._isPlotNode
end

function M:setIsPlotNode(status)
	self._isPlotNode = status
end

function M:getMultipliable()
	return self._multipliable
end

function M:getTips()
	return self._tips
end

function M:getFailTips()
	return self._failTips
end

function M:canRecord()
	local chapterCO = self:getChapterCo()

	if chapterCO and chapterCO.canRecord == 1 then
		return true
	end

	return false
end

function M:getMultiplicityLimit()
	local chapterCO = self:getChapterCo()

	return chapterCO and chapterCO.multiplicityLimit or 1
end

function M:getConsecutiveLimit()
	local chapterCO = self:getChapterCo()

	return chapterCO and chapterCO.consecutive or 0
end

function M:getDungeonIndex()
	return 0
end

return M
