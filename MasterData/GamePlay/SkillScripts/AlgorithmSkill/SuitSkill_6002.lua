local bs_6002 = class("bs_6002", LuaSkillBase)
local base = LuaSkillBase
bs_6002.config = {}

function bs_6002:ctor()
end

function bs_6002:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddSelfTrigger(eSkillTriggerType.HealResultStart, "bs_6002_15", 1, self.OnHealResultStart)
end

function bs_6002:OnHealResultStart(skill, context)
  if context.sender == self.caster then
    local offset = self.arglist[1]
    local precent = self.arglist[2]
    if precent >= context.target.hp * 100 // context.target.maxHp then
      offset = self.arglist[3]
    end
    context.correct_offset = context.correct_offset + offset * 10
  end
end

function bs_6002:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_6002
