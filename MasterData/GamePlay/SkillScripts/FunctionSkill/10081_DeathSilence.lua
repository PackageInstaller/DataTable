local bs_10081 = class("bs_10081", LuaSkillBase)
local base = LuaSkillBase
bs_10081.config = {buffId = 26, buffTier = 1}

function bs_10081:ctor()
end

function bs_10081:InitSkill(isMidwaySkill)
end

function bs_10081:OnCasterDie()
  local targetlist = LuaSkillCtrl:CallTargetSelect(self, 9, 10)
  for i = 0, targetlist.Count - 1 do
    LuaSkillCtrl:CallBuff(self, targetlist[i].targetRole, self.config.buffId, self.config.buffTier, self.arglist[1])
  end
  base.OnCasterDie(self)
end

return bs_10081
