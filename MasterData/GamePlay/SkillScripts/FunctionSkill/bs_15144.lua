local bs_15144 = class("bs_15144", LuaSkillBase)
local base = LuaSkillBase
bs_15144.config = {effectId = 12067}

function bs_15144:ctor()
end

function bs_15144:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterPlaySkillTrigger("bs_15144_3", 1, self.OnAfterPlaySkill, nil, nil, self.caster.belongNum, nil, eBattleRoleType.character, nil, nil, eSkillTag.commonAttack)
  self.damageNum = 0
end

function bs_15144:OnAfterPlaySkill(skill, role)
  if skill.isCommonAttack then
    self:findMax()
    if skill.moveSelectTarget == nil or skill.moveSelectTarget.targetRole == nil then
      return
    end
    LuaSkillCtrl:CallEffect(skill.moveSelectTarget.targetRole, self.config.effectId, self, self.SkillEventFunc)
  end
end

function bs_15144:SkillEventFunc(effect, eventId, target)
  if eventId == eBattleEffectEvent.Trigger then
    local skillResult1 = LuaSkillCtrl:CallSkillResultNoEffect(self, target)
    LuaSkillCtrl:HurtResultWithConfig(self, skillResult1, 14, {
      self.damageNum
    }, true, true)
    skillResult1:EndResult()
  end
end

function bs_15144:findMax()
  local role, baseDamage = LuaSkillCtrl:CallFindMaxPowOrSkillIntensityRole()
  if role ~= nil then
    self.damageNum = baseDamage * self.arglist[1] // 1000
  end
end

function bs_15144:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_15144
