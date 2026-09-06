-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/buddyluckybag/data/BuddyLuckyBagSubMo.lua

module("logic.extensions.buddyluckybag.data.BuddyLuckyBagSubMo", package.seeall)

local BuddyLuckyBagSubMo = class("BuddyLuckyBagSubMo")

function BuddyLuckyBagSubMo:ctor(activityId)
	self._activityId = activityId

	local actData = BuddyLuckyBagConfig.instance:getActivityData(activityId)

	if actData then
		self._maxHelpTimes = actData.openBagLimit or 0
	end

	if actData then
		self._maxGainBagTimes = actData.gainPrizeLimit or 0
	end

	if actData then
		self._firstHelpUnlockCount = actData.firstHelpUnlockCount or 0
	end

	self._itemMatInCard = {}

	local cardDatas = BuddyLuckyBagConfig.instance:getCardDatas(activityId)

	if cardDatas then
		for _, data in ipairs(cardDatas) do
			local mat = {}

			mat.matType = MatType.ACTIVITY_ITEM
			mat.matId = data.itemType
			mat.matNum = data.itemCount
			mat.matName = MaterialMgr.getMaterialsName(mat.matType, mat.matId)
			self._itemMatInCard[data.cardId] = mat
		end
	end

	self._cardMat = {}

	local gainLuckCost = actData and actData.gainLuckCost
	local matType, matId, matNum = MaterialMgr.getMatParams(gainLuckCost)

	self._cardMat.matType = matType
	self._cardMat.matId = matId
	self._cardMat.matNum = matNum
	self._cardMat.matName = MaterialMgr.getMaterialsName(matType, matId)

	self:_resetData()
end

function BuddyLuckyBagSubMo:_resetData()
	self._myCode = ""
	self._bagInfos = {}
	self._helpTimes = 0
	self._gainCollectPrizeIds = {}
	self._buddyBags = {}
end

function BuddyLuckyBagSubMo:dispose()
	self:_resetData()
end

function BuddyLuckyBagSubMo:handlePM_BuddyLuckyBagGetInfoRes(msg)
	self._myCode = msg.myCode
	self._helpTimes = msg.helpTimes

	table.clear(self._bagInfos)

	for _, bagInfo in ipairs(msg.bagList) do
		self._bagInfos[bagInfo.bagId] = bagInfo
	end

	table.clear(self._gainCollectPrizeIds)

	for _, prizeId in ipairs(msg.gainCollectPrizeIds) do
		self._gainCollectPrizeIds[prizeId] = true
	end
end

function BuddyLuckyBagSubMo:handlePM_BuddyLuckyBagHelpOpenBagRes(msg)
	for _, bagInfo in ipairs(msg.bagList) do
		self._bagInfos[bagInfo.bagId] = bagInfo
	end

	if msg:HasField("helpTimes") then
		self._helpTimes = msg.helpTimes
	end
end

function BuddyLuckyBagSubMo:handlePM_BuddyLuckyBagGainCollectPrizeBagRes(msg)
	self._gainCollectPrizeIds[msg.prizeId] = true
end

function BuddyLuckyBagSubMo:handlePM_BuddyLuckyBagBuddyBagsRes(msg)
	self._buddyBags = msg.buddyBags
end

function BuddyLuckyBagSubMo:handlePM_BuddyLuckyBagGainLuckRes(msg)
	self._bagInfos[msg.bagInfo.bagId] = msg.bagInfo
end

function BuddyLuckyBagSubMo:handlePM_BuddyLuckyBagGainBagPrizeRes(msg)
	self._bagInfos[msg.bagInfo.bagId] = msg.bagInfo
end

function BuddyLuckyBagSubMo:handlePM_BuddyLuckyBagNotifyChangeRes(msg)
	for _, bagInfo in ipairs(msg.bagList) do
		self._bagInfos[bagInfo.bagId] = bagInfo
	end
end

function BuddyLuckyBagSubMo:getMyCode()
	return self._myCode
end

function BuddyLuckyBagSubMo:getPrizeIdInBag(bagId)
	local info = self:getBagInfo(bagId)

	return (info or nil) and (info.prizeId or 0)
end

function BuddyLuckyBagSubMo:isPrizeGainInBag(bagId)
	local info = self:getBagInfo(bagId)

	return info and info.hasGained == true
end

function BuddyLuckyBagSubMo:getBagInfo(bagId)
	return self._bagInfos[bagId]
end

function BuddyLuckyBagSubMo:getCurGainHelpBagTimes()
	local helpTimes = self:getHelpTimes()

	return helpTimes * self._firstHelpUnlockCount
end

function BuddyLuckyBagSubMo:getFirstHelpUnlockCount()
	return self._firstHelpUnlockCount
end

function BuddyLuckyBagSubMo:getHelpTimes()
	return self._helpTimes
end

function BuddyLuckyBagSubMo:getMaxHelpTimes()
	return self._maxHelpTimes
end

function BuddyLuckyBagSubMo:getLeftHelpTimes()
	local max = self:getMaxHelpTimes()
	local cur = self:getHelpTimes()

	return Mathf.Max(0, max - cur)
end

function BuddyLuckyBagSubMo:getMaxGainBagTimes()
	return self._maxGainBagTimes
end

function BuddyLuckyBagSubMo:getCurGainBagTimes()
	local count = 0

	for _, info in pairs(self._bagInfos) do
		if self:isPrizeGainInBag(info.bagId) then
			count = count + 1
		end
	end

	return count
end

function BuddyLuckyBagSubMo:getLeftGainBagTimes()
	local max = self:getMaxGainBagTimes()
	local cur = self:getCurGainBagTimes()

	return Mathf.Max(0, max - cur)
end

function BuddyLuckyBagSubMo:getBuddyBags()
	return self._buddyBags
end

function BuddyLuckyBagSubMo:isCanGainPrizeInCard(cardId)
	return not self:isHasGainPrizeInCard(cardId) and self:isEnoughItemInCard(cardId)
end

function BuddyLuckyBagSubMo:isHasGainPrizeInCard(cardId)
	return self._gainCollectPrizeIds[cardId] == true
end

function BuddyLuckyBagSubMo:isEnoughItemInCard(cardId)
	local cur = self:getCurItemCountInCard(cardId)
	local max = self:getMaxItemCountInCard(cardId)

	return max <= cur
end

function BuddyLuckyBagSubMo:getCurItemCountInCard(cardId)
	local mat = self:getItemMatInCard(cardId)

	return MaterialModel.instance:getMaterialsNumber(mat.matType, mat.matId)
end

function BuddyLuckyBagSubMo:getMaxItemCountInCard(cardId)
	local mat = self:getItemMatInCard(cardId)

	return mat.matNum
end

function BuddyLuckyBagSubMo:getItemMatInCard(cardId)
	return self._itemMatInCard[cardId]
end

function BuddyLuckyBagSubMo:getCardCount()
	local mat = self._cardMat

	return MaterialModel.instance:getMaterialsNumber(mat.matType, mat.matId)
end

function BuddyLuckyBagSubMo:getMaxCardCount()
	local datas = BuddyLuckyBagConfig.instance:getCardDatas(self._activityId)

	return (datas or nil) and (#datas or 0)
end

return BuddyLuckyBagSubMo
