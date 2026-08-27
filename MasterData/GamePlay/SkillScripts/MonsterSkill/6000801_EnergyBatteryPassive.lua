local bs_6000800 = class("bs_6000800", LuaSkillBase)
local base = LuaSkillBase
bs_6000800.config = {effectId = 600801}

function bs_6000800:ctor()
end

function bs_6000800:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_6000800:OnCasterDie()
  LuaSkillCtrl:CallEffect(self.caster, self.config.effectId, self)
  LuaSkillCtrl:CallAddPlayerHmp(ConfigData.game_config.ultMpCost * self.arglist[1] // 1000)
  base.OnCasterDie(self)
end

return bs_6000800
