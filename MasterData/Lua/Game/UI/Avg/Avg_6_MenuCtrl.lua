local LocalData = require("GameCore.Data.LocalData")
local WwiseAudioMgr = CS.WwiseAudioManager.Instance
local GamepadUIManager = require("GameCore.Module.GamepadUIManager")
local LayoutRebuilder = CS.UnityEngine.UI.LayoutRebuilder
local LoopType = CS.DG.Tweening.LoopType
local Avg_6_MenuCtrl = class("Avg_6_MenuCtrl", BaseCtrl)
Avg_6_MenuCtrl._mapNodeConfig = {
  goUIBTN = {
    sNodeName = "----UI_BTN----"
  },
  canvas_group = {
    sComponentName = "CanvasGroup"
  },
  rtCG = {
    sNodeName = "canvas_group",
    sComponentName = "RectTransform"
  },
  imgMenuBg = {sComponentName = "Image"},
  rtImgMenuBg = {
    sNodeName = "imgMenuBg",
    sComponentName = "RectTransform"
  },
  btnSkip = {sComponentName = "NaviButton", callback = "OnBtn_Skip"},
  btnUIOnOff = {
    sComponentName = "NaviButton",
    callback = "OnBtn_UIOnOff"
  },
  imgBtnIcon_UIOnOff = {sComponentName = "Image"},
  btnLogOnOff = {
    sComponentName = "NaviButton",
    callback = "OnBtn_LogOnOff"
  },
  imgBtnIcon_Log = {sComponentName = "Image"},
  btnFoldMenu = {
    sComponentName = "NaviButton",
    callback = "OnBtn_FoldMenu"
  },
  goBtnIcon_FoldMenu = {
    sNodeName = "imgBtnIcon_FoldMenu",
    sComponentName = "GameObject"
  },
  goBtnIcon_UnfoldMenu = {
    sNodeName = "imgBtnIcon_UnfoldMenu",
    sComponentName = "GameObject"
  },
  btnAutoPlayOnOff = {
    sComponentName = "NaviButton",
    callback = "OnBtn_AutoPlayOnOff"
  },
  imgBtnIcon_AutoPlay = {sComponentName = "Image"},
  ActionBar = {
    sCtrlName = "Game.UI.ActionBar.ActionBarCtrl"
  },
  btnSpeedUp = {
    sComponentName = "NaviButton",
    callback = "OnBtn_SpeedUp"
  },
  tbTrSpeedUpIcon = {
    nCount = 3,
    sNodeName = "imgBtnIcon_SpeedUp",
    sComponentName = "Transform"
  },
  imgBtnIcon_SpeedUp1 = {sComponentName = "Image"},
  txtTime1 = {sComponentName = "TMP_Text"},
  txtDay1 = {sComponentName = "TMP_Text"},
  txtDay2 = {sComponentName = "TMP_Text"},
  txtPos1 = {sComponentName = "TMP_Text"},
  txtPos2 = {sComponentName = "TMP_Text"},
  aniTime = {
    sNodeName = "----TimeHeading----",
    sComponentName = "Animator"
  },
  goTimeHeading = {
    sNodeName = "----TimeHeading----",
    sComponentName = "GameObject"
  },
  goRootIntro = {
    sNodeName = "----Intro----"
  },
  acWindow = {sNodeName = "t_window", sComponentName = "Animator"},
  cgWindow = {
    sNodeName = "t_window",
    sComponentName = "CanvasGroup"
  },
  txtStoryId = {sComponentName = "TMP_Text"},
  txtStoryTitle = {sComponentName = "TMP_Text"},
  rubyTmpContent = {
    sComponentName = "RubyTextMeshProUGUI"
  },
  btnClose = {
    sComponentName = "UIButton",
    callback = "OnBtn_CloseIntro"
  },
  btnCancel = {
    sComponentName = "NaviButton",
    callback = "OnBtn_CloseIntro",
    sAction = "Back"
  },
  btnConfirm1 = {
    sComponentName = "NaviButton",
    callback = "OnBtn_ConfirmIntro",
    sAction = "Confirm"
  },
  txtWindowTitle = {sComponentName = "TMP_Text"},
  txtBtnCancel = {nCount = 2, sComponentName = "TMP_Text"},
  txtBtnConfirm1_ = {nCount = 2, sComponentName = "TMP_Text"},
  txtSkipTips = {sComponentName = "TMP_Text"},
  goRootNewCharIntro = {
    sNodeName = "----NewCharIntro----"
  },
  cgNewCharIntro = {
    sNodeName = "----NewCharIntro----",
    sComponentName = "CanvasGroup"
  },
  animChar = {
    sNodeName = "----NewCharIntro----",
    sComponentName = "Animator"
  },
  rtCharXYS = {
    sNodeName = "char_x_y_s",
    sComponentName = "RectTransform"
  },
  rtRawImgChar = {
    sNodeName = "rawImgChar",
    sComponentName = "RectTransform"
  },
  rawImgChar = {sNodeName = "rawImgChar", sComponentName = "RawImage"},
  tmpRoleName = {sComponentName = "TMP_Text"},
  tmpRoleTitle = {sComponentName = "TMP_Text"},
  trOffscreenRenderer = {
    sNodeName = "offscreen_renderer",
    sComponentName = "Transform"
  },
  Camera = {sNodeName = "Camera", sComponentName = "Camera"},
  sprBody = {
    sNodeName = "body",
    sComponentName = "SpriteRenderer"
  },
  sprFace = {
    sNodeName = "face",
    sComponentName = "SpriteRenderer"
  }
}
Avg_6_MenuCtrl._mapEventConfig = {
  [EventId.AvgAllMenuBtnEnable] = "OnEvent_AvgAllMenuBtnEnable",
  [EventId.AvgShowHideLog] = "OnEvent_AvgShowHideLog",
  [EventId.AvgSkipCheckIntro] = "OnEvent_AvgSkipCheckIntro",
  [EventId.AvgLogBtnEnable] = "OnEvent_AvgLogBtnEnable",
  [EventId.AvgSpeedUp] = "OnEvent_AvgSpeedUp",
  [EventId.AvgResetSpeed] = "OnEvent_AvgResetSpeed",
  [EventId.AvgRefreshActionBar] = "OnEvent_AvgRefreshActionBar",
  AvgCheckAutoOnOff = "OnEvent_CheckAutoOnOff"
}

function Avg_6_MenuCtrl:Awake()
  local _nScale = 1 / Settings.CANVAS_SCALE
  self._mapNode.trOffscreenRenderer.localScale = Vector3(_nScale, _nScale, _nScale)
  self:InitActionBarConfig()
  self:SetAutoLineWrap(true)
  self.mapIntroData = {}
  self.bUnfoldMenu = false
  self.bUILog = false
  self.bSetSpeed = true
  self.bALL = true
  if self._panel.sAvgId ~= nil then
    local sAvgCfgHead = string.sub(self._panel.sAvgId, 1, 2)
    self._mapNode.goUIBTN:SetActive(sAvgCfgHead ~= "GD" and sAvgCfgHead ~= "AA")
    if sAvgCfgHead == "GD" or sAvgCfgHead == "AA" then
      self.bALL = false
    end
  end
end

function Avg_6_MenuCtrl:OnEnable()
  self.bUIOn = true
  self:SetUIOnOff()
  self.bLogOn = false
  self.tbBtnIconColor = {
    "#264278",
    "#0ABEC5",
    "#6A7289"
  }
  self.bAutoPlayOn = self:GetLocalData("AvgMenu", "StateAuto")
  if self.bAutoPlayOn == nil then
    self.bAutoPlayOn = false
  end
  self:SetAutoPlayOnOff(true)
  if self._panel.tbAvgPreset ~= nil then
    self.tbSpeed = self._panel.tbAvgPreset.PlaySpeed[self._panel.sTxtLan]
  end
  if self.tbSpeed == nil then
    self.tbSpeed = {
      1,
      4,
      16
    }
  end
  if AVG_EDITOR == true then
    table.insert(self.tbSpeed, 32)
  end
  self.nSpeedIdx = 1
  self:SetSpeedUp()
  if self:GetPanelId() ~= PanelId.AvgEditor then
    local nLanguageIndex = self._panel.nCurLanguageIdx
    local AvgUIText = require(GetAvgLuaRequireRoot(nLanguageIndex) .. "Preset/AvgUIText")
    LayoutRebuilder.ForceRebuildLayoutImmediate(self._mapNode.rtCG)
    self.nWidth = self._mapNode.rtCG.rect.width
    self:UnfoldMenu(true)
    NovaAPI.SetTMPText(self._mapNode.txtWindowTitle, AvgUIText.SkipWinTitle)
    NovaAPI.SetTMPText(self._mapNode.txtSkipTips, AvgUIText.SkipTips)
    for i = 1, 3 do
      NovaAPI.SetTMPText(self._mapNode.txtBtnCancel[i], AvgUIText.AVG_BtnCancel)
      NovaAPI.SetTMPText(self._mapNode.txtBtnConfirm1_[i], AvgUIText.AVG_BtnConfim)
    end
  end
  local nInOutAnimLength = NovaAPI.GetAnimClipLength(self._mapNode.aniTime, {"time_in", "time_out"})
  self.nTimeHeadingDuration = nInOutAnimLength - 0.3
  if self.nTimeHeadingDuration < 0 then
    self.nTimeHeadingDuration = 0
  end
  self._mapNode.Camera.enabled = false
  self:AddGamepadUINode()
end

function Avg_6_MenuCtrl:OnDisable()
  if self.RT ~= nil then
    self._mapNode.Camera.targetTexture = nil
    NovaAPI.SetTexture(self._mapNode.rawImgChar, nil)
    GameUIUtils.ReleaseRenderTexture(self.RT)
    self.RT = nil
  end
  self.mapIntroData = nil
  self.bALL = false
  self:_ResetAllMenuBtn()
end

function Avg_6_MenuCtrl:GetLocalData(sMainKey, sSubKey)
  if AVG_EDITOR == true then
    return LocalData.GetLocalData(sMainKey, sSubKey)
  else
    return LocalData.GetPlayerLocalData(sSubKey)
  end
end

function Avg_6_MenuCtrl:SetLocalData(sMainKey, sSubKey, value)
  if AVG_EDITOR == true then
    LocalData.SetLocalData(sMainKey, sSubKey, value)
  else
    LocalData.SetPlayerLocalData(sSubKey, value)
  end
end

function Avg_6_MenuCtrl:SetAutoLineWrap(bEnable)
  NovaAPI.SetTMP_AutoLineWrap(self._mapNode.rubyTmpContent, bEnable)
end

function Avg_6_MenuCtrl:SetAudioSpeed()
  if self.nSpeedIdx == 1 then
    WwiseAudioMgr:PostEvent("avg_vox_100")
  else
    WwiseAudioMgr:PostEvent("avg_vox_0")
  end
end

function Avg_6_MenuCtrl:_SetMenuBtnEnable(bEnable, btn, img, tmp)
  local sColor = bEnable == true and "#264278" or "#94aac0"
  local _b, _color = ColorUtility.TryParseHtmlString(sColor)
  NovaAPI.SetButtonInteractable(btn, bEnable)
  if img ~= nil then
    NovaAPI.SetImageColor(img, _color)
  end
  if tmp ~= nil then
    NovaAPI.SetTMPColor(tmp, _color)
  end
end

function Avg_6_MenuCtrl:_ResetAllMenuBtn()
  self:_SetMenuBtnEnable(self.bALL == true, self._mapNode.btnSkip)
  self:_SetMenuBtnEnable(self.bALL == true and self.bUnfoldMenu == true and self.bUILog == true, self._mapNode.btnUIOnOff, self._mapNode.imgBtnIcon_UIOnOff)
  self:_SetMenuBtnEnable(self.bALL == true and self.bUnfoldMenu == true and self.bUILog == true, self._mapNode.btnLogOnOff, self._mapNode.imgBtnIcon_Log)
  self:_SetMenuBtnEnable(self.bALL == true, self._mapNode.btnFoldMenu, nil, nil)
  self:_SetMenuBtnEnable(self.bALL == true, self._mapNode.btnAutoPlayOnOff, nil, nil)
  self:_SetMenuBtnEnable(self.bALL == true and self.bSetSpeed == true and self.bUnfoldMenu == true, self._mapNode.btnSpeedUp, self._mapNode.imgBtnIcon_SpeedUp1, nil)
end

function Avg_6_MenuCtrl:SetUIOnOff()
  EventManager.Hit(EventId.AvgShowHideTalkUI, self.bUIOn)
end

function Avg_6_MenuCtrl:SetAutoPlayOnOff(bByInit)
  local sColor = self.tbBtnIconColor[1]
  if self.bAutoPlayOn == true then
    sColor = self.tbBtnIconColor[2]
  end
  local _b, _color = ColorUtility.TryParseHtmlString(sColor)
  NovaAPI.SetImageColor(self._mapNode.imgBtnIcon_AutoPlay, _color)
  if self.bAutoPlayOn == true then
    if self.tweener == nil then
      self.tweener = self._mapNode.imgBtnIcon_AutoPlay.transform:DOLocalRotate(Vector3(0, 0, -360), 2.6, RotateMode.FastBeyond360):SetLoops(-1, LoopType.Restart):SetEase(Ease.Linear):SetUpdate(true)
    end
  elseif self.tweener ~= nil then
    self.tweener:Kill()
    self._mapNode.imgBtnIcon_AutoPlay.transform.localRotation = Quaternion.identity
    self.tweener = nil
  end
  EventManager.Hit(EventId.AvgSetAutoPlay, self.bAutoPlayOn, bByInit == true)
  self:SetLocalData("AvgMenu", "StateAuto", self.bAutoPlayOn)
  NovaAPI.SetScreenSleepTimeout(self.bAutoPlayOn == true)
end

function Avg_6_MenuCtrl:SetSpeedUp()
  for i, v in ipairs(self._mapNode.tbTrSpeedUpIcon) do
    v.localScale = i == self.nSpeedIdx and Vector3.one or Vector3.zero
  end
  EventManager.Hit(EventId.AvgSpeedUp, self.tbSpeed[self.nSpeedIdx])
  self:SetAudioSpeed()
end

function Avg_6_MenuCtrl:UnfoldMenu(bSkipPlayAnim)
  self:_ResetAllMenuBtn()
  self:RefreshActionBar()
  local nTargetWidth = 0
  local nTargetAlpha = 0
  local sEase = "InBack"
  if self.bUnfoldMenu == true then
    nTargetWidth = self.nWidth
    nTargetAlpha = 1
    sEase = "OutBack"
    self._mapNode.goBtnIcon_FoldMenu:SetActive(true)
    self._mapNode.goBtnIcon_UnfoldMenu:SetActive(false)
  else
    self._mapNode.goBtnIcon_FoldMenu:SetActive(false)
    self._mapNode.goBtnIcon_UnfoldMenu:SetActive(true)
  end
  NovaAPI.SetCanvasGroupInteractable(self._mapNode.canvas_group, nTargetAlpha == 1)
  NovaAPI.SetCanvasGroupBlocksRaycasts(self._mapNode.canvas_group, nTargetAlpha == 1)
  local v2Size = Vector2(nTargetWidth, 99)
  if bSkipPlayAnim == true then
    NovaAPI.SetCanvasGroupAlpha(self._mapNode.canvas_group, nTargetAlpha)
    self._mapNode.rtImgMenuBg.sizeDelta = v2Size
    NovaAPI.SetImageColor(self._mapNode.imgMenuBg, Color(1, 1, 1, nTargetAlpha))
  else
    self._mapNode.canvas_group:DOFade(nTargetAlpha, 0.2):SetUpdate(true)
    self._mapNode.rtImgMenuBg:DOSizeDelta(v2Size, 0.2):SetUpdate(true):SetEase(Ease[sEase])
    NovaAPI.ImageDoFade(self._mapNode.imgMenuBg, nTargetAlpha, 0.2, true)
    EventManager.Hit(EventId.TemporaryBlockInput, 0.2)
  end
end

function Avg_6_MenuCtrl:OnBtn_Skip(btn)
  if self._panel._nPanelId == PanelId.AvgEditor then
    return
  end
  if self.bAutoPlayOn == true then
    self.bAutoPlayOn = false
    self:SetAutoPlayOnOff()
  end
  if self.nSpeedIdx ~= 1 then
    self.nSpeedIdx = 1
    self:SetSpeedUp()
  end
  EventManager.Hit(EventId.AvgSkipCheck)
  WwiseAudioMgr:PlaySound("ui_common_menu3")
end

function Avg_6_MenuCtrl:OnBtn_UIOnOff(btn)
  self.bUIOn = not self.bUIOn
  self:SetUIOnOff()
  if self.bAutoPlayOn == true then
    self.bAutoPlayOn = false
    self:SetAutoPlayOnOff()
  end
  if self.nSpeedIdx ~= 1 then
    self.nSpeedIdx = 1
    self:SetSpeedUp()
  end
  WwiseAudioMgr:PlaySound("ui_common_button_next")
end

function Avg_6_MenuCtrl:OnBtn_LogOnOff(btn)
  if self.bAutoPlayOn == true then
    self.bAutoPlayOn = false
    self:SetAutoPlayOnOff()
  end
  if self.nSpeedIdx ~= 1 then
    self.nSpeedIdx = 1
    self:SetSpeedUp()
  end
  self.bLogOn = not self.bLogOn
  EventManager.Hit(EventId.AvgShowHideLog, self.bLogOn)
  WwiseAudioMgr:PlaySound("ui_common_menu3")
end

function Avg_6_MenuCtrl:OnBtn_FoldMenu(btn)
  self.bUnfoldMenu = not self.bUnfoldMenu
  local sSound = self.bUnfoldMenu and "ui_common_menu_open" or "ui_common_menu_close"
  WwiseAudioMgr:PlaySound(sSound)
  self:UnfoldMenu()
end

function Avg_6_MenuCtrl:OnBtn_AutoPlayOnOff(btn)
  self.bAutoPlayOn = not self.bAutoPlayOn
  self:SetAutoPlayOnOff()
  if self.bUIOn == false then
    self.bUIOn = true
    self:SetUIOnOff()
  end
  if self.bAutoPlayOn == false and self.nSpeedIdx ~= 1 then
    self.nSpeedIdx = 1
    self:SetSpeedUp()
  end
  WwiseAudioMgr:PlaySound("ui_common_button")
end

function Avg_6_MenuCtrl:OnBtn_SpeedUp(btn)
  self.nSpeedIdx = self.nSpeedIdx + 1
  if self.nSpeedIdx > #self.tbSpeed then
    self.nSpeedIdx = 1
  end
  self:SetSpeedUp()
  if self.nSpeedIdx ~= 1 then
    if self.bAutoPlayOn == false then
      self.bAutoPlayOn = true
      self:SetAutoPlayOnOff()
    end
    if self.bUIOn == false then
      self.bUIOn = true
      self:SetUIOnOff()
    end
  end
  WwiseAudioMgr:PlaySound("ui_common_button_next")
end

function Avg_6_MenuCtrl:OnEvent_AvgAllMenuBtnEnable(bEnable)
  self.bALL = bEnable == true
  self:_ResetAllMenuBtn()
end

function Avg_6_MenuCtrl:OnEvent_AvgShowHideLog(bLogOn)
  self.bLogOn = bLogOn
  if self.bLogOn == true then
    DOTween.PauseAll()
    EventManager.Hit(EventId.DoTweenPauseAll)
    self.bALL = false
  else
    DOTween.PlayAll()
    self.bALL = true
  end
  self:_ResetAllMenuBtn()
end

function Avg_6_MenuCtrl:OnEvent_AvgLogBtnEnable(bEnable)
  self.bUILog = bEnable == true
  self:_ResetAllMenuBtn()
end

function Avg_6_MenuCtrl:OnEvent_AvgSpeedUp(nRate)
  if self:GetPanelId() ~= PanelId.AvgST then
    return
  end
  self:OnEvent_AvgSpeedUp_Timer(nRate)
  NovaAPI.SetAnimatorSpeed(self._mapNode.aniTime, nRate)
  NovaAPI.SetAnimatorSpeed(self._mapNode.acWindow, nRate)
  NovaAPI.SetAnimatorSpeed(self._mapNode.animChar, nRate)
end

function Avg_6_MenuCtrl:OnEvent_AvgResetSpeed(bReset)
  if self:GetPanelId() ~= PanelId.AvgST then
    return
  end
  if bReset == true then
    self.nSpeedIdx = 1
    self:SetSpeedUp()
    self.bSetSpeed = false
  else
    self.bSetSpeed = true
  end
  self:_ResetAllMenuBtn()
end

function Avg_6_MenuCtrl:OnEvent_AvgRefreshActionBar(tbAddConfig)
  self.bOpenActionBar = true
  self.tbAddConfig = tbAddConfig
  self:RefreshActionBar()
end

function Avg_6_MenuCtrl:OnEvent_CheckAutoOnOff()
  NovaAPI.SetScreenSleepTimeout(self.bAutoPlayOn == true)
end

function Avg_6_MenuCtrl:SetSceneHeading(tbParam)
  self.bALL = false
  self:_ResetAllMenuBtn()
  local sTime = tbParam[1]
  NovaAPI.SetTMPText(self._mapNode.txtTime1, sTime)
  NovaAPI.SetTMPText(self._mapNode.txtDay1, tbParam[2])
  NovaAPI.SetTMPText(self._mapNode.txtDay2, tbParam[3])
  NovaAPI.SetTMPText(self._mapNode.txtPos1, tbParam[4])
  NovaAPI.SetTMPText(self._mapNode.txtPos2, tbParam[5])
  self._mapNode.goTimeHeading:SetActive(true)
  self._mapNode.aniTime:Play("time_in")
  self:AddTimer(1, self.nTimeHeadingDuration + 0.5, "_DelayHideHeading", true, true, true, true)
  return self.nTimeHeadingDuration or 0
end

function Avg_6_MenuCtrl:_DelayHideHeading()
  self._mapNode.goTimeHeading:SetActive(false)
  self.bALL = true
  self:_ResetAllMenuBtn()
end

function Avg_6_MenuCtrl:SetIntro(tbParam)
  local sAvgId = self._panel.sAvgId
  if self.mapIntroData[sAvgId] == nil then
    self.mapIntroData[sAvgId] = tbParam
  end
  return 0
end

function Avg_6_MenuCtrl:_DOSetIntro(tbParam)
  local sIcon = tbParam[1]
  local sTitle = tbParam[2]
  local sName = tbParam[3]
  local sContent = tbParam[4]
  local bShowTips_BE = tbParam[5] == 1
  sContent = ProcAvgTextContent(sContent, self._panel.nCurLanguageIdx)
  NovaAPI.SetTMPText(self._mapNode.txtStoryId, sTitle)
  NovaAPI.SetTMPText(self._mapNode.txtStoryTitle, sName)
  NovaAPI.SetText_RubyTMP(self._mapNode.rubyTmpContent, sContent)
  local nLanguageIndex = self._panel.nCurLanguageIdx
  local AvgUIText = require(GetAvgLuaRequireRoot(nLanguageIndex) .. "Preset/AvgUIText")
  local sSkipTips = AvgUIText.SkipTips
  if bShowTips_BE == true then
    sSkipTips = AvgUIText.SkipBETips
  end
  NovaAPI.SetTMPText(self._mapNode.txtSkipTips, ProcAvgTextContent(sSkipTips))
  self.bALL = false
  self:_ResetAllMenuBtn()
end

function Avg_6_MenuCtrl:OnBtn_ConfirmIntro(btn)
  self._mapNode.acWindow:Play("t_window_04_t_out")
  self:AddTimer(1, 0.3, "_delayProcIntro", true, true, true, false)
  DOTween.PlayAll()
  EventManager.Hit(EventId.AvgSkip)
end

function Avg_6_MenuCtrl:OnBtn_CloseIntro(btn)
  DOTween.PlayAll()
  EventManager.Hit(EventId.AvgTryResume)
  EventManager.Hit(EventId.TemporaryBlockInput, 0.3)
  self._mapNode.acWindow:Play("t_window_04_t_out")
  self:AddTimer(1, 0.3, "_delayProcIntro", true, true, true, false)
  self.bALL = true
  self:_ResetAllMenuBtn()
end

function Avg_6_MenuCtrl:_delayProcIntro(timer, param)
  if param == true then
    GamepadUIManager.EnableGamepadUI("AVG_Intro", self.tbIntroNode)
    self._mapNode.acWindow:Play("t_window_04_t_in")
  else
    self._mapNode.goRootIntro:SetActive(false)
    GamepadUIManager.DisableGamepadUI("AVG_Intro")
  end
end

function Avg_6_MenuCtrl:OnEvent_AvgSkipCheckIntro()
  if self._panel._nPanelId == PanelId.AvgEditor then
    return
  end
  local sAvgId = self._panel.sAvgId
  local tbParam = self.mapIntroData[sAvgId]
  if tbParam ~= nil then
    self:_DOSetIntro(tbParam)
    DOTween.PauseAll()
    EventManager.Hit(EventId.TemporaryBlockInput, 0.4)
    EventManager.Hit(EventId.DoTweenPauseAll)
    NovaAPI.SetCanvasGroupAlpha(self._mapNode.cgWindow, 0)
    self._mapNode.goRootIntro:SetActive(true)
    self:AddTimer(1, 0.1, "_delayProcIntro", true, true, true, true)
  else
    EventManager.Hit(EventId.AvgSkip)
  end
end

function Avg_6_MenuCtrl:NewCharIntro(tbParam)
  self.bALL = false
  self:_ResetAllMenuBtn()
  self._mapNode.Camera.enabled = true
  local sAvgCharId = tbParam[1]
  local sName = tbParam[2]
  local sTitle = tbParam[3]
  local sBody = tbParam[4]
  local sFace = tbParam[5]
  local nPosX = tbParam[6] or 0
  local nPosY = tbParam[7] or 0
  local nScale = tbParam[8] or 1
  local sAnimName = "animNewCharIntro_" .. tostring(tbParam[9])
  local sResAvgCharId = self._panel:GetAvgCharReuseRes(sAvgCharId)
  local spBody, spFace, v3OffsetPos, v3OffsetScale, spBlackBody = self:GetAvgPortrait(sResAvgCharId, sBody, sFace)
  NovaAPI.SetSpriteRendererSprite(self._mapNode.sprBody, spBody)
  NovaAPI.SetSpriteRendererSprite(self._mapNode.sprFace, spFace)
  self._mapNode.rtRawImgChar.anchoredPosition3D = Vector3(v3OffsetPos.x, v3OffsetPos.y - Settings.DESIGN_SCREEN_RESOLUTION_HEIGHT * 0.5, 0)
  self._mapNode.rtRawImgChar.localScale = v3OffsetScale
  self._mapNode.rtCharXYS.anchoredPosition = Vector2(nPosX, nPosY)
  self._mapNode.rtCharXYS.localScale = Vector3(nScale, nScale, nScale)
  if self.RT == nil then
    local n = math.floor(2048 * Settings.RENDERTEXTURE_SIZE_FACTOR)
    self.RT = GameUIUtils.GenerateRenderTextureFor2D(n, n)
    self.RT.name = "Avg6NewChar"
    self._mapNode.Camera.targetTexture = self.RT
    NovaAPI.SetTexture(self._mapNode.rawImgChar, self.RT)
  end
  NovaAPI.SetTMPText(self._mapNode.tmpRoleName, sName)
  NovaAPI.SetTMPText(self._mapNode.tmpRoleTitle, sTitle)
  self._mapNode.animChar:Play(sAnimName, 0, 0)
  local nDuration = NovaAPI.GetAnimClipLength(self._mapNode.animChar, {sAnimName})
  self:AddTimer(1, nDuration, "_delayHideNewChar", true, true, true, true)
  WwiseAudioMgr:PlaySound("ui_avg_charInfo")
  EventManager.Hit(EventId.TemporaryBlockInput, nDuration)
  return nDuration - 0.2
end

function Avg_6_MenuCtrl:_delayHideNewChar()
  self._mapNode.Camera.enabled = false
  self.bALL = true
  self:_ResetAllMenuBtn()
end

function Avg_6_MenuCtrl:RestoreAll(bActive)
  self.gameObject:SetActive(bActive == true)
  NovaAPI.SetCanvasGroupAlpha(self._mapNode.cgNewCharIntro, 0)
end

function Avg_6_MenuCtrl:InitActionBarConfig()
  self.tbGamepadUINode = {
    [1] = {
      mapNode = self._mapNode.btnSkip,
      sComponentName = "NaviButton",
      sAction = "Skip"
    },
    [2] = {
      mapNode = self._mapNode.btnUIOnOff,
      sComponentName = "NaviButton",
      sAction = "Hide"
    },
    [3] = {
      mapNode = self._mapNode.btnLogOnOff,
      sComponentName = "NaviButton",
      sAction = "Log"
    },
    [4] = {
      mapNode = self._mapNode.btnFoldMenu,
      sComponentName = "NaviButton",
      sAction = "Menu"
    },
    [5] = {
      mapNode = self._mapNode.btnAutoPlayOnOff,
      sComponentName = "NaviButton",
      sAction = "Auto"
    },
    [6] = {
      mapNode = self._mapNode.btnSpeedUp,
      sComponentName = "NaviButton",
      sAction = "FastForward"
    }
  }
  self.tbIntroNode = {
    [1] = {
      mapNode = self._mapNode.btnCancel,
      sComponentName = "NaviButton",
      sAction = "Back",
      sActionIconType = "Dark"
    },
    [2] = {
      mapNode = self._mapNode.btnConfirm1,
      sComponentName = "NaviButton",
      sAction = "Confirm",
      sActionIconType = "Dark"
    }
  }
  self.tbOnActionBarConfig = {}
  self.tbOffActionBarConfig = {}
end

function Avg_6_MenuCtrl:AddGamepadUINode()
  GamepadUIManager.AddGamepadUINode("AVG", self.tbGamepadUINode)
end

function Avg_6_MenuCtrl:RefreshActionBar()
  if self.bOpenActionBar then
    local tbConfig = clone(self.bUnfoldMenu and self.tbOnActionBarConfig or self.tbOffActionBarConfig)
    if self.tbAddConfig then
      for _, v in ipairs(self.tbAddConfig) do
        table.insert(tbConfig, v)
      end
    end
    self._mapNode.ActionBar:InitActionBar(tbConfig)
  else
    self._mapNode.ActionBar:ClearActionBar()
  end
end

function Avg_6_MenuCtrl:CheckGamepadBlock()
  if not self._panel.sCurGamepadUI or self._panel.sCurGamepadUI == "MajorChoice" or self._panel.sCurGamepadUI == "PersonalityChoice" then
    return true
  end
  return false
end

return Avg_6_MenuCtrl
