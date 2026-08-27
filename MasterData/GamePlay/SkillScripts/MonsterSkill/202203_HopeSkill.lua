local bs_202203 = class("bs_202203", LuaSkillBase)
local base = LuaSkillBase
bs_202203.config = {
  effectIdline = 10430,
  effectId1 = 10428,
  effectId2 = 10429,
  effectId3 = 102506,
  effectId4 = 10432,
  monsterId = 11,
  HurtConfig = {
    def_formula = 9996,
    basehurt_formula = 10079,
    minhurt_formula = 9994,
    crithur_ratio = 9995,
    correct_formula = 9989,
    lifesteal_formula = 1001,
    spell_lifesteal_formula = 1002,
    returndamage_formula = 1000,
    hit_formula = 0,
    crit_formula = 0
  },
  skill_time = 30,
  start_time = 18,
  startAnimId = 1002,
  maxNum = 5,
  select_id = 42,
  select_range = 10,
  radius = 10,
  speed = 5,
  audioId2 = 306
}

function bs_202203:ctor()
end

function bs_202203:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self.summonerEffectSkill = {}
  self.timenumSkill = {}
  self.summnerListSkill = {}
  self.startCleanSkill = false
  self.caster.recordTable.num = 0
  self.caster.recordTable.hope_hurt = self.arglist[4]
end

function bs_202203:PlaySkill(data)
  if self.caster.recordTable.num < self.config.maxNum then
    LuaSkillCtrl:CallBreakAllSkill(self.caster)
    local attackTrigger = BindCallback(self, self.OnAttackTrigger, data)
    self:CallCasterWait(self.config.skill_time)
    LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, self.config.startAnimId, 1, self.config.start_time, attackTrigger)
    LuaSkillCtrl:CallEffect(self.caster, self.config.effectId1, self, nil, nil, nil, true)
  end
end

function bs_202203:FindEmptyGrid()
  local grid
  local targetlist = LuaSkillCtrl:CallTargetSelect(self, self.config.select_id, self.config.select_range)
  if targetlist.Count > 0 then
    for i = 0, targetlist.Count - 1 do
      grid = LuaSkillCtrl:FindEmptyGridAroundRole(targetlist[i].targetRole)
      if grid ~= nil then
        return grid
      end
    end
  end
  grid = LuaSkillCtrl:CallFindEmptyGridNearest(self.caster)
  return grid
end

function bs_202203:OnAttackTrigger(data)
  local grid = self:FindEmptyGrid()
  if grid == nil then
    return
  end
  local target = LuaSkillCtrl:GetTargetWithGrid(grid.x, grid.y)
  LuaSkillCtrl:CallEffect(target, self.config.effectId2, self)
  local summoner = LuaSkillCtrl:CreateSummoner(self, self.config.monsterId, grid.x, grid.y)
  summoner:SetAttr(eHeroAttr.maxHp, self.caster.maxHp * self.arglist[2] // 1000)
  summoner:SetAttr(eHeroAttr.pow, self.caster.pow)
  summoner:SetAttr(eHeroAttr.speed, self.caster.speed)
  summoner:SetAttr(eHeroAttr.def, self.caster.def)
  summoner:SetAttr(eHeroAttr.skill_intensity, self.caster.skill_intensity)
  summoner:SetAttr(eHeroAttr.sunder, self.caster.sunder)
  summoner:SetAsRealEntity(1)
  local summonerEntity = LuaSkillCtrl:AddSummonerRole(summoner)
  if summonerEntity == nil then
    return
  end
  if self.summnerListSkill == nil then
    self.summnerListSkill = {}
  end
  table.insert(self.summnerListSkill, summonerEntity)
  if summonerEntity ~= nil then
    if self.summonerEffectSkill == nil then
      self.summonerEffectSkill = {}
    end
    if self.timenumSkill == nil then
      self.timenumSkill = {}
    end
    self.summonerEffectSkill[summonerEntity] = LuaSkillCtrl:CallEffect(summonerEntity, self.config.effectIdline, self, nil, nil, nil, false)
    local cb = BindCallback(self, self.CheckSummonerSkill, summonerEntity)
    self.timenumSkill[summonerEntity] = LuaSkillCtrl:StartTimer(nil, self.arglist[3], cb, nil, -1, 0)
    self.caster.recordTable.num = self.caster.recordTable.num + 1
  end
end

function bs_202203:CheckSummonerSkill(summonerEntity)
  if self.timenumSkill[summonerEntity] ~= nil and self.timenumSkill[summonerEntity]:IsOver() then
    self.timenumSkill[summonerEntity] = nil
  end
  if self.startCleanSkill then
    return
  end
  if summonerEntity.hp > 0 then
    local cusEffect = LuaSkillCtrl:CallEffect(self.caster, self.config.effectId3, self)
    local target2 = summonerEntity
    local collisionTrigger = BindCallback(self, self.OnCollision)
    LuaSkillCtrl:CallCircledEmissionStraightly(self, self.caster, target2, self.config.radius, self.config.speed, eColliderInfluenceType.Enemy, collisionTrigger, nil, nil, cusEffect, false, true, nil)
  else
    if self.summonerEffectSkill ~= nil then
      if self.summonerEffectSkill[summonerEntity] ~= nil then
        self.summonerEffectSkill[summonerEntity]:Die()
        self.summonerEffectSkill[summonerEntity] = nil
      end
      if self.timenumSkill[summonerEntity] ~= nil then
        self.timenumSkill[summonerEntity]:Stop()
        self.timenumSkill[summonerEntity] = nil
      end
    end
    if self.summnerListSkill ~= nil then
      table.removebyvalue(self.summnerListSkill, summonerEntity)
    end
    self.caster.recordTable.num = self.caster.recordTable.num - 1
  end
end

function bs_202203:OnCollision(collider, index, entity)
  LuaSkillCtrl:CallEffect(entity, self.config.effectId4, self)
  local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, entity)
  LuaSkillCtrl:PlayAuSource(entity, self.config.audioId2)
  LuaSkillCtrl:HurtResult(self, skillResult, self.config.HurtConfig)
  skillResult:EndResult()
end

function bs_202203:OnCasterDie()
  base.OnCasterDie(self)
  self.startCleanSkill = true
  if self.summnerListSkill ~= nil then
    for i = 1, #self.summnerListSkill do
      local summonerEntity = self.summnerListSkill[i]
      if self.summonerEffectSkill[summonerEntity] ~= nil then
        self.summonerEffectSkill[summonerEntity]:Die()
        self.summonerEffectSkill[summonerEntity] = nil
      end
      if self.timenumSkill[summonerEntity] ~= nil then
        self.timenumSkill[summonerEntity]:Stop()
        self.timenumSkill[summonerEntity] = nil
      end
    end
  end
  self.summnerListSkill = nil
  self.summonerEffectSkill = nil
  self.timenumSkill = nil
end

function bs_202203:LuaDispose()
  base.LuaDispose(self)
  self.summnerListSkill = nil
  self.summonerEffectSkill = nil
  self.timenumSkill = nil
end

return bs_202203
