local bs_91016 = class("bs_91016", LuaSkillBase)
local base = LuaSkillBase
bs_91016.config = {buffId = 2026, buffTier = 1}

function bs_91016:ctor()
end

function bs_91016:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddSelfTrigger(eSkillTriggerType.AfterPlaySkill, "bs_91016_1", 1, self.OnAfterPlaySkill)
end

function bs_91016:OnAfterPlaySkill(skill, role)
  if skill.maker == self.caster and not skill.isCommonAttack then
    local targetlist = LuaSkillCtrl:CallTargetSelect(self, 14, 10)
    local Num = self.arglist[2] // self.arglist[1]
    if targetlist.Count ~= 0 then
      local layer = targetlist[0].targetRole:GetBuffTier(self.config.buffId)
      if Num > layer then
        LuaSkillCtrl:CallBuff(self, targetlist[0].targetRole, self.config.buffId, self.config.buffTier, nil, true)
      else
        LuaSkillCtrl:DispelBuff(targetlist[0].targetRole, self.config.buffId, 0)
        LuaSkillCtrl:CallBuff(self, targetlist[0].targetRole, self.config.buffId, Num, nil, true)
      end
      self:PlayChipEffect()
    end
  end
end

function bs_91016:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_91016
