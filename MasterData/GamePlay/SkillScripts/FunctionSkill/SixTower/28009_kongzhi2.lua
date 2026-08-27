local sixtower_kongzhi = class("sixtower_kongzhi", LuaSkillBase)
local base = LuaSkillBase
sixtower_kongzhi.config = {effect = 12207}

function sixtower_kongzhi:ctor()
end

function sixtower_kongzhi:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddSelfTrigger(eSkillTriggerType.OnBtRoleBreakStateEnter, "sixtower_kongzhi", 2, self._OnEnterBreak)
end

function sixtower_kongzhi:_OnEnterBreak(role)
  if role ~= self.caster then
    return
  end
  LuaSkillCtrl:CallEffect(self.caster, self.config.effect, self, self.SkillEventFunc)
end

function sixtower_kongzhi:SkillEventFunc(effect, eventId, target)
  if eventId == eBattleEffectEvent.Trigger then
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target)
    LuaSkillCtrl:HurtResultWithConfig(self, skillResult, 54, {
      self.arglist[1]
    })
    skillResult:EndResult()
  end
end

function sixtower_kongzhi:OnCasterDie()
  base.OnCasterDie(self)
end

return sixtower_kongzhi
