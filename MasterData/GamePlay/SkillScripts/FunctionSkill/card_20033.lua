local card_20033 = class("card_20033", LuaSkillBase)
local base = LuaSkillBase
card_20033.config = {buffId_1 = 1609, buffId_2 = 1610}

function card_20033:ctor()
end

function card_20033:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterHurtTrigger("card_20033_1", 1, self.OnAfterHurt, nil, self.caster)
end

function card_20033:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if target == self.caster and not isMiss and not isCrit and skill.skillType == eBattleSkillLogicType.Original then
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_2, 1, 45, true)
  elseif target == self.caster and isCrit and skill.skillType == eBattleSkillLogicType.Original then
    LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId_2, 0, true, false)
  end
end

function card_20033:LuaDispose()
  base.LuaDispose(self)
end

return card_20033
