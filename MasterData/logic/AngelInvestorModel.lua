-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/angelinvestor/model/AngelInvestorModel.lua

module("logic.extensions.angelinvestor.model.AngelInvestorModel", package.seeall)

local AngelInvestorModel = class("AngelInvestorModel", BaseModel)

function AngelInvestorModel:onInit()
	self:onReset()
end

function AngelInvestorModel:onReset()
	self._infos = {}
	self._customFmtMoPool = {}
	self._stageReviveCountMap = {}
	self._prizeGainCountMap = {}
	self._selectPrizeMap = {}
end

function AngelInvestorModel:getInfo(activityId)
	return self._infos[activityId]
end

function AngelInvestorModel:getStageReviveCountMap(activityId)
	return self._stageReviveCountMap[activityId]
end

function AngelInvestorModel:getPrizeGainCountMap(activityId)
	return self._prizeGainCountMap[activityId]
end

function AngelInvestorModel:getFmtMo(activityId)
	if self._customFmtMoPool[activityId] == nil then
		self._customFmtMoPool[activityId] = AngelInvestorFmtMo.New()
	end

	return self._customFmtMoPool[activityId]
end

function AngelInvestorModel:getSelectPrizeMap(activityId)
	if self._selectPrizeMap[activityId] == nil then
		self._selectPrizeMap[activityId] = {}
	end

	return self._selectPrizeMap[activityId]
end

function AngelInvestorModel:getSelectPrizeNum(activityId)
	local prizeMap = self._selectPrizeMap[activityId]
	local selectNum = 0

	for prizeId, hasSelect in pairs(prizeMap) do
		if hasSelect then
			selectNum = selectNum + 1
		end
	end

	return selectNum
end

function AngelInvestorModel:clearSelectPrizeMap(activityId)
	self._selectPrizeMap[activityId] = {}
end

function AngelInvestorModel:handlePM_AngelInvestorGetInfoRes(msg)
	self._infos[msg.activityId] = GameUtil.pbToTable(msg)

	local info = self._infos[msg.activityId]
	local stageMaxReviveCountsList = info and checktable(info.stageMaxReviveCounts) or {}

	self._stageReviveCountMap[msg.activityId] = self._stageReviveCountMap[msg.activityId] or {}

	local curStageReviveCountMap = self._stageReviveCountMap[msg.activityId]

	for _, pair in ipairs(stageMaxReviveCountsList) do
		curStageReviveCountMap[pair.left] = pair.right
	end

	local prizeGainCounts = info and checktable(info.prizeGainCounts) or {}

	self._prizeGainCountMap[msg.activityId] = self._prizeGainCountMap[msg.activityId] or {}

	local prizeGainCountMap = self._prizeGainCountMap[msg.activityId]

	for _, pair in ipairs(prizeGainCounts) do
		prizeGainCountMap[pair.left] = pair.right
	end
end

function AngelInvestorModel:handlePM_AngelInvestorGainHangRewardRes(msg)
	local pb = GameUtil.pbToTable(msg)
	local info = self._infos[msg.activityId]

	if info then
		info.hangGainPrizeIds = info.hangGainPrizeIds or {}

		for i, id in ipairs(pb.prizeIds) do
			table.insert(info.hangGainPrizeIds, id)
		end
	end
end

function AngelInvestorModel:handlePM_AngelInvestorSignContractRes(msg)
	local info = self._infos[msg.activityId]

	info.signed = msg.signed
end

function AngelInvestorModel:handlePM_AngelInvestorUpgradeAngelRes(msg)
	local info = self._infos[msg.activityId]

	info.angelLevel = msg.angelLevel
end

function AngelInvestorModel:handlePM_AngelInvestorStartHangRes(msg)
	local info = self._infos[msg.activityId]

	info.hangStartTime = msg.hangStartTime
	info.hangGainPrizeIds = nil
end

function AngelInvestorModel:handlePM_Notify_AngelInvestorChallengeResultRes(msg)
	self._stageReviveCountMap[msg.activityId] = self._stageReviveCountMap[msg.activityId] or {}

	local curStageReviveCountMap = self._stageReviveCountMap[msg.activityId]

	curStageReviveCountMap[msg.stageId] = checknumber(msg.maxReviveCount)
end

AngelInvestorModel.instance = AngelInvestorModel.New()

return AngelInvestorModel
