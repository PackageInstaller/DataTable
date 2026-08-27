local card_20010 = class("card_20010", LuaSkillBase)
local base = LuaSkillBase
card_20010.config = {}

function card_20010:ctor()
end

function card_20010:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddLuaTrigger(eSkillLuaTrigger.OnAddShield, self.OnAddShield, self)
end

function card_20010:OnAddShield(role, shieldType)
  if role.belongNum == eBattleRoleBelong.player then
    LuaSkillCtrl:ClearAllShield(role)
  end
end

function card_20010:OnCasterDie()
  base.OnCasterDie(self)
end

return card_20010
