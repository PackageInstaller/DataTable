local card_10004 = class("card_10004", LuaSkillBase)
local base = LuaSkillBase
card_10004.config = {}

function card_10004:ctor()
end

function card_10004:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterHurtTrigger("card_10004_3", 1, self.OnAfterHurt, self.caster)
end

function card_10004:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if sender == self.caster and skill.isCommonAttack and not isTriggerSet and not isMiss then
    local grid = LuaSkillCtrl:GetGridWithRole(target)
    local gridid = LuaSkillCtrl:GetRoleEfcGrid(target)
    if gridid == 0 then
      LuaSkillCtrl:CallCreateEfcGrid(grid.coord.x, grid.y, 36)
    end
  end
end

function card_10004:OnCasterDie()
  base.OnCasterDie(self)
end

return card_10004
