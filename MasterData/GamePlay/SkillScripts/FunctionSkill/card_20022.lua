local card_20022 = class("card_20022", LuaSkillBase)
local base = LuaSkillBase
card_20022.config = {}

function card_20022:ctor()
end

function card_20022:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "card_20022_1", 1, self.OnAfterBattleStart)
end

function card_20022:OnAfterBattleStart()
  local arriveCallBack = BindCallback(self, self.OnArriveAction)
  local times = self.arglist[3] // self.arglist[2] - 1
  self.timer = LuaSkillCtrl:StartTimer(nil, self.arglist[2], arriveCallBack, nil, times, self.arglist[2])
end

function card_20022:OnArriveAction()
  if self.timer ~= nil and self.timer:IsOver() then
    self.timer = nil
  end
  local hurt = self.caster.maxHp * self.arglist[1] // 1000
  LuaSkillCtrl:RemoveLife(hurt, self, self.caster, true, nil, true, true, eHurtType.RealDmg)
end

function card_20022:OnCasterDie()
  base.OnCasterDie(self)
end

return card_20022
