local bs_101002 = class("bs_101002", LuaSkillBase)
local base = LuaSkillBase
bs_101002.config = {
  effectId_skill = 101003,
  actionId = 1002,
  buffId_66 = 101002,
  hurtConfig = {
    hit_formula = 0,
    basehurt_formula = 3010,
    crit_formula = 0,
    returndamage_formula = 0
  },
  heal_config = {baseheal_formula = 3021},
  audioId1 = 101003,
  skill_time = 33,
  start_time = 15,
  weaponLv = 0,
  effectId_weapon = 101013
}

function bs_101002:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  if self.config.weaponLv >= 2 then
    self.weapon2 = true
  else
    self.weapon2 = false
  end
end

function bs_101002:PlaySkill(data)
  local belongNum = 2
  local grid = LuaSkillCtrl:CallFindGridMostRolesArounded(belongNum)
  if grid ~= nil then
    local target = LuaSkillCtrl:GetTargetWithGrid(grid.x, grid.y)
    self:CallCasterWait(self.config.skill_time)
    local roles = LuaSkillCtrl:FindRolesAroundGrid(grid, belongNum)
    local roles_net = LuaSkillCtrl:FindRolesAroundGrid(grid, 0)
    local triggerCallBack = BindCallback(self, self.OnActionCallBack, target, roles, roles_net)
    LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, self.config.actionId, 1, self.config.start_time, triggerCallBack)
    LuaSkillCtrl:PlayAuSource(self.caster, self.config.audioId1)
  end
end

function bs_101002:OnActionCallBack(target, roles, roles_net)
  LuaSkillCtrl:CallEffectWithArg(target, self.config.effectId_skill, self, false, false, self.OnEffectTrigger, roles, roles_net)
end

function bs_101002:OnEffectTrigger(roles, roles_net, effect, eventId, target)
  if effect.dataId == self.config.effectId_skill and eventId == eBattleEffectEvent.Trigger then
    if roles ~= nil and roles.Count > 0 then
      for i = 0, roles.Count - 1 do
        if roles[i] ~= nil and 0 < roles[i].hp then
          local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, roles[i], self.config.hurtConfig)
          LuaSkillCtrl:HurtResult(self, skillResult, self.config.hurtConfig, {
            self.arglist[1]
          })
          skillResult:EndResult()
          LuaSkillCtrl:CallBuff(self, roles[i], self.config.buffId_66, 1, self.arglist[2])
        end
      end
      if self.weapon2 == true and roles.Count == 1 then
        LuaSkillCtrl:CallEffect(roles[0], self.config.effectId_weapon, self)
        LuaSkillCtrl:StartTimer(nil, 7, function()
          local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, self.caster)
          LuaSkillCtrl:HealResult(skillResult, self.config.heal_config, {
            self.arglist[3]
          }, true)
          skillResult:EndResult()
        end)
      end
    end
    if roles_net ~= nil and roles_net.Count > 0 then
      for i = 0, roles_net.Count - 1 do
        if roles_net[i] ~= nil and 0 < roles_net[i].hp then
          local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, roles_net[i], self.config.hurtConfig)
          LuaSkillCtrl:HurtResult(self, skillResult, self.config.hurtConfig, {
            self.arglist[1]
          })
          skillResult:EndResult()
        end
      end
    end
    self:OnSkillDamageEnd()
  end
end

function bs_101002:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_101002
