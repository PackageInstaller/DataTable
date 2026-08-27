local bs_104901 = class("bs_104901", LuaSkillBase)
local base = LuaSkillBase
bs_104901.config = {
  effectId_passive = 104917,
  effectId_shield = 104918,
  buffId = 104901,
  buffId_stun = 3006,
  buffId_live = 3009,
  nanaka_buffId = 102603,
  healConfigId = 4,
  hurtConfigId = 2,
  shieldFormula = 3022
}

function bs_104901:ctor()
end

function bs_104901:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddSetDeadHurtTrigger("bs_104901_1", 900, self.OnSetDeadHurt, nil, self.caster)
  self:AddAfterHurtTrigger("bs_104901_2", 1, self.OnAfterHurt, nil, self.caster)
  self:AddSelfTrigger(eSkillTriggerType.OnBreakShield, "bs_104901_22", 1, self.OnBreakShield)
  self.hpNum = math.max(1, self.caster.maxHp * self.arglist[1] // 1000)
  self.recordNum = 0
end

function bs_104901:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if target == self.caster and 0 < hurt then
    self.recordNum = self.recordNum + hurt
  end
  while self.recordNum >= self.hpNum do
    self.recordNum = self.recordNum - self.hpNum
    LuaSkillCtrl:CallResetCDNumForRole(self.caster, self.arglist[2])
    LuaSkillCtrl:CallEffect(self.caster, self.config.effectId_passive, self)
  end
end

function bs_104901:OnSetDeadHurt(context)
  local NoDeath = LuaSkillCtrl:RoleContainsBuffFeature(context.target, eBuffFeatureType.NoDeath)
  if context.target == self.caster and context.target:GetBuffTier(self.config.buffId) > 0 and 0 >= context.target:GetBuffTier(self.config.nanaka_buffId) and NoDeath == false then
    LuaSkillCtrl:CallBuff(self, context.target, self.config.buffId_live, 1, 1, true)
    LuaSkillCtrl:StartTimer(nil, 1, function()
      if context.target == nil or context.target.hp <= 0 then
        return
      end
      local tier = context.target:GetBuffTier(self.config.buffId)
      local num = self.arglist[3] * tier
      local shieldValue = LuaSkillCtrl:CallFormulaNumberWithSkill(self.config.shieldFormula, self.caster, self.caster, self, num)
      if 0 < shieldValue then
        LuaSkillCtrl:AddRoleShield(self.caster, eShieldType.Normal, shieldValue)
      end
      self.shieldEffect = LuaSkillCtrl:CallEffect(self.caster, self.config.effectId_shield, self)
      LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId, 0)
    end)
  end
end

function bs_104901:OnBreakShield(shieldType, sender, target)
  if self.shieldEffect ~= nil then
    self.shieldEffect:Die()
    self.shieldEffect = nil
  end
end

function bs_104901:OnCasterDie()
  base.OnCasterDie(self)
  if self.shieldEffect ~= nil then
    self.shieldEffect:Die()
    self.shieldEffect = nil
  end
end

function bs_104901:LuaDispose()
  base.LuaDispose(self)
  self.shieldEffect = nil
end

return bs_104901
