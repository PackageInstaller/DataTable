local bs_10145 = class("bs_10145", LuaSkillBase)
local base = LuaSkillBase
bs_10145.config = {
  buffId = 1027,
  buffTier = 1,
  effectId = 10251
}

function bs_10145:ctor()
end

function bs_10145:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterHurtTrigger("bs_10144_3", 1, self.OnAfterHurt, self.caster)
  self.caster.recordTable["10145_AttackTime"] = 0
end

function bs_10145:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if sender == self.caster and skill.isCommonAttack and not isMiss and not isTriggerSet then
    self.caster.recordTable["10145_AttackTime"] = self.caster.recordTable["10145_AttackTime"] + 1
    if self.caster.recordTable["10145_AttackTime"] >= self.arglist[1] then
      local targetlist = LuaSkillCtrl:CallTargetSelect(self, 30, 10)
      if targetlist.Count <= 0 then
        return
      end
      self:PlayChipEffect()
      LuaSkillCtrl:CallBuff(self, targetlist[0].targetRole, self.config.buffId, self.config.buffTier, self.arglist[3])
      self.caster.recordTable["10145_AttackTime"] = 0
    end
  end
end

function bs_10145:OnCasterDie()
  base.OnCasterDie(self)
  if self.damTimer then
    self.damTimer:Stop()
    self.damTimer = nil
  end
end

return bs_10145
