-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/bestdragonsoul/model/BestdragonsoulModel.lua

module("logic.extensions.bestdragonsoul.view.BestdragonsoulModel", package.seeall)

local BestdragonsoulModel = class("BestdragonsoulModel", BaseModel)

function BestdragonsoulModel:ctor()
	return
end

function BestdragonsoulModel:onInit()
	self:onReset()
end

function BestdragonsoulModel:onReset()
	self._cutFruitDataMo = nil
	self._msgInfos = {}
end

function BestdragonsoulModel:getCurStageIdx(activityId)
	return self:getDailyTime(activityId) + 1
end

function BestdragonsoulModel:saveKey(clientKey, serverKey)
	self._clientKey = clientKey
	self._serverKey = serverKey
end

function BestdragonsoulModel:getGameDataMo()
	self._cutFruitDataMo = self._cutFruitDataMo or BestDragonsoulDataMo.New()

	return self._cutFruitDataMo
end

function BestdragonsoulModel:clearGameDataMo()
	self._cutFruitDataMo = nil
end

function BestdragonsoulModel:getStageTotalScore()
	return self:getGameDataMo():getStageTotalScore()
end

function BestdragonsoulModel:getEncryptedKey()
	local score = self:getStageTotalScore()
	local needScore = BestdragonsoulConfig.instance:getGamePassScore()
	local ispass = needScore <= score
	local value = ispass and 1 or 0

	return GameUtil.getClientEncryptedKey(self._clientKey, self._serverKey, {
		value
	})
end

function BestdragonsoulModel:updateProgress(msg)
	if msg.progress then
		-- block empty
	end
end

function BestdragonsoulModel:setInfo(msg)
	self._msgInfos[msg.activityId] = msg
end

function BestdragonsoulModel:getInfo(activityId)
	return self._msgInfos[activityId]
end

function BestdragonsoulModel:getDailyTime(activityId)
	local info = self:getInfo(activityId)

	if not info then
		return 0
	end

	return info.dailyTimes
end

function BestdragonsoulModel:updateLikeItem(msg)
	local info = self:getInfo(msg.activityId)

	if info then
		for i, v in ipairs(info.likeItems) do
			if v.id == msg.id then
				info.likeTimes = info.likeTimes + 1
				v.likeNum = v.likeNum + 1

				break
			end
		end
	end
end

function BestdragonsoulModel:gainPrizeRes(msg)
	local info = self:getInfo(msg.activityId)

	if info then
		for i, v in ipairs(info.progress) do
			if v.typeId == msg.typeId then
				v.gainedPrizeId:append(msg.prizeId)

				break
			end
		end
	end
end

function BestdragonsoulModel:getTotalLikeTime(activityId)
	local info = self:getInfo(activityId)

	if not info then
		return 0
	end

	local totalTime = 0

	for i, v in ipairs(info.progress) do
		totalTime = totalTime + BestdragonsoulConfig.instance:getTotalLikeTime(activityId, v.typeId, v.progress)
	end

	return totalTime
end

BestdragonsoulModel.instance = BestdragonsoulModel.New()

return BestdragonsoulModel
