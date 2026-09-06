-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/battle/model/round/BattleRound.lua

module("logic.extensions.battle.model.round.BattleRound", package.seeall)

local BattleRound = class("BattleRound", BattleRoundBase)

function BattleRound:ctor()
	self.roundType = BattleRoundBase.Round
end

return BattleRound
