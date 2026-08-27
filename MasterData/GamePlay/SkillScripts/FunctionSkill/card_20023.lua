local card_20023 = class("card_20023", LuaSkillBase)
local base = LuaSkillBase
card_20023.config = {}

function card_20023:ctor()
end

function card_20023:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterHurtTriggerForTable("card_20023", 1, self.OnAfterHurt, {
    senderBelongNum = eBattleRoleBelong.player,
    target = self.caster,
    extraArg1 = eSkillTag.commonAttack,
    extraArg2 = false,
    extraArg3 = false
  })
end

function card_20023:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if target.hp > 0 and skill.isCommonAttack and not isMiss and not isTriggerSet and sender.belongNum == 1 then
    local distance = LuaSkillCtrl:GetRoleGridsDistance(sender, target) - 1
    local damage = self.arglist[1] * target.pow // (1000 + 1000 * distance)
    LuaSkillCtrl:RemoveLife(damage, self, sender, true, nil, true, true, eHurtType.RealDmg)
  end
end

function card_20023:OnCasterDie()
  base.OnCasterDie(self)
end

return card_20023
