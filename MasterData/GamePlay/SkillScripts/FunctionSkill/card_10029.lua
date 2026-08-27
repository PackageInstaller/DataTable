local card_10029 = class("card_10029", LuaSkillBase)
local base = LuaSkillBase
card_10029.config = {buffId1 = 1605, buffId2 = 1606}

function card_10029:ctor()
end

function card_10029:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self.target_list = {}
  self.arriveCallBack = BindCallback(self, self.eventFunc)
  self:AddAfterHurtTriggerForTable("card_10029", 1, self.OnAfterHurt, {
    sender = self.caster,
    extraArg3 = false
  })
end

function card_10029:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if target.hp > 0 and sender == self.caster and not isMiss and skill.skillType == eBattleSkillLogicType.Original and self.target_list[target] == nil then
    self.target_list[target] = true
    LuaSkillCtrl:CallBuff(self, sender, self.config.buffId1, 1, 30, true)
    LuaSkillCtrl:CallBuff(self, target, self.config.buffId2, 1, 30, true)
    LuaSkillCtrl:StartTimer(nil, 30, self.arriveCallBack, target)
  end
end

function card_10029:eventFunc(target)
  self.target_list[target] = nil
  LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId1, 1, true, true)
end

function card_10029:OnCasterDie()
  base.OnCasterDie(self)
end

function card_10029:LuaDispose()
  base.LuaDispose(self)
  self.target_list = nil
end

return card_10029
