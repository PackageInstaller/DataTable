-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/battle/model/events/BattleEvtBase.lua

module("logic.extensions.battle.model.events.BattleEvtBase", package.seeall)

local BattleEvtBase = class("BattleEvtBase")

function BattleEvtBase:ctor()
	self.isToggled = nil
end

function BattleEvtBase:handleEvt()
	self.isToggled = true
end

function BattleEvtBase:isDone()
	return self.isFinished
end

function BattleEvtBase:checkCharacterAttrs()
	return
end

function BattleEvtBase:finish()
	return
end

function BattleEvtBase:clear()
	return
end

function BattleEvtBase:getCharactorResult()
	return
end

function BattleEvtBase:getTransformModelId(characterId, teamId)
	return
end

function BattleEvtBase:onPass()
	return
end

function BattleEvtBase:pause(pause)
	self.isPause = pause
end

function BattleEvtBase:getBuffEffectPaths()
	return
end

function BattleEvtBase:_getBuffEffectPathsFromCharResults(targetCharacterResults)
	local cnt = #targetCharacterResults
	local buffs

	for i = 1, cnt do
		local result = targetCharacterResults[i]

		if result.targetNum then
			if result.targetNum.beforeDisplayBuffs then
				for j = 1, #result.targetNum.beforeDisplayBuffs do
					if result.targetNum.beforeDisplayBuffs[j].displayType == 1 then
						buffs = buffs or {}
						buffs[result.targetNum.beforeDisplayBuffs[j].buffId] = true
					end
				end
			end

			if result.targetNum.afterDisplayBuffs then
				for j = 1, #result.targetNum.afterDisplayBuffs do
					if result.targetNum.afterDisplayBuffs[j].displayType == 1 then
						buffs = buffs or {}
						buffs[result.targetNum.afterDisplayBuffs[j].buffId] = true
					end
				end
			end
		end
	end

	return buffs
end

function BattleEvtBase:_getBuffEffectPathsFromPlayerResults(targetPlayerResults)
	return self:_getBuffEffectPathsFromCharResults(targetPlayerResults)
end

return BattleEvtBase
