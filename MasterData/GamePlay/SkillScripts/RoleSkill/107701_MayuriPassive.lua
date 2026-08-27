local bs_107701 = class("bs_107701", LuaSkillBase)
local base = LuaSkillBase
bs_107701.config = {
  buffid_fade = 107701,
  effectId_buff1 = 107704,
  effectId_buff2 = 107703,
  effectId_buff3 = 107709,
  HurtConfigID = 2,
  heroId_1 = 1076,
  heroId_2 = 1078,
  effectId_trail = 107713,
  effectId_cast = 107715,
  buffid = 107704
}

function bs_107701:ctor()
end

function bs_107701:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_107701_1", 1, self.OnAfterBattleStart)
  self:AddLuaTrigger(eSkillLuaTrigger.OnRecoverHeal, self.OnRecoverHeal)
  self:AddLuaTrigger(eSkillLuaTrigger.OnMayuriUlt, self.OnMayuriUlt)
  self:AddAfterPlaySkillTriggerForTable("bs_107701_2", 1, self.OnAfterPlaySkill, {
    senderBelongNum = self.caster.belongNum
  })
  self:AddOnRoleDieTrigger("bs_107701_3", 5, self.OnRoleDie, nil, nil, nil, nil)
  self.caster.recordTable.rate_ex = 0
  self.pow_ex = 0
  self.atk_num = 0
  self.target_ex = nil
  self.RecoverHeal_times = 0
end

function bs_107701:OnAfterBattleStart()
  local caster1 = LuaSkillCtrl:GetOriginRole(self.config.heroId_1)
  local caster2 = LuaSkillCtrl:GetOriginRole(self.config.heroId_2)
  if caster1 ~= nil and not caster1.roleOnBench == true then
    self.caster.recordTable.rate_ex = self.arglist[3]
  end
  if caster2 ~= nil and not caster2.roleOnBench == true then
    self.pow_ex = self.arglist[4]
  end
  self:AddUpaEffect()
end

function bs_107701:OnRecoverHeal(role)
  if self.target_ex == nil then
    self.RecoverHeal_times = self.RecoverHeal_times + 1
    if self.RecoverHeal_times >= self.caster.recordTable.RecoverHeal_times then
      self.RecoverHeal_times = 0
      self:AddUpaEffect()
    end
    return
  end
  if role == self.target_ex then
    LuaSkillCtrl:CallRecoverHeal(self.caster, self, 0, 0, 0)
  end
  if role == self.caster and 0 < self.caster:GetBuffTier(self.config.buffid_fade) then
    LuaSkillCtrl:DispelBuff(self.caster, self.config.buffid_fade, 1, true)
    self:UpdataAttr()
  end
end

function bs_107701:OnLoopFade()
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffid_fade, 1, nil, true)
  self:UpdataAttr()
end

function bs_107701:UpdataAttr()
  if self.target_ex == nil then
    return
  end
  self.target_ex:AddRoleProperty(eHeroAttr.pow, -self.pow_pool, eHeroAttrType.Extra)
  local num = self.caster:GetBuffTier(self.config.buffid_fade)
  self.pow_pool = self.pow_max_pool * (10 - num) // 10
  self.target_ex:AddRoleProperty(eHeroAttr.pow, self.pow_pool, eHeroAttrType.Extra)
end

function bs_107701:AddUpaEffect()
  if self.target_ex ~= nil then
    return
  end
  local target_pow
  local targets_pow = LuaSkillCtrl:CallTargetSelect(self, 59, 10)
  if targets_pow.Count > 0 then
    for i = 0, targets_pow.Count - 1 do
      if targets_pow[i].targetRole ~= self.caster and not targets_pow[i].targetRole.recordTable.Kurisu_Fenshen then
        target_pow = targets_pow[i].targetRole
        self.target_ex = target_pow
        break
      end
      if target_pow ~= nil then
        break
      end
    end
  end
  if self.target_ex == nil then
    return
  end
  local originAttrList = self.caster.originAttrList
  self.pow_origin = originAttrList[eHeroAttr.pow]
  self.pow_max_pool = self.pow_origin * (self.pow_ex + self.arglist[1]) // 1000
  self.target_ex:AddRoleProperty(eHeroAttr.pow, self.pow_max_pool, eHeroAttrType.Extra)
  self.pow_pool = self.pow_max_pool
  self.LoopFade = LuaSkillCtrl:StartTimer(nil, self.arglist[2], BindCallback(self, self.OnLoopFade), nil, -1, 0)
  LuaSkillCtrl:CallEffect(self.caster, self.config.effectId_buff1, self, nil, nil, nil)
  self.effect2 = LuaSkillCtrl:CallEffect(self.target_ex, self.config.effectId_buff2, self, nil, nil, nil)
  if 0 < self.caster:GetBuffTier(self.config.buffid) then
    LuaSkillCtrl:DispelBuff(self.caster, self.config.buffid, 1)
  end
end

function bs_107701:OnAfterPlaySkill(skill, role)
  if role == self.target_ex and skill.isCommonAttack then
    self.atk_num = self.atk_num + 1
    if self.atk_num >= 3 then
      local target = role.recordTable.lastAttackRole
      if target == nil then
        return
      end
      LuaSkillCtrl:CallEffect(self.caster, self.config.effectId_cast, self)
      LuaSkillCtrl:CallEffectWithArgOverride(target, self.config.effectId_trail, self, self.caster, nil, nil, self.SkillEventFunc)
      self.atk_num = 0
    end
  end
end

function bs_107701:SkillEventFunc(effect, eventId, target)
  if effect.dataId == self.config.effectId_trail and eventId == eBattleEffectEvent.Trigger then
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target)
    LuaSkillCtrl:HurtResultWithConfig(self, skillResult, self.config.HurtConfigID, {
      self.arglist[5]
    }, true)
    skillResult:EndResult()
  end
end

function bs_107701:OnMayuriUlt(attr, time)
  if self.target_ex == nil then
    return
  end
  local pow_up = self.pow_origin * attr // 1000
  self.target_ex:AddRoleProperty(eHeroAttr.pow, pow_up, eHeroAttrType.Extra)
  self.effect3 = LuaSkillCtrl:CallEffect(self.target_ex, self.config.effectId_buff3, self, nil, nil, nil)
  self.ClearAttr_timer = LuaSkillCtrl:StartTimer(nil, time, BindCallback(self, self.ClearAttr, pow_up), nil)
  if self.effect2 ~= nil then
    self.effect2:Die()
    self.effect2 = nil
  end
end

function bs_107701:ClearAttr(pow)
  if self.target_ex == nil then
    return
  end
  self.target_ex:AddRoleProperty(eHeroAttr.pow, -pow, eHeroAttrType.Extra)
  self.target_ex:AddRoleProperty(eHeroAttr.pow, -self.pow_pool, eHeroAttrType.Extra)
  if self.LoopFade ~= nil then
    self.LoopFade:Stop()
    self.LoopFade = nil
  end
  if self.effect3 ~= nil then
    self.effect3:Die()
    self.effect3 = nil
  end
  LuaSkillCtrl:DispelBuff(self.caster, self.config.buffid_fade)
  self.target_ex = nil
end

function bs_107701:OnRoleDie(killer, role)
  if role == self.target_ex then
    if self.effect3 ~= nil then
      self.effect3:Die()
      self.effect3 = nil
    end
    if self.effect2 ~= nil then
      self.effect2:Die()
      self.effect2 = nil
    end
    if self.LoopFade ~= nil then
      self.LoopFade:Stop()
      self.LoopFade = nil
    end
    LuaSkillCtrl:DispelBuff(self.caster, self.config.buffid_fade)
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffid, 1, nil, true)
    self.target_ex = nil
  end
end

function bs_107701:OnCasterDie()
  base.OnCasterDie(self)
  if self.LoopFade ~= nil then
    self.LoopFade:Stop()
    self.LoopFade = nil
  end
  if self.effect2 ~= nil then
    self.effect2:Die()
    self.effect2 = nil
  end
  if self.effect3 ~= nil then
    self.effect3:Die()
    self.effect3 = nil
  end
end

function bs_107701:LuaDispose()
  base.LuaDispose(self)
  self.effect2 = nil
  self.effect3 = nil
  self.target_ex = nil
end

return bs_107701
