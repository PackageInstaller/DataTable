local bs_21157 = class("bs_21157", LuaSkillBase)
local base = LuaSkillBase
bs_21157.config = {}

function bs_21157:ctor()
end

function bs_21157:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddOnRoleDieTrigger("bs_21157_1", 1, self.OnRoleDie, nil, nil, eBattleRoleBelong.player, eBattleRoleBelong.enemy)
end

function bs_21157:OnRoleDie(killer, role)
  if role.belongNum == eBattleRoleBelong.enemy and killer.belongNum == eBattleRoleBelong.player then
    local value = role.maxHp * self.arglist[1] // 1000
    local targetlist = LuaSkillCtrl:FindRolesAroundRole(role)
    if targetlist ~= nil and targetlist.Count > 0 then
      for i = 0, targetlist.Count - 1 do
        local targetRole = targetlist[i]
        if targetRole.belongNum == eBattleRoleBelong.player then
          local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, targetRole)
          LuaSkillCtrl:HealResultWithConfig(self, skillResult, 6, {value}, true, true)
          skillResult:EndResult()
        end
      end
    end
  end
end

function bs_21157:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_21157
