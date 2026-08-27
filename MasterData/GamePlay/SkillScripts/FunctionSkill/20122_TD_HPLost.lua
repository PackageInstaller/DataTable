local bs_20122 = class("bs_20122", LuaSkillBase)
local base = LuaSkillBase
bs_20122.config = {buff_id = 2012201}

function bs_20122:ctor()
end

function bs_20122:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  LuaSkillCtrl:CallBuffRepeated(self, self.caster, self.config.buff_id, 1, nil, false, false, self.OnBuffExecute)
end

function bs_20122:OnBuffExecute(buff, targetRole)
  local val = self.caster.maxHp * self.arglist[2] // 1000
  LuaSkillCtrl:RemoveLife(val, self, self.caster, true)
end

function bs_20122:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_20122
