local bs_1010022 = class("bs_1010022", LuaSkillBase)
local base = LuaSkillBase
bs_1010022.config = {
  effectId_skill = 101003,
  actionId = 1002,
  buffId_66 = 10100201,
  hurtConfig = {
    hit_formula = 0,
    basehurt_formula = 3010,
    crit_formula = 0,
    returndamage_formula = 0
  },
  audioId1 = 101003,
  skill_time = 33,
  start_time = 15
}

function bs_1010022:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_1010022:PlaySkill(data)
  local belongNum = 1
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

function bs_1010022:OnActionCallBack(target, roles, roles_net)
  LuaSkillCtrl:CallEffectWithArg(target, self.config.effectId_skill, self, false, false, self.OnEffectTrigger, roles, roles_net)
end

function bs_1010022:OnEffectTrigger(roles, roles_net, effect, eventId, target)
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
  end
end

function bs_1010022:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_1010022
