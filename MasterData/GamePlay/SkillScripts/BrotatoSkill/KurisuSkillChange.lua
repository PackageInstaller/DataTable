local KurisuSkillChange = {}
KurisuSkillChange.config = {
  actionId = 1002,
  actionId_start_time = 5,
  action_speed = 1,
  skill_time = 15,
  buffid_counter = 107801,
  hurt_config = 35,
  effectId_wave = 107834,
  effectId_hit = 107835,
  delayKillEffect = 3,
  buffFeature_ignoreDie = 6
}

function KurisuSkillChange:PlaySkill(data)
  if self.caster.recordTable.Kurisu_Mode == 3 then
    local time = self.config.skill_time
    self:CallCasterWait(time)
    local targetlist = LuaSkillCtrl:CallTargetSelectWithRange(self, 21, 20)
    local target = targetlist[0]
    self.caster:LookAtTarget(target)
    local attackTrigger1 = BindCallback(self, self.OnAttackTrigger1, target)
    LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, self.config.actionId, self.config.action_speed, self.config.actionId_start_time, attackTrigger1)
  else
    local time = self.config.skill_time
    self:CallCasterWait(time)
    local attackTrigger = BindCallback(self, self.OnAttackTrigger, data)
    LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, self.config.actionId, self.config.action_speed, self.config.actionId_start_time, attackTrigger)
  end
end

function KurisuSkillChange:OnAttackTrigger1(target)
  if target == nil then
    return
  end
  self.hitpartners = 0
  local direction = LuaSkillCtrl:GetTargetWithGrid(target.x, target.y)
  self:ShootWave(direction, target)
end

function KurisuSkillChange:ShootWave(direction, target)
  local ElectricalWave = LuaSkillCtrl:CallEffect(direction, self.config.effectId_wave, self)
  local OnCollision = BindCallback(self, self.OnCollision, ElectricalWave, target)
  self.emission = LuaSkillCtrl:CallCircledEmissionStraightly(self, self.caster, target, 15, 5, 10, OnCollision, nil, nil, ElectricalWave, true, true, BindCallback(self, self.OnArive, ElectricalWave))
end

function KurisuSkillChange:OnCollision(ElectricalWave, attackTarget1, collider, index, entity)
  if LuaSkillCtrl:IsFixedObstacle(entity) then
    return
  end
  if entity.belongNum ~= self.caster.belongNum and entity.hp >= 0 then
    self.hitpartners = self.hitpartners + 1
    LuaSkillCtrl:BroadcastLuaTrigger(eSkillLuaTrigger.OnKurisuSummonerHurt, entity, eSkillTag.normalSkill, self.hitpartners)
  end
end

function KurisuSkillChange:OnArive(cusEffect, emission)
  self:UnBindEfcForEmission(emission)
  self:DelayKillEffect(cusEffect)
end

function KurisuSkillChange:UnBindEfcForEmission(emission)
  emission.effect = nil
  emission.collider.lsObject = nil
end

function KurisuSkillChange:DelayKillEffect(ElectricalWave)
  LuaSkillCtrl:StartTimer(nil, self.config.delayKillEffect, function()
    if ElectricalWave ~= nil and not ElectricalWave:IsDie() then
      ElectricalWave:Die()
    end
  end)
end

function KurisuSkillChange:OnRoleDie(killer, role)
  if role == self.target_skill and role.hp <= 0 and role ~= nil then
    if self.caster.recordTable.Kurisu_Mode == 3 then
      LuaSkillCtrl:CallResetCDNumForRole(self.caster, self.caster.recordTable.Kurisu_CdReset)
    else
      LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffid_counter, self.arglist[5], nil, false)
    end
  end
end

return KurisuSkillChange
