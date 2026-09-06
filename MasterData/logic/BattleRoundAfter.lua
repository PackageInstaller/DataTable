-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/battle/model/round/BattleRoundAfter.lua

module("logic.extensions.battle.model.round.BattleRoundAfter", package.seeall)

local BattleRoundAfter = class("BattleRoundAfter", BattleRoundBase)

function BattleRoundAfter:ctor()
	self.roundType = BattleRoundBase.RoundAfter
end

function BattleRoundAfter:start()
	BattleRoundAfter.super.start(self)
end

function BattleRoundAfter:finish()
	BattleRoundAfter.super.finish(self)
end

return BattleRoundAfter
