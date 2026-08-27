local bs_109302 = class("bs_109302", LuaSkillBase)
local base = LuaSkillBase
bs_109302.config = {
  selectId_skill = 10001,
  buffId_1 = 109302,
  effectId_cast = 109304,
  effectId_hit = 109305,
  actionId = 1008,
  skill_time = 25,
  start_time = 10,
  skill_speed = 1
}

function bs_109302:ctor()
end

function bs_109302:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_109302:PlaySkill(data)
  local targetList = LuaSkillCtrl:CallTargetSelect(self, self.config.selectId_skill, 10)
  if targetList.Count <= 0 then
    return
  end
  local attackTrigger = BindCallback(self, self.OnAttackTrigger, targetList[0])
  self:CallCasterWait(self.config.skill_time)
  LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, self.config.actionId, self.config.action_speed, self.config.start_time, attackTrigger)
  LuaSkillCtrl:CallEffect(self.caster, self.config.effectId_cast, self)
end

function bs_109302:OnAttackTrigger(target, data)
  self.caster:LookAtTarget(target)
  LuaSkillCtrl:CallEffect(target, self.config.effectId_hit, self)
  local target_grid = LuaSkillCtrl:GetTargetWithGrid(target.x, target.y)
  local targetList = LuaSkillCtrl:FindAllRolesWithinRange(target_grid, 1, true)
  if targetList.Count > 0 then
    for i = 0, targetList.Count - 1 do
      local role = targetList[i]
      if role ~= nil and 0 < role.hp and role.belongNum ~= self.caster.belongNum and role.belongNum ~= eBattleRoleBelong.neutral then
        local num = role._curHp * self.arglist[1] // 1000
        if 0 < num then
          LuaSkillCtrl:RemoveLife(num, self, role, true, nil, false, true, eHurtType.RealDmg, true)
          LuaSkillCtrl:AddRoleShield(role, eShieldType.Normal, num)
        end
        LuaSkillCtrl:CallBuff(self, role, self.config.buffId_1, 1, self.arglist[2])
      end
    end
  end
  LuaSkillCtrl:CallRoleAction(self.caster, 1009, 1)
end

function bs_109302:LuaDispose()
  base.LuaDispose(self)
end

function bs_109302:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_109302
