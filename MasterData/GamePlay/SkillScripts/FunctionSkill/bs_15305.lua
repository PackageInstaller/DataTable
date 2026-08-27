local bs_15305 = class("bs_15305", LuaSkillBase)
local base = LuaSkillBase
bs_15305.config = {effectId = 12086, effectId1 = 12085}

function bs_15305:ctor()
end

function bs_15305:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_15305_1", 1, self.OnAfterBattleStart)
  self:AddAfterHurtTrigger("bs_15305_2", 1, self.OnAfterHurt, self.caster, nil, nil, eBattleRoleBelong.enemy)
end

function bs_15305:OnAfterBattleStart()
end

function bs_15305:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if sender == self.caster and 0 < hurt and not isMiss and not isTriggerSet then
    local SecondaryHurt = hurt * self.arglist[1] // 1000
    local targetList = LuaSkillCtrl:CallTargetSelect(self, 22, 10)
    if 1 < targetList.Count then
      local targetRole = targetList[0].targetRole
      if targetRole == target then
        targetRole = targetList[1].targetRole
      end
      if targetRole.belongNum ~= eBattleRoleBelong.enemy then
        return
      end
      LuaSkillCtrl:CallEffect(target, self.config.effectId1, self)
      LuaSkillCtrl:CallEffect(targetRole, self.config.effectId1, self)
      LuaSkillCtrl:CallEffect(targetRole, self.config.effectId, self, nil, target)
      local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, targetRole)
      LuaSkillCtrl:HurtResultWithConfig(self, skillResult, 14, {SecondaryHurt}, true, true)
      skillResult:EndResult()
    end
  end
end

function bs_15305:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_15305
