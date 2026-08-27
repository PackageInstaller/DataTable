local bs_10246 = class("bs_10246", LuaSkillBase)
local base = LuaSkillBase
bs_10246.config = {buffId = 1025, buffTier = 1}

function bs_10246:ctor()
end

function bs_10246:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddSelfTrigger(eSkillTriggerType.AfterPlaySkill, "bs_10246_12", 1, self.OnAfterPlaySkill)
end

function bs_10246:OnAfterPlaySkill(skill, role)
  if skill.maker == self.caster and not skill.isCommonAttack then
    local targetlist = LuaSkillCtrl:CallTargetSelect(self, 21, 10)
    if targetlist.Count < 1 then
      return
    end
    LuaSkillCtrl:CallBuff(self, targetlist[0].targetRole, self.config.buffId, self.config.buffTier, self.arglist[1])
    self:PlayChipEffect()
  end
end

function bs_10246:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_10246
