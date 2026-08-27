local bs_206801 = class("bs_206801", LuaSkillBase)
local base = LuaSkillBase
bs_206801.config = {
  buffId_crime = 206804,
  buffId_punish = 206805,
  buffId_stun = 206803,
  buffId_bati = 206800,
  effectId_mask = 2068013
}

function bs_206801:ctor()
end

function bs_206801:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_206801_1", 1, self.OnAfterBattleStart)
  self:AddSelfTrigger(eSkillTriggerType.OnBreakShield, "bs_206801_2", 1, self.OnBreakShield)
  self:AddSelfTrigger(eSkillTriggerType.BuffDie, "bs_206801_3", 1, self.OnBuffDie)
  self.Mask = nil
  self.MaskEffect = nil
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_bati, 1)
  self.caster:AddRoleProperty(eHeroAttr.cd_reduce, 1000, eHeroAttrType.Extra)
  self.caster.recordTable.shieldValue = self.caster.maxHp * self.arglist[1] // 1000
end

function bs_206801:OnAfterBattleStart()
  self.caster.recordTable.mask = 1
  self.Mask = LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_crime, 1, nil, true)
  self.MaskEffect = self.Mask.listBattleEffect[1]
  local MaskEffectNum = 0
  LuaSkillCtrl:EffectSetCountActive(self.MaskEffect, MaskEffectNum, true)
  local shieldValue = self.caster.recordTable.shieldValue
  local Shield = LuaSkillCtrl:AddRoleShield(self.caster, eShieldType.Beelneith, shieldValue, 206801)
end

function bs_206801:OnBreakShield(shieldType, sender, target)
  if shieldType == 3 and target == self.caster then
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_stun, 1, self.arglist[2], false)
    if self.caster.recordTable.mask == 1 then
      local maskEffectDie = LuaSkillCtrl:CallEffect(self.caster, self.config.effectId_mask, self)
      local MaskEffectNum = 2
      LuaSkillCtrl:EffectSetCountActive(maskEffectDie, MaskEffectNum, true)
      LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId_crime, 1)
    end
    if self.caster.recordTable.mask == 2 then
      local maskEffectDie = LuaSkillCtrl:CallEffect(self.caster, self.config.effectId_mask, self)
      local MaskEffectNum = 3
      LuaSkillCtrl:EffectSetCountActive(maskEffectDie, MaskEffectNum, true)
      LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId_punish, 1)
    end
  end
end

function bs_206801:OnBuffDie(buff, target, removeType)
  if buff.dataId ~= self.config.buffId_stun then
    return
  end
  if self.caster.recordTable.mask == 1 then
    self.Mask = LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_punish, 1, nil, true)
    self.MaskEffect = self.Mask.listBattleEffect[1]
    local MaskEffectNum = 1
    LuaSkillCtrl:EffectSetCountActive(self.MaskEffect, MaskEffectNum, true)
    self.caster.recordTable.mask = 2
    local shieldValue = self.caster.recordTable.shieldValue
    LuaSkillCtrl:AddRoleShield(self.caster, eShieldType.Beelneith, shieldValue, 206801)
    return
  end
  if self.caster.recordTable.mask == 2 then
    self.Mask = LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_crime, 1, nil, true)
    self.MaskEffect = self.Mask.listBattleEffect[1]
    local MaskEffectNum = 0
    LuaSkillCtrl:EffectSetCountActive(self.MaskEffect, MaskEffectNum, true)
    self.caster.recordTable.mask = 1
    local shieldValue = self.caster.recordTable.shieldValue
    LuaSkillCtrl:AddRoleShield(self.caster, eShieldType.Beelneith, shieldValue, 206801)
    return
  end
end

function bs_206801:LuaDispose()
  base.LuaDispose(self)
  self.Mask = nil
  self.MaskEffect = nil
end

return bs_206801
