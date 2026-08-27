local bs_107808 = class("bs_107808", LuaSkillBase)
local base = LuaSkillBase
bs_107808.config = {
  actionId = 1002,
  actionId_start_time = 5,
  action_speed = 1,
  skill_time = 15,
  effectId = 107818,
  effectId_hit = 107819,
  buffid_counter = 107801,
  delayKillEffect = 3,
  buffFeature_ignoreDie = 6
}

function bs_107808:ctor()
end

function bs_107808:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self.caster.recordTable.Kurisu_Fenshen = true
  self:AddLuaTrigger(eSkillLuaTrigger.OnPlayChang, self.OnPlayChang)
  self:AddOnRoleDieTrigger("bs_107808_1", 1, self.OnRoleDie, nil, nil, nil, self.caster.belongNum)
end

function bs_107808:OnPlayChang(data)
  if data then
    self:PlaySkill()
  end
end

function bs_107808:PlaySkill()
  LuaSkillCtrl:BroadcastLuaTrigger(eSkillLuaTrigger.OnKurisuSummonerSkill, self, 0, eSkillTag.normalSkill)
  local time = self.config.skill_time
  self:CallCasterWait(time)
  local target
  local targetlist = LuaSkillCtrl:CallTargetSelectWithRange(self, 21, 20)
  if targetlist ~= nil and targetlist.Count ~= 0 then
    target = targetlist[0]
  end
  if target == nil or 0 > target.targetRole.hp then
    return
  end
  self.caster:LookAtTarget(target)
  local attackTrigger = BindCallback(self, self.OnAttackTrigger, target)
  LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, self.config.actionId, self.config.action_speed, self.config.actionId_start_time, attackTrigger)
  LuaSkillCtrl:BroadcastLuaTrigger(eSkillLuaTrigger.OnKurisuSummonerSkill, self, 1, eSkillTag.normalSkill)
end

function bs_107808:OnAttackTrigger(target)
  if target == nil then
    return
  end
  self.hitpartners = 0
  local direction = LuaSkillCtrl:GetTargetWithGrid(target.x, target.y)
  self:ShootWave(direction, target)
end

function bs_107808:ShootWave(direction, target)
  local ElectricalWave = LuaSkillCtrl:CallEffect(direction, self.config.effectId, self)
  local OnCollition = BindCallback(self, self.OnCollision, ElectricalWave, target)
  self.emission = LuaSkillCtrl:CallCircledEmissionStraightly(self, self.caster, target, 15, 5, 10, OnCollition, nil, nil, ElectricalWave, true, true, BindCallback(self, self.OnArive, ElectricalWave))
end

function bs_107808:OnCollision(ElectricalWave, attackTarget, collider, index, entity)
  if LuaSkillCtrl:IsFixedObstacle(entity) or self.caster == nil then
    return
  end
  if entity.belongNum ~= self.caster.belongNum and entity.hp >= 0 then
    if entity.belongNum == eBattleRoleBelong.enemy then
      self.hitpartners = self.hitpartners + 1
    end
    LuaSkillCtrl:CallEffect(entity, self.config.effectId_hit, self)
    LuaSkillCtrl:BroadcastLuaTrigger(eSkillLuaTrigger.OnKurisuSummonerHurt, entity, eSkillTag.normalSkill, self.hitpartners)
  end
end

function bs_107808:OnArive(cusEffect, emission)
  self:UnBindEfcForEmission(emission)
  self:DelayKillEffect(cusEffect)
  LuaSkillCtrl:BroadcastLuaTrigger(eSkillLuaTrigger.OnKurisuSummonerHurt, nil, eSkillTag.normalSkill, nil)
end

function bs_107808:UnBindEfcForEmission(emission)
  emission.effect = nil
  emission.collider.lsObject = nil
end

function bs_107808:DelayKillEffect(ElectricalWave)
  LuaSkillCtrl:StartTimer(nil, self.config.delayKillEffect, function()
    if ElectricalWave ~= nil and not ElectricalWave:IsDie() then
      ElectricalWave:Die()
    end
  end)
end

function bs_107808:OnRoleDie(killer, role)
  if role.roleDataId == 1078 and role.hp <= 0 and role ~= nil then
    local IfRoleCotainsIgnoreDieBuff = LuaSkillCtrl:RoleContainsBuffFeature(self.caster, self.config.buffFeature_ignoreDie)
    if IfRoleCotainsIgnoreDieBuff == true then
      local buff_ignoreDie = LuaSkillCtrl:GetRoleAllBuffsByFeature(self.caster, self.config.buffFeature_ignoreDie)
      if 0 < buff_ignoreDie.Count then
        for i = 0, buff_ignoreDie.Count - 1 do
          LuaSkillCtrl:DispelBuff(self.caster, buff_ignoreDie[i].dataId, 0, true)
          IfRoleCotainsIgnoreDieBuff = false
        end
      end
    end
    if 0 < self.caster.hp and IfRoleCotainsIgnoreDieBuff == false then
      LuaSkillCtrl:RemoveLife(self.caster.hp + 10000, self, self.caster, true, nil, false, true, eHurtType.RealDmg, true)
    end
  end
end

function bs_107808:OnCasterDie()
  base.OnCasterDie(self)
  if self.emission ~= nil and self.emission.collider ~= nil then
    LuaSkillCtrl:ClearColliderOrEmission(self.emission.collider)
    self.emission = nil
  end
end

function bs_107808:LuaDispose()
  base.LuaDispose(self)
  self.emission = nil
end

return bs_107808
