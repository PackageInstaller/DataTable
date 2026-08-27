local bs_202201 = class("bs_202201", LuaSkillBase)
local base = LuaSkillBase
bs_202201.config = {
  effectIdline = 10430,
  effectId1 = 10428,
  effectId2 = 10429,
  effectId3 = 102506,
  effectId4 = 10432,
  monsterId = 11,
  HurtConfig = {
    def_formula = 9996,
    basehurt_formula = 10086,
    minhurt_formula = 9994,
    crithur_ratio = 9995,
    correct_formula = 9989,
    lifesteal_formula = 1001,
    spell_lifesteal_formula = 1002,
    returndamage_formula = 1000,
    hit_formula = 0,
    crit_formula = 0
  },
  select_id = 42,
  select_range = 10,
  calFormula = 10006,
  maxNum = 5,
  skill_time = 30,
  start_time = 18,
  startAnimId = 1002,
  radius = 10,
  speed = 5
}

function bs_202201:ctor()
end

function bs_202201:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterHurtTrigger("bs_202201_3", 1, self.OnAfterHurt, nil, self.caster)
  self.caster.recordTable.hurt = 0
  self.summonerEffect = {}
  self.timenum = {}
  self.summnerList = {}
  self.startClean = false
  self.caster.recordTable.num = 0
end

function bs_202201:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if target == self.caster and sender ~= self.caster and self.caster.recordTable.num < self.config.maxNum then
    self.caster.recordTable.hurt = self.caster.recordTable.hurt + hurt
    local hurt_num = LuaSkillCtrl:CallFormulaNumberWithSkill(self.config.calFormula, self.caster, sender, self)
    if hurt_num <= self.caster.recordTable.hurt then
      self.caster.recordTable.hurt = 0
      local grid
      local targetlist = LuaSkillCtrl:CallTargetSelect(self, self.config.select_id, self.config.select_range)
      if 0 < targetlist.Count then
        for i = 0, targetlist.Count - 1 do
          grid = LuaSkillCtrl:FindEmptyGridAroundRole(targetlist[i].targetRole)
          if grid ~= nil then
            break
          end
        end
      end
      if grid == nil then
        grid = LuaSkillCtrl:CallFindEmptyGridNearest(self.caster)
      end
      if grid == nil then
        return
      end
      if grid ~= nil then
        LuaSkillCtrl:CallBreakAllSkill(self.caster)
        local attackTrigger = BindCallback(self, self.OnAttackTrigger, grid)
        self:CallCasterWait(self.config.skill_time)
        LuaSkillCtrl:CallRoleAction(self.caster, self.config.startAnimId)
        LuaSkillCtrl:StartTimer(self, self.config.start_time, attackTrigger)
        LuaSkillCtrl:CallEffect(self.caster, self.config.effectId1, self, nil, nil, nil, true)
      end
    end
  end
end

function bs_202201:OnAttackTrigger(grid)
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
  table.insert(self.summnerList, summonerEntity)
  if summonerEntity ~= nil then
    self.summonerEffect[summonerEntity] = LuaSkillCtrl:CallEffect(summonerEntity, self.config.effectIdline, self, nil, nil, nil, false)
    local cb = BindCallback(self, self.CheckSummoner, summonerEntity)
    self.timenum[summonerEntity] = LuaSkillCtrl:StartTimer(nil, self.arglist[3], cb, nil, -1, 0)
    self.caster.recordTable.num = self.caster.recordTable.num + 1
  end
end

function bs_202201:CheckSummoner(summonerEntity)
  if self.timenum[summonerEntity] ~= nil and self.timenum[summonerEntity]:IsOver() then
    self.timenum[summonerEntity] = nil
  end
  if self.startClean then
    return
  end
  if summonerEntity.hp > 0 then
    local cusEffect = LuaSkillCtrl:CallEffect(self.caster, self.config.effectId3, self)
    local target2 = summonerEntity
    local collisionTrigger = BindCallback(self, self.OnCollision)
    self.skillEmission = LuaSkillCtrl:CallCircledEmissionStraightly(self, self.caster, target2, self.config.radius, self.config.speed, eColliderInfluenceType.Enemy, collisionTrigger, nil, nil, cusEffect, false, true, nil)
  else
    if self.summonerEffect ~= nil then
      if self.summonerEffect[summonerEntity] ~= nil then
        self.summonerEffect[summonerEntity]:Die()
        self.summonerEffect[summonerEntity] = nil
      end
      if self.timenum[summonerEntity] ~= nil then
        self.timenum[summonerEntity]:Stop()
        self.timenum[summonerEntity] = nil
      end
    end
    table.removebyvalue(self.summnerList, summonerEntity)
    self.caster.recordTable.num = self.caster.recordTable.num - 1
  end
end

function bs_202201:OnCollision(collider, index, entity)
  local num = self.caster.recordTable.hope_hurt
  LuaSkillCtrl:CallEffect(entity, self.config.effectId4, self)
  local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, entity)
  LuaSkillCtrl:PlayAuHit(self, entity)
  LuaSkillCtrl:HurtResult(self, skillResult, self.config.HurtConfig, {num})
  skillResult:EndResult()
end

function bs_202201:OnCasterDie()
  base.OnCasterDie(self)
  self.startClean = true
  if self.summnerList ~= nil then
    for i = 1, #self.summnerList do
      local summonerEntity = self.summnerList[i]
      if self.summonerEffect[summonerEntity] ~= nil then
        self.summonerEffect[summonerEntity]:Die()
        self.summonerEffect[summonerEntity] = nil
      end
      if self.timenum[summonerEntity] ~= nil then
        self.timenum[summonerEntity]:Stop()
        self.timenum[summonerEntity] = nil
      end
    end
  end
  self.summnerList = nil
  self.summonerEffect = nil
  self.timenum = nil
end

function bs_202201:LuaDispose()
  base.LuaDispose(self)
  self.summnerList = nil
  self.summonerEffect = nil
  self.timenum = nil
end

return bs_202201
