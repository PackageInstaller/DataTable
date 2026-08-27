local bs_4035 = class("bs_4035", LuaSkillBase)
local base = LuaSkillBase
bs_4035.config = {effect_trail_1 = 213903, HurtConfigID = 3}

function bs_4035:ctor()
end

function bs_4035:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddSelfTrigger(eSkillTriggerType.AfterPlaySkill, "bs_4035_2", 1, self.OnAfterPlaySkill)
end

function bs_4035:OnAfterPlaySkill(skill, role)
  if role == self.caster and skill.isNormalSkill then
    local last_target = self.caster.recordTable.lastAttackRole
    local target
    if last_target ~= nil and last_target.hp > 0 and last_target.belongNum ~= eBattleRoleBelong.neutral and LuaSkillCtrl:IsAbleAttackTarget(self.caster, last_target, 10) then
      target = last_target
    end
    LuaSkillCtrl:CallEffectWithArgOverride(target, self.config.effect_trail_1, self, self.caster, nil, nil, self.SkillEventFunc_1)
  end
end

function bs_4035:SkillEventFunc_1(effect, eventId, target)
  if effect.dataId == self.config.effect_trail_1 and eventId == eBattleEffectEvent.Trigger then
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target)
    LuaSkillCtrl:HurtResultWithConfig(self, skillResult, self.config.HurtConfigID, {
      self.arglist[1]
    }, true)
    skillResult:EndResult()
  end
end

function bs_4035:LuaDispose()
  base.LuaDispose(self)
end

function bs_4035:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_4035
