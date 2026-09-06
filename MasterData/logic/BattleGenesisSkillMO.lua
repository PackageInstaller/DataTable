-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/battle/model/BattleGenesisSkillMO.lua

module("logic.extensions.battle.model.BattleGenesisSkillMO", package.seeall)

local BattleGenesisSkillMO = class("BattleGenesisSkillMO")

function BattleGenesisSkillMO:ctor()
	self.genesisSkillId = 0
	self.minTriggerProgress = 0
	self.curProgress = 0
	self.maxTriggerCount = 0
	self.hasTriggerCount = 0
end

return BattleGenesisSkillMO
