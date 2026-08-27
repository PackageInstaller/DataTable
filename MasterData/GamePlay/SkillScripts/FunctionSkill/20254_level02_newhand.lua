local bs_20254 = class("bs_20254", LuaSkillBase)
local base = LuaSkillBase
bs_20254.config = {}

function bs_20254:ctor()
end

function bs_20254:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_20254_1", 1, self.OnAfterBattleStart)
end

function bs_20254:OnAfterBattleStart()
  self.HumNum = 0
  if self.HumNum == 0 then
    local value = LuaSkillCtrl:GetUltHMp()
    LuaSkillCtrl:CallAddPlayerHmp(ConfigData.game_config.ultMpCost * self.arglist[1] // 10)
    self.HumNum = 1
  end
end

function bs_20254:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_20254
