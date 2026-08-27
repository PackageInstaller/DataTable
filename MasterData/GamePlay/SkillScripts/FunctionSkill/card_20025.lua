local card_20025 = class("card_20025", LuaSkillBase)
local base = LuaSkillBase
card_20025.config = {buffId = 1601}

function card_20025:ctor()
end

function card_20025:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterHurtTriggerForTable("card_20025", 1, self.OnAfterHurt, {
    sender = self.caster,
    targetBelongNum = eBattleRoleBelong.player,
    extraArg2 = false
  })
end

function card_20025:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if target.hp > 0 and isMiss and not isTriggerSet then
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, 1)
  elseif not isMiss and not isTriggerSet then
    LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId, 0)
  end
end

function card_20025:OnCasterDie()
  base.OnCasterDie(self)
end

return card_20025
