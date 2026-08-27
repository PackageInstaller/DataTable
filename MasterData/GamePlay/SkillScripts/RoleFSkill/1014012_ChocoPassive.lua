local base = require("GamePlay.SkillScripts.RoleFSkill.FakeCommonPassive")
local bs_1014012 = class("bs_1014012", base)
bs_1014012.config = {
  buffId_choocolate = 101402,
  effectId_passive = 101404,
  selectId_pass = 6,
  select_range = -1,
  heal_config = {baseheal_formula = 3021}
}

function bs_1014012:ctor()
end

function bs_1014012:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddSelfTrigger(eSkillTriggerType.AfterBattleStart, "bs_1014012_1", 1, self.OnAfterBattleStart)
  self:AddSelfTrigger(eSkillTriggerType.AfterPlaySkill, "bs_1014012_12", 1, self.OnAfterPlaySkill)
end

function bs_1014012:OnAfterBattleStart()
  self.passive = LuaSkillCtrl:StartTimer(nil, self.arglist[1], function()
    local num = self.caster:GetBuffTier(self.config.buffId_choocolate) * self.arglist[2]
    local targetList = LuaSkillCtrl:CallTargetSelect(self, self.config.selectId_pass, self.config.select_range)
    if targetList.Count > 0 then
      for i = 0, targetList.Count - 1 do
        local target = targetList[i].targetRole
        local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target)
        LuaSkillCtrl:HealResult(skillResult, self.config.heal_config, {num})
        skillResult:EndResult()
        LuaSkillCtrl:CallEffect(target, self.config.effectId_passive, self)
      end
    end
    LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId_choocolate, 0, true)
  end, self, -1)
end

function bs_1014012:OnAfterPlaySkill(skill, role)
  if role == self.caster and skill.isCommonAttack then
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_choocolate, 1, nil, true)
  end
end

function bs_1014012:OnCasterDie()
  if self.passive ~= nil then
    self.passive:Stop()
    self.passive = nil
  end
  base.OnCasterDie(self)
end

return bs_1014012
