-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/bricksxgame/model/BricksxgameModel.lua

module("logic.extensions.bricksxgame.model.BricksxgameModel", package.seeall)

local BricksxgameModel = class("BricksxgameModel", BaseModel)

function BricksxgameModel:onInit()
	self:onReset()
end

function BricksxgameModel:onReset()
	self._msgPool = {}
	self._rankPool = {}
end

function BricksxgameModel:onGetInfo(msg)
	local activityId = msg.activityId

	self._msgPool[activityId] = GameUtil.pbToTable(msg)
end

function BricksxgameModel:onGetPrize(msg)
	local pb = GameUtil.pbToTable(msg)
	local activityId = msg.activityId
	local info = self._msgPool[activityId]

	if info then
		info.gainPrizeIds = pb.gainPrizeIds
	end
end

function BricksxgameModel:onGetRank(msg)
	local activityId = msg.activityId

	self._rankPool[activityId] = GameUtil.pbToTable(msg)
end

function BricksxgameModel:getInfo(activityId)
	return self._msgPool[activityId]
end

function BricksxgameModel:getRankInfo(activityId)
	return self._rankPool[activityId]
end

function BricksxgameModel:handlePM_XiaoXiaoLeGameSweepRes(msg)
	local info = self._msgPool[msg.activityId]

	if info then
		info.score = info.score + msg.times * msg.score
		info.dailyTimes = info.dailyTimes + msg.times
	end
end

BricksxgameModel.instance = BricksxgameModel.New()

return BricksxgameModel
