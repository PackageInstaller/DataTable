local bs_17203 = class("bs_17203", LuaSkillBase)
local base = LuaSkillBase
bs_17203.config = {}

function bs_17203:ctor()
end

function bs_17203:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.BeforeBattleEnd, "bs_17203_2", 2, self.BeforeEndBattle)
end

function bs_17203:BeforeEndBattle()
  local coin = LuaSkillCtrl:GetCacheGold()
  local num = coin * self.arglist[1] // 1000
  LuaSkillCtrl:AddCacheGold(num)
end

function bs_17203:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_17203
