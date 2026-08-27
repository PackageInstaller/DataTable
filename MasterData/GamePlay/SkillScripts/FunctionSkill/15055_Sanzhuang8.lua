local bs_15055 = class("bs_15055", LuaSkillBase)
local base = LuaSkillBase
bs_15055.config = {buffId1 = 1245, buffId2 = 1246}

function bs_15055:ctor()
end

function bs_15055:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_15055_1", 1, self.OnAfterBattleStart)
end

function bs_15055:OnAfterBattleStart()
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId2, 2, nil, true)
  local roles = LuaSkillCtrl:FindRolesAroundRole(self.caster)
  if roles ~= nil and roles.Count > 0 then
    for i = 0, roles.Count - 1 do
      local targetRole = roles[i]
      if targetRole.career ~= 4 and 0 < targetRole.hp then
        LuaSkillCtrl:CallBuff(self, targetRole, self.config.buffId1, 1, nil, true)
      end
    end
  end
end

function bs_15055:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_15055
