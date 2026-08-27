local career_102 = class("career_102", LuaSkillBase)
local base = LuaSkillBase
career_102.config = {}

function career_102:ctor()
end

function career_102:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterHurtTriggerForTable("career_102_5", 1, self.OnAfterHurt, {
    senderBelongNum = eBattleRoleBelong.player,
    targetBelongNum = eBattleRoleBelong.enemy,
    targetRoleType = eBattleRoleType.character
  })
end

function career_102:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if target.belongNum == eBattleRoleBelong.enemy and sender.belongNum == eBattleRoleBelong.player and not isMiss and skill.isCommonAttack and LuaSkillCtrl:GetGridsDistance(sender.x, sender.y, target.x, target.y) > 2 then
    LuaSkillCtrl:RemoveLife(self.arglist[1], self, target, true, nil, true, true, eHurtType.RealDmg)
    self:PlayChipEffect()
  end
end

function career_102:OnCasterDie()
  base.OnCasterDie(self)
end

return career_102
