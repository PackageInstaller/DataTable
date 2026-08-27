local bs_108803 = class("bs_108803", LuaSkillBase)
local base = LuaSkillBase
bs_108803.config = {
  configId = 17,
  actionId = 1010,
  action_speed = 1,
  effectId_cast = 108811,
  effectId_trail = 108812,
  audioIdStart = 108811,
  audioIdMovie = 108812,
  audioIdEnd = 108813
}

function bs_108803:ctor()
end

function bs_108803:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_108803:PlaySkill(data)
  self:CallCasterWait(13)
  local shoot = BindCallback(self, self.ShootWave)
  self.onLoopAttack = LuaSkillCtrl:StartTimer(self, 6, shoot, self, 2, 6)
end

function bs_108803:ShootWave()
  local target
  local targets = LuaSkillCtrl:CallTargetSelect(self, 42, 10)
  for i = 0, targets.Count - 1 do
    local role = targets[i].targetRole
    if not LuaSkillCtrl:IsObstacle(role) then
      target = role
      break
    end
  end
  if target == nil or 0 >= target.hp then
    return
  end
  LuaSkillCtrl:CallRoleAction(self.caster, self.config.actionId, self.config.action_speed)
  self.caster:LookAtTarget(target)
  local grid = LuaSkillCtrl:GetTargetWithGrid(target.x, target.y)
  if grid == nil then
    return
  end
  LuaSkillCtrl:CallEffect(target, self.config.effectId_trail, self)
  local gridPos = grid:GetLogicPos()
  local shootDir = CS.TrueSync.TSVector3.Subtract(gridPos, self.caster.lsObject.localPosition).normalized
  local shootDir2D = CS.TrueSync.TSVector2(shootDir.x, shootDir.z)
  local OnCollition = BindCallback(self, self.OnCollision, shootDir2D)
  LuaSkillCtrl:CallCircledEmissionStraightly(self, self.caster, grid, 30, 7, 2, OnCollition, nil, nil, nil, true, true)
end

function bs_108803:OnCollision(shootDir2d, collider, index, entity)
  if self.caster == nil or self.caster.hp <= 0 or entity == nil or entity.hp <= 0 then
    return
  end
  local bornPos = self.caster.lsObject.localPosition
  if not entity.lsObject.localPosition:Equals(bornPos) then
    local tsVec2 = CS.TrueSync.TSVector2
    local curDir = CS.TrueSync.TSVector3.Subtract(entity.lsObject.localPosition, bornPos)
    local curDir2d = tsVec2(curDir.x, curDir.z).normalized
    local angle = LuaSkillCtrl:CallTSVec2Angle(curDir2d, shootDir2d)
    if 100 < angle or angle < -100 then
      return
    end
  end
  if entity.belongNum ~= self.caster.belongNum and not LuaSkillCtrl:IsFixedObstacle(entity) then
    self:HurtEnermy(entity)
  end
end

function bs_108803:HurtEnermy(target)
  local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target)
  LuaSkillCtrl:HurtResultWithConfig(self, skillResult, self.config.configId, {
    self.arglist[1]
  })
  skillResult:EndResult()
end

function bs_108803:OnUltRoleAction()
  base.OnUltRoleAction(self)
  LuaSkillCtrl:StartTimerInUlt(self, 7, self.PlayUltMovie)
  LuaSkillCtrl:CallRoleAction(self.caster, 1005)
end

function bs_108803:OnMovieFadeOut()
  base.OnMovieFadeOut(self)
end

function bs_108803:PlayUltEffect()
  base.PlayUltEffect(self)
  LuaSkillCtrl:CallBuff(self, self.caster, 196, 1, 30, true)
  LuaSkillCtrl:CallFocusTimeLine(self.caster)
end

function bs_108803:OnSkipUltView()
  base.OnSkipUltView(self)
end

function bs_108803:OnCasterDie()
  base.OnCasterDie(self)
end

function bs_108803:LuaDispose()
  base.LuaDispose(self)
end

return bs_108803
