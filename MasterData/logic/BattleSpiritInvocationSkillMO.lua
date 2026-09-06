-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/battle/model/BattleSpiritInvocationSkillMO.lua

module("logic.extensions.battle.model.BattleSpiritInvocationSkillMO", package.seeall)

local BattleSpiritInvocationSkillMO = class("BattleSpiritInvocationSkillMO")

function BattleSpiritInvocationSkillMO:ctor()
	self.spiritInvocationSkillId = 0
	self.minTriggerProgress = 0
	self.curProgress = 0
	self.spiritInvocationSummonPetId = 0
end

return BattleSpiritInvocationSkillMO
