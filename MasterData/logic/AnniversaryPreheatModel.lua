-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/anniversarypreheat/model/AnniversaryPreheatModel.lua

module("logic.extensions.anniversarypreheat.model.AnniversaryPreheatModel", package.seeall)

local AnniversaryPreheatModel = class("AnniversaryPreheatModel", BaseModel)

function AnniversaryPreheatModel:onInit()
	self:onReset()
end

function AnniversaryPreheatModel:onReset()
	self._actId = 0
	self._actCfg = nil
	self._stareState = 0
	self._timesDanmu = 0
	self._curProgress = 0
	self._curPrizeState = {}
	self._closeDanmu = false
	self._danMuInfos = nil
end

function AnniversaryPreheatModel:setActId(actId)
	self._actId = actId
	self._actCfg = AnniversaryPreheatConfig.instance:getActCfg(self._actId)
end

function AnniversaryPreheatModel:getActId()
	return self._actId
end

function AnniversaryPreheatModel:getActIdByCfg()
	local actCfg = ActivityDefineController.instance:getActivityCfgByType(GameEnum.ActivityType.Anniversary_Preheat)

	if actCfg then
		if not actCfg.activityId then
			return 0
		end
	end
end

function AnniversaryPreheatModel:onGetInfo(msg)
	self:setActId(checkint(msg.activityId))

	self._stareState = checkint(msg.shareState)
	self._timesDanmu = checkint(msg.danmuTimes)
	self._curProgress = checkint(msg.progress)
	self._closeDanmu = checkbool(msg.closeDanmu)
end

function AnniversaryPreheatModel:onGetDanMuInfos(msg)
	self._danMuInfos = msg.danmu
end

function AnniversaryPreheatModel:switchDanMuState(isClose)
	self._closeDanmu = isClose
end

function AnniversaryPreheatModel:addSendDanMu(id)
	self._danMuInfos = self._danMuInfos or {}

	local info = {
		senderName = RoleModel.instance:getUserName(),
		danmuId = id
	}

	table.insert(self._danMuInfos, info)
end

function AnniversaryPreheatModel:onSendDanMu(msg)
	self._timesDanmu = self._timesDanmu + 1
	self._curProgress = self._curProgress + self._actCfg.danMuScore
end

function AnniversaryPreheatModel:onSucShare(msg)
	self._stareState = 1
	self._curProgress = self._curProgress + self._actCfg.shareAddScore
end

function AnniversaryPreheatModel:onGainSharePrize(msg)
	self._stareState = 2
end

function AnniversaryPreheatModel:onGainProgressPrize(msg)
	return
end

function AnniversaryPreheatModel:getCurProgress()
	return self._curProgress
end

function AnniversaryPreheatModel:getCurShareState()
	return self._stareState
end

function AnniversaryPreheatModel:getIsAbleSetBullet()
	return self._actCfg and self._actCfg.danMuTimes > self._timesDanmu
end

function AnniversaryPreheatModel:getIsGainPrizeState(id)
	return table.keyof(self._curPrizeState, id)
end

function AnniversaryPreheatModel:onGainProgressPrize(id)
	table.insert(self._curPrizeState, id)
end

function AnniversaryPreheatModel:getDanMuState()
	return self._closeDanmu
end

function AnniversaryPreheatModel:getDanMuInfo()
	return self._danMuInfos
end

AnniversaryPreheatModel.instance = AnniversaryPreheatModel.New()

return AnniversaryPreheatModel
