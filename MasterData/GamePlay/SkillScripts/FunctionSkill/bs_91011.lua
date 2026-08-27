local bs_91011 = class("bs_91011", LuaSkillBase)
local base = LuaSkillBase
bs_91011.config = {buffId = 2009}

function bs_91011:ctor()
end

function bs_91011:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddSelfTrigger(eSkillTriggerType.AfterBattleStart, "bs_91011_1", 1, self.OnAfterBattleStart)
end

function bs_91011:OnAfterBattleStart()
  local grids = LuaSkillCtrl:FindEmptyGridsWithinRange(self.caster.x, self.caster.y, 1)
  if grids ~= nil and grids.Count > 0 then
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, grids.Count, nil, true)
    self.caster:UpdateHp()
  end
end

function bs_91011:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_91011
