local bs_107602 = class("bs_107602", LuaSkillBase)
local base = LuaSkillBase
bs_107602.config = {
  actionId = 1002,
  action_speed = 1,
  start_time = 7,
  heal_config = {baseheal_formula = 3021},
  recoverHealEffect = 107605,
  healEffect = 107606,
  skillCast = 107607
}

function bs_107602:ctor()
end

function bs_107602:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_107602:PlaySkill(data)
  local attackTrigger = BindCallback(self, self.OnAttackTrigger)
  self:CallCasterWait(30)
  LuaSkillCtrl:CallEffect(self.caster, self.config.skillCast, self)
  LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, self.config.actionId, self.config.action_speed, self.config.start_time, attackTrigger)
end

function bs_107602:OnAttackTrigger()
  local roleList = LuaSkillCtrl:GetSelectTeamRoles(eBattleRoleBelong.player)
  if roleList.Count ~= nil then
    for i = 0, roleList.Count - 1 do
      if roleList[i].roleType ~= eBattleRoleType.realSummoner then
        local arg1 = self.caster.recordTable.arg1
        local arg2 = self.caster.recordTable.arg2
        LuaSkillCtrl:CallRecoverHeal(roleList[i], self, arg1, arg2, 0, self.config.recoverHealEffect)
        local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, roleList[i])
        LuaSkillCtrl:CallEffect(roleList[i], self.config.healEffect, self)
        if roleList[i].hp * 1000 // roleList[i].maxHp >= self.arglist[2] then
          LuaSkillCtrl:HealResult(skillResult, self.config.heal_config, {
            self.arglist[1]
          })
        else
          local num = self.arglist[1] * self.arglist[3] // 1000 + self.arglist[1]
          LuaSkillCtrl:HealResult(skillResult, self.config.heal_config, {num})
        end
        skillResult:EndResult()
      end
    end
  end
end

function bs_107602:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_107602
