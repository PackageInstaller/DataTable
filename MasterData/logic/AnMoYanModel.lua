-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/anmoyangame/model/AnMoYanModel.lua

module("logic.extensions.anmoyangame.model.AnMoYanModel", package.seeall)

local AnMoYanModel = class("AnMoYanModel", BaseModel)

function AnMoYanModel:onInit()
	self:onReset()
end

function AnMoYanModel:onReset()
	self._infos = {}
end

function AnMoYanModel:getInfo(activityId)
	return self._infos[activityId] or {}
end

function AnMoYanModel:getClientKey(activityId)
	local clientKey = math.random(1, ServerTime.now()) + activityId

	self._infos[activityId].clientKey = clientKey

	return clientKey
end

function AnMoYanModel:getEncryptedKey(activityId, score)
	local info = self._infos[checknumber(activityId)]

	return (GameUtil.getClientEncryptedKey(info.clientKey, info.serverKey, {
		activityId,
		score
	}))
end

function AnMoYanModel:handlePM_DarkMoYanGameInfoRes(msg)
	self._infos[msg.activityId] = GameUtil.pbToTable(msg, self._infos[msg.activityId])
	self._infos[msg.activityId].gainPrizeIds = msg.gainPrizeIds or {}
end

function AnMoYanModel:handlePM_DarkMoYanGameStartGameRes(msg)
	self._infos[msg.activityId].serverKey = msg.serverKey
end

function AnMoYanModel:handlePM_DarkMoYanGameEndGameRes(msg)
	self._infos[msg.activityId] = GameUtil.pbToTable(msg, self._infos[msg.activityId])
end

function AnMoYanModel:handlePM_DarkMoYanGameSweepRes(msg)
	self._infos[msg.activityId] = GameUtil.pbToTable(msg, self._infos[msg.activityId])
end

function AnMoYanModel:handlePM_DarkMoYanGameGainProgressPrizeRes(msg)
	self._infos[msg.activityId].gainPrizeIds = self._infos[msg.activityId].gainPrizeIds or {}

	table.insert(self._infos[msg.activityId].gainPrizeIds, msg.prizeId)
end

AnMoYanModel.instance = AnMoYanModel.New()

return AnMoYanModel
