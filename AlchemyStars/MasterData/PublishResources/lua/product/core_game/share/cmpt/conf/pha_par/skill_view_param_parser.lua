_class("SkillPaaseParam", Object)
SkillPaaseParam = SkillPaaseParam
_class("SkillViewParamParser", Object)
SkillViewParamParser = SkillViewParamParser

function SkillViewParamParser:Constructor()
  self._viewParamDic = {}
  self._viewParamDic[SkillViewPhaseType.Instruction] = SkillPhaseInstructionParam
  self._viewParamDic[SkillViewPhaseType.AttackAnimation] = SkillPhaseAttackAnimationParam
  self._viewParamDic[SkillViewPhaseType.CastAnimation] = SkillPhaseCastAnimationParam
  self._viewParamDic[SkillViewPhaseType.OnHit] = SkillPhaseOnHitParam
  self._viewParamDic[SkillViewPhaseType.GridArray] = SkillPhaseGridArrayParam
  self._viewParamDic[SkillViewPhaseType.ScreenShake] = SkillPhaseScreenShakeParam
  self._viewParamDic[SkillViewPhaseType.WaveGridArray] = SkillPhaseWaveGridArrayParam
  self._viewParamDic[SkillViewPhaseType.RoleCG] = SkillPhaseRoleCGParam
  self._viewParamDic[SkillViewPhaseType.SquareRing] = SkillPhaseSquareRingParam
  self._viewParamDic[SkillViewPhaseType.LRAttackAnimation] = SkillPhaseLRAttackAnimationParam
  self._viewParamDic[SkillViewPhaseType.FireAnimation] = SkillPhaseFireAnimationParam
  self._viewParamDic[SkillViewPhaseType.ImpactAnimation] = SkillPhaseImpactAnimationParam
  self._viewParamDic[SkillViewPhaseType.FlightVehicle] = SkillFlightVehcileGridArrayParam
  self._viewParamDic[SkillViewPhaseType.TurnRoundFlightVehicle] = SkillTurnFlightVehcileGridArrayParam
  self._viewParamDic[SkillViewPhaseType.AddGridEffect] = SkillPhaseAddGridEffectParam
  self._viewParamDic[SkillViewPhaseType.RoundGridDifferent] = SkillPhaseRoundGridParam
  self._viewParamDic[SkillViewPhaseType.AbsorbPieceAnimation] = SkillPhaseAbsorbPieceParam
  self._viewParamDic[SkillViewPhaseType.TrajectoryAnimation] = SkillPhaseTrajectoryParam
  self._viewParamDic[SkillViewPhaseType.FlashKnifeAndLine] = SkillPhaseFlashKnifeAndLineParam
  self._viewParamDic[SkillViewPhaseType.SummonTrap] = SkillPhaseSummonTrapParam
  self._viewParamDic[SkillViewPhaseType.GridReturn] = SkillPhaseParam_GridReturn
  self._viewParamDic[SkillViewPhaseType.RandAttack] = SkillPhaseParam_RandAttack
  self._viewParamDic[SkillViewPhaseType.RangeAttackAnimation] = SkillPhaseRangeAttackAnimationParam
  self._viewParamDic[SkillViewPhaseType.HitBack] = SkillPhaseHitBackParam
  self._viewParamDic[SkillViewPhaseType.PullAround] = SkillPhasePullAroundParam
  self._viewParamDic[SkillViewPhaseType.ShowWarningArea] = SkillPhaseParam_ShowWarningArea
  self._viewParamDic[SkillViewPhaseType.ConvertElment] = SkillPhaseConvertElementParam
  self._viewParamDic[SkillViewPhaseType.ScopeForward] = SkillPhaseScopeForwardParam
  self._viewParamDic[SkillViewPhaseType.EffectLineFlyWithDirection] = SkillPhaseLineFlyWithDirectionParam
  self._viewParamDic[SkillViewPhaseType.Charge] = SkillPhaseChargeParam
  self._viewParamDic[SkillViewPhaseType.SummonEverything] = SkillPhaseParam_SummonEverything
  self._viewParamDic[SkillViewPhaseType.AddBlood] = SkillPhaseParam_AddBlood
  self._viewParamDic[SkillViewPhaseType.Blink] = SkillPhaseBlinkParam
  self._viewParamDic[SkillViewPhaseType.RemoveEffect] = SkillPhaseRemoveEffectParam
  self._viewParamDic[SkillViewPhaseType.TrainConvertElement] = SkillPhaseTrainConvertElementParam
  self._viewParamDic[SkillViewPhaseType.TrainHitBack] = SkillPhaseTrainHitBackParam
  self._viewParamDic[SkillViewPhaseType.EffectRangeAttack] = SkillPhaseAttackEffectAnimationParam
  self._viewParamDic[SkillViewPhaseType.PlayAudio] = SkillPhasePlayAudioParam
  self._viewParamDic[SkillViewPhaseType.StoryTips] = SkillPhaseStoryTipsParam
  self._viewParamDic[SkillViewPhaseType.LRAttackDifferentAnimation] = SkillPhaseLRAttackDifferentAnimationParam
  self._viewParamDic[SkillViewPhaseType.LeaveEnterBattleField] = SkillPhaseLeaveEnterBattleFieldParam
  self._viewParamDic[SkillViewPhaseType.PlayLoopAudio] = SkillPhasePlayLoopAudioParam
  self._viewParamDic[SkillViewPhaseType.PlayEffect] = SkillPhasePlayEffectParam
  self._viewParamDic[SkillViewPhaseType.WaveGridTransform] = SkillPhaseWaveGridTransformParam
  self._viewParamDic[SkillViewPhaseType.ScopeForwardTransform] = SkillPhaseScopeForwardTransformParam
  self._viewParamDic[SkillViewPhaseType.TwoWayFlightVehicle] = SkillPhaseTwoWayFlightVehicleParam
  self._viewParamDic[SkillViewPhaseType.PlayEffectAtSomeElementGrid] = SkillPhasePlayEffectAtSomeElementGridParam
  self._viewParamDic[SkillViewPhaseType.ShowHideRole] = SkillPhaseParam_ShowHideRole
  self._viewParamDic[SkillViewPhaseType.PlayEffectAtGrid] = SkillPhasePlayEffectAtGridParam
  self._viewParamDic[SkillViewPhaseType.GridSpread] = SkillPhaseGridSpreadParam
  self._viewParamDic[SkillViewPhaseType.GridDark] = SkillPhaseParam_GridDark
  self._viewParamDic[SkillViewPhaseType.Trajectory] = SkillPhaseParam_Trajectory
  self._viewParamDic[SkillViewPhaseType.ScopeForwardByDistance] = SkillPhaseParamScopeForwardByDistance
  self._viewParamDic[SkillViewPhaseType.MultiGridEffect] = SkillPhaseParamMultiGridEffect
  self._viewParamDic[SkillViewPhaseType.CenterFirst] = SkillPhaseCenterFirstParam
  self._viewParamDic[SkillViewPhaseType.ScopeGroup] = SkillPhaseScopeGroupParam
  self._viewParamDic[SkillViewPhaseType.AOEDamage] = SkillPhaseAOEDamageParam
  self._viewParamDic[SkillViewPhaseType.MultiGridColumnAndRowCenterRandom] = SkillPhaseParamMultiGridColumnAndRowCenterRandom
  self._viewParamDic[SkillViewPhaseType.ColumnForward] = SkillPhaseParamColumnForward
  self._viewParamDic[SkillViewPhaseType.ConvertOccupiedGridPhase] = SkillPhaseConvertOccupiedGridElementParam
  self._viewParamDic[SkillViewPhaseType.ScopeTrajectory] = SkillPhaseParamScopeTrajectory
  self._viewParamDic[SkillViewPhaseType.ContinueAttack] = SkillPhaseParamContinueAttack
  self._viewParamDic[SkillViewPhaseType.SinkAllTarget] = SkillPhaseParamSinkAllTarget
  self._viewParamDic[SkillViewPhaseType.BombBullet] = SkillPhaseBombBulletParam
  self._viewParamDic[SkillViewPhaseType.SacrificeTrapsAndDamage] = SkillPhaseSacrificeTrapsAndDamageParam
  self._viewParamDic[SkillViewPhaseType.MultiGridDamageTrace] = SkillPhaseMultiGridDamageTraceParam
  self._viewParamDic[SkillViewPhaseType.BulletFlyToCasterFromEdge] = PlaySkillParamBulletFlyToCaster
  self._viewParamDic[SkillViewPhaseType.TrainResetElement] = SkillPhaseTrainResetElementParam
  self._viewParamDic[SkillViewPhaseType.MultiStageDamage] = SkillPhaseMultiStageDamageParam
  self._viewParamDic[SkillViewPhaseType.SphereTrajectoryMultiStageDamage] = SkillPhaseSphereTrajectoryMultiStageDamageParam
  self._viewParamDic[SkillViewPhaseType.CircleFlyMultipleEffect] = SkillPhaseCircleFlyMultipleEffectParam
  self._viewParamDic[SkillViewPhaseType.SummonChessSoldier] = SkillPhaseSummonChessSoldierParam
  self._viewParamDic[SkillViewPhaseType.TeleportAndSummonTrap] = SkillPhaseTeleportAndSummonTrapParam
  self._viewParamDic[SkillViewPhaseType.NormalAttackForAddBlood] = SkillPhaseNormalAttackForAddBloodParam
  self._viewParamDic[SkillViewPhaseType.ScopePushOrPull] = SkillPhaseScopePushOrPullParam
  self._viewParamDic[SkillViewPhaseType.MiejinRoll] = SkillPhaseParam_MiejinRoll
  self._viewParamDic[SkillViewPhaseType.GatherThrowDamage] = SkillPhaseGatherThrowDamageParam
  self._viewParamDic[SkillViewPhaseType.AbsorbTrapsAndDamageByPickupTarget] = SkillPhaseAbsorbTrapsAndDamageByPickupTargetParam
  self._viewParamDic[SkillViewPhaseType.FlotageTrajectory] = SkillPhaseFlotageTrajectoryParam
  self._viewParamDic[SkillViewPhaseType.NormalAttackOnlyAnimation] = SkillPhaseNormalAttackOnlyAnimationParam
  self._viewParamDic[SkillViewPhaseType.CircularTrajectory] = SkillPhaseCircularTrajectoryParam
  self._viewParamDic[SkillViewPhaseType.NormalAttackWithMove] = SkillPhaseNormalAttackWithMoveParam
  self._viewParamDic[SkillViewPhaseType.Transposition] = SkillPhaseTranspositionParam
  self._viewParamDic[SkillViewPhaseType.TrajectoryHitOnOwnTrapPos] = SkillPhaseTrajectoryHitOnOwnTrapPosParam
  self._viewParamDic[SkillViewPhaseType.ZhongxuSummonTrapOrAttachFlag] = SkillPhaseZhongxuSummonTrapOrAttachFlagParam
  self._viewParamDic[SkillViewPhaseType.CasterRotationTrajectory] = SkillPhaseCasterRotationTrajectoryParam
  self._viewParamDic[SkillViewPhaseType.DashTeleportWithPath] = SkillPhaseDashTeleportWithPathParam
  self._viewParamDic[SkillViewPhaseType.ControlMonsterMoveAttackSummon] = SkillPhaseControlMonsterMoveAttackSummonParam
  self._viewParamDic[SkillViewPhaseType.ConvertDamageTeleportByLinkLine] = SkillPhaseConvertDamageTeleportByLinkLineParam
  self._viewParamDic[SkillViewPhaseType.DrillerSummonBaseMonster] = SkillPhaseDrillerSummonBaseMonsterParam
  self._viewParamDic[SkillViewPhaseType.DrillerSacrificeTrapAndDamage] = SkillPhaseDrillerSacrificeTrapAndDamageParam
  self._viewParamDic[SkillViewPhaseType.DrillerExplosion] = SkillPhaseDrillerExplosionParam
  self._viewParamDic[SkillViewPhaseType.DrillerExplosionSimple] = SkillPhaseDrillerExplosionSimpleParam
  self._viewParamDic[SkillViewPhaseType.NightKingTeleportDamageWithPath] = SkillPhaseNightKingTeleportDamageWithPathParam
  self._viewParamDic[SkillViewPhaseType.PetANaTuoLiTraction] = SkillPhasePetANaTuoLiTractionParam
  self._viewParamDic[SkillViewPhaseType.ScopeForwardNoAttack] = SkillPhaseScopeForwardNoAttackParam
  self._viewParamDic[SkillViewPhaseType.ScopeForwardTransformNoAttack] = SkillPhaseScopeForwardTransformNoAttackParam
  self._viewParamDic[SkillViewPhaseType.Pet1602091Chain] = SkillPhasePet1602091ChainParam
  self._viewParamDic[SkillViewPhaseType.MultiRandomTrajectory] = SkillPhaseMultiRandomTrajectoryParam
  self._viewParamDic[SkillViewPhaseType.Moye] = SkillPhaseMoyeParam
  self._blackList = {}
  self._useSkillViewIDList = {}
end

function SkillViewParamParser:ClearSkillView()
  for k, v in pairs(self._useSkillViewIDList) do
    CfgClear("cfg_skill_view_" .. k)
  end
end

function SkillViewParamParser:ParseSkillView(skillViewID, viewParams)
  local viewPhaseArray = {}
  if not skillViewID or skillViewID == 0 then
    return viewPhaseArray
  end
  local skillViewArray
  skillViewArray = self:_GetSeperateView(skillViewID)
  if skillViewArray == nil then
    Log.fatal("Can not find skill view:", skillViewID)
  end
  local phaseCount = skillViewArray and skillViewArray:Size() or 0
  if phaseCount == 0 then
    return viewPhaseArray
  end
  for i = 1, phaseCount do
    local phaseData = skillViewArray:GetAt(i)
    self:_ReplaceViewParams(viewParams, phaseData)
    self:_ParseSkillViewPhase(phaseData, viewPhaseArray)
  end
  self._useSkillViewIDList[skillViewID] = 1
  return viewPhaseArray
end

function SkillViewParamParser:_ReplaceViewParams(viewParams, phaseData)
  local Prefix = "PARAM."
  local phaseParam = phaseData.PhaseParam
  if viewParams and table.count(viewParams) > 0 and phaseParam and type(phaseParam) == "table" then
    for k, v in pairs(phaseParam) do
      if phaseData.PhaseType == SkillViewPhaseType.Instruction then
        if type(v) == "string" then
          for key, value in pairs(viewParams) do
            local str = Prefix .. key
            v = string.gsub(v, str, tostring(value))
          end
          phaseParam[k] = v
        end
      elseif type(v) == "string" then
        local result = string.find(v, Prefix) and true
        if result then
          local key = string.gsub(v, Prefix, "")
          local value = viewParams[key]
          if value then
            phaseParam[k] = value
          else
            Log.error("view params don't exit param!")
          end
        end
      end
    end
  end
end

function SkillViewParamParser:_GetSkillViewArray(skillViewID)
  local phaseArray = ArrayList:New()
  local allSkillView = Cfg.cfg_skill_view({ViewID = skillViewID})
  if not allSkillView then
    Log.fatal("skill view parse failed:", skillViewID)
    return nil
  end
  table.sort(allSkillView, function(a, b)
    return a.ViewPhase < b.ViewPhase
  end)
  for k, v in pairs(allSkillView) do
    phaseArray:PushBack(v)
  end
  return phaseArray
end

local function Sort_GetSeperateView(a, b)
  return a.ViewPhase < b.ViewPhase
end

function SkillViewParamParser:_GetSeperateView(skillViewID)
  local phaseArray = ArrayList:New()
  local skillViewTableName = "cfg_skill_view_" .. skillViewID
  if EDITOR and AUTO_RELOAD_GAME_CFG then
    CfgClear(skillViewTableName)
  end
  local fileExist = self:_CheckSeperateSkillViewExist(skillViewTableName)
  if not fileExist then
    Log.warn("skill view not seperate:", skillViewTableName)
    return nil
  end
  local inBlackList = table.icontains(self._blackList, skillViewID)
  if inBlackList then
    return nil
  end
  local skillViewList = table.cloneconf(Cfg[skillViewTableName]())
  table.sort(skillViewList, Sort_GetSeperateView)
  for k, v in ipairs(skillViewList) do
    phaseArray:Insert(v, k)
  end
  return phaseArray
end

function SkillViewParamParser:_CheckSeperateSkillViewExist(skillViewTableName)
  if ResourceManager then
    return ResourceManager:GetInstance():HasLua(skillViewTableName)
  else
    return CheckCfgExist(skillViewTableName)
  end
end

function SkillViewParamParser:_ParseSkillViewPhase(curPhase, viewPhaseArray)
  if curPhase and curPhase.PhaseType then
    local phaseClass = self._viewParamDic[curPhase.PhaseType]
    if not phaseClass then
      Log.fatal("parse skill view phase error, phase type = ", curPhase.PhaseType)
      return
    end
    local phaseViewData = phaseClass:New(curPhase.PhaseParam)
    local posdisdata
    if curPhase.PhasePosDir then
      local gridpos, griddir
      local pos = string.split(curPhase.PhasePosDir[1], ",")
      local dir = string.split(curPhase.PhasePosDir[2], ",")
      if pos[1] and pos[2] then
        gridpos = Vector2(tonumber(pos[1]), tonumber(pos[2]))
      end
      if dir[1] and dir[2] then
        griddir = Vector2(tonumber(dir[1]), tonumber(dir[2]))
      end
      posdisdata = SkillPosDirParam:New(gridpos, griddir)
    end
    local viewdata = SkillPhaseData:New(posdisdata, curPhase.DelayType, curPhase.DelayFromPhase, curPhase.DelayMS, phaseViewData)
    viewPhaseArray[#viewPhaseArray + 1] = viewdata
  end
end
