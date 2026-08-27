local bs_101901 = class("bs_101901", LuaSkillBase)
local base = LuaSkillBase
bs_101901.config = {
  monsterId = 14,
  effectId1 = 10687,
  effectId1_skin = 106871,
  effectId2 = 10686,
  effectId2_weapon = 101906,
  effectId3 = 10699,
  effectId_db = 10700,
  effectId_db_weapon = 101905,
  hurtConfig = {
    hit_formula = 0,
    basehurt_formula = 10081,
    crit_formula = 0,
    crithur_ratio = 0
  },
  buffId_229 = 229,
  skill_time = 47,
  start_time = 27,
  actionId = 1002,
  action_speed = 1,
  audioId1 = 219,
  audioId2 = 220,
  weaponLv = 0
}
local SyncAttrList = {
  eHeroAttr.moveSpeed,
  eHeroAttr.dodge,
  eHeroAttr.crit,
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

function bs_101901:ctor()
end

function bs_101901:InitSkill(isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_101901_1", 1, self.OnAfterBattleStart)
  self:AddTrigger(eSkillTriggerType.RoleDie, "bs_101901_10", 1, self.OnRoleDie)
  self:AddLuaTrigger(eSkillLuaTrigger.FernSkill, self.AccTimer)
  self.summonerEntity = nil
end

function bs_101901:OnAfterBattleStart()
  if LuaSkillCtrl.IsInTDBattle ~= true then
    self:PlaySkill()
  end
end

function bs_101901:PlaySkill()
  if self.caster.hp <= 0 then
    return
  end
  local Grid = LuaSkillCtrl:FindRoleRightEmptyGrid(self.caster, 10)
  if Grid == nil then
    Grid = LuaSkillCtrl:CallFindEmptyGridNearest(self.caster)
  end
  if Grid ~= nil then
    local monsterId = self.config.monsterId
    if self.config.weaponLv >= 2 then
      monsterId = 141
      if self.config.weaponLv >= 3 then
        monsterId = 142
      end
    end
    local summoner = LuaSkillCtrl:CreateSummoner(self, monsterId, Grid.x, Grid.y)
    summoner:SetAttr(eHeroAttr.maxHp, self.caster.skill_intensity * self.arglist[1] // 1000)
    local pow = self.caster.skill_intensity * self.arglist[2]
    if self.config.weaponLv >= 1 then
      pow = pow + self.caster.skill_intensity * self.arglist[7]
    end
    summoner:SetAttr(eHeroAttr.pow, pow // 1000)
    if self.config.weaponLv >= 1 then
      local intensity = self.caster.skill_intensity * self.arglist[2] + self.caster.skill_intensity * self.arglist[7]
      summoner:SetAttr(eHeroAttr.skill_intensity, intensity // 1000)
    end
    local speed = self.caster.speed
    speed = speed + self.arglist[6]
    summoner:SetAttr(eHeroAttr.speed, speed)
    local def = self.caster.skill_intensity * self.arglist[3]
    if self.config.weaponLv >= 1 then
      def = def + self.caster.skill_intensity * self.arglist[8]
    end
    summoner:SetAttr(eHeroAttr.def, def // 1000)
    summoner:SetAttr(eHeroAttr.magic_res, def // 1000)
    local hostEntity = self.caster
    if hostEntity == nil or hostEntity.hp <= 0 then
      return over
    end
    for i, v in ipairs(SyncAttrList) do
      local curValue = self.caster:GetRealProperty(v)
      summoner:SetAttr(v, curValue)
    end
    summoner:SetAsRealEntity(1)
    LuaSkillCtrl:CallBuff(self, self.caster, 196, 1, self.config.start_time)
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_229, 1, self.config.skill_time - 2)
    if self.effect2 ~= nil then
      self.effect2:Die()
      self.effect2 = nil
    end
    local maxhp = self.caster.skill_intensity * self.arglist[1] // 1000 * 10
    self.summonerEntity = LuaSkillCtrl:AddSummonerRole(summoner)
    LuaSkillCtrl:CallBuff(self, self.summonerEntity, 270, 1, 27, true)
    LuaSkillCtrl:StartTimer(nil, 26, function()
      if self.caster == nil or self.caster.hp <= 0 then
        LuaSkillCtrl:RemoveLife(maxhp, self, self.summonerEntity, true, nil, false, true, 2)
      end
    end)
    local target = LuaSkillCtrl:GetTargetWithGrid(Grid.x, Grid.y)
    local attackTrigger = BindCallback(self, self.OnAttackTrigger, Grid, summoner, target)
    self.caster:LookAtTarget(target)
    self:CallCasterWait(self.config.skill_time)
    LuaSkillCtrl:CallRoleAction(self, self.config.actionId, 1)
    LuaSkillCtrl:StartTimer(nil, self.config.start_time, attackTrigger)
    LuaSkillCtrl:PlayAuSource(self.caster, self.config.audioId1)
    if LuaSkillCtrl:GetCasterSkinId(self.caster) == 301905 then
      self.effect = LuaSkillCtrl:CallEffect(self.caster, self.config.effectId1_skin, self, nil, nil, nil, true)
    else
      self.effect = LuaSkillCtrl:CallEffect(self.caster, self.config.effectId1, self, nil, nil, nil, true)
    end
    if self.config.weaponLv >= 1 then
      self.effect2 = LuaSkillCtrl:CallEffect(target, self.config.effectId_db_weapon, self, nil, nil, nil, true)
    else
      self.effect2 = LuaSkillCtrl:CallEffect(target, self.config.effectId_db, self, nil, nil, nil, true)
    end
  end
end

function bs_101901:OnAttackTrigger(grid, summoner, target)
  if self.config.weaponLv >= 1 then
    LuaSkillCtrl:CallEffect(target, self.config.effectId2_weapon, self)
  else
    LuaSkillCtrl:CallEffect(target, self.config.effectId2, self)
  end
  LuaSkillCtrl:PlayAuSource(self.caster, self.config.audioId2)
  self.caster.recordTable.sum = true
  LuaSkillCtrl:StartTimer(nil, 10, function()
    if self.effect ~= nil then
      self.effect:Die()
      self.effect = nil
    end
    if self.effect2 ~= nil then
      self.effect2:Die()
      self.effect2 = nil
    end
  end)
end

function bs_101901:AccTimer()
  if self.config.weaponLv >= 1 then
    self:OnSyncAttrFromHost()
  end
end

function bs_101901:OnSyncAttrFromHost()
  local summonerEntity = self.summonerEntity
  if summonerEntity == nil then
    return
  end
  local ownerSkillIntensity = self.caster.skill_intensity
  for i, v in ipairs(SyncAttrList) do
    local attrValue = summonerEntity:GetRealProperty(v)
    local curValue = self.caster:GetRealProperty(v)
    summonerEntity:AddRoleProperty(v, curValue - attrValue, eHeroAttrType.Origin)
  end
  local attrValue_def = summonerEntity:GetRealProperty(eHeroAttr.def)
  local attrValue_ma_def = summonerEntity:GetRealProperty(eHeroAttr.magic_res)
  local curValue = ownerSkillIntensity * (self.arglist[3] + self.arglist[8]) // 1000
  summonerEntity:AddRoleProperty(eHeroAttr.def, curValue - attrValue_def, eHeroAttrType.Origin)
  summonerEntity:AddRoleProperty(eHeroAttr.magic_res, curValue - attrValue_ma_def, eHeroAttrType.Origin)
  local attrValue_pow = summonerEntity:GetRealProperty(eHeroAttr.pow)
  local attrValue_int = summonerEntity:GetRealProperty(eHeroAttr.skill_intensity)
  local curValue_2 = ownerSkillIntensity * (self.arglist[2] + self.arglist[7]) // 1000
  summonerEntity:AddRoleProperty(eHeroAttr.pow, curValue_2 - attrValue_pow, eHeroAttrType.Origin)
  summonerEntity:AddRoleProperty(eHeroAttr.skill_intensity, curValue_2 - attrValue_int, eHeroAttrType.Origin)
  local hp_per = summonerEntity.hp * 1000 // summonerEntity.maxHp
  local curValue_hp = ownerSkillIntensity * self.arglist[1] // 1000
  local attrValue_hp = summonerEntity:GetRealProperty(eHeroAttr.maxHp)
  summonerEntity:AddRoleProperty(eHeroAttr.maxHp, curValue_hp - attrValue_hp, eHeroAttrType.Origin)
  local hp_now = curValue_hp * hp_per // 1000
  if hp_now > summonerEntity.hp then
    local num = hp_now - summonerEntity.hp
    LuaSkillCtrl:CallHeal(num, self, summonerEntity, true)
  else
    local num = summonerEntity.hp - hp_now
    LuaSkillCtrl:RemoveLife(num, self, summonerEntity, true, nil, false, true, 2, true)
  end
end

function bs_101901:OnRoleDie(killer, role)
  if role == self.summonerEntity then
    self.caster.recordTable.sum = false
    self.summonerEntity = nil
    self.again = LuaSkillCtrl:StartTimer(nil, self.arglist[4], function()
      if self.again ~= nil and self.again:IsOver() then
        self.again = nil
      end
      self:PlaySkill()
    end, self)
  end
end

function bs_101901:OnCasterDie()
  base.OnCasterDie(self)
  if self.again ~= nil then
    self.again:Stop()
    self.again = nil
  end
end

function bs_101901:LuaDispose()
  base.LuaDispose(self)
  self.effect = nil
  self.effect2 = nil
  self.summonerEntity = nil
  if self.again ~= nil then
    self.again:Stop()
    self.again = nil
  end
end

return bs_101901
