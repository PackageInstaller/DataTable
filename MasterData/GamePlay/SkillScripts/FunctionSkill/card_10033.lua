local card_10033 = class("card_10033", LuaSkillBase)
local base = LuaSkillBase
card_10033.config = {buffId_1 = 1609, buffId_2 = 1610}

function card_10033:ctor()
end

function card_10033:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterHurtTrigger("card_10033_1", 1, self.OnAfterHurt, self.caster)
end

function card_10033:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if sender == self.caster and isCrit and skill.skillType == eBattleSkillLogicType.Original then
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_1, 1, 45, true)
  end
end

function card_10033:LuaDispose()
  base.LuaDispose(self)
end

return card_10033
