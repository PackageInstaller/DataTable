local bs_212500 = class("bs_212500", LuaSkillBase)
local base = LuaSkillBase
bs_212500.config = {
  effectId_bomb_loop = 212500,
  effectId_bomb_end = 212501,
  action_loop_time = 75,
  configId = 13,
  HurtConfigID = 3,
  buffFeature_ignoreDie = 6,
  buffId_Bati = 207703,
  buffId_wudi = 209504,
  NoEffectBuffId = 110130,
  realDamage = {
    basehurt_formula = 502,
    lifesteal_formula = 0,
    spell_lifesteal_formula = 0,
    returndamage_formula = 0
  }
}

function bs_212500:ctor()
end

function bs_212500:InitSkill(isMidwaySkill)
  self.halo = nil
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_212500", 1, self.OnAfterBattleStart)
end

function bs_212500:OnAfterBattleStart()
  local collisionEnter = BindCallback(self, self.OnCollisionEnter)
  self.halo = LuaSkillCtrl:CallCircledEmissionStraightly(self, self.caster, self.caster, 90, 0, eColliderInfluenceType.Enemy, collisionEnter, nil, nil, nil, false, false, nil, self.caster)
end

function bs_212500:OnCollisionEnter(collider, index, entity)
  if entity._thisBelong == CS.Belong.player then
    self:doskill()
  end
end

function bs_212500:doskill()
  local Skill_time = self.config.action_loop_time
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_Bati, 1, Skill_time, true)
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_wudi, 1, Skill_time, true)
  local attackTrigger = BindCallback(self, self.OnAttackTrigger)
  local skill_left = 0
  self.Boom1 = LuaSkillCtrl:StartTimer(nil, 15, function()
    self.effect_loop_212500 = LuaSkillCtrl:CallEffect(self.caster, self.config.effectId_bomb_loop, self)
    LuaSkillCtrl:EffectSetCountValue(self.effect_loop_212500, skill_left)
    skill_left = skill_left + 1
  end, nil, 4, 15)
  self.Boom = LuaSkillCtrl:StartTimer(nil, Skill_time, attackTrigger)
  self:AddCasterWait(Skill_time)
  if self.halo ~= nil then
    self.halo:EndAndDisposeEmission()
    self.halo = nil
  end
end

function bs_212500:OnAttackTrigger()
  if self.effect_loop_212500 ~= nil then
    self.effect_loop_212500:Die()
    self.effect_loop_212500 = nil
  end
  LuaSkillCtrl:CallEffect(self.caster, self.config.effectId_bomb_end, self)
  local targetList = LuaSkillCtrl:FindAllRolesWithinRange(self.caster, 1, false)
  if targetList.Count > 0 then
    for i = 0, targetList.Count - 1 do
      if targetList[i].belongNum ~= self.caster.belongNum and targetList[i]:GetBuffTier(self.config.NoEffectBuffId) == 0 then
        local hurt_num = targetList[i].maxHp * self.arglist[1] // 1000
        LuaSkillCtrl:CallRealDamage(self, targetList[i], nil, self.config.realDamage, {hurt_num}, true)
      end
    end
  end
  local IfRoleCotainsIgnoreDieBuff = LuaSkillCtrl:RoleContainsBuffFeature(self.caster, self.config.buffFeature_ignoreDie)
  if IfRoleCotainsIgnoreDieBuff == true then
    local buff_ignoreDie = LuaSkillCtrl:GetRoleAllBuffsByFeature(self.caster, self.config.buffFeature_ignoreDie)
    if buff_ignoreDie.Count > 0 then
      for i = 0, buff_ignoreDie.Count - 1 do
        LuaSkillCtrl:DispelBuff(self.caster, buff_ignoreDie[i].dataId, 0)
        IfRoleCotainsIgnoreDieBuff = false
      end
    end
  end
  LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId_wudi, 0)
  LuaSkillCtrl:RemoveLife(self.caster.hp, self, self.caster, true, nil, false, true, eHurtType.RealDmg, true)
end

function bs_212500:OnCasterDie()
  if self.effect_loop_212500 ~= nil then
    self.effect_loop_212500:Die()
    self.effect_loop_212500 = nil
  end
  if self.Boom ~= nil then
    self.Boom:Stop()
    self.Boom = nil
  end
  if self.Boom1 ~= nil then
    self.Boom1:Stop()
    self.Boom1 = nil
  end
  base.OnCasterDie(self)
end

function bs_212500:LuaDispose()
  self.effect_loop_212500 = nil
  self.Boom = nil
  base.LuaDispose(self)
end

return bs_212500
