local bs_30045 = class("bs_30045", LuaSkillBase)
local base = LuaSkillBase
bs_30045.config = {buffId = 205, buffTier = 1}

function bs_30045:ctor()
end

function bs_30045:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.RoleDie, "bs_30045_10", 1, self.OnRoleDie)
end

function bs_30045:OnRoleDie(killer, role)
  if role.belongNum ~= self.caster.belongNum and role.roleType == 1 then
    local targetlist = LuaSkillCtrl:CallTargetSelect(self, 9, 0)
    if 1 > targetlist.Count then
      return
    end
    for i = 0, targetlist.Count - 1 do
      LuaSkillCtrl:CallBuff(self, targetlist[i].targetRole, self.config.buffId, self.config.buffTier, self.arglist[1])
    end
  end
end

function bs_30045:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_30045
