local bs_21031 = class("bs_21031", LuaSkillBase)
local base = LuaSkillBase
bs_21031.config = {}

function bs_21031:ctor()
end

function bs_21031:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_21031_1", 1, self.OnAfterBattleStart)
  self:AddTrigger(eSkillTriggerType.AfterPlaySkill, "bs_21031_13", 1, self.OnAfterPlaySkill)
end

function bs_21031:OnAfterBattleStart()
  self.HumNum = 0
end

function bs_21031:OnAfterPlaySkill(skill, role)
  if skill.isUltSkill and self.HumNum == 0 then
    local value = LuaSkillCtrl:GetUltHMp()
    LuaSkillCtrl:CallAddPlayerHmp(ConfigData.game_config.ultMpCost * self.arglist[1] // 10)
    self.HumNum = 1
  end
end

function bs_21031:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_21031
