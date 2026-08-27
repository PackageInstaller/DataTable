local bs_103707 = class("bs_1060", LuaSkillBase)
local base = LuaSkillBase
bs_103707.config = {
  effectId = 10293,
  effectId2 = 103710,
  buffId = 66,
  hurt_config = {hit_formula = 10010, basehurt_formula = 10076},
  hurt_config2 = {hit_formula = 10010, basehurt_formula = 10162},
  audioIdStart = 117,
  audioIdMovie = 118,
  audioIdEnd = 119,
  movieEndRoleActionId = 1102,
  roleDataId = 1037,
  tipId = 1021,
  skillDataId = 103703,
  audioIdMovie2 = 103701
}

function bs_103707:ctor()
end

function bs_103707:InitSkill(isMidwaySkill)
  self.hurt_config = {}
  self.skillEffect = nil
  self:AddLuaTrigger(eSkillLuaTrigger.OnUltSkillPlayed, self.OnUltSkillPlayed)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_103707_1", 1, self.OnAfterBattleStart)
  self.costPercent = 1000
  self.BenchRole = LuaSkillCtrl:GetOriginRole(self.config.roleDataId)
end

function bs_103707:PlaySkill(data, selectTargetCoord, selectRoles)
  local gridTarget
  if selectTargetCoord ~= nil then
    self:CallCasterWait(20)
    local gridTarget = LuaSkillCtrl:GetTargetWithGrid(selectTargetCoord.x, selectTargetCoord.y)
    if self.skillEffect ~= nil then
      self.skillEffect:Die()
      self.skillEffect = nil
    end
    LuaSkillCtrl:StartTimer(nil, 3, BindCallback(self, self.RealPlaySkill, gridTarget))
  end
end

function bs_103707:RealPlaySkill(target)
  if LuaSkillCtrl:GetCasterSkinId(self.BenchRole) == 303708 then
    self.skillEffect = LuaSkillCtrl:CallEffect(target, self.config.effectId2, self, self.SkillEventFunc, nil, 1)
  else
    self.skillEffect = LuaSkillCtrl:CallEffect(target, self.config.effectId, self, self.SkillEventFunc, nil, 1)
  end
  local targetList = LuaSkillCtrl:CallTargetSelect(self, 9, 10)
  for i = 0, targetList.Count - 1 do
    if targetList[i] ~= nil and targetList[i].targetRole ~= nil and targetList[i].targetRole.belongNum ~= eBattleRoleBelong.neutral and not LuaSkillCtrl:RoleContainsBuffFeature(targetList[i].targetRole, eBuffFeatureType.CtrlImmunity) then
      local emptyGrid = LuaSkillCtrl:CallFindEmptyGridClosedToTargetInRange(target.x, target.y, targetList[i].targetRole)
      if emptyGrid ~= nil and LuaSkillCtrl:GetGridsDistance(emptyGrid.x, emptyGrid.y, target.x, target.y) < LuaSkillCtrl:GetGridsDistance(targetList[i].targetRole.x, targetList[i].targetRole.y, target.x, target.y) then
        targetList[i].targetRole:ResetRoleState()
        LuaSkillCtrl:CallPhaseMoveWithoutTurn(self, targetList[i].targetRole, emptyGrid.x, emptyGrid.y, 5)
      end
      LuaSkillCtrl:CallBuff(self, targetList[i].targetRole, self.config.buffId, 1, self.arglist[2])
    end
    if targetList[i] ~= nil and targetList[i].targetRole ~= nil and targetList[i].targetRole.belongNum ~= eBattleRoleBelong.neutral then
      LuaSkillCtrl:StartTimer(nil, 5, function()
        if targetList[i].targetRole.hp <= 0 then
          return
        end
        local hurtCfg
        if self.BenchRole ~= nil then
          hurtCfg = self.config.hurt_config
          local skilUlt = LuaSkillCtrl:GetRoleBattleSkillWithDataId(self.config.roleDataId, self.config.skillDataId)
          local skillResult = LuaSkillCtrl:CallSkillResultNoEffectWithCSkill(skilUlt, targetList[i].targetRole)
          LuaSkillCtrl:HurtResult(self, skillResult, hurtCfg, nil, false)
          skillResult:EndResult()
        end
      end)
    end
  end
  LuaSkillCtrl:StartTimer(nil, self.arglist[2], function()
    if self.skillEffect ~= nil then
      self.skillEffect:Die()
      self.skillEffect = nil
    end
  end)
  if self.startEffect ~= nil then
    self.startEffect:Die()
    self.startEffect = nil
  end
  if self.reloadTimer ~= nil then
    self.reloadTimer:Stop()
    self.reloadTimer = nil
  end
end

function bs_103707:OnUltSkillPlayed(role, skill)
  if role.roleType == eBattleRoleType.skillCaster and skill.isUltSkill and skill.funcHeroId == self.config.roleDataId then
    local maxMP = self.isNeedCostUltMp
    LuaSkillCtrl:CallAddPlayerHmp(-maxMP)
  end
end

function bs_103707:OnAfterBattleStart()
  local currentMP = LuaSkillCtrl:GetUltHMp()
  self.isNeedCostUltMp = ConfigData.game_config.ultMpCost * self.costPercent // 1000
  if currentMP < self.isNeedCostUltMp then
    LuaSkillCtrl:SetConsumeSkillItemCanUse(self.cskill.dataId, false, 1021)
  end
  self.reloadTimer = LuaSkillCtrl:StartTimer(self, 5, function()
    local currentMP = LuaSkillCtrl:GetUltHMp()
    if currentMP >= self.isNeedCostUltMp then
      LuaSkillCtrl:SetConsumeSkillItemCanUse(self.cskill.dataId, true, nil)
    else
      LuaSkillCtrl:SetConsumeSkillItemCanUse(self.cskill.dataId, false, 1021)
    end
  end, nil, -1, 0)
end

function bs_103707:PlayUltEffect()
  base.PlayUltEffect(self)
  LuaSkillCtrl:CallBuff(self, self.caster, 196, 1, 15, true)
  LuaSkillCtrl:CallFocusTimeLine(self.caster)
end

function bs_103707:PlayUltMovie(moveSelectTarget, selectTargetCoord, selectRoles)
  local currentMP = LuaSkillCtrl:GetUltHMp()
  if self:IsConsumeSkill() and currentMP < self.isNeedCostUltMp then
    return true
  end
  if LuaSkillCtrl:GetCasterSkinId(self.BenchRole) == 303708 then
    LuaSkillCtrl:SetCurUltMovieFileName("ultskill1037_hubble_dress")
  end
  if self.config.audioIdMovie ~= nil then
    local audioId = self.config.audioIdMovie
    if LuaSkillCtrl:GetCasterSkinId(self.BenchRole) == 303708 then
      audioId = self.config.audioIdMovie2
    end
    self.actionAudio = LuaSkillCtrl:PlayAuSource(self.BenchRole, audioId)
  end
  return base.PlayUltMovie(self, moveSelectTarget, selectTargetCoord, selectRoles)
end

function bs_103707:OnUltRoleAction()
  LuaSkillCtrl:StartTimerInUlt(self, 15, self.PlayUltMovie)
  LuaSkillCtrl:CallRoleAction(self.caster, 1005)
  if LuaSkillCtrl:GetCasterSkinId(self.caster) ~= 303706 then
    LuaSkillCtrl:CallRoleAction(self.caster, 1101)
  end
end

function bs_103707:OnSkipUltView()
  base.OnSkipUltView(self)
end

function bs_103707:OnMovieFadeOut()
  if LuaSkillCtrl:GetCasterSkinId(self.caster) ~= 303706 then
    base.OnMovieFadeOut(self)
    return
  end
  self:RemoveSkillTrigger(eSkillTriggerType.OnSelfUltMovieFadeOut)
  if self:IsSkillCasterUltSkill() then
    LuaSkillCtrl:CallEndUltEffect(self.caster)
  else
    LuaSkillCtrl:CallBackViewTimeLine(self.caster, true)
  end
  self:OnAfterUltEffect()
end

function bs_103707:OnCasterDie()
  base.OnCasterDie(self)
  if self.reloadTimer ~= nil then
    self.reloadTimer:Stop()
    self.reloadTimer = nil
  end
end

function bs_103707:LuaDispose()
  base.LuaDispose(self)
  self.skillEffect = nil
  self.startEffect = nil
  if self.reloadTimer ~= nil then
    self.reloadTimer:Stop()
    self.reloadTimer = nil
  end
end

return bs_103707
