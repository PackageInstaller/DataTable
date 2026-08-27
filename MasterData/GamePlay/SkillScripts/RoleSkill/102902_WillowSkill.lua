local bs_102902 = class("bs_102902", LuaSkillBase)
local base = LuaSkillBase
bs_102902.config = {
  effectId_start = 102903,
  effectId_grid = 102904,
  effectId_hit = 102905,
  buffId_115 = 3012,
  actionId = 1002,
  skill_time = 17,
  start_time = 7,
  skill_speed = 1.5,
  hurtConfig = {
    hit_formula = 0,
    basehurt_formula = 10077,
    crit_formula = 0,
    crithur_ratio = 0
  },
  audioId1 = 102904,
  weaponLv = 0,
  buffIdInjury = 102902,
  effectId_grid_01 = 102912
}

function bs_102902:ctor()
end

function bs_102902:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_102902:PlaySkill(data)
  local belongNum = 2
  local grid = LuaSkillCtrl:CallFindGridMostRolesArounded(belongNum)
  if grid ~= nil then
    local target = LuaSkillCtrl:GetTargetWithGrid(grid.x, grid.y)
    local skilltime = self.config.skill_time * 100 // (self.config.skill_speed * 100)
    local starttime = self.config.start_time * 100 // (self.config.skill_speed * 100)
    self.caster:LookAtTarget(target)
    self:CallCasterWait(skilltime)
    local roles, roles_2
    if self.config.weaponLv >= 1 then
      roles = LuaSkillCtrl:FindAllRolesWithinRange(target, 2, true)
    else
      roles = LuaSkillCtrl:FindRolesAroundGrid(grid, belongNum)
      roles_2 = LuaSkillCtrl:FindRolesAroundGrid(grid, 0)
    end
    local triggerCallBack = BindCallback(self, self.OnActionCallBack, target, roles, roles_2)
    LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, self.config.actionId, self.config.skill_speed, starttime, triggerCallBack)
    LuaSkillCtrl:CallEffect(target, self.config.effectId_start, self, nil, nil, nil, true)
    if self.config.weaponLv >= 1 then
      LuaSkillCtrl:CallEffect(target, self.config.effectId_grid_01, self, nil, nil, nil, true)
    else
      LuaSkillCtrl:CallEffect(target, self.config.effectId_grid, self, nil, nil, nil, true)
    end
    LuaSkillCtrl:PlayAuSource(self.caster, self.config.audioId1)
  end
end

function bs_102902:OnActionCallBack(target, roles, roles_2)
  if roles ~= nil and roles.Count > 0 then
    for i = 0, roles.Count - 1 do
      if roles[i] ~= nil and 0 < roles[i].hp and roles[i].belongNum == eBattleRoleBelong.enemy then
        local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, roles[i])
        LuaSkillCtrl:HurtResult(self, skillResult, self.config.hurtConfig)
        skillResult:EndResult()
        LuaSkillCtrl:CallBuff(self, roles[i], self.config.buffId_115, 1, self.arglist[1], false)
        if 1 <= self.config.weaponLv then
          LuaSkillCtrl:CallBuff(self, roles[i], self.config.buffIdInjury, 1, self.arglist[1], false)
        end
        LuaSkillCtrl:CallEffect(roles[i], self.config.effectId_hit, self)
      end
    end
  end
  if roles_2 ~= nil and roles_2.Count > 0 then
    for i = 0, roles_2.Count - 1 do
      if roles_2[i] ~= nil and 0 < roles_2[i].hp and roles_2[i].belongNum == eBattleRoleBelong.enemy then
        local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, roles_2[i])
        LuaSkillCtrl:HurtResult(self, skillResult, self.config.hurtConfig)
        skillResult:EndResult()
        LuaSkillCtrl:CallEffect(roles_2[i], self.config.effectId_hit, self)
      end
    end
  end
  self:OnSkillDamageEnd()
end

function bs_102902:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_102902
