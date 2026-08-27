local bs_102803 = class("bs_102803", LuaSkillBase)
local base = LuaSkillBase
bs_102803.config = {
  hurt_config = {hit_formula = 0, basehurt_formula = 10076},
  hurt_configF = {hit_formula = 0, basehurt_formula = 10164},
  hurt_config1F = {hit_formula = 0, basehurt_formula = 10165},
  hurt_config1 = {hit_formula = 0, basehurt_formula = 10159},
  aoe_config = {
    effect_shape = 2,
    aoe_select_code = 4,
    aoe_range = 1
  },
  effectId = 10869,
  effectId_hit = 10871,
  movieEndRoleActionId = 100,
  audioIdStart = 102801,
  audioIdMovie = 102802,
  audioIdEnd = 102803
}

function bs_102803:ctor()
end

function bs_102803:InitSkill(isMidwaySkill)
end

function bs_102803:PlaySkill(data, selectTargetCoord, selectRoles)
  self:CallCasterWait(5)
  if selectTargetCoord ~= nil then
    local targetGrid = LuaSkillCtrl:GetTargetWithGrid(selectTargetCoord.x, selectTargetCoord.y)
    if targetGrid ~= nil then
      local effect = LuaSkillCtrl:CallEffect(targetGrid, self.config.effectId, self)
      LuaSkillCtrl:StartTimer(self, self.arglist[3], BindCallback(self, self.DelEffect, effect))
      self:CallFace(targetGrid)
    end
  end
  return self:GetSelectTargetAndExecute(selectRoles, BindCallback(self, self.CallSelectExecute))
end

function bs_102803:DelEffect(effect)
  if effect ~= nil then
    effect:Die()
    effect = nil
  end
end

function bs_102803:CallSelectExecute(target)
  if target ~= nil and target.belongNum ~= self.caster.belongNum and not target:IsUnSelect(self.caster) then
    LuaSkillCtrl:StartTimer(nil, 3, BindCallback(self, function()
      local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target)
      for i = 0, skillResult.roleList.Count - 1 do
        LuaSkillCtrl:CallEffect(skillResult.roleList[i], self.config.effectId_hit, self)
      end
      local hurtCfg
      if self:IsConsumeSkill() then
        hurtCfg = self.config.hurt_configF
      else
        hurtCfg = self.config.hurt_config
      end
      LuaSkillCtrl:HurtResult(self, skillResult, hurtCfg, nil, false)
      skillResult:EndResult()
    end))
  end
end

function bs_102803:CallFace(targetGrid)
  LuaSkillCtrl:StartTimer(nil, 15, BindCallback(self, function()
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, targetGrid, self.config.aoe_config)
    local hurtCfg1
    if self:IsConsumeSkill() then
      hurtCfg1 = self.config.hurt_config1F
    else
      hurtCfg1 = self.config.hurt_config1
    end
    LuaSkillCtrl:HurtResult(self, skillResult, hurtCfg1, nil, false)
    skillResult:EndResult()
  end), self, self.arglist[3] // 15 - 1)
end

function bs_102803:PlayUltEffect()
  base.PlayUltEffect(self)
  LuaSkillCtrl:CallBuff(self, self.caster, 196, 1, 15, true)
  LuaSkillCtrl:CallFocusTimeLine(self.caster)
end

function bs_102803:OnUltRoleAction()
  base.OnUltRoleAction(self)
  LuaSkillCtrl:StartTimerInUlt(self, 7, self.PlayUltMovie)
  LuaSkillCtrl:CallRoleAction(self.caster, 1004)
end

function bs_102803:OnMovieFadeOut()
  base.OnMovieFadeOut(self)
end

function bs_102803:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_102803
