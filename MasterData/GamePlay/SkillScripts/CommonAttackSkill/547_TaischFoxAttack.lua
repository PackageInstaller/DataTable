local bs_547 = class("bs_547", LuaSkillBase)
local base = LuaSkillBase
bs_547.config = {
  buffId_def = 290,
  buffId_magic_res = 291,
  buffFeature_ignoreDie = 6,
  effect_decrease = 106909,
  effect_live_back = 106911,
  effect_die_back = 106910,
  effect_loop_end = 106912,
  action_start = 1008,
  action_loop = 1007,
  action_end = 1009,
  action_speed = 1,
  start_time_1 = 5,
  start_time_2 = 30,
  loop_time = 35
}

function bs_547:ctor()
end

function bs_547:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self.caster.recordTable.TaischFox = true
  self.arg1 = self.caster.recordTable.arg_1
  self.alive = false
  self.effect = nil
  self.attack = nil
  local over = BindCallback(self, self.Onover)
  self.timer = LuaSkillCtrl:StartTimer(nil, self.arg1, over)
end

function bs_547:PlaySkill()
  if self.attack ~= true then
    self.attack = true
    local attackTrigger = BindCallback(self, self.OnAttackTrigger)
    LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, self.config.action_start, self.config.action_speed, self.config.start_time_1, attackTrigger)
    self.loopAttack = LuaSkillCtrl:StartTimer(self, self.config.start_time_2, function()
      LuaSkillCtrl:CallRoleAction(self.caster, self.config.action_loop, self.config.action_speed)
    end, nil)
    self.finishAttack = LuaSkillCtrl:StartTimer(self, self.config.start_time_2 + self.config.loop_time, function()
      LuaSkillCtrl:CallRoleAction(self.caster, self.config.action_end, self.config.action_speed)
    end, nil)
  end
end

function bs_547:OnAttackTrigger()
  if self.effect == nil then
    self.effect = LuaSkillCtrl:CallEffect(self.caster, self.config.effect_decrease, self)
  end
  local buff_time = self.arg1 / 15 - 1
  self.timer2 = LuaSkillCtrl:StartTimer(nil, 15, function()
    local targetlist_enemy = LuaSkillCtrl:FindAllRolesWithinRange(self.caster, 1, true)
    if targetlist_enemy ~= nil and targetlist_enemy.Count > 0 then
      for i = 0, targetlist_enemy.Count - 1 do
        local targetlist_enemy_ally = targetlist_enemy[i]
        if targetlist_enemy_ally.belongNum == eBattleRoleBelong.enemy and not targetlist_enemy[i]:IsUnSelect(self.caster) then
          LuaSkillCtrl:CallBuff(self, targetlist_enemy[i], self.config.buffId_def, 1, self.arg1)
          LuaSkillCtrl:CallBuff(self, targetlist_enemy[i], self.config.buffId_magic_res, 1, self.arg1)
        end
      end
    end
  end, nil, buff_time, 15)
end

function bs_547:Onover()
  local IfRoleCotainsIgnoreDieBuff = LuaSkillCtrl:RoleContainsBuffFeature(self.caster, self.config.buffFeature_ignoreDie)
  if IfRoleCotainsIgnoreDieBuff == true then
    local buff_ignoreDie = LuaSkillCtrl:GetRoleAllBuffsByFeature(self.caster, self.config.buffFeature_ignoreDie)
    if buff_ignoreDie.Count > 0 then
      for i = 0, buff_ignoreDie.Count - 1 do
        LuaSkillCtrl:DispelBuff(self.caster, buff_ignoreDie[i].dataId, 0, true)
        IfRoleCotainsIgnoreDieBuff = false
      end
    end
  end
  if 0 < self.caster.hp and IfRoleCotainsIgnoreDieBuff == false then
    self.alive = true
    LuaSkillCtrl:StartTimer(nil, 35, function()
      LuaSkillCtrl:CallEffect(self.caster, self.config.effect_live_back, self)
    end)
    LuaSkillCtrl:RemoveLife(self.caster.hp + 10000, self, self.caster, true, nil, false, true, eHurtType.RealDmg, true)
  end
end

function bs_547:OnCasterDie()
  if self.effect ~= nil then
    self.effect:Die()
    self.effect = nil
  end
  if self.timer ~= nil then
    self.timer:Stop()
    self.timer = nil
  end
  if self.timer2 ~= nil then
    self.timer2:Stop()
    self.timer2 = nil
  end
  LuaSkillCtrl:CallEffect(self.caster, self.config.effect_loop_end, self)
  if self.alive == false then
    LuaSkillCtrl:CallEffect(self.caster, self.config.effect_die_back, self)
  end
  local targetlist_enemy = LuaSkillCtrl:GetSelectTeamRoles(eBattleRoleBelong.enemy)
  if targetlist_enemy.Count > 0 and self.alive ~= true then
    for i = 0, targetlist_enemy.Count - 1 do
      if targetlist_enemy[i].belongNum == eBattleRoleBelong.enemy then
        LuaSkillCtrl:DispelBuff(targetlist_enemy[i], self.config.buffId_def, 0)
        LuaSkillCtrl:DispelBuff(targetlist_enemy[i], self.config.buffId_magic_res, 0)
      end
    end
  end
  base.OnCasterDie(self)
end

function bs_547:LuaDispose()
  base.LuaDispose(self)
  self.effect = nil
end

return bs_547
