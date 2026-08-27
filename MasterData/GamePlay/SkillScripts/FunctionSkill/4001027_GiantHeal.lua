local bs_4001027 = class("bs_4001027", LuaSkillBase)
local base = LuaSkillBase
bs_4001027.config = {buffId = 2056}

function bs_4001027:ctor()
end

function bs_4001027:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterHurtTrigger("bs_4001027_1", 1, self.OnAfterHurt, nil, nil, nil, eBattleRoleBelong.player)
  self.count = 0
end

function bs_4001027:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if target == self.caster and target.maxHp >= self.arglist[1] then
    self.count = self.count + 1
    if self.count >= self.arglist[2] then
      local healNum = self.arglist[3]
      local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, self.caster)
      LuaSkillCtrl:HealResultWithConfig(self, skillResult, 6, {healNum}, true, true)
      self.count = 0
    end
  end
end

function bs_4001027:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_4001027
