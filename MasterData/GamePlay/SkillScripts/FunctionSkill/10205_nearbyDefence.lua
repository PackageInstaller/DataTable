local bs_10205 = class("bs_10205", LuaSkillBase)
local base = LuaSkillBase
bs_10205.config = {
  defFormula = 10071,
  effectId = 10243,
  buffId = 1012
}

function bs_10205:ctor()
end

function bs_10205:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_10205_1", 1, self.OnAfterBattleStart)
end

function bs_10205:OnAfterBattleStart()
  self:PlayChipEffect()
  local targetList = LuaSkillCtrl:CallTargetSelect(self, 41, 0)
  if 0 < targetList.Count then
    for i = 0, targetList.Count - 1 do
      local targetRole = targetList[i].targetRole
      local defTier = LuaSkillCtrl:CallFormulaNumberWithSkill(self.config.defFormula, self.caster, targetRole, self)
      LuaSkillCtrl:CallBuff(self, targetRole, self.config.buffId, defTier, nil, true)
      LuaSkillCtrl:CallEffect(targetRole, self.config.effectId, self)
    end
  end
end

function bs_10205:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_10205
