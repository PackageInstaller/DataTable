local bs_21236 = class("bs_21236", LuaSkillBase)
local base = LuaSkillBase
bs_21236.config = {
  buffId_timeup = 110160,
  buffId_timedown = 110161,
  hurt_config = {
    hit_formula = 0,
    basehurt_formula = 10205,
    crit_formula = 0,
    lifesteal_formula = 0,
    spell_lifesteal_formula = 0,
    returndamage_formula = 0
  },
  heal_config = {baseheal_formula = 10204},
  effectId1 = 10607,
  effectId2 = 10163
}

function bs_21236:ctor()
end

function bs_21236:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_21236_1", 1, self.OnAfterBattleStart)
end

function bs_21236:OnAfterBattleStart()
  if self.timer == nil then
    local arriveCallBack = BindCallback(self, self.OnArriveAction)
    self.timer = LuaSkillCtrl:StartTimer(nil, self.arglist[1], arriveCallBack, self, -1)
  end
  if self.timer2 == nil then
    local arriveCallBack2 = BindCallback(self, self.OnArriveAction2)
    self.timer2 = LuaSkillCtrl:StartTimer(nil, self.arglist[3], arriveCallBack2, self, -1)
  end
end

function bs_21236:OnArriveAction()
  if self.timer ~= nil and self.timer:IsOver() then
    self.timer = nil
  end
  local targetList = LuaSkillCtrl:GetSelectTeamRoles(eBattleRoleBelong.player)
  if targetList.Count > 0 then
    for i = 0, targetList.Count - 1 do
      if 0 < targetList[i].hp and 0 < targetList[i]:GetBuffTier(self.config.buffId_timeup) then
        local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, targetList[i])
        LuaSkillCtrl:HealResult(skillResult, self.config.heal_config, nil, true)
        LuaSkillCtrl:CallEffect(targetList[i], self.config.effectId1, self)
        skillResult:EndResult()
      end
    end
  end
end

function bs_21236:OnArriveAction2()
  if self.timer2 ~= nil and self.timer2:IsOver() then
    self.timer2 = nil
  end
  local targetList = LuaSkillCtrl:GetSelectTeamRoles(eBattleRoleBelong.enemy)
  if targetList.Count > 0 then
    for i = targetList.Count - 1, 0, -1 do
      local targetRole = targetList[i]
      if targetRole ~= nil and 0 < targetRole.hp and 0 < targetRole:GetBuffTier(self.config.buffId_timedown) then
        local skillResult2 = LuaSkillCtrl:CallSkillResultNoEffect(self, targetList[i])
        LuaSkillCtrl:HurtResult(self, skillResult2, self.config.hurt_config, nil, true)
        LuaSkillCtrl:CallEffect(targetRole, self.config.effectId2, self)
        skillResult2:EndResult()
      end
    end
  end
end

function bs_21236:OnCasterDie()
  base.OnCasterDie(self)
  if self.timer ~= nil then
    self.timer:Stop()
    self.timer = nil
  end
  if self.timer2 ~= nil then
    self.timer2:Stop()
    self.timer2 = nil
  end
end

return bs_21236
