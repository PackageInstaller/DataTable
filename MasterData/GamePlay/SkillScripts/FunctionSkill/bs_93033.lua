local bs_93033 = class("bs_93033", LuaSkillBase)
local base = LuaSkillBase
bs_93033.config = {
  effectId2 = 10991,
  buffId1 = 2033,
  buffId2 = 2034,
  hurt_config = {
    hit_formula = 0,
    crit_formula = 0,
    basehurt_formula = 502
  }
}

function bs_93033:ctor()
end

function bs_93033:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterHurtTrigger("bs_93033_1", 1, self.OnAfterHurt, nil)
  self:AddTrigger(eSkillTriggerType.OnAfterShieldHurt, "bs_93033_3", 3, self.OnAfterShieldHurt)
  self.HpPercent = 1
  self.highHpTarget = nil
  self.ShieldNum = 0
  self.costValue = 0
  self.triggerCount = 0
end

function bs_93033:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, isRealDmg, isTriggerSet)
  if target.hp > 0 and target.hp * 1000 // target.maxHp <= self.arglist[1] and self.HpPercent == 1 and target.belongNum == eBattleRoleBelong.player and self.triggerCount == 0 then
    self.HpPercent = 0
    local targetListMax = LuaSkillCtrl:CallTargetSelect(self, 68, 10)
    if 0 < targetListMax.Count then
      self.highHpTarget = targetListMax[0].targetRole
      local targetlist = LuaSkillCtrl:CallTargetSelect(self, 6, 10)
      if 0 >= targetlist.Count then
        return
      end
      for i = 0, targetlist.Count - 1 do
        self.ShieldNum = self.ShieldNum + targetlist[i].targetRole.maxHp
      end
      self.ShieldNum = self.ShieldNum * self.arglist[2] // 1000
      self:PlayChipEffect()
      LuaSkillCtrl:AddRoleShield(self.highHpTarget, eShieldType.Normal, self.ShieldNum)
      LuaSkillCtrl:CallBuff(self, self.highHpTarget, self.config.buffId2, 1, nil, true)
      LuaSkillCtrl:CallStartLocalScale(self.highHpTarget, Vector3.New(1.3, 1.3, 1.3), 0.3)
      local targetlistEnemy = LuaSkillCtrl:CallTargetSelect(self, 9, 10)
      self.triggerCount = 1
      for i = 0, targetlistEnemy.Count - 1 do
        local targetRole = targetlistEnemy[i].targetRole
        LuaSkillCtrl:CallBuff(self, targetRole, self.config.buffId1, 1, nil, true, self.highHpTarget)
      end
      self.timer = LuaSkillCtrl:StartTimer(nil, self.arglist[3], self.CallBack, self, 0)
    end
  end
end

function bs_93033:OnAfterShieldHurt(context)
  if self.HpPercent == 0 and context.target == self.highHpTarget and self.highHpTarget ~= nil and self.timer ~= nil then
    self.costValue = context.shield_cost_hurt + self.costValue
    if self.costValue >= self.ShieldNum then
      LuaSkillCtrl:DispelBuff(self.highHpTarget, self.config.buffId2, 0, true)
      LuaSkillCtrl:CallEffect(self.highHpTarget, self.config.effectId2, self)
      self.costValue = self.costValue * self.arglist[4] // 1000
      local targetlistEnemy = LuaSkillCtrl:CallTargetSelect(self, 9, 10)
      for i = 0, targetlistEnemy.Count - 1 do
        local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, targetlistEnemy[i].targetRole)
        LuaSkillCtrl:HurtResult(self, skillResult, self.config.hurt_config, {
          self.costValue
        })
        skillResult:EndResult()
      end
      self.HpPercent = 1
    end
  end
end

function bs_93033:CallBack()
  if self.timer ~= nil and self.timer:IsOver() then
    self.timer = nil
  end
  local targetlistEnemy = LuaSkillCtrl:CallTargetSelect(self, 9, 10)
  for i = 0, targetlistEnemy.Count - 1 do
    local targetRole = targetlistEnemy[i].targetRole
    LuaSkillCtrl:DispelBuff(targetRole, self.config.buffId1, 0, true)
  end
  LuaSkillCtrl:CallStartLocalScale(self.highHpTarget, Vector3.New(1, 1, 1), 0.3)
  if self.HpPercent == 0 then
    LuaSkillCtrl:DispelBuff(self.highHpTarget, self.config.buffId2, 0, true)
    LuaSkillCtrl:CallEffect(self.highHpTarget, self.config.effectId2, self)
    local targetlistEnemy = LuaSkillCtrl:CallTargetSelect(self, 9, 10)
    self.costValue = self.costValue * self.arglist[4] // 1000
    for i = 0, targetlistEnemy.Count - 1 do
      local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, targetlistEnemy[i].targetRole)
      LuaSkillCtrl:HurtResult(self, skillResult, self.config.hurt_config, {
        self.costValue
      })
      skillResult:EndResult()
    end
    self.HpPercent = 2
  end
end

function bs_93033:OnCasterDie()
  base.OnCasterDie(self)
  if self.timer then
    self.timer:Stop()
    self.timer = nil
  end
end

return bs_93033
