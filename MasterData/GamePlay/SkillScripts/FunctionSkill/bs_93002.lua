local bs_93002 = class("bs_93002", LuaSkillBase)
local base = LuaSkillBase
bs_93002.config = {}

function bs_93002:ctor()
end

function bs_93002:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddSelfTrigger(eSkillTriggerType.AfterBattleStart, "bs_93002_1", 1, self.OnAfterBattleStart)
end

function bs_93002:OnAfterBattleStart()
  local arriveCallBack = BindCallback(self, self.OnArriveAction)
  self.timer = LuaSkillCtrl:StartTimer(nil, self.arglist[2], arriveCallBack, nil, -1, self.arglist[2])
end

function bs_93002:OnArriveAction()
  if self.timer ~= nil and self.timer:IsOver() then
    self.timer = nil
  end
  local sheildValue = self.caster.maxHp * self.arglist[1] // 1000
  LuaSkillCtrl:AddRoleShield(self.caster, eShieldType.Normal, sheildValue)
end

function bs_93002:OnCasterDie()
  base.OnCasterDie(self)
  if self.timer ~= nil then
    self.timer:Stop()
    self.timer = nil
  end
end

return bs_93002
