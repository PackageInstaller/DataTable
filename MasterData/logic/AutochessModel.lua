-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/autochess/model/AutochessModel.lua

module("logic.extensions.autochess.view.AutochessModel", package.seeall)

local AutochessModel = class("AutochessModel", BaseModel)

function AutochessModel:ctor()
	return
end

function AutochessModel:onInit()
	self:onReset()
end

function AutochessModel:onReset()
	self._formationMo = nil
	self._activityId = 0
	self._score = 0
	self._selectBuffIds = {}
	self._roundId = 1
	self._petInfoList = {}
	self._creepsMos = {}
	self._allPetInfoList = {}
	self._currPetInfoList = {}
	self._equipBuffIds = {}
	self._shopIndex2star = {}
	self._lastRank = -1
	self._decHp = -1
end

function AutochessModel:getPetList()
	local pets = {}
	local list = self:getPetInfoList()

	for raceId, star in pairs(list) do
		local creepsCfg = AutochessConfig.instance:getCreepsCfgByStarLevel(raceId, star)
		local pet = self:getPet(creepsCfg.creepsId)

		table.insert(pets, pet)
	end

	return pets
end

function AutochessModel:getPet(petId)
	if petId <= 0 then
		return nil
	end

	local mo = self._creepsMos[petId]

	if not mo then
		local cfg = AutochessConfig.instance:getCreepsCfg(petId)

		if not cfg then
			if Framework.OSDef.isEditor then
				printError("petId:", petId, debug.traceback())
			end

			return nil
		end

		local temp = FightingPowerPetMo.New()

		temp:fromChallengeCreepCo(cfg)

		mo = temp:toBaseBagPetMo()
		self._creepsMos[petId] = mo
	end

	return mo
end

function AutochessModel:getCurrFormation()
	self._formationMo = self._formationMo or FormationMO.New(function(petId)
		return self:getPet(petId)
	end)

	return self._formationMo
end

function AutochessModel:setActInfo(msg)
	self._activityId = msg.activityId
	self._score = msg.score
end

function AutochessModel:getActivityId()
	return self._activityId
end

function AutochessModel:setSelectBuffIds(selectBuffIds)
	self._selectBuffIds = selectBuffIds
end

function AutochessModel:getSelectBuffIds()
	return self._selectBuffIds
end

function AutochessModel:setPlayers(players)
	self._players = players
end

function AutochessModel:getPlayers()
	return self._players
end

function AutochessModel:setEnemyRoundInfo(enemyRoundInfo)
	self._enemyRoundInfo = enemyRoundInfo

	self:_setShop(enemyRoundInfo.shop, true)

	self._enemyRoundUserId = enemyRoundInfo.enemyUserId
end

function AutochessModel:getEnemyRoundInfo()
	return self._enemyRoundInfo
end

function AutochessModel:getEnemyUserId()
	return self._enemyRoundUserId
end

function AutochessModel:setBuffRoundInfo(buffRoundInfo)
	self._buffRoundInfo = buffRoundInfo
end

function AutochessModel:getBuffRoundInfo()
	return self._buffRoundInfo
end

function AutochessModel:getPetShop()
	return self._shop
end

function AutochessModel:changeShopLocked()
	if self._shop then
		self._shop.locked = not self._shop.locked
	end
end

function AutochessModel:refreshPetShop(msg)
	self._roundRefreshTimes = msg.times

	self:_setShop(msg.newShop, true)
end

function AutochessModel:resetRoundRefreshTimes()
	self._roundRefreshTimes = 0
end

function AutochessModel:getRoundRefreshTimes()
	return self._roundRefreshTimes
end

function AutochessModel:_setShop(shopPb, forceCacheStar, buyRaceId)
	self._shop = GameUtil.pbToTable(shopPb)

	if forceCacheStar then
		self._shopIndex2star = {}
		buyRaceId = nil
	end

	if not self._shop.index then
		self._shopIndex2star = {}

		return
	end

	local infoList = self:getPetInfoList()

	for i, v in ipairs(self._shop.index) do
		local var_24_0 = self._shopIndex2star[v.index]

		if not self._shopIndex2star[v.index] then
			var_24_0 = {
				bought = false
			}
			var_24_0.star = infoList[v.raceId] or -1
			var_24_0.raceId = v.raceId
		end

		self._shopIndex2star[v.index] = var_24_0
		self._shopIndex2star[v.index].bought = v.bought

		if buyRaceId and not v.bought and v.raceId == buyRaceId then
			self._shopIndex2star[v.index].star = infoList[v.raceId] or -1
		end
	end
end

function AutochessModel:getIndexShopStarData(index)
	return self._shopIndex2star[index]
end

function AutochessModel:getRoundId()
	return self._roundId
end

function AutochessModel:setRoundId(roundId)
	self._roundId = roundId
end

function AutochessModel:setIsBuffRound(isBuffRound)
	self._isBuffRound = isBuffRound
end

function AutochessModel:getIsBuffRound()
	return self._isBuffRound
end

function AutochessModel:notifyAfterPetChangedRes(msg, sellRaceId, buyRaceId)
	self._currPetInfoList = {}

	for i, v in ipairs(msg.petInfoList) do
		self._currPetInfoList[v.raceId] = v.star

		local creepsCfg = AutochessConfig.instance:getCreepsCfgByStarLevel(v.raceId, v.star)

		self:getPet(creepsCfg.creepsId)
	end

	self:_setShop(msg.shop, false, buyRaceId)

	if sellRaceId and sellRaceId > 0 then
		for i, v in pairs(self._shopIndex2star) do
			if v.raceId == sellRaceId then
				v.star = -1
			end
		end
	end
end

function AutochessModel:getPetInfoList()
	return self._currPetInfoList
end

function AutochessModel:setGameEndMsg(msg)
	self._gameEndMsg = msg
end

function AutochessModel:getGameEndMsg()
	return self._gameEndMsg
end

function AutochessModel:resetDataOnGameStart()
	self:getCurrFormation():ResetPosition()

	self._currPetInfoList = {}
	self._roundId = 1
	self._isBuffRound = false
	self._equipBuffIds = {}
	self._shopIndex2star = {}
	self._roundRefreshTimes = 0

	self:setShowBtnEquipEffect(nil)
end

function AutochessModel:setFullStarBuffIds(buffIds)
	self._fullStarBuffIds = buffIds
end

function AutochessModel:getFullStarBuffIds()
	return self._fullStarBuffIds
end

function AutochessModel:setInitBuffId(buffId)
	self._initBuffId = buffId
end

function AutochessModel:getInitBuffId()
	return self._initBuffId
end

function AutochessModel:insertEquipBuffId(buffId)
	self._equipBuffIds[buffId] = buffId
end

function AutochessModel:getEquipBuffIds()
	return self._equipBuffIds
end

function AutochessModel:setShowBtnEquipEffect(flag)
	self._showBtnEquipEffect = flag
end

function AutochessModel:getShowBtnEquipEffect()
	return self._showBtnEquipEffect
end

function AutochessModel:saveLastRank()
	self._lastRank = -1

	local players = self:getPlayers()
	local userId = RoleModel.instance:getUserId()

	for i, v in ipairs(players) do
		if v.headInfo.userId == userId then
			self._lastRank = i

			break
		end
	end
end

function AutochessModel:getLastRank()
	return self._lastRank
end

function AutochessModel:clearLastRank()
	self._lastRank = -1
end

function AutochessModel:setDecHp(decHp)
	self._decHp = decHp
end

function AutochessModel:getDecHp()
	return self._decHp
end

AutochessModel.instance = AutochessModel.New()

return AutochessModel
