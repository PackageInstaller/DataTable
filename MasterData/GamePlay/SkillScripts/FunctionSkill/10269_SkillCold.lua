local bs_10269 = class("bs_10269", LuaSkillBase)
local base = LuaSkillBase
bs_10269.config = {
  neareastRoleSelectId = 1001,
  freezeBuff = 1178,
  freezeBuffDuration = 75,
  effectId = 10876
}

function bs_10269:InitSkill(isMidwaySkill)
  self:AddSelfTrigger(eSkillTriggerType.AfterPlaySkill, "bs_10269_1", 1, self.OnAfterPlaySkill)
end

function bs_10269:OnAfterPlaySkill(skill, role)
  if skill.maker == self.caster and not skill.isCommonAttack and self:IsReadyToTake() then
    self:AddBuffForNearestRole()
    self:OnSkillTake()
  end
end

function bs_10269:AddBuffForNearestRole()
  local targets = LuaSkillCtrl:CallTargetSelect(self, self.config.neareastRoleSelectId, 0)
  if targets ~= nil and 0 < targets.Count then
    local role = targets[0].targetRole
    if role ~= nil and 0 < role.hp and role.belongNum ~= 0 then
      local curTier = role:GetBuffTier(self.config.freezeBuff)
      if curTier >= self.arglist[1] then
        return
      end
      LuaSkillCtrl:CallEffect(role, self.config.effectId, self, self.SkillEventFunc)
      self:PlayChipEffect()
    end
  end
end

function bs_10269:SkillEventFunc(effect, eventId, target)
  if eventId == eBattleEffectEvent.Trigger then
    LuaSkillCtrl:CallBuff(self, target.targetRole, self.config.freezeBuff, self.arglist[1], self.config.freezeBuffDuration)
  end
end

function bs_10269:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_10269
