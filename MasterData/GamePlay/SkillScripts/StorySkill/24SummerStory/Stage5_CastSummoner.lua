local StorySkillBase = require("GamePlay.SkillScripts.StorySkill.StorySkillBase")
local sc_2 = class("sc_2", StorySkillBase)
local base = StorySkillBase
sc_2.config = {roleId = 20035}
sc_2.config = setmetatable(sc_2.config, {
  __index = base.config
})

function sc_2:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function sc_2:OnAfterBattleStart()
  base.OnAfterBattleStart(self)
  self.die_star = self:GetRole(self.config.roleId)
  LuaSkillCtrl:StartTimer(nil, self.arglist[3], self.EventFunction, self)
end

function sc_2:EventFunction()
  if self.die_star == nil then
    local plist = LuaSkillCtrl:GetSelectTeamRoles(eBattleRoleBelong.player)
    self.die_star = plist[0]
  end
  local attr_table = {
    maxHp = self.die_star.maxHp * 100 // 1000,
    pow = self.die_star.pow * 100 // 1000,
    skill_intensity = self.die_star.skill_intensity * 100 // 1000,
    speed = self.die_star.speed,
    def = self.die_star.def * 100 // 1000,
    crit = self.die_star.crit,
    critDamage = self.die_star.critDamage,
    sunder = self.die_star.sunder,
    magic_res = self.die_star.magic_res,
    magic_pen = self.die_star.magic_pen
  }
  for i = 0, self.arglist[2] - 1 do
    local empty_grid = LuaSkillCtrl:FindEmptyGrid()
    self:CastSummoner(empty_grid.x, empty_grid.y, self.arglist[1], eBattleRoleBelong.player, attr_table)
  end
end

function sc_2:OnCasterDie()
  base.OnCasterDie(self)
end

return sc_2
