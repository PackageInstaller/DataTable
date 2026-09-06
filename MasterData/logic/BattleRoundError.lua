-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/battle/model/round/BattleRoundError.lua

module("logic.extensions.battle.model.round.BattleRoundError", package.seeall)

local BattleRoundError = class("BattleRoundError", BattleRoundBase)

function BattleRoundError:ctor()
	self.roundType = BattleRoundBase.RoundError
	self.errorCode = nil
end

function BattleRoundError:start()
	BattleRoundError.super.start(self)

	self._time = 0

	local statusStr = MsgFlowMgr.instance._resultCode["rc_" .. self.errorCode]

	if statusStr then
		local langKey = "content" .. LanguageMgr.instance:getLanguageType()
		local msg = statusStr[langKey]

		FloatWordMgr.instance:show(msg)
	else
		printInfo(LogTag.NETWORK, "no message for result code:", self.errorCode)
	end
end

function BattleRoundError:update(deltaTime)
	self._time = self._time + deltaTime
end

function BattleRoundError:finish()
	BattleRoundError.super.finish(self)
	BattleController.instance:endBattle()
end

function BattleRoundError:isDone()
	return self._time >= 2
end

return BattleRoundError
