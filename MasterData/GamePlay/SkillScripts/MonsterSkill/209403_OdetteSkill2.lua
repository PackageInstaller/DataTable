local bs_209403 = class("bs_209403", LuaSkillBase)
local base = LuaSkillBase
bs_209403.config = {
  effectId_trail = 209410,
  effectId_hit = 209411,
  effectId_xuli = 209409,
  actionId = 1020,
  act_speed = 1,
  start_time = 19,
  skill_time = 56,
  configId = 3,
  buffId = 1257
}

function bs_209403:ctor()
end

function bs_209403:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self.effectGrid = {}
end

function bs_209403:PlaySkill(data)
  self:OnSkillTake()
  LuaSkillCtrl:CallBreakAllSkill(self.caster)
  self:CallCasterWait(self.config.skill_time)
  LuaSkillCtrl:CallBuff(self, self.caster, 170, 1, self.config.skill_time, true)
  LuaSkillCtrl:CallEffect(self.caster, self.config.effectId_xuli, self)
  local skillTrigger = BindCallback(self, self.OnSkillTrigger)
  LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, self.config.actionId, self.config.act_speed, self.config.start_time, skillTrigger)
  local callnextskill = BindCallback(self, self.EndSkillAndCallNext)
  LuaSkillCtrl:StartTimer(nil, self.config.skill_time, callnextskill)
  self:AbandonSkillCdAutoReset(true)
end

function bs_209403:OnSkillTrigger()
  local target
  local targets = LuaSkillCtrl:CallTargetSelect(self, 48, 10)
  if targets.Count > 0 then
    for i = 0, targets.Count - 1 do
      if targets[i].targetRole:GetBuffTier(self.config.buffId) == 0 then
        target = targets[i].targetRole
        break
      end
    end
  end
  if target == nil then
    local randTarget = LuaSkillCtrl:CallTargetSelect(self, 19, 10)
    if randTarget == nil or randTarget.Count == 0 then
      return
    end
    target = randTarget[0].targetRole
  end
  self.caster:LookAtTarget(target)
  local grid = LuaSkillCtrl:GetTargetWithGrid(target.x, target.y)
  local effect_zd = LuaSkillCtrl:CallEffect(target, self.config.effectId_hit, self)
  local gridPos = grid:GetLogicPos()
  local shootDir = CS.TrueSync.TSVector3.Subtract(gridPos, self.caster.lsObject.localPosition).normalized
  local shootDir2D = CS.TrueSync.TSVector2(shootDir.x, shootDir.z)
  local OnCollition = BindCallback(self, self.OnCollision, shootDir2D)
  local skillEmission = LuaSkillCtrl:CallCircledEmissionStraightly(self, target, self.caster, 25, 3, 4, OnCollition, nil, nil, effect_zd, true, true)
  if self.timer ~= nil then
    self.timer:Stop()
    self.timer = nil
  end
  local cusEffect1 = LuaSkillCtrl:CallEffectWithEmission(skillEmission, self.config.effectId_trail, self, nil, self.caster, 1, true)
  self.timer = LuaSkillCtrl:StartTimer(nil, 3, BindCallback(self, self.findGrid, skillEmission.collider, target, effect_zd), nil, -1, 3)
end

function bs_209403:findGrid(collider, target, effect)
  if effect == nil or effect:IsDie() or collider == nil then
    self.timer:Stop()
    self.timer = nil
    return
  end
  if collider ~= nil then
    local pos = collider.coliderPos
    local grids = LuaSkillCtrl:FindAllGridsWithUnityRange(pos, collider.colliderRadius:AsFloat())
    if grids ~= nil then
      for k, v in pairs(grids) do
        if self.effectGrid[v] == nil then
          LuaSkillCtrl:CallCreateEfcGrid(v.coord.x, v.coord.y, 1125)
          self.effectGrid[v] = true
        end
      end
    end
  end
end

function bs_209403:OnCollision(shootDir2d, collider, index, entity)
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

function bs_209403:HurtEnermy(target)
  local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target)
  LuaSkillCtrl:HurtResultWithConfig(self, skillResult, self.config.configId, {
    self.arglist[1]
  })
  skillResult:EndResult()
end

function bs_209403:EndSkillAndCallNext()
  if self.caster == nil then
    return
  end
  local skillMgr = self.caster:GetSkillComponent()
  if skillMgr == nil then
    return
  end
  skillMgr.lastSkill = self.cskill
  self:CancleCasterWait()
  self.caster:CallUnFreezeNextSkill()
end

function bs_209403:OnCasterDie()
  base.OnCasterDie(self)
end

function bs_209403:LuaDispose()
  base.LuaDispose(self)
  self.effectGrid = nil
end

return bs_209403
