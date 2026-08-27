local card_10002 = class("card_10002", LuaSkillBase)
local base = LuaSkillBase
card_10002.config = {buffId = 1503}

function card_10002:ctor()
end

function card_10002:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "card_10002", 1, self.OnAfterBattleStart)
end

function card_10002:OnAfterBattleStart()
  LuaSkillCtrl:CallBuff(self, self.caster, 1503, 1, nil, true)
  local grid = LuaSkillCtrl:GetGridWithRole(self.caster)
  if grid ~= nil then
    LuaSkillCtrl:CallCreateEfcGrid(grid.coord.x, grid.coord.y, 35)
  end
end

function card_10002:OnCasterDie()
  base.OnCasterDie(self)
end

return card_10002
