-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/anniversarycake/view/CakeMoBase.lua

module("logic.extensions.anniversarycake.view.CakeMoBase", package.seeall)

local CakeMoBase = class("CakeMoBase")

function CakeMoBase:ctor()
	self._isCanSendReq = true
	self._type = 0
end

function CakeMoBase:reset()
	self._isCanSendReq = true
end

function CakeMoBase:isCanSendReq()
	return self._isCanSendReq
end

function CakeMoBase:sendGetInfoReq(activityId)
	self._isCanSendReq = false
end

function CakeMoBase:getWorldPrizePlanId()
	return
end

function CakeMoBase:getPlayerPrizePlanId()
	return
end

function CakeMoBase:getWorldProgress()
	return
end

function CakeMoBase:getPersonalScore()
	return
end

function CakeMoBase:getCurLeftGameCount()
	return
end

function CakeMoBase:getSpecialDesc()
	return
end

function CakeMoBase:getSpecialReward()
	return
end

function CakeMoBase:getBgPath()
	return
end

function CakeMoBase:openGame()
	return
end

function CakeMoBase:isWorldRewardGeted(prizeId)
	return
end

function CakeMoBase:isWorldRewardCanGet(prizeId, needScore)
	return
end

function CakeMoBase:isPlayerRewardGeted(prizeId)
	return
end

function CakeMoBase:isPlayerRewardCanGet(prizeId, needScore)
	return
end

function CakeMoBase:sendGainPersonalPrizeReq(activityId, prizeId)
	return
end

function CakeMoBase:sendGainWorldPrizeReq(activityId, prizeId)
	return
end

return CakeMoBase
