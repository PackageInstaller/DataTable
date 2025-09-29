-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/battle/model/BattleCalculateModel.lua

module("logic.extensions.battle.model.BattleCalculateModel", package.seeall)

local M = class("BattleCalculateModel", BaseModel)

function M:onInit()
	self._isWin = false
	self._itemMOList = {}
	self._allHeroIdList = {}
	self._calculateHeroIdList = {}
	self._playerLevelInfo = {
		exp = 0,
		level = 0
	}
	self._heroLevelInfoList = {}
	self._cacheItemMOList = {}
	self._defaultItemMOList = {}
	self._winDesType = {}
	self._customResultViewClass = false
	self._hasGotCalculateData = false
	self._heroCount = nil
end

function M:onReset()
	self._isWin = false
	self._customResultViewClass = false
	self._hasGotCalculateData = false
	self._heroCount = nil

	BattleTableUtil.clearTable(self._itemMOList)
	BattleTableUtil.clearTable(self._allHeroIdList)
	BattleTableUtil.clearTable(self._calculateHeroIdList)
	BattleTableUtil.clearTable(self._playerLevelInfo)
	BattleTableUtil.clearTable(self._heroLevelInfoList)
	BattleTableUtil.clearTable(self._cacheItemMOList)
	BattleTableUtil.clearTable(self._defaultItemMOList)
	BattleTableUtil.clearTable(self._winDesType)
end

function M:clear()
	self._isWin = false
	self._customResultViewClass = false
	self._hasGotCalculateData = false
	self._heroCount = nil

	BattleTableUtil.clearTable(self._itemMOList)
	BattleTableUtil.clearTable(self._allHeroIdList)
	BattleTableUtil.clearTable(self._calculateHeroIdList)
	BattleTableUtil.clearTable(self._playerLevelInfo)
	BattleTableUtil.clearTable(self._heroLevelInfoList)
	BattleTableUtil.clearTable(self._defaultItemMOList)
	BattleTableUtil.clearTable(self._winDesType)
end

function M:backupCalculateModel()
	self._playerLevelInfo.level = PlayerModel.instance:getLevel()
	self._playerLevelInfo.exp = PlayerModel.instance:getExp()

	for _, heroId in ipairs(self._calculateHeroIdList) do
		local heroMO = HeroDepotModel.instance:getHeroInfoByID(heroId)

		if heroMO then
			self._heroLevelInfoList[heroId] = {
				level = heroMO:getLevel(),
				exp = heroMO:getLevelExp()
			}
		end
	end
end

function M:getHeroLevelInfoById(id)
	return self._heroLevelInfoList[id] or false
end

function M:getPlayerLevelInfo()
	return self._playerLevelInfo
end

function M:setCacheItemMOList(itemMoList)
	table.insertto(self._cacheItemMOList, itemMoList)
end

function M:popCacheItemMoList()
	if self._cacheItemMOList and #self._cacheItemMOList ~= 0 then
		local len = self._cacheItemMOList and #self._cacheItemMOList or 0
		local heroIds = {}

		if len > 0 then
			for index, value in ipairs(self._cacheItemMOList) do
				if value:getType() == GameEnum.ItemTypeEnum.HeroType then
					table.insert(heroIds, value:getItemId())
				end
			end
		end

		if #heroIds > 0 then
			RetrieveFacade.instance:showGetRole(heroIds[1])
		end

		ItemConvertController.instance:clearCache()
		BattleTableUtil.clearTable(self._cacheItemMOList)
	end
end

function M:setCacheItemConvertList(itemConvertList)
	self._cacheItemConvertList = itemConvertList
end

function M:popCacheItemConvertList()
	if self._cacheItemConvertList then
		ViewMgr.instance:open(ViewName.ItemConvert, self._cacheItemConvertList)

		self._cacheItemConvertList = nil
	end
end

function M:setDefaultItemMoList(pointCount)
	if pointCount > 0 then
		local item = ItemData.New({
			itemId = 1100006,
			count = pointCount
		})

		table.insert(self._defaultItemMOList, item)
	end
end

function M:getDefaultItemMoList()
	if self._defaultItemMOList and #self._defaultItemMOList > 0 then
		return self._defaultItemMOList
	end

	local dungeonCode = BattleEnterUtil.getCurrentDungeonCode()

	if dungeonCode then
		local dungeonMO = DungeonModel.instance:getDungeonMoById(dungeonCode)
		local dungeonCO = dungeonMO:getDungeonCO()

		if dungeonCO.pointCost > 0 then
			local item = ItemData.New({
				itemId = 1100006,
				count = dungeonCO.pointCost
			})

			table.insert(self._defaultItemMOList, item)
		end
	end

	return self._defaultItemMOList
end

function M:setCalculateItemProto(rewards)
	local temp = {}

	for i, reward in ipairs(rewards) do
		local tempItem = temp[reward.reward.itemId]
		local canStacked = ItemUtil.canStacked(reward.reward.itemId)

		if tempItem and tempItem:getRewardTag() == reward.rewardTag and canStacked then
			tempItem:setCount(tempItem:getCount() + reward.itemCount)
		else
			local tempReward = reward.reward
			local item = ItemUtil.createItemData(tempReward)

			item:setRewardTag(reward.rewardTag or 0)

			temp[reward.reward.itemId] = item

			table.insert(self._itemMOList, item)
		end
	end
end

function M:getCalculateItemMOList()
	table.sort(self._itemMOList, ItemUtil.commonSortFunc)

	local newMap = {}
	local resutlMap = {}

	for i = 1, #self._itemMOList do
		local tempItem = newMap[self._itemMOList[i]:getItemId()]

		if tempItem then
			if tempItem:getRewardTag() > 0 and self._itemMOList[i]:getRewardTag() > 0 then
				table.insert(resutlMap, tempItem.index + 1, self._itemMOList[i])
			else
				table.insert(resutlMap, self._itemMOList[i])
			end
		else
			local item = self._itemMOList[i]

			item.index = i
			newMap[item:getItemId()] = item

			table.insert(resutlMap, item)
		end
	end

	return resutlMap
end

function M:setCalculateHeroCount(count)
	self._heroCount = count
end

function M:getCalculateHeroCount(count)
	return self._heroCount
end

function M:setCalculateHeroBattleData(datas)
	self._hasGotCalculateData = true
	self._heroBattleData = {}

	for i, data in ipairs(datas) do
		local heroData = {
			code = data.code,
			hpDecrement = data.hpDecrement,
			sanityDecrement = data.sanityDecrement,
			enemyKilled = data.enemyKilled,
			phyDamage = data.phyDamage,
			magDamage = data.magDamage,
			cured = data.cured
		}

		table.insert(self._heroBattleData, heroData)
	end
end

function M:hasGotCalculateData()
	return self._hasGotCalculateData
end

function M:getCalculateHeroBattleData()
	return self._heroBattleData
end

function M:getCalculateHeroIdList()
	return self._calculateHeroIdList
end

function M:getAllHeroIdList()
	return self._allHeroIdList
end

function M:setIsWin(isWin)
	self._isWin = isWin
end

function M:buildBattelReprot()
	local allReportCO = BattleConfig.instance:getAllBattleReportConfig()
	local maxCount = #allReportCO

	self._winDesType = {}

	for i = 1, #self._heroBattleData do
		local heroData = self._heroBattleData[i]

		for j = 1, maxCount do
			local attrValue = self:_getHeroDataByIndex(j, heroData)

			if attrValue > 0 and not TableUtil.contains(self._winDesType, j) then
				table.insert(self._winDesType, j)
			end
		end
	end

	local count = 2
	local length = #self._winDesType

	for i = 1, count do
		local ri = math.random(i, length)
		local tmp = self._winDesType[i]

		self._winDesType[i] = self._winDesType[ri]
		self._winDesType[ri] = tmp
	end
end

function M:isWin()
	return self._isWin
end

function M:setCustomResultViewClass(viewClass)
	self._customResultViewClass = viewClass
end

function M:getCustomResultViewClass()
	return self._customResultViewClass
end

function M:getBattleReortInfo(index)
	if index > #self._winDesType then
		return false, false, false
	end

	local typeIndex = self._winDesType[index]
	local reportCO = BattleConfig.instance:getBattleReportDesc(typeIndex)
	local heroData, value = self:_getHeroIdByIndex(typeIndex)

	return reportCO, heroData, value
end

function M:_getHeroIdByIndex(index)
	table.sort(self._heroBattleData, function(hero1, hero2)
		if not hero1 or not hero2 then
			return false
		end

		local value1 = self:_getHeroDataByIndex(index, hero1)
		local value2 = self:_getHeroDataByIndex(index, hero2)

		if value1 == value2 then
			return hero1.code > hero2.code
		else
			return value2 < value1
		end
	end)

	local len = #self._heroBattleData

	if len > 0 then
		local firstData = self._heroBattleData[1]
		local value = self:_getHeroDataByIndex(index, firstData)

		return firstData, value
	end
end

function M:_getHeroDataByIndex(index, heroData)
	local value = 0

	if index == 1 then
		value = heroData.hpDecrement
	elseif index == 2 then
		value = heroData.sanityDecrement
	elseif index == 3 then
		value = heroData.enemyKilled
	elseif index == 4 then
		value = heroData.phyDamage
	elseif index == 5 then
		value = heroData.magDamage
	elseif index == 6 then
		value = heroData.cured
	end

	return value
end

M.instance = M.New()

return M
