local card_10010 = class("card_10010", LuaSkillBase)
local base = LuaSkillBase
card_10010.config = {}

function card_10010:ctor()
end

function card_10010:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddLuaTrigger(eSkillLuaTrigger.OnAddShield, self.OnAddShield, self.caster)
end

function card_10010:OnAddShield(role, shieldType, value, addValue)
  if role.belongNum == eBattleRoleBelong.player then
    local sheidValue = addValue * self.arglist[1] // 1000
    LuaSkillCtrl:AddRoleShield(role, shieldType, sheidValue, nil, true)
  end
end

function card_10010:OnCasterDie()
  if self.damTimer ~= nil then
    self.damTimer:Stop()
    self.damTimer = nil
  end
  base.OnCasterDie(self)
end

return card_10010
