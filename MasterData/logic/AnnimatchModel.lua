-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/annimatch/model/AnnimatchModel.lua

module("logic.extensions.annimatch.model.AnnimatchModel", package.seeall)

local AnnimatchModel = class("AnnimatchModel", BaseModel)

function AnnimatchModel:ctor()
	return
end

function AnnimatchModel:onInit()
	self:onReset()
end

function AnnimatchModel:onReset()
	self.activityId = checknumber(AnnimatchConfig.instance:getCommonByKey("CURR_ACT_ID"))
	self.isAdmissionPool = {}
	self.matchPool = {}
	self.petPool = {}
	self.formationMoPool = {}
	self.petListPool = {}
	self.currBattleRes = nil
	self.rankMsgPool = {}
	self.taskInfoPool = {}
	self._banInfoPool = {}
	self._voteRaceIdMapPool = {}
end

function AnnimatchModel:getCurrActId()
	return self.activityId
end

function AnnimatchModel:getCurrActType()
	return 133
end

function AnnimatchModel:getBanPetInfo(activityId)
	return self._banInfoPool[activityId]
end

function AnnimatchModel:getVoteRaceIdMap(activityId)
	return self._voteRaceIdMapPool[activityId]
end

function AnnimatchModel:getFormationMo(activityId)
	activityId = checknumber(activityId)

	local formationMo = self.formationMoPool[activityId]

	if formationMo == nil then
		formationMo = FormationMO.New(function(petId)
			return self:getPetMo(activityId, petId)
		end)
		self.formationMoPool[activityId] = formationMo
	end

	return formationMo
end

function AnnimatchModel:resetFormation(activityId)
	activityId = checknumber(activityId)

	local info = self:getInfo(activityId)
	local fmo = self:getFormationMo(activityId)

	fmo:SetData(info.simpleForm)
end

function AnnimatchModel:getInfo(activityId)
	activityId = checknumber(activityId)

	return self.matchPool[activityId] or {}
end

function AnnimatchModel:onGiveup(msg)
	self:updateTicketInfo(msg)
end

function AnnimatchModel:updateTicketInfo(msg)
	local activityId = msg.activityId

	self.isAdmissionPool[activityId] = msg.isAdmission
end

function AnnimatchModel:getIsAdmission(activityId)
	return self.isAdmissionPool[activityId]
end

function AnnimatchModel:onSetInfo(msg)
	local activityId = msg.activityId

	self.matchPool[activityId] = GameUtil.pbToTable(msg)

	self:updatePetList(activityId)
	self:resetFormation(activityId)
end

function AnnimatchModel:updateWinFalseTime(activityId, winTimes, failTimes)
	local info = self:getInfo(activityId)

	info.winTimes = winTimes
	info.failTimes = failTimes
end

function AnnimatchModel:onSetForm(msg)
	local activityId = msg.activityId
	local info = self:getInfo(activityId)

	info.simpleForm = GameUtil.pbToTable(msg.simpleForm)

	self:resetFormation(activityId)
end

function AnnimatchModel:setBattleRes(msg)
	self.currBattleRes = msg
end

function AnnimatchModel:getBattleRes()
	return self.currBattleRes
end

function AnnimatchModel:getRankInfo(activityId)
	return self.rankMsgPool[activityId] or {}
end

function AnnimatchModel:onGetRankInfo(msg)
	self.rankMsgPool[msg.activityId] = msg
end

function AnnimatchModel:onGetTaskInfo(msg)
	local map = {}

	for i, v in ipairs(msg.taskInfos) do
		map[v.taskId] = v
	end

	self.taskInfoPool[msg.activityId] = map
end

function AnnimatchModel:getTaskInfo(activityId, taskId)
	if self.taskInfoPool[activityId] then
		return self.taskInfoPool[activityId][taskId]
	end
end

function AnnimatchModel:updatePetList(activityId)
	local info = self:getInfo(activityId)
	local list = {}

	for i, v in ipairs(info.creepsIds or {}) do
		local petMo = self:getPetMo(activityId, v)

		table.insert(list, petMo)
	end

	self.petListPool[activityId] = list
end

function AnnimatchModel:onUpdateSysPet(msg)
	local activityId = msg.activityId
	local info = self:getInfo(activityId)

	info.creepsIds = msg.creepsIds or {}
	info.curGroupId = msg.curGroupId
	info.alternativeCreepsIds = msg.alternativeCreepsIds

	self:updatePetList(activityId)
end

function AnnimatchModel:handlePM_AnnualCompetitionBuySysPetRes(msg)
	local activityId = msg.activityId
	local info = self:getInfo(activityId)

	info.creepsIds = msg.creepsIds or {}

	self:updatePetList(activityId)
end

function AnnimatchModel:handlePM_AnnualCompetitionRefreshSysPetShopRes(msg)
	local activityId = msg.activityId
	local info = self:getInfo(activityId)

	info.shop = msg.shop
end

function AnnimatchModel:handlePM_AnnualCompetitionBanPetInfoRes(msg)
	local info = GameUtil.pbToTable(msg)
	local activityId = info.activityId

	self._voteRaceIdMapPool[activityId] = self._voteRaceIdMapPool[activityId] or {}
	self._banInfoPool[activityId] = info.banPetInfo

	local banPetInfo = self._banInfoPool[activityId]
	local voteRaceIdMap = self._voteRaceIdMapPool[activityId]

	banPetInfo.banRaceIds = banPetInfo.banRaceIds or {}
	banPetInfo.raceIdAndVote = banPetInfo.raceIdAndVote or {}
	banPetInfo.selfBanRaceIds = banPetInfo.selfBanRaceIds or {}
	banPetInfo.history = banPetInfo.history or {}

	for i, pair in ipairs(banPetInfo.raceIdAndVote) do
		voteRaceIdMap[pair.left] = pair.right
	end
end

function AnnimatchModel:handlePM_AnnualCompetitionBanPetRes(msg)
	local activityId = msg.activityId
	local banPetInfo = self._banInfoPool[activityId]
	local voteRaceIdMap = self._voteRaceIdMapPool[activityId]

	banPetInfo.selfBanRaceIds = msg.raceIds

	for i, raceId in ipairs(msg.raceIds) do
		voteRaceIdMap[raceId] = checknumber(voteRaceIdMap[raceId]) + 1
	end
end

function AnnimatchModel:handlePM_AnnualCompetitionFinishBuyPetRes(msg)
	local activityId = msg.activityId
	local info = self:getInfo(activityId)

	info.shop = nil
end

function AnnimatchModel:getCurrSelectBuffIds(activityId)
	local info = self:getInfo(activityId)

	return info.alternativeBuffConfigIds or {}
end

function AnnimatchModel:getCurrBuffIds(activityId)
	local info = self:getInfo(activityId)

	return info.buffConfigIds or {}
end

function AnnimatchModel:getReplaceCreepsIds(activityId)
	local info = self:getInfo(activityId)

	return info.replaceCreepsIds or {}
end

function AnnimatchModel:onSetBuff(msg)
	local info = self:getInfo(msg.activityId)

	info.alternativeBuffConfigIds = msg.alternativeBuffConfigIds
	info.buffConfigIds = msg.buffConfigIds
end

function AnnimatchModel:onReplaceCreeps(msg)
	local info = self:getInfo(msg.activityId)

	info.replaceCreepsIds = nil

	self:updatePetList(msg.activityId)
	self:resetFormation(msg.activityId)
end

function AnnimatchModel:getPetList(activityId)
	activityId = checknumber(activityId)

	return self.petListPool[activityId] or {}
end

function AnnimatchModel:getPetMo(activityId, creepsId)
	local petMo

	if creepsId > 0 then
		self.petPool[activityId] = self.petPool[activityId] or {}
		petMo = self.petPool[activityId][creepsId]

		if self.petPool[activityId][creepsId] == nil then
			local cfg = AnnimatchConfig.instance:getCfgById(activityId)
			local planId = cfg.systemPetPlanId
			local petCo = AnnimatchConfig.instance:getPetCfg(planId, creepsId)

			if petCo then
				local fPowerPet = FightingPowerPetMo.New()

				fPowerPet:fromChallengeCreepCo(petCo)

				petMo = fPowerPet:toBaseBagPetMo()
				self.petPool[activityId][creepsId] = petMo
			end

			if petMo == nil then
				local rpPlanId = cfg.replacePetPlanId
				local rpPetCo = AnnimatchConfig.instance:getPetCfg(rpPlanId, creepsId)

				if rpPetCo then
					local fPowerPet = FightingPowerPetMo.New()

					fPowerPet:fromChallengeCreepCo(rpPetCo)

					petMo = fPowerPet:toBaseBagPetMo()
					self.petPool[activityId][creepsId] = petMo
				end
			end
		end
	end

	return petMo
end

function AnnimatchModel:getCurWeekBanRaceId(activityId)
	local banInfo = self:getBanPetInfo(activityId)
	local history = banInfo.history
	local banPetRaceIds = {}
	local lastWeekBanInfo
	local lastWeekNum = 0
	local actType = self:getCurrActType()
	local startTime, endTime = ActivityDefineController.instance:getStartTimeAndEndTime(actType, activityId)

	for i, weekInfo in ipairs(history) do
		if lastWeekNum < weekInfo.weekDate then
			lastWeekNum = weekInfo.weekDate
			lastWeekBanInfo = weekInfo
		end
	end

	if lastWeekBanInfo then
		local weekDate = lastWeekBanInfo.weekDate
		local day = weekDate % 100

		weekDate = math.floor(weekDate / 100)

		local month = weekDate % 100

		weekDate = math.floor(weekDate / 100)

		local year = weekDate
		local oneWeekStamp = 604800
		local startHour = 18000
		local timeStamp = GameUtil.date2time(year, month, day) + startHour + 1
		local diffTimeStamp = timeStamp - startTime
		local curDiffTime = ServerTime.now() - startTime
		local lastBanWeek = math.ceil(diffTimeStamp / oneWeekStamp)
		local curWeek = math.ceil(curDiffTime / oneWeekStamp)

		if curWeek == lastBanWeek then
			banPetRaceIds = lastWeekBanInfo.banRaceIds
		end
	end

	return banPetRaceIds
end

AnnimatchModel.instance = AnnimatchModel.New()

return AnnimatchModel
