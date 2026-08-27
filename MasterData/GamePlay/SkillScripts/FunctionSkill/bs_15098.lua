local bs_15098 = class("bs_15098", LuaSkillBase)
local base = LuaSkillBase
bs_15098.config = {}

function bs_15098:ctor()
end

function bs_15098:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.RoleDie, "bs_15098_10", 1, self.OnRoleDie)
end

function bs_15098:OnRoleDie(killer, role)
  if role.belongNum == eBattleRoleBelong.enemy then
    LuaSkillCtrl:CallAddPlayerHmp(ConfigData.game_config.ultMpCost * self.arglist[1] // 1000)
  end
end

function bs_15098:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_15098
