local Avg_0_Stage = class("Avg_0_Stage", BaseCtrl)
Avg_0_Stage._mapNodeConfig = {
  imgStage_Main = {
    sNodeName = "----StageRoot----",
    sComponentName = "Image"
  },
  tbStageTr = {
    sNodeName = "Stage_",
    nCount = 7,
    sComponentName = "Transform"
  },
  tbAnim = {
    sNodeName = "anim_",
    nCount = 7,
    sComponentName = "Animator"
  },
  tbAnimRT = {
    sNodeName = "anim_",
    nCount = 7,
    sComponentName = "RectTransform"
  },
  tbShakeEft = {
    sNodeName = "shake_",
    nCount = 7,
    sComponentName = "GameObject"
  },
  tbImgRT = {
    sNodeName = "rawImg_",
    nCount = 7,
    sComponentName = "RectTransform"
  },
  tbRawImg = {
    sNodeName = "rawImg_",
    nCount = 7,
    sComponentName = "RawImage"
  },
  tbRawImgHeartBeat = {
    sNodeName = "rawImgHeartBeat_",
    nCount = 7,
    sComponentName = "RawImage"
  },
  tbAnimHeartBeat = {
    sNodeName = "shake_",
    nCount = 7,
    sComponentName = "Animator"
  },
  goFrontObj = {
    sNodeName = "FrontObjMask"
  },
  imgFrontObjMask = {
    sNodeName = "FrontObjMask",
    sComponentName = "Image"
  },
  imgFrontObjA = {
    sNodeName = "imgFrontObj_A",
    sComponentName = "Image"
  },
  imgFrontObjB = {
    sNodeName = "imgFrontObj_B",
    sComponentName = "Image"
  },
  rtFrontObjA = {
    sNodeName = "imgFrontObj_A",
    sComponentName = "RectTransform"
  },
  rtFrontObjB = {
    sNodeName = "imgFrontObj_B",
    sComponentName = "RectTransform"
  }
}
Avg_0_Stage._mapEventConfig = {
  [EventId.AvgClearStage] = "OnEvent_ClearStage",
  [EventId.AvgSpeedUp] = "OnEvent_AvgSpeedUp"
}
local ENUM_InOut = {
  DoTweenFadeIn = 0,
  DoTweenFadeOut = 1,
  DoTweenIn = 2,
  DoTweenOut = 3,
  MoveIn = 4,
  MoveOut = 5,
  ExpandIn = 6,
  ExpandOut = 7,
  ExpandFullIn = 8,
  ExpandFullOut = 9,
  ExpandFullInEx = 10,
  ExpandFullOutEx = 11,
  MoveInEx = 12,
  MoveOutEx = 13,
  ScaleIn = 14,
  ScaleOut = 15,
  FadeIn = 16,
  FadeOut = 17
}
local tbKeepStay = {
  ENUM_InOut.ExpandFullOutEx
}

function Avg_0_Stage:Awake()
  self.goStageInsRoot = GameObject("--AvgStageOffScreenRender--")
  self.goStageInsRoot.transform:SetParent(PanelManager.GetUIRoot(self._panel._sSortingLayerName))
  local trParent = self.goStageInsRoot.transform
  trParent.localPosition = Vector3.zero
  trParent.localScale = Vector3.one
  self:_GetMask_RT_CG()
  local objStageTemplate = self:LoadAsset("UI/Avg/Avg_1_Bg.prefab")
  local nCount = 7
  self._panel.tbStageBgCtrl = {}
  for i = 1, nCount do
    local tbData = self:_GetStageSize(i)
    local goStageIns = instantiate(objStageTemplate, trParent)
    goStageIns.transform.localPosition = Vector3(0, -10000 * i, 0)
    goStageIns.transform.localScale = Vector3.one
    local objCtrl = self:BindCtrlByNode(goStageIns, "Game.UI.Avg.Avg_1_BgCtrl")
    objCtrl:InitOffScreenRender(self._mapNode.tbRawImg[i], i, tbData.v2PreferredSize)
    table.insert(self._panel.tbStageBgCtrl, objCtrl)
    NovaAPI.SetCanvasGroupAlpha(self._mapNode.tbCanvasGroup[i], i == 1 and 1 or 0)
    if tbData.v2SizeOut ~= nil and tbData.v2SizeIn ~= nil then
      self._mapNode.tbMaskRT[i].sizeDelta = tbData.v2SizeOut
    end
    if tbData.v2PosOut ~= nil and tbData.v2PosIn ~= nil then
      self._mapNode.tbMaskRT[i].anchoredPosition = tbData.v2PosOut
    end
  end
  if self._panel.AVG_NO_BG_MODE == true then
    local color = Color(0, 0, 0, 0.5)
    local sAvgCfgHead = string.sub(self._panel.sAvgId, 1, 2)
    if sAvgCfgHead == "GD" then
      color = Color(0, 0, 0, 0.65)
    end
    NovaAPI.SetImageColor(self._mapNode.imgStage_Main, color)
    NovaAPI.SetRawImageMaterial(self._mapNode.tbRawImg[1], nil)
  end
end

function Avg_0_Stage:OnDisable()
  if self.goStageInsRoot ~= nil then
    destroy(self.goStageInsRoot)
    self.goStageInsRoot = nil
  end
  self._panel.tbStageBgCtrl = nil
end

function Avg_0_Stage:ResetStageEft(nIndex)
  self._mapNode.tbImgRT[nIndex].pivot = Vector2(0.5, 0.5)
  self._mapNode.tbImgRT[nIndex].anchoredPosition = Vector2(0, 0)
  self._mapNode.tbImgRT[nIndex].localScale = Vector3.one
  NovaAPI.SetRawImageColor(self._mapNode.tbRawImg[nIndex], Color.white)
  NovaAPI.StopShakeEffect(self._mapNode.tbShakeEft[nIndex])
end

function Avg_0_Stage:LoadPresetShake()
  if self.mapPresetShake == nil then
    self.mapPresetShake = {}
    for _, data in ipairs(self._panel.tbAvgPreset.BgShakeType) do
      local sKey = data[1]
      self.mapPresetShake[sKey] = data[2]
    end
  end
end

function Avg_0_Stage:PosPercentToV2(nX, nY)
  local nPosX = 0
  local nPosY = 0
  if nX <= 0 then
    nPosX = Settings.CURRENT_CANVAS_FULL_RECT_WIDTH * nX - Settings.CURRENT_CANVAS_FULL_RECT_WIDTH * 0.5
  elseif 1 <= nX then
    nPosX = Settings.CURRENT_CANVAS_FULL_RECT_WIDTH * (nX - 1) + Settings.CURRENT_CANVAS_FULL_RECT_WIDTH * 0.5
  else
    nPosX = Settings.DESIGN_SCREEN_RESOLUTION_WIDTH * nX - Settings.DESIGN_SCREEN_RESOLUTION_WIDTH * 0.5
  end
  if nY <= 0 then
    nPosY = Settings.CURRENT_CANVAS_FULL_RECT_HEIGHT * nY - Settings.CURRENT_CANVAS_FULL_RECT_HEIGHT * 0.5
  elseif 1 <= nY then
    nPosY = Settings.CURRENT_CANVAS_FULL_RECT_HEIGHT * (nY - 1) + Settings.CURRENT_CANVAS_FULL_RECT_HEIGHT * 0.5
  else
    nPosY = Settings.DESIGN_SCREEN_RESOLUTION_HEIGHT * nY - Settings.DESIGN_SCREEN_RESOLUTION_HEIGHT * 0.5
  end
  return Vector2(nPosX, nPosY)
end

function Avg_0_Stage:_GetMask_RT_CG()
  self._mapNode.tbMaskRT = {}
  self._mapNode.tbCanvasGroup = {}
  self._mapNode.tbAnchorRT = {}
  for i = 1, 7 do
    local tr = self._mapNode.tbAnim[i].transform:GetChild(0)
    self._mapNode.tbMaskRT[i] = tr:GetComponent("RectTransform")
    self._mapNode.tbCanvasGroup[i] = tr:GetComponent("CanvasGroup")
    self._mapNode.tbAnchorRT[i] = tr:GetChild(0):GetComponent("RectTransform")
  end
end

function Avg_0_Stage:_GetStageSize(nStageIndex)
  local nW, nH = Settings.CURRENT_CANVAS_FULL_RECT_WIDTH, Settings.CURRENT_CANVAS_FULL_RECT_HEIGHT
  if self._panel._nPanelId == PanelId.AvgEditor then
    nW, nH = 2160, 1080
  end
  local tbStageSize = {
    [1] = {},
    [2] = {
      v2SizeOut = Vector2(0, 2500),
      v2SizeIn = Vector2(1500, 2500),
      v2PreferredSize = Vector2(nW, nH)
    },
    [3] = {
      v2SizeOut = Vector2(0, 2500),
      v2SizeIn = Vector2(1500, 2500),
      v2PreferredSize = Vector2(nW, nH)
    },
    [4] = {
      v2PosOut = Vector2(-2000, -186.3497),
      v2PosIn = Vector2(-1115.467, -186.3497),
      v2PreferredSize = Vector2(1200, nH)
    },
    [5] = {
      v2PosOut = Vector2(2000, -186.3497),
      v2PosIn = Vector2(1115.467, -186.3497),
      v2PreferredSize = Vector2(1200, nH)
    },
    [6] = {
      v2SizeOut = Vector2(2500, 0),
      v2SizeIn = Vector2(2500, 400),
      v2PreferredSize = Vector2(nW, nH)
    },
    [7] = {
      v2SizeOut = Vector2(2500, 0),
      v2SizeIn = Vector2(2500, 400),
      v2PreferredSize = Vector2(nW, nH)
    }
  }
  return tbStageSize[nStageIndex]
end

function Avg_0_Stage:_DelayHideFrontObj()
  self._mapNode.goFrontObj:SetActive(false)
end

function Avg_0_Stage:_PlayStageAnim(nStageIndex, nInOut)
  local animator = self._mapNode.tbAnim[nStageIndex]
  if animator == nil then
    return
  end
  animator.enabled = true
  local sName
  if nInOut == ENUM_InOut.MoveIn then
    sName = "Stage%sMoveIn"
  elseif nInOut == ENUM_InOut.MoveOut then
    sName = "Stage%sMoveOut"
  elseif nInOut == ENUM_InOut.ExpandIn then
    sName = "Stage%sExpandIn"
  elseif nInOut == ENUM_InOut.ExpandOut then
    sName = "Stage%sExpandOut"
  elseif nInOut == ENUM_InOut.ExpandFullIn then
    sName = "Stage%sExpandFullIn"
  elseif nInOut == ENUM_InOut.ExpandFullOut then
    sName = "Stage%sExpandFullOut"
  elseif nInOut == ENUM_InOut.ExpandFullInEx then
    sName = "Stage%sExpandFullInEx"
  elseif nInOut == ENUM_InOut.ExpandFullOutEx then
    sName = "Stage%sExpandFullOutEx"
  elseif nInOut == ENUM_InOut.MoveInEx then
    sName = "Stage%sMoveInEx"
  elseif nInOut == ENUM_InOut.MoveOutEx then
    sName = "Stage%sMoveOutEx"
  elseif nInOut == ENUM_InOut.ScaleIn then
    sName = "Stage%sScaleIn"
  elseif nInOut == ENUM_InOut.ScaleOut then
    sName = "Stage%sScaleOut"
  elseif nInOut == ENUM_InOut.FadeIn then
    sName = "Stage%sFadeIn"
  elseif nInOut == ENUM_InOut.FadeOut then
    sName = "Stage%sFadeOut"
  end
  if sName == nil then
    return
  end
  sName = string.format(sName, tostring(nStageIndex))
  animator:Play(sName, 0, 0)
  local nInOutAnimLength = NovaAPI.GetAnimClipLength(animator, {sName})
  if nInOutAnimLength <= 0 then
    nInOutAnimLength = animator:GetCurrentAnimatorStateInfo(0).length
  end
  if 0 >= table.indexof(tbKeepStay, nInOut) then
    local sCallback = nInOut % 2 == 0 and "_DelayResetStageAnim" or "_DelayResetStageEft"
    self:AddTimer(1, nInOutAnimLength, sCallback, true, true, true, nStageIndex)
  end
  return nInOutAnimLength
end

function Avg_0_Stage:_ResetStageSizePosanchor(nStageIndex)
  local rtAnim = self._mapNode.tbAnimRT[nStageIndex]
  local rtMask = self._mapNode.tbMaskRT[nStageIndex]
  local rtAnchor = self._mapNode.tbAnchorRT[nStageIndex]
  rtAnim.anchoredPosition = Vector2.zero
  if nStageIndex == 2 then
    rtMask.pivot = Vector2(0, 0.5)
    rtMask.anchoredPosition = Vector2(-1409.539, 513.0305)
    rtMask.sizeDelta = Vector2(1500, 2500)
    rtAnchor.anchorMin = Vector2(0, 0.5)
    rtAnchor.anchorMax = Vector2(0, 0.5)
    rtAnchor.anchoredPosition = Vector2(1500, 0)
  elseif nStageIndex == 3 then
    rtMask.pivot = Vector2(1, 0.5)
    rtMask.anchoredPosition = Vector2(1409.539, -513.0305)
    rtMask.sizeDelta = Vector2(1500, 2500)
    rtAnchor.anchorMin = Vector2(1, 0.5)
    rtAnchor.anchorMax = Vector2(1, 0.5)
    rtAnchor.anchoredPosition = Vector2(-1500, 0)
  elseif nStageIndex == 4 then
    rtMask.pivot = Vector2(0, 0.5)
    rtMask.anchoredPosition = Vector2(-1115.467, -186.3497)
    rtMask.sizeDelta = Vector2(720, 2500)
    rtAnchor.anchorMin = Vector2(0, 0.5)
    rtAnchor.anchorMax = Vector2(0, 0.5)
    rtAnchor.anchoredPosition = Vector2(720, 0)
  elseif nStageIndex == 5 then
    rtMask.pivot = Vector2(1, 0.5)
    rtMask.anchoredPosition = Vector2(1115.467, -186.3497)
    rtMask.sizeDelta = Vector2(720, 2500)
    rtAnchor.anchorMin = Vector2(1, 0.5)
    rtAnchor.anchorMax = Vector2(1, 0.5)
    rtAnchor.anchoredPosition = Vector2(-720, 0)
  elseif nStageIndex == 6 then
    rtMask.pivot = Vector2(0.5, 0.5)
    rtMask.anchoredPosition = Vector2(0, 150)
    rtMask.sizeDelta = Vector2(2500, 400)
    rtAnchor.anchorMin = Vector2(0.5, 0.5)
    rtAnchor.anchorMax = Vector2(0.5, 0.5)
    rtAnchor.anchoredPosition = Vector2(0, -150)
  elseif nStageIndex == 7 then
    rtMask.pivot = Vector2(0.5, 0.5)
    rtMask.anchoredPosition = Vector2(0, -150)
    rtMask.sizeDelta = Vector2(2500, 400)
    rtAnchor.anchorMin = Vector2(0.5, 0.5)
    rtAnchor.anchorMax = Vector2(0.5, 0.5)
    rtAnchor.anchoredPosition = Vector2(0, 150)
  end
end

function Avg_0_Stage:_DelayCloseHeartBeatPP(timer)
  self:_RemapCmdProcFunc({
    0,
    "fx_avg_nega_ev",
    1,
    0,
    0,
    0,
    1,
    false,
    0,
    false
  }, "SetFx")
end

function Avg_0_Stage:_DelayCloseHeartBeat(timer, nStageIndex)
  local rawImgHeartBeat = self._mapNode.tbRawImgHeartBeat[nStageIndex]
  NovaAPI.SetTexture(rawImgHeartBeat, nil)
  rawImgHeartBeat.gameObject:SetActive(false)
  self._mapNode.tbAnimHeartBeat[nStageIndex].enabled = false
  local rawImg = self._mapNode.tbRawImg[nStageIndex]
  local rtRawImg = rawImg.gameObject:GetComponent("RectTransform")
  local rtRawImgParent = rtRawImg.parent
  local rtRawImgHeartBeat = rawImgHeartBeat.gameObject:GetComponent("RectTransform")
  local rtRawImgHeartBeatParent = rtRawImgHeartBeat.parent
  local nW = rtRawImgHeartBeat.rect.width
  local nH = rtRawImgHeartBeat.rect.height
  local v2Pivot = Vector2(0.5, 0.5)
  rtRawImgParent.pivot = v2Pivot
  rtRawImgParent.anchoredPosition = Vector2.zero
  rtRawImgHeartBeatParent.pivot = v2Pivot
  rtRawImgHeartBeatParent.anchoredPosition = Vector2.zero
end

function Avg_0_Stage:OnEvent_ClearStage()
  if self:GetPanelId() == PanelId.AvgEditor then
    return
  end
  for i = 0, 6 do
    self:CtrlStage({
      i,
      0.5,
      0.5,
      0,
      0,
      1,
      0,
      1,
      0,
      "stop",
      "Linear",
      0,
      false
    })
  end
  for i = 0, 5 do
    self:SetStage({
      i,
      ENUM_InOut.DoTweenFadeOut,
      "Linear",
      0.0,
      false
    })
  end
  for i, v in ipairs(self._panel.tbStageBgCtrl) do
    v:ClearAll()
  end
  self:SetFrontObj({
    1,
    1,
    "",
    nil,
    nil,
    0.0,
    false
  }, 0)
  self._mapNode.goFrontObj:SetActive(false)
  for i, v in ipairs(self._mapNode.tbRawImgHeartBeat) do
    v.gameObject:SetActive(false)
  end
end

function Avg_0_Stage:OnEvent_AvgSpeedUp(nRate)
  if self:GetPanelId() ~= PanelId.AvgST then
    return
  end
  self:OnEvent_AvgSpeedUp_Timer(nRate)
  for index, value in ipairs(self._mapNode.tbAnim) do
    NovaAPI.SetAnimatorSpeed(value, nRate)
  end
  for index, value in ipairs(self._mapNode.tbAnimHeartBeat) do
    NovaAPI.SetAnimatorSpeed(value, nRate)
  end
end

function Avg_0_Stage:_RemapCmdProcFunc(tbParam, sCmdName)
  local nIndex = tbParam[1] + 1
  local objBgCtrl = self._panel.tbStageBgCtrl[nIndex]
  local _tbParam = {}
  for k, v in pairs(tbParam) do
    _tbParam[k - 1] = v
  end
  local ProcFunc = objBgCtrl[sCmdName]
  return ProcFunc(objBgCtrl, _tbParam)
end

function Avg_0_Stage:SetBg(tbParam)
  local nIndex = tbParam[1] + 1
  if nIndex == 1 then
    self._panel.tbStageBgCtrl[nIndex]:Active(true)
  end
  return self:_RemapCmdProcFunc(tbParam, "SetBg")
end

function Avg_0_Stage:CtrlBg(tbParam)
  return self:_RemapCmdProcFunc(tbParam, "CtrlBg")
end

function Avg_0_Stage:SetFx(tbParam)
  return self:_RemapCmdProcFunc(tbParam, "SetFx")
end

function Avg_0_Stage:SetFrontObj(tbParam, n)
  local nTime = n or 0.33
  local sEaseType_FadeOut = "InSine"
  local sEaseType_FadeIn = "OutSine"
  local bShow = tbParam[1] == 0
  local bShowMask = tbParam[2] == 0
  local sName = tbParam[3]
  local nPosX = tbParam[4] or 0.5
  local nPosY = tbParam[5] or 0.5
  local nDuration = tbParam[6]
  local bWait = tbParam[7]
  if bShow == true then
    self._mapNode.goFrontObj:SetActive(true)
    if bShowMask == true and 0.5 > NovaAPI.GetImageColor(self._mapNode.imgFrontObjMask).a then
      local tweener = NovaAPI.ImageDoFade(self._mapNode.imgFrontObjMask, 0.5, nTime, true)
      tweener:SetEase(Ease[sEaseType_FadeIn])
    elseif bShowMask == false and 0 < NovaAPI.GetImageColor(self._mapNode.imgFrontObjMask).a then
      local tweener = NovaAPI.ImageDoFade(self._mapNode.imgFrontObjMask, 0, nTime, true)
      tweener:SetEase(Ease[sEaseType_FadeOut])
    end
    if 0 < NovaAPI.GetImageColor(self._mapNode.imgFrontObjB).a then
      NovaAPI.SetImageColor(self._mapNode.imgFrontObjA, Color.white)
      NovaAPI.SetImageSpriteAsset(self._mapNode.imgFrontObjA, self._mapNode.imgFrontObjB.sprite)
      NovaAPI.SetImageNativeSize(self._mapNode.imgFrontObjA)
      self._mapNode.rtFrontObjA.anchoredPosition = self._mapNode.rtFrontObjB.anchoredPosition
      local tweenerA = NovaAPI.ImageDoFade(self._mapNode.imgFrontObjA, 0, nTime, true)
      tweenerA:SetEase(Ease[sEaseType_FadeOut])
    end
    NovaAPI.SetImageColor(self._mapNode.imgFrontObjB, Color(1, 1, 1, 0))
    self:SetPngSprite(self._mapNode.imgFrontObjB, Avg_ProcRes_M_F("Icon/AvgElement/" .. sName))
    NovaAPI.SetImageNativeSize(self._mapNode.imgFrontObjB)
    self._mapNode.rtFrontObjB.anchoredPosition = self:PosPercentToV2(nPosX, nPosY)
    local tweenerB = NovaAPI.ImageDoFade(self._mapNode.imgFrontObjB, 1, nTime, true)
    tweenerB:SetEase(Ease[sEaseType_FadeIn])
  else
    if 0 < NovaAPI.GetImageColor(self._mapNode.imgFrontObjMask).a then
      local tweenerMask = NovaAPI.ImageDoFade(self._mapNode.imgFrontObjMask, 0, nTime, true)
      tweenerMask:SetEase(Ease[sEaseType_FadeOut])
    end
    if 0 < NovaAPI.GetImageColor(self._mapNode.imgFrontObjA).a then
      local tweenerA = NovaAPI.ImageDoFade(self._mapNode.imgFrontObjA, 0, nTime, true)
      tweenerA:SetEase(Ease[sEaseType_FadeOut])
    end
    if 0 < NovaAPI.GetImageColor(self._mapNode.imgFrontObjB).a then
      local tweenerB = NovaAPI.ImageDoFade(self._mapNode.imgFrontObjB, 0, nTime, true)
      tweenerB:SetEase(Ease[sEaseType_FadeOut])
    end
    if type(nTime) == "number" and 0 < nTime then
      self:AddTimer(1, nTime, "_DelayHideFrontObj", true, true, true, true)
    end
  end
  if bWait == true and 0 < nDuration then
    return nDuration
  else
    return 0
  end
end

function Avg_0_Stage:SetHeartBeat(tbParam)
  local nStageIndex = tbParam[1] + 1
  local nPivotX = tbParam[2] or 0.5
  local nPivotY = tbParam[3] or 0.5
  local nDelTime = tbParam[4]
  self:_RemapCmdProcFunc({
    0,
    "fx_avg_nega_ev",
    0,
    0,
    0,
    0,
    1,
    false,
    0,
    false
  }, "SetFx")
  local rawImg = self._mapNode.tbRawImg[nStageIndex]
  local rawImgHeartBeat = self._mapNode.tbRawImgHeartBeat[nStageIndex]
  NovaAPI.SetTexture(rawImgHeartBeat, NovaAPI.GetTexture(rawImg))
  local rtRawImg = rawImg.gameObject:GetComponent("RectTransform")
  local rtRawImgHeartBeat = rawImgHeartBeat.gameObject:GetComponent("RectTransform")
  rtRawImgHeartBeat.pivot = rtRawImg.pivot
  rtRawImgHeartBeat.anchoredPosition = rtRawImg.anchoredPosition
  rtRawImgHeartBeat.localScale = rtRawImg.localScale
  rawImgHeartBeat.gameObject:SetActive(true)
  local rtRawImgParent = rtRawImg.parent
  local rtRawImgHeartBeatParent = rtRawImgHeartBeat.parent
  local nW = rtRawImgHeartBeat.rect.width
  local nH = rtRawImgHeartBeat.rect.height
  local v2Pivot = Vector2(nPivotX, nPivotY)
  local v2Pos = Vector2((nPivotX - 0.5) * nW, (nPivotY - 0.5) * nH)
  rtRawImgParent.pivot = v2Pivot
  rtRawImgParent.anchoredPosition = v2Pos
  rtRawImgHeartBeatParent.pivot = v2Pivot
  rtRawImgHeartBeatParent.anchoredPosition = v2Pos
  local animator = self._mapNode.tbAnimHeartBeat[nStageIndex]
  animator.enabled = true
  animator:Play("stage_heart_beat", 0, 0)
  local nAnimLen = NovaAPI.GetAnimClipLength(animator, {
    "stage_heart_beat"
  })
  self:AddTimer(1, nAnimLen - nDelTime, "_DelayCloseHeartBeatPP", true, true, true)
  self:AddTimer(1, nAnimLen, "_DelayCloseHeartBeat", true, true, true, nStageIndex)
  return nAnimLen
end

function Avg_0_Stage:SetPP(tbParam)
  tbParam[1] = tbParam[1] + 1
  return self:_RemapCmdProcFunc(tbParam, "SetPP")
end

function Avg_0_Stage:SetPPGlobal(tbParam)
  if self:GetPanelId() == PanelId.AvgEditor and VISUALIZED_EDIT_CMD ~= true then
    return
  end
  local bApplyToAll = tbParam[1] == 1
  local trParent
  if bApplyToAll == true then
    trParent = self._panel.tbStageBgCtrl[1]._mapNode.trSubStageRT
  else
    trParent = self._mapNode.imgStage_Main.transform
  end
  for i = 2, 7 do
    local trStage = self._mapNode.tbStageTr[i]
    trStage:SetParent(trParent)
    trStage:SetAsLastSibling()
    trStage.localPosition = Vector3.zero
  end
  return 0
end

function Avg_0_Stage:SetStage(tbParam)
  local nIndex = tbParam[1] + 2
  local nInOut = tbParam[2]
  local sEaseType = tbParam[3]
  local nDuration = tbParam[4]
  local bWait = tbParam[5]
  local enumEase = Ease[sEaseType]
  local tbData = self:_GetStageSize(nIndex)
  local objBgCtrl = self._panel.tbStageBgCtrl[nIndex]
  local rtMask = self._mapNode.tbMaskRT[nIndex]
  local canvasGroup = self._mapNode.tbCanvasGroup[nIndex]
  local trStage = self._mapNode.tbAnim[nIndex].transform
  local bInOut = nInOut % 2 == 0
  if bInOut == true then
    if nInOut <= ENUM_InOut.DoTweenIn then
      self:_ResetStageSizePosanchor(nIndex)
      NovaAPI.SetCanvasGroupAlpha(canvasGroup, 1)
      if 0 < nDuration then
        local twRT
        if tbData.v2SizeIn ~= nil then
          rtMask.sizeDelta = tbData.v2SizeOut
          twRT = rtMask:DOSizeDelta(tbData.v2SizeIn, nDuration)
        elseif tbData.v2PosIn ~= nil then
          rtMask.anchoredPosition = tbData.v2PosOut
          twRT = rtMask:DOAnchorPos(tbData.v2PosIn, nDuration)
        end
        if twRT ~= nil then
          twRT:SetUpdate(true)
          twRT:SetEase(enumEase)
        end
      elseif tbData.v2SizeIn ~= nil then
        rtMask.sizeDelta = tbData.v2SizeIn
      elseif tbData.v2PosIn ~= nil then
        rtMask.anchoredPosition = tbData.v2PosIn
      end
    else
      nDuration = self:_PlayStageAnim(nIndex, nInOut)
    end
    objBgCtrl:Active(true)
    trStage:SetAsLastSibling()
  elseif bInOut == false then
    if nInOut <= ENUM_InOut.DoTweenOut then
      if 0 < nDuration then
        local twRT
        if tbData.v2SizeOut ~= nil then
          rtMask.sizeDelta = tbData.v2SizeIn
          twRT = rtMask:DOSizeDelta(tbData.v2SizeOut, nDuration)
        elseif tbData.v2PosOut ~= nil then
          rtMask.anchoredPosition = tbData.v2PosIn
          twRT = rtMask:DOAnchorPos(tbData.v2PosOut, nDuration)
        end
        if twRT ~= nil then
          twRT:SetUpdate(true)
          twRT:SetEase(enumEase)
        end
        self:AddTimer(1, nDuration, "_DelayResetStageEft", true, true, true, nIndex)
      else
        if tbData.v2SizeOut ~= nil then
          rtMask.sizeDelta = tbData.v2SizeOut
        elseif tbData.v2PosOut ~= nil then
          rtMask.anchoredPosition = tbData.v2PosOut
        end
        objBgCtrl:Active(false)
        self:ResetStageEft(nIndex)
        NovaAPI.SetCanvasGroupAlpha(canvasGroup, 0)
      end
    else
      nDuration = self:_PlayStageAnim(nIndex, nInOut)
    end
  end
  if bWait == true and 0 < nDuration then
    return nDuration
  else
    return 0
  end
end

function Avg_0_Stage:_DelayResetStageEft(timer, nIndex)
  self._panel.tbStageBgCtrl[nIndex]:Active(false)
  self:ResetStageEft(nIndex)
  NovaAPI.SetCanvasGroupAlpha(self._mapNode.tbCanvasGroup[nIndex], 0)
  self._mapNode.tbAnim[nIndex].enabled = false
end

function Avg_0_Stage:_DelayResetStageAnim(timer, nIndex)
  self._mapNode.tbAnim[nIndex].enabled = false
end

function Avg_0_Stage:CtrlStage(tbParam)
  self:LoadPresetShake()
  local nIndex = tbParam[1] + 1
  local nPivotX = tbParam[2]
  local nPivotY = tbParam[3]
  local nPosX = tbParam[4]
  local nPosY = tbParam[5]
  local nScale = tbParam[6]
  local nGray = tbParam[7]
  local nBrightness = tbParam[8]
  local nBlur = tbParam[9]
  local sShakeType = tbParam[10]
  local sEaseType = tbParam[11]
  local nDuration = tbParam[12]
  local bWait = tbParam[13]
  local rt = self._mapNode.tbImgRT[nIndex]
  local rawImg = self._mapNode.tbRawImg[nIndex]
  local shake = self._mapNode.tbShakeEft[nIndex]
  local enumEase = Ease[sEaseType]
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
  if nBrightness ~= nil then
    local color = Color(nBrightness, nBrightness, nBrightness, 1)
    if 0 < nDuration then
      local tweener = rawImg:DOColor(color, nDuration)
      tweener:SetUpdate(true)
      tweener:SetEase(enumEase)
    else
      NovaAPI.SetRawImageColor(rawImg, color)
    end
  end
  if sShakeType ~= nil then
    local tb = self.mapPresetShake[sShakeType]
    local _sT = type(tb)
    if _sT == "table" then
      NovaAPI.DoShakeEffect(shake, tb[1], tb[2], tb[3])
    elseif _sT == "number" and (tb == 0 or tb == 1) then
      NovaAPI.StopShakeEffect(shake)
    end
  end
  if bWait == true and 0 < nDuration then
    return nDuration
  else
    return 0
  end
end

function Avg_0_Stage:RestoreAll(bActive, tbHistoryData)
  self.gameObject:SetActive(bActive)
  if bActive == false then
    self.mapPresetShake = nil
  end
  if self._panel.AVG_NO_BG_MODE == true then
    NovaAPI.SetImageColor(self._mapNode.imgStage_Main, Color(0, 0, 0, 0.5))
  else
    NovaAPI.SetImageColor(self._mapNode.imgStage_Main, Color(0, 0, 0, 1))
  end
  for nIndex = 1, 7 do
    local data = tbHistoryData[nIndex]
    local rt = self._mapNode.tbImgRT[nIndex]
    local rawImg = self._mapNode.tbRawImg[nIndex]
    rt.pivot = Vector2(data.stage.nPivotX, data.stage.nPivotY)
    rt.anchoredPosition = Vector2(data.stage.nPosX, data.stage.nPosY)
    rt.localScale = Vector3(data.stage.nScale, data.stage.nScale, 1)
    NovaAPI.SetRawImageColor(rawImg, Color(data.stage.nBrightness, data.stage.nBrightness, data.stage.nBrightness, 1))
    local tbData = self:_GetStageSize(nIndex)
    local objBgCtrl = self._panel.tbStageBgCtrl[nIndex]
    local rtMask = self._mapNode.tbMaskRT[nIndex]
    local canvasGroup = self._mapNode.tbCanvasGroup[nIndex]
    if 1 < nIndex then
      NovaAPI.SetCanvasGroupAlpha(canvasGroup, data.bIn == true and 1 or 0)
      if data.bIn == true then
        if tbData.v2SizeIn ~= nil then
          rtMask.sizeDelta = tbData.v2SizeIn
        else
          rtMask.anchoredPosition = tbData.v2PosIn
        end
      elseif tbData.v2SizeOut ~= nil then
        rtMask.sizeDelta = tbData.v2SizeOut
      else
        rtMask.anchoredPosition = tbData.v2PosOut
      end
    end
    objBgCtrl:RestoreAll(bActive and data.bIn, data.bg, data.fg, data.bgfx, data.fgfx, data.topfx, data.filterfx, data.bRemoveUnloopFx)
  end
  local data = tbHistoryData.fo
  local _color = NovaAPI.GetImageColor(self._mapNode.imgFrontObjMask)
  _color = Color(_color.r, _color.g, _color.b, 0)
  local _colorInvisible = Color(1, 1, 1, 0)
  local _colorVisible = Color.white
  if data.sName == "" then
    NovaAPI.SetImageColor(self._mapNode.imgFrontObjMask, _color)
    NovaAPI.SetImageColor(self._mapNode.imgFrontObjA, _colorInvisible)
    NovaAPI.SetImageSpriteAsset(self._mapNode.imgFrontObjA, nil)
    self._mapNode.rtFrontObjA.anchoredPosition = Vector2.zero
    NovaAPI.SetImageColor(self._mapNode.imgFrontObjB, _colorInvisible)
    NovaAPI.SetImageSpriteAsset(self._mapNode.imgFrontObjB, nil)
    NovaAPI.SetImageSpriteAsset(self._mapNode.imgFrontObjB, nil)
    self._mapNode.rtFrontObjB.anchoredPosition = Vector2.zero
  else
    NovaAPI.SetImageColor(self._mapNode.imgFrontObjMask, data.bMask == true and Color(_color.r, _color.g, _color.b, 0.5) or _color)
    NovaAPI.SetImageColor(self._mapNode.imgFrontObjA, _colorInvisible)
    NovaAPI.SetImageSpriteAsset(self._mapNode.imgFrontObjA, nil)
    self._mapNode.rtFrontObjA.anchoredPosition = Vector2.zero
    NovaAPI.SetImageColor(self._mapNode.imgFrontObjB, _colorVisible)
    self:SetPngSprite(self._mapNode.imgFrontObjB, "Icon/AvgElement/" .. data.sName)
    NovaAPI.SetImageNativeSize(self._mapNode.imgFrontObjB)
    self._mapNode.rtFrontObjB.anchoredPosition = self:PosPercentToV2(data.nPosX, data.nPosY)
  end
end

return Avg_0_Stage
