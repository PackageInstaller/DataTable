local bs_6001002 = class("bs_6001002", LuaSkillBase)
local base = LuaSkillBase
bs_6001002.config = {effectId = 601000}

function bs_6001002:ctor()
end

function bs_6001002:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_6001002:PlaySkill(data)
  LuaSkillCtrl:CallEffect(self.caster, self.config.effectId, self)
  local costurlnum = 0 - LuaSkillCtrl:GetUltHMp()
  LuaSkillCtrl:CallAddPlayerHmp(costurlnum)
end

function bs_6001002:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_6001002
