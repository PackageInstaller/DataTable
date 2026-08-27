local bs_213403 = class("bs_213403", LuaSkillBase)
local base = LuaSkillBase
bs_213403.config = {
  actionId = 1002,
  action_speed = 1,
  actionId_start_time = 12,
  skilltime = 25,
  effectId_line = 213405,
  effectId_hit = 213408,
  buffFeature_ignoreDie = 6,
  buffFeature_Invinciable = 2,
  Exiled = 16,
  buffId = 213401,
  buffId_damage = 213402,
  buffId_lockCd = 170,
  monsterId = 82
}

function bs_213403:ctor()
end

function bs_213403:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddOnRoleDieTrigger("bs_213403_1", 1, self.OnRoleDie, nil, nil, nil, nil)
  self:AddTrigger(eSkillTriggerType.AfterHeal, "bs_213403_2", 1, self.OnAfterHeal)
  self.target = nil
  self.Summoner = nil
end

function bs_213403:PlaySkill(data)
  local attackTrigger = BindCallback(self, self.OnAttackTrigger)
  local time = self.config.skilltime
  self:CallCasterWait(time)
  LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, self.config.actionId, self.config.action_speed, self.config.actionId_start_time, attackTrigger)
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_lockCd, 1, time, true)
  local callnextskill = BindCallback(self, self.EndSkillAndCallNext)
  LuaSkillCtrl:StartTimer(self, time, callnextskill)
end

function bs_213403:OnAttackTrigger(target)
  local target_pow, target_skill_intensity, target
  local targets_pow = LuaSkillCtrl:CallTargetSelect(self, 84, 10)
  if targets_pow.Count > 0 then
    for i = 0, targets_pow.Count - 1 do
      target_pow = targets_pow[i].targetRole
      if target_pow ~= nil and target_pow.roleType ~= eBattleRoleType.realSummoner then
        break
      end
    end
  end
  if target_pow == nil then
    target_pow = targets_pow[0].targetRole
  end
  local targets_skill_intensity = LuaSkillCtrl:CallTargetSelect(self, 54, 10)
  if targets_skill_intensity.Count > 0 then
    for i = 0, targets_skill_intensity.Count - 1 do
      target_skill_intensity = targets_skill_intensity[i].targetRole
      if target_skill_intensity ~= nil and target_skill_intensity.roleType ~= eBattleRoleType.realSummoner then
        break
      end
    end
    if target_skill_intensity == nil then
      target_skill_intensity = targets_skill_intensity[0].targetRole
    end
  end
  if target_pow.pow >= target_skill_intensity.skill_intensity then
    target = target_pow
  else
    target = target_skill_intensity
  end
  self.target = target
  self:Summon(target)
end

function bs_213403:Summon(target)
  local Grid = LuaSkillCtrl:CallFindEmptyGridNearest(target)
  if Grid == nil then
    Grid = LuaSkillCtrl:FindRoleRightEmptyGrid(target, 10)
  end
  local summonerEntity
  if Grid ~= nil then
    local summoner = LuaSkillCtrl:CreateSummoner(self, self.config.monsterId, Grid.x, Grid.y)
    summoner:SetAttr(eHeroAttr.maxHp, self.caster.maxHp * self.arglist[1] // 1000)
    summoner:SetAttr(eHeroAttr.injury_reduce, self.caster.injury_reduce)
    summoner:SetAttr(eHeroAttr.resistance, self.caster.resistance)
    summoner:SetAttr(eHeroAttr.def, self.caster.def)
    summoner:SetAttr(eHeroAttr.magic_res, self.caster.magic_res)
    summoner:SetAttr(eHeroAttr.dodge, self.dodge)
    summoner:SetAsRealEntity(1)
    local arg1 = self.arglist[2]
    local tab = {arg_1 = arg1}
    summoner:SetRecordTable(tab)
    summonerEntity = LuaSkillCtrl:AddSummonerRole(summoner)
    self.Summoner = summonerEntity
    self.line = LuaSkillCtrl:CallEffect(target, self.config.effectId_line, self, nil, summonerEntity)
    self.killTargeter = LuaSkillCtrl:StartTimer(nil, self.arglist[2], function()
      self:killTarget()
    end, nil, 0)
  end
end

function bs_213403:killTarget()
  if self.target == nil then
    return
  end
  local role = self.target
  local role1 = self.Summoner
  local IfRoleCotainsIgnoreDieBuff = LuaSkillCtrl:RoleContainsBuffFeature(role1, self.config.buffFeature_ignoreDie)
  if IfRoleCotainsIgnoreDieBuff == true then
    local buff_ignoreDie = LuaSkillCtrl:GetRoleAllBuffsByFeature(role1, self.config.buffFeature_ignoreDie)
    if buff_ignoreDie.Count > 0 then
      for i = 0, buff_ignoreDie.Count - 1 do
        LuaSkillCtrl:DispelBuff(role1, buff_ignoreDie[i].dataId, 0, true)
        IfRoleCotainsIgnoreDieBuff = false
      end
    end
  end
  local IfRoleCotainsWudiBuff = LuaSkillCtrl:RoleContainsBuffFeature(role1, self.config.buffFeature_Invinciable)
  if IfRoleCotainsWudiBuff == true then
    local buff_Wudi = LuaSkillCtrl:GetRoleAllBuffsByFeature(role1, self.config.buffFeature_Invinciable)
    if buff_Wudi.Count > 0 then
      for i = 0, buff_Wudi.Count - 1 do
        LuaSkillCtrl:DispelBuff(role1, buff_Wudi[i].dataId, 0, true)
      end
    end
  end
  local IfRoleCotainsExiledBuff = LuaSkillCtrl:RoleContainsBuffFeature(role1, self.config.Exiled)
  if IfRoleCotainsExiledBuff == true then
    local buff_Exile = LuaSkillCtrl:GetRoleAllBuffsByFeature(role1, self.config.Exiled)
    if buff_Exile.Count > 0 then
      for i = 0, buff_Exile.Count - 1 do
        LuaSkillCtrl:DispelBuff(role1, buff_Exile[i].dataId, 0, true)
      end
    end
  end
  local IfRoleCotainsWudiBuff = LuaSkillCtrl:RoleContainsBuffFeature(role, self.config.buffFeature_Invinciable)
  if IfRoleCotainsWudiBuff == true then
    local buff_Wudi = LuaSkillCtrl:GetRoleAllBuffsByFeature(role, self.config.buffFeature_Invinciable)
    if buff_Wudi.Count > 0 then
      for i = 0, buff_Wudi.Count - 1 do
        LuaSkillCtrl:DispelBuff(role, buff_Wudi[i].dataId, 0, true)
      end
    end
  end
  local IfRoleCotainsExiledBuff = LuaSkillCtrl:RoleContainsBuffFeature(role, self.config.Exiled)
  if IfRoleCotainsExiledBuff == true then
    local buff_Exile = LuaSkillCtrl:GetRoleAllBuffsByFeature(role, self.config.Exiled)
    if buff_Exile.Count > 0 then
      for i = 0, buff_Exile.Count - 1 do
        LuaSkillCtrl:DispelBuff(role, buff_Exile[i].dataId, 0, true)
      end
    end
  end
  if 0 < role.hp and IfRoleCotainsIgnoreDieBuff == false then
    LuaSkillCtrl:CallEffect(role, self.config.effectId_hit, self)
    LuaSkillCtrl:CallEffect(self.Summoner, self.config.effectId_hit, self)
    LuaSkillCtrl:RemoveLife(role.hp * 100, self, role, true, nil, false, false, eHurtType.RealDmg, true)
    self.target = nil
    if self.Summoner ~= nil then
      LuaSkillCtrl:CallEffect(self.Summoner, self.config.effectId_hit, self)
      LuaSkillCtrl:RemoveLife(self.Summoner.hp * 100, self, self.Summoner, true, nil, false, true, eHurtType.RealDmg, true)
      self.Summoner = nil
    end
    if self.line ~= nil then
      self.line:Die()
      self.line = nil
    end
  end
end

function bs_213403:OnRoleDie(killer, role)
  if role == self.Summoner then
    if self.killTargeter ~= nil then
      self.killTargeter:Stop()
      self.killTargeter = nil
      self.Summoner = nil
    end
    if self.line ~= nil then
      self.line:Die()
      self.line = nil
    end
    LuaSkillCtrl:CallBuff(self, self.target, self.config.buffId_damage, 1, self.arglist[5], true)
  elseif role == self.target then
    if self.killTargeter ~= nil then
      self.killTargeter:Stop()
      self.killTargeter = nil
    end
    if self.line ~= nil then
      self.line:Die()
      self.line = nil
    end
    self.target = nil
    if self.Summoner ~= nil then
      LuaSkillCtrl:CallEffect(self.Summoner, self.config.effectId_hit, self)
      LuaSkillCtrl:RemoveLife(self.Summoner.hp * 100, self, self.Summoner, true, nil, false, true, eHurtType.RealDmg, true)
      self.Summoner = nil
    end
  end
end

function bs_213403:OnAfterHeal(sender, target, skill, heal, isStealHeal, isCrit, isTriggerSet)
  if self.Summoner ~= nil then
    LuaSkillCtrl:CallBuff(self, self.Summoner, self.config.buffId, 1, nil, true)
  end
end

function bs_213403:EndSkillAndCallNext()
  LuaSkillCtrl:DispelBuff(self.caster, 170, 0)
  if self.caster == nil then
    return
  end
  self:CancleCasterWait()
  local skillMgr = self.caster:GetSkillComponent()
  if skillMgr == nil then
    return
  end
  skillMgr.lastSkill = self.cskill
  self.caster:CallUnFreezeNextSkill()
  LuaSkillCtrl:StopShowSkillDurationTime(self)
end

function bs_213403:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_213403
