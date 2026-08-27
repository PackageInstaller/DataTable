local bs_20123 = class("bs_20123", LuaSkillBase)
local base = LuaSkillBase
bs_20123.config = {
  buffId_1 = 66,
  buffId_2 = 2012301,
  Aoe = {
    effect_shape = 3,
    aoe_select_code = 4,
    aoe_range = 1
  },
  HurtConfig = {
    hit_formula = 0,
    basehurt_formula = 3000,
    crit_formula = 0,
    crithur_ratio = 0
  },
  effectId = 2012302,
  effectId1 = 10853,
  effectId_down = 2012301
}

function bs_20123:ctor()
end

function bs_20123:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_20123_1", 1, self.OnAfterBattleStart)
end

function bs_20123:OnAfterBattleStart()
  LuaSkillCtrl:StartTimer(self, 2, function()
    LuaSkillCtrl:CallEffect(self.caster, self.config.effectId_down, self, nil, nil, nil, true)
  end)
  if self.caster.career == 1 then
    LuaSkillCtrl:CallEffect(self.caster, self.config.effectId1, self, nil, nil, nil, true)
    local targetList = LuaSkillCtrl:CallTargetSelect(self, 9, 30)
    for i = 0, targetList.Count - 1 do
      local target = targetList[i].targetRole
      LuaSkillCtrl:CallBuff(self, target, self.config.buffId_1, 1, self.arglist[1], true)
    end
  end
  if self.caster.career == 2 then
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_2, 1, nil, true)
  end
  if self.caster.career == 3 then
    LuaSkillCtrl:StartTimer(self, 2, function()
      LuaSkillCtrl:CallEffect(self.caster, self.config.effectId, self)
    end)
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, self.caster, self.config.Aoe)
    LuaSkillCtrl:HurtResult(self, skillResult, self.config.HurtConfig, {
      self.arglist[2]
    })
    skillResult:EndResult()
  end
end

function bs_20123:OnAfterPlaySkill(skill, role)
  if role == self.caster and skill.skillTag == eSkillTag.normalSkill and self.curCd ~= nil then
    LuaSkillCtrl:CallResetCDNumForRole(role, self.curCd)
    self.curCd = nil
    self:RemoveSkillTrigger(eSkillTriggerType.AfterPlaySkill)
  end
end

function bs_20123:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_20123
