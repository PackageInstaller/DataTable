local bs_60008 = class("bs_60008", LuaSkillBase)
local base = LuaSkillBase
bs_60008.config = {effectId = 12063}

function bs_60008:ctor()
end

function bs_60008:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddSetDeadHurtTrigger("bs_60008", 2, self.OnSetDeadHurt, nil, self.caster)
end

function bs_60008:OnSetDeadHurt(context)
  LuaSkillCtrl:CallAddPlayerHmp(ConfigData.game_config.ultMpCost * self.arglist[1] // 1000)
end

function bs_60008:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_60008
