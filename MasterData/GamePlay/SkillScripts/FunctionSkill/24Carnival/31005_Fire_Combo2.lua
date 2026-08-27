local FireBase = require("GamePlay.SkillScripts.FunctionSkill.24Carnival.FireBase")
local bs_31005 = class("bs_31005", FireBase)
local base = FireBase
bs_31005.config = {newBuffId_miniFire = 2229, buffId = 110154}
bs_31005.config = setmetatable(bs_31005.config, {
  __index = base.config
})

function bs_31005:ctor()
end

function bs_31005:InitSkill(isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_31005", 1, self.OnAfterBattleStart)
  self:ChangeFireBuff(self.config.newBuffId_miniFire)
  self:AddFireMaxTier(self.arglist[1])
end

function bs_31005:OnAfterBattleStart()
  base.OnAfterBattleStart(self)
  local p_list = LuaSkillCtrl:GetAllFriendRoles()
  for _, player in ipairs(p_list) do
    LuaSkillCtrl:CallBuff(self, player, self.config.buffId, 1, nil, true)
  end
end

function bs_31005:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_31005
