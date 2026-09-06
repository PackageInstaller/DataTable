-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/battle/model/BattlePsychicSkillMO.lua

module("logic.extensions.battle.model.BattlePsychicSkillMO", package.seeall)

local BattlePsychicSkillMO = class("BattlePsychicSkillMO")

function BattlePsychicSkillMO:ctor()
	self.psychicSkillId = 0
	self.minTriggerProgress = 0
	self.curProgress = 0
	self.maxTriggerCount = 0
	self.hasTriggerCount = 0
end

return BattlePsychicSkillMO
