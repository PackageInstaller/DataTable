-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/bountypkcompete/model/BountyPkCompeteMatchModel.lua

module("logic.extensions.bountypkcompete.model.BountyPkCompeteMatchModel", package.seeall)

local BountyPkCompeteMatchModel = class("BountyPkCompeteMatchModel")

BountyPkCompeteMatchModel.MatchSuccess = 1
BountyPkCompeteMatchModel.CancelMatch = 2
BountyPkCompeteMatchModel.ServerOverTime = 3
BountyPkCompeteMatchModel.MatchFail = 4
BountyPkCompeteMatchModel.ClientOverTime = 5

function BountyPkCompeteMatchModel:ctor()
	return
end

function BountyPkCompeteMatchModel:reset()
	self._isMatching = false
	self._reqStartMatchFunc = nil
	self._reqCancelMatchFunc = nil
	self._disposeMatchFunc = nil
	self._hideCancelBtn = false
	self._thisArg = nil
	self._maxMatchTime = 150
	self._result = nil
end

function BountyPkCompeteMatchModel:setMatchingState(value)
	self._isMatching = value
end

function BountyPkCompeteMatchModel:reqStartMatch()
	if not self._isMatching and (not self._thisArg or self._thisArg.destroyed == false) then
		GameUtil.callBack(self._reqStartMatchFunc, self._thisArg)
	end
end

function BountyPkCompeteMatchModel:reqCancelMatch(isForce)
	if self._isMatching or isForce then
		self._isMatching = false

		if not self._thisArg or self._thisArg.destroyed ~= true then
			GameUtil.callBack(self._reqCancelMathFunc, self._thisArg)
		end
	end
end

function BountyPkCompeteMatchModel:disposeMatch(reason)
	self._result = reason

	if not self._thisArg or self._thisArg.destroyed ~= true then
		GameUtil.callBack(self._disposeMatchFunc, self._thisArg, reason)
	end
end

function BountyPkCompeteMatchModel:getMaxMatchTime()
	return self._maxMatchTime
end

function BountyPkCompeteMatchModel:isHideCancelBtn()
	return self._hideCancelBtn
end

return BountyPkCompeteMatchModel
