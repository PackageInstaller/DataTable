local Avg_2_CharCtrl = class("Avg_2_CharCtrl", BaseCtrl)
local GameResourceLoader = require("Game.Common.Resource.GameResourceLoader")
local ResType = GameResourceLoader.ResType
Avg_2_CharCtrl._mapNodeConfig = {
  t_char = {}
}
Avg_2_CharCtrl._mapEventConfig = {
  [EventId.AvgClearAllChar] = "OnEvent_ClearAllChar",
  [EventId.AvgChoiceMainRoleOS_In] = "OnEvent_SetMainRoltToChoiceUI",
  [EventId.AvgChoiceMainRoleOS_Out] = "OnEvent_ExitMainRoleInChoiceUI",
  [EventId.AvgMainRoleTalk_Set] = "OnEvent_SetMainRoleTalk",
  [EventId.AvgMainRoleTalk_Switch] = "OnEvent_SwitchMainRoleTalk",
  [EventId.AvgMainRoleTalk_SetEmoji] = "OnEvent_SetEmojiMainRoleTalk",
  [EventId.AvgMainRoleTalk_Shake] = "OnEvent_ShakeMainRoleTalk",
  [EventId.AvgMainRoleTalk_Reset] = "OnEvent_ResetMainRoleTalk",
  [EventId.AvgSpeedUp] = "OnEvent_AvgSpeedUp"
}

function Avg_2_CharCtrl:Awake()
  self.sNone = ""
  self.nChangeBodyTime = 0.5
  self.nChangeFaceTime = 0.3
  self.mapPresetColor = {
    invisible = Color(1, 1, 1, 0),
    ["50_visible"] = Color(1, 1, 1, 0.5),
    ["75_visible"] = Color(1, 1, 1, 0.75),
    normal = Color.white,
    black = Color.black,
    dark = Color.gray,
    black_invisible = Color(0, 0, 0, 0)
  }
  self.tbHoldEmoji = nil
  self.mapPresetShake = nil
  self.mapPresetEnter = nil
  self.mapPresetExit = nil
  self.tbCharIns = {}
  self:PreInstantiate(6)
  self.KEY = {}
  self.KEY.MOVE = 1
  self.KEY.ROTATE = 2
  self.KEY.SCALE = 3
  self.KEY.GRAY = 4
  self.KEY.BLUR = 5
  self.KEY.BRIGHT = 6
  self.KEY.COLOR = 7
  self.KEY.EFT = 8
  self.nLayerIndex = CS.UnityEngine.LayerMask.NameToLayer("Cam_Layer_4")
end

function Avg_2_CharCtrl:OnEnable()
  self.gameObject:SetActive(false)
end

function Avg_2_CharCtrl:OnDisable()
  for _, data in ipairs(self.tbCharIns) do
    self:ClearCharData(nil, data, true)
  end
  if self.goCharInsRoot ~= nil then
    destroy(self.goCharInsRoot)
    self.goCharInsRoot = nil
  end
  self.tbCharIns = nil
  self.tbHoldEmoji = nil
  self.mapPresetShake = nil
  self.mapPresetEnter = nil
  self.mapPresetExit = nil
end

function Avg_2_CharCtrl:PreInstantiate(nCount)
  self.goCharInsRoot = GameObject("--AvgCharOffScreenRender--")
  self.goCharInsRoot.transform:SetParent(PanelManager.GetUIRoot(self._panel._sSortingLayerName))
  local trParent = self.goCharInsRoot.transform
  for i = 1, nCount do
    local data = {}
    data._idx = i
    local goRoot = instantiate(self._mapNode.t_char, trParent)
    data.trRoot = goRoot.transform
    data.trRoot.localPosition = Vector3(3000 * #self.tbCharIns, 20000, 0)
    data.trRoot.localScale = Vector3.one
    data.rtChar = data.trRoot:GetChild(0):GetComponent("RectTransform")
    local trShake = data.rtChar:GetChild(0)
    data.eftShake = trShake.gameObject
    data.animator = trShake.transform:GetComponent("Animator")
    data.animator.enabled = false
    data.rtRawImage = trShake:GetChild(0):GetComponent("RectTransform")
    data.rawImage = data.rtRawImage:GetComponent("RawImage")
    data.eftGrayAndTrans = data.rtRawImage:GetComponent("UIEffectAndTransition")
    data.rtEmoji = trShake:GetChild(1):GetComponent("RectTransform")
    local trRenderer = data.trRoot:GetChild(1)
    data.camera = trRenderer:Find("Camera"):GetComponent("Camera")
    data.sprBodyA = trRenderer:Find("body_a"):GetComponent("SpriteRenderer")
    data.sprBodyB = trRenderer:Find("body_b"):GetComponent("SpriteRenderer")
    data.sprFaceA = trRenderer:Find("face_a"):GetComponent("SpriteRenderer")
    data.sprFaceB = trRenderer:Find("face_b"):GetComponent("SpriteRenderer")
    data.sprBlack = trRenderer:Find("body_black"):GetComponent("SpriteRenderer")
    data.bInUse = false
    data.sAvgCharId = self.sNone
    data.sBody = self.sNone
    data.sFace = self.sNone
    data.sEmoji = self.sNone
    data.trFrame = nil
    data.trHead = nil
    table.insert(self.tbCharIns, data)
  end
end

function Avg_2_CharCtrl:CheckOffScreenInited(data)
  if data.renderTexture == nil then
    local n = math.floor(2048 * Settings.RENDERTEXTURE_SIZE_FACTOR)
    data.renderTexture = GameUIUtils.GenerateRenderTextureFor2D(n, n)
    data.renderTexture.name = string.format("Avg2Char(%s)", tostring(data._idx))
    data.camera.targetTexture = data.renderTexture
    NovaAPI.SetTexture(data.rawImage, data.renderTexture)
  end
end

function Avg_2_CharCtrl:ClearCharData(timer, data, bForceClear)
  self:_KillAllCharTweener(data)
  data.sAvgCharId = self.sNone
  data.sBody = self.sNone
  data.sFace = self.sNone
  data.sEmoji = self.sNone
  NovaAPI.StopShakeEffect(data.eftShake)
  if data.animator.enabled == true then
    data.animator:SetTrigger("none")
    data.animator.enabled = false
  end
  data.rtChar:SetParent(data.trRoot)
  data.rtChar.anchoredPosition = Vector2.zero
  data.rtChar.localScale = Vector3.one
  data.rtChar.localRotation = Quaternion.identity
  data.rtRawImage.anchoredPosition = Vector2.zero
  data.rtRawImage.localScale = Vector3.one
  data.rtRawImage.localRotation = Quaternion.identity
  NovaAPI.SetRawImageColor(data.rawImage, self.mapPresetColor.invisible)
  data.eftGrayAndTrans.effectFactor = 0
  data.eftGrayAndTrans.blurFactor = 0
  data.eftGrayAndTrans.blurMode = false
  data.eftGrayAndTrans.effectFactorTr = 0
  data.eftGrayAndTrans.transitionTexture = nil
  data.eftGrayAndTrans.enabled = false
  data.rtEmoji.anchoredPosition = Vector2.zero
  data.rtEmoji.localScale = Vector3.one
  NovaAPI.PlayGradient2Anim(data.rawImage.gameObject, 0, 1, 0)
  if data.trFrame ~= nil then
    data.trFrame.gameObject:SetActive(false)
    data.trFrame = nil
  end
  data.trHead = nil
  delChildren(data.rtEmoji)
  NovaAPI.SetSpriteRendererSprite(data.sprBodyA, nil)
  NovaAPI.SetSpriteRendererSprite(data.sprBodyB, nil)
  NovaAPI.SetSpriteRendererColor(data.sprBodyA, self.mapPresetColor.invisible)
  NovaAPI.SetSpriteRendererColor(data.sprBodyB, self.mapPresetColor.normal)
  NovaAPI.SetSpriteRendererSprite(data.sprFaceA, nil)
  NovaAPI.SetSpriteRendererSprite(data.sprFaceB, nil)
  NovaAPI.SetSpriteRendererColor(data.sprFaceA, self.mapPresetColor.invisible)
  NovaAPI.SetSpriteRendererColor(data.sprFaceB, self.mapPresetColor.normal)
  NovaAPI.SetSpriteRendererSprite(data.sprBlack, nil)
  NovaAPI.SetSpriteRendererColor(data.sprBlack, self.mapPresetColor.black_invisible)
  data.sprBlack.gameObject:SetActive(false)
  data.bInUse = false
  data.trRoot.gameObject:SetActive(false)
  NovaAPI.SetTexture(data.rawImage, nil)
  data.camera.targetTexture = nil
  if data.renderTexture ~= nil then
    GameUIUtils.ReleaseRenderTexture(data.renderTexture)
    data.renderTexture = nil
  end
  if bForceClear == true then
    data.trRoot = nil
    data.rtChar = nil
    data.eftShake = nil
    data.animator = nil
    data.rtRawImage = nil
    data.rawImage = nil
    data.eftGrayAndTrans = nil
    data.rtEmoji = nil
    data.camera = nil
    data.sprBodyA = nil
    data.sprBodyB = nil
    data.sprFaceA = nil
    data.sprFaceB = nil
  end
end

function Avg_2_CharCtrl:GetCharData(sAvgCharId)
  for _, data in ipairs(self.tbCharIns) do
    if data.bInUse == true and data.sAvgCharId == sAvgCharId then
      return data, false
    end
  end
  for _, data in ipairs(self.tbCharIns) do
    if data.bInUse == false then
      self:CheckOffScreenInited(data)
      return data, true
    end
  end
  self:PreInstantiate(1)
  for _, data in ipairs(self.tbCharIns) do
    if data.bInUse == false then
      self:CheckOffScreenInited(data)
      return data, true
    end
  end
  printError("AVG角色立绘实例数量超过预实例化数量上限，更多实例(RenderTexture)将占用更多内存，可根据实际情况，调整预实例化数量。")
  return nil, false
end

function Avg_2_CharCtrl:PosPercentToV2(nX, nY)
  local nPosX = 0
  local nPosY = 0
  if nX <= 0 then
    nPosX = Settings.CURRENT_CANVAS_FULL_RECT_WIDTH * nX - Settings.CURRENT_CANVAS_FULL_RECT_WIDTH * 0.5
  elseif 1 <= nX then
    nPosX = Settings.CURRENT_CANVAS_FULL_RECT_WIDTH * (nX - 1) + Settings.CURRENT_CANVAS_FULL_RECT_WIDTH * 0.5
  else
    nPosX = Settings.DESIGN_SCREEN_RESOLUTION_WIDTH * nX - Settings.DESIGN_SCREEN_RESOLUTION_WIDTH * 0.5
  end
  nPosY = Settings.DESIGN_SCREEN_RESOLUTION_HEIGHT * nY - Settings.DESIGN_SCREEN_RESOLUTION_HEIGHT * 0.5
  return Vector2(nPosX, nPosY)
end

function Avg_2_CharCtrl:ParseTargetPos(nX, nY, v2Cur)
  local v2TargetPos = self:PosPercentToV2(nX or 0, nY or 0)
  if nX == nil then
    v2TargetPos.x = v2Cur.x
  end
  if nY == nil then
    v2TargetPos.y = v2Cur.y
  end
  return v2TargetPos
end

function Avg_2_CharCtrl:LoadPresetShake()
  if self.mapPresetShake == nil then
    self.mapPresetShake = {}
    for _, data in ipairs(self._panel.tbAvgPreset.CharShakeType) do
      local sKey = data[1]
      self.mapPresetShake[sKey] = data[2]
    end
  end
end

function Avg_2_CharCtrl:LoadPresetEnter()
  if self.mapPresetEnter == nil then
    self.mapPresetEnter = {}
    for _, v in ipairs(self._panel.tbAvgPreset.CharEnter) do
      local sKey = v[1]
      local tbValue = v[2]
      self.mapPresetEnter[sKey] = tbValue
    end
  end
end

function Avg_2_CharCtrl:LoadPresetExit()
  if self.mapPresetExit == nil then
    self.mapPresetExit = {}
    for _, v in ipairs(self._panel.tbAvgPreset.CharExit) do
      local sKey = v[1]
      local tbValue = v[2]
      self.mapPresetExit[sKey] = tbValue
    end
  end
end

function Avg_2_CharCtrl:LoadPresetEmoji()
  if self.tbHoldEmoji == nil then
    self.tbHoldEmoji = {}
    for _, v in ipairs(self._panel.tbAvgPreset.CharEmoji) do
      local sEmojiName = v[3]
      local bIsLoop = v[5]
      if bIsLoop == true then
        table.insert(self.tbHoldEmoji, sEmojiName)
      end
    end
  end
end

function Avg_2_CharCtrl:_KillCharTweener(mapCharData, nKey)
  if mapCharData.tbTw == nil then
    mapCharData.tbTw = {}
  end
  local tw = mapCharData.tbTw[nKey]
  if tw == nil then
    return
  end
  tw:Kill(true)
  tw = nil
  mapCharData.tbTw[nKey] = nil
end

function Avg_2_CharCtrl:_MarkCharTweener(mapCharData, tw, nKey)
  if tw == nil then
    return
  end
  if mapCharData.tbTw == nil then
    mapCharData.tbTw = {}
  end
  mapCharData.tbTw[nKey] = tw
end

function Avg_2_CharCtrl:_KillAllCharTweener(mapCharData)
  if mapCharData.tbTw == nil then
    return
  end
  for k, v in pairs(mapCharData.tbTw) do
    v:Kill(true)
  end
  mapCharData.tbTw = nil
end

function Avg_2_CharCtrl:_OptimizeUIEft(eft)
  if eft == nil then
    return
  end
  if eft.effectFactor < 0.001 and 0.001 > eft.effectFactorTr and 0.001 > eft.blurFactor then
    eft.enabled = false
  else
    eft.enabled = true
  end
  eft.blurMode = eft.blurFactor > 0
end

function Avg_2_CharCtrl:_SetPortrait(mapCharData, sAvgCharId, sBody, sFace, nStageType, rtRoot)
  mapCharData.trRoot.gameObject:SetActive(true)
  local trStageCharRoot = rtRoot
  if trStageCharRoot == nil then
    trStageCharRoot = self._panel.tbStageBgCtrl[nStageType]._mapNode.trCharRoot
  end
  mapCharData.rtChar:SetParent(trStageCharRoot)
  mapCharData.rtChar.anchoredPosition = Vector2.zero
  mapCharData.rtChar.localScale = Vector3.one
  mapCharData.rtChar.localRotation = Quaternion.identity
  mapCharData.bInUse = true
  mapCharData.sAvgCharId = sAvgCharId
  mapCharData.sBody = sBody
  mapCharData.sFace = sFace
  local sResAvgCharId = self._panel:GetAvgCharReuseRes(sAvgCharId)
  local spBody, spFace, v3OffsetPos, v3OffsetScale, spBlackBody = self:GetAvgPortrait(sResAvgCharId, sBody, sFace)
  NovaAPI.SetSpriteRendererSprite(mapCharData.sprBodyB, spBody)
  mapCharData.sprFaceB.transform.localScale = spFace == nil and Vector3.zero or Vector3.one
  NovaAPI.SetSpriteRendererSprite(mapCharData.sprFaceB, spFace)
  mapCharData.rtRawImage.anchoredPosition3D = v3OffsetPos
  mapCharData.rtRawImage.localScale = v3OffsetScale
  NovaAPI.SetSpriteRendererSprite(mapCharData.sprBlack, spBlackBody)
end

function Avg_2_CharCtrl:_SwitchPortrait(mapCharData, sAvgCharId, sBody, sFace, nDuration)
  local bSwitchBody, bSwitchFace = false, false
  if sBody == nil then
    if sFace == nil then
      return
    else
      bSwitchFace = sFace ~= mapCharData.sFace
    end
  else
    bSwitchBody = sBody ~= mapCharData.sBody
    if bSwitchBody == true then
      bSwitchFace = true
      if sFace == nil then
        sFace = "002"
      end
    elseif sFace == nil then
      return
    else
      bSwitchFace = sFace ~= mapCharData.sFace
    end
  end
  if bSwitchBody == false and bSwitchFace == false then
    return
  end
  if sBody == nil then
    sBody = mapCharData.sBody
  end
  if sFace == nil then
    sFace = mapCharData.sFace
  end
  if 0 < nDuration then
    nDuration = 0.33
  end
  local sEaseType_FadeOut = "InSine"
  local sEaseType_FadeIn = "OutSine"
  local sResAvgCharId = self._panel:GetAvgCharReuseRes(sAvgCharId)
  local spBody, spFace, v3OffsetPos, v3OffsetScale, spBlackBody = self:GetAvgPortrait(sResAvgCharId, sBody, sFace)
  if 0 < nDuration then
    if bSwitchBody == true then
      NovaAPI.SetSpriteRendererColor(mapCharData.sprBodyA, self.mapPresetColor.normal)
      NovaAPI.SetSpriteRendererSprite(mapCharData.sprBodyA, mapCharData.sprBodyB.sprite)
      local tweenerBodyA = NovaAPI.SpriteRendererDoColor(mapCharData.sprBodyA, self.mapPresetColor.invisible, nDuration)
      if tweenerBodyA ~= nil then
        tweenerBodyA:SetUpdate(true):SetEase(Ease[sEaseType_FadeOut])
      end
      NovaAPI.SetSpriteRendererColor(mapCharData.sprBodyB, self.mapPresetColor.invisible)
      NovaAPI.SetSpriteRendererSprite(mapCharData.sprBodyB, spBody)
      local tweenerBodyB = NovaAPI.SpriteRendererDoColor(mapCharData.sprBodyB, self.mapPresetColor.normal, nDuration)
      if tweenerBodyB ~= nil then
        tweenerBodyB:SetUpdate(true):SetEase(Ease[sEaseType_FadeIn])
      end
    end
    if bSwitchFace == true then
      NovaAPI.SetSpriteRendererColor(mapCharData.sprFaceA, self.mapPresetColor.normal)
      NovaAPI.SetSpriteRendererSprite(mapCharData.sprFaceA, mapCharData.sprFaceB.sprite)
      local tweenerFaceA = NovaAPI.SpriteRendererDoColor(mapCharData.sprFaceA, self.mapPresetColor.invisible, nDuration)
      if tweenerFaceA ~= nil then
        tweenerFaceA:SetUpdate(true):SetEase(Ease[sEaseType_FadeOut])
      end
      NovaAPI.SetSpriteRendererColor(mapCharData.sprFaceB, self.mapPresetColor.invisible)
      mapCharData.sprFaceB.transform.localScale = spFace == nil and Vector3.zero or Vector3.one
      NovaAPI.SetSpriteRendererSprite(mapCharData.sprFaceB, spFace)
      local tweenerFaceB = NovaAPI.SpriteRendererDoColor(mapCharData.sprFaceB, self.mapPresetColor.normal, nDuration)
      if tweenerFaceB ~= nil then
        tweenerFaceB:SetUpdate(true):SetEase(Ease[sEaseType_FadeIn])
      end
    end
  else
    if bSwitchBody == true then
      NovaAPI.SetSpriteRendererSprite(mapCharData.sprBodyB, spBody)
    end
    if bSwitchFace == true then
      mapCharData.sprFaceB.transform.localScale = spFace == nil and Vector3.zero or Vector3.one
      NovaAPI.SetSpriteRendererSprite(mapCharData.sprFaceB, spFace)
    end
  end
  mapCharData.sBody = sBody
  mapCharData.sFace = sFace
  NovaAPI.SetSpriteRendererSprite(mapCharData.sprBlack, spBlackBody)
end

function Avg_2_CharCtrl:OnEvent_ClearAllChar(nDuration)
  local bUseCmd = type(nDuration) == "number" and 0 < nDuration
  for _, data in ipairs(self.tbCharIns) do
    if data.bInUse == true and data.sAvgCharId ~= self.sNone then
      if bUseCmd == true then
        self:_SetExit(data, nDuration)
        local colorCur = NovaAPI.GetRawImageColor(data.rawImage)
        local targetColor = Color(colorCur.r, colorCur.g, colorCur.b, 0)
        self:_SetColor(data, targetColor, nDuration, "Linear")
      else
        self:ClearCharData(nil, data, false)
      end
    end
  end
end

function Avg_2_CharCtrl:OnEvent_SetMainRoltToChoiceUI(trRoot, sBody, sFace, sEmoji)
  if self:GetPanelId() == PanelId.AvgEditor and VISUALIZED_EDIT_CMD ~= true then
    return
  end
  local sMainRoleAvgCharId = "avg3_100"
  sMainRoleAvgCharId = AdjustMainRoleAvgCharId(sMainRoleAvgCharId)
  local mapCharData, bIsNew = self:GetCharData(sMainRoleAvgCharId)
  if mapCharData ~= nil then
    self:_SetPortrait(mapCharData, sMainRoleAvgCharId, sBody, sFace, 1, trRoot)
    NovaAPI.SetRawImageColor(mapCharData.rawImage, self.mapPresetColor.normal)
    self:_SetEmoji(mapCharData, sEmoji)
  end
end

function Avg_2_CharCtrl:OnEvent_ExitMainRoleInChoiceUI()
  if self:GetPanelId() == PanelId.AvgEditor and VISUALIZED_EDIT_CMD ~= true then
    return
  end
  local sMainRoleAvgCharId = "avg3_100"
  sMainRoleAvgCharId = AdjustMainRoleAvgCharId(sMainRoleAvgCharId)
  local mapCharData, bIsNew = self:GetCharData(sMainRoleAvgCharId)
  self:ClearCharData(nil, mapCharData, false)
end

function Avg_2_CharCtrl:OnEvent_SetMainRoleTalk(trRoot, sAvgCharId, sBody, sFace)
  if self:GetPanelId() == PanelId.AvgEditor and VISUALIZED_EDIT_CMD ~= true then
    return
  end
  sAvgCharId = AdjustMainRoleAvgCharId(sAvgCharId)
  local mapCharData, bIsNew = self:GetCharData(sAvgCharId)
  if mapCharData ~= nil then
    self:_SetPortrait(mapCharData, sAvgCharId, sBody, sFace, 1, trRoot)
    NovaAPI.SetRawImageColor(mapCharData.rawImage, self.mapPresetColor.normal)
    self.sCurMainRoleTalkCharId = sAvgCharId
  end
end

function Avg_2_CharCtrl:OnEvent_SwitchMainRoleTalk(sAvgCharId, sBody, sFace)
  if self:GetPanelId() == PanelId.AvgEditor and VISUALIZED_EDIT_CMD ~= true then
    return
  end
  sAvgCharId = AdjustMainRoleAvgCharId(sAvgCharId)
  local mapCharData, bIsNew
  if self.sCurMainRoleTalkCharId ~= nil and self.sCurMainRoleTalkCharId ~= sAvgCharId then
    mapCharData, bIsNew = self:GetCharData(self.sCurMainRoleTalkCharId)
    mapCharData.sAvgCharId = sAvgCharId
    mapCharData.sBody = ""
    mapCharData.sFace = ""
    self.sCurMainRoleTalkCharId = sAvgCharId
  else
    mapCharData, bIsNew = self:GetCharData(sAvgCharId)
  end
  if mapCharData ~= nil then
    self:_SwitchPortrait(mapCharData, sAvgCharId, sBody, sFace, 0)
  end
end

function Avg_2_CharCtrl:OnEvent_SetEmojiMainRoleTalk(sAvgCharId, sEmoji, bPlaySound)
  if self:GetPanelId() == PanelId.AvgEditor and VISUALIZED_EDIT_CMD ~= true then
    return
  end
  sAvgCharId = AdjustMainRoleAvgCharId(sAvgCharId)
  local mapCharData, bIsNew = self:GetCharData(sAvgCharId)
  if bIsNew == true then
    return
  end
  self:_SetEmoji(mapCharData, sEmoji, bPlaySound)
end

function Avg_2_CharCtrl:OnEvent_ShakeMainRoleTalk(sAvgCharId, sShakeType)
  if self:GetPanelId() == PanelId.AvgEditor and VISUALIZED_EDIT_CMD ~= true then
    return
  end
  sAvgCharId = AdjustMainRoleAvgCharId(sAvgCharId)
  local mapCharData, bIsNew = self:GetCharData(sAvgCharId)
  if mapCharData ~= nil then
    self:_SetShake(mapCharData.eftShake, sShakeType, mapCharData.animator)
  end
end

function Avg_2_CharCtrl:OnEvent_ResetMainRoleTalk(sAvgCharId, nDuration)
  if self:GetPanelId() == PanelId.AvgEditor and VISUALIZED_EDIT_CMD ~= true then
    return
  end
  sAvgCharId = AdjustMainRoleAvgCharId(sAvgCharId)
  local mapCharData, bIsNew = self:GetCharData(sAvgCharId)
  if sAvgCharId == "avg3_100" or sAvgCharId == "avg3_101" or sAvgCharId == "avg4_999" then
    self:_SetExit(mapCharData, nDuration)
  end
  self.sCurMainRoleTalkCharId = nil
end

function Avg_2_CharCtrl:OnEvent_AvgSpeedUp(nRate)
  if self:GetPanelId() ~= PanelId.AvgST then
    return
  end
  self:OnEvent_AvgSpeedUp_Timer(nRate)
  for index, value in ipairs(self.tbCharIns) do
    NovaAPI.SetAnimatorSpeed(value.animator, nRate)
  end
end

function Avg_2_CharCtrl:_delayHideUnloopEmoji(timer, goEmojiIns)
  if goEmojiIns ~= nil and goEmojiIns:IsNull() == false then
    goEmojiIns:SetActive(false)
  end
end

function Avg_2_CharCtrl:_SetEmoji(mapCharData, sEmoji, bPlaySound)
  self:LoadPresetEmoji()
  if bPlaySound == nil then
    bPlaySound = true
  end
  if sEmoji ~= nil and sEmoji ~= "none" then
    if sEmoji == "close" then
      if mapCharData.sEmoji ~= self.sNone then
        if mapCharData.rtEmoji.childCount > 0 then
          local trEmojiIns = mapCharData.rtEmoji:GetChild(mapCharData.rtEmoji.childCount - 1)
          if trEmojiIns ~= nil then
            local animator = trEmojiIns:GetComponent("Animator")
            if animator ~= nil then
              animator:SetTrigger("tOut")
              NovaAPI.SetAnimatorSpeed(animator, self._panel.nSpeedRate or 1)
            end
          end
        end
        mapCharData.sEmoji = self.sNone
      end
    else
      delChildren(mapCharData.rtEmoji)
      local sFullPath = string.format("UI/Avg/AnimEmoji/%s.prefab", sEmoji)
      local goEmojiIns = self:CreatePrefabInstance(sFullPath, mapCharData.rtEmoji)
      goEmojiIns.transform:SetLayerRecursively(self.nLayerIndex)
      local animator = goEmojiIns:GetComponent("Animator")
      if animator ~= nil then
        animator:SetTrigger("tIn")
        NovaAPI.SetAnimatorSpeed(animator, self._panel.nSpeedRate or 1)
      end
      local sResAvgCharId = self._panel:GetAvgCharReuseRes(mapCharData.sAvgCharId)
      local v3OffSetPosEmoji, v3OffsetScaleEmoji = self:GetAvgPortraitEmojiOffsetData(sResAvgCharId, mapCharData.sBody, self._panel:GetCharEmojiIndex(sEmoji))
      mapCharData.rtEmoji.anchoredPosition3D = v3OffSetPosEmoji
      mapCharData.rtEmoji.localScale = v3OffsetScaleEmoji
      if bPlaySound == true then
        self._panel:PlayCharEmojiSound(sEmoji)
      end
      if 0 < table.indexof(self.tbHoldEmoji, sEmoji) then
        mapCharData.sEmoji = sEmoji
      else
        mapCharData.sEmoji = self.sNone
        self:AddTimer(1, 5, "_delayHideUnloopEmoji", true, true, true, goEmojiIns)
      end
    end
  end
end

function Avg_2_CharCtrl:_SetSortOrder(mapCharData, nSortOrder)
  local nCurStageCharCnt = mapCharData.rtChar.parent.childCount
  if nSortOrder == nil then
    nSortOrder = 1
  else
    if nCurStageCharCnt < nSortOrder then
      nSortOrder = nCurStageCharCnt
    end
    if nSortOrder < 1 then
      nSortOrder = 1
    end
  end
  local nIndex = nCurStageCharCnt - nSortOrder
  mapCharData.rtChar:SetSiblingIndex(nIndex)
end

function Avg_2_CharCtrl:_SetPos(mapCharData, v2TargetPos, nDuration, sEaseType)
  self:_KillCharTweener(mapCharData, self.KEY.MOVE)
  if 0 < nDuration then
    local tweener = mapCharData.rtChar:DOAnchorPos(v2TargetPos, nDuration)
    tweener:SetUpdate(true)
    tweener:SetAutoKill(false)
    tweener:SetEase(Ease[sEaseType])
    self:_MarkCharTweener(mapCharData, tweener, self.KEY.MOVE)
  else
    mapCharData.rtChar.anchoredPosition = v2TargetPos
  end
end

function Avg_2_CharCtrl:_SetRotate(nRotateType, mapCharData, nRotate, nDuration, sEaseType)
  self:_KillCharTweener(mapCharData, self.KEY.ROTATE)
  local rt = mapCharData.rtChar
  if nRotateType == 1 then
    rt = mapCharData.rtRawImage
  end
  nRotate = nRotate % 360
  if 0 < nDuration then
    local nDelta = nRotate - rt.localEulerAngles.z
    if 180 < nDelta then
      nDelta = nDelta - 360
    elseif nDelta < -180 then
      nDelta = nDelta + 360
    end
    local tweener = rt:DORotate(Vector3(0, 0, nDelta), nDuration, RotateMode.LocalAxisAdd)
    tweener:SetUpdate(true)
    tweener:SetAutoKill(false)
    tweener:SetEase(Ease[sEaseType])
    self:_MarkCharTweener(mapCharData, tweener, self.KEY.ROTATE)
  else
    rt.localRotation = Quaternion.Euler(0, 0, nRotate)
  end
end

function Avg_2_CharCtrl:_SetScale(mapCharData, nScale, nDuration, sEaseType)
  self:_KillCharTweener(mapCharData, self.KEY.SCALE)
  local v3TargetScale = Vector3(nScale, math.abs(nScale), 1)
  if 0 < nDuration then
    local tweener = mapCharData.rtChar:DOScale(v3TargetScale, nDuration)
    tweener:SetUpdate(true)
    tweener:SetAutoKill(false)
    tweener:SetEase(Ease[sEaseType])
    self:_MarkCharTweener(mapCharData, tweener, self.KEY.SCALE)
  else
    mapCharData.rtChar.localScale = v3TargetScale
  end
end

function Avg_2_CharCtrl:_SetGray(mapCharData, nTargetGray, nDuration, sEaseType)
  self:_KillCharTweener(mapCharData, self.KEY.GRAY)
  if mapCharData.eftGrayAndTrans.enabled == false then
    mapCharData.eftGrayAndTrans.enabled = true
  end
  if 0 < nDuration then
    local tweener = mapCharData.eftGrayAndTrans:DOEffectAndTransitionGray(nTargetGray, nDuration)
    tweener:SetUpdate(true)
    tweener:SetAutoKill(false)
    tweener:SetEase(Ease[sEaseType])
    if nTargetGray < 0.001 then
      local function _cb()
        self:_OptimizeUIEft(mapCharData.eftGrayAndTrans)
      end
      
      tweener.onComplete = dotween_callback_handler(self, _cb)
    end
    self:_MarkCharTweener(mapCharData, tweener, self.KEY.GRAY)
  else
    mapCharData.eftGrayAndTrans.effectFactor = nTargetGray
    if nTargetGray < 0.001 then
      self:_OptimizeUIEft(mapCharData.eftGrayAndTrans)
    end
  end
end

function Avg_2_CharCtrl:_SetBlur(mapCharData, nTargetBlur, nDuration, sEaseType)
  self:_KillCharTweener(mapCharData, self.KEY.BLUR)
  if mapCharData.eftGrayAndTrans.enabled == false then
    mapCharData.eftGrayAndTrans.enabled = true
  end
  if mapCharData.eftGrayAndTrans.blurMode == false then
    mapCharData.eftGrayAndTrans.blurMode = true
  end
  if 0 < nDuration then
    local tweener = mapCharData.eftGrayAndTrans:DOEffectAndTransitionBlur(nTargetBlur, nDuration)
    tweener:SetUpdate(true)
    tweener:SetAutoKill(false)
    tweener:SetEase(Ease[sEaseType])
    if nTargetBlur < 0.001 then
      local function _cb()
        self:_OptimizeUIEft(mapCharData.eftGrayAndTrans)
      end
      
      tweener.onComplete = dotween_callback_handler(self, _cb)
    end
    self:_MarkCharTweener(mapCharData, tweener, self.KEY.BLUR)
  else
    mapCharData.eftGrayAndTrans.blurFactor = nTargetBlur
    if nTargetBlur < 0.001 then
      self:_OptimizeUIEft(mapCharData.eftGrayAndTrans)
    end
  end
end

function Avg_2_CharCtrl:_SetBright(mapCharData, nBright, nDuration, sEaseType)
  self:_KillCharTweener(mapCharData, self.KEY.BRIGHT)
  if mapCharData.sprBlack.gameObject.activeSelf == false then
    mapCharData.sprBlack.gameObject:SetActive(true)
  end
  if 0 < nDuration then
    local tweener = NovaAPI.SpriteRendererDoFade(mapCharData.sprBlack, nBright, nDuration)
    tweener:SetUpdate(true):SetEase(Ease[sEaseType])
    tweener:SetAutoKill(false)
    if nBright < 0.001 then
      local function _cb()
        mapCharData.sprBlack.gameObject:SetActive(false)
      end
      
      tweener.onComplete = dotween_callback_handler(self, _cb)
    end
    self:_MarkCharTweener(mapCharData, tweener, self.KEY.BRIGHT)
  else
    NovaAPI.SetSpriteRendererColor(mapCharData.sprBlack, Color(0, 0, 0, nBright))
    if nBright < 0.001 then
      mapCharData.sprBlack.gameObject:SetActive(false)
    end
  end
end

function Avg_2_CharCtrl:_SetColor(mapCharData, colorTarget, nDuration, sEaseType)
  self:_KillCharTweener(mapCharData, self.KEY.COLOR)
  if 0 < nDuration then
    local tweener = NovaAPI.DoRawImageColor(mapCharData.rawImage, colorTarget, nDuration)
    tweener:SetUpdate(true)
    tweener:SetAutoKill(false)
    tweener:SetEase(Ease[sEaseType])
    self:_MarkCharTweener(mapCharData, tweener, self.KEY.COLOR)
  else
    NovaAPI.SetRawImageColor(mapCharData.rawImage, colorTarget)
  end
end

function Avg_2_CharCtrl:_SetShake(eftShake, sShakeType, animator)
  self:LoadPresetShake()
  if sShakeType ~= nil and sShakeType ~= "none" then
    local tb = self.mapPresetShake[sShakeType]
    if animator.enabled == true then
      animator:SetTrigger("none")
      animator.enabled = false
    end
    local _sT = type(tb)
    if _sT == "table" then
      NovaAPI.DoShakeEffect(eftShake, tb[1], tb[2], tb[3])
    elseif _sT == "number" and (tb == 0 or tb == 1) then
      NovaAPI.StopShakeEffect(eftShake)
    end
  end
end

function Avg_2_CharCtrl:_SetGhost(mapCharData, sEftName, nDuration, sEaseType, nStart, nEnd)
  self:_KillCharTweener(mapCharData, self.KEY.EFT)
  if mapCharData.eftGrayAndTrans.enabled == false then
    mapCharData.eftGrayAndTrans.enabled = true
  end
  if 0 < nDuration then
    mapCharData.eftGrayAndTrans.transitionTexture = self:GetAvgStageEffect(sEftName)
    mapCharData.eftGrayAndTrans.effectFactorTr = nStart
    local tweener = mapCharData.eftGrayAndTrans:DOEffectAndTransitionFade(nEnd, nDuration)
    tweener:SetUpdate(true)
    tweener:SetAutoKill(false)
    tweener:SetEase(Ease[sEaseType])
    
    local function _cb()
      self:_OptimizeUIEft(mapCharData.eftGrayAndTrans)
    end
    
    tweener.onComplete = dotween_callback_handler(self, _cb)
    self:_MarkCharTweener(mapCharData, tweener, self.KEY.EFT)
  else
    mapCharData.eftGrayAndTrans.effectFactorTr = nEnd
    self:_OptimizeUIEft(mapCharData.eftGrayAndTrans)
  end
end

function Avg_2_CharCtrl:_SetExit(mapCharData, nDuration)
  if 0 < nDuration then
    self:AddTimer(1, nDuration, "ClearCharData", true, true, true, mapCharData)
  else
    self:ClearCharData(nil, mapCharData, false)
  end
end

function Avg_2_CharCtrl:_SetGradient2(mapCharData, nStart, nEnd, nDuration)
  NovaAPI.PlayGradient2Anim(mapCharData.rawImage.gameObject, nStart, nEnd, nDuration)
end

function Avg_2_CharCtrl:SetChar(tbParam)
  self:LoadPresetShake()
  self:LoadPresetEnter()
  self:LoadPresetExit()
  local nType = tbParam[1]
  local nStageType = tbParam[2] + 1
  local sKey = tbParam[3]
  local sAvgCharId = tbParam[4]
  sAvgCharId = AdjustMainRoleAvgCharId(sAvgCharId)
  local sBody = tbParam[5]
  local sFace = tbParam[6]
  local sEmoji = tbParam[7]
  local nSortOrder = tbParam[8]
  local nPosX = tbParam[9]
  local nPosY = tbParam[10]
  local nScale = tbParam[11]
  local nGray = tbParam[12]
  local nBright = tbParam[13]
  local nAlpha = tbParam[14]
  local nDuration = tbParam[15]
  local bWait = tbParam[16]
  local nBlur = tbParam[17]
  local mapCharData, bIsNew = self:GetCharData(sAvgCharId)
  local nPosX_Start, nPosY_Start, nScale_Start, nGray_Start, nBright_Start, nAlpha_Start, nBlur_Start, nPosX_End, nPosY_End, nScale_End, nGray_End, nBright_End, nAlpha_End, nBlur_End, sEftName
  local sEaseType = "Linear"
  if nType == 0 then
    if bIsNew == false then
      printError("Avg SetChar 入场指令配置中，含逻辑错误，不应该让一个 '已入场的角色' 入场。")
      return -1
    end
    local mapPresetData = self.mapPresetEnter[sKey]
    if mapPresetData == 0 then
      nPosX_End = nPosX or 0.5
      nPosY_End = nPosY or 0
      nScale_End = nScale or 1
      nGray_End = nGray or 0
      nBright_End = nBright or 0
      nAlpha_End = nAlpha or 1
      nPosX_Start = nPosX_End
      nPosY_Start = nPosY_End
      nScale_Start = nScale_End
      nGray_Start = nGray_End
      nBright_Start = nBright_End
      nAlpha_Start = nAlpha_End
      nBlur_End = nBlur or 0
      nBlur_Start = nBlur_End
    else
      nPosX_Start = mapPresetData.nPosX[1]
      nPosY_Start = mapPresetData.nPosY[1]
      nScale_Start = mapPresetData.nScale[1]
      nGray_Start = mapPresetData.nGray[1]
      nBright_Start = mapPresetData.nBright[1]
      nAlpha_Start = mapPresetData.nAlpha[1]
      nPosX_End = mapPresetData.nPosX[2]
      nPosY_End = mapPresetData.nPosY[2]
      nScale_End = mapPresetData.nScale[2]
      nGray_End = mapPresetData.nGray[2]
      nBright_End = mapPresetData.nBright[2]
      nAlpha_End = mapPresetData.nAlpha[2]
      sEftName = mapPresetData.sEftName
      sEaseType = mapPresetData.sEaseType
      nBlur_Start = mapPresetData.nBlur[1]
      nBlur_End = mapPresetData.nBlur[2]
    end
    self:_SetPortrait(mapCharData, sAvgCharId, sBody, sFace, nStageType)
    self:_SetEmoji(mapCharData, sEmoji)
    self:_SetSortOrder(mapCharData, nSortOrder)
    if mapCharData ~= nil then
      mapCharData.rtChar.anchoredPosition = self:PosPercentToV2(nPosX_Start, nPosY_Start)
      mapCharData.rtChar.localScale = Vector3(nScale_Start, math.abs(nScale_Start), 1)
      mapCharData.eftGrayAndTrans.effectFactor = nGray_Start
      self:_SetBright(mapCharData, nBright_Start, 0, nil)
      NovaAPI.SetRawImageColor(mapCharData.rawImage, Color(1, 1, 1, nAlpha_Start))
      mapCharData.eftGrayAndTrans.effectFactorTr = 0
      mapCharData.eftGrayAndTrans.blurFactor = nBlur_Start
      self:_OptimizeUIEft(mapCharData.eftGrayAndTrans)
    end
    if nPosX_Start ~= nPosX_End or nPosY_Start ~= nPosY_End then
      self:_SetPos(mapCharData, self:PosPercentToV2(nPosX_End, nPosY_End), nDuration, sEaseType)
    end
    if nScale_Start ~= nScale_End then
      self:_SetScale(mapCharData, nScale_End, nDuration, sEaseType)
    end
    if nGray_Start ~= nGray_End then
      self:_SetGray(mapCharData, nGray_End, nDuration, sEaseType)
    end
    if nBright_Start ~= nBright_End then
      self:_SetBright(mapCharData, nBright_End, nDuration, sEaseType)
    end
    if nAlpha_Start ~= nAlpha_End then
      self:_SetColor(mapCharData, Color(1, 1, 1, nAlpha_End), nDuration, sEaseType)
    end
    if nBlur_Start ~= nBlur_End then
      self:_SetBlur(mapCharData, nBlur_End, nDuration, sEaseType)
    end
    if sEftName ~= nil and sEftName ~= "none" then
      self:_SetGhost(mapCharData, sEftName, nDuration, sEaseType, 1, 0)
    end
  else
    if bIsNew == true then
      printError("Avg SetChar 离场指令配置中，含逻辑错误，不应该让一个 '未入场的角色' 离场。")
      return -1
    end
    local mapPresetData = self.mapPresetExit[sKey]
    if mapPresetData == 0 then
      nPosX_End = nPosX
      nPosY_End = nPosY
      nScale_End = nScale
      nGray_End = nGray
      nBright_End = nBright
      nAlpha_End = nAlpha
    else
      nPosX_End = mapPresetData.nPosX
      nPosY_End = mapPresetData.nPosY
      nScale_End = mapPresetData.nScale
      nGray_End = mapPresetData.nGray
      nBright_End = mapPresetData.nBright
      nAlpha_End = mapPresetData.nAlpha
      sEftName = mapPresetData.sEftName
      sEaseType = mapPresetData.sEaseType
    end
    if (nPosX_End ~= nil or nPosY_End ~= nil) and mapCharData ~= nil then
      self:_SetPos(mapCharData, self:ParseTargetPos(nPosX_End, nPosY_End, mapCharData.rtChar.anchoredPosition), nDuration, sEaseType)
    end
    if nScale_End ~= nil then
      self:_SetScale(mapCharData, nScale_End, nDuration, sEaseType)
    end
    if nGray_End ~= nil then
      self:_SetGray(mapCharData, nGray_End, nDuration, sEaseType)
    end
    if nBright_End ~= nil then
      self:_SetBright(mapCharData, nBright, nDuration, sEaseType)
    end
    if nAlpha_End ~= nil then
      self:_SetColor(mapCharData, Color(1, 1, 1, nAlpha_End), nDuration, sEaseType)
    end
    if sEftName ~= nil and sEftName ~= "none" then
      self:_SetGhost(mapCharData, sEftName, nDuration, sEaseType, 0, 1)
    end
    self:_SetExit(mapCharData, nDuration)
  end
  if bWait == true and 0 < nDuration then
    return nDuration
  else
    return 0
  end
end

function Avg_2_CharCtrl:CtrlChar(tbParam)
  self:LoadPresetShake()
  local sAvgCharId = tbParam[1]
  sAvgCharId = AdjustMainRoleAvgCharId(sAvgCharId)
  local sBody = tbParam[2]
  local sFace = tbParam[3]
  local sEmoji = tbParam[4]
  local nSortOrder = tbParam[5]
  local nPosX = tbParam[6]
  local nPosY = tbParam[7]
  local nScale = tbParam[8]
  local nGray = tbParam[9]
  local nBright = tbParam[10]
  local nAlpha = tbParam[11]
  local sShakeType = tbParam[12]
  local sEftName = tbParam[13]
  local sEaseType = tbParam[14]
  local nRotateType = tbParam[15]
  local nRotate = tbParam[16]
  local bExit = tbParam[17]
  local nDuration = tbParam[18]
  local bWait = tbParam[19]
  local nBlur = tbParam[20]
  local mapCharData, bIsNew = self:GetCharData(sAvgCharId)
  if bIsNew == true then
    printError("Avg CtrlChar 指令配置中，含逻辑错误，不应该直接控制一个 '未入场的角色' 。")
    return -1
  end
  self:_SwitchPortrait(mapCharData, sAvgCharId, sBody, sFace, nDuration)
  self:_SetEmoji(mapCharData, sEmoji)
  if nSortOrder ~= nil then
    self:_SetSortOrder(mapCharData, nSortOrder)
  end
  if (nPosX ~= nil or nPosY ~= nil) and mapCharData ~= nil then
    self:_SetPos(mapCharData, self:ParseTargetPos(nPosX, nPosY, mapCharData.rtChar.anchoredPosition), nDuration, sEaseType)
  end
  if nScale ~= nil then
    self:_SetScale(mapCharData, nScale, nDuration, sEaseType)
  end
  if nGray ~= nil then
    self:_SetGray(mapCharData, nGray, nDuration, sEaseType)
  end
  if nBright ~= nil then
    self:_SetBright(mapCharData, nBright, nDuration, sEaseType)
  end
  if nAlpha ~= nil then
    self:_SetColor(mapCharData, Color(1, 1, 1, nAlpha), nDuration, sEaseType)
  end
  if mapCharData ~= nil then
    self:_SetShake(mapCharData.eftShake, sShakeType, mapCharData.animator)
  end
  if sEftName ~= nil and sEftName ~= "none" then
    local nStart = 1
    local nEnd = 0
    if bExit == true then
      nStart = 0
      nEnd = 1
    end
    self:_SetGhost(mapCharData, sEftName, nDuration, sEaseType, nStart, nEnd)
  end
  if nRotate ~= nil then
    self:_SetRotate(nRotateType, mapCharData, nRotate, nDuration, sEaseType)
  end
  if nBlur ~= nil then
    self:_SetBlur(mapCharData, nBlur, nDuration, sEaseType)
  end
  if bExit == true then
    self:_SetExit(mapCharData, nDuration)
  end
  if bWait == true and 0 < nDuration then
    return nDuration
  else
    return 0
  end
end

function Avg_2_CharCtrl:PlayCharAnim(tbParam)
  local sAvgCharId = tbParam[1]
  sAvgCharId = AdjustMainRoleAvgCharId(sAvgCharId)
  local sAnimName = tbParam[2]
  local bExit = tbParam[3]
  local nDuration = tbParam[4]
  local bWait = tbParam[5]
  local mapCharData, bIsNew = self:GetCharData(sAvgCharId)
  if bIsNew == true then
    printError("Avg PlayCharAnim 指令配置中，含逻辑错误，不应该直接控制一个 '未入场的角色' 。")
    return -1
  end
  if sAnimName ~= "" and mapCharData ~= nil then
    mapCharData.animator.enabled = true
    mapCharData.animator:SetTrigger(sAnimName)
  end
  if bExit == true then
    self:_SetExit(mapCharData, nDuration)
  end
  if bWait == true and 0 < nDuration then
    return nDuration
  else
    return 0
  end
end

function Avg_2_CharCtrl:PlayGradient2Anim(tbParam)
  local sAvgCharId = tbParam[1]
  local nStart = tbParam[2]
  local nEnd = tbParam[3]
  local nDuration = tbParam[4]
  local bWait = tbParam[5]
  sAvgCharId = AdjustMainRoleAvgCharId(sAvgCharId)
  local mapCharData, bIsNew = self:GetCharData(sAvgCharId)
  if bIsNew == true then
    printError("Avg PlayGradient2Anim 指令配置中，含逻辑错误，不应该直接控制一个 '未入场的角色' 。")
    return -1
  end
  if mapCharData ~= nil then
    self:_SetGradient2(mapCharData, nStart, nEnd, nDuration)
  end
  if bWait == true and 0 < nDuration then
    return nDuration
  else
    return 0
  end
end

function Avg_2_CharCtrl:_SetCharHeadOffset(tr, sAvgCharId, sPose, nFrameIndex)
  local rt = tr.gameObject:GetComponent("RectTransform")
  sAvgCharId = self._panel:GetAvgCharReuseRes(sAvgCharId)
  local x, y, s = self:GetAvgHeadFrameOffsetData(sAvgCharId, sPose, nFrameIndex)
  rt.anchoredPosition = Vector2(x, y)
  rt.localScale = Vector3(s, math.abs(s), 1)
end

function Avg_2_CharCtrl:_SetCharHeadBg(mapCharData, nBgType)
  local imgFrameBg = mapCharData.trFrame:Find("rtFrameOffset/rtFramePos/goFrameBgMask/imgFrameBg"):GetComponent("Image")
  self:SetPngSprite(imgFrameBg, "UI/big_sprites/zs_avg_mood_" .. tostring(nBgType + 1))
end

function Avg_2_CharCtrl:_SetCharHeadFramePosScale(mapCharData, nX, nY, nS, nDuration, bAvgEditorPreivew, nStagePos)
  local rt = mapCharData.trFrame:GetChild(0):GetComponent("RectTransform")
  nX = nX or rt.anchoredPosition.x
  nY = nY or rt.anchoredPosition.y
  nS = nS or rt.localScale.x
  local v2TargetPos = Vector2(nX, nY)
  local v3TargetScale = Vector3(nS, nS, nS)
  if 0 < nDuration then
    self:_KillCharTweener(mapCharData, self.KEY.MOVE)
    local tweener = rt:DOAnchorPos(v2TargetPos, nDuration)
    tweener:SetUpdate(true)
    tweener:SetAutoKill(false)
    tweener:SetEase(Ease.Linear)
    self:_MarkCharTweener(mapCharData, tweener, self.KEY.MOVE)
    self:_KillCharTweener(mapCharData, self.KEY.SCALE)
    local tw = rt:DOScale(v3TargetScale, nDuration)
    tw:SetUpdate(true)
    tw:SetAutoKill(false)
    tw:SetEase(Ease.Linear)
    self:_MarkCharTweener(mapCharData, tw, self.KEY.SCALE)
  else
    rt.anchoredPosition = v2TargetPos
    rt.localScale = v3TargetScale
  end
  if bAvgEditorPreivew == true and 4 <= nStagePos then
    local cg = rt:GetChild(0):GetComponent("CanvasGroup")
    if cg ~= nil then
      NovaAPI.SetCanvasGroupAlpha(cg, 1)
    end
    local trCharWhite = rt:Find("rtFramePos/goCharMask/goCharWhite")
    if trCharWhite ~= nil then
      NovaAPI.SetImageColor(trCharWhite:GetComponent("Image"), Color(1, 1, 1, 0))
    end
  end
end

function Avg_2_CharCtrl:_DelayDisableCharHeadFrameAnim(timer, nStagePos)
  self._panel.tbStageBgCtrl[1]:DisableCharHeadFrameAnim(nStagePos)
end

function Avg_2_CharCtrl:SetCharHead(tbParam)
  local nType = tbParam[1]
  local nStagePos = tbParam[2] + 1
  local nFramePosX = tbParam[3] or 0
  local nFramePosY = tbParam[4] or 0
  local nFrameScale = tbParam[5] or 1
  local sAvgCharId = tbParam[6]
  sAvgCharId = AdjustMainRoleAvgCharId(sAvgCharId)
  local sBody = tbParam[7]
  local sFace = tbParam[8]
  local sEmoji = tbParam[9]
  local nBgType = tbParam[10]
  local nPosX = tbParam[11] or 0.5
  local nPosY = tbParam[12] or 0.5
  local nScale = tbParam[13] or 1
  local nGray = tbParam[14] or 0
  local nBright = tbParam[15] or 0
  local nAlpha = tbParam[16] or 1
  local nDuration = tbParam[17]
  local bWait = tbParam[18]
  local nBlur = tbParam[19] or 0
  local mapCharData, bIsNew = self:GetCharData(sAvgCharId)
  mapCharData.trFrame, mapCharData.trHead = self._panel.tbStageBgCtrl[1]:GetCharHeadFrameRoot(nStagePos)
  if nType == 0 then
    if bIsNew == false then
      printError("Avg SetCharHead 入场指令配置中，含逻辑错误，不应该让一个 '已入场的角色' 入场。")
      return -1
    end
    if mapCharData ~= nil then
      mapCharData.trFrame.gameObject:SetActive(true)
      self:_SetCharHeadOffset(mapCharData.trHead, sAvgCharId, sBody, nStagePos)
      self:_SetPortrait(mapCharData, sAvgCharId, sBody, sFace, 1, mapCharData.trHead)
      self:_SetEmoji(mapCharData, sEmoji)
      self:_SetPos(mapCharData, self:PosPercentToV2(nPosX, nPosY), 0, nil)
      self:_SetScale(mapCharData, nScale, 0, nil)
      self:_SetGray(mapCharData, nGray, 0, nil)
      self:_SetBlur(mapCharData, nBlur, 0, nil)
      self:_SetBright(mapCharData, nBright, 0, nil)
      self:_SetColor(mapCharData, Color(1, 1, 1, nAlpha), 0, nil)
      self:_OptimizeUIEft(mapCharData.eftGrayAndTrans)
      self:_SetCharHeadBg(mapCharData, nBgType)
      self:_SetCharHeadFramePosScale(mapCharData, nFramePosX, nFramePosY, nFrameScale, 0)
    end
    nDuration = self._panel.tbStageBgCtrl[1]:PlayCharHeadFrameAnim(nStagePos, nType)
  else
    if bIsNew == true then
      printError("Avg SetCharHead 离场指令配置中，含逻辑错误，不应该让一个 '未入场的角色' 离场。")
      return -1
    end
    nDuration = self._panel.tbStageBgCtrl[1]:PlayCharHeadFrameAnim(nStagePos, nType)
    self:_SetExit(mapCharData, nDuration)
  end
  self:AddTimer(1, nDuration, "_DelayDisableCharHeadFrameAnim", true, true, true, nStagePos)
  if bWait == true and 0 < nDuration then
    return nDuration
  else
    return 0
  end
end

function Avg_2_CharCtrl:CtrlCharHead(tbParam)
  local nPosX = tbParam[1]
  local nPosY = tbParam[2]
  local nScale = tbParam[3]
  local sAvgCharId = tbParam[4]
  sAvgCharId = AdjustMainRoleAvgCharId(sAvgCharId)
  local nBgType = tbParam[5]
  local nDuration = tbParam[6]
  local bWait = tbParam[7]
  local mapCharData, bIsNew = self:GetCharData(sAvgCharId)
  local sEaseType = "Linear"
  if bIsNew == true then
    printError("Avg CtrlChar 指令配置中，含逻辑错误，不应该直接控制一个 '未入场的角色'的头像框 。")
    return -1
  end
  self:_SetCharHeadBg(mapCharData, nBgType)
  self:_SetCharHeadFramePosScale(mapCharData, nPosX, nPosY, nScale, nDuration)
  if bWait == true and 0 < nDuration then
    return nDuration
  else
    return 0
  end
end

function Avg_2_CharCtrl:RestoreAll(bActive, tbHistoryData)
  self.gameObject:SetActive(bActive)
  if bActive == false then
    for _, data in ipairs(self.tbCharIns) do
      self:ClearCharData(nil, data, false)
    end
    self.mapPresetShake = nil
    self.mapPresetEnter = nil
    self.mapPresetExit = nil
    return
  end
  for nIndex, data in ipairs(tbHistoryData) do
    local mapCharData = self.tbCharIns[nIndex]
    self:CheckOffScreenInited(mapCharData)
    if data.sAvgCharId == "" then
      self:ClearCharData(nil, mapCharData, false)
    else
      if data.IsCharHead == true then
        mapCharData.trFrame, mapCharData.trHead = self._panel.tbStageBgCtrl[1]:GetCharHeadFrameRoot(data.nStagePos)
        self:_SetCharHeadOffset(mapCharData.trHead, data.sAvgCharId, data.sBody, data.nStagePos)
        self:_SetCharHeadBg(mapCharData, data.nBgType)
        self:_SetCharHeadFramePosScale(mapCharData, data.nFramePosX, data.nFramePosY, data.nFrameScale, 0, true, data.nStagePos)
        mapCharData.trFrame.gameObject:SetActive(true)
      end
      self:_SetPortrait(mapCharData, data.sAvgCharId, data.sBody, data.sFace, data.nStageType, mapCharData.trHead)
      self:_SetPos(mapCharData, self:PosPercentToV2(data.nPosX, data.nPosY), 0, nil)
      self:_SetEmoji(mapCharData, data.sEmoji, false)
      self:_SetScale(mapCharData, data.nScale, 0, nil)
      self:_SetGray(mapCharData, data.nGray, 0, nil)
      self:_SetBlur(mapCharData, data.nBlur, 0, nil)
      self:_SetBright(mapCharData, data.nBright, 0, nil)
      self:_SetColor(mapCharData, Color(1, 1, 1, data.nAlpha), 0, nil)
      self:_SetRotate(data.nRotateType, mapCharData, data.nRotate, 0, nil)
      self:_SetGradient2(mapCharData, 1, data.nBlackOffset, 0)
      if data.sAnim ~= "" then
        mapCharData.animator.enabled = true
        mapCharData.animator:CrossFade("Base Layer." .. data.sAnim, 0, -1, 1, 0)
      else
        mapCharData.animator.enabled = false
      end
    end
  end
  for nIndex, data in ipairs(tbHistoryData) do
    if data.sAvgCharId ~= "" and data.IsCharHead ~= true then
      self:_SetSortOrder(self.tbCharIns[nIndex], data.nSortOrder)
    end
  end
end

return Avg_2_CharCtrl
