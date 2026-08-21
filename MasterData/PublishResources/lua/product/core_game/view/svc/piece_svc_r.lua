_class("PieceServiceRender", Object)
PieceServiceRender = PieceServiceRender

function PieceServiceRender:Constructor(world)
  self._world = world
  local chessItemID = UIPropertyHelper:GetInstance():GetChessItemID()
  local itemChessConfig = Cfg.cfg_item_chess[chessItemID]
  self._pieceSkinID = itemChessConfig.pieceSkinID
  self._hasGridLineInCfg = itemChessConfig.hasGridLine
  self._piecePrefabConfigDefault = Cfg.cfg_piece_prefab[1]
  self._piecePrefabConfig = Cfg.cfg_piece_prefab[self._pieceSkinID]
  self._pieceLayerConfig = Cfg.cfg_piece_layer
  self.applyPieceAnimation = {}
  self.applyPieceAnimation.Normal = self._ApplyPieceNormal
  self.applyPieceAnimation.Birth = self._ApplyPieceBirth
  self.applyPieceAnimation.Dark = self._ApplyPieceDark
  self.applyPieceAnimation.Up = self._ApplyPieceUp
  self.applyPieceAnimation.Down = self._ApplyPieceDown
  self.applyPieceAnimation.LinkIn = self._ApplyPieceLinkIn
  self.applyPieceAnimation.LinkOut = self._ApplyPieceLinkOut
  self.applyPieceAnimation.LinkDone = self._ApplyPieceLinkDone
  self.applyPieceAnimation.MoveDone = self._ApplyPieceMoveDone
  self.applyPieceAnimation.DarkByParam = self._ApplyPieceDarkByParam
  self.applyPieceAnimation.UltBlack = self._ApplyPieceUltBlack
  self.applyPieceAnimation.UltSliver = self._ApplyPieceUltSliver
  self.applyPieceAnimation.UltGray = self._ApplyPieceUltGray
  self.applyPieceAnimation.UltColor = self._ApplyPieceUltColor
  self.applyPieceAnimation.UltAtkColor = self._ApplyPieceUltAtkColor
  self.applyPieceAnimation.UltInvalid = self._ApplyPieceUltInvalid
  self.applyPieceAnimation.UltAdd = self._ApplyPieceUltAdd
  self.applyPieceAnimation.UltReflash = self._ApplyPieceUltReflash
  self._pieceAnimationClips = nil
  self._pieceAnimationContainerPrefab = ResourceManager:GetInstance():SyncLoadAsset("PieceAnimationClipList.prefab", LoadType.GameObject)
  if self._pieceAnimationContainerPrefab and self._pieceAnimationContainerPrefab.Obj then
    local pieceAnimation = self._pieceAnimationContainerPrefab.Obj:GetComponent("Animation")
    if pieceAnimation then
      self._pieceAnimationClips = HelperProxy:GetInstance():GetAllAnimationClip(pieceAnimation)
    end
  end
  self._hasGridLineWithBoardMode = nil
end

function PieceServiceRender:Initialize()
end

function PieceServiceRender:GetPieceHasGridLine()
  return self._hasGridLineInCfg
end

function PieceServiceRender:SetHasGridLineWithBoardMode(show)
  self._hasGridLineWithBoardMode = show
end

function PieceServiceRender:GetHasGridLineWithBoardMode()
  return self._hasGridLineWithBoardMode
end

function PieceServiceRender:GetPieceLayerConfig()
  return self._pieceLayerConfig
end

function PieceServiceRender:GetPiecePrefabConfig()
  return self._piecePrefabConfig
end

function PieceServiceRender:GetPiecePrefabConfigDefault()
  return self._piecePrefabConfigDefault
end

function PieceServiceRender:GetPieceConfigBase()
  return "gezi_base.prefab"
end

function PieceServiceRender:GetGridPrefabPathConfig(gridTypeString)
  local piecePrefabConfig = self:GetPiecePrefabConfig()
  local gridPrefabPath = piecePrefabConfig[gridTypeString]
  if gridPrefabPath == nil then
    local piecePrefabConfigDefault = self:GetPiecePrefabConfigDefault()
    gridPrefabPath = piecePrefabConfigDefault[gridTypeString]
  end
  if not gridPrefabPath or gridPrefabPath == "" then
    Log.error("[GetGridPrefabPathConfig] cant find prefab with key=" .. gridTypeString .. "   " .. debug.traceback())
  end
  return gridPrefabPath
end

function PieceServiceRender:GetGridPrefabPath(gridType)
  local gridTypeString = self:_GetGridTypeString(gridType)
  local gridPrefabPath = self:GetGridPrefabPathConfig(gridTypeString)
  return gridPrefabPath
end

function PieceServiceRender:GetGridPrefabPathFinal(pieceType, pieceEffectType)
  local gridEffectStr = self:_GetGridEffectTypeString(pieceEffectType)
  local gridTypeStr = self:_GetGridTypeString(pieceType)
  local piecePrefabKey = gridEffectStr .. gridTypeStr
  return piecePrefabKey
end

function PieceServiceRender:_GetGridEffectTypeString(pieceEffectType)
  if pieceEffectType == PieceEffectType.Normal then
    return ""
  else
    return GetEnumKey("PieceEffectType", pieceEffectType) or ""
  end
  return ""
end

function PieceServiceRender:_GetGridTypeString(pieceType)
  if pieceType == PieceType.None then
    return "Gray"
  else
    return GetEnumKey("PieceType", pieceType) or "Gray"
  end
  return "Gray"
end

function PieceServiceRender:SetPieceEntityPieceType(pieceEntity, pieceType)
  pieceEntity:ReplacePiece(pieceType)
  local pieceComponent = pieceEntity:Piece()
  local hasInitAsset = pieceComponent:HasInitAsset()
  if hasInitAsset == false then
    local pieceBase = self:GetPieceConfigBase()
    pieceEntity:ReplaceAsset(NativeUnityPrefabAsset:New(pieceBase))
    pieceComponent:SetInitAsset()
    local pieceBasePrefabObj = pieceEntity:View():GetGameObject()
  end
  local curAnim = pieceComponent:GetPieceAnimName()
  self:_OnHidePiecePrefabSameLayer(pieceEntity, curAnim)
  local pieceEffectType = pieceComponent:GetRenderPieceEffectType()
  local piecePrefabKey = self:GetGridPrefabPathFinal(pieceType, pieceEffectType)
  self:_OnShowPiecePrefab(pieceEntity, piecePrefabKey)
end

function PieceServiceRender:GetPieceAnimation(pos)
  local pieceEntity = self:FindPieceEntity(pos)
  if not pieceEntity then
    return
  end
  local pieceComponent = pieceEntity:Piece()
  local curAnim = pieceComponent:GetPieceAnimName()
  return curAnim
end

function PieceServiceRender:SetPieceAnimation(pos, anim, force, param)
  local pieceEntity = self:FindPieceEntity(pos)
  if not pieceEntity then
    return
  end
  local pieceComponent = pieceEntity:Piece()
  local curAnim = pieceComponent:GetPieceAnimName()
  if curAnim == anim and not force then
    return
  end
  self:_OnHidePiecePrefabSameLayer(pieceEntity, curAnim, anim)
  self:_OnCheckShowCurPieceTypePrefab(pieceEntity)
  pieceComponent:SetPieceAnimName(anim)
  local applyFunc = self.applyPieceAnimation[anim]
  if applyFunc ~= nil then
    applyFunc(self, pos, pieceEntity, anim, param)
  end
end

function PieceServiceRender:ResetPieceAnimation(pos)
  local curAnim = self:GetPieceAnimation(pos)
  if curAnim then
    local forcePlay = true
    self:SetPieceAnimation(pos, curAnim, forcePlay)
  end
end

function PieceServiceRender:_InitAnimation(gameObject)
  local anim = gameObject:GetComponent(typeof(UnityEngine.Animation))
  anim = anim or gameObject:AddComponent(typeof(UnityEngine.Animation))
  if not self._pieceAnimationClips then
    return
  end
  for i = 0, self._pieceAnimationClips.Length - 1 do
    if self._pieceAnimationClips[i] ~= nil then
      anim:AddClip(self._pieceAnimationClips[i], self._pieceAnimationClips[i].name)
    end
  end
end

function PieceServiceRender:SetAllPieceNormal()
  local pieceGroup = self._world:GetGroup(self._world.BW_WEMatchers.Piece)
  for _, e in ipairs(pieceGroup:GetEntities()) do
    local pos = e:GetGridPosition()
    self:SetPieceAnimNormal(pos)
  end
end

function PieceServiceRender:SetAllPieceDark()
  local pieceGroup = self._world:GetGroup(self._world.BW_WEMatchers.Piece)
  for _, e in ipairs(pieceGroup:GetEntities()) do
    local pos = e:GetGridPosition()
    self:SetPieceAnimDark(pos)
  end
end

function PieceServiceRender:SetAllPieceDarkParam(duration, endValue)
  local pieceGroup = self._world:GetGroup(self._world.BW_WEMatchers.Piece)
  for _, e in ipairs(pieceGroup:GetEntities()) do
    local pos = e:GetGridPosition()
    self:SetPieceAnimDarkParam(pos, duration, endValue)
  end
end

function PieceServiceRender:RefreshMonsterPiece(targetEntity, bUp)
  local renderPos = targetEntity:GetRenderGridPosition()
  local area = targetEntity:BodyArea():GetArea()
  for i, p in ipairs(area) do
    local posWork = renderPos + p
    if bUp then
      self:SetPieceAnimUp(posWork)
    else
      self:SetPieceAnimDown(posWork)
    end
  end
end

function PieceServiceRender:SetPieceAnimBirth(pos)
  self:SetPieceAnimation(pos, "Birth")
end

function PieceServiceRender:SetPieceAnimNormal(pos, force)
  self:SetPieceAnimation(pos, "Normal", force)
end

function PieceServiceRender:SetPieceAnimDark(pos)
  self:SetPieceAnimation(pos, "Dark")
end

function PieceServiceRender:SetPieceAnimDarkParam(pos, duration, endValue)
  self:SetPieceAnimation(pos, "DarkByParam", false, {duration, endValue})
end

function PieceServiceRender:SetPieceAnimUp(pos)
  self:SetPieceAnimation(pos, "Up")
end

function PieceServiceRender:SetPieceAnimDown(pos)
  self:SetPieceAnimation(pos, "Down")
end

function PieceServiceRender:SetPieceAnimLinkIn(pos)
  self:SetPieceAnimation(pos, "LinkIn")
end

function PieceServiceRender:SetPieceAnimLinkOut(pos)
  self:SetPieceAnimation(pos, "LinkOut")
end

function PieceServiceRender:SetPieceAnimLinkDone(pos)
  self:SetPieceAnimation(pos, "LinkDone")
end

function PieceServiceRender:SetPieceAnimMoveDone(pos)
  self:SetPieceAnimation(pos, "MoveDone")
end

function PieceServiceRender:SetPieceAnimBlack(pos)
  self:SetPieceAnimation(pos, "UltBlack")
end

function PieceServiceRender:SetPieceAnimSliver(pos)
  self:SetPieceAnimation(pos, "UltSliver")
end

function PieceServiceRender:SetPieceAnimGray(pos)
  self:SetPieceAnimation(pos, "UltGray")
end

function PieceServiceRender:SetPieceAnimColor(pos, pieceType)
  local force = false
  self:SetPieceAnimation(pos, "UltColor", force, {pieceType})
end

function PieceServiceRender:SetPieceAnimAtkColor(pos)
  self:SetPieceAnimation(pos, "UltAtkColor")
end

function PieceServiceRender:SetPieceAnimInvalid(pos)
  self:SetPieceAnimation(pos, "UltInvalid")
end

function PieceServiceRender:SetPieceAnimAdd(pos)
  self:SetPieceAnimation(pos, "UltAdd")
end

function PieceServiceRender:SetPieceAnimReflash(pos)
  self:SetPieceAnimation(pos, "UltReflash")
end

function PieceServiceRender:SetPieceGameoejectPlayAnim(gameObject, animName)
  if not gameObject then
    return
  end
  local anim = gameObject:GetComponent("Animation")
  if not anim then
    return
  end
  if anim.isPlaying then
    anim:PlayQueued(animName, UnityEngine.QueueMode.CompleteOthers)
  else
    anim:Play(animName)
  end
end

function PieceServiceRender:SetPieceGameoejectPlayAnimList(gameObject, animNameList)
  if not gameObject then
    return
  end
  local anim = gameObject:GetComponent("Animation")
  if not anim then
    return
  end
  for _, v in ipairs(animNameList) do
    anim:PlayQueued(v, UnityEngine.QueueMode.CompleteOthers)
  end
end

function PieceServiceRender:SetPieceEntityPlayAnim(pieceEntity, animName)
  local pieceComponent = pieceEntity:Piece()
  pieceComponent = pieceComponent or pieceEntity:PieceFake()
  local curPiecePrefabObj = pieceComponent:GetBaseLayerObj()
  if not curPiecePrefabObj then
    return
  end
  self:SetPieceGameoejectPlayAnim(curPiecePrefabObj, animName)
end

function PieceServiceRender:SetPieceEntityBirth(pieceEntity)
end

function PieceServiceRender:SetPieceEntityAnimNormal(pieceEntity)
  local pieceComponent = pieceEntity:Piece()
  local curAnim = pieceComponent:GetPieceAnimName()
  self:_OnHidePiecePrefabSameLayer(pieceEntity, curAnim)
  pieceComponent:SetPieceAnimName("Normal")
  self:_ApplyPieceNormal(nil, pieceEntity)
end

function PieceServiceRender:SetPieceEntityAnimDark(pieceEntity)
  self:_ApplyPieceDark(nil, pieceEntity)
end

function PieceServiceRender:SetPieceFakeEntityAnimDark(gridFakeEntity)
  self:_ApplyPieceDark(nil, gridFakeEntity)
end

function PieceServiceRender:_ApplyPieceNormal(pos, pieceEntity, anim)
  local startValue
  local endValue = 1
  local duration = 0
  self:SetMaterialDarkness(pieceEntity, startValue, endValue, duration)
  self:_OnPlayAnimaNormalWithGridLine(pieceEntity)
end

function PieceServiceRender:_ApplyPieceBirth(pos, pieceEntity, anim)
  self:SetPieceEntityPlayAnim(pieceEntity, "Anim_gezi_1001_birth")
end

function PieceServiceRender:_ApplyPieceDark(pos, pieceEntity, anim)
  local startValue
  local endValue = 0.5
  local duration = 0.16
  self:SetMaterialDarkness(pieceEntity, startValue, endValue, duration)
  self:_HasGridLineSendCellRenderEvent(pieceEntity, false)
end

function PieceServiceRender:_ApplyPieceDarkByParam(pos, pieceEntity, anim, params)
  local startValue
  local endValue = params and params[2] or 0.5
  local duration = params and params[1] or 0.16
  self:SetMaterialDarkness(pieceEntity, startValue, endValue, duration)
  self:_HasGridLineSendCellRenderEvent(pieceEntity, false)
end

function PieceServiceRender:_ApplyPieceUp(pos, pieceEntity, anim)
  local startValue = 0.5
  local endValue = 1
  local duration = 0.16
  self:SetMaterialDarkness(pieceEntity, startValue, endValue, duration)
  self:_OnPlayAnimaNormalWithGridLine(pieceEntity)
end

function PieceServiceRender:_ApplyPieceDown(pos, pieceEntity, anim)
  local startValue = 1
  local endValue = 0.5
  local duration = 0.16
  self:SetMaterialDarkness(pieceEntity, startValue, endValue, duration)
  self:_OnPlayAnimaNormalWithGridLine(pieceEntity)
end

function PieceServiceRender:_ApplyPieceLinkIn(pos, pieceEntity, anim)
  local pieceComponent = pieceEntity:Piece()
  local pieceType = GetEnumKey("PieceType", pieceComponent:GetPieceType())
  local linkInPrefabKey = "LinkIn" .. tostring(pieceType)
  self:_OnShowPiecePrefab(pieceEntity, linkInPrefabKey)
end

function PieceServiceRender:_ApplyPieceLinkOut(pos, pieceEntity, anim)
  self:SetPieceEntityPlayAnim(pieceEntity, "Anim_gezi_1001_linkout")
  self:SetPieceAnimation(pos, "Normal")
end

function PieceServiceRender:_ApplyPieceLinkDone(pos, pieceEntity, anim)
  self:SetPieceAnimation(pos, "Normal")
end

function PieceServiceRender:_ApplyPieceMoveDone(pos, pieceEntity, anim)
  self:_OnShowPiecePrefab(pieceEntity, "MoveDone")
end

function PieceServiceRender:_ApplyPieceUltBlack(pos, pieceEntity, anim)
  self:_OnShowPiecePrefab(pieceEntity, "UltBlack")
  self:_HasGridLineSendCellRenderEvent(pieceEntity, true)
end

function PieceServiceRender:_ApplyPieceUltSliver(pos, pieceEntity, anim)
  self:_OnShowPiecePrefab(pieceEntity, "UltSliver")
  self:_HasGridLineSendCellRenderEvent(pieceEntity, true)
end

function PieceServiceRender:_ApplyPieceUltGray(pos, pieceEntity, anim)
  self:_OnShowPiecePrefab(pieceEntity, "UltGray")
  self:_HasGridLineSendCellRenderEvent(pieceEntity, true)
end

function PieceServiceRender:_ApplyPieceUltColor(pos, pieceEntity, anim, param)
  local pieceType = param[1]
  local pieceType = GetEnumKey("PieceType", pieceType)
  local linkInPrefabKey = "UltColor" .. tostring(pieceType)
  self:_OnShowPiecePrefab(pieceEntity, linkInPrefabKey)
end

function PieceServiceRender:_ApplyPieceUltAtkColor(pos, pieceEntity, anim)
  self:_OnShowPiecePrefab(pieceEntity, "UltAtkColor")
  self:_HasGridLineSendCellRenderEvent(pieceEntity, true)
end

function PieceServiceRender:_ApplyPieceUltInvalid(pos, pieceEntity, anim)
  self:SetPieceEntityPlayAnim(pieceEntity, "Anim_gezi_1001_invalid")
end

function PieceServiceRender:_ApplyPieceUltAdd(pos, pieceEntity, anim)
  self:SetPieceEntityPlayAnim(pieceEntity, "Anim_gezi_ult_add")
end

function PieceServiceRender:_ApplyPieceUltReflash(pos, pieceEntity, anim)
  self:_OnShowPiecePrefab(pieceEntity, "UltReflash")
  self:_HasGridLineSendCellRenderEvent(pieceEntity, true)
end

function PieceServiceRender:_OnCheckHasGridLine()
  local hasGridLine = self:GetPieceHasGridLine()
  if hasGridLine ~= 1 then
    return false
  end
  local hasGridLineWithBoardMode = self:GetHasGridLineWithBoardMode()
  if hasGridLineWithBoardMode == false then
    return false
  end
  if hasGridLineWithBoardMode == nil then
    local renderBoardEntity = self._world:GetRenderBoardEntity()
    local renderBoardCmpt = renderBoardEntity:RenderBoard()
    local brillantLineObj = renderBoardCmpt:GetBrillantGridObj()
    if brillantLineObj == nil or brillantLineObj.activeInHierarchy == false then
      return false
    end
  end
  return true
end

function PieceServiceRender:_OnPlayAnimaNormalWithGridLine(pieceEntity)
  self:SetPieceEntityPlayAnim(pieceEntity, "Anim_gezi_1001_normal")
  local checkHasGridLine = self:_OnCheckHasGridLine()
  if checkHasGridLine then
    self:SetPieceEntityPlayAnim(pieceEntity, "Anim_gezi_1001_normal")
  else
    self:SetPieceEntityPlayAnim(pieceEntity, "Anim_gezi_1001_normal_no_event")
  end
end

function PieceServiceRender:_HasGridLineSendCellRenderEvent(pieceEntity, showLine)
  local checkHasGridLine = self:_OnCheckHasGridLine()
  if checkHasGridLine == false then
    return
  end
  if showLine then
    self:SetPieceEntityPlayAnim(pieceEntity, "Anim_gezi_Event_CellRender_OnDisable")
  else
    self:SetPieceEntityPlayAnim(pieceEntity, "Anim_gezi_Event_CellRender_OnEnable")
  end
end

function PieceServiceRender:_OnCheckShowCurPieceTypePrefab(pieceEntity)
  local pieceComponent = pieceEntity:Piece()
  local pieceType = pieceComponent:GetPieceType()
  local pieceEffectType = pieceComponent:GetRenderPieceEffectType()
  local piecePrefabKey = self:GetGridPrefabPathFinal(pieceType, pieceEffectType)
  self:_OnShowPiecePrefab(pieceEntity, piecePrefabKey)
end

function PieceServiceRender:CheckPiecePrefabValid(prefab)
  if GameGlobal.GetModule(SkillPerfModule):IsBeginPerf() then
    return not tolua.isnull(prefab) and prefab ~= nil
  end
  return prefab
end

function PieceServiceRender:_OnShowPiecePrefab(pieceEntity, piecePrefabKey)
  local pieceComponent = pieceEntity:Piece()
  pieceComponent = pieceComponent or pieceEntity:PieceFake()
  local layerName = self:_OnGetPieceLayerName(piecePrefabKey)
  local curPiecePrefabKey = pieceComponent:OnGetLayerPrefabName(layerName)
  if curPiecePrefabKey == piecePrefabKey then
    return
  end
  local curPiecePrefabObj = pieceComponent:OnGetLayerPrefabObj(layerName)
  if self:CheckPiecePrefabValid(curPiecePrefabObj) then
    curPiecePrefabObj:SetActive(false)
  end
  local piecePrefabObj = pieceComponent:GetPiecePrefabObj(piecePrefabKey)
  if not piecePrefabObj then
    local sEntity = self._world:GetService("RenderEntity")
    local gridPrefabEntity = sEntity:CreateRenderEntity(EntityConfigIDRender.GridPrefab)
    local piecePrefabPath = self:GetGridPrefabPathConfig(piecePrefabKey)
    if piecePrefabPath then
      gridPrefabEntity:ReplaceAsset(NativeUnityPrefabAsset:New(piecePrefabPath))
    end
    if gridPrefabEntity:View() then
      piecePrefabObj = gridPrefabEntity:View():GetGameObject()
      pieceComponent:SetPiecePrefabObj(layerName, piecePrefabKey, piecePrefabObj, gridPrefabEntity)
      self:_InitAnimation(piecePrefabObj)
    end
  end
  pieceComponent:OnSetLayerPrefab(layerName, piecePrefabKey, piecePrefabObj)
  if self:CheckPiecePrefabValid(piecePrefabObj) then
    piecePrefabObj:SetActive(true)
  end
end

function PieceServiceRender:_OnHidePiecePrefabSameLayer(pieceEntity, lastAnimaName, newAnimaName)
  local layerName = self:_OnGetPieceLayerName(lastAnimaName)
  if not layerName then
    return
  end
  if layerName ~= "EffectLayer" then
    return
  end
  local pieceComponent = pieceEntity:Piece()
  local curPiecePrefabObj = pieceComponent:OnGetLayerPrefabObj(layerName)
  self:_OnHideCurPiecePrefabObj(curPiecePrefabObj, lastAnimaName)
  pieceComponent:OnSetLayerPrefabName(layerName, nil)
end

function PieceServiceRender:_OnHideCurPiecePrefabObj(piecePrefabObj, lastAnimaName)
  if piecePrefabObj and tostring(piecePrefabObj) ~= "null" then
    local playAnimNameOut = self:_OnGetPiecePlayAnimNameOut(lastAnimaName)
    if playAnimNameOut then
      GameGlobal.TaskManager():CoreGameStartTask(function(TT)
        self:SetPieceGameoejectPlayAnim(piecePrefabObj, playAnimNameOut)
        local animaTime = self:_OnGetPiecePlayAnimNameOutTime(lastAnimaName)
        YIELD(TT, animaTime)
        piecePrefabObj:SetActive(false)
      end)
    else
      piecePrefabObj:SetActive(false)
    end
  end
end

function PieceServiceRender:_OnGetPiecePlayAnimNameOut(animName)
  local pieceLayerConfig = self:GetPieceLayerConfig()[animName]
  return pieceLayerConfig.PlayAnimNameOut
end

function PieceServiceRender:_OnGetPiecePlayAnimNameOutTime(animName)
  local pieceLayerConfig = self:GetPieceLayerConfig()[animName]
  return pieceLayerConfig.PlayAnimNameOutTime
end

function PieceServiceRender:_OnGetPieceLayerName(animName)
  local pieceLayerConfig = self:GetPieceLayerConfig()[animName]
  local layerName = "BaseLayer"
  if pieceLayerConfig then
    layerName = pieceLayerConfig.Layer
  end
  return layerName
end

function PieceServiceRender:SetMaterialDarkness(pieceEntity, startValue, endValue, duration)
  local pieceComponent = pieceEntity:Piece()
  pieceComponent = pieceComponent or pieceEntity:PieceFake()
  local curPiecePrefabObj = pieceComponent:GetBaseLayerObj()
  local lastDoTween = pieceComponent:GetDoTweenMaterialDarkness()
  if lastDoTween then
    lastDoTween:Kill()
  end
  local doTween = self:SetGameObjectMaterialDarkness(curPiecePrefabObj, startValue, endValue, duration)
  pieceComponent:SetDoTweenMaterialDarkness(doTween)
end

function PieceServiceRender:SetGameObjectMaterialDarkness(gameObject, startValue, endValue, duration)
  if not gameObject or tostring(gameObject) == "null" then
    return
  end
  local csMeshRenderer = gameObject:GetComponentInChildren(typeof(UnityEngine.MeshRenderer))
  if not csMeshRenderer or tostring(csMeshRenderer) == "null" then
    return
  end
  local csMaterial = csMeshRenderer.material
  if not csMaterial or tostring(csMaterial) == "null" then
    return
  end
  local tween = csMaterial:DOFloat(endValue, "_Darkness", duration):SetEase(DG.Tweening.Ease.InOutQuad)
  return tween
end

function PieceServiceRender:RefreshMonsterAreaOutLine(TT)
  local utilDataSvc = self._world:GetService("UtilData")
  local round = utilDataSvc:GetStatCurWaveTotalRoundCount()
  local waveIndex = utilDataSvc:GetStatCurWaveIndex()
  local renderEntityService = self._world:GetService("RenderEntity")
  local monsterGroup = self._world:GetGroup(self._world.BW_WEMatchers.MonsterID)
  for _, e in ipairs(monsterGroup:GetEntities()) do
    if not e:HasDeadFlag() and e:View() then
      renderEntityService:DestroyMonsterAreaOutLineEntity(e)
    end
  end
  YIELD(TT)
  for _, e in ipairs(monsterGroup:GetEntities()) do
    if not e:HasGhost() and not e:HasGuideGhost() and not e:HasDeadFlag() and e:View() and not utilDataSvc:IsAIAttachState(e, round, waveIndex) and e:MonsterID():IsNeedOutLine() then
      renderEntityService:CreateMonsterAreaOutlineEntity(e)
    end
  end
end

function PieceServiceRender:GetSelectMonsterShadowPosList(selectEntityIDs)
  local shadowPosList = {}
  local monsterShadowPosList = self:GetMonsterShadowPosList(selectEntityIDs)
  table.appendArray(shadowPosList, monsterShadowPosList)
  local trapShadowPosList = self:GetTrapShadowPosList(selectEntityIDs)
  table.appendArray(shadowPosList, trapShadowPosList)
  return shadowPosList
end

function PieceServiceRender:_IsCanSelectShadow(selectEntityIDs, entityID)
  local canSelectShadow = true
  if selectEntityIDs and table.count(selectEntityIDs) > 0 and not table.icontains(selectEntityIDs, entityID) then
    canSelectShadow = false
  end
  return canSelectShadow
end

function PieceServiceRender:GetMonsterShadowPosList(selectEntityIDs)
  local shadowPosList = {}
  local utilDataSvc = self._world:GetService("UtilData")
  local round = utilDataSvc:GetStatCurWaveTotalRoundCount()
  local waveIndex = utilDataSvc:GetStatCurWaveIndex()
  local monsterGroup = self._world:GetGroup(self._world.BW_WEMatchers.MonsterID)
  for _, e in ipairs(monsterGroup:GetEntities()) do
    local canSelectShadow = self:_IsCanSelectShadow(selectEntityIDs, e:GetID())
    if not e:HasOutsideRegion() and not e:HasGhost() and not e:HasGuideGhost() and canSelectShadow then
      local monsterGridPos = e:GetGridPosition()
      if e:HasBodyArea() then
        local monsterIDCmpt = e:MonsterID()
        if not utilDataSvc:IsAIAttachState(e, round, waveIndex) and monsterIDCmpt:IsNeedGridDown() then
          local bodyAreaCmpt = e:BodyArea()
          local areaArray = bodyAreaCmpt:GetArea()
          for i = 1, #areaArray do
            local curAreaPos = areaArray[i]
            shadowPosList[#shadowPosList + 1] = monsterGridPos + curAreaPos
          end
        end
      else
        shadowPosList[#shadowPosList + 1] = monsterGridPos
      end
    end
  end
  return shadowPosList
end

function PieceServiceRender:GetTrapShadowPosList(selectEntityIDs)
  local shadowPosList = {}
  local trapGroup = self._world:GetGroup(self._world.BW_WEMatchers.Trap)
  for _, e in ipairs(trapGroup:GetEntities()) do
    local canSelectShadow = self:_IsCanSelectShadow(selectEntityIDs, e:GetID())
    local trapGridPos = e:GetGridPosition()
    if e:HasBodyArea() and canSelectShadow then
      local trapRender = e:TrapRender()
      if trapRender:IsNeedGridDown() then
        local bodyAreaCmpt = e:BodyArea()
        local areaArray = bodyAreaCmpt:GetArea()
        for i = 1, #areaArray do
          local curAreaPos = areaArray[i]
          shadowPosList[#shadowPosList + 1] = trapGridPos + curAreaPos
        end
      end
    else
      shadowPosList[#shadowPosList + 1] = trapGridPos
    end
  end
  return shadowPosList
end

function PieceServiceRender:GetChessPetShadowPosList()
  local shadowPosList = {}
  local chessPetGroup = self._world:GetGroup(self._world.BW_WEMatchers.ChessPetRender)
  for _, e in ipairs(chessPetGroup:GetEntities()) do
    local chessPetGridPos = e:GetGridPosition()
    if e:HasBodyArea() then
      local bodyAreaCmpt = e:BodyArea()
      local areaArray = bodyAreaCmpt:GetArea()
      for i = 1, #areaArray do
        local curAreaPos = areaArray[i]
        shadowPosList[#shadowPosList + 1] = chessPetGridPos + curAreaPos
      end
    else
      shadowPosList[#shadowPosList + 1] = chessPetGridPos
    end
  end
  return shadowPosList
end

function PieceServiceRender:RefreshPieceAnim()
  local utilDataSvc = self._world:GetService("UtilData")
  local shadowPosList = {}
  local monsterShadowPosList = self:GetMonsterShadowPosList()
  table.appendArray(shadowPosList, monsterShadowPosList)
  local trapShadowPosList = self:GetTrapShadowPosList()
  table.appendArray(shadowPosList, trapShadowPosList)
  local chessPetShadowPosList = self:GetChessPetShadowPosList()
  table.appendArray(shadowPosList, chessPetShadowPosList)
  self:HandleTeamPlayerPiece(shadowPosList)
end

function PieceServiceRender:HandleTeamPlayerPiece(shadowPosList)
  local trapServiceRender = self._world:GetService("TrapRender")
  local pieceMultiServiceRender = self._world:GetService("PieceMulti")
  local pieceGroup = self._world:GetGroup(self._world.BW_WEMatchers.Piece)
  for _, e in ipairs(pieceGroup:GetEntities()) do
    local pos = e:GetGridPosition()
    if e:HasOutsideRegion() then
      local outsideRegion = e:OutsideRegion()
      local boardIndex = outsideRegion:GetBoardIndex()
      pieceMultiServiceRender:SetPieceAnimDown(boardIndex, pos)
    end
    if table.icontains(shadowPosList, pos) then
      self:SetPieceAnimDown(pos)
      trapServiceRender:ShowHideTrapAtPos(pos, false)
    else
      self:SetPieceAnimNormal(pos)
      trapServiceRender:ShowHideTrapAtPos(pos, true)
    end
  end
end

function PieceServiceRender:ResetPieceEffectRender(pos)
  local utilDataSvc = self._world:GetService("UtilData")
  local pieceEffectType = utilDataSvc:GetBoardPieceEffectType(pos)
  if pieceEffectType == nil then
    pieceEffectType = PieceEffectType.Normal
  end
  self:SetPieceRenderEffect(pos, pieceEffectType)
end

function PieceServiceRender:SetPieceRenderEffect(pos, effectType, notPlayAnim)
  local curPieceEffectType = self:GetPieceEffectType(pos)
  if curPieceEffectType == effectType then
    return
  end
  local pieceEntity = self:FindPieceEntity(pos)
  local pieceComponent = pieceEntity:Piece()
  pieceComponent:SetRenderPieceEffectType(effectType)
  if notPlayAnim then
    return
  end
  self:ResetPieceAnimation(pos)
end

function PieceServiceRender:GetPieceEffectType(pos)
  local pieceEntity = self:FindPieceEntity(pos)
  if not pieceEntity then
    return PieceEffectType.Normal
  end
  local pieceComponent = pieceEntity:Piece()
  local curPieceEffectType = pieceComponent:GetRenderPieceEffectType()
  return curPieceEffectType
end

function PieceServiceRender:RemovePrismAt(pos)
  local boardServiceR = self._world:GetService("BoardRender")
  local pieceEntity = self:FindPieceEntity(pos)
  if not pieceEntity then
    return
  end
  self:SetPieceRenderEffect(pos, PieceEffectType.Normal)
end

function PieceServiceRender:FindPieceEntity(pos)
  local renderBoardEntity = self._world:GetRenderBoardEntity()
  local renderBoardCmpt = renderBoardEntity:RenderBoard()
  return renderBoardCmpt:GetGridRenderEntity(pos)
end

function PieceServiceRender:DestroyPieceEntity(pieceEntity)
  local pieceComponent = pieceEntity:Piece()
  pieceComponent = pieceComponent or pieceEntity:PieceFake()
  if not pieceComponent then
    return
  end
  self._world:DestroyEntity(pieceEntity)
end

function PieceServiceRender:RevertPieceShowRangeByGameObj(gameObj)
  UnityEngine.Shader.DisableKeyword("_CELL_SELF_CLIP")
  local meshRenderer = gameObj:GetComponentInChildren(typeof(UnityEngine.MeshRenderer))
  meshRenderer:SetPropertyBlock(nil)
end

function PieceServiceRender:RevertPieceShowRange(entity)
  local gridGameObj = entity:View().ViewWrapper.GameObject
  self:RevertPieceShowRangeByGameObj(gridGameObj)
end

function PieceServiceRender:SetPieceShowRange(entity, pos)
  UnityEngine.Shader.EnableKeyword("_CELL_SELF_CLIP")
  local gridGameObj = entity:View().ViewWrapper.GameObject
  local meshRenderer = gridGameObj:GetComponentInChildren(typeof(UnityEngine.MeshRenderer))
  local _mpb = UnityEngine.MaterialPropertyBlock:New()
  local boardServiceRender = self._world:GetService("BoardRender")
  local renderPos = boardServiceRender:GridPosition2LocationPos(pos, entity)
  local posV4 = Vector4(renderPos.x - 0.5, renderPos.x + 0.5, renderPos.z - 0.5, renderPos.z + 0.5)
  _mpb:SetVector("_H3DGZ_SelfClipParams", Vector4(renderPos.x - 0.5, renderPos.x + 0.5, renderPos.z - 0.5, renderPos.z + 0.5))
  meshRenderer:SetPropertyBlock(_mpb)
end

function PieceServiceRender:SetPieceFakeEntityPieceType(pieceFakeEntity, pieceType)
  pieceFakeEntity:ReplacePieceFake(pieceType)
  local pieceFakeComponent = pieceFakeEntity:PieceFake()
  local hasInitAsset = pieceFakeComponent:HasInitAsset()
  if hasInitAsset == false then
    local pieceBase = self:GetPieceConfigBase()
    pieceFakeEntity:ReplaceAsset(NativeUnityPrefabAsset:New(pieceBase))
    pieceFakeComponent:SetInitAsset()
    local pieceBasePrefabObj = pieceFakeEntity:View():GetGameObject()
    pieceBasePrefabObj.name = "gezi_base_fake"
  end
  local pieceEffectType = pieceFakeComponent:GetRenderPieceEffectType()
  local piecePrefabKey = self:GetGridPrefabPathFinal(pieceType, pieceEffectType)
  self:_OnShowPiecePrefab(pieceFakeEntity, piecePrefabKey)
end

function PieceServiceRender:FindPieceFakeEntity(pos)
  local renderBoardEntity = self._world:GetRenderBoardEntity()
  local renderBoardSpliceComponent = renderBoardEntity:RenderBoardSplice()
  local gridEntity = renderBoardSpliceComponent:GetGridRenderEntity(pos)
  return gridEntity
end

function PieceServiceRender:OnSetTrapViewWithPieceExtraLayer(trapEntity, pos)
  if not trapEntity:HasView() then
    return
  end
  local pieceEntity = self:FindPieceEntity(pos)
  if not pieceEntity then
    return
  end
  local pieceComponent = pieceEntity:Piece()
  local extraLayerTransform = pieceComponent:OnGetLayerTransform("ExtraLayer")
  local trapObj = trapEntity:View().ViewWrapper.GameObject
  trapObj.transform.parent = extraLayerTransform
  if trapObj.transform.localPosition ~= Vector3.zero then
    trapObj.transform.localPosition = Vector3.zero
  end
  if not APPVER_LAYERORDER then
    return
  end
  local tLayerOrderComponent = trapObj.gameObject:GetComponentInChildren(typeof(TLayerOrderComponent))
  if tLayerOrderComponent then
    UnityEngine.GameObject.Destroy(tLayerOrderComponent)
  end
end

function PieceServiceRender:SetEffectEntityParentWithPiecePos(effectEntity, pos)
  effectEntity:SetLocationHeight(0.01)
end
