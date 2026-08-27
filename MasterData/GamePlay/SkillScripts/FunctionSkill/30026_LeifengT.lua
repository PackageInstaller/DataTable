local bs_30026 = class("bs_30026", LuaSkillBase)
local base = LuaSkillBase
bs_30026.config = {buffId = 1188}

function bs_30026:ctor()
end

function bs_30026:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddLuaTrigger(eSkillLuaTrigger.OnChipSuitInvoke, self.OnChipSuitInvoke)
end

function bs_30026:OnChipSuitInvoke(sender, targetRole)
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, self.arglist[1])
end

function bs_30026:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_30026
