local bs_4001224 = class("bs_4001224", LuaSkillBase)
local base = LuaSkillBase
bs_4001224.config = {buffId1 = 2073, buffId2 = 2084}

function bs_4001224:ctor()
end

function bs_4001224:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterHurtTrigger("bs_4010419", 1, self.OnAfterHurt, self.caster, nil, nil, eBattleRoleBelong.enemy, nil, nil, nil, nil, false)
end

function bs_4001224:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if self.caster ~= sender or isTriggerSet or sender == target or target.belongNum ~= eBattleRoleBelong.enemy then
    return
  end
  local giant = self.caster:GetBuffTier(self.config.buffId1)
  if giant == nil or giant < 1 then
    return
  end
  if giant ~= nil and 1 <= giant then
    LuaSkillCtrl:CallBuffLifeEvent(self, target, self.config.buffId2, 1, self.arglist[2], BindCallback(self, self.OnBuffLifeEvent, target))
  end
end

function bs_4001224:OnBuffLifeEvent(role, lifeType, arg)
  if lifeType == eBuffLifeEvent.NewAdd then
    LuaSkillCtrl:CallStartLocalScale(role, Vector3.New(0.6, 0.6, 0.6), 0.6)
  end
  if lifeType == eBuffLifeEvent.Remove then
    LuaSkillCtrl:CallStartLocalScale(role, Vector3.New(1, 1, 1), 0.6)
  end
end

function bs_4001224:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_4001224
