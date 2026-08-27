local bs_20125 = class("bs_20125", LuaSkillBase)
local base = LuaSkillBase
bs_20125.config = {}

function bs_20125:OnCasterDie()
  base.OnCasterDie(self)
  LuaSkillCtrl:BroadcastLuaTrigger(eSkillLuaTrigger.OnTDTakeGrid, self.caster.x, self.caster.y, self.caster)
end

return bs_20125
