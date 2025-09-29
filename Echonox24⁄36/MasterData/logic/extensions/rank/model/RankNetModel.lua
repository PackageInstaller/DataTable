-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/rank/model/RankNetModel.lua

module("logic.extensions.rank.model.RankNetModel", package.seeall)

local M = class("RankNetModel", BaseModel)
local rankTypeToMO = {
	[CommEnum.RankEnum.FOOTBALL] = CollectionRankMO,
	[CommEnum.RankEnum.Collection] = CollectionRankMO,
	[CommEnum.RankEnum.Level] = LevelRankMO,
	[CommEnum.RankEnum.ClimbTower] = ClimbTowerRankMO,
	[CommEnum.RankEnum.AirWorkShop] = AirWorkShopRankMO,
	[CommEnum.RankEnum.MainLine] = MainLineRankMO,
	[CommEnum.RankEnum.AirWorkShopFreeEndless] = AirWorkShopEndlessRankMO
}

function M:ctor()
	self._rankListByIdDic = {}
	self._myRankByIdDic = {}
	self._validRnakIdsByTypeDic = {}
end

function M:updateRankInfo(rankId, entry, myEntry)
	if not rankId or not entry or not myEntry then
		return
	end

	if not self._rankListByIdDic[rankId] then
		self._rankListByIdDic[rankId] = {}
	end

	local curRankList = self._rankListByIdDic[rankId]
	local rankType = RankConfig.instance:getRankType(rankId)
	local moClass = rankTypeToMO[rankType] or RankBaseMO

	self:_checkRankListContinuity(curRankList, moClass, entry[1])

	for _, data in ipairs(entry) do
		local index = data.rank

		if index > 0 then
			local mo = curRankList[index]

			if not mo then
				mo = moClass.New()

				table.insert(curRankList, mo)
			end

			mo:updateData(rankId, data)
		end
	end

	self._myRankByIdDic[rankId] = moClass.New()

	self._myRankByIdDic[rankId]:updateData(rankId, myEntry)
end

function M:updateValidRankData(validRanks)
	local rankListByIdDic = {}
	local myRankByIdDic = {}
	local validRnakIdsByTypeDic = {}

	if validRanks then
		for _, rankId in ipairs(validRanks) do
			rankListByIdDic[rankId] = self._rankListByIdDic[rankId]
			myRankByIdDic[rankId] = self._myRankByIdDic[rankId]

			local rankType = RankConfig.instance:getRankType(rankId)

			if not validRnakIdsByTypeDic[rankType] then
				validRnakIdsByTypeDic[rankType] = {}
			end

			table.insert(validRnakIdsByTypeDic[rankType], rankId)
		end
	end

	self._rankListByIdDic = rankListByIdDic
	self._myRankByIdDic = myRankByIdDic
	self._validRnakIdsByTypeDic = validRnakIdsByTypeDic
end

function M:getRankListById(rankId)
	return self._rankListByIdDic[rankId]
end

function M:getMyRankById(rankId)
	return self._myRankByIdDic[rankId]
end

function M:isValidRank(rankId)
	return
end

function M:getValidRankIds(rankType)
	return self._validRnakIdsByTypeDic[rankType]
end

function M:_checkRankListContinuity(rankList, moClass, startEntry)
	if not startEntry or startEntry.rank <= 0 then
		return
	end

	local listEnd = startEntry.rank - 1

	if listEnd <= #rankList then
		return
	end

	for i = #rankList + 1, listEnd do
		local mo = moClass.New()

		table.insert(rankList, mo)
	end

	print("校正排行榜数据连续性")
end

function M:onReset()
	self._rankListByTypeDic = {}
	self._myRankByIdDic = {}
	self._validRnakIdsByTypeDic = {}
end

M.instance = M.New()

return M
