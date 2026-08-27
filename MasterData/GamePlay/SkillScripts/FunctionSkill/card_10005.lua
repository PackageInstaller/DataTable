local card_10005 = class("card_10005", LuaSkillBase)
local base = LuaSkillBase
card_10005.config = {}

function card_10005:ctor()
end

function card_10005:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "card_10005_1", 1, self.OnAfterBattleStart)
end

function card_10005:OnAfterBattleStart()
  local grid = LuaSkillCtrl:GetGridWithRole(self.caster)
  local gridid = LuaSkillCtrl:GetRoleEfcGrid(self.caster)
  if gridid == 0 then
    LuaSkillCtrl:CallCreateEfcGrid(grid.coord.x, grid.y, 11)
  end
end

function card_10005:OnCasterDie()
  base.OnCasterDie(self)
end

return card_10005
