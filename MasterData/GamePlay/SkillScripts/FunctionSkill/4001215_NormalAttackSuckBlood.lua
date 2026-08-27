local bs_4001215 = class("bs_4001215", LuaSkillBase)
local base = LuaSkillBase
bs_4001215.config = {buffId = 2056}

function bs_4001215:ctor()
end

function bs_4001215:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterHurtTrigger("bs_4001215_1", 1, self.OnAfterHurt, nil, nil, eBattleRoleBelong.player, nil, nil, nil, nil, eSkillTag.commonAttack)
  self.count = 0
end

function bs_4001215:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if sender == self.caster and skill.isCommonAttack and not isTriggerSet and not isMiss then
    self.count = self.count + 1
    if self.count >= self.arglist[1] then
      self.count = 0
      local extraHpTier = hurt * self.arglist[2] // 1000
      if extraHpTier <= 0 then
        extraHpTier = 1
      end
      local Hp_pre = sender.maxHp
      LuaSkillCtrl:CallBuff(self, sender, self.config.buffId, extraHpTier)
      local Hp_ed = sender.maxHp
      local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, sender)
      LuaSkillCtrl:HealResultWithConfig(self, skillResult, 6, {
        Hp_ed - Hp_pre
      }, true, true)
    end
  end
end

function bs_4001215:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_4001215
