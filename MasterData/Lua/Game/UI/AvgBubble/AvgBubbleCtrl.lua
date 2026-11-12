local LayoutRebuilder = CS.UnityEngine.UI.LayoutRebuilder
local WwiseAudioMgr = CS.WwiseAudioManager.Instance
local GameResourceLoader = require("Game.Common.Resource.GameResourceLoader")
local ResType = GameResourceLoader.ResType
local BubbleVoiceManager = require("Game.Actor2D.BubbleVoiceManager")
local AvgBubbleCtrl = class("AvgBubbleCtrl", BaseCtrl)
AvgBubbleCtrl._mapNodeConfig = {
  cg1 = {
    sNodeName = "--Style_1--",
    sComponentName = "CanvasGroup"
  },
  TMP = {
    sComponentName = "RubyTextMeshProUGUI"
  },
  rtTMP = {
    sNodeName = "TMP",
    sComponentName = "RectTransform"
  },
  LSV = {
    sComponentName = "LoopScrollView"
  },
  cg2 = {
    sNodeName = "--Style_2--",
    sComponentName = "CanvasGroup"
  },
  txtName = {
    sComponentName = "RubyTextMeshProUGUI"
  },
  tmp_Content = {
    sComponentName = "RubyTextMeshProUGUI"
  },
  cgContent = {
    sNodeName = "tmp_Content",
    sComponentName = "CanvasGroup"
  },
  cg3 = {
    sNodeName = "--Style_3--",
    sComponentName = "CanvasGroup"
  },
  img_head = {sComponentName = "Image"},
  tmp_SpeakerName = {
    sComponentName = "RubyTextMeshProUGUI"
  },
  tmp_Content3 = {
    sComponentName = "RubyTextMeshProUGUI"
  },
  cgContent3 = {
    sNodeName = "tmp_Content3",
    sComponentName = "CanvasGroup"
  },
  trRoot = {
    sNodeName = "----SafeAreaRoot----",
    sComponentName = "Transform"
  },
  trStyleRoot_1 = {
    sNodeName = "--Style_1--",
    sComponentName = "Transform"
  },
  trStyleRoot_2 = {
    sNodeName = "--Style_2--",
    sComponentName = "Transform"
  },
  trStyleRoot_3 = {
    sNodeName = "--Style_3--",
    sComponentName = "Transform"
  }
}
AvgBubbleCtrl._mapEventConfig = {
  [EventId.AvgBubbleShutDown] = "CloseBubble",
  [EventId.PasueAvgBubble] = "OnEvent_Pause"
}

function AvgBubbleCtrl:OnEnable()
  self.tbRawIndex = {}
  self.tbEachGridHeight = {}
  self.tbEachGridBgWidth = {}
  self.nCurRawDataIndex = 0
  self.nAllCount = #self._panel.tbAvgBBCmdCfg
  self.nTIME = 0
  self.timer = nil
  self.v3Scale = Vector3(0.8, 0.8, 0.8)
  self.sAvgId = self._panel.sAvgId
  self.sGroupId = self._panel.sGroupId
  self.bRun = true
  self.bPause = false
  if self._panel.nBubbleType == 1 then
    EventManager.Hit(EventId.MoveAvgBubbleRoot, self._mapNode.trStyleRoot_1)
    NovaAPI.SetCanvasGroupAlpha(self._mapNode.cg1, 1)
    self:PopupBubble()
  elseif self._panel.nBubbleType == 2 then
    EventManager.Hit(EventId.MoveAvgBubbleRoot, self._mapNode.trStyleRoot_2)
    self._mapNode.cg2:DOFade(1, 0.2):SetUpdate(true)
    self:ShowAvgBubbleInPrologue()
  elseif self._panel.nBubbleType == 3 then
    EventManager.Hit(EventId.MoveAvgBubbleRoot, self._mapNode.trStyleRoot_3)
    self:PopupBubble3()
  end
end

function AvgBubbleCtrl:OnDisable()
  if self.bRun == true then
    self:CloseBubble(true)
  end
end

function AvgBubbleCtrl:_GetAvgCharName(sAvgCharId)
  if self.tbAvgCharacter == nil then
    self.sAvgCharacterPath = GetAvgLuaRequireRoot(self._panel.nCurLanguageIdx) .. "Preset/AvgCharacter"
    local tbAvgChar = require(self.sAvgCharacterPath)
    self.tbAvgCharacter = {}
    for i, v in ipairs(tbAvgChar) do
      self.tbAvgCharacter[v.id] = v.name
    end
  end
  local sName = self.tbAvgCharacter[sAvgCharId]
  if type(sName) == "string" then
    return sName
  else
    return sAvgCharId
  end
end

function AvgBubbleCtrl:_ClearAvgCharName()
  if self.tbAvgCharacter ~= nil and self.sAvgCharacterPath ~= nil then
    self.tbAvgCharacter = nil
    package.loaded[self.sAvgCharacterPath] = nil
    self.sAvgCharacterPath = nil
  end
end

function AvgBubbleCtrl:CloseBubble(bCovered)
  self.bRun = false
  if self.timer ~= nil then
    self.timer:Cancel()
    self.timer = nil
  end
  if self.sequence ~= nil then
    self.sequence:Kill()
    self.sequence = nil
  end
  WwiseAudioMgr:WwiseVoice_StopInAVG()
  if bCovered == true then
    self:EndAvgBubble(true)
  else
    self._mapNode.cg1:DOFade(0, 0.2):SetUpdate(true)
    self._mapNode.cg2:DOFade(0, 0.2):SetUpdate(true)
    self._mapNode.cg3:DOFade(0, 0.2):SetUpdate(true)
    self:AddTimer(1, 0.2, "EndAvgBubble", true, true, true)
  end
  self:_ClearAvgCharName()
end

function AvgBubbleCtrl:EndAvgBubble(bCovered)
  if self._panel.nBubbleType == 1 then
    if self._mapNode.trStyleRoot_1 ~= nil and self._mapNode.trStyleRoot_1:IsNull() == false then
      self._mapNode.trStyleRoot_1:SetParent(self._mapNode.trRoot)
    end
  elseif self._panel.nBubbleType == 2 then
    if self._mapNode.trStyleRoot_2 ~= nil and self._mapNode.trStyleRoot_2:IsNull() == false then
      self._mapNode.trStyleRoot_2:SetParent(self._mapNode.trRoot)
    end
  elseif self._panel.nBubbleType == 3 and self._mapNode.trStyleRoot_3 ~= nil and self._mapNode.trStyleRoot_3:IsNull() == false then
    self._mapNode.trStyleRoot_3:SetParent(self._mapNode.trRoot)
  end
  if bCovered ~= true then
    EventManager.Hit(EventId.AvgBubbleExit)
  end
  NovaAPI.DispatchEventWithData("AVG_BB_END", nil, string.format("%s|%s", self.sAvgId, tostring(self.sGroupId)))
end

function AvgBubbleCtrl:OnEvent_Pause(bPause)
  self.bPause = bPause
  if self.bPause == true then
  elseif self.timer == nil then
    local tb = {
      "PopupBubble",
      "ShowAvgBubbleInPrologue",
      "PopupBubble3"
    }
    local sFuncName = tb[self._panel.nBubbleType]
    local func = self[sFuncName]
    if type(func) == "function" then
      func(self)
    end
  end
end

function AvgBubbleCtrl:PopupBubble()
  self.nCurRawDataIndex = self.nCurRawDataIndex + 1
  if self.nCurRawDataIndex > self.nAllCount then
    self:CloseBubble()
    return
  end
  local data = self._panel.tbAvgBBCmdCfg[self.nCurRawDataIndex]
  local sContent = ProcAvgTextContentFallback(self._panel.sTxtLan, self._panel.sVoLan, self._panel.bIsPlayerMale, data.param[3], data.param[6], data.param[9], data.param[10])
  sContent = ProcAvgTextContent(sContent, self._panel.nCurLanguageIdx)
  local sVoiceName = data.param[5]
  local nW, nH = self:_CalcWidthAndHeight(sContent)
  table.insert(self.tbEachGridBgWidth, 1, nW)
  table.insert(self.tbEachGridHeight, 1, nH)
  table.insert(self.tbRawIndex, 1, self.nCurRawDataIndex)
  self._mapNode.LSV:InitAvgBubble(self.tbEachGridHeight, self, self.RefreshBubbleGrid)
  if type(sVoiceName) == "string" and sVoiceName ~= "" then
    WwiseAudioMgr:WwiseVoice_PlayInAVG(sVoiceName)
  else
    self.nTIME = CalcTextAnimDuration(sContent, self._panel.nCurLanguageIdx, true)
    if self.timer ~= nil then
      self.timer:Cancel()
      self.timer = nil
    end
    self.timer = self:AddTimer(1, self.nTIME, "PopupBubble", true, false, true)
  end
end

function AvgBubbleCtrl:RefreshBubbleGrid(goGrid, gridIndex)
  local nLayoutIndex = gridIndex
  if nLayoutIndex == nil then
    return
  end
  nLayoutIndex = nLayoutIndex + 1
  local nRawDataIndex = self.tbRawIndex[nLayoutIndex]
  local paramData = self._panel.tbAvgBBCmdCfg[nRawDataIndex].param
  local trScale = goGrid.transform:GetChild(0)
  if 2 < nLayoutIndex then
    trScale.localScale = self.v3Scale
  elseif nLayoutIndex < 2 then
    trScale.localScale = Vector3.one
  else
    trScale.localScale = Vector3.one
    trScale:DOScale(self.v3Scale, 0.2):SetUpdate(true)
  end
  local cgScale = trScale:GetComponent("CanvasGroup")
  if 3 < nLayoutIndex then
    NovaAPI.SetCanvasGroupAlpha(cgScale, 0)
  elseif nLayoutIndex < 3 then
    NovaAPI.SetCanvasGroupAlpha(cgScale, 1)
  else
    NovaAPI.SetCanvasGroupAlpha(cgScale, 1)
    cgScale:DOFade(0, 0.2):SetUpdate(true)
  end
  self:SetAvgCharHeadIcon(trScale:Find("imgSpeaker"):GetComponent("Image"), AdjustMainRoleAvgCharId(paramData[1]), paramData[2])
  local trTMP = trScale:Find("rubyTmp")
  local sContent = ProcAvgTextContentFallback(self._panel.sTxtLan, self._panel.sVoLan, self._panel.bIsPlayerMale, paramData[3], paramData[6], paramData[9], paramData[10])
  sContent = ProcAvgTextContent(sContent, self._panel.nCurLanguageIdx)
  NovaAPI.SetText_RubyTMP(trTMP:GetComponent("RubyTextMeshProUGUI"), ProcAvgTextContent(sContent, self._panel.nCurLanguageIdx))
  local rtTMP = trTMP:GetComponent("RectTransform")
  LayoutRebuilder.ForceRebuildLayoutImmediate(rtTMP)
  local nH = self.tbEachGridHeight[nLayoutIndex]
  trScale:Find("imgBg"):GetComponent("RectTransform").sizeDelta = Vector2(self.tbEachGridBgWidth[nLayoutIndex], nH - 4)
  goGrid:GetComponent("RectTransform").sizeDelta = Vector2(800, nH)
end

function AvgBubbleCtrl:_CalcWidthAndHeight(sContent)
  local nBgWidth = 0
  local nGridHeight = 0
  NovaAPI.SetText_RubyTMP(self._mapNode.TMP, sContent)
  LayoutRebuilder.ForceRebuildLayoutImmediate(self._mapNode.rtTMP)
  nBgWidth = self._mapNode.rtTMP.rect.width + 88
  if self._mapNode.rtTMP.rect.height > 100 then
    nGridHeight = self._mapNode.rtTMP.rect.height + 40
  end
  if nBgWidth < 120 then
    nBgWidth = 120
  end
  if nGridHeight < 110 then
    nGridHeight = 110
  end
  return nBgWidth, nGridHeight
end

function AvgBubbleCtrl:_ParseBBHeadIcon(sParam1)
  local sIcon = sParam1
  if string.find(sParam1, "_BB_") == nil then
    sIcon = sParam1 .. "_BB_001"
  end
  local tb = string.split(sIcon, "_BB_")
  return tb[1], tb[2]
end

function AvgBubbleCtrl:ShowAvgBubbleInPrologue()
  self.nCurRawDataIndex = self.nCurRawDataIndex + 1
  if self.nCurRawDataIndex > self.nAllCount then
    self:CloseBubble()
    return
  end
  local paramData = self._panel.tbAvgBBCmdCfg[self.nCurRawDataIndex].param
  NovaAPI.SetText_RubyTMP(self._mapNode.txtName, self:_GetAvgCharName(paramData[1]))
  local sContent = ProcAvgTextContentFallback(self._panel.sTxtLan, self._panel.sVoLan, self._panel.bIsPlayerMale, paramData[3], paramData[6], paramData[9], paramData[10])
  sContent = ProcAvgTextContent(sContent, self._panel.nCurLanguageIdx)
  local sVoiceName = paramData[5]
  NovaAPI.SetText_RubyTMP(self._mapNode.tmp_Content, sContent)
  NovaAPI.SetCanvasGroupAlpha(self._mapNode.cgContent, 0)
  self._mapNode.cgContent:DOFade(1, 0.3):SetUpdate(true)
  if type(sVoiceName) == "string" and sVoiceName ~= "" then
    WwiseAudioMgr:WwiseVoice_PlayInAVG(sVoiceName)
  else
    self.nTIME = CalcTextAnimDuration(sContent, self._panel.nCurLanguageIdx, true)
    if self.timer ~= nil then
      self.timer:Cancel()
      self.timer = nil
    end
    self.timer = self:AddTimer(1, self.nTIME, "ShowAvgBubbleInPrologue", true, false, true)
  end
end

function AvgBubbleCtrl:PopupBubble3()
  if self.timer ~= nil then
    self.timer:Cancel()
    self.timer = nil
  end
  if self.bPause == true then
    return
  end
  self.nCurRawDataIndex = self.nCurRawDataIndex + 1
  if self.nCurRawDataIndex > self.nAllCount then
    self:CloseBubble()
    return
  end
  local param = self._panel.tbAvgBBCmdCfg[self.nCurRawDataIndex].param
  local sAvgCharId = param[1]
  local sResName = sAvgCharId
  sAvgCharId, sResName = self:_ParseBBHeadIcon(sAvgCharId)
  sAvgCharId = AdjustMainRoleAvgCharId(sAvgCharId)
  local sContent = ProcAvgTextContentFallback(self._panel.sTxtLan, self._panel.sVoLan, self._panel.bIsPlayerMale, param[3], param[6], param[9], param[10])
  sContent = ProcAvgTextContent(sContent, self._panel.nCurLanguageIdx)
  local sVoiceName = param[5]
  local sSpName = param[7]
  local sName
  if type(sSpName) == "string" and sSpName ~= "" then
    sName = sSpName
  elseif sAvgCharId == "avg3_100" or sAvgCharId == "avg3_101" then
    sName = PlayerData.Base:GetPlayerNickName()
  else
    sName = self:_GetAvgCharName(sAvgCharId)
  end
  local bShadowMask = param[8] == 1
  
  local function func_ReSetBubble()
    local sFullPath = string.format("Icon/AvgHead/%s/%s_BB_%s.png", sAvgCharId, sAvgCharId, sResName)
    local _sprite = GameResourceLoader.LoadAsset(ResType.Any, Settings.AB_ROOT_PATH .. sFullPath, typeof(Sprite), "UI", self._panel._nPanelId)
    NovaAPI.SetImageSpriteAsset(self._mapNode.img_head, _sprite)
    NovaAPI.SetEnable_Gradient2(self._mapNode.img_head.gameObject, bShadowMask)
    NovaAPI.SetText_RubyTMP(self._mapNode.tmp_SpeakerName, sName)
    NovaAPI.SetText_RubyTMP(self._mapNode.tmp_Content3, sContent)
  end
  
  self.sequence = DOTween.Sequence()
  local bSameSpeaker = self.sPreSpeakerAvgCharId == sAvgCharId
  if bSameSpeaker == true then
    NovaAPI.SetCanvasGroupAlpha(self._mapNode.cg3, 1)
    self.sequence:Append(self._mapNode.cgContent3:DOFade(0, 0.2):SetUpdate(true))
    self.sequence:AppendCallback(dotween_callback_handler(self, func_ReSetBubble))
    self.sequence:Append(self._mapNode.cgContent3:DOFade(1, 0.2):SetUpdate(true))
  else
    NovaAPI.SetCanvasGroupAlpha(self._mapNode.cgContent3, 1)
    self.sequence:Append(self._mapNode.cg3:DOFade(0, 0.2):SetUpdate(true))
    self.sequence:AppendCallback(dotween_callback_handler(self, func_ReSetBubble))
    self.sequence:Append(self._mapNode.cg3:DOFade(1, 0.2):SetUpdate(true))
  end
  
  local function cb()
    self.sequence = nil
  end
  
  self.sequence.onComplete = dotween_callback_handler(self, cb)
  self.sequence:SetUpdate(true)
  self.sPreSpeakerAvgCharId = sAvgCharId
  if type(sVoiceName) == "string" and sVoiceName ~= "" then
    WwiseAudioMgr:WwiseVoice_PlayInAVG(sVoiceName)
    self.nTIME = BubbleVoiceManager.GetVoResLen(sVoiceName) + 0.5
    self.timer = self:AddTimer(1, self.nTIME, "PopupBubble3", true, false, true)
  else
    self.nTIME = CalcTextAnimDuration(sContent, self._panel.nCurLanguageIdx, true)
    self.timer = self:AddTimer(1, self.nTIME, "PopupBubble3", true, false, true)
  end
end

return AvgBubbleCtrl
