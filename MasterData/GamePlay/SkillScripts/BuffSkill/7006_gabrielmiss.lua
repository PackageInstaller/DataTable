local bs_7006 = class("bs_7006", LuaSkillBase)
local base = LuaSkillBase
bs_7006.config = {
  effectId_CD = 10821,
  effectId1 = nil,
  effectId2 = 10495,
  effectId3 = 10496,
  effectId4 = 10497,
  effectId5 = 10498,
  hurt_delay = 9,
  hurtconfig = {hit_formula = 0, basehurt_formula = 10043}
}

function bs_7006:ctor()
end

function bs_7006:InitSkill(isMidwaySkill)
  self:AddAfterHurtTrigger("bs_7006_3", 1, self.OnAfterHurt, nil, self.caster)
end

function bs_7006:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if target == self.caster and skill.isCommonAttack and isMiss then
    LuaSkillCtrl:CallEffect(self.caster, self.config.effectId_CD, self)
    local skills = self.caster:GetBattleSkillList()
    if skills ~= nil then
      local skillCount = skills.Count
      if 0 < skillCount then
        for j = 0, skillCount - 1 do
          local curTotalCd = self.arglist[3]
          LuaSkillCtrl:CallResetCDForSingleSkill(skills[j], curTotalCd)
        end
      end
    end
    if self.caster.recordTable["20048_root1arg1"] ~= nil then
      if effectId1 ~= nil then
        LuaSkillCtrl:CallEffect(self.caster, self.config.effectId1, self)
      end
      LuaSkillCtrl:CallEffect(self.caster, self.config.effectId2, self)
      LuaSkillCtrl:CallEffect(self.caster, self.config.effectId3, self)
      LuaSkillCtrl:CallEffect(sender, self.config.effectId4, self)
      LuaSkillCtrl:CallEffect(sender, self.config.effectId5, self)
      self:OnHurtExecute(sender)
    end
  end
end

function bs_7006:OnHurtExecute(sender)
  local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, sender)
  LuaSkillCtrl:HurtResult(self, skillResult, self.config.hurtconfig)
  skillResult:EndResult()
end

function bs_7006:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_7006
