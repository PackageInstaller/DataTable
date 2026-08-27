local bs_10182 = class("bs_10182", LuaSkillBase)
local base = LuaSkillBase
bs_10182.config = {
  buffIdYuan = 1047,
  buffIdJin = 1048,
  buffIdYuan1 = 1055,
  buffIdJin1 = 1056
}

function bs_10182:ctor()
end

function bs_10182:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_10182_1", 1, self.OnAfterBattleStart)
end

function bs_10182:OnAfterBattleStart()
  LuaSkillCtrl:StartTimer(nil, 1, self.CallBack, self, 1, 0)
end

function bs_10182:CallBack()
  local targetlist = LuaSkillCtrl:CallTargetSelect(self, 5, 20)
  if targetlist.Count > 0 then
    for i = 0, targetlist.Count - 1 do
      local targetRole = targetlist[i].targetRole
      local value = LuaSkillCtrl:GetShield(targetRole, eShieldType.NoRange)
      local value2 = LuaSkillCtrl:GetShield(targetRole, eShieldType.LongRange)
      if 0 < value then
        LuaSkillCtrl:ClearShield(targetRole, eShieldType.NoRange)
        LuaSkillCtrl:CallBuff(self, targetRole, self.config.buffIdJin1, 1)
      end
      if 0 < value2 then
        LuaSkillCtrl:ClearShield(targetRole, eShieldType.LongRange)
        LuaSkillCtrl:CallBuff(self, targetRole, self.config.buffIdYuan1, 1)
      end
    end
  end
end

function bs_10182:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_10182
