local bs_10291 = class("bs_10291", LuaSkillBase)
local base = LuaSkillBase
bs_10291.config = {
  realDamageConfig = {
    basehurt_formula = 10046,
    lifesteal_formula = 0,
    spell_lifesteal_formula = 0
  },
  aoe_config = {
    effect_shape = 3,
    aoe_select_code = 4,
    aoe_range = 1
  },
  aoe_config1 = {
    effect_shape = 3,
    aoe_select_code = 4,
    aoe_range = 2
  },
  effectId = 10257,
  effectId2 = 10256,
  effectId3 = 10902
}

function bs_10291:ctor()
end

function bs_10291:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddSelfTrigger(eSkillTriggerType.AfterBattleStart, "bs_10291_1", 1, self.OnAfterBattleStart)
end

function bs_10291:OnAfterBattleStart()
  self.timer = LuaSkillCtrl:StartTimer(nil, self.arglist[2], self.RealPlaySkill, self, -1)
end

function bs_10291:RealPlaySkill()
  if self:IsReadyToTake() then
    local grid = LuaSkillCtrl:CallFindGridMostRolesArounded(2)
    if grid ~= nil then
      local target = LuaSkillCtrl:GetTargetWithGrid(grid.x, grid.y)
      local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target, self.config.aoe_config)
      if self.caster.recordTable["30041_Flag"] then
        skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target, self.config.aoe_config1)
      end
      if skillResult.roleList.Count > 0 then
        if self.caster.recordTable["30041_Flag"] then
          LuaSkillCtrl:CallEffect(target, self.config.effectId3, self, self.SkillEventFunc)
        else
          LuaSkillCtrl:CallEffect(target, self.config.effectId, self, self.SkillEventFunc)
        end
        self:OnSkillTake()
      end
    end
  end
end

function bs_10291:SkillEventFunc(effect, eventId, target)
  if eventId == eBattleEffectEvent.Trigger then
    local targetPow = self.caster.skill_intensity
    local targetSunder = self.caster.magic_pen
    local skillResult = LuaSkillCtrl:CallSkillResult(effect, target, self.config.aoe_config)
    if self.caster.recordTable["30041_Flag"] then
      targetPow = targetPow + targetPow * self.caster.recordTable["30041_arg"] // 1000
      skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target, self.config.aoe_config1)
    end
    LuaSkillCtrl:HurtResult(self, skillResult, self.config.realDamageConfig, {targetPow, targetSunder}, true)
    if skillResult.roleList.Count > 0 then
      for i = 0, skillResult.roleList.Count - 1 do
        local role = skillResult.roleList[i]
        if not LuaSkillCtrl:IsFixedObstacle(role) then
          LuaSkillCtrl:CallEffect(role, self.config.effectId2, self)
        end
      end
    end
    skillResult:EndResult()
  end
end

function bs_10291:OnCasterDie()
  base.OnCasterDie(self)
  if self.timer ~= nil then
    self.timer:Stop()
    self.timer = nil
  end
end

function bs_10291:LuaDispose()
  base.LuaDispose(self)
  self.timer = nil
end

return bs_10291
