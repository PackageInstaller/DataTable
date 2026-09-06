-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/burygame/model/BuryGameModel.lua

module("logic.extensions.burygame.model.BuryGameModel", package.seeall)

local BuryGameModel = class("BuryGameModel", TLCBaseGameModel)

function BuryGameModel:onInit()
	return
end

function BuryGameModel:onReset()
	return
end

function BuryGameModel:getActivityId()
	local activityType = GameEnum.ActivityType.BuryGame
	local cfg = ActivityDefineController.instance:getActivityCfgByType(activityType)

	return (cfg or nil) and checknumber(cfg.activityId)
end

function BuryGameModel:setInfo(info)
	self._todayGameTimes = checknumber(info.todayGameTimes)
	self._todayGameBuyTimes = checknumber(info.todayGameBuyTimes)
	self._totalScore = checknumber(info.totalScore)
	self._scorePrizeGainBits = info.scorePrizeGainBits or {}
end

function BuryGameModel:getUsedTimes()
	return checknumber(self._todayGameTimes)
end

function BuryGameModel:getBuyedTimes()
	return checknumber(self._todayGameBuyTimes)
end

function BuryGameModel:setGameStartInfo(msg)
	self:setServerKey(msg.serverKey)

	self._specialPrizeIds = msg.specialPrizeIds
end

function BuryGameModel:getSpecialPrizeIds()
	return self._specialPrizeIds or {}
end

function BuryGameModel:subTodayGameBuyTimes()
	self._todayGameBuyTimes = self._todayGameBuyTimes + 1
end

function BuryGameModel:getTotalScore()
	return checknumber(self._totalScore)
end

function BuryGameModel:setTotalScore(value)
	self._totalScore = value
end

function BuryGameModel:isGainedById(id)
	if self._scorePrizeGainBits then
		for k, v in ipairs(self._scorePrizeGainBits) do
			if k == id then
				return v
			end
		end
	end

	return false
end

function BuryGameModel:setGainedById(id)
	if self._scorePrizeGainBits then
		for k, v in ipairs(self._scorePrizeGainBits) do
			if k == id then
				self._scorePrizeGainBits[id] = true

				break
			end
		end
	end
end

function BuryGameModel:setRankInfo(msg)
	self._rankInfo = msg
end

function BuryGameModel:getRankInfo()
	return self._rankInfo
end

BuryGameModel.instance = BuryGameModel.New()

return BuryGameModel
