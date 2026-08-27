local bs_108601 = class("bs_108601", LuaSkillBase)
local base = LuaSkillBase
bs_108601.config = {
  monsterId1 = 94,
  monsterId2 = 95,
  configId = 3,
  effect_cast = 108604,
  effect_halo = 108605,
  buffId_1 = 108601,
  buffId_2 = 108602,
  buffId_3 = 108605,
  buffId_4 = 108606
}

function bs_108601:ctor()
end

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

function bs_108601:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterPlaySkillTriggerForTable("bs_108601_01", 1, self.OnAfterPlaySkill, {
    senderBelongNum = self.caster.belongNum,
    extraArg1 = eSkillTag.commonAttack
  })
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_108601_03", 1, self.OnAfterBattleStart)
  self:AddOnRoleDieTrigger("bs_108601_02", 1, self.OnRoleDie)
  self.dogface1 = nil
  self.dogface2 = nil
  self.dogface1_actor = nil
  self.dogface2_actor = nil
  self.effectHalo1 = nil
  self.halo1 = nil
  self.effectHalo2 = nil
  self.halo2 = nil
end

function bs_108601:OnAfterBattleStart()
  self:Summon()
end

function bs_108601:Summon()
  if self.dogface1 ~= true then
    self:doSummon(1)
    self.dogface1 = true
  end
  if self.dogface2 ~= true then
    self:doSummon(2)
    self.dogface2 = true
  end
end

function bs_108601:doSummon(num)
  local Grid = LuaSkillCtrl:CallFindEmptyGridNearest(self.caster)
  if Grid == nil then
    Grid = LuaSkillCtrl:FindRoleRightEmptyGrid(self.caster, 10)
  end
  if Grid == nil then
    return
  end
  local summonerEntity
  if num == 1 then
    local target = LuaSkillCtrl:GetTargetWithGrid(Grid.x, Grid.y)
    LuaSkillCtrl:CallEffect(target, self.config.effect_cast, self)
    local summoner = LuaSkillCtrl:CreateSummoner(self, self.config.monsterId2, Grid.x, Grid.y)
    summoner:SetAttr(eHeroAttr.maxHp, self.caster.maxHp * self.arglist[1] // 1000)
    summoner:SetAttr(eHeroAttr.skill_intensity, self.caster.skill_intensity * self.arglist[6] // 1000)
    summoner:SetAttr(eHeroAttr.pow, self.caster.skill_intensity * self.arglist[6] // 1000)
    summoner:SetAttr(eHeroAttr.speed, self.caster.speed)
    summoner:SetAttr(eHeroAttr.def, self.caster.def)
    summoner:SetAttr(eHeroAttr.magic_res, self.caster.magic_res)
    summoner:SetAttr(eHeroAttr.lucky, self.caster.lucky)
    summoner:SetAttr(eHeroAttr.crit, self.caster.crit)
    local hostEntity = self.caster
    if hostEntity == nil or hostEntity.hp <= 0 then
      return over
    end
    for i, v in ipairs(SyncAttrList) do
      local curValue = self.caster:GetRealProperty(v)
      summoner:SetAttr(v, curValue)
    end
    summoner:SetAsRealEntity(1)
    summonerEntity = LuaSkillCtrl:AddSummonerRole(summoner)
    self.dogface1_actor = summonerEntity
    if self.effectHalo1 == nil then
      self.effectHalo1 = LuaSkillCtrl:CallEffect(summonerEntity, self.config.effect_halo, self)
    end
    local collisionEnter1 = BindCallback(self, self.OnCollisionEnter1)
    local collisionExit1 = BindCallback(self, self.OnCollisionExit1)
    self.halo1 = LuaSkillCtrl:CallCircledEmissionStraightly(self, summonerEntity, summonerEntity, 775, 0, eColliderInfluenceType.Player, collisionEnter1, nil, collisionExit1, nil, false, false, nil, summonerEntity)
  end
  if num == 2 then
    local target = LuaSkillCtrl:GetTargetWithGrid(Grid.x, Grid.y)
    LuaSkillCtrl:CallEffect(target, self.config.effect_cast, self)
    local summoner = LuaSkillCtrl:CreateSummoner(self, self.config.monsterId1, Grid.x, Grid.y)
    summoner:SetAttr(eHeroAttr.maxHp, self.caster.maxHp * self.arglist[1] // 1000)
    summoner:SetAttr(eHeroAttr.skill_intensity, self.caster.skill_intensity * self.arglist[6] // 1000)
    summoner:SetAttr(eHeroAttr.pow, self.caster.skill_intensity * self.arglist[6] // 1000)
    summoner:SetAttr(eHeroAttr.speed, self.caster.speed)
    summoner:SetAttr(eHeroAttr.def, self.caster.def)
    summoner:SetAttr(eHeroAttr.magic_res, self.caster.magic_res)
    summoner:SetAttr(eHeroAttr.lucky, self.caster.lucky)
    summoner:SetAttr(eHeroAttr.crit, self.caster.crit)
    local hostEntity = self.caster
    if hostEntity == nil or hostEntity.hp <= 0 then
      return over
    end
    for i, v in ipairs(SyncAttrList) do
      local curValue = self.caster:GetRealProperty(v)
      summoner:SetAttr(v, curValue)
    end
    summoner:SetAsRealEntity(1)
    summonerEntity = LuaSkillCtrl:AddSummonerRole(summoner)
    self.dogface2_actor = summonerEntity
    if self.effectHalo2 == nil then
      self.effectHalo2 = LuaSkillCtrl:CallEffect(summonerEntity, self.config.effect_halo, self)
    end
    local collisionEnter2 = BindCallback(self, self.OnCollisionEnter2)
    local collisionExit2 = BindCallback(self, self.OnCollisionExit2)
    self.halo2 = LuaSkillCtrl:CallCircledEmissionStraightly(self, summonerEntity, summonerEntity, 999, 0, eColliderInfluenceType.Player, collisionEnter2, nil, collisionExit2, nil, false, false, nil, summonerEntity)
  end
end

function bs_108601:OnAfterPlaySkill(skill, role)
  local target = role.recordTable.lastAttackRole
  if target == nil then
    return
  end
  if role.roleType == 4 then
    LuaSkillCtrl:StartTimer(nil, 7, function()
      local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target)
      LuaSkillCtrl:HurtResultWithConfig(self, skillResult, self.config.configId, {
        self.arglist[5]
      }, true, nil)
      skillResult:EndResult()
    end, nil)
  end
end

function bs_108601:OnCollisionEnter1(collider, index, entity)
  if entity:GetBuffTier(self.config.buffId_3) < 1 and (entity == self.caster or entity == self.dogface1_actor or entity == self.dogface2_actor) then
    LuaSkillCtrl:CallBuff(self, entity, self.config.buffId_3, 1)
  end
end

function bs_108601:OnCollisionExit1(collider, entity)
  if entity:GetBuffTier(self.config.buffId_3) < 1 and (entity == self.caster or entity == self.dogface1_actor or entity == self.dogface2_actor) then
    LuaSkillCtrl:DispelBuff(entity, self.config.buffId_3, 0)
  end
end

function bs_108601:OnCollisionEnter2(collider, index, entity)
  if entity:GetBuffTier(self.config.buffId_4) < 1 and (entity == self.caster or entity == self.dogface1_actor or entity == self.dogface2_actor) then
    LuaSkillCtrl:CallBuff(self, entity, self.config.buffId_4, 1)
  end
end

function bs_108601:OnCollisionExit2(collider, entity)
  if entity:GetBuffTier(self.config.buffId_4) < 1 and (entity == self.caster or entity == self.dogface1_actor or entity == self.dogface2_actor) then
    LuaSkillCtrl:DispelBuff(entity, self.config.buffId_4, 0)
  end
end

function bs_108601:OnRoleDie(killer, role)
  if role == self.dogface1_actor then
    self.dogface1 = nil
    self.dogface1_actor = nil
    self.timer1 = LuaSkillCtrl:StartTimer(nil, self.arglist[4], function()
      self:doSummon(1)
    end, nil, 0, 0)
    if self.effectHalo1 ~= nil then
      self.effectHalo1:Die()
      self.effectHalo1 = nil
    end
    if self.halo1 ~= nil then
      self.halo1:EndAndDisposeEmission()
      self.halo1 = nil
    end
    self:Addbuff(1)
  elseif role == self.dogface2_actor then
    self.dogface2 = nil
    self.dogface2_actor = nil
    self.timer2 = LuaSkillCtrl:StartTimer(nil, self.arglist[4], function()
      self:doSummon(2)
    end, nil, 0, 0)
    if self.effectHalo2 ~= nil then
      self.effectHalo2:Die()
      self.effectHalo2 = nil
    end
    if self.halo2 ~= nil then
      self.halo2:EndAndDisposeEmission()
      self.halo2 = nil
    end
    self:Addbuff(2)
  end
end

function bs_108601:Addbuff(num)
  local playerList = LuaSkillCtrl:GetSelectTeamRoles(eBattleRoleBelong.player)
  if playerList.Count > 0 then
    for i = 0, playerList.Count - 1 do
      local role = playerList[i]
      if role ~= nil and 0 < role.hp then
        LuaSkillCtrl:CallBuff(self, role, self.config.buffId_1, 1, self.arglist[2])
      end
      if num == 1 and 0 < role:GetBuffTier(self.config.buffId_3) then
        LuaSkillCtrl:DispelBuff(role, self.config.buffId_3, 1)
      end
      if num == 2 and 0 < role:GetBuffTier(self.config.buffId_4) then
        LuaSkillCtrl:DispelBuff(role, self.config.buffId_4, 1)
      end
    end
  end
end

function bs_108601:OnCasterDie()
  base.OnCasterDie(self)
  if self.timer1 ~= nil then
    self.timer1:Stop()
    self.timer1 = nil
  end
  if self.timer2 ~= nil then
    self.timer2:Stop()
    self.timer2 = nil
  end
end

function bs_108601:LuaDispose()
  self.dogface1 = nil
  self.dogface2 = nil
  self.dogface1_actor = nil
  self.dogface2_actor = nil
  base.LuaDispose(self)
end

return bs_108601
