-- chunkname: @IQIGame\\Module\\Battle\\Skill\\BattleSkillHit_None.lua

local BattleSkillHitBase = require("IQIGame/Module/Battle/Skill/BattleSkillHitBase")
local BattleSkillHit_None = Clone(BattleSkillHitBase)

function BattleSkillHit_None.New(mainSkill, subSkillQueue, timelineCfg)
	local obj = Clone(BattleSkillHit_None)

	obj:__Init(mainSkill, subSkillQueue, timelineCfg)

	return obj
end

function BattleSkillHit_None:__Init(mainSkill, subSkillQueue, timelineCfg)
	self:_Init(mainSkill, subSkillQueue, timelineCfg)
end

function BattleSkillHit_None:OnHit(hitEventArgs)
	return
end

return BattleSkillHit_None
