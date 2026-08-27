local bs_107103 = class("bs_107103", LuaSkillBase)
local base = LuaSkillBase
bs_107103.config = {
  gridId = 1131,
  effectId = 107112,
  effectId_cast1 = 107110,
  effectId_cast2 = 107111,
  configId = 17,
  audioIdStart = 107109,
  audioIdMovie = 107110,
  audioIdEnd = 107111,
  audioIdMovie2 = 107114
}

function bs_107103:ctor()
end

function bs_107103:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_107103:PlaySkill(data, selectTargetCoord, selectRoles)
  LuaSkillCtrl:CallBreakAllSkill(self.caster)
  self:CallCasterWait(13)
  if selectTargetCoord ~= nil then
    LuaSkillCtrl:StartTimer(nil, 2, function()
      LuaSkillCtrl:CallEffect(self.caster, self.config.effectId_cast1, self)
      LuaSkillCtrl:CallEffect(self.caster, self.config.effectId_cast2, self)
      local target = LuaSkillCtrl:GetTargetWithGrid(selectTargetCoord.x, selectTargetCoord.y)
      self.caster:LookAtTarget(target)
      local effect_zd = LuaSkillCtrl:CallEffect(target, self.config.effectId, self)
      local gridPos = target:GetLogicPos()
      local shootDir = CS.TrueSync.TSVector3.Subtract(gridPos, self.caster.lsObject.localPosition).normalized
      local shootDir2D = CS.TrueSync.TSVector2(shootDir.x, shootDir.z)
      local OnCollition = BindCallback(self, self.OnCollision, shootDir2D)
      local onArrive = BindCallback(self, self.onArrive)
      local skillEmission = LuaSkillCtrl:CallCircledEmissionStraightly(self, self.caster, target, 60, 10, 2, OnCollition, nil, nil, effect_zd, true, true, onArrive)
      self.effectGrid = {}
      if self.timer ~= nil then
        self.timer:Stop()
        self.timer = nil
      end
      self.timer = LuaSkillCtrl:StartTimer(nil, 1, BindCallback(self, self.findGrid, skillEmission, target, effect_zd), nil, -1, 1)
    end, nil, 0)
  end
end

function bs_107103:findGrid(skillEmission, target, effect)
  local collider = skillEmission.collider
  if collider ~= nil then
    local pos = collider.coliderPos
    local grids = LuaSkillCtrl:FindAllGridsWithUnityRange(pos, collider.colliderRadius:AsFloat())
    if grids ~= nil then
      for k, v in pairs(grids) do
        if self.effectGrid[v] == nil then
          local EfcGrid = LuaSkillCtrl:CallCreateEfcGrid(v.coord.x, v.coord.y, self.config.gridId)
          if EfcGrid ~= nil then
            EfcGrid:BindNeutralBattleSkill(self.cskill)
          end
          self.effectGrid[v] = true
        end
      end
    end
  end
end

function bs_107103:onArrive()
  if self.timer ~= nil then
    self.timer:Stop()
    self.timer = nil
  end
end

function bs_107103:OnCollision(shootDir2d, collider, index, entity)
  if self.caster == nil or self.caster.hp <= 0 or entity == nil or entity.hp <= 0 then
    return
  end
  if entity.belongNum == self.caster.belongNum or LuaSkillCtrl:IsFixedObstacle(entity) then
    return
  end
  local bornPos = self.caster.lsObject.localPosition
  if not entity.lsObject.localPosition:Equals(bornPos) then
    local tsVec2 = CS.TrueSync.TSVector2
    local curDir = CS.TrueSync.TSVector3.Subtract(entity.lsObject.localPosition, bornPos)
    local curDir2d = tsVec2(curDir.x, curDir.z).normalized
    local angle = LuaSkillCtrl:CallTSVec2Angle(curDir2d, shootDir2d)
    if 100 < angle or angle < -100 then
      return
    end
  end
  self:HurtEnermy(entity)
end

function bs_107103:HurtEnermy(target)
  local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target)
  LuaSkillCtrl:HurtResultWithConfig(self, skillResult, self.config.configId, {
    self.arglist[1]
  })
  skillResult:EndResult()
end

function bs_107103:OnUltRoleAction()
  base.OnUltRoleAction(self)
  LuaSkillCtrl:StartTimerInUlt(self, 7, function()
    MsgCenter:Broadcast(eMsgEventId.OnUltSkillVideoStart)
    if string.IsNullOrEmpty(LuaSkillCtrl.cUltSkillCtrl.curUltMovieFileName) then
      self:OnMovieFadeOut()
      return
    end
    if not CommonUtil.GetIsNeedPlayUltrSkillAnimi(self.cskill.dataId, true) then
      self:OnMovieFadeOut()
      return
    end
    self:RemoveSkillTrigger(eSkillTriggerType.OnSelfUltMovieFadeOut)
    self:AddTrigger(eSkillTriggerType.OnSelfUltMovieFadeOut, "OnMovieFadeOut", 1, self.OnMovieFadeOut)
    LuaSkillCtrl:CallPlayUltMovie()
    if self.config.audioIdMovie == nil then
      return
    end
    local audioId = self.config.audioIdMovie
    if LuaSkillCtrl:GetCasterSkinId(self.caster) == 307104 then
      audioId = self.config.audioIdMovie2
    end
    self.actionAudio = LuaSkillCtrl:PlayAuSource(self.caster, audioId, function(auback)
      if auback == self.actionAudio then
        self.actionAudio = nil
      end
    end)
  end)
  LuaSkillCtrl:CallRoleAction(self.caster, 1005, 1)
end

function bs_107103:PlayUltEffect()
  base.PlayUltEffect(self)
  LuaSkillCtrl:CallBuff(self, self.caster, 196, 1, 15, true)
  LuaSkillCtrl:CallFocusTimeLine(self.caster)
end

function bs_107103:OnSkipUltView()
  base.OnSkipUltView(self)
end

function bs_107103:OnMovieFadeOut()
  base.OnMovieFadeOut(self)
end

function bs_107103:OnCasterDie()
  base.OnCasterDie(self)
end

function bs_107103:LuaDispose()
  base.LuaDispose(self)
  self.effectGrid = nil
end

return bs_107103
