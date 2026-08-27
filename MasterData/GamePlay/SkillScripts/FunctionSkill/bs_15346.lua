local bs_15346 = class("bs_15346", LuaSkillBase)
local base = LuaSkillBase
bs_15346.config = {buffWKId = 1248}

function bs_15346:ctor()
end

function bs_15346:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterAddBuffTrigger("bs_15346_2", 1, self.OnAfterAddBuff, nil, self.caster, nil, nil, self.config.buffWKId)
end

function bs_15346:OnAfterAddBuff(buff, target)
  if buff.dataId == self.config.buffWKId then
    local value = self.caster.skill_intensity * self.arglist[1] // 1000
    LuaSkillCtrl:AddRoleShield(self.caster, eShieldType.Normal, value)
  end
end

function bs_15346:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_15346
