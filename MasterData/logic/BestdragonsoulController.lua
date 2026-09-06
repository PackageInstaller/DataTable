-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/bestdragonsoul/controller/BestdragonsoulController.lua

module("logic.extensions.bestdragonsoul.controller.BestdragonsoulController", package.seeall)

local BestdragonsoulController = class("BestdragonsoulController", BaseController)

function BestdragonsoulController:ctor()
	return
end

function BestdragonsoulController:onInit()
	self:onReset()
end

function BestdragonsoulController:onReset()
	return
end

function BestdragonsoulController:sendPM_BestDragonSoulStartGameReq(activityId)
	self._clientKey = math.random(1, 100000)

	BestDragonSoulAgent.instance:sendPM_BestDragonSoulStartGameReq(activityId, self._clientKey)
end

function BestdragonsoulController:handlePM_BestDragonSoulStartGameRes(serverKey)
	BestdragonsoulModel.instance:saveKey(self._clientKey, serverKey)
end

function BestdragonsoulController:sendPM_BestDragonSoulEndGameReq(activityId)
	local score = BestdragonsoulModel.instance:getStageTotalScore()
	local needScore = BestdragonsoulConfig.instance:getGamePassScore()
	local ispass = needScore <= score
	local encryptedKey = BestdragonsoulModel.instance:getEncryptedKey()
	local prizes = BestdragonsoulModel.instance:getGameDataMo():getPropsToPrizes()

	BestDragonSoulAgent.instance:sendPM_BestDragonSoulEndGameReq(activityId, ispass, encryptedKey, prizes)
end

function BestdragonsoulController:isCanGet(activityId, typeId, prizeId)
	local info = BestdragonsoulModel.instance:getInfo(activityId)

	if not info then
		return false
	end

	local isGain = self:isGainPrize(activityId, typeId, prizeId)

	if isGain then
		return false
	end

	local cfg = BestdragonsoulConfig.instance:getProgressPrizeCfg(activityId, typeId, prizeId)

	for i, v in ipairs(info.progress) do
		if v.typeId == typeId and v.progress >= cfg.progress then
			return true
		end
	end

	return false
end

function BestdragonsoulController:isGainPrize(activityId, typeId, prizeId)
	local info = BestdragonsoulModel.instance:getInfo(activityId)

	if not info then
		return false
	end

	for i, v in ipairs(info.progress) do
		if v.typeId == typeId then
			for _, gainId in ipairs(v.gainedPrizeId) do
				if gainId == prizeId then
					return true
				end
			end
		end
	end

	return false
end

BestdragonsoulController.instance = BestdragonsoulController.New()

return BestdragonsoulController
