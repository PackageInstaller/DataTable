-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/battle/model/round/BattleRoundBegin.lua

module("logic.extensions.battle.model.round.BattleRoundBegin", package.seeall)

local BattleRoundBegin = class("BattleRoundBegin", BattleRoundBase)

function BattleRoundBegin:ctor()
	self.roundType = BattleRoundBase.RoundBegin
end

function BattleRoundBegin:start()
	BattleRoundBegin.super.start(self)

	BattleModel.instance.currRoundNum = self.roundNum

	GlobalDispatcher:dispatch(GlobalNotify.BattleRoundStart, self.roundNum)

	self._time = 0
end

function BattleRoundBegin:finish()
	BattleRoundBegin.super.finish(self)
end

function BattleRoundBegin:isDone()
	if self.roundNum == 1 then
		return self._time >= 1
	end

	return self._time >= 1
end

function BattleRoundBegin:update(deltaTime)
	self._time = self._time + deltaTime
end

return BattleRoundBegin
