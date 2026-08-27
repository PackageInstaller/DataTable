local bs_8204301 = class("bs_8204301", LuaSkillBase)
local base = LuaSkillBase
bs_8204301.config = {
  buff_ExSkill = 714,
  HurtConfig = {hit_formula = 0, basehurt_formula = 10127},
  HurtConfigID1 = 41,
  effect_fly = 614
}

function bs_8204301:ctor()
end

function bs_8204301:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddLuaTrigger(eSkillLuaTrigger.OnRealSummonerCaster, self.OnRealSummonerCaster)
  self.summonerNum = 0
end

function bs_8204301:OnRealSummonerCaster(role)
  if role.belongNum == self.caster.belongNum then
    self.summonerNum = self.summonerNum + 1
    if self.summonerNum >= self.arglist[2] then
      self.summonerNum = 0
      local target
      local targetList = LuaSkillCtrl:CallTargetSelect(self, 7, 20)
      if 1 <= targetList.Count and targetList[0] ~= nil then
        target = targetList[0]
        LuaSkillCtrl:CallEffect(targetList[0].targetRole, self.config.effect_fly, self, self.SkillEventFunc)
      end
    end
  end
end

function bs_8204301:SkillEventFunc(effect, eventId, target)
  if eventId == eBattleEffectEvent.Trigger then
    local highAttRole = LuaSkillCtrl:CallTargetSelect(self, 80, 20)
    if highAttRole ~= nil and highAttRole.Count > 0 and highAttRole[0] ~= nil then
      local Damage = highAttRole[0].targetRole.skill_intensity
      local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target)
      LuaSkillCtrl:HurtResultWithConfig(self, skillResult, self.config.HurtConfigID1, {Damage}, true)
      skillResult:EndResult()
    end
  end
end

function bs_8204301:OnCasterDie()
  local highAttRole = LuaSkillCtrl:CallTargetSelect(self, 46, 20)
  if highAttRole ~= nil and highAttRole.Count > 0 and highAttRole[0] ~= nil then
    LuaSkillCtrl:CallBuff(self, highAttRole[0].targetRole, self.config.buff_ExSkill, 1, nil, true)
  end
  base.OnCasterDie(self)
end

return bs_8204301
