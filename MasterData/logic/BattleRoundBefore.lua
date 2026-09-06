-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/battle/model/round/BattleRoundBefore.lua

module("logic.extensions.battle.model.round.BattleRoundBefore", package.seeall)

local BattleRoundBefore = class("BattleRoundBefore", BattleRoundBase)

function BattleRoundBefore:ctor()
	self.roundType = BattleRoundBase.RoundBefore
end

function BattleRoundBefore:start()
	BattleRoundBefore.super.start(self)
end

function BattleRoundBefore:finish()
	BattleRoundBefore.super.finish(self)
end

return BattleRoundBefore
