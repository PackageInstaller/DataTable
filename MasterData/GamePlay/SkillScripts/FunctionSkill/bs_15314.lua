local bs_15314 = class("bs_15314", LuaSkillBase)
local base = LuaSkillBase
bs_15314.config = {buffId = 107101}

function bs_15314:ctor()
end

function bs_15314:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterAddBuffTrigger("bs_15314", 1, self.OnAfterAddBuff, self.caster, nil, nil, nil, self.config.buffId)
end

function bs_15314:OnAfterAddBuff(buff, target)
  local sheildValue = self.caster.maxHp * self.arglist[1] // 1000
  LuaSkillCtrl:AddRoleShield(self.caster, eShieldType.Normal, sheildValue)
end

function bs_15314:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_15314
