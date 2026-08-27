local bs_25291 = class("bs_25291", LuaSkillBase)
local base = LuaSkillBase
bs_25291.config = {buffId = 2145}

function bs_25291:ctor()
end

function bs_25291:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterHurtTrigger("bs_25291", 9, self.OnAfterHurt, nil, self.caster, nil, nil, nil, nil, nil)
end

function bs_25291:OnAfterHurt()
  local curHp = self.caster.hp
  local tarHp = self.caster.maxHp * self.arglist[1] // 1000
  if curHp < tarHp then
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, 1, nil, true)
  else
    LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId, 0, true, false)
  end
end

function bs_25291:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_25291
