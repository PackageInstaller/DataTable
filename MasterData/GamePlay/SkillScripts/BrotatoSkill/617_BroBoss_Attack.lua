local bs_617 = class("bs_617", LuaSkillBase)
local base = LuaSkillBase
bs_617.config = {
  effectId_skill = 60403,
  Hurt_config = {
    hit_formula = 0,
    basehurt_formula = 502,
    crit_formula = 0,
    returndamage_formula = 0
  },
  actionId_start = 1022,
  actionId_loop = 1023,
  actionId_end = 100,
  buffIdBro = 60401,
  action_speed = 1,
  effectPick = 61701,
  passive_select_id = 9,
  passive_select_range = 0,
  Time = 30,
  skill_time = 20,
  radius = 10,
  spd = 1,
  effectId_w = 60402
}

function bs_617:ctor()
end

function bs_617:InitSkill(isMidwaySkill)
end

function bs_617:PlaySkill(data)
  local moveTarget = self:GetMoveSelectTarget()
  if moveTarget ~= nil then
    local curAtkRole = moveTarget.targetRole
    if curAtkRole ~= nil then
      if self.lastAttackRole ~= curAtkRole then
        self.displaySelectEfc = true
      end
      self.lastAttackRole = curAtkRole
    end
  end
  if self.caster.recordTable.life_num ~= nil then
    local targetlist = LuaSkillCtrl:CallTargetSelect(self, self.config.passive_select_id, self.config.passive_select_range)
    if targetlist.Count > 0 then
      self.life_num = self.caster.recordTable.life_num * targetlist.Count
    end
  else
    self.life_num = 0
  end
  if moveTarget ~= nil then
    self:CallCasterWait(self.config.skill_time)
    local role = moveTarget.targetRole
    self.caster:LookAtTarget(role)
    local Targetgrid = LuaSkillCtrl:GetTargetWithGrid(role.x, role.y)
    LuaSkillCtrl:CallRoleAction(self.caster, self.config.actionId_start, self.config.action_speed)
    LuaSkillCtrl:CallEffect(Targetgrid, self.config.effectPick, self)
    self:DamageAnimation(Targetgrid)
  end
end

function bs_617:DamageAnimation(target)
  LuaSkillCtrl:CallEffect(self.caster, self.config.effectId_w, self)
  local grid = LuaSkillCtrl:GetGridWithPos(target.x, target.y)
  if grid ~= nil then
    self.hurtTime = LuaSkillCtrl:StartTimer(nil, self.config.Time, function()
      LuaSkillCtrl:CallCreateEfcGrid(grid.coord.x, grid.coord.y, 1129)
    end, self, 0)
  end
end

function bs_617:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_617
