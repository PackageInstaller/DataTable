local bs_4001031 = class("bs_4001031", LuaSkillBase)
local base = LuaSkillBase
bs_4001031.config = {buffId = 1272, duration = 75}

function bs_4001031:ctor()
end

function bs_4001031:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterHurtTrigger("bs_4001031_1", 1, self.OnAfterHurt, nil, nil, nil, eBattleRoleBelong.player, nil, nil, nil, nil, false)
end

function bs_4001031:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if self.caster == target and not isMiss and not isTriggerSet then
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, 1, nil, true)
  end
end

function bs_4001031:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_4001031
