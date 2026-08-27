local FireBase = require("GamePlay.SkillScripts.FunctionSkill.24Carnival.FireBase")
local bs_17318 = class("bs_17318", FireBase)
local base = FireBase
bs_17318.config = {}

function bs_17318:ctor()
end

bs_17318.config = setmetatable(bs_17318.config, {
  __index = base.config
})

function bs_17318:InitSkill(isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_17318_1", 1, self.OnAfterBattleStart)
  self:AddAfterPlaySkillTrigger("bs_17318_2", 1, self.OnAfterPlaySkill, nil, nil, nil, nil, nil, nil, nil, eSkillTag.ultSkill)
end

function bs_17318:OnAfterPlaySkill(skill, role)
  if skill.skillTag ~= eSkillTag.ultSkill then
    return
  end
  if skill.skillType ~= eBattleSkillLogicType.Original then
    return
  end
  local enemyList = LuaSkillCtrl:GetAllEnmyRoles()
  for i = 0, enemyList.Count - 1 do
    self:CallFireBuff(enemyList[i], self.arglist[1])
  end
end

function bs_17318:OnAfterAddBuff(buff, target)
end

function bs_17318:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_17318
