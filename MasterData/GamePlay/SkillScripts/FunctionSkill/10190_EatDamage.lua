local bs_10190 = class("bs_10190", LuaSkillBase)
local base = LuaSkillBase
bs_10190.config = {
  hurt_config = {basehurt_formula = 10076},
  effectId = 10254
}

function bs_10190:ctor()
end

function bs_10190:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddLuaTrigger(eSkillLuaTrigger.OnDoodad, self.OnDoodad)
end

function bs_10190:OnDoodad(sender, targetRole)
  if targetRole == self.caster then
    local targetList = LuaSkillCtrl:CallTargetSelect(self, 1, 20)
    if targetList ~= nil and targetList.Count > 0 then
      local hurtTarget = targetList[0].targetRole
      if hurtTarget ~= nil then
        LuaSkillCtrl:CallEffect(hurtTarget, self.config.effectId, self, self.SkillEventFunc)
        self:PlayChipEffect()
      end
    end
  end
end

function bs_10190:SkillEventFunc(effect, eventId, target)
  if eventId == eBattleEffectEvent.Trigger then
    local skillResult = LuaSkillCtrl:CallSkillResult(effect, target)
    LuaSkillCtrl:HurtResult(self, skillResult, self.config.hurt_config, nil, true)
    skillResult:EndResult()
  end
end

function bs_10190:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_10190
