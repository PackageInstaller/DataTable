local bs_202202 = class("bs_202202", LuaSkillBase)
local base = LuaSkillBase
bs_202202.config = {
  hurtConfig = {basehurt_formula = 10076},
  healConfig = {baseheal_formula = 10087},
  select_id = 9,
  select_range = 0,
  start_time = 3,
  effectId1 = 10433,
  effectId2 = 10433,
  audioId1 = 301
}

function bs_202202:ctor()
end

function bs_202202:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_202202:OnCasterDie()
  base.OnCasterDie(self)
  LuaSkillCtrl:StartTimer(nil, self.config.start_time, function()
    LuaSkillCtrl:CallEffect(self.caster, self.config.effectId1, self, nil, nil, nil, false)
    local targetList = LuaSkillCtrl:CallTargetSelect(self, self.config.select_id, self.config.select_range)
    if targetList.Count > 0 then
      for i = 0, targetList.Count - 1 do
        LuaSkillCtrl:CallEffect(targetList[i].targetRole, self.config.effectId2, self)
        local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, targetList[i].targetRole)
        LuaSkillCtrl:PlayAuSource(targetList[i].targetRole, self.config.audioId1)
        LuaSkillCtrl:HurtResult(self, skillResult, self.config.hurtConfig)
        skillResult:EndResult()
      end
    end
    local targetlist2 = LuaSkillCtrl:CallTargetSelect(self, 2, 0)
    if targetlist2.Count > 0 then
      for i = 0, targetlist2.Count - 1 do
        local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, targetlist2[i].targetRole)
        LuaSkillCtrl:HealResult(skillResult, self.config.healConfig)
        skillResult:EndResult()
      end
    end
  end)
end

return bs_202202
