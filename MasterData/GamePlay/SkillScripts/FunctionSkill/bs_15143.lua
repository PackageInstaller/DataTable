local bs_15143 = class("bs_15143", LuaSkillBase)
local base = LuaSkillBase
bs_15143.config = {
  formula = 10106,
  effectId = 12066,
  buffId = 1059
}

function bs_15143:ctor()
end

function bs_15143:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_15143_1", 1, self.OnAfterBattleStart)
  self.damageNum = 0
end

function bs_15143:OnAfterBattleStart()
  if self.damTimer ~= nil then
    self.damTimer:Stop()
    self.damTimer = nil
  end
  self.damTimer = LuaSkillCtrl:StartTimer(nil, self.arglist[1], self.CallBack, self, -1, self.arglist[1])
end

function bs_15143:CallBack()
  self:findMax()
  local targetList = LuaSkillCtrl:CallTargetSelect(self, 1001, 10)
  if targetList.Count > 0 then
    local targetRole = targetList[0].targetRole
    if targetRole.belongNum ~= eBattleRoleBelong.enemy then
      return
    end
    LuaSkillCtrl:CallEffect(targetRole, self.config.effectId, self)
    local skillResult1 = LuaSkillCtrl:CallSkillResultNoEffect(self, targetRole)
    LuaSkillCtrl:HurtResultWithConfig(self, skillResult1, 14, {
      self.damageNum
    }, true, true)
    skillResult1:EndResult()
    LuaSkillCtrl:CallBuff(self, targetRole, self.config.buffId, 1, 75)
  end
end

function bs_15143:findMax()
  local role, baseDamage = LuaSkillCtrl:CallFindMaxPowOrSkillIntensityRole()
  if role ~= nil then
    self.damageNum = baseDamage * self.arglist[2] // 1000
  end
end

function bs_15143:OnCasterDie()
  base.OnCasterDie(self)
  if self.damTimer then
    self.damTimer:Stop()
    self.damTimer = nil
  end
end

return bs_15143
