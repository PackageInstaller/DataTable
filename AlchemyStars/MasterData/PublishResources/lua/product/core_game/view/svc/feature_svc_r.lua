_class("FeatureServiceRender", BaseService)
FeatureServiceRender = FeatureServiceRender

function FeatureServiceRender:Dispose()
  self:_ResetDayNightShaderParam()
end

function FeatureServiceRender:OnBattleEnter(TT)
  self:_ResetDayNightShaderParam()
  self:_InitUIFeatureList(TT)
end

function FeatureServiceRender:_InitUIFeatureList(TT)
  local featureInitList = {}
  local utilData = self._world:GetService("UtilData")
  featureInitList = utilData:GetFeatureUiInitData()
  GameGlobal.EventDispatcher():Dispatch(GameEventType.FeatureListInit, featureInitList)
end

function FeatureServiceRender:DoFeatureOnRoundEnter(TT)
  local renderBoardEntity = self._world:GetRenderBoardEntity()
  local renderFeature = renderBoardEntity:RenderFeature()
  if renderFeature then
    local info = renderFeature:GetCurRoundDecreaseSanValue(1)
    if info then
      self:NotifySanValueChange(info.cur, info.old, info.modify)
      local svcPlayBuff = self._world:GetService("PlayBuff")
      svcPlayBuff:PlayBuffView(TT, NTSanValueChange:New(info.cur, info.old, info.debt, info._modifyTimes))
    end
    local dayNightInfo = renderFeature:GetCurRoundDayNightRouncChangeValue(1)
    if dayNightInfo then
      self:NotifyDayNightDataChange(dayNightInfo._curState, dayNightInfo._restRound)
      local svcPlayBuff = self._world:GetService("PlayBuff")
      if dayNightInfo._curState ~= dayNightInfo._oldState then
        self:_DoSceneSwitchDayNight(TT, dayNightInfo._curState)
        svcPlayBuff:PlayBuffView(TT, NTDayNightStateChange:New(dayNightInfo._curState, dayNightInfo._oldState))
      end
    end
  end
end

function FeatureServiceRender:DoFeatureOnRoundEnterEarly(TT)
  local renderBoardEntity = self._world:GetRenderBoardEntity()
  local renderFeature = renderBoardEntity:RenderFeature()
  if renderFeature then
    local info = renderFeature:GetCurRoundChangeStepPoint(1)
    if info then
      local isRoundRecover = true
      self:NotifyStepPointChange(info.cur, info.old, isRoundRecover)
    end
  end
end

function FeatureServiceRender:_DoSceneSwitchDayNight(TT, toState)
  local goRenderSetting = UnityEngine.GameObject.Find("[H3DRenderSetting]")
  if goRenderSetting then
    local anim = goRenderSetting:GetComponent("Animation")
    local animName = "anim_jdzz_daylight"
    local duration = 1
    local oldVal = 0
    local newVal = 1
    local effId
    if toState == FeatureDayNightState.Day then
      animName = "anim_jdzz_daylight"
      oldVal = 0
      newVal = 1
      effId = BattleConst.DayNightToDayDefaultEffID
    else
      animName = "anim_jdzz_nightlight"
      oldVal = 1
      newVal = 0
      effId = BattleConst.DayNightToNightDefaultEffID
    end
    local utilDataSvc = self._world:GetService("UtilData")
    local posCenter = utilDataSvc:GetBoardCenterPos()
    local serEffect = self._world:GetService("Effect")
    serEffect:CreateWorldPositionEffect(effId, posCenter, true)
    YIELD(TT, 500)
    if anim then
      anim:Play(animName)
    end
    DoTweenHelper.DoUpdateFloat(oldVal, newVal, duration, function(percent)
      UnityEngine.Shader.SetGlobalFloat("_LightmapSwitch", percent)
    end)
  end
end

function FeatureServiceRender:ModifyDayNightData(TT, oldState, newState, restRound)
  Log.debug("Feature render,buff modify dayNight, oldState:", oldState, " newState:", newState, " restRound:", restRound)
  self:NotifyDayNightDataChange(newState, restRound)
  local svcPlayBuff = self._world:GetService("PlayBuff")
  if newState ~= oldState then
    self:_DoSceneSwitchDayNight(TT, newState)
    svcPlayBuff:PlayBuffView(TT, NTDayNightStateChange:New(newState, oldState))
  end
end

function FeatureServiceRender:_ResetDayNightShaderParam()
  UnityEngine.Shader.SetGlobalFloat("_LightmapSwitch", 1)
end

function FeatureServiceRender:NotifySanValueChange(curValue, oldValue, modifyValue, forceRefresh)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.FeatureSanValueChange, curValue, oldValue, modifyValue, forceRefresh)
  self:_SanScreenEffOnValueChange(curValue, oldValue, modifyValue)
end

function FeatureServiceRender:NotifySanMaxValueChange(curValue, oldValue, modifyValue, curMaxVal)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.FeatureSanMaxValueChange, curValue, oldValue, modifyValue, curMaxVal)
  self:_SanScreenEffOnValueChange(curValue, oldValue, modifyValue)
end

function FeatureServiceRender:_SanScreenEffOnValueChange(curValue, oldValue, modifyValue)
  local effStartSan = self:_GetSanViewEffStartVal()
  if self._sanScreenEffEntity then
    if curValue > effStartSan then
      if self._sanScreenEffGo then
        self._sanScreenEffGo:SetActive(false)
      end
    else
      self:_UpdateSanScreenEff(curValue)
    end
  elseif curValue <= effStartSan then
    self:_CreateSanScreenEff()
    self:_UpdateSanScreenEff(curValue)
  end
end

function FeatureServiceRender:_CreateSanScreenEff()
  if self._sanScreenEffEntity then
    return
  end
  local serEffect = self._world:GetService("Effect")
  self._sanScreenEffEntity = serEffect:CreateScreenEffPointEffect(BattleConst.SanCameraEffID)
  if self._sanScreenEffEntity then
    self._sanScreenEffGo = self._sanScreenEffEntity:View():GetGameObject()
    self._sanEffAnim = self._sanScreenEffGo:GetComponent("Animation")
    if self._sanEffAnim then
      self._sanEffAnimState = self._sanEffAnim:get_Item("uieffanim_FeatureSan_Camera")
    end
  end
end

function FeatureServiceRender:_UpdateSanScreenEff(curVal)
  local topVal = self:_GetSanViewEffStartVal()
  local bottomVal = 0
  local rangeVal = topVal - bottomVal
  if rangeVal < 0 then
    return
  end
  if self._sanScreenEffGo then
    self._sanScreenEffGo:SetActive(true)
  end
  if self._sanEffAnim and self._sanEffAnimState then
    local percent = curVal / rangeVal
    local animPercent = 1 - percent
    self._sanEffAnimState.enabled = true
    self._sanEffAnimState.normalizedTime = animPercent
    self._sanEffAnimState.weight = 1
    self._sanEffAnim:Sample()
    self._sanEffAnimState.enabled = false
  end
end

function FeatureServiceRender:_GetSanViewEffStartVal()
  if not self._sanViewEffStartVal then
    local sanData = FeatureServiceHelper.GetFeatureData(FeatureType.Sanity)
    if sanData then
      local sanityParam = sanData:GetSanityParam()
      if sanityParam then
        local viewStartVal = sanityParam.viewEffStartVal
        viewStartVal = viewStartVal or BattleConst.SanViewEffDefaultStartVal
        self._sanViewEffStartVal = viewStartVal
      end
    end
  end
  return self._sanViewEffStartVal
end

function FeatureServiceRender:NotifyDayNightDataChange(state, restRound)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.FeatureDayNightRefresh, state, restRound)
end

function FeatureServiceRender:NotifyDayNightUIStyleChange(uiStyle)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.FeatureDayNightChangeUIStyle, uiStyle)
end

function FeatureServiceRender:IsActiveSkillCanCastInPreview(casterEntity, skillID, previewContext)
  local context = {}
  local previewAttackGridList = previewContext:GetScopeResult() or {}
  context.scopeGridCount = #previewAttackGridList
  return FeatureServiceHelper.IsActiveSkillCanCast(casterEntity, skillID, context)
end

function FeatureServiceRender:NotifyFeatureSkillPowerChange(featureType, curPower, curReady)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.PersonaPowerChange, featureType, curPower, curReady)
end

function FeatureServiceRender:NotifyShopCoinCountChange(curValue, oldValue, modifyValue)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.FeatureCoinCountChange, curValue, oldValue, modifyValue)
end

function FeatureServiceRender:NotifyStepPointChange(curValue, oldValue, isRoundRecover)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.FeatureStepPointRefresh, curValue, oldValue, isRoundRecover)
end

function FeatureServiceRender:NotifyMaxStepPointChange(curValue, oldValue)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.FeatureMaxStepPointRefresh, curValue, oldValue)
end

function FeatureServiceRender:NotifyRecoverStepPointChange(curValue, oldValue)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.FeatureRecoverStepPointRefresh, curValue, oldValue)
end

function FeatureServiceRender:DoFeatureOnRoleMoveEnter(TT)
  local renderBoardEntity = self._world:GetRenderBoardEntity()
  local renderFeature = renderBoardEntity:RenderFeature()
  if renderFeature then
    local info = renderFeature:GetMoveCostStepPoint(1)
    if info then
      self:NotifyStepPointChange(info.cur, info.old)
      local costVal = info.cur - info.old
      local svcPlayBuff = self._world:GetService("PlayBuff")
      local teamEntity = self._world:Player():GetCurrentTeamEntity()
      svcPlayBuff:PlayBuffView(TT, NTFeatureStepPointMoveCost:New(teamEntity, info.cur, info.old, costVal))
      renderFeature:ClearMoveCostStepPoint()
    end
  end
end

function FeatureServiceRender:OnLinkLineChainPathChange(chainPath, isCancel)
  if self._world:LinkLineType() == ELinkLineType.ELLT_LINE_NoElementCostStep then
    local extraRecover = self:CalcExtraRecoverStepPointForLinkUI(chainPath)
    local playLongAnim = false
    GameGlobal.EventDispatcher():Dispatch(GameEventType.FeatureStepPointRefreshByLink, chainPath, extraRecover, playLongAnim)
  end
end

function FeatureServiceRender:AddExtraRecoverStepPointForLinkUI(flagID, stepMin, stepMax, modifyValue)
  local renderBoardEntity = self._world:GetRenderBoardEntity()
  local renderFeature = renderBoardEntity:RenderFeature()
  if renderFeature then
    renderFeature:AddExtraRecoverStepPointForLinkUI(flagID, stepMin, stepMax, modifyValue)
  end
end

function FeatureServiceRender:RemoveExtraRecoverStepPointForLinkUI(flagID)
  local renderBoardEntity = self._world:GetRenderBoardEntity()
  local renderFeature = renderBoardEntity:RenderFeature()
  if renderFeature then
    renderFeature:RemoveExtraRecoverStepPointForLinkUI(flagID)
  end
end

function FeatureServiceRender:ClearExtraRecoverStepPointForLinkUI()
  local renderBoardEntity = self._world:GetRenderBoardEntity()
  local renderFeature = renderBoardEntity:RenderFeature()
  if renderFeature then
    renderFeature:ClearExtraRecoverStepPointForLinkUI()
  end
end

function FeatureServiceRender:CalcExtraRecoverStepPointForLinkUI(chainPath)
  local renderBoardEntity = self._world:GetRenderBoardEntity()
  local renderFeature = renderBoardEntity:RenderFeature()
  if renderFeature then
    return renderFeature:CalcExtraRecoverStepPointForLinkUI(chainPath)
  end
end

function FeatureServiceRender:NotifyAUOEValueChange(curValue)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.FeatureAUOEValueChange, curValue)
end

function FeatureServiceRender:NotifyAlchemyAPChange(TT, ap, level, addAP)
  local utilData = self._world:GetService("UtilData")
  GameGlobal.EventDispatcher():Dispatch(GameEventType.FeatureAddAlchemyAP, ap, level, addAP)
end

function FeatureServiceRender:NotifyTetrisOP(opType, opValue)
  GameGlobal.TaskManager():CoreGameStartTask(function(TT)
    if opType == TetrisFeatureCmdOPType.Lock then
      GameGlobal.EventDispatcher():Dispatch(GameEventType.TetrisFeatureLock, opValue)
    end
    if opType == TetrisFeatureCmdOPType.ReRoll then
      local svcPlayBuff = self._world:GetService("PlayBuff")
      svcPlayBuff:PlayBuffView(TT, NTRandomTetrisEnd:New(nil, opValue[1], opValue[2]))
      self:NotifyTetrisRandom(TT, opValue[1], opValue[2])
      self:NotifyTetrisPower(TT, opValue[3])
    end
  end)
end

function FeatureServiceRender:NotifyTetrisRandom(TT, tetrisIndex, tetrisType)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.TetrisFeatureRandom, tetrisIndex, tetrisType)
end

function FeatureServiceRender:NotifyTetrisPower(TT, newPower)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.TetrisFeatureChangePower, newPower)
end
