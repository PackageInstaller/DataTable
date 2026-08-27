local bs_213401 = class("bs_213401", LuaSkillBase)
local base = LuaSkillBase
bs_213401.config = {
  buffId_Boss = 3017,
  buffId_stop = 107803,
  effectId_shield = 213403
}

function bs_213401:ctor()
end

function bs_213401:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_213401", 1, self.OnAfterBattleStart)
  self:AddAfterHurtTrigger("bs_213401_2", 1, self.OnAfterHurt, nil, self.caster)
  self.caster.recordTable.P2 = false
  self.caster.recordTable.P3 = false
  self:AddSetHurtTrigger("bs_213401_3", 1, self.OnSetHurt, nil, self.caster)
  self:AddTrigger(eSkillTriggerType.OnBreakShield, "bs_213401_4", 1, self.OnBreakShield)
end

function bs_213401:OnBreakShield(shieldType, sender, target)
  if target == self.caster and self.effect_shield ~= nil then
    self.effect_shield:Die()
    self.effect_shield = nil
  end
end

function bs_213401:OnAfterBattleStart()
  local breakComponent = self.caster:GetBreakComponent()
  if breakComponent == nil then
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_Boss, 1, nil, true)
  end
  local shieldValue = self.caster.maxHp * self.arglist[1] // 1000
  if 0 < shieldValue then
    LuaSkillCtrl:AddRoleShield(self.caster, eShieldType.Normal, shieldValue)
    self.effect_shield = LuaSkillCtrl:CallEffect(self.caster, self.config.effectId_shield, self, nil)
  end
end

function bs_213401:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  local hprate = self.caster._curHp * 1000 // self.caster.maxHp
  if hprate <= self.arglist[4] and self.caster.recordTable.P3 == false then
    self.caster.recordTable.P2 = true
    self.caster.recordTable.P3 = true
    local shieldValue = self.caster.maxHp * self.arglist[5] // 1000
    if 0 < shieldValue then
      LuaSkillCtrl:AddRoleShield(self.caster, eShieldType.Normal, shieldValue)
      if self.effect_shield == nil then
        self.effect_shield = LuaSkillCtrl:CallEffect(self.caster, self.config.effectId_shield, self, nil)
      end
    end
  elseif hprate <= self.arglist[2] and self.caster.recordTable.P2 == false then
    self.caster.recordTable.P2 = true
    local shieldValue = self.caster.maxHp * self.arglist[3] // 1000
    if 0 < shieldValue then
      LuaSkillCtrl:AddRoleShield(self.caster, eShieldType.Normal, shieldValue)
      if self.effect_shield == nil then
        self.effect_shield = LuaSkillCtrl:CallEffect(self.caster, self.config.effectId_shield, self, nil)
      end
    end
  end
end

function bs_213401:OnSetHurt(context)
  local num = context.target:GetBuffTier(self.config.buffId_stop)
  if 0 < num then
    local shieldNum = LuaSkillCtrl:GetRoleAllShield(context.target)
    if 0 < shieldNum then
      if shieldNum > context.hurt * self.arglist[6] then
        context.hurt = context.hurt * self.arglist[6]
      else
        context.hurt = (context.hurt * self.arglist[6] - shieldNum) // self.arglist[6] + shieldNum
      end
    end
  end
end

function bs_213401:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_213401
