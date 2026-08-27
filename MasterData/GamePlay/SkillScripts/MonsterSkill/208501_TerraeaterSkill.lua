local bs_208501 = class("bs_208501", LuaSkillBase)
local base = LuaSkillBase
bs_208501.config = {
  buffId_151 = 3019,
  skill_time = 38,
  skill_speed = 1,
  start_time = 13,
  end_time = 16,
  sum_time = 15,
  buffId_170 = 170,
  startAnimId = 1008,
  effectId_skill = 208501,
  effectId_hit = 208502,
  effectId_xs = 208506,
  monsterId = 52,
  maxHpPer = 50,
  powPer = 1000,
  hurtConfig = {
    hit_formula = 0,
    basehurt_formula = 3010,
    crit_formula = 0,
    crithur_ratio = 0
  }
}

function bs_208501:ctor()
end

function bs_208501:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterHurtTrigger("bs_208501_1", 1, self.OnAfterHurt, nil, nil, nil, self.caster.belongNum)
end

function bs_208501:PlaySkill(data)
  LuaSkillCtrl:CallBreakAllSkill(self.caster)
  local grid_dict = LuaSkillCtrl:FindEmptyGridsWithinRange(self.caster.x, self.caster.y, 10)
  if grid_dict ~= nil then
    LuaSkillCtrl:CallBreakAllSkill(self.caster)
    local attackTrigger = BindCallback(self, self.OnAttackTrigger, data)
    self:CallCasterWait(self.config.start_time + self.config.end_time + self.config.sum_time)
    LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, self.config.startAnimId, self.config.skill_speed, self.config.start_time, attackTrigger)
  end
end

function bs_208501:OnAttackTrigger(data)
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_170, 1, self.arglist[2])
  LuaSkillCtrl:StartShowSkillDurationTime(self, self.arglist[2])
  local targetrole
  local targetList = LuaSkillCtrl:CallTargetSelect(self, 10002, 20)
  if targetList ~= 0 then
    for i = 0, targetList.Count - 1 do
      if targetList[i].targetRole ~= nil and targetList[i].targetRole.belongNum ~= eBattleRoleBelong.neutral and not LuaSkillCtrl:RoleContainsBuffFeature(targetList[i].targetRole, eBuffFeatureType.CtrlImmunity) then
        targetrole = targetList[i].targetRole
        break
      end
    end
  end
  if targetrole ~= nil then
    LuaSkillCtrl:CallEffect(targetrole, self.config.effectId_hit, self)
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, targetrole)
    LuaSkillCtrl:HurtResult(self, skillResult, self.config.hurt_config, {
      self.arglist[1]
    })
    skillResult:EndResult()
    local grid = LuaSkillCtrl:GetGridWithRole(targetrole)
    local target_grid = LuaSkillCtrl:GetTargetWithGrid(grid.x, grid.y)
    local grid_t
    local grid_dict = LuaSkillCtrl:FindEmptyGridsWithinRange(self.caster.x, self.caster.y, 10)
    if grid_dict ~= nil or 1 <= grid_dict.Count then
      local minDis = 99
      for i = 0, grid_dict.Count - 1 do
        local grid1 = grid_dict[i]
        if grid1 ~= grid then
          local dis1 = LuaSkillCtrl:GetGridsDistance(grid1.x, grid1.y, self.caster.x, self.caster.y)
          if minDis > dis1 then
            minDis = dis1
            grid_t = grid1
          end
        end
      end
    end
    if self.eff_skill ~= nil then
      self.eff_skill:Die()
      self.eff_skill = nil
    end
    LuaSkillCtrl:CallPhaseMoveWithoutTurnAndAllowCcd(self, targetrole, grid_t.x, grid_t.y, 7, 3020, 1, true)
    self:summoner(grid)
    LuaSkillCtrl:StartTimer(self, self.config.sum_time, function()
      LuaSkillCtrl:CallRoleAction(self.caster, 1009)
    end)
  else
    LuaSkillCtrl:StartTimer(self, self.config.sum_time, function()
      LuaSkillCtrl:CallRoleAction(self.caster, 1009)
    end)
    return
  end
end

function bs_208501:summoner(grid)
  if self.summonerEntity ~= nil then
    return
  end
  local x = grid.x
  local y = grid.y
  local target = LuaSkillCtrl:GetTargetWithGrid(grid.x, grid.y)
  local summoner = LuaSkillCtrl:CreateSummoner(self, self.config.monsterId, x, y)
  summoner:SetAttr(eHeroAttr.maxHp, self.caster.maxHp * self.arglist[3] // 1000)
  summoner:SetAttr(eHeroAttr.def, self.caster.def * self.arglist[4] // 1000)
  summoner:SetAttr(eHeroAttr.magic_res, self.caster.magic_res * self.arglist[4] // 1000)
  summoner:SetAsRealEntity(1)
  self.summonerEntity = LuaSkillCtrl:AddSummonerRole(summoner)
  if self.summonerEntity == nil then
    return
  end
  self.eff_skill = LuaSkillCtrl:CallEffect(self.summonerEntity, self.config.effectId_skill, self)
  LuaSkillCtrl:CallRoleAction(self.summonerEntity, 1008)
  LuaSkillCtrl:StartTimer(nil, self.arglist[2], function(entity)
    if entity == nil or entity.hp <= 0 then
      return
    end
    LuaSkillCtrl:RemoveLife(entity.maxHp + 1, self, entity, true, nil, false, true, eHurtType.RealDmg)
    LuaSkillCtrl:CallRoleAction(entity, 1009)
    if self.eff_skill ~= nil then
      self.eff_skill:Die()
      self.eff_skill = nil
    end
    LuaSkillCtrl:CallEffect(entity, self.config.effectId_xs, self)
    self.summonerEntity = nil
  end, self.summonerEntity)
end

function bs_208501:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if target == self.summonerEntity and target.hp >= 0 then
    local hurtNum = hurt
    LuaSkillCtrl:RemoveLife(hurtNum, self, self.caster, false, nil, true, false)
    if target.hp <= 0 then
      LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId_170, 0)
      LuaSkillCtrl:StopShowSkillDurationTime(self)
      if self.eff_skill ~= nil then
        self.eff_skill:Die()
        self.eff_skill = nil
      end
      if self.summonerEntity ~= nil then
        LuaSkillCtrl:CallEffect(self.summonerEntity, self.config.effectId_xs, self)
        self.summonerEntity = nil
      end
    end
  end
end

function bs_208501:OnCasterDie()
  base.OnCasterDie(self)
  if self.summonerEntity ~= nil then
    LuaSkillCtrl:RemoveLife(self.summonerEntity.maxHp + 1, self, self.summonerEntity, true, nil, false, true, eHurtType.RealDmg)
    self.summonerEntity = nil
  end
  if self.eff_skill ~= nil then
    self.eff_skill:Die()
    self.eff_skill = nil
  end
end

function bs_208501:LuaDispose()
  base.LuaDispose(self)
  self.summonerEntity = nil
  if self.eff_skill ~= nil then
    self.eff_skill:Die()
    self.eff_skill = nil
  end
end

return bs_208501
