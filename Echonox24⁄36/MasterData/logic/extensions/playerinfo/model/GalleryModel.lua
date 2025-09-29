-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/playerinfo/model/GalleryModel.lua

module("logic.extensions.playerinfo.model.GalleryModel", package.seeall)

local M = class("GalleryModel", BaseModel)

function M:onInit()
	self:onReset()
end

function M:onReset()
	local typ = GameEnum.UnlockTypeEnum

	self._unlockIds = {}
	self._unlockIds[typ.Hero] = {}
	self._unlockIds[typ.Monster] = {}
	self._unlockIds[typ.CG] = {}
	self._unlockIds[typ.Music] = {}
	self._unlockIds[typ.PlotMemory] = {}
	self._unlockIds[typ.Event] = {}
	self._unlockIds[typ.Word] = {}
	self._unlockIds[typ.Protomer] = {}
	self._unlockIds[typ.EchoItem] = {}
	self._unlockIds[typ.HeroRelation] = {}
	self._isReadFromCache = false
	self._newUnlockIds = {}
	self._newUnlockCount = {}
	self._myMonsterComment = {}
	self._playerInfoViewMsg = {}
end

function M:updateUnlockIds(typ, ids)
	if not self._unlockIds[typ] then
		self._unlockIds[typ] = {}
	end

	for _, id in ipairs(ids or {}) do
		self._unlockIds[typ][id] = 1
	end
end

function M:updateSingleUnlockId(typ, id)
	if not self._unlockIds[typ] then
		self._unlockIds[typ] = {}
	end

	self._unlockIds[typ][id] = 1
end

function M:getIsUnLock(typ, id)
	local isUnLock = false

	if self._unlockIds[typ] and self._unlockIds[typ][id] then
		isUnLock = true
	end

	return isUnLock
end

function M:getTypUnlockCount(typ)
	local count = 0

	if not self._unlockIds[typ] then
		return count
	end

	for key, value in pairs(self._unlockIds[typ]) do
		count = count + 1
	end

	return count
end

function M:getAllUnlockCount()
	local count = 0
	local allUnlockTyp = HandbookConfig.instance:getAllUnlockTyp()

	for _, typVal in ipairs(allUnlockTyp) do
		count = count + self:getTypUnlockCount(typVal)
	end

	return count
end

function M:getCampUnlockCount(camp)
	local count = 0
	local campHeroIds = HandbookConfig.instance:getCampHeroIds(camp)

	if #campHeroIds > 0 then
		for _, heroId in ipairs(campHeroIds) do
			if self:getIsUnLock(GameEnum.UnlockTypeEnum.Hero, heroId) then
				count = count + 1
			end
		end
	end

	return count
end

function M:updateMonsterComment(monsterId, msg)
	if not self._myMonsterComment[monsterId] then
		self._myMonsterComment[monsterId] = GalleryMonsterCommentMo.New(monsterId)
	end

	local theMo = self._myMonsterComment[monsterId]

	theMo:updateFromServer(msg)
end

function M:getMonsterComment(monsterId)
	return self._myMonsterComment[monsterId]
end

function M:updateNewUnlockIds(galleryTypeEnum, ids)
	if not self:getIsReadedFromCache() then
		self:_readAllUnWriteNewInfo()
	end

	if not self._newUnlockIds[galleryTypeEnum] then
		self._newUnlockIds[galleryTypeEnum] = {}
	end

	for _, id in ipairs(ids or {}) do
		self._newUnlockIds[galleryTypeEnum][id] = 1
	end

	if not self._newUnlockCount[galleryTypeEnum] then
		self._newUnlockCount[galleryTypeEnum] = 0
	end

	local typCount = 0
	local keyTable = {}

	for key, _ in pairs(self._newUnlockIds[galleryTypeEnum] or {}) do
		typCount = typCount + 1

		table.insert(keyTable, key)
	end

	self._newUnlockCount[galleryTypeEnum] = typCount

	local writeStr

	if typCount > 0 then
		writeStr = table.concat(keyTable, "#")
	else
		writeStr = "#"
	end

	self:_writeUnWriteNewInfo(galleryTypeEnum, writeStr)
end

function M:setNewUnlockIds(galleryTypeEnum, ids)
	if not self:getIsReadedFromCache() then
		self:_readAllUnWriteNewInfo()
	end

	self._newUnlockIds[galleryTypeEnum] = {}

	self:updateNewUnlockIds(galleryTypeEnum, ids)
end

function M:getTypUnReadNewIds(galleryTypeEnum)
	if not self:getIsReadedFromCache() then
		self:_readAllUnWriteNewInfo()
	end

	return self._newUnlockIds[galleryTypeEnum] or {}
end

function M:getTypUnReadCount(galleryTypeEnum)
	if not self:getIsReadedFromCache() then
		self:_readAllUnWriteNewInfo()
	end

	return self._newUnlockCount[galleryTypeEnum] or 0
end

function M:getIsIdUnRead(galleryTypeEnum, id)
	if not self:getIsReadedFromCache() then
		self:_readAllUnWriteNewInfo()
	end

	if not self._newUnlockIds[galleryTypeEnum] then
		return false
	end

	return self._newUnlockIds[galleryTypeEnum][id] ~= nil
end

function M:getIsIdsUnRead(galleryTypeEnum, ids)
	local hasUnRead = false

	for _, id in ipairs(ids) do
		if self:getIsIdUnRead(galleryTypeEnum, id) then
			hasUnRead = true

			break
		end
	end

	return hasUnRead
end

function M:_writeUnWriteNewInfo(typ, str)
	local key = self:getUnReadNewInfoStoreKey(typ)

	Astral.LocalStorage.Instance:SetString(key, str)
	Astral.LocalStorage.Instance:Save()
end

function M:_readAllUnWriteNewInfo()
	local allUnlockTyp = HandbookConfig.instance:getAllUnlockTyp()

	for _, typVal in ipairs(allUnlockTyp) do
		self:_readUnWriteNewInfo(typVal)
	end

	self._isReadFromCache = true
end

function M:_readUnWriteNewInfo(typ)
	self._newUnlockCount[typ] = 0

	if not self._newUnlockIds[typ] then
		self._newUnlockIds[typ] = {}
	end

	local key = self:getUnReadNewInfoStoreKey(typ)
	local str = Astral.LocalStorage.Instance:GetString(key, "#")
	local count = 0

	for id in string.gmatch(str, "%d+") do
		self._newUnlockIds[typ][tonumber(id)] = 1
		count = count + 1
	end

	self._newUnlockCount[typ] = count
end

function M:getIsReadedFromCache()
	return self._isReadFromCache
end

function M:getUnReadNewInfoStoreKey(typ)
	local playerUuid = PlayerModel.instance:getId()

	return string.format("Handbook_%s_%s", playerUuid, typ)
end

function M:_dealUnReadRelation()
	local typNewUnlockMap = self._newUnlockIds[GameEnum.UnlockTypeEnum.HeroRelation]
	local tmpMap = {}

	for id, value in pairs(typNewUnlockMap or {}) do
		local cfg = HandbookConfig.instance:getConfigByKey(ConfigName.HeroRelation, id)

		if cfg then
			if cfg.priority <= 0 then
				tmpMap[id] = 1
			else
				local heroId = cfg.heroId
				local targetHeroId = cfg.targetId
				local theCfg = HandbookConfig.instance:getHeroToOtherHeroRelation(heroId, targetHeroId)

				if theCfg and theCfg.id == id then
					tmpMap[id] = 1
				end
			end
		end
	end

	self._newUnlockIds[GameEnum.UnlockTypeEnum.HeroRelation] = tmpMap
end

function M:setPlayerInfoViewMsg(info)
	self._playerInfoViewMsg = info
end

function M:getPlayerInfoViewMsg()
	return self._playerInfoViewMsg or {}
end

M.instance = M.New()

return M
