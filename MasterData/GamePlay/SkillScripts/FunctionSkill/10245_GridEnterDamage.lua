local bs_10245 = class("bs_10245", LuaSkillBase)
local base = LuaSkillBase
bs_10245.config = {
  hurt_config = {basehurt_formula = 10076},
  effectIdAttack = 10638
}

function bs_10245:ctor()
end

function bs_10245:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.OnSelfAfterMove, "bs_10245_1", 1, self.OnAfterMove)
end

function bs_10245:OnAfterMove()
  if LuaSkillCtrl:GetRoleEfcGrid(self.caster) ~= 0 then
    local targetlist = LuaSkillCtrl:CallTargetSelect(self, 1001, 10)
    if targetlist.Count < 1 then
      return
    end
    LuaSkillCtrl:CallEffect(targetlist[0].targetRole, self.config.effectIdAttack, self, self.SkillEventFunc)
  end
end

function bs_10245:SkillEventFunc(effect, eventId, target)
  if eventId == eBattleEffectEvent.Trigger then
    local skillResult = LuaSkillCtrl:CallSkillResult(effect, target)
    LuaSkillCtrl:HurtResult(self, skillResult, self.config.hurt_config, nil, true)
    skillResult:EndResult()
  end
end

function bs_10245:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_10245
