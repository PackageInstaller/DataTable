local bs_108909 = class("bs_108909", LuaSkillBase)
local base = LuaSkillBase
bs_108909.config = {HurtConfigId = 58}

function bs_108909:ctor()
end

function bs_108909:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  local dmg = self.caster.recordTable.bleedNum
  LuaSkillCtrl:StartTimer(nil, 15, function()
    if self.caster ~= nil and self.caster.hp > 0 then
      local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, self.caster)
      local realDmg = dmg * self.caster:GetBuffTier(108904)
      LuaSkillCtrl:HurtResultWithConfig(self, skillResult, self.config.HurtConfigId, {realDmg}, false, false, nil, 106)
      skillResult:EndResult()
    end
  end, self, -1, 14)
end

function bs_108909:LuaDispose()
  base.LuaDispose(self)
end

function bs_108909:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_108909
