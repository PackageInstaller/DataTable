local bs_615 = class("bs_615", LuaSkillBase)
local base = LuaSkillBase
bs_615.config = {
  effectId_skill = 61501,
  effectId_w = 60402,
  effectId1 = 10277,
  effectId2 = 10278,
  effectId3 = 10279,
  effectId4 = 10280,
  aoe_config = {
    effect_shape = 3,
    aoe_select_code = 4,
    aoe_range = 1
  },
  monsterEffectId = 61503,
  buffId_shark = 1277,
  buffId_1130 = 1130,
  buffDamageFormula = 10078,
  effecthurtId = 10275,
  audioId1 = 78,
  audioId2 = 79,
  audioId3 = 80,
  startAnimId = 1002,
  skill_time = 27,
  start_time = 12,
  freq = 15,
  gridid_skill = 1128,
  grid_time = 60,
  effectPick = 61502,
  hurt_config = {
    basehurt_formula = 10080,
    hit_formula = 0,
    crit_formula = 0,
    correct_formula = 9989,
    lifesteal_formula = 0,
    spell_lifesteal_formula = 0,
    returndamage_formula = 0
  },
  hurt_config2 = {
    hit_formula = 0,
    basehurt_formula = 10114,
    crit_formula = 0,
    crithur_ratio = 0,
    lifesteal_formula = 0,
    spell_lifesteal_formula = 0,
    returndamage_formula = 0
  },
  buffDispelEffectId = 10275,
  buffDamageFormula = 10078,
  audioId1 = 80
}

function bs_615:ctor()
end

function bs_615:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.BeforeBattleEnd, "bs_615_3", 1, self.BeforeEndBattle)
  self:AddAfterAddBuffTrigger("bs_615", 1, self.OnAfterAddBuff, self.caster)
end

function bs_615:PlaySkill(data)
  local belongNum = 1
  local target = self.caster.recordTable.lastAttackRole
  if target == nil or target.hp <= 0 or target.belongNum == eBattleRoleBelong.neutral then
    local tempTarget = self:GetMoveSelectTarget()
    if tempTarget ~= nil then
      target = tempTarget.targetRole
    end
  end
  if target == nil then
    return
  end
  local Targetgrid = LuaSkillCtrl:GetTargetWithGrid(target.x, target.y)
  local triggerCallBack = BindCallback(self, self.OnActionCallBack, Targetgrid)
  LuaSkillCtrl:CallEffect(self.caster, self.config.effectId_w, self)
  self.caster:LookAtTarget(Targetgrid)
  LuaSkillCtrl:CallEffect(Targetgrid, self.config.effectPick, self)
  self:CallCasterWait(self.config.skill_time)
  LuaSkillCtrl:PlayAuSource(self.caster, self.config.audioId1)
  LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, self.config.startAnimId, 1, self.config.start_time, triggerCallBack)
end

function bs_615:OnActionCallBack(target, data, atkSpeedRatio, atkActionId)
  self.caster:LookAtTarget(target)
  local grid = LuaSkillCtrl:GetGridWithPos(target.x, target.y)
  if grid == nil then
    return
  end
  LuaSkillCtrl:CallEffect(target, self.config.effectId1, self)
  LuaSkillCtrl:StartTimer(nil, 1, function()
    LuaSkillCtrl:CallEffect(target, self.config.effectId3, self)
  end)
  LuaSkillCtrl:StartTimer(nil, 3, function(csGrid)
    LuaSkillCtrl:CallEffectWithArg(target, self.config.effectId2, self, nil, nil, self.SkillEventFunc, csGrid)
  end, grid)
end

function bs_615:SkillEventFunc(grid, effect, eventId, target)
  if eventId == eBattleEffectEvent.Trigger then
    local gridTarget = LuaSkillCtrl:GetTargetWithGrid(grid.x, grid.y)
    local loop = LuaSkillCtrl:CallEffect(gridTarget, self.config.monsterEffectId, self)
    local loopAudio = LuaSkillCtrl:PlayAuSource(self.caster, self.config.audioId2)
    self.loopAudio = loopAudio
    local count_times = self.config.grid_time // self.config.freq
    LuaSkillCtrl:StartTimer(nil, self.config.freq, function()
      if self.caster == nil or self.caster.hp <= 0 then
        return
      end
      local roles = LuaSkillCtrl:FindRolesAroundGrid(grid, 1)
      if roles ~= nil then
        for i = 0, roles.Count - 1 do
          LuaSkillCtrl:CallBuff(self, roles[i], self.config.buffId_1130, 1, nil)
          LuaSkillCtrl:DispelBuff(roles[i], self.config.buffId_1130, 0, true)
          LuaSkillCtrl:PlayAuSource(roles[i], self.config.audioId3)
        end
      end
    end, self, count_times, self.config.freq)
    LuaSkillCtrl:StartTimer(nil, self.config.grid_time, BindCallback(self, self.__killEffectAndAudio, loop, loopAudio))
  end
end

function bs_615:__killEffectAndAudio(effect, loopAudio)
  if effect ~= nil then
    effect:Die()
    effect = nil
  end
  if loopAudio ~= nil then
    LuaSkillCtrl:StopAudioByBack(loopAudio)
  end
end

function bs_615:BeforeEndBattle()
  if self.loopAudio ~= nil then
    LuaSkillCtrl:StopAudioByBack(self.loopaudio)
    self.loopAudio = nil
  end
end

function bs_615:LuaDispose()
  base.LuaDispose(self)
  self.loopAudio = nil
end

function bs_615:OnBuffExecute(buff, targetRole)
  local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, targetRole)
  LuaSkillCtrl:PlayAuHit(self, targetRole)
  LuaSkillCtrl:HurtResult(self, skillResult, self.config.hurt_config2, {
    buff.tier
  }, true)
  skillResult:EndResult()
  LuaSkillCtrl:CallEffect(targetRole, self.config.buffDispelEffectId, self)
end

function bs_615:OnAfterAddBuff(buff, target)
  if buff.dataId == self.config.buffId_shark and target:GetBuffTier(self.config.buffId_shark) >= 4 then
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target)
    LuaSkillCtrl:PlayAuHit(self, target)
    LuaSkillCtrl:HurtResult(self, skillResult, self.config.hurt_config, nil, true)
    LuaSkillCtrl:CallEffect(target, self.config.buffDispelEffectId, self)
    LuaSkillCtrl:DispelBuff(target, self.config.buffId_shark, 0)
    skillResult:EndResult()
  end
  if buff.dataId == self.config.buffId_1130 then
    LuaSkillCtrl:CallBuffRepeated(self, target, self.config.buffId_shark, 1, self.arglist[4], false, false, self.OnBuffExecute)
    LuaSkillCtrl:PlayAuSource(target, self.config.audioId1)
  end
end

function bs_615:OnCasterDie()
  base.OnCasterDie(self)
  self.loopAudio = nil
end

return bs_615
