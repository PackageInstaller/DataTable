local bs_106801 = class("bs_106801", LuaSkillBase)
local base = LuaSkillBase
bs_106801.config = {
  buffId_atkSpeed = 106801,
  effectId_atkSpeed_1 = 106803,
  effectId_atkSpeed_2 = 106804
}

function bs_106801:ctor()
end

function bs_106801:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddSetHurtTrigger("bs_106801_1", 1, self.OnSetHurt, nil, nil)
  self:AddAfterPlaySkillTrigger("bs_106801_2", 1, self.OnAfterPlaySkill, self.caster, nil, nil, nil, nil)
  self.target = nil
end

function bs_106801:OnSetHurt(context)
  if context.sender == self.caster and context.target.camp == 2 then
    context.hurt = context.hurt * (1000 + self.arglist[1]) // 1000
  end
  if context.target == self.caster and context.sender.camp == 1 then
    context.hurt = context.hurt * (1000 - self.arglist[2]) // 1000
  end
end

function bs_106801:OnAfterPlaySkill(skill, role)
  local target = role.recordTable.lastAttackRole
  if target == nil then
    return
  end
  local attackSpeedBuffTier = self.caster:GetBuffTier(self.config.buffId_atkSpeed)
  if skill.isCommonAttack then
    if self.target == target or attackSpeedBuffTier == 0 then
      LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_atkSpeed, 1, nil, true)
    else
      local num = attackSpeedBuffTier // 2
      if 0 < num then
        LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId_atkSpeed, num)
      end
    end
    self.target = target
  end
  local attackSpeedBuffTier = self.caster:GetBuffTier(self.config.buffId_atkSpeed)
  if 5 <= attackSpeedBuffTier then
    if self.effect1 ~= nil then
      self.effect1:Die()
      self.effect1 = nil
    end
    if self.effect2 == nil then
      self.effect2 = LuaSkillCtrl:CallEffect(self.caster, self.config.effectId_atkSpeed_2, self)
    end
  elseif 1 <= attackSpeedBuffTier then
    if self.effect2 ~= nil then
      self.effect2:Die()
      self.effect2 = nil
    end
    if self.effect1 == nil then
      self.effect1 = LuaSkillCtrl:CallEffect(self.caster, self.config.effectId_atkSpeed_1, self)
    end
  end
end

function bs_106801:OnCasterDie()
  base.OnCasterDie(self)
  if self.effect1 ~= nil then
    self.effect1:Die()
    self.effect1 = nil
  end
  if self.effect2 ~= nil then
    self.effect2:Die()
    self.effect2 = nil
  end
end

function bs_106801:LuaDispose()
  base.LuaDispose(self)
  self.effect1 = nil
  self.effect2 = nil
end

return bs_106801
