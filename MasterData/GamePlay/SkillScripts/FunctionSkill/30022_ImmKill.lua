local bs_30022 = class("bs_30022", LuaSkillBase)
local base = LuaSkillBase
bs_30022.config = {
  effectId = 10879,
  effectId1 = 10882,
  buffId1 = 50,
  buffId2 = 278,
  delay = 5,
  buffTier = 1
}

function bs_30022:ctor()
end

function bs_30022:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterHurtTrigger("bs_30022_3", 1, self.OnAfterHurt, self.caster)
end

function bs_30022:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if sender == self.caster and target.hp * 1000 // target.maxHp < self.arglist[1] and target.intensity <= 2 and self:IsReadyToTake() then
    self:OnSkillTake()
    LuaSkillCtrl:CallEffect(target, self.config.effectId, self)
    local hurt = target.maxHp * self.arglist[1] // 1000
    LuaSkillCtrl:RemoveLife(hurt, self, target, true, nil, true, false, eHurtType.RealDmg)
  end
end

function bs_30022:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_30022
