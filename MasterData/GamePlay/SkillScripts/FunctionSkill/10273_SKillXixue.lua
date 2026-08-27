local bs_10273 = class("bs_10273", LuaSkillBase)
local base = LuaSkillBase
bs_10273.config = {
  buffId = 1187,
  buffTier = 1,
  effectId = 10892
}

function bs_10273:ctor()
end

function bs_10273:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddSelfTrigger(eSkillTriggerType.AfterPlaySkill, "bs_10273_12", 1, self.OnAfterPlaySkill)
end

function bs_10273:OnAfterPlaySkill(skill, role)
  if self.caster.recordTable["104502_active"] == false then
    return
  end
  if role == self.caster and not skill.isCommonAttack then
    local targetlist = LuaSkillCtrl:CallTargetSelect(self, 59, 10)
    if targetlist.Count < 1 then
      return
    end
    local targetRole = targetlist[0].targetRole
    if targetRole == self.caster and targetlist.Count > 1 then
      targetRole = targetlist[1].targetRole
    end
    LuaSkillCtrl:CallBuff(self, targetRole, self.config.buffId, self.config.buffTier, self.arglist[2], true)
    LuaSkillCtrl:CallChipSuitInvoke(self.caster, targetRole)
    LuaSkillCtrl:CallEffect(targetRole, self.config.effectId, self, self.SkillEventFunc)
    self:PlayChipEffect()
  end
end

function bs_10273:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_10273
