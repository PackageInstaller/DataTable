-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/airworkshop/model/challenge/AirWorkShopChallengeMo.lua

module("logic.extensions.airworkshop.model.challenge.AirWorkShopChallengeMo", package.seeall)

local M = class("AirWorkShopChallengeMo")

function M:ctor()
	return
end

function M:updateFromServer(info)
	self._lv = info.lv
	self._week = info.week
	self._state = info.state or false
	self._position = info.position or 0
	self._maxOfWeek = info.maxOfWeek or 0
	self._maxRound = info.maxRound or 0
	self._firstRank = nil

	if info:HasField("firstRank") then
		self._firstRank = info.firstRank
	end

	self._firstScore = info.firstScore or 0
	self._up3Score = info.up3Score or 0
	self._up2Score = info.up2Score or 0
	self._up1Score = info.up1Score or 0
	self._keepScore = info.keepScore or 0
	self._downScore = info.downScore or 0
	self._challengeNum = info.challengeNum
	self._recoveryTime = tonumber(info.recoveryTime)
	self._firstRewardLv = info.firstRewardLv or 0
	self._life = info:HasField("life") and info.life or self:getMaxLife()
	self._score = info.score or 0
	self._round = info.round

	self:updateCurLevelLst(info.level)

	self._hadOff = info.hadOff
	self._isWin = nil

	if info:HasField("isWin") then
		self._isWin = info.isWin
	end
end

function M:getStatusMsg()
	local msg = {}

	table.insert(msg, string.format("竞技等级:%s", self._lv))
	table.insert(msg, string.format("LvState 当前等级将发生的变化:%s, stateNum:%s", self:getState(), AirWorkShopEnum.LvStateNum[self:getState()]))
	table.insert(msg, string.format("当前玩家排名显示所处位置百分比:%s, 击败:%s", self._position, self:getDefeatPosition()))
	table.insert(msg, string.format("已领取的最高等级首通奖励:%s", self._firstRewardLv))
	table.insert(msg, string.format("分数线: 榜首:%s, up3:%s, up2:%s, up1:%s, keep:%s, down:%s", self._firstScore, self._up3Score, self._up2Score, self._up1Score, self._keepScore, self._downScore))

	if self._firstRank then
		table.insert(msg, string.format("榜首: uuid:%s, name:%s", self._firstRank.userId, self._firstRank.nickname))
	else
		table.insert(msg, "榜首: 无")
	end

	table.insert(msg, string.format("剩余的挑战次数:%s, 上次变更时间:%s", self._challengeNum, self._recoveryTime))
	table.insert(msg, string.format("剩余复活点数（命）:%s", self._life))
	table.insert(msg, string.format("记录关卡数量:%s", #self._map))

	if #self._map > 0 then
		for index, value in ipairs(self._map) do
			table.insert(msg, string.format("    [%s]mapId:%s", index, value.mapId))
		end
	end

	table.insert(msg, string.format("当前挑战所在第%s场", self._round))
	table.insert(msg, string.format("当前挑战是否胜利:%s", self._isWin))
	table.insert(msg, string.format("玩家所处赛季:%s", self._week))

	return table.concat(msg, "\n")
end

function M:updateCurLevelLst(levelNOLst)
	self._map = {}

	if levelNOLst and #levelNOLst > 0 then
		for _, LevelNO in ipairs(levelNOLst) do
			table.insert(self._map, LevelNO)
		end
	end
end

function M:getLv()
	if not self._lv then
		local minLv, maxLv = AirWorkShopConfig.instance:getRodeoLvRange()

		return minLv
	end

	return self._lv
end

function M:getIsMaxLv()
	local minLv, maxLv = AirWorkShopConfig.instance:getRodeoLvRange()

	return maxLv <= self:getLv()
end

function M:getState()
	return self._state or AirWorkShopEnum.LvState.KEEP
end

function M:getStateNum()
	return AirWorkShopEnum.LvStateNum[self:getState()]
end

function M:getPosition()
	return self._position
end

function M:getDefeatPosition()
	return 1 - self:getPosition()
end

function M:getMaxOfWeek()
	return self._maxOfWeek
end

function M:getFirstRankNO()
	return self._firstRank
end

function M:getFirstRankIsMe()
	local isSelf = false
	local firstRankNO = self:getFirstRankNO()

	if firstRankNO then
		isSelf = firstRankNO.userId == PlayerModel.instance:getId()
	end

	return isSelf
end

function M:getFirstScore()
	return self._firstScore
end

function M:getUp3Score()
	return self._up3Score
end

function M:getUp2Score()
	return self._up2Score
end

function M:getUp1Score()
	return self._up1Score
end

function M:getKeepScore()
	return self._keepScore
end

function M:getDownScore()
	return self._downScore
end

function M:getPredictScore(targetLv)
	local curLv = self:getLv()
	local offsetLv = targetLv - curLv
	local score = 0

	if offsetLv == 3 then
		score = self:getUp3Score()
	elseif offsetLv == 2 then
		score = self:getUp2Score()
	elseif offsetLv == 1 then
		score = self:getUp1Score()
	elseif offsetLv == 0 then
		score = self:getKeepScore()
	elseif offsetLv == -1 then
		score = self:getDownScore()
	else
		printWarn(string.format("无法获得[%s]与当前等级[%s]之间的目标分数 ", targetLv, curLv))
	end

	if Astral.OSDef.isEditor then
		printWarn(string.format("curLv[%s] targetLv[%s] offset[%s] score[%s]", curLv, targetLv, offsetLv, score))
	end

	return score
end

function M:getUseChallengeNum()
	local maxChallengeNum = AirWorkShopConfig.instance:getMaxChallengeNum()

	return maxChallengeNum - self:getChallengeNum()
end

function M:getChallengeNumIsFull()
	local maxChallengeNum = AirWorkShopConfig.instance:getMaxChallengeNum()

	return maxChallengeNum == self:getChallengeNum()
end

function M:getChallengeNum()
	return self._challengeNum or 0
end

function M:setUseChallengeNum(useChallengeNum)
	self._challengeNum = useChallengeNum
end

function M:getLastChallengeNumRecoverTime()
	return self._recoveryTime or 0
end

function M:setLastChallengeNumRecoverTime(time)
	self._recoveryTime = time
end

function M:getMaxLife()
	if not self._maxLife then
		self._maxLife = AirWorkShopConfig.instance:getAtkConst("MaxRodeoLife").numValue
	end

	return self._maxLife
end

function M:getUseLife()
	local max = self:getMaxLife()

	return max - self:getLife()
end

function M:getLife()
	return self._life or 0
end

function M:getMapLst()
	return self._map
end

function M:getHadOff()
	return self._hadOff
end

function M:getScore()
	return self._score or 0
end

function M:getRound()
	return self._round or 0
end

function M:getIsWin()
	return self._isWin
end

function M:getWeek()
	return self._week
end

function M:getMaxRound()
	return self._maxRound
end

function M:getFirstRewardLv()
	return self._firstRewardLv
end

function M:isFirstRewardReceive(lv)
	lv = lv or 0

	return lv <= self:getFirstRewardLv()
end

return M
