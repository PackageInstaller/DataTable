local bs_21021 = class("bs_21021", LuaSkillBase)
local base = LuaSkillBase
bs_21021.config = {}

function bs_21021:ctor()
end

function bs_21021:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddSelfTrigger(eSkillTriggerType.HurtResultEnd, "bs_21021_1", 1, self.OnHurtResultEnd)
end

function bs_21021:OnHurtResultEnd(skill, targetRole, hurtValue)
  if skill.maker == self.caster then
    local targetlist = LuaSkillCtrl:FindAllRolesWithinRange(self.caster, 1, false)
    if targetlist.Count == 0 then
      local Value = math.max(1, hurtValue * self.arglist[1] // 1000)
      LuaSkillCtrl:AddRoleShield(self.caster, eShieldType.Normal, Value)
    else
      local Num = 0
      for i = 0, targetlist.Count - 1 do
        local role = targetlist[i]
        if role.belongNum == eBattleRoleBelong.enemy and LuaSkillCtrl:IsRoleAdjacent(role, self.caster) then
          Num = Num + 1
        end
      end
      if Num == 0 then
        local Value = math.max(1, hurtValue * self.arglist[1] // 1000)
        LuaSkillCtrl:AddRoleShield(self.caster, eShieldType.Normal, Value)
      end
    end
  end
end

function bs_21021:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_21021
