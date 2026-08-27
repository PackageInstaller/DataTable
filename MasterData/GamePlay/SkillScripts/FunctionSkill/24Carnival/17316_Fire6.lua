local FireBase = require("GamePlay.SkillScripts.FunctionSkill.24Carnival.FireBase")
local bs_17316 = class("bs_17316", FireBase)
local base = FireBase
bs_17316.config = {buffId = 2224}
bs_17316.config = setmetatable(bs_17316.config, {
  __index = base.config
})

function bs_17316:ctor()
end

function bs_17316:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_17316", 1, self.OnAfterBattleStart)
  self:AddFireMaxTier(self.arglist[2])
end

function bs_17316:OnAfterBattleStart()
  base.OnAfterBattleStart(self)
  local playerList = LuaSkillCtrl:GetSelectTeamRoles(eBattleRoleBelong.player)
  for i = 0, playerList.Count - 1 do
    LuaSkillCtrl:CallBuff(self, playerList[i], self.config.buffId, 1, nil, true, nil, true)
  end
end

function bs_17316:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_17316
