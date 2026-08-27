local bs_109001 = class("bs_109001", LuaSkillBase)
local base = LuaSkillBase
bs_109001.config = {
  buffId = 107101,
  buffId_1 = 109001,
  buffId_maxlos = 109002,
  buffId_live = 215005,
  effectId_hit = 109004,
  effectId_fire = 109005,
  HurtConfigID = 39,
  heal_config = 7,
  effectId_show = 109007,
  nanaka_buffId = 102603
}

function bs_109001:ctor()
end

function bs_109001:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self.times = 0
  self:AddSetHurtTrigger("bs_109001_3", 1, self.OnSetHurt, nil, nil, self.caster.belongNum, nil, 1, nil)
  self:AddSetDeadHurtTrigger("bs_109001_1", 1999, self.OnSetDeadHurt, nil, self.caster, nil, nil)
  self.caster.recordTable.energy_num = 0
  LuaSkillCtrl:BroadcastLuaTrigger(eSkillLuaTrigger.StoryEvent, "sp_suer_born", self.caster)
end

function bs_109001:OnSetHurt(context)
  if context.hurt_tag == 1 and context.target.belongNum ~= self.caster.belongNum and context.target:GetBuffTier(self.config.buffId_1) > 0 then
    if context.sender == self.caster then
      local num = context.target:GetBuffTier(self.config.buffId_1)
      context.hurt = context.hurt * (1000 + self.arglist[3] * num) // 1000
    else
      local num = context.target:GetBuffTier(self.config.buffId_1)
      context.hurt = context.hurt * (1000 + self.arglist[5] * num) // 1000
    end
  end
end

function bs_109001:OnAfterAddBuff(buff, target)
  self:Dodamage(target)
  LuaSkillCtrl:CallBuff(self, target, self.config.buffId_1, 1)
  LuaSkillCtrl:CallEffect(target, self.config.effectId_hit, self, nil, nil, nil, nil)
  self.caster.recordTable.energy_num = self.caster.recordTable.energy_num + 1
  self.times = self.times + 1
  if self.times >= self.arglist[4] then
    self:AddShield()
    self.times = self.times - self.arglist[4]
  end
  if self.Aliver ~= nil then
    self.Aliver.left = self.Aliver.left - 15
  end
end

function bs_109001:AddShield()
  local targetList = LuaSkillCtrl:GetSelectTeamRoles(eBattleRoleBelong.enemy)
  if targetList.Count > 0 then
    for i = 0, targetList.Count - 1 do
      local role = targetList[i]
      if role ~= nil and 0 < role.hp and role.roleType ~= eBattleRoleType.realSummoner then
        local shieldValue = self.caster.skill_intensity * self.arglist[10] // 1000
        if 0 < shieldValue then
          LuaSkillCtrl:AddRoleShield(role, eShieldType.Normal, shieldValue)
        end
      end
    end
  end
  if self.LoopDamage == nil then
    self.LoopEffect = LuaSkillCtrl:CallEffect(self.caster, self.config.effectId_fire, self, nil, nil, nil, nil)
    self.LoopDamage = LuaSkillCtrl:StartTimer(nil, 15, function()
      local targetlist = LuaSkillCtrl:FindRolesAroundRole(self.caster)
      if targetlist ~= nil and targetlist.Count > 0 then
        for i = targetlist.Count - 1, 0, -1 do
          local role = targetlist[i]
          if role.belongNum ~= eBattleRoleBelong.player then
            local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, role)
            LuaSkillCtrl:HurtResultWithConfig(self, skillResult, self.config.HurtConfigID, {
              self.arglist[6]
            }, false, false, nil, 106)
            skillResult:EndResult()
          end
        end
      end
    end, nil, 2, 10)
  else
    self.LoopDamage:Stop()
    self.LoopDamage = nil
    if self.LoopEffect ~= nil then
      self.LoopEffect:Die()
      self.LoopEffect = nil
    end
    self.LoopEffect = LuaSkillCtrl:CallEffect(self.caster, self.config.effectId_fire, self, nil, nil, nil, nil)
    self.LoopDamage = LuaSkillCtrl:StartTimer(nil, 15, function()
      local targetlist = LuaSkillCtrl:FindRolesAroundRole(self.caster)
      if targetlist ~= nil and targetlist.Count > 0 then
        for i = targetlist.Count - 1, 0, -1 do
          local role = targetlist[i]
          if role.belongNum ~= eBattleRoleBelong.player then
            local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, role)
            LuaSkillCtrl:HurtResultWithConfig(self, skillResult, self.config.HurtConfigID, {
              self.arglist[6]
            }, false, false, nil, 106)
            skillResult:EndResult()
          end
        end
      end
    end, nil, 2, 10)
  end
end

function bs_109001:Dodamage(target)
  local originAttrList = target.originAttrList
  local origin_maxHp = originAttrList[eHeroAttr.maxHp]
  local now_maxHp = target.maxHp
  if now_maxHp >= origin_maxHp * self.arglist[2] // 1000 then
    local damage = self.caster.skill_intensity * self.arglist[1] // 1000 + target.maxHp * self.arglist[8] // 1000
    LuaSkillCtrl:RemoveLife(damage, self, target, true, nil, true, false, 2, true)
    LuaSkillCtrl:CallBuff(self, target, self.config.buffId_maxlos, 1, nil, true)
  end
end

function bs_109001:OnSetDeadHurt(context)
  if self.isInDeading then
    return
  end
  local NoDeath = LuaSkillCtrl:RoleContainsBuffFeature(context.target, eBuffFeatureType.NoDeath)
  if context.target:GetBuffTier(self.config.nanaka_buffId) <= 0 and NoDeath == false then
    self.isInDeading = true
    LuaSkillCtrl:CallBuff(self, context.target, self.config.buffId_live, 1, nil, true)
    self.checker = LuaSkillCtrl:StartTimer(nil, 2, function()
      self:check_dead()
    end, nil, -1, 0)
    self.Aliver = LuaSkillCtrl:StartTimer(nil, self.arglist[9], function()
      LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId_live, 1)
      local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, self.caster)
      LuaSkillCtrl:HealResultWithConfig(self, skillResult, self.config.heal_config, {1000}, true, true)
      skillResult:EndResult()
      LuaSkillCtrl:CallEffect(self.caster, self.config.effectId_show, self)
      if self.checker ~= nil then
        self.checker:Stop()
        self.checker = nil
      end
      self.isInDeading = false
    end, nil, 0, 0)
  end
end

function bs_109001:check_dead()
  local targetList = LuaSkillCtrl:GetSelectTeamRoles(eBattleRoleBelong.enemy)
  if targetList.Count == 1 then
    LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId_live, 1)
    LuaSkillCtrl:RemoveLife(self.caster.hp, self, self.caster, true, nil, false, true, eHurtType.RealDmg, true)
  end
end

function bs_109001:OnCasterDie()
  base.OnCasterDie(self)
  if self.LoopEffect ~= nil then
    self.LoopEffect:Die()
    self.LoopEffect = nil
  end
end

function bs_109001:LuaDispose()
  base.LuaDispose(self)
  if self.LoopEffect ~= nil then
    self.LoopEffect:Die()
    self.LoopEffect = nil
  end
  if self.Aliver ~= nil then
    self.Aliver:Stop()
    self.Aliver = nil
  end
  if self.checker ~= nil then
    self.checker:Stop()
    self.checker = nil
  end
end

return bs_109001
