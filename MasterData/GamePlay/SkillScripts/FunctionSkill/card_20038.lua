local card_20038 = class("card_20038", LuaSkillBase)
local base = LuaSkillBase
card_20038.config = {effectId = 12083}

function card_20038:ctor()
end

function card_20038:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddOnRoleDieTrigger("card_20038", 1, self.OnRoleDie, nil, nil, nil, nil, nil, eBattleRoleType.realSummoner, nil)
end

function card_20038:OnRoleDie(killer, role)
  local p_list = LuaSkillCtrl:CallTargetSelect(self, 95, 10)
  if p_list.Count < 1 then
    return
  end
  local rand = LuaSkillCtrl:CallRange(0, p_list.Count - 1)
  local targetRole = p_list[rand]
  local value = role.maxHp * self.arglist[1] // 1000
  LuaSkillCtrl:CallEffectWithArgAndSpeedOverride(targetRole, self.config.effectId, self, role, 1, false, false, self.SkillEventFunc, value)
end

function card_20038:SkillEventFunc(value, effect, eventId, target)
  if eventId == eBattleEffectEvent.Trigger then
    local skillResult1 = LuaSkillCtrl:CallSkillResultNoEffect(self, target)
    LuaSkillCtrl:HurtResultWithConfig(self, skillResult1, 14, {value}, true, true)
    skillResult1:EndResult()
  end
end

function card_20038:OnCasterDie()
  base.OnCasterDie(self)
end

return card_20038
