local Avg_1_BgCtrl = class("Avg_1_BgCtrl", BaseCtrl)
Avg_1_BgCtrl._mapNodeConfig = {
  camera = {sNodeName = "camera", sComponentName = "Camera"},
  t_BG = {},
  trDelRoot = {sNodeName = "--del_bg--", sComponentName = "Transform"},
  trBgInsRoot = {sNodeName = "--bg--", sComponentName = "Transform"},
  trFgInsRoot = {sNodeName = "--fg--", sComponentName = "Transform"},
  trBgFxRoot = {sNodeName = "--bg_fx--", sComponentName = "Transform"},
  trCharRoot = {sNodeName = "--char--", sComponentName = "Transform"},
  tbTrCharHeadFrame = {
    sNodeName = "rtFrame_",
    nCount = 5,
    sComponentName = "Transform"
  },
  tbTrCharHeadRoot = {
    sNodeName = "rtCharOffset_",
    nCount = 5,
    sComponentName = "Transform"
  },
  trL2D = {sNodeName = "--L2D--", sComponentName = "Transform"},
  trFgFxRoot = {sNodeName = "--fg_fx--", sComponentName = "Transform"},
  trTopFxRoot = {sNodeName = "--top_fx--", sComponentName = "Transform"},
  trFilterFxRoot = {
    sNodeName = "--filter_fx--",
    sComponentName = "Transform"
  },
  trSubStageRT = {
    sNodeName = "canvas_sub_stage_rt",
    sComponentName = "Transform"
  }
}
Avg_1_BgCtrl._mapEventConfig = {
  [EventId.AvgEnableStageCamera] = "OnEvent_AvgEnableStageCamera",
  [EventId.AvgSpeedUp] = "OnEvent_AvgSpeedUp"
}

function Avg_1_BgCtrl:Awake()
  self.mapPresetShake = nil
  self.mapPresetTransition = nil
  self.nPersonalityIdx = nil
  self.goCurBgIns = nil
  self.rtBg = nil
  self.imgBg = nil
  self.eftBg = nil
  self.goCurFgIns = nil
  self.rtFg = nil
  self.imgFg = nil
  self.eftFg = nil
  self.renderTexture = nil
  self.rawImgStage = nil
  self.mapBgFx = {}
  self.mapFgFx = {}
  self.mapTopFx = {}
  self.mapFilterFx = {}
  local a = 0.01 / Settings.CANVAS_SCALE
  local b = Settings.CURRENT_CANVAS_FULL_RECT_WIDTH / Settings.DESIGN_SCREEN_RESOLUTION_WIDTH
  if math.abs(a - 1) < 1.0E-4 then
    self.nRatioScale = b
  else
    self.nRatioScale = a
  end
  self.nLayerIndex = CS.UnityEngine.LayerMask.NameToLayer("Cam_Layer_4")
  self.nOwnerStageIndex = nil
  self.tbCharHeadAnim = {}
  for i, v in ipairs(self._mapNode.tbTrCharHeadRoot) do
    local animator = v.parent.parent.gameObject:GetComponent("Animator")
    table.insert(self.tbCharHeadAnim, animator)
  end
end

function Avg_1_BgCtrl:OnDisable()
  self.mapPresetShake = nil
  self.mapPresetTransition = nil
  self.nPersonalityIdx = nil
  if self.goCurBgIns ~= nil then
    self.rtBg = nil
    NovaAPI.SetImageSpriteAsset(self.imgBg, nil)
    self.imgBg = nil
    self.eftBg.transitionTexture = nil
    self.eftBg = nil
    self.goCurBgIns = nil
  end
  if self.goCurFgIns ~= nil then
    self.rtFg = nil
    NovaAPI.SetImageSpriteAsset(self.imgFg, nil)
    self.imgFg = nil
    self.eftFg.transitionTexture = nil
    self.eftFg = nil
    self.goCurFgIns = nil
  end
  self:UnInitOffScreenRender()
  self.mapBgFx = nil
  self.mapFgFx = nil
end

function Avg_1_BgCtrl:InitOffScreenRender(rawImage, nStageIndex, v2PreferredSize)
  if v2PreferredSize ~= nil then
    self.nW = math.floor(v2PreferredSize.x)
    self.nH = math.floor(v2PreferredSize.y)
  end
  self.rawImgStage = rawImage
  GameUIUtils.SetCameraPostProcessing(self._mapNode.camera, nStageIndex == 1)
  if nStageIndex == 1 then
    local nW = math.floor(2500 * Settings.RENDERTEXTURE_SIZE_FACTOR)
    local nH = math.floor(1800 * Settings.RENDERTEXTURE_SIZE_FACTOR)
    self.renderTexture = GameUIUtils.GenerateRenderTextureFor2D(nW, nH, false, true, true)
    self.renderTexture.name = "Avg1Bg(1)"
    self._mapNode.camera.orthographicSize = 9.0
    self._mapNode.camera.targetTexture = self.renderTexture
    NovaAPI.SetTexture(self.rawImgStage, self.renderTexture)
    if self._panel.AVG_NO_BG_MODE ~= true then
      self:CreateNewBg("BG_Black")
    end
  end
  self:Active(nStageIndex == 1 and self:GetPanelId() ~= PanelId.AvgEditor)
  self.nOwnerStageIndex = nStageIndex
  self.rawImgStage.gameObject:GetComponent("RectTransform").sizeDelta = Vector2(2500, 1800)
end

function Avg_1_BgCtrl:EnablePostProcessing(bEnablePP)
  if self.nOwnerStageIndex == 1 then
    return bEnablePP
  else
    return false
  end
end

function Avg_1_BgCtrl:UnInitOffScreenRender()
  self:Active(false)
  if self.rawImgStage ~= nil then
    NovaAPI.SetTexture(self.rawImgStage, nil)
    self.rawImgStage = nil
  end
  self._mapNode.camera.targetTexture = nil
  if self.renderTexture ~= nil then
    GameUIUtils.ReleaseRenderTexture(self.renderTexture)
    self.renderTexture = nil
  end
end

function Avg_1_BgCtrl:LoadPresetShake()
  if self.mapPresetShake == nil then
    self.mapPresetShake = {}
    for _, data in ipairs(self._panel.tbAvgPreset.BgShakeType) do
      local sKey = data[1]
      self.mapPresetShake[sKey] = data[2]
    end
  end
end

function Avg_1_BgCtrl:_LoadPreset_Transition()
  if self.mapPresetTransition == nil then
    self.mapPresetTransition = {}
    for i, v in ipairs(self._panel.tbAvgPreset.Transition) do
      local sKeyName = v[1]
      local tbData = v[2]
      self.mapPresetTransition[sKeyName] = tbData
    end
  end
end

function Avg_1_BgCtrl:CheckOffScreenInited()
  if self.renderTexture == nil then
    local nW = math.floor(self.nW * Settings.RENDERTEXTURE_SIZE_FACTOR)
    local nH = math.floor(self.nH * Settings.RENDERTEXTURE_SIZE_FACTOR)
    self.renderTexture = GameUIUtils.GenerateRenderTextureFor2D(nW, nH, false, true, false)
    self.renderTexture.name = string.format("Avg1Bg(%s)", tostring(self.nOwnerStageIndex))
    self._mapNode.camera.orthographicSize = self.nH / 200
    self._mapNode.camera.targetTexture = self.renderTexture
    NovaAPI.SetTexture(self.rawImgStage, self.renderTexture)
    self.rawImgStage.gameObject:GetComponent("RectTransform").sizeDelta = Vector2(self.nW, self.nH)
    if self._panel.AVG_NO_BG_MODE ~= true then
      self:CreateNewBg("BG_Black")
    end
  end
end

function Avg_1_BgCtrl:CreateNewBg(sName, bIsFG)
  local goIns, rt, img, eft, trParent = nil, nil, nil, nil, self._mapNode.trBgInsRoot
  if bIsFG == true then
    trParent = self._mapNode.trFgInsRoot
  end
  goIns = instantiate(self._mapNode.t_BG, trParent)
  goIns.transform:SetAsFirstSibling()
  local trImgBg = goIns.transform:GetChild(0)
  rt = trImgBg:GetComponent("RectTransform")
  img = trImgBg:GetComponent("Image")
  local sFullPath = self._panel:GetBgCgFgResFullPath(sName)
  self:SetPngSprite(img, sFullPath)
  NovaAPI.SetImageNativeSize(img)
  eft = trImgBg:GetComponent("UIEffectAndTransition")
  goIns:SetActive(true)
  if bIsFG == true then
    self.goCurFgIns = goIns
    self.rtFg = rt
    self.imgFg = img
    self.eftFg = eft
  else
    self.goCurBgIns = goIns
    self.rtBg = rt
    self.imgBg = img
    self.eftBg = eft
  end
end

function Avg_1_BgCtrl:Active(bVisible)
  self.gameObject:SetActive(bVisible == true)
end

function Avg_1_BgCtrl:_OptimizeUIEft(eft, bBlurMode)
  if eft ~= nil and eft:IsNull() == false then
    if eft.effectFactor > 0 or 0 < eft.blurFactor or 0 < eft.effectFactorTr then
      eft.enabled = true
    else
      eft.enabled = false
    end
    if bBlurMode ~= nil then
      eft.blurMode = bBlurMode
    end
  end
end

function Avg_1_BgCtrl:_SetUIEffectAndTransition(sKeyName)
  if sKeyName == nil then
    sKeyName = "default"
  end
  local tbEftData = self.mapPresetTransition[sKeyName]
  if tbEftData == nil then
    tbEftData = self.mapPresetTransition.default
  end
  NovaAPI.SetUIEffectAndTransition(self.eftBg, tbEftData[1], tbEftData[2], tbEftData[3])
  local sName = tbEftData[4]
  return sName
end

function Avg_1_BgCtrl:GetCharHeadFrameRoot(nType)
  local trCharHeadFrameRoot = self._mapNode.tbTrCharHeadFrame[nType]
  local trCharHeadRoot = self._mapNode.tbTrCharHeadRoot[nType]
  return trCharHeadFrameRoot, trCharHeadRoot
end

function Avg_1_BgCtrl:PlayCharHeadFrameAnim(nType, nInOut)
  local animator = self.tbCharHeadAnim[nType]
  animator.enabled = true
  local sName
  if nType <= 3 then
    sName = "char_head_framert_FramePos_"
  elseif nType == 4 then
    sName = "char_head_framert_FramePosL_"
  elseif nType == 5 then
    sName = "char_head_framert_FramePosR_"
  end
  if nInOut == 0 then
    sName = sName .. "in"
  elseif nInOut == 1 then
    sName = sName .. "out"
  end
  animator:Play(sName, 0, 0)
  return NovaAPI.GetAnimClipLength(animator, {sName})
end

function Avg_1_BgCtrl:DisableCharHeadFrameAnim(nType)
  local animator = self.tbCharHeadAnim[nType]
  animator.enabled = false
end

function Avg_1_BgCtrl:ClearAll()
  if self.renderTexture == nil then
    return
  end
  
  local function _clear(trParent)
    if trParent.childCount > 1 then
      for i = trParent.childCount - 1, 1, -1 do
        trParent:GetChild(i):SetParent(self._mapNode.trDelRoot)
      end
    end
  end
  
  _clear(self._mapNode.trBgInsRoot)
  _clear(self._mapNode.trFgInsRoot)
  if self.goCurFgIns ~= nil then
    self.goCurFgIns.transform:SetParent(self._mapNode.trDelRoot)
  end
  self.goCurFgIns = nil
  self.rtFg = nil
  self.imgFg = nil
  self.eftFg = nil
  if self.goCurBgIns ~= nil then
    self.goCurBgIns.transform:SetParent(self._mapNode.trDelRoot)
  end
  self.goCurBgIns = nil
  self.rtBg = nil
  self.imgBg = nil
  self.eftBg = nil
  self:SetBg({
    "BG_Black",
    "0",
    "Linear",
    0.0,
    false,
    "default",
    0
  })
  
  local function func_stopFx(trParent)
    local nCount = trParent.childCount
    if 0 < nCount then
      nCount = nCount - 1
      for i = nCount, 0, -1 do
        local goChild = trParent:GetChild(i).gameObject
        if goChild:IsNull() == false then
          NovaAPI.StopFX(goChild)
        end
      end
    end
  end
  
  func_stopFx(self._mapNode.trBgFxRoot)
  func_stopFx(self._mapNode.trFgFxRoot)
  func_stopFx(self._mapNode.trTopFxRoot)
  func_stopFx(self._mapNode.trFilterFxRoot)
  self.mapBgFx = {}
  self.mapFgFx = {}
  self.mapTopFx = {}
  self.mapFilterFx = {}
  if self.nOwnerStageIndex ~= 1 then
    GameUIUtils.SetCameraPostProcessing(self._mapNode.camera, false)
  end
end

function Avg_1_BgCtrl:OnEvent_AvgEnableStageCamera(bEnable)
  self._mapNode.camera.enabled = bEnable == true
end

function Avg_1_BgCtrl:OnEvent_AvgSpeedUp(nRate)
  if self:GetPanelId() ~= PanelId.AvgST then
    return
  end
  self:OnEvent_AvgSpeedUp_Timer(nRate)
  for index, value in ipairs(self.tbCharHeadAnim) do
    NovaAPI.SetAnimatorSpeed(value, nRate)
  end
end

function Avg_1_BgCtrl:Avg_ProcRes_Personality(sResName)
  local sName = sResName
  if AVG_EDITOR == true then
    return sName
  end
  local mapFallback = {
    [1] = {
      "AAA",
      "AA",
      "A"
    },
    [2] = {
      "BBB",
      "BB",
      "B"
    },
    [0] = {
      "CCC",
      "CC",
      "C"
    }
  }
  local mapResNameSurfix = {
    "AAA",
    "BBB",
    "CCC",
    "AA",
    "BB",
    "CC",
    "A",
    "B",
    "C",
    "N"
  }
  if self.nPersonalityIdx == nil then
    local _, _, _, _, _, _, n = PlayerData.Avg:CalcPersonality(1)
    self.nPersonalityIdx = n
  end
  if type(self.nPersonalityIdx) == "number" then
    local sResult = mapResNameSurfix[self.nPersonalityIdx]
    if type(sResult) == "string" and sResult ~= "" and sResult ~= "N" then
      local nFallbackIdx = self.nPersonalityIdx % 3
      local tbFallback = mapFallback[nFallbackIdx]
      local nStartIdx = table.indexof(tbFallback, sResult)
      local nCount = #tbFallback
      if 0 < nStartIdx then
        for i = nStartIdx, nCount do
          local s = sName .. "_" .. tbFallback[i]
          if 0 < table.indexof(self._panel.tbAvgPreset.CgResName, s) then
            sName = s
            break
          end
        end
      end
    end
  end
  return sName
end

function Avg_1_BgCtrl:SetBg(tbParam)
  self:CheckOffScreenInited()
  self:_LoadPreset_Transition()
  local sResName = tbParam[1]
  local sEftName = tbParam[2]
  local sEaseType = tbParam[3]
  local nDuration = tbParam[4]
  local bWait = tbParam[5]
  local sKeyName = tbParam[6]
  local bIsFG = tbParam[7] == 1
  local img, eft, goCurIns = self.imgBg, self.eftBg, self.goCurBgIns
  if bIsFG == true then
    img, eft, goCurIns = self.imgFg, self.eftFg, self.goCurFgIns
  end
  if goCurIns ~= nil then
    if 0 < nDuration then
      local tweener
      if sEftName == "0" then
        tweener = NovaAPI.ImageDoColor(img, Color(1, 1, 1, 0), nDuration)
      else
        if eft.enabled == false then
          eft.enabled = true
        end
        local sEftPngName = self:_SetUIEffectAndTransition(sKeyName)
        if sEftPngName ~= nil and sEftPngName ~= "" then
          sEftName = sEftPngName
        end
        eft.transitionTexture = self:GetAvgStageEffect(sEftName)
        tweener = eft:DOEffectAndTransitionFade(1, nDuration)
      end
      tweener:SetUpdate(true)
      tweener:SetEase(Ease[sEaseType])
      local goBg = goCurIns
      
      local function cb()
        if goBg ~= nil and goBg:IsNull() == false then
          goBg.transform:SetParent(self._mapNode.trDelRoot)
          goBg = nil
        end
      end
      
      tweener.onComplete = dotween_callback_handler(self, cb)
    else
      if sEftName == "0" then
        NovaAPI.SetImageColor(img, Color(1, 1, 1, 0))
      else
        if eft.enabled == false then
          eft.enabled = true
        end
        eft.effectFactorTr = 1
      end
      goCurIns.transform:SetParent(self._mapNode.trDelRoot)
    end
  end
  delChildren(self._mapNode.trDelRoot)
  sResName = Avg_ProcRes_M_F(sResName)
  sResName = self:Avg_ProcRes_Personality(sResName)
  self:CreateNewBg(sResName, bIsFG)
  if bWait == true and 0 < nDuration then
    return nDuration
  else
    return 0
  end
end

function Avg_1_BgCtrl:CtrlBg(tbParam)
  self:CheckOffScreenInited()
  self:LoadPresetShake()
  local nPivotX = tbParam[1]
  local nPivotY = tbParam[2]
  local nPosX = tbParam[3]
  local nPosY = tbParam[4]
  local nScale = tbParam[5]
  local nGray = tbParam[6]
  local nAlpha = tbParam[7]
  local nBrightness = tbParam[8]
  local nBlur = tbParam[9]
  local sShakeType = tbParam[10]
  local sEaseType = tbParam[11]
  local nDuration = tbParam[12]
  local bWait = tbParam[13]
  local bIsFG = tbParam[14] == 1
  local nRotate = tbParam[15]
  local enumEase = Ease[sEaseType]
  local rt, goIns, eft, img = self.rtBg, self.goCurBgIns, self.eftBg, self.imgBg
  if bIsFG == true then
    rt, goIns, eft, img = self.rtFg, self.goCurFgIns, self.eftFg, self.imgFg
  end
  if nPivotX ~= nil or nPivotY ~= nil then
    local v2CurPivot = rt.pivot
    local v2CurPos = rt.anchoredPosition
    nPivotX = nPivotX or v2CurPivot.x
    nPivotY = nPivotY or v2CurPivot.y
    rt.pivot = Vector2(nPivotX, nPivotY)
    rt.anchoredPosition = Vector2(v2CurPos.x + (nPivotX - v2CurPivot.x) * rt.rect.width, v2CurPos.y + (nPivotY - v2CurPivot.y) * rt.rect.height)
  end
  if nPosX ~= nil or nPosY ~= nil then
    local v2CurPos = rt.anchoredPosition
    local v2TargetPos = Vector2(nPosX or v2CurPos.x, nPosY or v2CurPos.y)
    if 0 < nDuration then
      local tweener = rt:DOAnchorPos(v2TargetPos, nDuration)
      tweener:SetUpdate(true)
      tweener:SetEase(enumEase)
    else
      rt.anchoredPosition = v2TargetPos
    end
  end
  if nScale ~= nil then
    local v3TargetScale = Vector3(nScale, nScale, 1)
    if 0 < nDuration then
      local tweener = rt:DOScale(v3TargetScale, nDuration)
      tweener:SetUpdate(true)
      tweener:SetEase(enumEase)
    else
      rt.localScale = v3TargetScale
    end
  end
  if sShakeType ~= nil and sShakeType ~= "none" then
    local tb = self.mapPresetShake[sShakeType]
    local _sT = type(tb)
    if _sT == "table" then
      NovaAPI.DoShakeEffect(goIns, tb[1], tb[2], tb[3])
    elseif _sT == "number" and (tb == 0 or tb == 1) then
      NovaAPI.StopShakeEffect(goIns)
    end
  end
  if nGray ~= nil then
    if eft.enabled == false then
      eft.enabled = true
    end
    if 0 < nDuration then
      local tweener = eft:DOEffectAndTransitionGray(nGray, nDuration)
      tweener:SetUpdate(true)
      tweener:SetEase(enumEase)
      if nGray < 0.001 then
        local function _cb()
          self:_OptimizeUIEft(eft, nil)
        end
        
        tweener.onComplete = dotween_callback_handler(self, _cb)
      end
    else
      eft.effectFactor = nGray
      if nGray < 0.001 then
        self:_OptimizeUIEft(eft, nil)
      end
    end
  end
  if nAlpha ~= nil or nBrightness ~= nil then
    nAlpha = nAlpha or NovaAPI.GetImageColor(img).a
    nBrightness = nBrightness or NovaAPI.GetImageColor(img).r
    local color = Color(nBrightness, nBrightness, nBrightness, nAlpha)
    if 0 < nDuration then
      local tweener = NovaAPI.ImageDoColor(img, color, nDuration, true)
      tweener:SetEase(enumEase)
    else
      NovaAPI.SetImageColor(img, color)
    end
  end
  if nBlur ~= nil then
    if eft.blurMode == false then
      eft.blurMode = true
    end
    if eft.enabled == false then
      eft.enabled = true
    end
    if 0 < nDuration then
      local tweener = eft:DOEffectAndTransitionBlur(nBlur, nDuration)
      tweener:SetUpdate(true)
      tweener:SetEase(enumEase)
      if nBlur < 0.001 then
        local function _cb()
          self:_OptimizeUIEft(eft, false)
        end
        
        tweener.onComplete = dotween_callback_handler(self, _cb)
      end
    else
      eft.blurFactor = nBlur
      if nBlur < 0.001 then
        self:_OptimizeUIEft(eft, false)
      end
    end
  end
  if type(nRotate) == "number" then
    if 0 < nDuration then
      local tweener = img.transform:DOLocalRotate(Vector3(0, 0, nRotate), nDuration, RotateMode.FastBeyond360)
      tweener:SetUpdate(true)
      tweener:SetEase(enumEase)
    else
      img.transform.localRotation = Quaternion.Euler(0, 0, nRotate)
    end
  end
  if bWait == true and 0 < nDuration then
    return nDuration
  else
    return 0
  end
end

function Avg_1_BgCtrl:SetFx(tbParam)
  self:CheckOffScreenInited()
  local sFxName = tbParam[1]
  local bCreate = tbParam[2] == 0
  local nPosIndex = tbParam[3]
  local nPosX = tbParam[4]
  local nPosY = tbParam[5]
  local nScale = tbParam[6]
  local nDuration = tbParam[7]
  local bWait = tbParam[8]
  local bEnablePP = tbParam[9] == false
  local nRotate = tbParam[10]
  local map, trRoot
  if nPosIndex == 0 then
    map = self.mapBgFx
    trRoot = self._mapNode.trBgFxRoot
  elseif nPosIndex == 1 then
    map = self.mapFgFx
    trRoot = self._mapNode.trFgFxRoot
  elseif nPosIndex == 2 then
    map = self.mapTopFx
    trRoot = self._mapNode.trTopFxRoot
  end
  if bCreate == true then
    local assetPath = "UI/Avg/FX/" .. sFxName
    nPosX = nPosX or 0
    nPosY = nPosY or 0
    nScale = nScale or 1
    nRotate = nRotate or 0
    local bIsLoop, goFXIns = NovaAPI.PlayFX(self:EnablePostProcessing(bEnablePP), assetPath, self._panel.nSpeedRate or 1)
    local trFxPlayer = goFXIns.transform
    trFxPlayer:SetLayerRecursively(self.nLayerIndex)
    trFxPlayer:SetParent(trRoot)
    trFxPlayer.localPosition = Vector3(nPosX, nPosY, 0)
    trFxPlayer.localRotation = Quaternion.Euler(0, 0, nRotate)
    nScale = self.nRatioScale * nScale
    trFxPlayer.localScale = Vector3(nScale, nScale, nScale)
    self._panel:PlayFxSound(sFxName, true)
    if bIsLoop == true then
      local tbGroup = map[sFxName]
      if tbGroup == nil then
        map[sFxName] = {}
        tbGroup = map[sFxName]
      end
      table.insert(tbGroup, goFXIns)
    end
  else
    local tbGroup = map[sFxName]
    if tbGroup ~= nil then
      local nCount = #tbGroup
      for i = nCount, 1, -1 do
        local goFXIns = tbGroup[i]
        NovaAPI.StopFX(goFXIns)
        table.remove(tbGroup, i)
      end
    end
    self._panel:PlayFxSound(sFxName, false)
  end
  if bWait == true and 0 < nDuration then
    return nDuration
  else
    return 0
  end
end

function Avg_1_BgCtrl:SetPP(tbParam)
  local bEnable = tbParam[1] == 1
  GameUIUtils.SetCameraPostProcessing(self._mapNode.camera, bEnable)
  return 0
end

function Avg_1_BgCtrl:RestoreAll(bActive, tbDataBg, tbDataFg, mapBgFx, mapFgFx, mapTopFx, mapFilterFx, bRemoveUnloopFx)
  self:Active(bActive)
  local nChildCount = self._mapNode.trBgInsRoot.childCount - 1
  for i = 0, nChildCount do
    local trChild = self._mapNode.trBgInsRoot:GetChild(i)
    if self.goCurBgIns ~= trChild.gameObject then
      trChild:SetParent(self._mapNode.trDelRoot)
    end
  end
  nChildCount = self._mapNode.trFgInsRoot.childCount - 1
  for i = 0, nChildCount do
    local trChild = self._mapNode.trFgInsRoot:GetChild(i)
    trChild:SetParent(self._mapNode.trDelRoot)
  end
  self.goCurFgIns = nil
  if bActive == false then
    self.mapPresetShake = nil
    if self.nOwnerStageIndex ~= 1 then
      GameUIUtils.SetCameraPostProcessing(self._mapNode.camera, false)
    end
    return
  end
  self:CheckOffScreenInited()
  local sResName = "BG_Black"
  if tbDataBg.sResName ~= "" then
    sResName = tbDataBg.sResName
  end
  local sFullPath = self._panel:GetBgCgFgResFullPath(sResName)
  self:SetPngSprite(self.imgBg, sFullPath)
  self.rtBg.pivot = Vector2(tbDataBg.nPivotX, tbDataBg.nPivotY)
  self.rtBg.anchoredPosition = Vector2(tbDataBg.nPosX, tbDataBg.nPosY)
  self.rtBg.localScale = Vector3(tbDataBg.nScale, tbDataBg.nScale, 1)
  self.eftBg.effectFactor = tbDataBg.nGray
  self.eftBg.blurFactor = tbDataBg.nBlur
  self.eftBg.blurMode = 0 < tbDataBg.nBlur
  if 0 < tbDataBg.nGray or 0 < tbDataBg.nBlur then
    self.eftBg.enabled = true
  else
    self.eftBg.enabled = false
  end
  if self._panel.AVG_NO_BG_MODE == true then
    NovaAPI.SetImageColor(self.imgBg, Color(1, 1, 1, 0))
  else
    NovaAPI.SetImageColor(self.imgBg, Color(tbDataBg.nBrightness, tbDataBg.nBrightness, tbDataBg.nBrightness, tbDataBg.nAlpha))
  end
  local bEnablePP = tbDataBg.bEnablePP
  if self.nOwnerStageIndex == 1 then
    bEnablePP = true
  end
  GameUIUtils.SetCameraPostProcessing(self._mapNode.camera, bEnablePP)
  local nRotate = tbDataBg.nRotate
  self.rtBg.transform.localRotation = Quaternion.Euler(0, 0, nRotate)
  sResName = tbDataFg.sResName
  if sResName ~= "" then
    if self.goCurFgIns == nil then
      sResName = Avg_ProcRes_M_F(sResName)
      sResName = self:Avg_ProcRes_Personality(sResName)
      self:CreateNewBg(sResName, true)
    else
      local sFullPath = self._panel:GetBgCgFgResFullPath(sResName)
      self:SetPngSprite(self.imgFg, sFullPath)
    end
    self.rtFg.pivot = Vector2(tbDataFg.nPivotX, tbDataFg.nPivotY)
    self.rtFg.anchoredPosition = Vector2(tbDataFg.nPosX, tbDataFg.nPosY)
    self.rtFg.localScale = Vector3(tbDataFg.nScale, tbDataFg.nScale, 1)
    self.eftFg.effectFactor = tbDataFg.nGray
    self.eftFg.blurFactor = tbDataFg.nBlur
    self.eftFg.blurMode = 0 < tbDataFg.nBlur
    if 0 < tbDataFg.nGray or 0 < tbDataFg.nBlur then
      self.eftFg.enabled = true
    else
      self.eftFg.enabled = false
    end
    if self._panel.AVG_NO_BG_MODE == true then
      NovaAPI.SetImageColor(self.imgFg, Color(1, 1, 1, 0))
    else
      NovaAPI.SetImageColor(self.imgFg, Color(tbDataFg.nBrightness, tbDataFg.nBrightness, tbDataFg.nBrightness, tbDataFg.nAlpha))
    end
    nRotate = tbDataFg.nRotate
    self.rtFg.transform.localRotation = Quaternion.Euler(0, 0, nRotate)
  end
  self.mapBgFx = {}
  self.mapFgFx = {}
  self.mapTopFx = {}
  self.mapFilterFx = {}
  
  local function func_stopFx(trParent)
    local nCount = trParent.childCount
    if 0 < nCount then
      nCount = nCount - 1
      for i = nCount, 0, -1 do
        local goChild = trParent:GetChild(i).gameObject
        if goChild:IsNull() == false and goChild.activeSelf == true then
          NovaAPI.StopFX(goChild)
        end
      end
    end
  end
  
  func_stopFx(self._mapNode.trBgFxRoot)
  func_stopFx(self._mapNode.trFgFxRoot)
  func_stopFx(self._mapNode.trTopFxRoot)
  func_stopFx(self._mapNode.trFilterFxRoot)
  if self.tbTempFxSound ~= nil then
    for i, v in ipairs(self.tbTempFxSound) do
      self._panel:PlayFxSound(v, false)
    end
  end
  if bActive == true then
    local function func_SetFx(mapData, trRoot, map)
      for sFxName, tbData in pairs(mapData) do
        for i, v in ipairs(tbData) do
          local bIsLoopFx = string.find(sFxName, "_loop") ~= nil or string.find(sFxName, "_lp") ~= nil
          
          if bIsLoopFx == true or bRemoveUnloopFx == false and bIsLoopFx == false then
            local assetPath = "UI/Avg/FX/" .. sFxName
            local bIsLoop, goFXIns = NovaAPI.PlayFX(self:EnablePostProcessing(v.bFxEnablePP == false), assetPath, 1)
            local trFxPlayer = goFXIns.transform
            trFxPlayer:SetLayerRecursively(self.nLayerIndex)
            trFxPlayer:SetParent(trRoot)
            trFxPlayer.localPosition = Vector3(v.x, v.y, 0)
            trFxPlayer.localRotation = Quaternion.Euler(0, 0, v.r or 0)
            local ns = v.s * self.nRatioScale
            trFxPlayer.localScale = Vector3(ns, ns, ns)
            if bIsLoop == true then
              local tbGroup = map[sFxName]
              if tbGroup == nil then
                map[sFxName] = {}
                tbGroup = map[sFxName]
              end
              table.insert(tbGroup, goFXIns)
              self._panel:PlayFxSound(sFxName, true)
              if self.tbTempFxSound == nil then
                self.tbTempFxSound = {}
              end
              table.insert(self.tbTempFxSound, sFxName)
            end
          end
        end
      end
    end
    
    func_SetFx(mapBgFx, self._mapNode.trBgFxRoot, self.mapBgFx)
    func_SetFx(mapFgFx, self._mapNode.trFgFxRoot, self.mapFgFx)
    func_SetFx(mapTopFx, self._mapNode.trTopFxRoot, self.mapTopFx)
    func_SetFx(mapFilterFx, self._mapNode.trFilterFxRoot, self.mapFilterFx)
  end
end

return Avg_1_BgCtrl
