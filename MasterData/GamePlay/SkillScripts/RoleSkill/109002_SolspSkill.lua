local bs_109002 = class("bs_109002", LuaSkillBase)
local base = LuaSkillBase
bs_109002.config = {
  skill_time = 25,
  actionId_start = 1008,
  actionId_end = 1009,
  action_speed = 1,
  start_time = 9,
  action_end_time = 9,
  effect_cast = 109006,
  effectId_show = 109007,
  effectId_hit1 = 109008,
  effectId_hit2 = 109009,
  buffid1 = 109004,
  buffId = 107101,
  HurtConfigID = 39
}

function bs_109002:ctor()
end

function bs_109002:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_109002:PlaySkill(data)
  local target
  local targets = LuaSkillCtrl:CallTargetSelect(self, 7, 10)
  for i = 0, targets.Count - 1 do
    local role = targets[i].targetRole
    if not LuaSkillCtrl:IsObstacle(role) then
      target = role
      break
    end
  end
  if target == nil then
    LuaSkillCtrl:SetResetCdByReturnConfigOnce(self)
    return
  end
  LuaSkillCtrl:CallEffect(self.caster, self.config.effect_cast, self)
  local attackTrigger = BindCallback(self, self.OnAttackTrigger, target)
  self.caster:LookAtTarget(target)
  local skilltime = self.config.skill_time
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffid1, 1, self.config.skill_time, true)
  self:CallCasterWait(skilltime)
  LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, self.config.actionId_start, self.config.action_speed, self.config.start_time, attackTrigger)
end

function bs_109002:OnAttackTrigger(target)
  if target ~= nil then
    local Grid = LuaSkillCtrl:CallFindEmptyGridNearest(target)
    local Grid_target = LuaSkillCtrl:GetGridWithRole(target)
    if Grid == nil then
      Grid = LuaSkillCtrl:GetGridWithRole(self.caster)
    elseif LuaSkillCtrl:GetGridsDistance(Grid.x, Grid.y, Grid_target.x, Grid_target.y) ~= 1 then
      Grid = LuaSkillCtrl:GetGridWithRole(self.caster)
    end
    self:DoDamage1(target)
    LuaSkillCtrl:SetRolePos(Grid, self.caster)
  end
  LuaSkillCtrl:CallRoleAction(self.caster, self.config.actionId_end, 1)
  LuaSkillCtrl:StartTimer(nil, self.config.action_end_time, function()
    if target ~= nil then
      local tarGrid = LuaSkillCtrl:GetGridWithRole(target)
      LuaSkillCtrl:StartTimer(nil, 8, function()
        self:DoDamage2(tarGrid, target)
      end, nil, 0, 0)
    end
  end, nil)
end

function bs_109002:DoDamage1(target)
  local originAttrList = target.originAttrList
  local origin_maxHp = originAttrList[eHeroAttr.maxHp]
  local now_maxHp = target._curHp
  local damageUp = 0
  if now_maxHp <= origin_maxHp * self.arglist[5] // 1000 then
    if self.caster.recordTable.energy_num >= self.arglist[7] then
      self.caster.recordTable.energy_num = self.arglist[7]
    end
    damageUp = self.arglist[6] * self.caster.recordTable.energy_num
  end
  for i = 0, self.arglist[2] - 1 do
    LuaSkillCtrl:CallBuff(self, target, self.config.buffId, 1, 120)
  end
  LuaSkillCtrl:CallEffect(target, self.config.effectId_hit1, self, nil, nil, nil, true)
  local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target)
  LuaSkillCtrl:HurtResultWithConfig(self, skillResult, self.config.HurtConfigID, {
    self.arglist[1] + damageUp
  })
  skillResult:EndResult()
  self.caster.recordTable.energy_num = 0
end

function bs_109002:DoDamage2(tarGrid, target)
  LuaSkillCtrl:CallEffect(target, self.config.effectId_hit2, self, nil, nil, nil, true)
  local targetlist = LuaSkillCtrl:FindRolesAroundGrid(tarGrid, 2)
  if targetlist ~= nil and targetlist.Count > 0 then
    for i = targetlist.Count - 1, 0, -1 do
      local role = targetlist[i]
      if role.belongNum ~= eBattleRoleBelong.player then
        local originAttrList = role.originAttrList
        local origin_maxHp = originAttrList[eHeroAttr.maxHp]
        local now_maxHp = role._curHp
        local damageUp = 0
        LuaSkillCtrl:CallBuff(self, role, self.config.buffId, self.arglist[4], 120)
        local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, role)
        LuaSkillCtrl:HurtResultWithConfig(self, skillResult, self.config.HurtConfigID, {
          self.arglist[3]
        })
        skillResult:EndResult()
      end
    end
  end
  LuaSkillCtrl:CallEffect(self.caster, self.config.effectId_show, self)
  self:OnSkillDamageEnd()
end

function bs_109002:LuaDispose()
  base.LuaDispose(self)
end

function bs_109002:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_109002
