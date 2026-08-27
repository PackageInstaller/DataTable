local bs_10048 = class("bs_10048", LuaSkillBase)
local base = LuaSkillBase
bs_10048.config = {buffId = 26, buffTier = 1}

function bs_10048:ctor()
end

function bs_10048:InitSkill(isMidwaySkill)
  self:AddSelfTrigger(eSkillTriggerType.RoleDie, "bs_10048_1", 1, self.OnRoleDie)
end

function bs_10048:OnRoleDie(killer, role)
  if self.caster == role then
  end
end

function bs_10048:OnCasterDie()
  local targetlist = LuaSkillCtrl:CallTargetSelect(self, 9, 10)
  for i = 0, targetlist.Count - 1 do
    LuaSkillCtrl:CallBuff(self, targetlist[i].targetRole, self.config.buffId, self.config.buffTier, self.arglist[1])
  end
  base.OnCasterDie(self)
end

return bs_10048
