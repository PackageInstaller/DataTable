-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/playerinfo/controller/HandbookController.lua

module("logic.extensions.playerinfo.controller.HandbookController", package.seeall)

local M = class("HandbookController", BaseController)

function M:ctor()
	M.super.ctor(self)
end

function M:onInit()
	self:onReset()
	self:_regUnlockConditionCheckFuncMap()
	GlobalDispatcher:addEventListener(EventType.PLAYER_INFO_MAIN_OPEN, self._onEnterPlayInfoMainView, self)
end

function M:onLateInit()
	return
end

function M:onReset()
	self._hadGetAllUnlockGalleryIds = nil
end

function M:_onEnterPlayInfoMainView()
	self:tryGetAllUnlockGalleryIds()
end

function M:tryGetAllUnlockGalleryIds()
	if not self._hadGetAllUnlockGalleryIds then
		self._hadGetAllUnlockGalleryIds = true

		PlayerAgent.instance:sendGetUnlockGalleryRequestAllTyp()
	end
end

function M:tryGetMonsterComment(monsterId)
	local mo = GalleryModel.instance:getMonsterComment(monsterId)

	if mo then
		local needReAsk = true

		if needReAsk then
			GalleryAgent.instance:sendGetMonsterCommentRequest(monsterId)
		else
			GlobalDispatcher:dispatchEvent(EventType.HANDBOOK_MONSTER_TAG_CHANGE, monsterId)
		end
	else
		GalleryAgent.instance:sendGetMonsterCommentRequest(monsterId)
	end
end

function M:onGetUnlockGalleryReply(dataLst)
	if dataLst and #dataLst > 0 then
		for _, UnlockInfoNO in ipairs(dataLst) do
			local typ = UnlockInfoNO.type

			if typ <= 100 then
				local ids = UnlockInfoNO.id or {}

				GalleryModel.instance:updateUnlockIds(typ, ids)
			end
		end
	end
end

function M:onCommitMonsterCommentReply(info)
	local monsterId = info.monsterId
	local mo = GalleryModel.instance:getMonsterComment(monsterId)

	mo:setMyStar(info.myStar)
	mo:setMyTags(info.myTagIds)
	GlobalDispatcher:dispatchEvent(EventType.HANDBOOK_MONSTER_TAG_CHANGE, monsterId)
end

function M:onUnlockPush(galleryTypeEnum, ids)
	if ids and #ids > 0 then
		GalleryModel.instance:updateUnlockIds(galleryTypeEnum, ids)
		GalleryModel.instance:updateNewUnlockIds(galleryTypeEnum, ids)
		GlobalDispatcher:dispatchEvent(EventType.HANDBOOK_UNREAD_INFO_CHANGE)
	end
end

function M:onGetMonsterCommentReply(monsterId, msg)
	if msg then
		local star = msg.star
		local commentPlayerCount = msg.count
		local tagLst = msg.tag
		local myStar = msg.myStar
		local myTagIds = msg.myTag

		printWarn(string.format("怪物[%s] 难度星[%s] 评价人数[%s] 我的难度星[%s]", monsterId, star, commentPlayerCount, myStar))

		if myTagIds and #myTagIds > 0 then
			printWarn(string.format("玩家对怪物标签->%s", table.concat(myTagIds, ",")))
		else
			printWarn("玩家对怪物标签为空")
		end

		if tagLst and #tagLst > 0 then
			for _, value in ipairs(tagLst) do
				printWarn(string.format("热门标签 id[%s] count[%s]", value.id, value.count))
			end
		else
			printWarn("怪物热门标签长度为0")
		end

		GalleryModel.instance:updateMonsterComment(monsterId, msg)
		GlobalDispatcher:dispatchEvent(EventType.HANDBOOK_MONSTER_TAG_CHANGE, monsterId)
	end
end

function M:onUnlockPlotMemoryReply(ids)
	if ids and #ids > 0 then
		local typ = GameEnum.UnlockTypeEnum.PlotMemory

		printWarn(string.format("剧情回溯确认解锁，id长度为[%d] ->%s", #ids, table.concat(ids, ",")))
		GalleryModel.instance:updateUnlockIds(typ, ids)
		GalleryModel.instance:updateNewUnlockIds(typ, ids)
		GlobalDispatcher:dispatchEvent(EventType.HANDBOOK_UNREAD_INFO_CHANGE)
	end
end

function M:setHandbookTypAllRead(galleryTypeEnum)
	GalleryModel.instance:setNewUnlockIds(galleryTypeEnum, nil)
	GlobalDispatcher:dispatchEvent(EventType.HANDBOOK_UNREAD_INFO_CHANGE)
end

function M:setHandbookTypIdRead(galleryTypeEnum, id, broadCast)
	local leftUnRead = {}
	local idsCache = GalleryModel.instance:getTypUnReadNewIds(galleryTypeEnum)

	for idInCache, _ in pairs(idsCache) do
		if idInCache ~= id then
			table.insert(leftUnRead, idInCache)
		end
	end

	GalleryModel.instance:setNewUnlockIds(galleryTypeEnum, leftUnRead)

	if broadCast then
		GlobalDispatcher:dispatchEvent(EventType.HANDBOOK_UNREAD_INFO_CHANGE)
	end
end

function M:setHandbookTypIdsRead(galleryTypeEnum, ids, broadCast)
	local setReadMap = {}

	for index, id in ipairs(ids) do
		setReadMap[id] = 1
	end

	local leftUnRead = {}
	local idsCache = GalleryModel.instance:getTypUnReadNewIds(galleryTypeEnum)

	for id, _ in pairs(idsCache) do
		if not setReadMap[id] then
			table.insert(leftUnRead, id)
		end
	end

	GalleryModel.instance:setNewUnlockIds(galleryTypeEnum, leftUnRead)

	if broadCast then
		GlobalDispatcher:dispatchEvent(EventType.HANDBOOK_UNREAD_INFO_CHANGE)
	end
end

M._unlockCondition = {
	characterLv = 2,
	item = 6,
	dungeon = 4,
	plotMemory = 5,
	tacitLv = 3,
	level = 1
}

function M:_regUnlockConditionCheckFuncMap()
	local Map = {
		[self._unlockCondition.level] = self._checkLevel,
		[self._unlockCondition.characterLv] = self._checkCharacterLv,
		[self._unlockCondition.tacitLv] = self._checktacitLv,
		[self._unlockCondition.dungeon] = self._checkDungeon,
		[self._unlockCondition.plotMemory] = self._checkPlotMemory,
		[self._unlockCondition.item] = self._checkItem
	}

	self._unLockConditionFuncMap = {}

	for keyStr, val in pairs(self._unlockCondition) do
		if Map[val] then
			self._unLockConditionFuncMap[keyStr] = Map[val]
		end
	end

	Map = nil
end

function M:checkAutoUnlockPlotMemory()
	local canUnlockIds = {}
	local cfgLst = HandbookConfig.instance:getConfigList(ConfigName.GalleryPlotMemory)

	for _, cfg in ipairs(cfgLst or {}) do
		if not GalleryModel.instance:getIsUnLock(GameEnum.UnlockTypeEnum.PlotMemory, cfg.id) and self:checkGalleryUnLockCondition(cfg.condition) then
			table.insert(canUnlockIds, cfg.id)
		end
	end

	if #canUnlockIds > 0 then
		GalleryAgent.instance:sendUnlockPlotMemoryRequest(canUnlockIds)
	end
end

function M:checkGalleryUnLockCondition(conditionLst)
	local unlock = true
	local len = conditionLst and #conditionLst or 0

	if len > 0 then
		for _, conDef in ipairs(conditionLst) do
			local typ = conDef.type
			local val = conDef.value
			local func = self._unLockConditionFuncMap[typ]
			local oneUnlock = false

			if func then
				oneUnlock = func(val)
			else
				printError(string.format("无法找到[%s]对应方法", typ))
			end

			if not oneUnlock then
				unlock = false

				break
			end
		end
	end

	return unlock
end

function M._checkLevel(lv)
	local playerLevel = PlayerModel.instance:getLevel()

	if playerLevel >= tonumber(lv) then
		return true
	end

	return false
end

function M._checkCharacterLv(heroLvPairs)
	local unlock = true
	local hPairs = string.split(heroLvPairs, ",")
	local len = hPairs and #hPairs or 0

	if len > 0 then
		for _, val in ipairs(hPairs) do
			local group = string.split(val, "_")
			local heroId = tonumber(group[1])
			local reqLv = tonumber(group[2])
			local heroMo = HeroDepotModel.instance:getHeroInfoByID(heroId)

			if heroMo then
				if reqLv > heroMo:getLevel() then
					unlock = false

					break
				end
			else
				unlock = false

				break
			end
		end
	end

	return unlock
end

function M._checktacitLv(heroFavPairs)
	local unlock = true
	local hPairs = string.split(heroFavPairs, ",")
	local len = hPairs and #hPairs or 0

	if len > 0 then
		for _, val in ipairs(hPairs) do
			local group = string.split(val, "_")
			local heroId = tonumber(group[1])
			local reqLv = tonumber(group[2])
			local heroMo = HeroDepotModel.instance:getHeroInfoByID(heroId)

			if heroMo then
				if reqLv > heroMo:getTacit() then
					unlock = false

					break
				end
			else
				unlock = false

				break
			end
		end
	end

	return unlock
end

function M._checkDungeon(dungeonIds)
	local unlock = true
	local ids = string.split(dungeonIds, ",")
	local len = ids and #ids or 0

	if len > 0 then
		for index, id in ipairs(ids) do
			if DungeonModel.instance:getDungeonPassDataByDungeonId(tonumber(id)) == nil then
				unlock = false

				break
			end
		end
	end

	return unlock
end

function M._checkPlotMemory(plotMemoryCfgIds)
	local unlock = true
	local ids = string.split(plotMemoryCfgIds, ",")
	local len = ids and #ids or 0

	if len > 0 then
		for index, id in ipairs(ids) do
			local checkUnlock = GalleryModel.instance:getIsUnLock(GameEnum.UnlockTypeEnum.PlotMemory, tonumber(id))

			if not checkUnlock then
				unlock = false

				break
			end
		end
	end

	return unlock
end

function M._checkItem(itemIdLst)
	local unlock = true
	local ids = string.split(itemIdLst, ",")
	local len = ids and #ids or 0

	if len > 0 then
		for index, id in ipairs(ids) do
			local num = ItemModel.instance:getItemCountByItemId(tonumber(id))

			if num <= 0 then
				unlock = false

				break
			end
		end
	end

	return unlock
end

M.instance = M.New()

return M
