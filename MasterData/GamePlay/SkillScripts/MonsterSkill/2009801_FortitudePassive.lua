local bs_2009801 = class("bs_2009801", LuaSkillBase)
local base = LuaSkillBase
bs_2009801.config = {
  hurtConfigId = 2,
  effectId_1 = 2009809,
  buffId_1 = 2009801
}

function bs_2009801:ctor()
end

function bs_2009801:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterHurtTriggerForTable("bs_2009801_4", 1, self.OnAfterHurt, {
    target = self.caster,
    extraArg2 = false,
    extraArg3 = false
  })
  self:AddAfterAddBuffTrigger("bs_2009801_8", 1, self.OnAfterAddBuff, nil, nil, nil, nil, self.config.buffId_1)
  self:AddLuaTrigger(eSkillLuaTrigger.OnFortitudeSkill, self.OnFortitudeSkill, self)
end

function bs_2009801:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, isRealDmg, isTriggerSet)
  if LuaSkillCtrl:CallRange(1, 1000) < self.arglist[1] then
    LuaSkillCtrl:CallEffect(self.caster, self.config.effectId_1, self)
    local targetList = LuaSkillCtrl:CallTargetSelect(self, 9, 0)
    if 0 < targetList.Count then
      for i = 0, targetList.Count - 1 do
        local role = targetList[i].targetRole
        LuaSkillCtrl:CallBuff(self, role, self.config.buffId_1, 1)
      end
    end
  end
end

function bs_2009801:OnAfterAddBuff(buff, target)
  if target:GetBuffTier(self.config.buffId_1) >= self.arglist[3] then
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target)
    LuaSkillCtrl:HurtResultWithConfig(self, skillResult, self.config.hurtConfigId, {
      self.arglist[4]
    })
    skillResult:EndResult()
    LuaSkillCtrl:DispelBuff(target, self.config.buffId_1, self.arglist[3])
  end
end

function bs_2009801:OnFortitudeSkill(target, num)
  LuaSkillCtrl:CallBuff(self, target, self.config.buffId_1, num)
end

function bs_2009801:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_2009801
