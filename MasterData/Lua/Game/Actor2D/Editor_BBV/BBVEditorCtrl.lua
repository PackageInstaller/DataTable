local BBVEditorCtrl = class("BBVEditorCtrl", BaseCtrl)
local BubbleVoiceManager = require("Game.Actor2D.BubbleVoiceManager")
local Actor2DManager = require("Game.Actor2D.Actor2DManager")
BBVEditorCtrl._mapNodeConfig = {
  rawImage = {
    sNodeName = "----Actor2D----",
    sComponentName = "RawImage"
  },
  ipt_SrcContent = {sComponentName = "InputField"},
  dd_PlayerSex = {
    sComponentName = "Dropdown",
    callback = "OnDD_PlayerSex"
  },
  dd_Language_Vo = {
    sComponentName = "Dropdown",
    callback = "OnDD_SwitchVoLan"
  },
  dd_Language_Txt = {
    sComponentName = "Dropdown",
    callback = "OnDD_SwitchTxtLan"
  },
  btn_SaveSplitContent = {},
  btn_UseCn_Time = {
    sComponentName = "Button",
    callback = "OnBtn_ReuseCnTime"
  },
  btn_UseCn_Anim = {
    sComponentName = "Button",
    callback = "OnBtn_ReuseCnAnim"
  },
  btn_UseJp_Time = {
    sComponentName = "Button",
    callback = "OnBtn_ReuseJpTime"
  },
  btn_UseJp_Anim = {
    sComponentName = "Button",
    callback = "OnBtn_ReuseJpAnim"
  },
  btn_SaveByDefault = {
    sComponentName = "Button",
    callback = "OnBtn_SaveNewDataByDefault"
  },
  dd_VoResName = {sComponentName = "Dropdown"},
  btn_Back = {sComponentName = "Button", callback = "OnBtn_Back"},
  tog_CnM = {sComponentName = "Toggle"},
  tog_CnF = {sComponentName = "Toggle"},
  tog_JpM = {sComponentName = "Toggle"},
  CnMText = {nCount = 4, sComponentName = "InputField"},
  CnMTextFallback = {nCount = 4, sComponentName = "Text"},
  CnMTime = {nCount = 4, sComponentName = "InputField"},
  CnMTimeFallback = {nCount = 4, sComponentName = "Text"},
  CnMTimeSnip = {
    nCount = 4,
    sComponentName = "Button",
    callback = "OnTimeSnip_CnM"
  },
  CnMAnim = {nCount = 4, sComponentName = "Dropdown"},
  CnFText = {nCount = 4, sComponentName = "InputField"},
  CnFTextFallback = {nCount = 4, sComponentName = "Text"},
  CnFTime = {nCount = 4, sComponentName = "InputField"},
  CnFTimeFallback = {nCount = 4, sComponentName = "Text"},
  CnFTimeSnip = {
    nCount = 4,
    sComponentName = "Button",
    callback = "OnTimeSnip_CnF"
  },
  CnFAnim = {nCount = 4, sComponentName = "Dropdown"},
  JpMText = {nCount = 4, sComponentName = "InputField"},
  JpMTextFallback = {nCount = 4, sComponentName = "Text"},
  JpMTime = {nCount = 4, sComponentName = "InputField"},
  JpMTimeFallback = {nCount = 4, sComponentName = "Text"},
  JpMTimeSnip = {
    nCount = 4,
    sComponentName = "Button",
    callback = "OnTimeSnip_JpM"
  },
  JpMAnim = {nCount = 4, sComponentName = "Dropdown"},
  JpFText = {nCount = 4, sComponentName = "InputField"},
  JpFTextFallback = {nCount = 4, sComponentName = "Text"},
  JpFTime = {nCount = 4, sComponentName = "InputField"},
  JpFTimeFallback = {nCount = 4, sComponentName = "Text"},
  JpFTimeSnip = {
    nCount = 4,
    sComponentName = "Button",
    callback = "OnTimeSnip_JpF"
  },
  JpFAnim = {nCount = 4, sComponentName = "Dropdown"},
  goBubbleRoot = {
    sNodeName = "----bubble----"
  },
  rtBubbleRoot = {
    sNodeName = "----bubble----",
    sComponentName = "RectTransform"
  },
  dd_BBLeftRight = {sComponentName = "Dropdown"},
  tmp_CurVosResLen = {sComponentName = "TMP_Text"},
  sld_Progress = {sComponentName = "Slider"},
  dd_Speed = {
    sComponentName = "Dropdown",
    callback = "OnDD_SpeedChanged"
  }
}
BBVEditorCtrl._mapEventConfig = {
  BBVE_SetTextTime = "onEvent_SetTextTime",
  BBVE_SaveTextTime = "onEvent_SaveTextTime",
  BBVE_SetCharL2D = "onEvent_SetCharL2D",
  BBVE_SaveOffset = "onEvent_SaveOffset",
  BBVE_Play = "onEvent_Play",
  BBVE_Stop = "onEvent_Stop",
  BBVE_Pause = "onEvent_Pause",
  BBVE_Resume = "onEvent_Resume",
  BBVE_CheckNewData = "onEvent_CheckNewData"
}

function BBVEditorCtrl:OnEnable()
  if Settings.sCurrentTxtLanguage == AllEnum.Language.CN then
    NovaAPI.SetToggleIsOn(self._mapNode.tog_CnF, true)
    NovaAPI.SetToggleInteractable(self._mapNode.tog_CnM, false)
    NovaAPI.SetToggleInteractable(self._mapNode.tog_JpM, false)
    for i = 1, 4 do
      self._mapNode.JpFAnim[i].gameObject:SetActive(false)
    end
  else
    if Settings.sCurrentTxtLanguage == AllEnum.Language.JP then
      NovaAPI.SetToggleInteractable(self._mapNode.tog_CnM, false)
      NovaAPI.SetToggleInteractable(self._mapNode.tog_CnF, false)
    else
    end
  end
  local ListString = CS.System.Collections.Generic.List(CS.System.String)
  local listLanguage = ListString()
  for i, v in ipairs(AllEnum.LanguageInfo) do
    listLanguage:Add(v[2])
  end
  NovaAPI.ClearDropDownOptions(self._mapNode.dd_Language_Vo)
  NovaAPI.DropDownAddOptions(self._mapNode.dd_Language_Vo, listLanguage)
  NovaAPI.SetDDValueWithoutNotify(self._mapNode.dd_Language_Vo, GetLanguageIndex(Settings.sCurrentVoLanguage) - 1)
  self.mapText = {
    male_cn = self._mapNode.CnMText,
    female_cn = self._mapNode.CnFText,
    male_jp = self._mapNode.JpMText,
    female_jp = self._mapNode.JpFText
  }
  self.mapTextFallback = {
    male_cn = self._mapNode.CnMTextFallback,
    female_cn = self._mapNode.CnFTextFallback,
    male_jp = self._mapNode.JpMTextFallback,
    female_jp = self._mapNode.JpFTextFallback
  }
  self.mapTime = {
    male_cn = self._mapNode.CnMTime,
    female_cn = self._mapNode.CnFTime,
    male_jp = self._mapNode.JpMTime,
    female_jp = self._mapNode.JpFTime
  }
  self.mapTimeFallback = {
    male_cn = self._mapNode.CnMTimeFallback,
    female_cn = self._mapNode.CnFTimeFallback,
    male_jp = self._mapNode.JpMTimeFallback,
    female_jp = self._mapNode.JpFTimeFallback
  }
  self.mapAnim = {
    male_cn = self._mapNode.CnMAnim,
    female_cn = self._mapNode.CnFAnim,
    male_jp = self._mapNode.JpMAnim,
    female_jp = self._mapNode.JpFAnim
  }
  self.tbCheckOrder = {
    "male_cn",
    "female_cn",
    "male_jp",
    "female_jp"
  }
  if Settings.sCurrentTxtLanguage == AllEnum.Language.CN then
    self.tbCheckOrder = {
      "male_jp",
      "female_jp",
      "male_cn",
      "female_cn"
    }
  elseif Settings.sCurrentTxtLanguage == AllEnum.Language.JP then
    self.tbCheckOrder = {"male_jp", "female_jp"}
  end
  self:InitL2DAnimDD()
  BubbleVoiceManager.Init(true)
  local bReuseFunc = Settings.sCurrentTxtLanguage ~= AllEnum.Language.CN and Settings.sCurrentTxtLanguage ~= AllEnum.Language.JP
  self._mapNode.btn_UseCn_Time.gameObject:SetActive(bReuseFunc)
  self._mapNode.btn_UseCn_Anim.gameObject:SetActive(bReuseFunc)
  self._mapNode.btn_UseJp_Time.gameObject:SetActive(bReuseFunc)
  self._mapNode.btn_UseJp_Anim.gameObject:SetActive(bReuseFunc)
  BubbleVoiceManager.SetSpeed(1)
end

function BBVEditorCtrl:OnDisable()
  Actor2DManager.DestroyL2D_InBBVEditor()
end

function BBVEditorCtrl:InitL2DAnimDD()
  self.tbAnimName = {
    "",
    "presents_a",
    "presents_b",
    "chat_a",
    "chat_b",
    "chat_c",
    "chat_d",
    "think_a",
    "shy_a",
    "special_a",
    "special_b"
  }
  local ListString = CS.System.Collections.Generic.List(CS.System.String)
  local listAnim = ListString()
  for i, v in ipairs(self.tbAnimName) do
    listAnim:Add(v)
  end
  for i = 1, 4 do
    NovaAPI.ClearDropDownOptions(self._mapNode.CnMAnim[i])
    NovaAPI.ClearDropDownOptions(self._mapNode.CnFAnim[i])
    NovaAPI.ClearDropDownOptions(self._mapNode.JpMAnim[i])
    NovaAPI.ClearDropDownOptions(self._mapNode.JpFAnim[i])
  end
  for i = 1, 4 do
    NovaAPI.DropDownAddOptions(self._mapNode.CnMAnim[i], listAnim)
    NovaAPI.DropDownAddOptions(self._mapNode.CnFAnim[i], listAnim)
    NovaAPI.DropDownAddOptions(self._mapNode.JpMAnim[i], listAnim)
    NovaAPI.DropDownAddOptions(self._mapNode.JpFAnim[i], listAnim)
  end
end

function BBVEditorCtrl:OnDD_PlayerSex()
  local bIsMale = NovaAPI.GetDropDownValue(self._mapNode.dd_PlayerSex) == 1
  PlayerData.Base:SetPlayerSex(bIsMale)
end

function BBVEditorCtrl:OnBtn_Back()
  EventManager.Hit(EventId.ClosePanel, PanelId.BBVEditor)
end

function BBVEditorCtrl:OnDD_SwitchVoLan(dd)
  local nIndex = NovaAPI.GetDropDownValue(dd)
  local sVoLan = AllEnum.LanguageInfo[nIndex + 1][1]
  if sVoLan ~= AllEnum.Language.CN and sVoLan ~= AllEnum.Language.JP then
    sVoLan = Settings.sCurrentVoLanguage
    nIndex = GetLanguageIndex(sVoLan)
    NovaAPI.SetDDValueWithoutNotify(dd, nIndex - 1)
    return
  end
  local bDownloaded, nTotalSize, nNeedDownloadSize = NovaAPI.HasDownload_VoLanguage(sVoLan)
  if bDownloaded == false and 0 < nNeedDownloadSize then
    NovaAPI.Enable_VoLanguage(sVoLan)
    PanelManager.OnConfirmBackToLogIn()
    return
  end
  NovaAPI.SetCur_VoiceLanguage(sVoLan)
  Settings.sCurrentVoLanguage = sVoLan
  NovaAPI.SetTMPText(self._mapNode.tmp_CurVosResLen, tostring(BubbleVoiceManager.GetVoResLen(self.sVoResName)))
end

function BBVEditorCtrl:OnDD_SwitchTxtLan(dd)
  local nLanIdx = NovaAPI.GetDropDownValue(dd) + 1
  local sLan = GetLanguageByIndex(nLanIdx)
  NovaAPI.SetCur_TextLanguage(sLan)
  Settings.sCurrentTxtLanguage = sLan
  PanelManager.OnConfirmBackToLogIn()
end

function BBVEditorCtrl:_ReuseData(_sLan, _sDataType)
  local mapReuseData = BubbleVoiceManager.GetReuseData(_sLan)
  if mapReuseData == nil then
    return
  end
  mapReuseData = mapReuseData[_sDataType]
  local _sKey = _sLan == AllEnum.Language.CN and "female_cn" or "female_jp"
  local tbReuseData = mapReuseData[_sKey]
  for i = 1, 4 do
    if _sDataType == "time" then
      NovaAPI.SetInputFieldText(self.mapTime[_sKey][i], tostring(tbReuseData[i]))
      NovaAPI.SetText(self.mapTimeFallback[_sKey][i], "")
    elseif _sDataType == "anim" then
      local nDDIndex = table.indexof(self.tbAnimName, tbReuseData[i]) - 1
      NovaAPI.SetDropDownValue(self.mapAnim[_sKey][i], nDDIndex)
    end
  end
  self._mapNode.btn_SaveSplitContent:SetActive(true)
end

function BBVEditorCtrl:OnBtn_ReuseCnTime()
  self:_ReuseData(AllEnum.Language.CN, "time")
end

function BBVEditorCtrl:OnBtn_ReuseCnAnim()
  self:_ReuseData(AllEnum.Language.CN, "anim")
end

function BBVEditorCtrl:OnBtn_ReuseJpTime()
  self:_ReuseData(AllEnum.Language.JP, "time")
end

function BBVEditorCtrl:OnBtn_ReuseJpAnim()
  self:_ReuseData(AllEnum.Language.JP, "anim")
end

function BBVEditorCtrl:OnBtn_SaveNewDataByDefault()
  local sCurVoResName = self.sVoResName
  self.bSaveByDefault = true
  if type(self.tbVoResName) == "table" then
    for i, sVoResName in ipairs(self.tbVoResName) do
      if BubbleVoiceManager.IsNew(sVoResName) == true then
        NovaAPI.SetDropDownValue(self._mapNode.dd_VoResName, i - 1)
      end
    end
  end
  self.bSaveByDefault = nil
  NovaAPI.SetDropDownValue(self._mapNode.dd_VoResName, table.indexof(self.tbVoResName, sCurVoResName) - 1)
end

function BBVEditorCtrl:onEvent_SetTextTime(sVoResName)
  self.sVoResName = sVoResName
  self.mapAllData, self.bIsNewData = BubbleVoiceManager.GetBubbleData_All(sVoResName)
  local tbFallbackText = {
    "",
    "",
    "",
    ""
  }
  local tbFallbackTime = {
    0,
    0,
    0,
    0
  }
  local nCount = #self.tbCheckOrder
  NovaAPI.SetTMPText(self._mapNode.tmp_CurVosResLen, tostring(BubbleVoiceManager.GetVoResLen(sVoResName)))
  if self.bIsNewData == true then
    local sKey = self.tbCheckOrder[nCount]
    self.mapAllData.text[sKey][1] = NovaAPI.GetInputFieldText(self._mapNode.ipt_SrcContent)
    self.mapAllData.time[sKey][1] = BubbleVoiceManager.GetVoResLen(sVoResName)
  end
  for _, mapData in pairs(self.mapAllData) do
    for i, sKey in ipairs(self.tbCheckOrder) do
      if mapData[sKey] == nil then
        self.mapAllData[_][sKey] = _ == "time" and {
          0,
          0,
          0,
          0
        } or {
          "",
          "",
          "",
          ""
        }
      end
    end
  end
  for i = nCount, 1, -1 do
    local sKey = self.tbCheckOrder[i]
    local bTextFB = false
    local bTimeFB = false
    for ii = 1, 4 do
      local sText = self.mapAllData.text[sKey][ii]
      local nTime = self.mapAllData.time[sKey][ii]
      sText = string.gsub(sText, "==RT==", "\n")
      if ii == 1 and i ~= nCount then
        bTextFB = sText == ""
        bTimeFB = nTime <= 0
      end
      if bTextFB == false then
        tbFallbackText[ii] = sText
      end
      if bTimeFB == false then
        tbFallbackTime[ii] = nTime
      end
      local _sText = tbFallbackText[ii]
      local _nTime = tbFallbackTime[ii]
      NovaAPI.SetInputFieldText(self.mapText[sKey][ii], bTextFB == true and "" or sText)
      NovaAPI.SetText(self.mapTextFallback[sKey][ii], bTextFB == true and _sText or "")
      NovaAPI.SetInputFieldText(self.mapTime[sKey][ii], bTimeFB == true and "" or tostring(nTime))
      NovaAPI.SetText(self.mapTimeFallback[sKey][ii], bTimeFB == true and tostring(_nTime) or "")
      if sKey == "female_jp" or sKey == "female_cn" then
        local nDDIndex = table.indexof(self.tbAnimName, self.mapAllData.anim[sKey][ii]) - 1
        NovaAPI.SetDropDownValue(self.mapAnim[sKey][ii], nDDIndex)
      end
    end
  end
  if self.bSaveByDefault == true then
    self:onEvent_SaveTextTime()
  else
    self._mapNode.btn_SaveSplitContent:SetActive(self.bIsNewData == true)
  end
end

function BBVEditorCtrl:onEvent_SaveTextTime()
  if self.mapAllData ~= nil then
    local nCount = #self.tbCheckOrder
    for i = 1, nCount do
      local sKey = self.tbCheckOrder[i]
      local bTextFB = false
      local bTimeFB = false
      for ii = 1, 4 do
        local sText = NovaAPI.GetInputFieldText(self.mapText[sKey][ii])
        local sTime = NovaAPI.GetInputFieldText(self.mapTime[sKey][ii])
        sText = string.gsub(sText, "\r\n", "==RT==")
        sText = string.gsub(sText, "\r", "==RT==")
        sText = string.gsub(sText, "\n", "==RT==")
        sText = string.gsub(sText, "\\", "")
        sText = string.gsub(sText, "\"", "\"")
        if ii == 1 and i ~= nCount then
          bTextFB = sText == ""
          bTimeFB = sTime == ""
        end
        if sTime == "" then
          sTime = "0"
        end
        self.mapAllData.text[sKey][ii] = bTextFB == true and "" or sText
        self.mapAllData.time[sKey][ii] = bTimeFB == true and 0 or tonumber(sTime)
        if sKey == "female_jp" or sKey == "female_cn" then
          local nDDIndex = NovaAPI.GetDropDownValue(self.mapAnim[sKey][ii]) + 1
          self.mapAllData.anim[sKey][ii] = self.tbAnimName[nDDIndex]
        end
      end
    end
    BubbleVoiceManager.DoSaveData(self.mapAllData)
    if self.bSaveByDefault ~= true then
      self:onEvent_SetTextTime(self.sVoResName)
    end
  end
end

function BBVEditorCtrl:onEvent_SetCharL2D(bIsNpc, nCharSkinId, bIsCG)
  Actor2DManager.SetL2D_InBBVEditor(self._mapNode.rawImage, bIsNpc, nCharSkinId, bIsCG)
  local bIsLeft, x, y = BubbleVoiceManager.BBVEditor_GetBBPos(nCharSkinId, bIsCG)
  self._mapNode.rtBubbleRoot.anchoredPosition = Vector2(x, y)
  NovaAPI.SetDDValueWithoutNotify(self._mapNode.dd_BBLeftRight, bIsLeft == true and 0 or 1)
end

function BBVEditorCtrl:onEvent_SaveOffset(nCharSkinId, bIsCG, bIsLeft, x, y)
  BubbleVoiceManager.DoSaveOffset(nCharSkinId, bIsCG, bIsLeft, x / 100, y / 100)
end

function BBVEditorCtrl:onEvent_Play(sVoResName, nCharSkinId, bIsCG)
  BubbleVoiceManager.PlayBubbleAnim(self._mapNode.goBubbleRoot, sVoResName, nCharSkinId, bIsCG)
end

function BBVEditorCtrl:onEvent_Stop()
  BubbleVoiceManager.StopBubbleAnim()
end

function BBVEditorCtrl:onEvent_Pause()
  BubbleVoiceManager.PauseBubbleAnim()
end

function BBVEditorCtrl:onEvent_Resume()
  BubbleVoiceManager.ResumeBubbleAnim()
end

function BBVEditorCtrl:onEvent_CheckNewData(listVoResName, nCount)
  self.tbVoResName = {}
  nCount = nCount - 1
  for i = 0, nCount do
    local sVoResName = listVoResName[i]
    if type(sVoResName) == "string" then
      table.insert(self.tbVoResName, sVoResName)
    end
  end
  self._mapNode.btn_SaveByDefault.gameObject:SetActive(BubbleVoiceManager.HasNewDataToSave(self.tbVoResName) == true)
end

function BBVEditorCtrl:GetCurTime()
  local nSldValue = NovaAPI.GetSliderValue(self._mapNode.sld_Progress)
  local nTotalTime = tonumber(NovaAPI.GetTMPText(self._mapNode.tmp_CurVosResLen))
  if type(nTotalTime) == "number" and 0 < nTotalTime then
    return string.format("%.2f", nTotalTime * nSldValue)
  else
    return 0
  end
end

function BBVEditorCtrl:OnTimeSnip_CnM(btn, nIndex)
  local nTime = self:GetCurTime()
  NovaAPI.SetInputFieldText(self._mapNode.CnMTime[nIndex], tostring(nTime))
end

function BBVEditorCtrl:OnTimeSnip_CnF(btn, nIndex)
  local nTime = self:GetCurTime()
  NovaAPI.SetInputFieldText(self._mapNode.CnFTime[nIndex], tostring(nTime))
end

function BBVEditorCtrl:OnTimeSnip_JpM(btn, nIndex)
  local nTime = self:GetCurTime()
  NovaAPI.SetInputFieldText(self._mapNode.JpMTime[nIndex], tostring(nTime))
end

function BBVEditorCtrl:OnTimeSnip_JpF(btn, nIndex)
  local nTime = self:GetCurTime()
  NovaAPI.SetInputFieldText(self._mapNode.JpFTime[nIndex], tostring(nTime))
end

function BBVEditorCtrl:OnDD_SpeedChanged()
  local nValue = NovaAPI.GetDropDownValue(self._mapNode.dd_Speed)
  BubbleVoiceManager.SetSpeed(nValue + 1)
end

return BBVEditorCtrl
