local bs_15224 = class("bs_15224", LuaSkillBase)
local base = LuaSkillBase
bs_15224.config = {
  effectBallId = 12081,
  effectLineId = 12082,
  effectHit = 12080,
  effectDie = 12079,
  hurt_config = {
    hit_formula = 0,
    basehurt_formula = 10187,
    crit_formula = 0
  }
}

function bs_15224:ctor()
end

function bs_15224:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_15224_1", 1, self.OnAfterBattleStart)
  self.damTimer = nil
  self.effect = nil
  self.Timer = nil
  self.count = 0
  self.grid = LuaSkillCtrl:GetTargetWithGrid(3, 2)
end

function bs_15224:OnAfterBattleStart()
  if self.Timer ~= nil then
    self.Timer:Stop()
    self.Timer = nil
  end
  self.Timer = LuaSkillCtrl:StartTimer(nil, self.arglist[1], self.CallBack, self, -1, 0)
end

function bs_15224:CallBack()
  if self.effect ~= nil then
    self.effect:Die()
    self.effect = nil
  end
  self.effect = LuaSkillCtrl:CallEffect(self.grid, self.config.effectBallId, self)
  if self.damTimer ~= nil then
    self.damTimer:Stop()
    self.damTimer = nil
  end
  self.count = 0
  self.damTimer = LuaSkillCtrl:StartTimer(nil, 8, self.DamCallBack, self, -1, 0)
end

function bs_15224:DamCallBack()
  if self.count < self.arglist[3] then
    self.count = self.count + 1
    local senderList = LuaSkillCtrl:CallTargetSelect(self, 46, 10)
    if senderList.Count <= 0 then
      return
    end
    local senderRole = senderList[0].targetRole
    local value = senderRole.skill_intensity * self.arglist[4] // 1000
    local targetList = LuaSkillCtrl:CallTargetSelect(self, 7, 10)
    if targetList.Count > 0 then
      local targetRole = targetList[0].targetRole
      LuaSkillCtrl:CallEffect(targetRole, self.config.effectHit, self)
      local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, targetRole)
      LuaSkillCtrl:HurtResult(self, skillResult, self.config.hurt_config, {value}, true)
      skillResult:EndResult()
    end
  else
    if self.damTimer ~= nil then
      self.damTimer:Stop()
      self.damTimer = nil
    end
    if self.effect ~= nil then
      self.effect:Die()
      self.effect = nil
    end
  end
end

function bs_15224:OnCasterDie()
  base.OnCasterDie(self)
  if self.damTimer then
    self.damTimer:Stop()
    self.damTimer = nil
  end
  if self.Timer then
    self.Timer:Stop()
    self.Timer = nil
  end
  if self.effect ~= nil then
    self.effect:Die()
    self.effect = nil
  end
end

function bs_15224:LuaDispose()
  base.LuaDispose(self)
  self.effect = nil
end

return bs_15224
