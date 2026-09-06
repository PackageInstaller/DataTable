-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/anniversarykoi/model/AnniversaryKoiModel.lua

module("logic.extensions.anniversarykoi.model.AnniversaryKoiModel", package.seeall)

local AnniversaryKoiModel = class("AnniversaryKoiModel", BaseModel)

function AnniversaryKoiModel:ctor()
	return
end

function AnniversaryKoiModel:onInit()
	self:onReset()
end

function AnniversaryKoiModel:onReset()
	self._info = {}
	self._myNumber = {}
	self._koiNumber = {}
	self._rankMsgList = {}
	self._recordList = {}
	self._isNewRecord = false
	self._rankIndex = 0
end

function AnniversaryKoiModel:setInfo(msg)
	self._info = {}

	GameUtil.pbToTable(msg, self._info)

	local todayNumber = self._info.todayNumber

	if todayNumber then
		self._koiNumber = todayNumber[1].myNumbers or {}
	end
end

function AnniversaryKoiModel:getPlayerList()
	return self._info.koiPlayerList
end

function AnniversaryKoiModel:getMyNumberInfo()
	local info = self._info.myNumbers

	if info then
		for _, data in pairs(info) do
			return data.myNumbers
		end
	end
end

function AnniversaryKoiModel:setMyNumberInfo(msg)
	table.clear(self._myNumber)
	GameUtil.pbToTable(msg, self._myNumber)
end

function AnniversaryKoiModel:getMyNumber()
	return self._myNumber
end

function AnniversaryKoiModel:resetMyNumberInfo()
	self._myNumber = {}
end

function AnniversaryKoiModel:setKoiNumberInfo(msg)
	GameUtil.pbToTable(msg, self._koiNumber)
end

function AnniversaryKoiModel:getKoiNumber()
	return self._koiNumber
end

function AnniversaryKoiModel:getRankId()
	return self._rankIndex
end

function AnniversaryKoiModel:setRankId(rankIndex)
	self._rankIndex = rankIndex
end

function AnniversaryKoiModel:setRankList(msg)
	table.clear(self._rankMsgList)
	GameUtil.pbToTable(msg, self._rankMsgList)
end

function AnniversaryKoiModel:getRankList(poolId, prizeType)
	if checknumber(self._rankMsgList.poolId) == poolId and checknumber(self._rankMsgList.prizeType) == prizeType then
		if not self._rankMsgList.rankList then
			if #self._rankMsgList.rankList > 0 then
				table.sort(self._rankMsgList.rankList, function(a, b)
					return a.timeStamp > b.timeStamp
				end)

				return self._rankMsgList.rankList
			end
		end
	end
end

function AnniversaryKoiModel:setRecordInfo(msg)
	GameUtil.pbToTable(msg, self._recordList)
end

function AnniversaryKoiModel:getRecord(poolId)
	local record = {}

	for _, data in pairs(self._recordList) do
		if data.poolId == poolId then
			table.insert(record, data)
		end
	end

	return record
end

function AnniversaryKoiModel:setRecordLightRed(isLight)
	self._isNewRecord = isLight
end

function AnniversaryKoiModel:getRecordLightRed()
	return self._isNewRecord
end

AnniversaryKoiModel.instance = AnniversaryKoiModel.New()

return AnniversaryKoiModel
