local bs_91015 = class("bs_91015", LuaSkillBase)
local base = LuaSkillBase
bs_91015.config = {buffId = 2025}

function bs_91015:ctor()
end

function bs_91015:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddSelfTrigger(eSkillTriggerType.AfterBattleStart, "bs_91015_1", 1, self.OnAfterBattleStart)
end

function bs_91015:OnAfterBattleStart()
  local targetlist = LuaSkillCtrl:CallTargetSelect(self, 6, 10)
  if targetlist.Count ~= 0 then
    for i = 0, targetlist.Count - 1 do
      local value = targetlist[i].targetRole.dodge
      if value < self.arglist[1] then
        LuaSkillCtrl:CallBuff(self, targetlist[i].targetRole, self.config.buffId, value, nil, true)
      else
        LuaSkillCtrl:CallBuff(self, targetlist[i].targetRole, self.config.buffId, self.arglist[1], nil, true)
      end
    end
  end
  self:PlayChipEffect()
end

function bs_91015:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_91015
