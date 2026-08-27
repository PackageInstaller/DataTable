local bs_30014 = class("bs_30014", LuaSkillBase)
local base = LuaSkillBase
bs_30014.config = {
  buffId_fuyu = 1088,
  heal_config = {
    baseheal_formula = 10118,
    heal_number = 0,
    correct_formula = 9990
  },
  effectId = 10897
}

function bs_30014:ctor()
end

function bs_30014:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterAddBuffTrigger("bs_30014_7", 1, self.OnAfterAddBuff, nil, nil, nil, nil, self.config.buffId_fuyu)
  self.tier = 0
  self.flag = true
end

function bs_30014:OnAfterAddBuff(buff, target)
  self.tier = self.tier + buff.tier
  if self.tier > self.arglist[1] and self.flag then
    local targetlist = LuaSkillCtrl:CallTargetSelect(self, 6, 0)
    if 1 > targetlist.Count then
      return
    end
    for i = 0, targetlist.Count - 1 do
      local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, targetlist[i].targetRole)
      LuaSkillCtrl:HealResult(skillResult, self.config.heal_config, nil, true, true)
      skillResult:EndResult()
      LuaSkillCtrl:CallEffect(targetlist[i].targetRole, self.config.effectId, self)
    end
    self.flag = false
  end
end

function bs_30014:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_30014
