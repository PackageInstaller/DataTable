local bs_15054 = class("bs_15054", LuaSkillBase)
local base = LuaSkillBase
bs_15054.config = {}

function bs_15054:ctor()
end

function bs_15054:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_15054_1", 1, self.OnAfterBattleStart)
  self:AddAfterHurtTrigger("bs_15054_2", 1, self.OnAfterHurt, self.caster)
  self.isXidun = true
end

function bs_15054:OnAfterBattleStart()
  local arriveCallBack = BindCallback(self, self.OnArriveAction)
  LuaSkillCtrl:StartTimer(nil, self.arglist[1], arriveCallBack)
end

function bs_15054:OnArriveAction()
  self.isXidun = false
end

function bs_15054:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if sender == self.caster and self.isXidun and not isTriggerSet then
    local sheidValue = hurt * self.arglist[2] // 1000
    LuaSkillCtrl:AddRoleShield(self.caster, eShieldType.normal, sheidValue)
  end
end

function bs_15054:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_15054
