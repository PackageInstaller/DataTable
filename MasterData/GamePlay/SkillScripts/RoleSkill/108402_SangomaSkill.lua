local bs_108402 = class("bs_108402", LuaSkillBase)
local base = LuaSkillBase
bs_108402.config = {
  start_time = 15,
  actionId = 1002,
  action_speed = 1,
  buffSpeed = 108405,
  buffDot = 108406,
  selectId = 9,
  HurtConfigId = 25,
  selectId = 9,
  buffId_3024 = 3024,
  buffId_198 = 198,
  buffAtkUp = 108401,
  effectSX = 108413,
  effect1 = 108414,
  effect2 = 108415,
  effect3 = 108416
}

function bs_108402:ctor()
end

function bs_108402:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddSetHurtTriggerForTable("bs_208802_1", 1, self.OnSetHurt, {
    extraArg1 = eSkillTag.commonAttack,
    sender = self.caster,
    targetBelongNum = eBattleRoleBelong.enemy,
    extraArg2 = false,
    extraArg3 = false
  })
  self.caster.recordTable.attackArg = self.arglist[8]
end

function bs_108402:PlaySkill(data)
  local grid = LuaSkillCtrl:CallFindEmptyGridMostRolesArounded(2)
  if grid ~= nil then
    local gridNow = LuaSkillCtrl:GetGridWithRole(self.caster)
    local selfAroundList = LuaSkillCtrl:FindRolesAroundGrid(gridNow, 2)
    local targetAroundList = LuaSkillCtrl:FindRolesAroundGrid(grid, 2)
    if selfAroundList ~= nil and targetAroundList ~= nil and targetAroundList.Count < selfAroundList.Count then
      grid = LuaSkillCtrl:GetGridWithRole(self.caster)
    end
  end
  if grid == nil then
    local selfAroundList = LuaSkillCtrl:CallTargetSelectWithRange(self, self.config.selectId, 1)
    if selfAroundList ~= nil then
      grid = LuaSkillCtrl:GetGridWithRole(self.caster)
    else
      LuaSkillCtrl:SetResetCdByReturnConfigOnce(self)
      return
    end
  end
  LuaSkillCtrl:CallEffect(self.caster, self.config.effectSX, self)
  LuaSkillCtrl:SetRolePos(grid, self.caster)
  local time = self.config.start_time
  self:CallCasterWait(time)
  local attackTrigger = BindCallback(self, self.OnAttackTrigger)
  local tier = self.caster:GetBuffTier(self.config.buffAtkUp)
  if 40 <= tier then
    self.effect = LuaSkillCtrl:CallEffect(self.caster, self.config.effect3, self)
  elseif 20 <= tier then
    self.effect = LuaSkillCtrl:CallEffect(self.caster, self.config.effect2, self)
  else
    self.effect = LuaSkillCtrl:CallEffect(self.caster, self.config.effect1, self)
  end
  LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, self.config.actionId, self.config.action_speed, self.config.start_time, attackTrigger)
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_3024, 1, self.config.start_time + self.arglist[5], true)
end

function bs_108402:OnAttackTrigger(data)
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffSpeed, 1, self.arglist[5])
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_198, 1, self.arglist[5])
  local tarList = LuaSkillCtrl:CallTargetSelectWithRange(self, self.config.selectId, 1)
  for i = tarList.Count - 1, 0, -1 do
    if tarList[i].targetRole.belongNum == eBattleRoleBelong.neutral then
      tarList:RemoveAt(i)
    end
  end
  for i = 0, tarList.Count - 1 do
    local target = tarList[i].targetRole
    LuaSkillCtrl:CallBuffRepeated(self, target, self.config.buffDot, 1, self.arglist[3], false, false, self.OnBuffExecute)
  end
  LuaSkillCtrl:StartTimer(self, self.arglist[5], function()
    self:OnSkillDamageEnd()
  end)
end

function bs_108402:OnBuffExecute(buff, targetRole)
  local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, targetRole)
  LuaSkillCtrl:HurtResultWithConfig(self, skillResult, self.config.HurtConfigId, {
    self.arglist[2]
  })
  skillResult:EndResult()
end

function bs_108402:OnSetHurt(context)
  if self.caster:GetBuffTier(self.config.buffSpeed) > 0 then
    local tarList = LuaSkillCtrl:CallTargetSelectWithRange(self, self.config.selectId, 1)
    for i = tarList.Count - 1, 0, -1 do
      if tarList[i].targetRole.belongNum == eBattleRoleBelong.neutral then
        tarList:RemoveAt(i)
      end
    end
    if tarList.Count == 1 then
      self.solo = true
    end
  end
  if self.solo then
    local tier = self.caster:GetBuffTier(self.config.buffAtkUp)
    context.hurt = context.hurt * (1000 + self.arglist[7] * tier) // 1000
    self.solo = false
  end
end

function bs_108402:OnBreakSkill(role)
  if self.effect ~= nil then
    self.effect:Die()
    self.effect = nil
  end
  base.OnBreakSkill(self, role)
  LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId_3024, 0, true)
end

function bs_108402:OnCasterDie()
  if self.effect ~= nil then
    self.effect:Die()
    self.effect = nil
  end
  base.OnCasterDie(self)
end

function bs_108402:LuaDispose()
  self.effect = nil
  base.LuaDispose(self)
end

return bs_108402
