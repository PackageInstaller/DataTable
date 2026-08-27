local bs_94209 = class("bs_94209", LuaSkillBase)
local base = LuaSkillBase
bs_94209.config = {buffId = 110065}

function bs_94209:ctor()
end

function bs_94209:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.RoleDie, "bs_94209_11", 1, self.OnRoleDie)
end

function bs_94209:OnRoleDie(killer, role, killSkill)
  if killer.belongNum == eBattleRoleBelong.player and role.belongNum == eBattleRoleBelong.enemy then
    local targetlist = LuaSkillCtrl:GetSelectTeamRoles(eBattleRoleBelong.player)
    if targetlist.Count > 0 then
      for i = 0, targetlist.Count - 1 do
        LuaSkillCtrl:CallBuff(self, targetlist[i], self.config.buffId, 1, self.arglist[2])
      end
    end
  end
end

function bs_94209:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_94209
