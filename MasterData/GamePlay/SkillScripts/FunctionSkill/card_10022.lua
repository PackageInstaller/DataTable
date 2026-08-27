local card_10022 = class("card_10022", LuaSkillBase)
local base = LuaSkillBase
card_10022.config = {}

function card_10022:ctor()
end

function card_10022:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterHurtTriggerForTable("card_10022", 1, self.OnAfterHurt, {
    target = self.caster,
    extraArg3 = false
  })
  self.flag = 0
  self.arriveCallBack = BindCallback(self, self.OnArriveAction)
end

function card_10022:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if not isMiss then
    local hurt = self.caster.maxHp * self.arglist[1] // 1000
    local times = self.arglist[4] // self.arglist[3]
    LuaSkillCtrl:RemoveLife(hurt, self, self.caster, true, nil, true, true, eHurtType.RealDmg)
    self.timer = LuaSkillCtrl:StartTimer(nil, self.arglist[3], self.arriveCallBack, self.arglist[3], times, self.arglist[3])
    self:RemoveSkillTrigger(eSkillTriggerType.AfterHurt)
  end
end

function card_10022:OnArriveAction()
  if self.timer ~= nil and self.timer:IsOver() then
    self.timer = nil
  end
  if self.flag > 0 then
    local heal = self.caster.maxHp * self.arglist[2] // 1000
    LuaSkillCtrl:CallHeal(heal, self, self.caster, true)
  end
  self.flag = self.flag + 1
end

function card_10022:OnCasterDie()
  base.OnCasterDie(self)
end

function card_10022:LuaDispose()
  base.LuaDispose(self)
  self.arriveCallBack = nil
end

return card_10022
