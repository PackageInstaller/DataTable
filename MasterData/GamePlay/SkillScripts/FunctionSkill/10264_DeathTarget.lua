local bs_10264 = class("bs_10264", LuaSkillBase)
local base = LuaSkillBase
bs_10264.config = {
  buffId = 243,
  effectId1 = 10880,
  hurtConfig = {
    hit_formula = 0,
    basehurt_formula = 10031,
    crit_formula = 0,
    crithur_ratio = 0
  }
}

function bs_10264:ctor()
end

function bs_10264:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.RoleDie, "bs_10264_10", 1, self.OnRoleDie)
end

function bs_10264:OnRoleDie(killer, role)
  if killer == self.caster then
    local timeCallBack = BindCallback(self, self.TimeUp)
    if self.timer == nil then
      self.timer = LuaSkillCtrl:StartTimer(nil, 10, timeCallBack)
    end
  end
end

function bs_10264:TimeUp()
  if self.timer ~= nil and self.timer:IsOver() then
    self.timer = nil
  end
  local targetlist = LuaSkillCtrl:CallTargetSelect(self, 45, 10)
  if targetlist.Count < 1 then
    return
  end
  local target = targetlist[0].targetRole
  if target == nil then
    return
  end
  local grid = LuaSkillCtrl:FindEmptyGridWithinRange(target, 1)
  if grid == nil then
    return
  end
  LuaSkillCtrl:CallEffect(target, self.config.effectId1, self)
  if not LuaSkillCtrl:IsRoleAdjacent(self.caster, target) then
    LuaSkillCtrl:CallEffect(self.caster, 10263, self)
    LuaSkillCtrl:SetRolePos(grid, self.caster)
    LuaSkillCtrl:CallEffect(self.caster, 10264, self)
  end
  self.caster:LookAtTarget(target)
  self.caster.recordTable.lastAttackRole = target
  local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target)
  LuaSkillCtrl:HurtResult(self, skillResult, self.config.hurtConfig, nil, true)
  skillResult:EndResult()
  self:PlayChipEffect()
  self.timer = nil
end

function bs_10264:OnCasterDie()
  base.OnCasterDie(self)
  if self.timer ~= nil then
    self.timer:Stop()
    self.timer = nil
  end
end

return bs_10264
