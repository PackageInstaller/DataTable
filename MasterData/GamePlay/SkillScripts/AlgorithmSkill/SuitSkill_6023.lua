local bs_6023 = class("bs_6023", LuaSkillBase)
local base = LuaSkillBase
bs_6023.config = {buffId_1 = 3004}

function bs_6023:ctor()
end

function bs_6023:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterHurtTrigger("bs_6023_4", 9, self.OnAfterHurt, nil, nil, nil, self.caster.belongNum, nil, self.caster.roleType)
end

function bs_6023:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, isRealDmg, isTriggerSet)
  if target.belongNum == self.caster.belongNum and target.roleType == self.caster.roleType then
    local num = target.hp * 1000 // target.maxHp
    if num < self.arglist[1] then
      local Value = self.caster.maxHp * self.arglist[2] // 1000
      LuaSkillCtrl:AddRoleShield(target, 0, Value)
      LuaSkillCtrl:CallBuff(self, target, self.config.buffId_1, 1, self.arglist[3], true)
      self:RemoveSkillTrigger(eSkillTriggerType.AfterHurt)
    end
  end
end

function bs_6023:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_6023
