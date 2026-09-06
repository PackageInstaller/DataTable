-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/caiqingdraw/model/CaiqingdrawModel.lua

module("logic.extensions.caiqingdraw.model.CaiqingdrawModel", package.seeall)

local CaiqingdrawModel = class("CaiqingdrawModel", BaseModel)

function CaiqingdrawModel:onInit()
	self:onReset()
end

function CaiqingdrawModel:onReset()
	self._weekCount = 0
	self._prizeIds = {}
end

function CaiqingdrawModel:_setInfoData(msg)
	self._weekCount = msg.weekCount
	self._prizeIds = GameUtil.pbToTable(msg.prizeIds) or {}
end

function CaiqingdrawModel:_getRewardProgress()
	return self._weekCount
end

function CaiqingdrawModel:_isPlayerRewardCanGet(weekCount, maxHit)
	return maxHit <= weekCount
end

function CaiqingdrawModel:_isPlayerRewardGeted(id)
	return TableUtil.isHad(self._prizeIds, id)
end

CaiqingdrawModel.instance = CaiqingdrawModel.New()

return CaiqingdrawModel
