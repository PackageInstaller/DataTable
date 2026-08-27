local bs_20095 = class("bs_20095", LuaSkillBase)
local base = LuaSkillBase
bs_20095.config = {buffId = 32}

function bs_20095:ctor()
end

function bs_20095:InitSkill(isMidwaySkill)
  self.undead = true
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterHurtTrigger("bs_20095_3", 1, self.OnAfterHurt)
  self:AddSetHurtTrigger("bs_20095_2", 99, self.OnSetHurt, nil, self.caster)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_20095_1", 1, self.OnAfterBattleStart)
end

function bs_20095:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if target ~= self.caster and target.roleDataId ~= 40003 and not self.undead then
    local damage = self.caster.hp // 20
    LuaSkillCtrl:RemoveLife(damage, self, self.caster, true, nil, true)
  elseif target ~= self.caster and target.roleDataId == 40003 then
    local damage = self.caster.maxHp * hurt // (target.maxHp + 1)
    LuaSkillCtrl:RemoveLife(damage, self, self.caster, true, nil, true)
  elseif target == self.caster and sender.roleDataId == 40003 then
    local damage = sender.maxHp * hurt // (self.caster.maxHp + 1)
    LuaSkillCtrl:RemoveLife(damage, self, sender, true, nil, true)
  end
end

function bs_20095:OnSetHurt(context)
  if context.target == self.caster and context.hurt > self.caster.hp then
    context.hurt = 0
  end
end

function bs_20095:OnAfterBattleStart()
  local arriveCallBack = BindCallback(self, self.OnArriveAction)
  LuaSkillCtrl:StartTimer(nil, 150, arriveCallBack)
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, 1, nil, true)
end

function bs_20095:OnArriveAction()
  self.undead = false
end

function bs_20095:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_20095
