local bs_107409 = class("bs_107409", LuaSkillBase)
local base = LuaSkillBase
bs_107409.config = {buffId = 107403}

function bs_107409:ctor()
end

function bs_107409:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddOnRoleDieTrigger("bs_107409_1", 1, self.OnRoleDie, nil, nil, nil, self.caster.belongNum)
end

function bs_107409:OnRoleDie(killer, role)
  local caster = LuaSkillCtrl:GetOriginRole(1074)
  if caster ~= nil and caster.roleOnBench == true and role.belongNum == self.caster.belongNum then
    local targetList = LuaSkillCtrl:GetSelectTeamRoles(eBattleRoleBelong.player)
    if targetList ~= nil and targetList.Count > 0 then
      for i = 0, targetList.Count - 1 do
        local role = targetList[i]
        if role ~= nil and 0 < role.hp and role.roleType ~= eBattleRoleType.realSummoner then
          LuaSkillCtrl:CallBuff(self, targetList[i], self.config.buffId, 1, self.arglist[2])
        end
      end
    end
  end
end

function bs_107409:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_107409
