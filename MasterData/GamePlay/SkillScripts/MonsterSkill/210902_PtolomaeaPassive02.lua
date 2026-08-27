local bs_210902 = class("bs_210902", LuaSkillBase)
local base = LuaSkillBase
bs_210902.config = {}

function bs_210902:ctor()
end

function bs_210902:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_210902_1", 1, self.OnAfterBattleStart)
end

function bs_210902:OnAfterBattleStart()
  local grid = LuaSkillCtrl:GetGridWithRole(self.caster)
  if grid ~= nil then
    LuaSkillCtrl:CallCreateEfcGrid(grid.coord.x, grid.coord.y, 1126)
  end
end

function bs_210902:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_210902
