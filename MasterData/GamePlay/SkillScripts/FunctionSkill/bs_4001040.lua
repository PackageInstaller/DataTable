local bs_4001040 = class("bs_4001040", LuaSkillBase)
local base = LuaSkillBase
bs_4001040.config = {
  buffId = 2073,
  buffId_blood = 195,
  buffId_fire = 1227,
  duration_blood = 75,
  duration_fire = 90
}

function bs_4001040:ctor()
end

function bs_4001040:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterHurtTrigger("bs_4001040", 10, self.OnAfterHurt, self.caster, nil, nil, eBattleRoleBelong.enemy, nil, nil, nil, nil)
end

function bs_4001040:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  local Giantbuff = self.caster:GetBuffTier(self.config.buffId)
  if isMiss or Giantbuff == nil or Giantbuff < 1 and isTriggerSet then
    return
  end
  if hurtType == eHurtType.PhysicsDmg then
    LuaSkillCtrl:CallBuff(self, target, self.config.buffId_blood, 1, self.config.duration_blood, true)
  end
  if hurtType == eHurtType.MagicDmg then
    LuaSkillCtrl:CallBuff(self, target, self.config.buffId_fire, 1, self.config.duration_fire, true)
  end
end

function bs_4001040:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_4001040
