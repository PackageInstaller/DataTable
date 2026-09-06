-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/aresmom/model/AresMomModel.lua

module("logic.extensions.aresmom.model.AresMomModel", package.seeall)

local AresMomModel = class("AresMomModel", BaseModel)

function AresMomModel:onInit()
	self:onReset()

	self._challengeId = 51
end

function AresMomModel:onReset()
	self._infoList = {}
	self._curType = 0
	self._owerFmtMo = nil
	self._supFmtMo = nil
end

function AresMomModel:onGetInfo(msg)
	self._infoList = {}

	for k, v in ipairs(msg.typeList) do
		local info = self:createInfo()

		info.type = checkint(v.type)
		info.stageDay = checkint(v.stageDay)
		info.gameDay = checkint(v.gameDay)
		info.gameTimes = checkint(v.gameTimes)
		info.gainPrizeIds = v.gainPrizeIds
		info.unlockBlockIds = v.unlockBlockIds
		info.itemCount = v.itemCount
		info.stageInfoList = {}

		for k1, v1 in ipairs(v.stages) do
			info.stageInfoList[v1.stageId] = v1.everMaxScore
		end

		for i = 1, 5 do
			local getInfo = info.stageInfoList[i]

			if not getInfo then
				info.stageInfoList[i] = 0
			end
		end

		self._infoList[info.type] = info
	end
end

function AresMomModel:onNotifyFight(msg)
	local info = self:getChallengeInfo(msg.type) or self:createInfo()

	info.stageInfoList[msg.stageId] = msg.everMaxScore
end

function AresMomModel:onGainPrize(msg)
	local info = self:getChallengeInfo(msg.type) or self:createInfo()

	info.gameTimes = msg.gameTimes

	table.insert(info.gainPrizeIds, msg.prizeId)
end

function AresMomModel:onUnlock(msg)
	local info = self:getChallengeInfo(msg.type) or self:createInfo()

	info.itemCount = msg.itemCount
	info.gameTimes = msg.gameTimes

	table.insert(info.unlockBlockIds, msg.blockId)
end

function AresMomModel:onBuyTimes(msg)
	local info = self:getChallengeInfo(msg.type) or self:createInfo()

	info.gameTimes = msg.gameTimes
end

function AresMomModel:createInfo()
	local info = {}

	info.type = 0
	info.stageInfoList = {}
	info.stageDay = 0
	info.gameDay = 0
	info.gameTimes = 0
	info.gainPrizeIds = {}
	info.unlockBlockIds = {}

	return info
end

function AresMomModel:getChallengeId()
	return self._challengeId
end

function AresMomModel:getChallengeInfo(type)
	return self._infoList[type]
end

function AresMomModel:getIsAbleToGetPrize(type)
	local info = self._infoList[type]

	if info then
		local curProgress = 0

		for k, v in pairs(info.stageInfoList) do
			curProgress = curProgress + checkint(v)
		end

		local cfgs = AresMomConfig.instance:getPrizeCfgs(type) or {}

		for k, data in ipairs(cfgs) do
			if not table.keyof(info.gainPrizeIds, data.id) and curProgress >= data.progress then
				return true
			end
		end
	end

	return false
end

function AresMomModel:getCurType()
	return self._curType
end

function AresMomModel:setCurType(type)
	self._curType = type
end

function AresMomModel:getCurOwerCustomFmtMo()
	if self._owerFmtMo == nil then
		self._owerFmtMo = AresMomOwerCustomFmtMo.New()
	end

	return self._owerFmtMo
end

function AresMomModel:getCurSupCustomFmtMo()
	if self._supFmtMo == nil then
		self._supFmtMo = AresMomSupCustomFmtMo.New()
	end

	return self._supFmtMo
end

AresMomModel.instance = AresMomModel.New()

return AresMomModel
