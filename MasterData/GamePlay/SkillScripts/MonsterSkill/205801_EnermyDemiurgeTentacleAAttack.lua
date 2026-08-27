local bs_205801 = class("bs_205801", LuaSkillBase)
local base = LuaSkillBase
bs_205801.config = {
  actionId_start = 1008,
  start_time = 20,
  actionId_loop = 1007,
  actionId_end = 1009,
  end_time = 1,
  effectId_Birth = 205801,
  effectId_loop = 205802,
  effectId_death = 205803,
  buffId_Taunt = 3002,
  buffId_SummonerSign = 2048035,
  buffId_LockCD = 2048034,
  buffFeature_ignoreDie = 6,
  buffId_SuperArmor = 2048036,
  buffId_target = 2048037
}

function bs_205801:ctor()
end

function bs_205801:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self.caster.recordTable.DemiurgeTentacleA = 2058
  self:AddTrigger(eSkillTriggerType.RoleDie, "bs_205801_1", 10, self.OnRoleDie)
  self.maxHP = self.caster.recordTable.HP
  self.aliveTime = self.caster.recordTable.aliveTime + 1
  self.creater = self.caster.recordTable.creater
  self.target = self.caster.recordTable.actionTarget
  local hurtTarget = self.target
  local over = BindCallback(self, self.Onover, hurtTarget)
  LuaSkillCtrl:StartTimer(nil, self.aliveTime + self.config.end_time, over)
  self.over_time = true
  LuaSkillCtrl:StartTimer(nil, self.aliveTime, function()
    self.over_time = false
  end)
end

function bs_205801:PlaySkill()
  local target = self.target
  local alivetime = self.aliveTime
  local superArmorTime = self.aliveTime + self.config.start_time + self.config.end_time
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_SuperArmor, 1, superArmorTime)
  self:CallCasterWait(self.config.start_time + alivetime + self.config.end_time)
  self.caster:LookAtTarget(self.target)
  LuaSkillCtrl:CallEffect(target, self.config.effectId_Birth, self)
  local stifletarget = BindCallback(self, self.stifle, target, data)
  LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, self.config.actionId_start, self.config.action_speed, self.config.start_time, stifletarget)
end

function bs_205801:stifle(target, data)
  LuaSkillCtrl:StartShowSkillDurationTime(self, self.aliveTime)
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_SummonerSign, 1, self.aliveTime)
end

function bs_205801:tauntAllEnermy()
  local targetlist = LuaSkillCtrl:FindAllRolesWithinRange(self.caster, 10, false)
  if targetlist.Count > 0 then
    for i = 0, targetlist.Count - 1 do
      if targetlist[i].belongNum == eBattleRoleBelong.player and not targetlist[i]:IsUnSelect(self.caster) then
        LuaSkillCtrl:CallBuff(self, targetlist[i], self.config.buffId_Taunt, 1, self.aliveTime)
      end
    end
  end
end

function bs_205801:Onover(hurtTarget)
  if self.caster == nil or self.caster.hp <= 0 then
    return
  end
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
  if self.caster.hp > 0 and IfRoleCotainsIgnoreDieBuff == false then
    LuaSkillCtrl:RemoveLife(self.caster.hp + 10000, self, self.caster, false, nil, false, false, eHurtType.RealDmg)
    local targetlist_enemy = LuaSkillCtrl:FindAllRolesWithinRange(self.caster, 1, false)
    if 0 < targetlist_enemy.Count then
      for i = 0, targetlist_enemy.Count - 1 do
        if targetlist_enemy[i].belongNum == eBattleRoleBelong.enemy and not targetlist_enemy[i]:IsUnSelect(self.caster) then
          LuaSkillCtrl:DispelBuffByMaker(self.caster, targetlist_enemy[i], self.config.buffId_Taunt, 1)
        end
      end
    end
  end
end

function bs_205801:OnCasterDie()
  local targetlist_enemy = LuaSkillCtrl:FindAllRolesWithinRange(self.caster, 1, false)
  if targetlist_enemy.Count > 0 then
    for i = 0, targetlist_enemy.Count - 1 do
      if targetlist_enemy[i].belongNum == eBattleRoleBelong.enemy and not targetlist_enemy[i]:IsUnSelect(self.caster) then
        LuaSkillCtrl:DispelBuffByMaker(self.caster, targetlist_enemy[i], self.config.buffId_Taunt, 1)
      end
    end
  end
  base.OnCasterDie(self)
end

function bs_205801:OnRoleDie(killer, role)
  if role == self.caster.recordTable.actionTarget then
    self:Onover()
  end
end

return bs_205801
