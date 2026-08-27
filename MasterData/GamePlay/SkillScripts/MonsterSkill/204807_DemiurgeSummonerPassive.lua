local bs_204807 = class("bs_204807", LuaSkillBase)
local base = LuaSkillBase
bs_204807.config = {}

function bs_204807:OnCasterDie()
  LuaSkillCtrl:BroadcastLuaTrigger(eSkillLuaTrigger.OnSummonerDieForDemiurge, self.caster)
  base.OnCasterDie(self)
end

return bs_204807
