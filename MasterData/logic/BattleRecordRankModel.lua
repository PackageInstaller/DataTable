-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/battlerecord/model/BattleRecordRankModel.lua

module("logic.extensions.battlerecord.model.BattleRecordRankModel", package.seeall)

local BattleRecordRankModel = class("BattleRecordRankModel", BaseModel)

function BattleRecordRankModel:ctor()
	return
end

function BattleRecordRankModel:onInit()
	self:onReset()
end

function BattleRecordRankModel:onReset()
	self._rankLists = nil
	self._records = nil
end

function BattleRecordRankModel:onBattleRecordRanks(rankKey, respond)
	self._rankLists = self._rankLists or {}
	self._rankLists[rankKey] = {
		rankKey = rankKey,
		myRank = respond.myRank,
		rankList = respond.rankList
	}
end

function BattleRecordRankModel:getBattleRecordRanks(rankKey)
	if self._rankLists then
		return self._rankLists[rankKey]
	end
end

function BattleRecordRankModel:getRank(rankKey, rank)
	local ranks = self:getBattleRecordRanks(rankKey)

	if ranks then
		return ranks.rankList[rank]
	end
end

function BattleRecordRankModel:getRankBtlResult(rankKey, rank)
	local ranks = self:getBattleRecordRanks(rankKey)

	if ranks and ranks.btlResults then
		local rankData = self:getRank(rankKey, rank)

		for i = 1, #ranks.btlResults do
			local btlData = ranks.btlResults[i]

			if checknumber(btlData.rank) == rank and btlData.userId == rankData.userId then
				return btlData
			end
		end
	end
end

function BattleRecordRankModel:saveRankBtlResule(rankKey, rank, btlResult, time)
	local ranks = self:getBattleRecordRanks(rankKey)

	if ranks then
		ranks.btlResults = ranks.btlResults or {}

		local rankData = self:getRank(rankKey, rank)

		table.insert(ranks.btlResults, {
			rank = rank,
			userId = rankData.userId,
			result = btlResult,
			btlTime = time
		})
	end
end

function BattleRecordRankModel:getRankDetails(rankKey, rank)
	local ranks = self:getBattleRecordRanks(rankKey)

	if ranks and ranks.rankDetails then
		local rankData = self:getRank(rankKey, rank)

		for i = 1, #ranks.rankDetails do
			local detailData = ranks.rankDetails[i]

			if checknumber(detailData.rank) == rank and detailData.userId == rankData.userId then
				return detailData
			end
		end
	end
end

function BattleRecordRankModel:saveRankDetails(rankKey, rank, detailData, time)
	local ranks = self:getBattleRecordRanks(rankKey)

	if ranks then
		ranks.rankDetails = ranks.rankDetails or {}

		local rankData = self:getRank(rankKey, rank)

		table.insert(ranks.rankDetails, {
			rank = rank,
			userId = rankData.userId,
			details = detailData,
			detailsTime = time
		})
	end
end

function BattleRecordRankModel:onBattleLatestRecords(rankKey, respond)
	self._records = self._records or {}
	self._records[rankKey] = {
		rankKey = rankKey,
		recordList = respond.recordList
	}
end

function BattleRecordRankModel:getBattleLatestRecords(rankKey)
	if self._records then
		return self._records[rankKey]
	end
end

BattleRecordRankModel.instance = BattleRecordRankModel.New()

return BattleRecordRankModel
