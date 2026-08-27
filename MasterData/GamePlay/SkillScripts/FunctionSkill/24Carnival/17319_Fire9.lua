local FireBase = require("GamePlay.SkillScripts.FunctionSkill.24Carnival.FireBase")
local bs_17319 = class("bs_17319", FireBase)
local base = FireBase
bs_17319.config = {buffId = 2226}

function bs_17319:ctor()
end

bs_17319.config = setmetatable(bs_17319.config, {
  __index = base.config
})

function bs_17319:InitSkill(isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_17319", 1, self.OnAfterBattleStart)
  self:AddFireMaxTier(self.arglist[2])
end

function bs_17319:OnAfterBattleStart()
  base.OnAfterBattleStart(self)
  local playerList = LuaSkillCtrl:GetAllFriendRoles()
  for _, role in ipairs(playerList) do
    LuaSkillCtrl:CallBuff(self, role, self.config.buffId, 1, nil, true, nil, true)
  end
end

function bs_17319:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_17319
