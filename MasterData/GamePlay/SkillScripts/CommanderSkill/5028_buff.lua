local bs_5028 = class("bs_5028", LuaSkillBase)
local base = LuaSkillBase
bs_5028.config = {
  HurtConfig = {basehurt_formula = 10127}
}

function bs_5028:ctor()
end

function bs_5028:InitSkill(isMidwaySkill)
  self:AddAfterHurtTrigger("bs_5028_1", 1, self.OnAfterHurt, nil, self.caster)
  self.healTargetList = {}
end

function bs_5028:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if sender.belongNum ~= self.caster.belongNum and target ~= nil and target.hp > 0 and target == self.caster and skill.isCommonAttack and not isMiss then
    local buffId = LuaSkillCtrl:GetSkillBindBuffId(self)
    if self.caster:GetBuffTier(buffId) >= 2 then
      local highAttRole = LuaSkillCtrl:CallTargetSelect(self, 54, 20)
      if highAttRole ~= nil and 0 < highAttRole.Count and highAttRole[0] ~= nil then
        local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, self.caster)
        LuaSkillCtrl:HurtResult(self, skillResult, self.config.HurtConfig, {
          highAttRole[0].targetRole.skill_intensity
        }, true)
        skillResult:EndResult()
      end
    end
    if self.caster ~= nil and self.caster:GetBuffTier(buffId) >= 3 and self.healTargetList[sender] == nil then
      LuaSkillCtrl:CallHeal(sender.maxHp * self.arglist[2] // 1000, self, sender, true)
      self.healTargetList[sender] = true
    end
  end
end

function bs_5028:OnCasterDie()
  base.OnCasterDie(self)
end

function bs_5028:LuaDispose()
  self.healTargetList = nil
  base.LuaDispose(self)
end

return bs_5028
