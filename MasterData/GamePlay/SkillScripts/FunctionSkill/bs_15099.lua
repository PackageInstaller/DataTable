local bs_15099 = class("bs_15099", LuaSkillBase)
local base = LuaSkillBase
bs_15099.config = {}

function bs_15099:ctor()
end

function bs_15099:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterPlaySkill, "bs_15099_13", 1, self.OnAfterPlaySkill)
end

function bs_15099:OnAfterPlaySkill(skill, role)
  if skill.isUltSkill then
    LuaSkillCtrl:CallAddPlayerHmp(ConfigData.game_config.ultMpCost * self.arglist[1] // 1000)
  end
end

function bs_15099:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_15099
