local bs_15312 = class("bs_15312", LuaSkillBase)
local base = LuaSkillBase
bs_15312.config = {
  heal_config = {baseheal_formula = 3021},
  effectId = 10634
}

function bs_15312:InitSkill(isMidwaySkill)
  self:AddSetHurtTrigger("bs_15312_1", 1, self.OnSetHurt, self.caster, nil, nil, nil, nil, nil, nil, eSkillTag.ultSkill)
end

function bs_15312:OnSetHurt(context)
  if context.skill.skillType ~= eBattleSkillLogicType.Original then
    return
  end
  local targetList = LuaSkillCtrl:GetSelectTeamRoles(eBattleRoleBelong.player)
  if targetList == nil then
    return
  end
  if targetList.Count > 0 then
    for i = 0, targetList.Count - 1 do
      local targetRole = targetList[i]
      local heal = context.hurt * self.arglist[1] // 1000
      if 0 < heal then
        LuaSkillCtrl:CallEffect(targetRole, self.config.effectId, self)
        local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, targetRole)
        LuaSkillCtrl:HealResult(skillResult, self.config.heal_config, {heal}, true)
      end
      self:PlayChipEffect()
    end
  end
end

function bs_15312:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_15312
