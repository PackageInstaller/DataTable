-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/characterinformation/model/CharacterInformationModel.lua

module("logic.extensions.characterinformation.model.CharacterInformationModel", package.seeall)

local M = class("CharacterInformationModel", BaseModel)
local infoUnlockType = CharacterInfoEnum.UnlockTyp
local DEFAULT_HERO_WEIGHT = 50

M.AUDIO_ID_OFFSET = 3000

function M:onInit()
	self:onReset()
end

function M:onReset()
	self._heroCacheStatus = {}
	self._heroWeightCache = {}
	self._heroWeightExpireTS = 0
	self._impressionTaskPageIndex = 1
	self._inAnchorSublimedView = false
end

function M:getImpressionTaskPageIndex()
	return self._impressionTaskPageIndex
end

function M:setImpressionTaskPageIndex(index)
	index = index or 1
	self._impressionTaskPageIndex = index
end

function M:setInAnchorSublimedView(enter, isExistBySublimedFinish, noBroadcast)
	self._inAnchorSublimedView = enter

	if not noBroadcast then
		GlobalDispatcher:dispatchEvent(EventType.TACIT_ANCHOR_SUBLIMED_VIEW_ENTER, enter, isExistBySublimedFinish)
	end
end

function M:getInAnchorSublimedView()
	return self._inAnchorSublimedView
end

function M:onLoadHeroWeightReply(lstHeroWeightNO, expiredMillis)
	self._heroWeightExpireTS = tonumber(expiredMillis)

	for _, _HeroWeightNO in ipairs(lstHeroWeightNO or {}) do
		local heroId = _HeroWeightNO.heroId
		local weight = _HeroWeightNO.weight

		self._heroWeightCache[heroId] = weight
	end

	GlobalDispatcher:dispatchEvent(EventType.HERO_INFO_WEIGHT_CHANGE)
end

function M:getHeroWeight(heroId)
	local nowTime = ServerTime.now() * 1000

	if nowTime >= self._heroWeightExpireTS then
		HeroDepotAgent.instance:sendLoadHeroWeightRequest()
	end

	return self._heroWeightCache[heroId] or DEFAULT_HERO_WEIGHT
end

function M:getHasNewAllType(heroId)
	local hasNew = false
	local data = self:getHeroCacheData(heroId)

	if data then
		hasNew = data.newIds and #data.newIds or 0
		hasNew = hasNew > 0
	end

	return hasNew
end

function M:getNewPastInfoLst(heroId, includeCarryItem)
	local newInfoIds = {}
	local data = self:getHeroCacheData(heroId)

	if data then
		for _, _id in pairs(data.newIds or {}) do
			if _id >= infoUnlockType.CarryItem1 then
				if includeCarryItem then
					table.insert(newInfoIds, _id)
				end
			else
				table.insert(newInfoIds, _id)
			end
		end
	end

	return newInfoIds
end

function M:getNewVoiceLst(heroId, checkRes)
	local newVoiceIds = {}
	local data = self:getHeroCacheData(heroId)

	if data then
		for _, _id in pairs(data.newIds or {}) do
			if _id > M.AUDIO_ID_OFFSET then
				if checkRes then
					if self:getIsVoiceResExist(heroId, _id - M.AUDIO_ID_OFFSET) then
						table.insert(newVoiceIds, _id)
					end
				else
					table.insert(newVoiceIds, _id)
				end
			end
		end
	end

	return newVoiceIds
end

function M:getIsNewCarryItem(heroId)
	local isNew = false
	local data = self:getHeroCacheData(heroId)

	if data then
		for i = CharacterInfoEnum.UnlockTyp.CarryItem2, CharacterInfoEnum.UnlockTyp.CarryItem4 do
			local newIds = data.newIds or {}
			local index = table.indexof(newIds, i)

			if index then
				isNew = true
			end
		end
	end

	return isNew
end

function M:getIsNewPastInfo(heroId, pastId)
	local isNew = false
	local data = self:getHeroCacheData(heroId)

	if data then
		local newIds = data.newIds or {}
		local index = table.indexof(newIds, pastId)

		if index then
			isNew = true
		end
	end

	return isNew
end

function M:getIsNewVoice(heroId, audioId)
	local isNew = false
	local data = self:getHeroCacheData(heroId)

	if data then
		local newIds = data.newIds or {}
		local index = table.indexof(newIds, audioId + M.AUDIO_ID_OFFSET)

		if index then
			isNew = true
		end
	end

	return isNew
end

function M:setReadPastInfo(heroId, pastId)
	local data = self:getHeroCacheData(heroId)

	if data then
		local newIds = data.newIds or {}
		local index = table.indexof(newIds, pastId)

		if index then
			table.remove(newIds, index)

			self._heroCacheStatus[heroId].newIds = newIds

			self:_writeInfoData(heroId)
		end
	end

	GlobalDispatcher:dispatchEvent(EventType.HERO_INFO_RED_DOT_CHANGE, heroId)
end

function M:setReadPastInfoIds(heroId, pastIds)
	local len = pastIds and #pastIds or 0

	if len > 0 then
		local data = self:getHeroCacheData(heroId)

		if data then
			local recoverNewIds = {}

			for _, _id in ipairs(data.newIds or {}) do
				local index = table.indexof(pastIds, _id)

				if index then
					-- block empty
				else
					table.insert(recoverNewIds, _id)
				end
			end

			self._heroCacheStatus[heroId].newIds = recoverNewIds

			self:_writeInfoData(heroId)
			GlobalDispatcher:dispatchEvent(EventType.HERO_INFO_RED_DOT_CHANGE, heroId)
		end
	end
end

function M:setReadVoice(heroId, audioId)
	local data = self:getHeroCacheData(heroId)

	if data then
		local newIds = data.newIds or {}
		local index = table.indexof(newIds, audioId + M.AUDIO_ID_OFFSET)

		if index then
			table.remove(newIds, index)

			self._heroCacheStatus[heroId].newIds = newIds

			self:_writeInfoData(heroId)
		end
	end

	GlobalDispatcher:dispatchEvent(EventType.HERO_INFO_RED_DOT_CHANGE, heroId)
end

function M:setNewIds(heroId, ids)
	local data = self:getHeroCacheData(heroId)

	if data then
		ids = ids or {}
		self._heroCacheStatus[heroId].newIds = ids

		self:_writeInfoData(heroId)
		GlobalDispatcher:dispatchEvent(EventType.HERO_INFO_RED_DOT_CHANGE, heroId)
	end
end

function M:getUnlockPastInfo(heroId, pastId)
	local isUnlock = true
	local data = self:getHeroCacheData(heroId)

	if data then
		local lockIds = data.lockIds
		local index = table.indexof(lockIds, pastId)

		if index then
			isUnlock = false
		end
	end

	return isUnlock
end

function M:getUnlockVoice(heroId, audioId, checkRes)
	local isUnlock = true
	local data = self:getHeroCacheData(heroId)

	if data then
		local lockIds = data.lockIds
		local index = table.indexof(lockIds, audioId + M.AUDIO_ID_OFFSET)

		if index then
			isUnlock = false
		end
	end

	if checkRes then
		local isExist = self:getIsVoiceResExist(heroId, audioId)

		if not isExist then
			isUnlock = false
		end
	end

	return isUnlock
end

function M:getIsVoiceResExist(heroId, audioId)
	local isExist = true
	local cfg = CharacterAudioConfig.instance:getCharacterAudioCOByHeroIdAndAudioId(heroId, audioId)
	local VoiceEnumRes = CharacterInfoEnum.VoiceRes[audioId]
	local voiceRes = VoiceEnumRes and string.format(VoiceEnumRes, heroId) or cfg.voiceId
	local wwiseCo = CriwareAudioConfig.instance:getCOByName(voiceRes)

	if not wwiseCo then
		isExist = false
	end

	return isExist
end

function M:getHeroCacheData(heroId)
	return self._heroCacheStatus[heroId]
end

function M:refreshHeroData(heroNO)
	local heroId = heroNO.id
	local heroLv = heroNO.level
	local powerLv = heroNO.powerLv
	local breakLv = heroNO.breakLv
	local tacitExp = heroNO.tacitExp

	self:setHeroCacheData(heroId, heroLv, powerLv, breakLv, tacitExp)
end

function M:setHeroCacheData(heroId, heroLv, powerLv, breakLv, tacitExp)
	local isNew = false

	if not self._heroCacheStatus[heroId] then
		self._heroCacheStatus[heroId] = {}
		isNew = true
	end

	self._heroCacheStatus[heroId].heroLv = heroLv
	self._heroCacheStatus[heroId].powerLv = powerLv
	self._heroCacheStatus[heroId].breakLv = breakLv
	self._heroCacheStatus[heroId].tacitExp = tacitExp

	if isNew then
		local lockIds = {}

		for keyStr, valInt in pairs(infoUnlockType) do
			local conditionLst = CharacterUnlockContentConfig.instance:getConditionLstPastId(heroId, valInt)
			local unlock = CharacterInformationController.instance:isConditionPass(heroId, conditionLst, true, heroLv, powerLv, breakLv, tacitExp)

			if not unlock then
				table.insert(lockIds, valInt)
			end
		end

		local cgfList = CharacterAudioConfig.instance:getCharacterAudiosById(heroId, true) or {}

		for _, _cfg in pairs(cgfList) do
			local conditionLst = CharacterUnlockContentConfig.instance:getConditionLstVoice(heroId, _cfg.audioId)
			local unlock = CharacterInformationController.instance:isConditionPass(heroId, conditionLst, true, heroLv, powerLv, breakLv, tacitExp)

			if not unlock then
				table.insert(lockIds, _cfg.audioId + M.AUDIO_ID_OFFSET)
			end
		end

		self._heroCacheStatus[heroId].lockIds = lockIds
		self._heroCacheStatus[heroId].newIds = self:_readInfoData(heroId)
	else
		local unlockMap = {}
		local lockIds = self._heroCacheStatus[heroId].lockIds

		for _, _id in ipairs(lockIds) do
			local conditionLst

			if _id > M.AUDIO_ID_OFFSET then
				local audioId = _id - M.AUDIO_ID_OFFSET

				conditionLst = CharacterUnlockContentConfig.instance:getConditionLstVoice(heroId, audioId)
			else
				conditionLst = CharacterUnlockContentConfig.instance:getConditionLstPastId(heroId, _id)
			end

			local unlock = CharacterInformationController.instance:isConditionPass(heroId, conditionLst, true, heroLv, powerLv, breakLv, tacitExp)

			if unlock then
				unlockMap[_id] = 1
			end
		end

		local newlockIds = {}

		for _, _id in ipairs(lockIds) do
			if unlockMap[_id] then
				local index = table.indexof(self._heroCacheStatus[heroId].newIds, _id)

				if not index then
					table.insert(self._heroCacheStatus[heroId].newIds, _id)
				end
			else
				table.insert(newlockIds, _id)
			end
		end

		self._heroCacheStatus[heroId].lockIds = newlockIds

		self:_writeInfoData(heroId)
		GlobalDispatcher:dispatchEvent(EventType.HERO_INFO_RED_DOT_CHANGE, heroId)
	end
end

function M:_writeInfoData(heroId)
	local data = self:getHeroCacheData(heroId)

	if not data then
		return
	end

	local newIds = data.newIds

	if newIds and #newIds >= 0 then
		local writeStr = table.concat(newIds, ",")
		local key = self:_getStoreKey(heroId)

		if Astral.OSDef.isEditor then
			printWarn(string.format("[角色资料][%s] %s", heroId, writeStr))
		end

		Astral.LocalStorage.Instance:SetString(key, writeStr)
		Astral.LocalStorage.Instance:Save()
	end
end

function M:_readInfoData(heroId)
	local newIds = {}
	local key = self:_getStoreKey(heroId)
	local str = Astral.LocalStorage.Instance:GetString(key, "")

	if not string.nilorempty(str) then
		for id in string.gmatch(str, "%d+") do
			table.insert(newIds, tonumber(id))
		end
	end

	return newIds
end

function M:_getStoreKey(subKey)
	local playerUuid = PlayerModel.instance:getId()

	return string.format("CharInfoRedP_%s_%s", playerUuid, subKey)
end

function M:checkRedPoint()
	local showRedPoint = false
	local viewPageMo = HeroDepotModel.instance:getViewPageMo()
	local heroData = viewPageMo and viewPageMo.hero or false

	if not heroData then
		GlobalDispatcher:dispatchEvent(EventType.RED_DOT_UPDATE_EVENT, {
			key = RedDotType.ERedDotKey.CHARACTERDATA,
			isActive = showRedPoint
		})

		return
	end

	local heroId = heroData:getId()
	local powerLv = heroData:getPowerLv()
	local heroLv = heroData:getLevel()
	local tacitLv = heroData:getTacit()
	local curFileInfos = {}

	GlobalDispatcher:dispatchEvent(EventType.RED_DOT_UPDATE_EVENT, {
		key = RedDotType.ERedDotKey.CHARACTERDATA,
		isActive = showRedPoint
	})
end

M.instance = M.New()

return M
