local bs_8204 = class("bs_8204", LuaSkillBase)
local base = LuaSkillBase
bs_8204.config = {
  buffId = 606,
  enemyStunBuff = 289,
  monsterId1 = 77,
  effect_showup = 613,
  buffFeature_ignoreDie = 6
}
local SyncAttrList = {
  eHeroAttr.moveSpeed,
  eHeroAttr.dodge,
  eHeroAttr.critDamage,
  eHeroAttr.sunder,
  eHeroAttr.damage_increase,
  eHeroAttr.injury_reduce,
  eHeroAttr.heal,
  eHeroAttr.treatment,
  eHeroAttr.magic_pen,
  eHeroAttr.cd_reduce,
  eHeroAttr.resistance
}
bs_8204.AbandonTakeFeatureEx = {
  eBuffFeatureType.BeatBack,
  eBuffFeatureType.KnockOff,
  eBuffFeatureType.Stun,
  eBuffFeatureType.Exiled,
  eBuffFeatureType.CtrlImmunity
}

function bs_8204:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterBuffRemoveTrigger("bs_8204_buff_die", 1, self.AfterBuffRemove, nil, nil, self.config.buffId)
  self:AddOnRoleDieTrigger("bs_8204_01", 1, self.OnRoleDie)
  self.table = {}
end

function bs_8204:PlaySkill(data, selectTargetCoord, selectRoles)
  return self:GetSelectTargetAndExecute(selectRoles, BindCallback(self, self.CallSelectExecute))
end

function bs_8204:CallSelectExecute(role)
  self.failedfly = true
  if self.AbandonTakeFeatureEx ~= nil then
    for i = 1, #self.AbandonTakeFeatureEx do
      if LuaSkillCtrl:RoleContainsBuffFeature(role, self.AbandonTakeFeatureEx[i]) then
        self.failedfly = false
      end
    end
  end
  if role ~= nil and role.belongNum ~= eBattleRoleBelong.neutral and self.failedfly == true then
    LuaSkillCtrl:CallBuff(self, role, self.config.buffId, 1, self.arglist[1])
  end
  if role ~= nil and role.belongNum ~= eBattleRoleBelong.neutral and self.failedfly == false then
    self:Onover()
    self:Summon(role)
    self:Summon(role)
  end
end

function bs_8204:AfterBuffRemove(buffId, target, removeType)
  if target.hp <= 0 then
    return
  end
  if target.belongNum == eBattleRoleBelong.enemy then
    LuaSkillCtrl:CallBuff(self, target, self.config.enemyStunBuff, 1, self.arglist[2])
    self:Onover()
    self:Summon(target)
    self:Summon(target)
  end
  LuaSkillCtrl:CallRedisplayInSkillInputCtrl(target)
end

function bs_8204:Summon(target)
  local Grid = LuaSkillCtrl:CallFindEmptyGridNearest(target)
  if Grid == nil then
    Grid = LuaSkillCtrl:FindRoleRightEmptyGrid(target, 10)
  end
  if Grid ~= nil then
    self:doSummon(Grid)
  end
end

function bs_8204:doSummon(Grid, Num)
  local summonerEntity
  local target = LuaSkillCtrl:GetTargetWithGrid(Grid.x, Grid.y)
  local highAttRole = LuaSkillCtrl:CallTargetSelect(self, 46, 20)
  if highAttRole == nil or highAttRole.Count == 0 or highAttRole[0] == nil then
    return
  end
  local TargetRole = highAttRole[0].targetRole
  local summoner = LuaSkillCtrl:CreateSummoner(self, self.config.monsterId1, Grid.x, Grid.y)
  summoner:SetAttr(eHeroAttr.maxHp, TargetRole.maxHp * self.arglist[3] // 1000)
  summoner:SetAttr(eHeroAttr.skill_intensity, TargetRole.skill_intensity * self.arglist[4] // 1000)
  summoner:SetAttr(eHeroAttr.pow, TargetRole.pow * self.arglist[4] // 1000)
  summoner:SetAttr(eHeroAttr.speed, TargetRole.speed)
  summoner:SetAttr(eHeroAttr.def, TargetRole.def)
  summoner:SetAttr(eHeroAttr.magic_res, TargetRole.magic_res)
  summoner:SetAttr(eHeroAttr.lucky, TargetRole.lucky)
  summoner:SetAttr(eHeroAttr.crit, TargetRole.crit)
  summoner:SetAsRealEntity(1)
  summoner:SetRecordTable(tab)
  summonerEntity = LuaSkillCtrl:AddSummonerRole(summoner)
  LuaSkillCtrl:CallEffect(summonerEntity, self.config.effect_showup, self)
  if self.table[1] == nil then
    self.table[1] = summonerEntity
  elseif self.table[2] == nil then
    self.table[2] = summonerEntity
  end
end

function bs_8204:Onover()
  if self.table[2] ~= nil then
    local target = self.table[2]
    local IfRoleCotainsIgnoreDieBuff = LuaSkillCtrl:RoleContainsBuffFeature(target, self.config.buffFeature_ignoreDie)
    if IfRoleCotainsIgnoreDieBuff == true then
      local buff_ignoreDie = LuaSkillCtrl:GetRoleAllBuffsByFeature(target, self.config.buffFeature_ignoreDie)
      if buff_ignoreDie.Count > 0 then
        for i = 0, buff_ignoreDie.Count - 1 do
          LuaSkillCtrl:DispelBuff(target, buff_ignoreDie[i].dataId, 0, true)
          IfRoleCotainsIgnoreDieBuff = false
        end
      end
    end
    if 0 < target.hp and IfRoleCotainsIgnoreDieBuff == false then
      LuaSkillCtrl:RemoveLife(target.hp + 10000, self, target, true, nil, false, true, eHurtType.RealDmg, true)
    end
  end
  if self.table[1] ~= nil then
    local target = self.table[1]
    local IfRoleCotainsIgnoreDieBuff = LuaSkillCtrl:RoleContainsBuffFeature(target, self.config.buffFeature_ignoreDie)
    if IfRoleCotainsIgnoreDieBuff == true then
      local buff_ignoreDie = LuaSkillCtrl:GetRoleAllBuffsByFeature(target, self.config.buffFeature_ignoreDie)
      if buff_ignoreDie.Count > 0 then
        for i = 0, buff_ignoreDie.Count - 1 do
          LuaSkillCtrl:DispelBuff(target, buff_ignoreDie[i].dataId, 0, true)
          IfRoleCotainsIgnoreDieBuff = false
        end
      end
    end
    if 0 < target.hp and IfRoleCotainsIgnoreDieBuff == false then
      LuaSkillCtrl:RemoveLife(target.hp + 10000, self, target, true, nil, false, true, eHurtType.RealDmg, true)
    end
  end
end

function bs_8204:OnRoleDie(killer, role)
  if role == self.table[2] then
    table.remove(self.table, 2)
  elseif role == self.table[1] then
    table.remove(self.table, 1)
  end
end

function bs_8204:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_8204
