local bs_1060 = class("bs_1060", LuaSkillBase)
local base = LuaSkillBase
bs_1060.config = {
  effectId = 10293,
  buffId = 66,
  hurt_config = {hit_formula = 10010, basehurt_formula = 10076},
  hurt_config2 = {hit_formula = 10010, basehurt_formula = 10162},
  audioIdStart = 117,
  audioIdMovie = 118,
  audioIdEnd = 119,
  movieEndRoleActionId = 1102,
  audioIdMovie2 = 103701
}

function bs_1060:ctor()
end

function bs_1060:InitSkill(isMidwaySkill)
  self.hurt_config = {}
  self.skillEffect = nil
end

function bs_1060:PlaySkill(data, selectTargetCoord, selectRoles)
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

function bs_1060:RealPlaySkill(target)
  self.skillEffect = LuaSkillCtrl:CallEffect(target, self.config.effectId, self, self.SkillEventFunc, nil, 1)
  local targetList = LuaSkillCtrl:CallTargetSelect(self, 9, 10)
  for i = 0, targetList.Count - 1 do
    if targetList[i] ~= nil and targetList[i].targetRole ~= nil and targetList[i].targetRole.belongNum ~= eBattleRoleBelong.neutral and not LuaSkillCtrl:RoleContainsBuffFeature(targetList[i].targetRole, eBuffFeatureType.CtrlImmunity) then
      local emptyGrid = LuaSkillCtrl:CallFindEmptyGridClosedToTargetInRange(target.x, target.y, targetList[i].targetRole)
      if emptyGrid ~= nil and LuaSkillCtrl:GetGridsDistance(emptyGrid.x, emptyGrid.y, target.x, target.y) < LuaSkillCtrl:GetGridsDistance(targetList[i].targetRole.x, targetList[i].targetRole.y, target.x, target.y) then
        targetList[i].targetRole:ResetRoleState()
        LuaSkillCtrl:CallPhaseMoveWithoutTurn(self, targetList[i].targetRole, emptyGrid.x, emptyGrid.y, 5)
      end
      LuaSkillCtrl:CallBuff(self, targetList[i].targetRole, 66, 1, self.arglist[2])
    end
    if targetList[i] ~= nil and targetList[i].targetRole ~= nil and targetList[i].targetRole.belongNum ~= eBattleRoleBelong.neutral then
      LuaSkillCtrl:StartTimer(nil, 5, function()
        if targetList[i].targetRole.hp <= 0 then
          return
        end
        local hurtCfg
        if self:IsConsumeSkill() then
          hurtCfg = self.config.hurt_config2
        else
          hurtCfg = self.config.hurt_config
        end
        local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, targetList[i].targetRole)
        LuaSkillCtrl:HurtResult(self, skillResult, hurtCfg, nil, false)
        skillResult:EndResult()
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
end

function bs_1060:PlayUltEffect()
  base.PlayUltEffect(self)
  LuaSkillCtrl:CallBuff(self, self.caster, 196, 1, 15, true)
  LuaSkillCtrl:CallFocusTimeLine(self.caster)
end

function bs_1060:OnUltRoleAction()
  if self.config.audioIdMovie ~= nil then
    local audioId = self.config.audioIdMovie
    if LuaSkillCtrl:GetCasterSkinId(self.caster) == 303708 then
      audioId = self.config.audioIdMovie2
    end
    self.actionAudio = LuaSkillCtrl:PlayAuSource(self.caster, audioId, function(auback)
      if auback == self.actionAudio then
        self.actionAudio = nil
      end
    end)
  end
  LuaSkillCtrl:StartTimerInUlt(self, 15, self.PlayUltMovie)
  LuaSkillCtrl:CallRoleAction(self.caster, 1005)
  if LuaSkillCtrl:GetCasterSkinId(self.caster) ~= 303706 and LuaSkillCtrl:GetCasterSkinId(self.caster) ~= 303708 then
    LuaSkillCtrl:CallRoleAction(self.caster, 1101)
  end
end

function bs_1060:OnSkipUltView()
  base.OnSkipUltView(self)
end

function bs_1060:OnMovieFadeOut()
  if LuaSkillCtrl:GetCasterSkinId(self.caster) ~= 303706 and LuaSkillCtrl:GetCasterSkinId(self.caster) ~= 303708 then
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

function bs_1060:OnCasterDie()
  base.OnCasterDie(self)
end

function bs_1060:LuaDispose()
  base.LuaDispose(self)
  self.skillEffect = nil
  self.startEffect = nil
end

return bs_1060
