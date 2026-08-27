local bs_10225 = class("bs_10225", LuaSkillBase)
local base = LuaSkillBase
bs_10225.config = {
  buffId = 1081,
  buffId2 = 1134,
  buffTier = 1,
  effectId = 10754,
  effectId2 = 10755
}

function bs_10225:ctor()
end

function bs_10225:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddSelfTrigger(eSkillTriggerType.AfterPlaySkill, "bs_10225_3", 3, self.OnAfterPlaySkill)
  self:AddAfterHurtTrigger("bs_10225_2", 1, self.OnAfterHurt, self.caster)
end

function bs_10225:OnAfterPlaySkill(skill, role)
  if self.caster.recordTable["104502_active"] == false then
    return
  end
  local tier = self.caster:GetBuffTier(self.config.buffId)
  if tier == 0 and skill.maker == self.caster and not skill.isCommonAttack then
    self:PlayChipEffect()
    if skill.maker.attackRange ~= 1 then
      LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, self.config.buffTier, nil, true)
    end
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId2, self.config.buffTier, nil, true)
    local targetlist = LuaSkillCtrl:CallTargetSelect(self, 7, 10)
    if 1 > targetlist.Count then
      return
    end
    self.caster.recordTable.lastAttackRole = targetlist[0].targetRole
    self.effect = LuaSkillCtrl:CallEffect(targetlist[0].targetRole, self.config.effectId, self)
    self.flag = true
  end
end

function bs_10225:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if sender == self.caster and skill.isCommonAttack and target == self.caster.recordTable.lastAttackRole and self.flag and not isTriggerSet then
    LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId, 0)
    self.caster.recordTable.lastAttackRole = nil
    if self.effect ~= nil then
      self.effect:Die()
      self.effect = nil
    end
    LuaSkillCtrl:CallEffect(target, self.config.effectId2, self)
    self.flag = false
  end
end

function bs_10225:OnCasterDie()
  base.OnCasterDie(self)
end

function bs_10225:LuaDispose()
  base.LuaDispose(self)
  self.effect = nil
end

return bs_10225
