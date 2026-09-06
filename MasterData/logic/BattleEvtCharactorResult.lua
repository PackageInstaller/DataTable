-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/battle/model/events/BattleEvtCharactorResult.lua

module("logic.extensions.battle.model.events.BattleEvtCharactorResult", package.seeall)

local BattleEvtCharactorResult = class("BattleEvtCharactorResult", BattleEvtBase)

function BattleEvtCharactorResult:ctor()
	self.targetCharacterResults = nil
end

function BattleEvtCharactorResult:handleEvt()
	self.isToggled = true
	self.isFinished = true

	if not self.targetCharacterResults then
		return
	end

	UnitCompBattleFlowCommon.handleCharactorResults(self.targetCharacterResults)
end

function BattleEvtCharactorResult:clear()
	self.targetCharacterResults = nil
end

function BattleEvtCharactorResult:onPass()
	local battleScene = SceneMgr.instance:getScene(SceneType.Battle)
	local cnt = #self.targetCharacterResults

	for i = 1, cnt do
		local result = self.targetCharacterResults[i]

		if result.targetNum then
			local unitTarget = battleScene.unitFactory:getUnit(result.target.targetTeamId, result.target.targetCharacterId)

			if unitTarget then
				unitTarget.attrs:setCurVigour(result.targetNum.afterRoundVigour)
				unitTarget.attrs:setCurHp(result.targetNum.afterRoundHp)
				unitTarget.attrs:setCurTempHp(result.targetNum.afterRoundHp)
			end
		end
	end
end

function BattleEvtCharactorResult:getBuffEffectPaths()
	return self:_getBuffEffectPathsFromCharResults(self.targetCharacterResults)
end

return BattleEvtCharactorResult
