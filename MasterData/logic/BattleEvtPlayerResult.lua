-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/battle/model/events/BattleEvtPlayerResult.lua

module("logic.extensions.battle.model.events.BattleEvtPlayerResult", package.seeall)

local BattleEvtPlayerResult = class("BattleEvtPlayerResult", BattleEvtBase)

function BattleEvtPlayerResult:ctor()
	self.targetPlayerResults = nil
end

function BattleEvtPlayerResult:handleEvt()
	self.isToggled = true
	self.isFinished = true

	if not self.targetPlayerResults then
		return
	end

	UnitCompBattleFlowCommon.handlePlayerResults(self.targetPlayerResults)
end

function BattleEvtPlayerResult:clear()
	self.targetPlayerResults = nil
end

function BattleEvtPlayerResult:getBuffEffectPaths()
	return self:_getBuffEffectPathsFromPlayerResults(self.targetPlayerResults)
end

return BattleEvtPlayerResult
