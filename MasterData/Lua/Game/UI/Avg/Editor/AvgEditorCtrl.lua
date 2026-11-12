local CS_SYS = CS.System
local CS_SYS_IO = CS_SYS.IO
local CS_UNITY = CS.UnityEngine
local WwiseAudioManager = CS.WwiseAudioManager
local PlayerBaseData = PlayerData.Base
local Actor2DManager = require("Game.Actor2D.Actor2DManager")
local AvgEditorCtrl = class("AvgEditorCtrl", BaseCtrl)
local AvgData = PlayerData.Avg
local serpent = require("serpent")
local CmdInfo = require("Game.UI.Avg.Editor.CmdInfo")
AvgEditorCtrl._mapNodeConfig = {
  BG = {
    sNodeName = "----EditorBG----"
  },
  txtAvgStoryId = {sComponentName = "Text"},
  goMain = {},
  input_AvgConfigName = {sComponentName = "InputField"},
  btnEditST = {
    sComponentName = "Button",
    callback = "OnBtnClick_EditST"
  },
  btnRefreshST = {
    sComponentName = "Button",
    callback = "OnBtnClick_RefreshST"
  },
  togEditorBgm = {
    sComponentName = "Toggle",
    callback = "OnToggle_EditorBgm"
  },
  inputAddST = {sComponentName = "InputField"},
  btnAddST = {
    sComponentName = "Button",
    callback = "OnBtnClick_AddST"
  },
  ddSetResolution = {
    sComponentName = "Dropdown",
    callback = "OnBtnClick_ApplyResolution"
  },
  ddLanguage = {
    sComponentName = "Dropdown",
    callback = "OnDD_TextLan"
  },
  ddVoLan = {sComponentName = "Dropdown", callback = "OnDD_VoLan"},
  inputStartCmdID = {sComponentName = "InputField"},
  btnPreviewST = {
    sComponentName = "Button",
    callback = "OnBtnClick_PreviewAvgST"
  },
  inputPlayerName = {sComponentName = "InputField"},
  ddGender = {
    sComponentName = "Dropdown",
    callback = "OnDD_Gender"
  },
  Placeholder_CurPlayerName = {sComponentName = "Text"},
  btnSetPlayerName = {
    sComponentName = "Button",
    callback = "OnBtnClick_SetPlayerName"
  },
  inputConditionIds = {sComponentName = "InputField"},
  btnAddConditionIds = {
    sComponentName = "Button",
    callback = "OnBtnClick_AddConditionIds"
  },
  btnSubConditionIds = {
    sComponentName = "Button",
    callback = "OnBtnClick_SubConditionIds"
  },
  inputIfTrueData = {sComponentName = "InputField"},
  btnAddIfTrueData = {
    sComponentName = "Button",
    callback = "OnBtnClick_AddIfTrueData"
  },
  btnSubIfTrueData = {
    sComponentName = "Button",
    callback = "OnBtnClick_SubIfTrueData"
  },
  btn_Back = {sComponentName = "Button", callback = "OnBtn_Back"},
  ctrlMultiLanTool = {
    sNodeName = "----MULTI_LANGUAGE_TOOL----",
    sCtrlName = "Game.UI.Avg.Editor.AvgEditorMultiLanTool"
  },
  goPreview = {},
  btnSkip = {
    sComponentName = "Button",
    callback = "OnBtnClick_Skip"
  },
  goCmdConfig = {},
  btnBackToMain = {
    sComponentName = "Button",
    callback = "OnBtnClick_BackToMain"
  },
  inputJumpToID = {
    sComponentName = "InputField_onEndEdit",
    callback = "OnEditEnd_inputJumpToID"
  },
  ddGenderInCmdList = {
    sComponentName = "Dropdown",
    callback = "OnDD_Gender"
  },
  ddVoLanInCmdList = {sComponentName = "Dropdown", callback = "OnDD_VoLan"},
  btnSaveCmd = {
    sComponentName = "Button",
    callback = "OnBtnClick_SaveCmd"
  },
  btnMoveCmdUp = {
    sComponentName = "Button",
    callback = "OnBtnClick_MoveCmdUp"
  },
  btnMoveCmdDown = {
    sComponentName = "Button",
    callback = "OnBtnClick_MoveCmdDown"
  },
  btnVisualizedEditCmd = {
    sComponentName = "Button",
    callback = "OnBtnClick_VisualizedEditCmd"
  },
  togRemoveUnloopFx = {sComponentName = "Toggle"},
  btnOpenAddCmdWindow = {
    sComponentName = "Button",
    callback = "OnBtnClick_OpenAddCmdWindow"
  },
  btnOpenDelCmdWindow = {
    sComponentName = "Button",
    callback = "OnBtnClick_OpenDelCmdWindow"
  },
  loopSV = {
    sNodeName = "svCmdList",
    sComponentName = "LoopScrollView"
  },
  cmdContent = {sComponentName = "Transform"},
  goAddCmdWindow = {},
  layoutCmd_Bg = {sComponentName = "Transform"},
  layoutCmd_Char = {sComponentName = "Transform"},
  layoutCmd_Talk = {sComponentName = "Transform"},
  layoutCmd_Choice = {sComponentName = "Transform"},
  layoutCmd_Audio = {sComponentName = "Transform"},
  layoutCmd_Other = {sComponentName = "Transform"},
  btnAddCmd = {
    sComponentName = "Button",
    callback = "OnBtnClick_AddCmd"
  },
  btnCloseAdd = {
    sComponentName = "Button",
    callback = "OnBtnClick_CloseAdd"
  },
  goDelCmdWindow = {},
  btnDelCmd = {
    sComponentName = "Button",
    callback = "OnBtnClick_DelCmd"
  },
  btnCloseDel = {
    sComponentName = "Button",
    callback = "OnBtnClick_CloseDel"
  },
  goFullParam = {},
  grid_full = {sComponentName = "Transform"},
  txtCmdIndex = {sComponentName = "Text"},
  btnPreview = {
    sComponentName = "Button",
    callback = "OnBtnClick_Preview"
  },
  btnConfirm = {
    sComponentName = "Button",
    callback = "OnBtnClick_Confirm"
  },
  btnBackToList = {
    sComponentName = "Button",
    callback = "OnBtnClick_BackToList"
  },
  btnShowParam = {
    sComponentName = "Button",
    callback = "OnBtnClick_ShowParam"
  },
  btnHideParam = {
    sComponentName = "Button",
    callback = "OnBtnClick_HideParam"
  },
  goShakeEditor = {},
  btnShakeEditor = {
    sComponentName = "Button",
    callback = "OnBtnClick_OpenShakeEditor"
  },
  btnCloseShakeEditor = {
    sComponentName = "Button",
    callback = "OnBtnClick_CloseShakeEditor"
  },
  trActor2D_PNG = {
    sNodeName = "----Actor2D_PNG----",
    sComponentName = "Transform"
  },
  eftShake = {sComponentName = "GameObject"},
  input_Pos = {nCount = 3, sComponentName = "InputField"},
  input_PosTime = {nCount = 3, sComponentName = "InputField"},
  input_PosCount = {nCount = 3, sComponentName = "InputField"},
  tog_PosBothDir = {nCount = 3, sComponentName = "Toggle"},
  tog_PosDamping = {nCount = 3, sComponentName = "Toggle"},
  input_Rot = {nCount = 3, sComponentName = "InputField"},
  input_RotTime = {nCount = 3, sComponentName = "InputField"},
  input_RotCount = {nCount = 3, sComponentName = "InputField"},
  tog_RotBothDir = {nCount = 3, sComponentName = "Toggle"},
  tog_RotDamping = {nCount = 3, sComponentName = "Toggle"},
  tog_LOOP = {sComponentName = "Toggle"},
  btnPreviewShake = {
    sComponentName = "Button",
    callback = "OnBtnClick_PreviewShake"
  },
  input_Output = {sComponentName = "InputField"},
  btnOutput = {
    sComponentName = "Button",
    callback = "OnBtnClick_Output"
  },
  input_Input = {sComponentName = "InputField"},
  btnInput = {
    sComponentName = "Button",
    callback = "OnBtnClick_Input"
  },
  btnAudioVolEditor = {
    sComponentName = "Button",
    callback = "OnBtnClick_OpenAudioVol"
  },
  goAudioVolEditor = {},
  btnCloseAudioVolEditor = {
    sComponentName = "Button",
    callback = "OnBtnClick_CloseAudioVol"
  },
  inputAvgBGM = {sComponentName = "InputField"},
  btnPlayBgm = {
    sComponentName = "Button",
    callback = "OnBtnClick_PlayAvgBGM"
  },
  SldBgmVol = {
    sComponentName = "Slider",
    callback = "OnSld_AvgBgmVol"
  },
  inputBgmVol = {sComponentName = "InputField"},
  btnApplyBgmVol = {
    sComponentName = "Button",
    callback = "OnBtnClick_ApplyAvgBgmVol"
  },
  inputAvgAudio = {sComponentName = "InputField"},
  btnPlayAudio = {
    sComponentName = "Button",
    callback = "OnBtnClick_PlayAvgAudio"
  },
  goSelectGroupId = {},
  inputGroupId = {sComponentName = "InputField"},
  btnConfirmGroupId = {
    sComponentName = "Button",
    callback = "OnBtnClick_ConfirmGroupId"
  },
  btnAutoAdjustData = {
    sComponentName = "Button",
    callback = "OnBtnClick_AutoAdjustData"
  }
}
AvgEditorCtrl._mapEventConfig = {
  StoryDialog_DialogEnd = "OnEvent_AvgEnd",
  AvgEditor_OnCmdValueChanged = "OnValueChanged",
  AvgMultiLanTool_SAVE_AVG_CONFIG = "SAVE_AVG_CONFIG",
  AvgMultiLanTool_DO_SAVE_LUA_FILE = "DO_SAVE_LUA_FILE"
}

function AvgEditorCtrl:Awake()
  WwiseAudioManager.Instance:PostEvent("avg_enter")
  self:_SetTimeScale("BB")
  self.tbFileName = {}
  local ListString = CS_SYS.Collections.Generic.List(CS_SYS.String)
  self.listLanguage = ListString()
  self.tbAllBgCg = nil
  self.tbBgEftName = nil
  self.tbIntroIcon = nil
  self.listBgShakeType = ListString()
  self.listEaseType = ListString()
  self.listKeyName = ListString()
  self.listBody = ListString()
  self.listBodyHead = ListString()
  self.listEmoji = ListString()
  self.listCharFadeInOut = ListString()
  self.listCharShakeType = ListString()
  self.listCharPresetDataEnter = ListString()
  self.listCharPresetDataExit = ListString()
  self.listBgmFadeTime = ListString()
  self.listBgmVol = ListString()
  self.tbFxName = nil
  self:PrepareConstCmdParamOptions()
  VISUALIZED_EDIT_CMD = false
  self._mapNode.btnAutoAdjustData.gameObject:SetActive(ADJUST == true)
end

function AvgEditorCtrl:OnEnable()
  self:RefreshDropdown()
  self:SwitchRoot(1)
  self._mapNode.btnAddST.gameObject:SetActive(CAN_EDIT == true)
  self._mapNode.btnSaveCmd.gameObject:SetActive(CAN_EDIT == true)
  self._mapNode.btnMoveCmdUp.gameObject:SetActive(CAN_EDIT == true)
  self._mapNode.btnMoveCmdDown.gameObject:SetActive(CAN_EDIT == true)
  self._mapNode.btnVisualizedEditCmd.gameObject:SetActive(CAN_EDIT == true)
  self._mapNode.btnOpenAddCmdWindow.gameObject:SetActive(CAN_EDIT == true)
  self._mapNode.btnOpenDelCmdWindow.gameObject:SetActive(CAN_EDIT == true)
  self._mapNode.togRemoveUnloopFx.gameObject:SetActive(CAN_EDIT == true)
  self._mapNode.btnShakeEditor.gameObject:SetActive(CAN_EDIT == true)
  self._mapNode.btnAudioVolEditor.gameObject:SetActive(CAN_EDIT == true)
  self._mapNode.inputAddST.gameObject:SetActive(CAN_EDIT == true)
  self._mapNode.btnAddST.gameObject:SetActive(CAN_EDIT == true)
  self.objCtrl_Stage = self._panel:GetCtrlObj("Avg_0_Stage")
  self.objCtrl_Char = self._panel:GetCtrlObj("Avg_2_CharCtrl")
  self.objCtrl_Trans = self._panel:GetCtrlObj("Avg_3_TransitionCtrl")
  self.objCtrl_Talk = self._panel:GetCtrlObj("Avg_4_TalkCtrl")
  self.objCtrl_Menu = self._panel:GetCtrlObj("Avg_6_MenuCtrl")
  self.objCtrl_Choice = self._panel:GetCtrlObj("Avg_7_ChoiceCtrl")
  self.objCtrl_Stage:RestoreAll(false, self:GetHistoryData_Stage(false))
  self.objCtrl_Char:RestoreAll(false, self:GetHistoryData_Char(false))
  self.objCtrl_Trans:RestoreAll(false, self:GetHistoryData_Trans(false))
  self.objCtrl_Talk:RestoreAll(false, self:GetHistoryData_Talk(false))
  self.objCtrl_Menu:RestoreAll(false)
  self.objCtrl_Choice:RestoreAll(false)
end

function AvgEditorCtrl:SetConfigPath()
  local sRequireRoot = GetAvgLuaRequireRoot(self._panel.nCurLanguageIdx)
  self.sRequireAvgCfgPath = sRequireRoot .. "Config/"
  self.sRequireAvgCharPath = sRequireRoot .. "Preset/AvgCharacter"
  self.sRequireAvgContactsPath = sRequireRoot .. "Preset/AvgContacts"
  self.sRequireAvgUITextPath = sRequireRoot .. "Preset/AvgUIText"
  self.sRequireAvgPresetPath = "Game.UI.Avg.AvgPreset"
  local sWriteFileRoot = NovaAPI.ApplicationDataPath .. "/../Lua/"
  if NovaAPI.IsRuntimeWindowsPlayer() == true then
    sWriteFileRoot = NovaAPI.StreamingAssetsPath .. "/Lua/"
  end
  sWriteFileRoot = sWriteFileRoot .. sRequireRoot
  self.sWriteFileAvgCfgPath = sWriteFileRoot .. "Config/"
end

function AvgEditorCtrl:PrepareConfigurableCmdParamOptions()
  local tbAvgChar = require(self.sRequireAvgCharPath)
  local tbAvgContacts = require(self.sRequireAvgContactsPath)
  self._panel.tbAvgPreset = require(self.sRequireAvgPresetPath)
  self.tbAllBgCg = {}
  for _, sName in ipairs(self._panel.tbAvgPreset.BgResName) do
    table.insert(self.tbAllBgCg, sName)
  end
  for _, sName in ipairs(self._panel.tbAvgPreset.CgResName) do
    table.insert(self.tbAllBgCg, sName)
  end
  for _, sName in ipairs(self._panel.tbAvgPreset.FgResName) do
    table.insert(self.tbAllBgCg, sName)
  end
  for _, sName in ipairs(self._panel.tbAvgPreset.DiscResName) do
    table.insert(self.tbAllBgCg, sName)
  end
  self.tbBgEftName = {}
  for _, sName in ipairs(self._panel.tbAvgPreset.BgEffectResName) do
    table.insert(self.tbBgEftName, sName)
  end
  self.tbIntroIcon = {}
  for _, sName in ipairs(self._panel.tbAvgPreset.IntroIcon) do
    table.insert(self.tbIntroIcon, sName)
  end
  self.listBgShakeType:Clear()
  for _, data in ipairs(self._panel.tbAvgPreset.BgShakeType) do
    self.listBgShakeType:Add(data[1])
  end
  self.listEaseType:Clear()
  for _, sName in ipairs(self._panel.tbAvgPreset.EaseType) do
    self.listEaseType:Add(sName)
  end
  self.listKeyName:Clear()
  for i, v in ipairs(self._panel.tbAvgPreset.Transition) do
    self.listKeyName:Add(v[1])
  end
  self.tbAvgCharId = {}
  self.tbAvgCharName = {}
  self.mapAvgCharNameAllLanguage = {}
  self.mapAvgCharReuseResAvg = {}
  for _, mapData in ipairs(tbAvgChar) do
    table.insert(self.tbAvgCharId, mapData.id)
    table.insert(self.tbAvgCharName, string.format("%s%s", mapData.name, mapData.surfix or ""))
    self.mapAvgCharNameAllLanguage[mapData.id] = {
      name = mapData.name,
      color = mapData.name_bg_color
    }
    if mapData.reuse ~= nil then
      self.mapAvgCharReuseResAvg[mapData.id] = mapData.reuse
    end
  end
  self.listBody:Clear()
  for _, sBody in ipairs(self._panel.tbAvgPreset.CharPose_0) do
    self.listBody:Add(sBody)
  end
  self.listBodyHead:Clear()
  for _, sBody in ipairs(self._panel.tbAvgPreset.CharPose_1) do
    self.listBodyHead:Add(sBody)
  end
  self.listEmoji:Clear()
  for _, tbEmoji in ipairs(self._panel.tbAvgPreset.CharEmoji) do
    self.listEmoji:Add(tbEmoji[2])
  end
  self.listCharFadeInOut:Clear()
  for _, tbFadeEft in ipairs(self._panel.tbAvgPreset.CharFadeEft) do
    self.listCharFadeInOut:Add(tbFadeEft[1])
  end
  self.listCharShakeType:Clear()
  for _, data in ipairs(self._panel.tbAvgPreset.CharShakeType) do
    self.listCharShakeType:Add(data[1])
  end
  self.listCharPresetDataEnter:Clear()
  for _, v in ipairs(self._panel.tbAvgPreset.CharEnter) do
    self.listCharPresetDataEnter:Add(v[1])
  end
  self.listCharPresetDataExit:Clear()
  for _, v in ipairs(self._panel.tbAvgPreset.CharExit) do
    self.listCharPresetDataExit:Add(v[1])
  end
  self.listBgmFadeTime:Clear()
  for _, data in ipairs(self._panel.tbAvgPreset.BgmFadeTime) do
    self.listBgmFadeTime:Add(data)
  end
  self.listBgmVol:Clear()
  for _, data in ipairs(self._panel.tbAvgPreset.BgmVol) do
    self.listBgmVol:Add(data[1])
  end
  self.tbFxName = {}
  for _, tbFx in ipairs(self._panel.tbAvgPreset.FxResName) do
    table.insert(self.tbFxName, tbFx[1])
  end
  self.tbAvgContactsId = {}
  self.tbAvgContactsName = {}
  self.mapAvgContactsNameAllLanguage = {}
  for _, mapData in ipairs(tbAvgContacts) do
    table.insert(self.tbAvgContactsId, mapData.id)
    table.insert(self.tbAvgContactsName, mapData.name)
    self.mapAvgContactsNameAllLanguage[mapData.id] = mapData.name
  end
end

function AvgEditorCtrl:PrepareConstCmdParamOptions()
  self.bIgnoreValueChange = false
  self.tbSetAudioType = {
    "AvgBGM",
    "Effect",
    "Environment",
    "GameBGM"
  }
  self.tbPauseFadeoutSecond = {
    0,
    0.5,
    1,
    2,
    4
  }
  self.mapColor = {
    {
      Color(0.368, 0.537, 0.705, 1),
      {"SetStage", "CtrlStage"}
    },
    {
      Color(0.5, 0.5, 0.5, 1),
      {
        "SetBg",
        "CtrlBg",
        "SetFx",
        "SetFrontObj",
        "SetFilm",
        "SetTrans",
        "SetBubbleUIType",
        "SetHeartBeat",
        "SetPP",
        "SetPPGlobal",
        "SetCameraAperture"
      }
    },
    {
      Color(0.5, 0, 0.75, 1),
      {
        "SetChar",
        "CtrlChar",
        "PlayCharAnim",
        "SetCharHead",
        "CtrlCharHead",
        "SetL2D",
        "CtrlL2D",
        "SetCharL2D",
        "PlayGradient2Anim"
      }
    },
    {
      Color(0, 0.75, 0.5, 1),
      {
        "SetTalk",
        "SetTalkShake",
        "SetGoOn",
        "SetMainRoleTalk",
        "SetPhone",
        "SetPhoneMsg",
        "SetPhoneThinking",
        "SetBubble"
      }
    },
    {
      Color(1, 1, 0.5, 1),
      {
        "SetChoiceBegin",
        "SetChoiceJumpTo",
        "SetChoiceRollback",
        "SetChoiceRollover",
        "SetChoiceEnd",
        "SetPhoneMsgChoiceBegin",
        "SetPhoneMsgChoiceJumpTo",
        "SetPhoneMsgChoiceEnd",
        "SetMajorChoice",
        "SetMajorChoiceJumpTo",
        "SetMajorChoiceRollover",
        "SetMajorChoiceEnd",
        "SetPersonalityChoice",
        "SetPersonalityChoiceJumpTo",
        "SetPersonalityChoiceRollover",
        "SetPersonalityChoiceEnd",
        "IfTrue",
        "EndIf",
        "GetEvidence"
      }
    },
    {
      Color(1, 0, 1, 1),
      {"SetAudio", "SetBGM"}
    }
  }
  self.tbGroupA = {
    "SetBg",
    "CtrlBg",
    "SetStage",
    "CtrlStage",
    "SetFx",
    "SetFrontObj"
  }
  self.tbGroupB = {
    "SetChar",
    "CtrlChar",
    "PlayCharAnim",
    "SetCharHead",
    "CtrlCharHead",
    "PlayGradient2Anim"
  }
  self.tbGroupC = {"SetFilm", "SetTrans"}
  self.tbGroupD = {
    "SetTalk",
    "SetTalkShake",
    "SetMainRoleTalk"
  }
  self.tbGroupE = {
    "SetChoiceBegin"
  }
  self.tbGroupF = {
    "NewCharIntro"
  }
  for i, v in ipairs(AllEnum.LanguageInfo) do
    self.listLanguage:Add(v[2])
  end
  NovaAPI.ClearDropDownOptions(self._mapNode.ddLanguage)
  NovaAPI.DropDownAddOptions(self._mapNode.ddLanguage, self.listLanguage)
  local nCurTxtLanIdx = GetLanguageIndex(Settings.sCurrentTxtLanguage)
  NovaAPI.SetDDValueWithoutNotify(self._mapNode.ddLanguage, nCurTxtLanIdx - 1)
  self._panel.nCurLanguageIdx = nCurTxtLanIdx
  self._panel.sTxtLan = Settings.sCurrentTxtLanguage
  NovaAPI.ClearDropDownOptions(self._mapNode.ddVoLan)
  NovaAPI.ClearDropDownOptions(self._mapNode.ddVoLanInCmdList)
  NovaAPI.DropDownAddOptions(self._mapNode.ddVoLan, self.listLanguage)
  NovaAPI.DropDownAddOptions(self._mapNode.ddVoLanInCmdList, self.listLanguage)
  local nCurVoLanIdx = GetLanguageIndex(Settings.sCurrentVoLanguage)
  NovaAPI.SetDDValueWithoutNotify(self._mapNode.ddVoLan, nCurVoLanIdx - 1)
  NovaAPI.SetDDValueWithoutNotify(self._mapNode.ddVoLanInCmdList, nCurVoLanIdx - 1)
  self._panel.sVoLan = Settings.sCurrentVoLanguage
  self._panel.bIsPlayerMale = PlayerBaseData:GetPlayerSex() == true
  self._panel.sPlayerNickName = PlayerBaseData:GetPlayerNickName()
  NovaAPI.SetDDValueWithoutNotify(self._mapNode.ddGender, self._panel.bIsPlayerMale == true and 1 or 0)
  NovaAPI.SetDDValueWithoutNotify(self._mapNode.ddGenderInCmdList, self._panel.bIsPlayerMale == true and 1 or 0)
  NovaAPI.SetText(self._mapNode.Placeholder_CurPlayerName, "玩家当前名字为：" .. self._panel.sPlayerNickName)
end

function AvgEditorCtrl:SwitchRoot(nType)
  self._mapNode.goMain:SetActive(false)
  self._mapNode.goPreview:SetActive(false)
  self._mapNode.goCmdConfig:SetActive(false)
  self._mapNode.goFullParam.transform.localScale = Vector3.zero
  self._mapNode.goShakeEditor:SetActive(false)
  if nType == 1 then
    self._mapNode.goMain:SetActive(true)
  elseif nType == 2 then
    self._mapNode.goPreview:SetActive(true)
  elseif nType == 3 then
    self._mapNode.goCmdConfig:SetActive(true)
  elseif nType == 4 then
    self._mapNode.goFullParam.transform.localScale = Vector3.one
  elseif nType == 5 then
    self._mapNode.goShakeEditor:SetActive(true)
  end
  self._mapNode.txtAvgStoryId.gameObject:SetActive(nType == 2 or nType == 3 or nType == 4)
  AVG_EDITOR_PLAYING = nType == 2
end

function AvgEditorCtrl:SetEditorBgm(bPlay, bOverWrite)
  if self.bEditorBgmSetOn == nil then
    self.bEditorBgmSetOn = true
    WwiseAudioManager.Instance:PlayMusic("login")
  end
  WwiseAudioManager.Instance.MusicVolume = bPlay == true and 10 or 0
  if bOverWrite == true then
    self.bEditorBgmSetOn = bPlay == true
  end
end

function AvgEditorCtrl:GetAvgCharName(sAvgCharId, bForce_zhCN)
  if sAvgCharId == "avg3_100" or sAvgCharId == "avg3_101" then
    local sName = PlayerData.Base:GetPlayerNickName()
    return sName, "#0ABEC5"
  end
  local nLanIdx = self._panel.nCurLanguageIdx
  if bForce_zhCN == true then
    nLanIdx = 1
  end
  local tbData = self.mapAvgCharNameAllLanguage[sAvgCharId]
  if tbData == nil then
    return sAvgCharId, "#0ABEC5"
  else
    return tbData.name or sAvgCharId, tbData.color or "#0ABEC5"
  end
end

function AvgEditorCtrl:GetAvgCharReuseRes(sAvgCharId)
  local sReuse = self.mapAvgCharReuseResAvg[sAvgCharId]
  if sReuse == nil then
    return sAvgCharId
  else
    return AdjustMainRoleAvgCharId(sReuse)
  end
end

function AvgEditorCtrl:GetCmdColor(sCmdName)
  for i, v in ipairs(self.mapColor) do
    if table.indexof(v[2], sCmdName) > 0 then
      return v[1]
    end
  end
  if self.colorDefault == nil then
    self.colorDefault = Color.white
  end
  return self.colorDefault
end

function AvgEditorCtrl:RefreshDropdown(sNewAvgId)
  self:SetConfigPath()
  local nCount = #self.tbFileName
  for i = nCount, 1, -1 do
    table.remove(self.tbFileName, i)
  end
  if #self.tbFileName > 0 then
    printLog("演出配置文件名列表未清空")
  end
  self.tbFileName = self:GetAllAvgLuaConfigFileName()
  self._mapNode.input_AvgConfigName.gameObject:SetActive(true)
  GameUIUtils.AvgEditor_SetResName(self._mapNode.input_AvgConfigName.transform, self.tbFileName, sNewAvgId or "", true)
  NovaAPI.SetText(self._mapNode.txtAvgStoryId, #self.tbFileName > 0 and self.tbFileName[1] or "none")
end

function AvgEditorCtrl:GetAvgLuaConfigFileNameByPattern(sRootPath, sPattern)
  local tbFileName = {}
  local files = CS_SYS_IO.Directory.GetFiles(sRootPath, sPattern, CS_SYS_IO.SearchOption.TopDirectoryOnly)
  local nFileCount = files.Length - 1
  for i = 0, nFileCount do
    local sFileName = string.gsub(CS_SYS_IO.Path.GetFileName(files[i]), ".lua", "")
    table.insert(tbFileName, sFileName)
  end
  return tbFileName
end

function AvgEditorCtrl:GetAllAvgLuaConfigFileName(bCN)
  local sRoot = self.sWriteFileAvgCfgPath
  if bCN == true then
    local sFolderSurfix = GetLanguageSurfixByIndex(self._panel.nCurLanguageIdx)
    sRoot = sRoot.gsub(sFolderSurfix, "_cn")
  end
  local tbFileName = {}
  table.insertto(tbFileName, self:GetAvgLuaConfigFileNameByPattern(sRoot, "BB*.lua"), #tbFileName + 1)
  table.insertto(tbFileName, self:GetAvgLuaConfigFileNameByPattern(sRoot, "BT*.lua"), #tbFileName + 1)
  table.insertto(tbFileName, self:GetAvgLuaConfigFileNameByPattern(sRoot, "CG*.lua"), #tbFileName + 1)
  table.insertto(tbFileName, self:GetAvgLuaConfigFileNameByPattern(sRoot, "DP*.lua"), #tbFileName + 1)
  table.insertto(tbFileName, self:GetAvgLuaConfigFileNameByPattern(sRoot, "GD*.lua"), #tbFileName + 1)
  table.insertto(tbFileName, self:GetAvgLuaConfigFileNameByPattern(sRoot, "PM*.lua"), #tbFileName + 1)
  table.insertto(tbFileName, self:GetAvgLuaConfigFileNameByPattern(sRoot, "ST*.lua"), #tbFileName + 1)
  return tbFileName
end

function AvgEditorCtrl:GetCurrentAvgId()
  local sAvgId = NovaAPI.GetInputFieldText(self._mapNode.input_AvgConfigName)
  if table.indexof(self.tbFileName, sAvgId) > 0 then
    return sAvgId
  else
    return nil
  end
end

function AvgEditorCtrl:OnBtnClick_EditST(btn)
  local sAvgId = self:GetCurrentAvgId()
  if sAvgId ~= nil then
    EventManager.Hit(EventId.MarkFullRectWH)
    local sAvgIdHead = string.sub(sAvgId, 1, 2)
    self:_SetTimeScale(sAvgIdHead)
    NovaAPI.SetText(self._mapNode.txtAvgStoryId, sAvgId)
    local sAvgIdHead = string.sub(sAvgId, 1, 2)
    if sAvgIdHead == "BT" or sAvgIdHead == "DP" or sAvgIdHead == "GD" then
      self._panel.AVG_NO_BG_MODE = true
    else
      self._panel.AVG_NO_BG_MODE = nil
    end
    self:SwitchRoot(3)
    self:PrepareConfigurableCmdParamOptions()
    self:CreateCmdIns(sAvgId)
  end
end

function AvgEditorCtrl:OnBtnClick_RefreshST(btn)
  self:RefreshDropdown()
end

function AvgEditorCtrl:OnToggle_EditorBgm(tog, isOn)
end

function AvgEditorCtrl:OnBtnClick_AddST(btn)
  local sAvgId = NovaAPI.GetInputFieldText(self._mapNode.inputAddST)
  if table.indexof(self.tbFileName, sAvgId) > 0 then
    local msg = "重名了，请检查指令配置文件目录。"
    if self._panel.nCurLanguageIdx ~= 0 then
      msg = "Exist same Lua file name."
    end
    EventManager.Hit(EventId.OpenMessageBox, msg)
    return
  end
  local sFileNameHead = string.sub(sAvgId, 1, 2)
  if sFileNameHead ~= "ST" and sFileNameHead ~= "BT" and sFileNameHead ~= "CG" and sFileNameHead ~= "BB" and sFileNameHead ~= "GD" then
    local msg = "需以 ST 或 BT 或 CG 或 BB 开头，请阅读检查命名规则。"
    if self._panel.nCurLanguageIdx ~= 0 then
      msg = "File name must start with one of them: BB BT CG DP GD PM ST."
    end
    EventManager.Hit(EventId.OpenMessageBox, msg)
    return
  end
  local fs = CS_SYS_IO.FileStream(self.sWriteFileAvgCfgPath .. sAvgId .. ".lua", CS_SYS_IO.FileMode.Create)
  local sw = CS_SYS_IO.StreamWriter(fs, CS_SYS.Text.UTF8Encoding(false))
  sw:WriteLine("return {  {cmd=\"End\"},")
  sw:WriteLine("}")
  sw:Close()
  fs:Close()
  NovaAPI.SetInputFieldText(self._mapNode.inputAddST, "")
  self:RefreshDropdown(sAvgId)
end

function AvgEditorCtrl:OnBtnClick_ApplyResolution()
  local tbResolution = {
    {1280, 960},
    {1536, 960},
    {1536, 864},
    {1536, 768},
    {1920, 960},
    {1614, 768},
    {1690, 768}
  }
  local nIdx = NovaAPI.GetDropDownValue(self._mapNode.ddSetResolution) + 1
  local nW = tbResolution[nIdx][1]
  local nH = tbResolution[nIdx][2]
  CS_UNITY.Screen.SetResolution(nW, nH, false)
end

function AvgEditorCtrl:OnBtnClick_PreviewAvgST(btn)
  local sAvgId = self:GetCurrentAvgId()
  if sAvgId ~= nil then
    EventManager.Hit(EventId.MarkFullRectWH)
    self.sPreviewHead = string.sub(sAvgId, 1, 2)
    self:_SetTimeScale(self.sPreviewHead)
    if self.sPreviewHead == "BB" or self.sPreviewHead == "DP" or self.sPreviewHead == "PM" then
      self._mapNode.goSelectGroupId:SetActive(true)
    else
      NovaAPI.SetText(self._mapNode.txtAvgStoryId, sAvgId)
      self:SwitchRoot(2)
      local nStartCMDID = tonumber(NovaAPI.GetInputFieldText(self._mapNode.inputStartCmdID))
      EventManager.Hit("StoryDialog_DialogStart", sAvgId, self._panel.sTxtLan, self._panel.sVoLan, nil, nStartCMDID)
    end
  end
end

function AvgEditorCtrl:OnBtnClick_SetPlayerName(btn)
  local sName = NovaAPI.GetInputFieldText(self._mapNode.inputPlayerName)
  if sName ~= "" then
    self._panel.sPlayerNickName = sName
    PlayerBaseData:SetPlayerNickName(sName)
    NovaAPI.SetText(self._mapNode.Placeholder_CurPlayerName, "玩家当前名字为：" .. sName)
  end
end

function AvgEditorCtrl:OnBtnClick_AddConditionIds(btn)
  AvgData:AvgEditorTempData(NovaAPI.GetInputFieldText(self._mapNode.inputConditionIds), true)
  NovaAPI.SetInputFieldText(self._mapNode.inputConditionIds, "")
end

function AvgEditorCtrl:OnBtnClick_SubConditionIds(btn)
  AvgData:AvgEditorTempData(NovaAPI.GetInputFieldText(self._mapNode.inputConditionIds), false)
  NovaAPI.SetInputFieldText(self._mapNode.inputConditionIds, "")
end

function AvgEditorCtrl:OnBtnClick_AddIfTrueData(btn)
  AvgData:AvgEditorTempIfTrueData(NovaAPI.GetInputFieldText(self._mapNode.inputIfTrueData), true)
  NovaAPI.SetInputFieldText(self._mapNode.inputIfTrueData, "")
end

function AvgEditorCtrl:OnBtnClick_SubIfTrueData(btn)
  AvgData:AvgEditorTempIfTrueData(NovaAPI.GetInputFieldText(self._mapNode.inputIfTrueData), false)
  NovaAPI.SetInputFieldText(self._mapNode.inputIfTrueData, "")
end

function AvgEditorCtrl:OnBtnClick_OpenShakeEditor(btn)
  self:SwitchRoot(5)
  Actor2DManager.SetActor2D_PNG(self._mapNode.trActor2D_PNG, PanelId.MainView, 103, 10301)
end

function AvgEditorCtrl:OnBtnClick_CloseShakeEditor(btn)
  self:SwitchRoot(1)
  Actor2DManager.UnsetActor2D()
end

function AvgEditorCtrl:_SetTimeScale(sAvgIdHead)
  local nTimeScale = 1
  if sAvgIdHead == "BB" or sAvgIdHead == "BT" then
    nTimeScale = 0
  end
  CS_UNITY.Time.timeScale = nTimeScale
end

function AvgEditorCtrl:OnDD_TextLan()
  local nLanIdx = NovaAPI.GetDropDownValue(self._mapNode.ddLanguage) + 1
  if self._panel.nCurLanguageIdx ~= nLanIdx then
    self._panel.nCurLanguageIdx = nLanIdx
    self._panel.sTxtLan = AllEnum.LanguageInfo[self._panel.nCurLanguageIdx][1]
    Settings.sCurrentTxtLanguage = self._panel.sTxtLan
    NovaAPI.SetCur_TextLanguage(self._panel.sTxtLan)
    PanelManager.OnConfirmBackToLogIn()
  end
end

function AvgEditorCtrl:OnDD_VoLan(dd)
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
  self._panel.sVoLan = sVoLan
  NovaAPI.SetCur_VoiceLanguage(self._panel.sVoLan)
  Settings.sCurrentVoLanguage = self._panel.sVoLan
  if dd == self._mapNode.ddVoLan then
    NovaAPI.SetDDValueWithoutNotify(self._mapNode.ddVoLanInCmdList, nIndex)
  elseif dd == self._mapNode.ddVoLanInCmdList then
    NovaAPI.SetDDValueWithoutNotify(self._mapNode.ddVoLan, nIndex)
    self._mapNode.loopSV:ForceRefresh()
  end
end

function AvgEditorCtrl:OnBtn_Back()
  EventManager.Hit(EventId.ClosePanel, PanelId.AvgEditor)
end

function AvgEditorCtrl:OnBtnClick_PreviewShake(btn)
  local node = self._mapNode
  local bLoop = NovaAPI.GetToggleIsOn(node.tog_LOOP)
  local tbVector3Pos = {
    {},
    {},
    {},
    {},
    {}
  }
  local tbVector3Rot = {
    {},
    {},
    {},
    {},
    {}
  }
  for i = 1, 3 do
    if i == 1 then
      tbVector3Pos[1][1] = tonumber(NovaAPI.GetInputFieldText(node.input_Pos[i])) or 0
      tbVector3Pos[2][1] = tonumber(NovaAPI.GetInputFieldText(node.input_PosTime[i])) or 0
      tbVector3Pos[3][1] = tonumber(NovaAPI.GetInputFieldText(node.input_PosCount[i])) or 0
      tbVector3Pos[4][1] = NovaAPI.GetToggleIsOn(node.tog_PosBothDir[i]) == true and 1 or 0
      tbVector3Pos[5][1] = NovaAPI.GetToggleIsOn(node.tog_PosDamping[i]) == true and 1 or 0
      tbVector3Rot[1][1] = tonumber(NovaAPI.GetInputFieldText(node.input_Rot[i])) or 0
      tbVector3Rot[2][1] = tonumber(NovaAPI.GetInputFieldText(node.input_RotTime[i])) or 0
      tbVector3Rot[3][1] = tonumber(NovaAPI.GetInputFieldText(node.input_RotCount[i])) or 0
      tbVector3Rot[4][1] = NovaAPI.GetToggleIsOn(node.tog_RotBothDir[i]) == true and 1 or 0
      tbVector3Rot[5][1] = NovaAPI.GetToggleIsOn(node.tog_RotDamping[i]) == true and 1 or 0
    elseif i == 2 then
      tbVector3Pos[1][2] = tonumber(NovaAPI.GetInputFieldText(node.input_Pos[i])) or 0
      tbVector3Pos[2][2] = tonumber(NovaAPI.GetInputFieldText(node.input_PosTime[i])) or 0
      tbVector3Pos[3][2] = tonumber(NovaAPI.GetInputFieldText(node.input_PosCount[i])) or 0
      tbVector3Pos[4][2] = NovaAPI.GetToggleIsOn(node.tog_PosBothDir[i]) == true and 1 or 0
      tbVector3Pos[5][2] = NovaAPI.GetToggleIsOn(node.tog_PosDamping[i]) == true and 1 or 0
      tbVector3Rot[1][2] = tonumber(NovaAPI.GetInputFieldText(node.input_Rot[i])) or 0
      tbVector3Rot[2][2] = tonumber(NovaAPI.GetInputFieldText(node.input_RotTime[i])) or 0
      tbVector3Rot[3][2] = tonumber(NovaAPI.GetInputFieldText(node.input_RotCount[i])) or 0
      tbVector3Rot[4][2] = NovaAPI.GetToggleIsOn(node.tog_RotBothDir[i]) == true and 1 or 0
      tbVector3Rot[5][2] = NovaAPI.GetToggleIsOn(node.tog_RotDamping[i]) == true and 1 or 0
    elseif i == 3 then
      tbVector3Pos[1][3] = tonumber(NovaAPI.GetInputFieldText(node.input_Pos[i])) or 0
      tbVector3Pos[2][3] = tonumber(NovaAPI.GetInputFieldText(node.input_PosTime[i])) or 0
      tbVector3Pos[3][3] = tonumber(NovaAPI.GetInputFieldText(node.input_PosCount[i])) or 0
      tbVector3Pos[4][3] = NovaAPI.GetToggleIsOn(node.tog_PosBothDir[i]) == true and 1 or 0
      tbVector3Pos[5][3] = NovaAPI.GetToggleIsOn(node.tog_PosDamping[i]) == true and 1 or 0
      tbVector3Rot[1][3] = tonumber(NovaAPI.GetInputFieldText(node.input_Rot[i])) or 0
      tbVector3Rot[2][3] = tonumber(NovaAPI.GetInputFieldText(node.input_RotTime[i])) or 0
      tbVector3Rot[3][3] = tonumber(NovaAPI.GetInputFieldText(node.input_RotCount[i])) or 0
      tbVector3Rot[4][3] = NovaAPI.GetToggleIsOn(node.tog_RotBothDir[i]) == true and 1 or 0
      tbVector3Rot[5][3] = NovaAPI.GetToggleIsOn(node.tog_RotDamping[i]) == true and 1 or 0
    end
  end
  NovaAPI.StopShakeEffect(node.eftShake)
  NovaAPI.DoShakeEffect(node.eftShake, tbVector3Pos, tbVector3Rot, bLoop)
end

function AvgEditorCtrl:OnBtnClick_Output(btn)
  local node = self._mapNode
  local bLoop = NovaAPI.GetToggleIsOn(node.tog_LOOP)
  local tbVector3Pos = {
    {},
    {},
    {},
    {},
    {}
  }
  local tbVector3Rot = {
    {},
    {},
    {},
    {},
    {}
  }
  for i = 1, 3 do
    if i == 1 then
      tbVector3Pos[1][1] = tonumber(NovaAPI.GetInputFieldText(node.input_Pos[i])) or 0
      tbVector3Pos[2][1] = tonumber(NovaAPI.GetInputFieldText(node.input_PosTime[i])) or 0
      tbVector3Pos[3][1] = tonumber(NovaAPI.GetInputFieldText(node.input_PosCount[i])) or 0
      tbVector3Pos[4][1] = NovaAPI.GetToggleIsOn(node.tog_PosBothDir[i]) == true and 1 or 0
      tbVector3Pos[5][1] = NovaAPI.GetToggleIsOn(node.tog_PosDamping[i]) == true and 1 or 0
      tbVector3Rot[1][1] = tonumber(NovaAPI.GetInputFieldText(node.input_Rot[i])) or 0
      tbVector3Rot[2][1] = tonumber(NovaAPI.GetInputFieldText(node.input_RotTime[i])) or 0
      tbVector3Rot[3][1] = tonumber(NovaAPI.GetInputFieldText(node.input_RotCount[i])) or 0
      tbVector3Rot[4][1] = NovaAPI.GetToggleIsOn(node.tog_RotBothDir[i]) == true and 1 or 0
      tbVector3Rot[5][1] = NovaAPI.GetToggleIsOn(node.tog_RotDamping[i]) == true and 1 or 0
    elseif i == 2 then
      tbVector3Pos[1][2] = tonumber(NovaAPI.GetInputFieldText(node.input_Pos[i])) or 0
      tbVector3Pos[2][2] = tonumber(NovaAPI.GetInputFieldText(node.input_PosTime[i])) or 0
      tbVector3Pos[3][2] = tonumber(NovaAPI.GetInputFieldText(node.input_PosCount[i])) or 0
      tbVector3Pos[4][2] = NovaAPI.GetToggleIsOn(node.tog_PosBothDir[i]) == true and 1 or 0
      tbVector3Pos[5][2] = NovaAPI.GetToggleIsOn(node.tog_PosDamping[i]) == true and 1 or 0
      tbVector3Rot[1][2] = tonumber(NovaAPI.GetInputFieldText(node.input_Rot[i])) or 0
      tbVector3Rot[2][2] = tonumber(NovaAPI.GetInputFieldText(node.input_RotTime[i])) or 0
      tbVector3Rot[3][2] = tonumber(NovaAPI.GetInputFieldText(node.input_RotCount[i])) or 0
      tbVector3Rot[4][2] = NovaAPI.GetToggleIsOn(node.tog_RotBothDir[i]) == true and 1 or 0
      tbVector3Rot[5][2] = NovaAPI.GetToggleIsOn(node.tog_RotDamping[i]) == true and 1 or 0
    elseif i == 3 then
      tbVector3Pos[1][3] = tonumber(NovaAPI.GetInputFieldText(node.input_Pos[i])) or 0
      tbVector3Pos[2][3] = tonumber(NovaAPI.GetInputFieldText(node.input_PosTime[i])) or 0
      tbVector3Pos[3][3] = tonumber(NovaAPI.GetInputFieldText(node.input_PosCount[i])) or 0
      tbVector3Pos[4][3] = NovaAPI.GetToggleIsOn(node.tog_PosBothDir[i]) == true and 1 or 0
      tbVector3Pos[5][3] = NovaAPI.GetToggleIsOn(node.tog_PosDamping[i]) == true and 1 or 0
      tbVector3Rot[1][3] = tonumber(NovaAPI.GetInputFieldText(node.input_Rot[i])) or 0
      tbVector3Rot[2][3] = tonumber(NovaAPI.GetInputFieldText(node.input_RotTime[i])) or 0
      tbVector3Rot[3][3] = tonumber(NovaAPI.GetInputFieldText(node.input_RotCount[i])) or 0
      tbVector3Rot[4][3] = NovaAPI.GetToggleIsOn(node.tog_RotBothDir[i]) == true and 1 or 0
      tbVector3Rot[5][3] = NovaAPI.GetToggleIsOn(node.tog_RotDamping[i]) == true and 1 or 0
    end
  end
  local sOutput = "{--[[幅度]]{%s,%s,%s},--[[周期]]{%s,%s,%s},--[[次数]]{%s,%s,%s},--[[双向]]{%s,%s,%s},--[[衰减]]{%s,%s,%s}},{--[[幅度]]{%s,%s,%s},--[[周期]]{%s,%s,%s},--[[次数]]{%s,%s,%s},--[[双向]]{%s,%s,%s},--[[衰减]]{%s,%s,%s}},--[[循环]]%s"
  sOutput = string.format(sOutput, tbVector3Pos[1][1], tbVector3Pos[1][2], tbVector3Pos[1][3], tbVector3Pos[2][1], tbVector3Pos[2][2], tbVector3Pos[2][3], tbVector3Pos[3][1], tbVector3Pos[3][2], tbVector3Pos[3][3], tbVector3Pos[4][1], tbVector3Pos[4][2], tbVector3Pos[4][3], tbVector3Pos[5][1], tbVector3Pos[5][2], tbVector3Pos[5][3], tbVector3Rot[1][1], tbVector3Rot[1][2], tbVector3Rot[1][3], tbVector3Rot[2][1], tbVector3Rot[2][2], tbVector3Rot[2][3], tbVector3Rot[3][1], tbVector3Rot[3][2], tbVector3Rot[3][3], tbVector3Rot[4][1], tbVector3Rot[4][2], tbVector3Rot[4][3], tbVector3Rot[5][1], tbVector3Rot[5][2], tbVector3Rot[5][3], bLoop)
  NovaAPI.SetInputFieldText(node.input_Output, sOutput)
end

function AvgEditorCtrl:OnBtnClick_Input(btn)
  local sPresetShakeData = NovaAPI.GetInputFieldText(self._mapNode.input_Input)
  local tbVector3Pos, tbVector3Rot, bLoop
  if false then
    local tbData = load("return " .. sPresetShakeData)()
    bLoop = false
    local px = tbData.nPosX
    local py = tbData.nPosY
    local rx = tbData.nRotX
    local ry = tbData.nRotY
    local rz = tbData.nRotZ
    local t = tbData.nTime
    local n = tbData.nCount
    local nBothDir = tbData.bBothDir == true and 1 or 0
    local nDamping = tbData.bFixShake == false and 1 or 0
    tbVector3Pos = {
      {
        px,
        py,
        0
      },
      {
        t,
        t,
        0
      },
      {
        n,
        n,
        0
      },
      {
        nBothDir,
        nBothDir,
        nBothDir
      },
      {
        nDamping,
        nDamping,
        nDamping
      }
    }
    tbVector3Rot = {
      {
        rx,
        ry,
        rz
      },
      {
        t,
        t,
        t
      },
      {
        n,
        n,
        n
      },
      {
        nBothDir,
        nBothDir,
        nBothDir
      },
      {
        nDamping,
        nDamping,
        nDamping
      }
    }
  else
    tbVector3Pos, tbVector3Rot, bLoop = load("return " .. sPresetShakeData)()
  end
  local node = self._mapNode
  NovaAPI.SetToggleIsOn(node.tog_LOOP, bLoop)
  for i = 1, 3 do
    NovaAPI.SetInputFieldText(node.input_Pos[i], self:FormatNum(tbVector3Pos[1][i], true))
    NovaAPI.SetInputFieldText(node.input_PosTime[i], self:FormatNum(tbVector3Pos[2][i], true))
    NovaAPI.SetInputFieldText(node.input_PosCount[i], self:FormatNum(tbVector3Pos[3][i], true))
    NovaAPI.SetToggleIsOn(node.tog_PosBothDir[i], tbVector3Pos[4][i] == 1)
    NovaAPI.SetToggleIsOn(node.tog_PosDamping[i], tbVector3Pos[5][i] == 1)
    NovaAPI.SetInputFieldText(node.input_Rot[i], self:FormatNum(tbVector3Rot[1][i], true))
    NovaAPI.SetInputFieldText(node.input_RotTime[i], self:FormatNum(tbVector3Rot[2][i], true))
    NovaAPI.SetInputFieldText(node.input_RotCount[i], self:FormatNum(tbVector3Rot[3][i], true))
    NovaAPI.SetToggleIsOn(node.tog_RotBothDir[i], tbVector3Rot[4][i] == 1)
    NovaAPI.SetToggleIsOn(node.tog_RotDamping[i], tbVector3Rot[5][i] == 1)
  end
end

function AvgEditorCtrl:OnBtnClick_OpenAudioVol(btn)
  self._mapNode.goAudioVolEditor:SetActive(true)
  WwiseAudioManager.Instance.MusicVolume = 0
  NovaAPI.SetInputFieldText(self._mapNode.inputBgmVol, 0)
  NovaAPI.SetSliderValue(self._mapNode.SldBgmVol, 0)
end

function AvgEditorCtrl:OnBtnClick_CloseAudioVol(btn)
  self._mapNode.goAudioVolEditor:SetActive(false)
  WwiseAudioManager.Instance:PostEvent("avg_track1_stop")
  NovaAPI.SetInputFieldText(self._mapNode.inputAvgBGM, "")
  NovaAPI.SetInputFieldText(self._mapNode.inputAvgAudio, "")
  if self.sPreviewAudioName ~= nil and self.sPreviewAudioName ~= "" then
    WwiseAudioManager.Instance:PlaySound(self.sPreviewAudioName .. "_stop")
    self.sPreviewAudioName = nil
  end
end

function AvgEditorCtrl:OnBtnClick_PlayAvgBGM(btn)
  local sName = NovaAPI.GetInputFieldText(self._mapNode.inputAvgBGM)
  if sName ~= "" then
    WwiseAudioManager.Instance:PostEvent("music_avg_volume100_0s")
    WwiseAudioManager.Instance:PostEvent("avg_track1_stop")
    WwiseAudioManager.Instance:SetState("avg_track1", sName)
    WwiseAudioManager.Instance:PostEvent("avg_track1")
  end
end

function AvgEditorCtrl:OnSld_AvgBgmVol(sld)
  NovaAPI.SetInputFieldText(self._mapNode.inputBgmVol, tostring(sld.value))
  WwiseAudioManager.Instance.MusicVolume = sld.value / 10
end

function AvgEditorCtrl:OnBtnClick_ApplyAvgBgmVol(btn)
  local nVol = tonumber(NovaAPI.GetInputFieldText(self._mapNode.inputBgmVol))
  if 0 <= nVol and nVol <= 100 then
    NovaAPI.SetSliderValue(self._mapNode.SldBgmVol, nVol)
    WwiseAudioManager.Instance.MusicVolume = nVol / 10
  else
    NovaAPI.SetInputFieldText(self._mapNode.inputBgmVol, tostring(NovaAPI.GetSliderValue(self._mapNode.SldBgmVol)))
  end
end

function AvgEditorCtrl:OnBtnClick_PlayAvgAudio(btn)
  local sName = NovaAPI.GetInputFieldText(self._mapNode.inputAvgAudio)
  if sName ~= "" then
    if self.sPreviewAudioName ~= nil and self.sPreviewAudioName ~= "" then
      WwiseAudioManager.Instance:PlaySound(self.sPreviewAudioName .. "_stop")
    end
    WwiseAudioManager.Instance:PlaySound(sName)
    self.sPreviewAudioName = sName
  end
end

function AvgEditorCtrl:OnBtnClick_ConfirmGroupId()
  local sGroupId = NovaAPI.GetInputFieldText(self._mapNode.inputGroupId)
  if sGroupId == "" then
    if self.sPreviewHead == "BB" or self.sPreviewHead == "DP" then
      sGroupId = "PLAY_ALL_PLAY_ALL"
    else
      local msg = "请输入组ID"
      if self._panel.nCurLanguageIdx ~= 0 then
        msg = "Please input Group Id."
      end
      EventManager.Hit(EventId.OpenMessageBox, msg)
      return
    end
  end
  self._mapNode.goSelectGroupId:SetActive(false)
  local sAvgId = self:GetCurrentAvgId()
  if sAvgId ~= nil then
    NovaAPI.SetText(self._mapNode.txtAvgStoryId, sAvgId)
    self:SwitchRoot(2)
    if self.sPreviewHead == "BB" then
      EventManager.Hit(EventId.AvgBubbleShow, sAvgId, sGroupId, self._panel.sTxtLan, self._panel.sVoLan)
    else
      local nStartCMDID = tonumber(NovaAPI.GetInputFieldText(self._mapNode.inputStartCmdID))
      EventManager.Hit("StoryDialog_DialogStart", sAvgId, self._panel.sTxtLan, self._panel.sVoLan, sGroupId, nStartCMDID)
    end
  end
  NovaAPI.SetInputFieldText(self._mapNode.inputGroupId, "")
end

function AvgEditorCtrl:OnBtnClick_AutoAdjustData()
end

function AvgEditorCtrl:OnBtnClick_Skip(btn)
  AVG_EDITOR_PLAYING = false
  if self.sPreviewHead == "BB" then
    EventManager.Hit(EventId.AvgBubbleExit)
    self:OnEvent_AvgEnd()
  else
    EventManager.Hit(EventId.AvgSkipCheck)
  end
end

function AvgEditorCtrl:OnEvent_AvgEnd()
  WwiseAudioManager.Instance:PostEvent("avg_enter")
  self:SwitchRoot(1)
  self:_SetTimeScale("BB")
end

function AvgEditorCtrl:CreateCmdIns(sAvgId)
  self.sAvgCfgPath = self.sRequireAvgCfgPath .. sAvgId
  package.loaded[self.sAvgCfgPath] = nil
  self.tbAvgCfg = require(self.sAvgCfgPath)
  local nCount = #self.tbAvgCfg
  self._mapNode.loopSV:Init(nCount, self, self.OnRefreshGrid, self.OnGridBtnClick)
  local nJumpToID = tonumber(NovaAPI.GetInputFieldText(self._mapNode.inputJumpToID))
  if nJumpToID ~= nil and 0 < nJumpToID and nCount >= nJumpToID then
    self:OnEditEnd_inputJumpToID()
    self._mapNode.loopSV:ForceRefresh()
  end
  self.mapEnableChoicePreivew = {
    SetChoiceJumpTo = {},
    SetMajorChoiceJumpTo = {},
    SetPersonalityChoiceJumpTo = {},
    SetPhoneMsgChoiceJumpTo = {}
  }
end

function AvgEditorCtrl:OnRefreshGrid(go)
  local nTransformIndex = tonumber(go.name)
  if nTransformIndex == nil then
    if go ~= nil then
      local tr = go.transform
      local nCount = tr.childCount - 1
      for i = 3, nCount do
        tr:GetChild(i).gameObject:SetActive(false)
      end
    end
    return
  end
  local nCmdId = nTransformIndex + 1
  local tbCmdData = self.tbAvgCfg[nCmdId]
  local sCmdName = tbCmdData.cmd
  local tr = go.transform
  NovaAPI.SetImageColor(tr:Find("imgGridColor"):GetComponent("Image"), self:GetCmdColor(sCmdName))
  local trToggle = tr:Find("togSelected")
  trToggle.localScale = self.nCurTransformIndex == nTransformIndex and Vector3.one or Vector3.zero
  NovaAPI.SetToggleIsOn(trToggle:GetComponent("Toggle"), self.nCurTransformIndex == nTransformIndex)
  NovaAPI.SetText(tr:Find("txtIdx"):GetComponent("Text"), string.format("id:%d", nCmdId))
  local nCount = tr.childCount - 1
  for i = 3, nCount do
    local trCmd = tr:GetChild(i)
    if trCmd.name == sCmdName then
      trCmd.gameObject:SetActive(true)
      local func = CmdInfo["VisualizedCmd_" .. sCmdName]
      if type(func) == "function" then
        self.bIgnoreValueChange = true
        func(self, trCmd, tbCmdData.param)
        self.bIgnoreValueChange = false
      end
    else
      trCmd.gameObject:SetActive(false)
    end
  end
end

function AvgEditorCtrl:OnGridBtnClick(go)
  if type(self.nCurTransformIndex) == "number" then
    local tr = self._mapNode.cmdContent:Find(tostring(self.nCurTransformIndex))
    if tr ~= nil then
      local trToggle = tr:Find("togSelected")
      trToggle.localScale = Vector3.zero
      NovaAPI.SetToggleIsOn(trToggle:GetComponent("Toggle"), false)
    end
  end
  self.nCurTransformIndex = tonumber(go.name)
  local trTog = go.transform:Find("togSelected")
  NovaAPI.SetToggleIsOn(trTog:GetComponent("Toggle"), true)
  trTog.localScale = Vector3.one
  if self.objCtrl_AvgEditorQuickPreview == nil then
    self.objCtrl_AvgEditorQuickPreview = self._panel:GetCtrlObj("AvgEditorQuickPreview")
  end
  if self.objCtrl_AvgEditorQuickPreview ~= nil then
    local nCmdId = self.nCurTransformIndex + 1
    local tbCmdData = self.tbAvgCfg[nCmdId]
    self.objCtrl_AvgEditorQuickPreview:SetQuickPreview(tbCmdData, self._panel.nCurLanguageIdx)
  end
end

function AvgEditorCtrl:OnValueChanged(go)
  if self.bIgnoreValueChange == true then
    return
  end
  local n = tonumber(go.name)
  if n == nil then
    if go == nil then
      printError("刷新指令格子错误！！")
    end
    printError(go.name)
    return
  end
  local nCmdId = n + 1
  local tbCmdData = self.tbAvgCfg[nCmdId]
  local sCmdName = tbCmdData.cmd
  local trCmd = go.transform:Find(sCmdName)
  local func = CmdInfo["ParseParam_" .. sCmdName]
  if type(func) == "function" then
    func(self, trCmd, self.tbTempCmdParam or tbCmdData.param)
  end
  if self.mapEnableChoicePreivew[sCmdName] ~= nil then
    self:Proc_EnableChoicePreview(tbCmdData)
  end
end

function AvgEditorCtrl:Proc_EnableChoicePreview(tbCmdData)
  local sCmd = tbCmdData.cmd
  local mapJumpTo = self.mapEnableChoicePreivew[sCmd]
  local sGroupId = tostring(tbCmdData.param[1])
  local sJumpIdx = tostring(tbCmdData.param[2])
  local bEnable = tbCmdData.param.enable_in_visualize_preview == true
  if bEnable == true then
    mapJumpTo[sGroupId] = sJumpIdx
  else
    mapJumpTo[sGroupId] = "1"
  end
  for i, v in ipairs(self.tbAvgCfg) do
    if v.cmd == sCmd and tostring(v.param[1]) == sGroupId then
      v.param.enable_in_visualize_preview = mapJumpTo[sGroupId] == tostring(v.param[2])
    end
  end
end

function AvgEditorCtrl:OnBtnClick_BackToMain(btn)
  delChildren(self._mapNode.cmdContent)
  self.nCurTransformIndex = nil
  self.tbAvgCfg = nil
  self._panel.tbAvgPreset = nil
  package.loaded[self.sAvgCfgPath] = nil
  package.loaded[self.sRequireAvgCharPath] = nil
  package.loaded[self.sRequireAvgContactsPath] = nil
  package.loaded[self.sRequireAvgUITextPath] = nil
  package.loaded[self.sRequireAvgPresetPath] = nil
  self:SwitchRoot(1)
  self:_SetTimeScale("BB")
end

function AvgEditorCtrl:OnEditEnd_inputJumpToID()
  local nJumpToID = tonumber(NovaAPI.GetInputFieldText(self._mapNode.inputJumpToID))
  if nJumpToID ~= nil then
    self._mapNode.loopSV:SetScrollGridPos(nJumpToID - 1, 0)
  end
end

function AvgEditorCtrl:OnDD_Gender(dd)
  local nIndex = NovaAPI.GetDropDownValue(dd)
  local bIsMale = nIndex == 1
  PlayerBaseData:SetPlayerSex(bIsMale)
  self._panel.bIsPlayerMale = bIsMale
  if dd == self._mapNode.ddGender then
    NovaAPI.SetDDValueWithoutNotify(self._mapNode.ddGenderInCmdList, nIndex)
  elseif dd == self._mapNode.ddGenderInCmdList then
    NovaAPI.SetDDValueWithoutNotify(self._mapNode.ddGender, nIndex)
    self._mapNode.loopSV:ForceRefresh()
  end
end

function AvgEditorCtrl:OnBtnClick_SaveCmd(btn)
  local sFileFullPath = self.sWriteFileAvgCfgPath .. NovaAPI.GetText(self._mapNode.txtAvgStoryId) .. ".lua"
  self:SAVE_AVG_CONFIG(self.tbAvgCfg, sFileFullPath)
end

function AvgEditorCtrl:SAVE_AVG_CONFIG(tbAvgCfg, sFileFullPath)
  local tbLineData = {}
  for i, tbCmdData in ipairs(tbAvgCfg) do
    local func = CmdInfo["TbDataToCfgStr_" .. tbCmdData.cmd]
    if type(func) == "function" then
      local sCmdToString = func(self, tbCmdData.param)
      sCmdToString = string.gsub(sCmdToString, "\"nil\"", "nil")
      if i == 1 then
        sCmdToString = "return {" .. sCmdToString
      end
      table.insert(tbLineData, sCmdToString)
    end
  end
  if 0 < #tbLineData then
    table.insert(tbLineData, "}")
  else
    table.insert(tbLineData, "return {")
    table.insert(tbLineData, "}")
  end
  self:DO_SAVE_LUA_FILE(sFileFullPath, tbLineData)
end

function AvgEditorCtrl:DO_SAVE_LUA_FILE(sFileFullPath, data)
  local fs = CS_SYS_IO.FileStream(sFileFullPath, CS_SYS_IO.FileMode.Create)
  local sw = CS_SYS_IO.StreamWriter(fs, CS_SYS.Text.UTF8Encoding(false))
  if type(data) == "table" then
    for i, v in ipairs(data) do
      sw:WriteLine(v)
    end
  elseif type(data) == "string" then
    sw:Write(data)
  end
  sw:Close()
  fs:Close()
end

function AvgEditorCtrl:OnBtnClick_MoveCmdUp(btn)
  if self.nCurTransformIndex == nil or self.nCurTransformIndex <= 0 then
    return
  end
  local nCmdId = self.nCurTransformIndex + 1
  local tbCurCmdData = self.tbAvgCfg[nCmdId]
  local tbAboveCmdData = self.tbAvgCfg[self.nCurTransformIndex]
  self.tbAvgCfg[self.nCurTransformIndex] = tbCurCmdData
  self.tbAvgCfg[nCmdId] = tbAboveCmdData
  self.nCurTransformIndex = self.nCurTransformIndex - 1
  self._mapNode.loopSV:ForceRefresh()
end

function AvgEditorCtrl:OnBtnClick_MoveCmdDown(btn)
  if self.nCurTransformIndex == nil or self.nCurTransformIndex >= #self.tbAvgCfg - 1 then
    return
  end
  local nCmdId = self.nCurTransformIndex + 1
  local tbCurCmdData = self.tbAvgCfg[nCmdId]
  local tbNextCmdData = self.tbAvgCfg[nCmdId + 1]
  self.tbAvgCfg[nCmdId + 1] = tbCurCmdData
  self.tbAvgCfg[nCmdId] = tbNextCmdData
  self.nCurTransformIndex = self.nCurTransformIndex + 1
  self._mapNode.loopSV:ForceRefresh()
end

function AvgEditorCtrl:OnBtnClick_VisualizedEditCmd(btn)
  if self.nCurTransformIndex == nil then
    return
  end
  local nCmdId = self.nCurTransformIndex + 1
  local tbCmdData = self.tbAvgCfg[nCmdId]
  local sCmdName = tbCmdData.cmd
  local nIdxOfGroupA = table.indexof(self.tbGroupA, sCmdName)
  local nIdxOfGroupB = table.indexof(self.tbGroupB, sCmdName)
  local nIdxOfGroupC = table.indexof(self.tbGroupC, sCmdName)
  local nIdxOfGroupD = table.indexof(self.tbGroupD, sCmdName)
  local nIdxOfGroupE = table.indexof(self.tbGroupE, sCmdName)
  local nIdxOfGroupF = table.indexof(self.tbGroupF, sCmdName)
  if nIdxOfGroupA <= 0 and nIdxOfGroupB <= 0 and nIdxOfGroupC <= 0 and nIdxOfGroupD <= 0 and nIdxOfGroupE <= 0 and nIdxOfGroupF <= 0 then
    return
  end
  self:SwitchRoot(4)
  self._mapNode.grid_full.name = tostring(self.nCurTransformIndex)
  NovaAPI.SetText(self._mapNode.txtCmdIndex, string.format("id:%d", nCmdId))
  self.tbTempCmdParam = {}
  for k, v in pairs(tbCmdData.param) do
    self.tbTempCmdParam[k] = v
  end
  local nCount = self._mapNode.grid_full.childCount - 1
  for i = 0, nCount do
    local trCmd = self._mapNode.grid_full:GetChild(i)
    if trCmd.name == sCmdName then
      trCmd.gameObject:SetActive(true)
      local func = CmdInfo["VisualizedCmd_" .. sCmdName]
      if type(func) == "function" then
        self.bIgnoreValueChange = true
        func(self, trCmd, self.tbTempCmdParam)
        self.bIgnoreValueChange = false
      end
    else
      trCmd.gameObject:SetActive(false)
    end
  end
  VISUALIZED_EDIT_CMD = true
  self:OnBtnClick_Preview()
end

function AvgEditorCtrl:OnBtnClick_OpenAddCmdWindow(btn)
  if self.nCurTransformIndex == nil and #self.tbAvgCfg > 0 then
    return
  end
  self._mapNode.goAddCmdWindow:SetActive(true)
end

function AvgEditorCtrl:OnBtnClick_OpenDelCmdWindow(btn)
  if self.nCurTransformIndex == nil then
    return
  end
  self._mapNode.goDelCmdWindow:SetActive(true)
end

function AvgEditorCtrl:OnBtnClick_AddCmd(btn)
  local sCmdName
  
  local function find_cmd(trLayoutCmd)
    if sCmdName == nil then
      local nCount = trLayoutCmd.childCount - 1
      for i = 0, nCount do
        local trChild = trLayoutCmd:GetChild(i)
        if NovaAPI.GetToggleIsOn(trChild:GetComponent("Toggle")) == true then
          sCmdName = trChild.name
          break
        end
      end
    end
  end
  
  find_cmd(self._mapNode.layoutCmd_Bg)
  find_cmd(self._mapNode.layoutCmd_Char)
  find_cmd(self._mapNode.layoutCmd_Talk)
  find_cmd(self._mapNode.layoutCmd_Choice)
  find_cmd(self._mapNode.layoutCmd_Audio)
  find_cmd(self._mapNode.layoutCmd_Other)
  if sCmdName == nil then
    return
  end
  local nNewCmdId
  if self.nCurTransformIndex == nil then
    if #self.tbAvgCfg == 0 then
      nNewCmdId = 1
    else
      return
    end
  else
    nNewCmdId = self.nCurTransformIndex + 2
  end
  if nNewCmdId == nil then
    return
  end
  local func = CmdInfo["VisualizedCmd_" .. sCmdName]
  table.insert(self.tbAvgCfg, nNewCmdId, {
    cmd = sCmdName,
    param = func(self)
  })
  self.nCurTransformIndex = nNewCmdId - 1
  self._mapNode.loopSV:Init(#self.tbAvgCfg, self, self.OnRefreshGrid, self.OnGridBtnClick, true)
  self._mapNode.goAddCmdWindow:SetActive(false)
end

function AvgEditorCtrl:OnBtnClick_CloseAdd(btn)
  self._mapNode.goAddCmdWindow:SetActive(false)
end

function AvgEditorCtrl:OnBtnClick_DelCmd(btn)
  if self.nCurTransformIndex == nil then
    return
  end
  local nDelCmdId = self.nCurTransformIndex + 1
  table.remove(self.tbAvgCfg, nDelCmdId)
  if #self.tbAvgCfg > 0 then
    if self.nCurTransformIndex >= #self.tbAvgCfg then
      self.nCurTransformIndex = #self.tbAvgCfg - 1
    end
    self._mapNode.loopSV:Init(#self.tbAvgCfg, self, self.OnRefreshGrid, self.OnGridBtnClick, true)
  else
    self.nCurTransformIndex = nil
    self._mapNode.loopSV:Init(#self.tbAvgCfg, self, self.OnRefreshGrid, self.OnGridBtnClick)
    delChildren(self._mapNode.cmdContent)
  end
  self._mapNode.goDelCmdWindow:SetActive(false)
end

function AvgEditorCtrl:OnBtnClick_CloseDel(btn)
  self._mapNode.goDelCmdWindow:SetActive(false)
end

function AvgEditorCtrl:OnBtnClick_Preview(btn)
  local tbCmdData = self.tbAvgCfg[self.nCurTransformIndex + 1]
  local sCmdName = tbCmdData.cmd
  
  local function funcPreview(objCtrl, bRestoreAll)
    if bRestoreAll == nil then
      bRestoreAll = true
    end
    if bRestoreAll == true then
      self.objCtrl_Stage:RestoreAll(true, self:GetHistoryData_Stage(true))
      self.objCtrl_Char:RestoreAll(true, self:GetHistoryData_Char(true))
      self.objCtrl_Trans:RestoreAll(true, self:GetHistoryData_Trans(true))
      self.objCtrl_Talk:RestoreAll(true, self:GetHistoryData_Talk(true))
      self.objCtrl_Menu:RestoreAll(true)
    end
    local func = objCtrl[sCmdName]
    if type(func) == "function" then
      func(objCtrl, self.tbTempCmdParam)
    end
  end
  
  DOTween.KillAll()
  if table.indexof(self.tbGroupA, sCmdName) > 0 then
    funcPreview(self.objCtrl_Stage)
  elseif 0 < table.indexof(self.tbGroupB, sCmdName) then
    funcPreview(self.objCtrl_Char)
  elseif 0 < table.indexof(self.tbGroupC, sCmdName) then
    funcPreview(self.objCtrl_Trans)
  elseif 0 < table.indexof(self.tbGroupD, sCmdName) then
    funcPreview(self.objCtrl_Talk)
  elseif 0 < table.indexof(self.tbGroupE, sCmdName) then
    self.objCtrl_Choice:RestoreAll(true)
    funcPreview(self.objCtrl_Choice, false)
  elseif 0 < table.indexof(self.tbGroupF, sCmdName) then
    funcPreview(self.objCtrl_Menu)
  end
end

function AvgEditorCtrl:OnBtnClick_Confirm(btn)
  local tbCmdData = self.tbAvgCfg[self.nCurTransformIndex + 1]
  tbCmdData.param = self.tbTempCmdParam
  self._mapNode.loopSV:ForceRefresh()
  self:OnBtnClick_BackToList()
end

function AvgEditorCtrl:OnBtnClick_BackToList(btn)
  local tbCmdData = self.tbAvgCfg[self.nCurTransformIndex + 1]
  local sCmdName = tbCmdData.cmd
  DOTween.KillAll()
  self.objCtrl_Stage:RestoreAll(false, self:GetHistoryData_Stage(false))
  self.objCtrl_Char:RestoreAll(false, self:GetHistoryData_Char(false))
  self.objCtrl_Trans:RestoreAll(false, self:GetHistoryData_Trans(false))
  self.objCtrl_Talk:RestoreAll(false, self:GetHistoryData_Talk(false))
  self.objCtrl_Choice:RestoreAll(false)
  self.objCtrl_Menu:RestoreAll(false)
  self.tbTempCmdParam = nil
  self:SwitchRoot(3)
  VISUALIZED_EDIT_CMD = false
end

function AvgEditorCtrl:OnBtnClick_ShowParam(btn)
  self._mapNode.grid_full.localScale = Vector3.one
  self._mapNode.btnShowParam.transform.localScale = Vector3.zero
  self._mapNode.btnHideParam.transform.localScale = Vector3.one
end

function AvgEditorCtrl:OnBtnClick_HideParam(btn)
  self._mapNode.grid_full.localScale = Vector3.zero
  self._mapNode.btnShowParam.transform.localScale = Vector3.one
  self._mapNode.btnHideParam.transform.localScale = Vector3.zero
end

function AvgEditorCtrl:SetTog(tr, sName, bValue)
  NovaAPI.SetToggleIsOn(tr:Find(sName):GetComponent("Toggle"), bValue == true)
end

function AvgEditorCtrl:GetTog(tr, sName)
  return NovaAPI.GetToggleIsOn(tr:Find(sName):GetComponent("Toggle"))
end

function AvgEditorCtrl:FormatNum(nNum, bRetStr)
  if nNum == "" or nNum == nil then
    nNum = 0
  end
  local sFormattedNum = string.format("%0.3f", nNum)
  if bRetStr == true then
    return sFormattedNum
  else
    return tonumber(sFormattedNum)
  end
end

function AvgEditorCtrl:SetInputDuration(tr, sName, nValue)
  local input = tr:Find(sName):GetComponent("InputField")
  NovaAPI.SetInputFieldText(input, self:FormatNum(nValue, true))
end

function AvgEditorCtrl:GetInputDuration(tr, sName)
  local input = tr:Find(sName):GetComponent("InputField")
  local n = self:FormatNum(tonumber(NovaAPI.GetInputFieldText(input)), false)
  NovaAPI.SetInputFieldText(input, tostring(n))
  return n
end

function AvgEditorCtrl:SetDD(tr, sName, listData, nValue)
  local dd = tr:Find(sName):GetComponent("Dropdown")
  NovaAPI.ClearDropDownOptions(dd)
  NovaAPI.DropDownAddOptions(dd, listData)
  NovaAPI.SetDropDownValue(dd, nValue)
end

function AvgEditorCtrl:GetDD(tr, sName)
  local dd = tr:Find(sName):GetComponent("Dropdown")
  return NovaAPI.GetCurDDOptionsText(dd)
end

function AvgEditorCtrl:SetDDIndex(tr, sName, nValue)
  local dd = tr:Find(sName):GetComponent("Dropdown")
  NovaAPI.SetDropDownValue(dd, nValue)
end

function AvgEditorCtrl:GetDDIndex(tr, sName)
  local dd = tr:Find(sName):GetComponent("Dropdown")
  return NovaAPI.GetDropDownValue(dd)
end

function AvgEditorCtrl:SetInputNum(tr, sName, value)
  local sValue = ""
  if value ~= nil then
    sValue = tostring(value)
  end
  local input = tr:Find(sName):GetComponent("InputField")
  NovaAPI.SetInputFieldText(input, sValue)
end

function AvgEditorCtrl:GetInputNum(tr, sName, bIsIntNum)
  local value
  local input = tr:Find(sName):GetComponent("InputField")
  local sValue = NovaAPI.GetInputFieldText(input)
  if sValue ~= "" then
    if bIsIntNum == true then
      value = tonumber(sValue)
    else
      value = self:FormatNum(tonumber(sValue), false)
    end
    NovaAPI.SetInputFieldText(input, tostring(value))
  end
  return value
end

function AvgEditorCtrl:SetInputFace(tr, sName, sFace)
  local input = tr:Find(sName):GetComponent("InputField")
  NovaAPI.SetInputFieldText(input, sFace)
end

function AvgEditorCtrl:GetInputFace(tr, sName)
  local input = tr:Find(sName):GetComponent("InputField")
  local sFace = NovaAPI.GetInputFieldText(input)
  if sFace == "" then
    return nil
  end
  sFace = tostring(1000 + tonumber(sFace))
  sFace = string.sub(sFace, 2, 4)
  NovaAPI.SetInputFieldText(input, sFace)
  return sFace
end

function AvgEditorCtrl:GetBubbleInputFace(tr, sName)
  local input = tr:Find(sName):GetComponent("InputField")
  if NovaAPI.GetInputFieldText(input) == "" then
    return "002"
  end
  return NovaAPI.GetInputFieldText(input)
end

function AvgEditorCtrl:GetCharEmojiIndex(sResName)
  for i, v in ipairs(self._panel.tbAvgPreset.CharEmoji) do
    if v[3] == sResName then
      return i
    end
  end
  return 1
end

function AvgEditorCtrl:GetCharEmojiResName(nIdx)
  local mapData = self._panel.tbAvgPreset.CharEmoji[nIdx]
  return mapData[3]
end

function AvgEditorCtrl:GetCharFadeEftIndex(sResName)
  for i, v in ipairs(self._panel.tbAvgPreset.CharFadeEft) do
    if v[2] == sResName then
      return i
    end
  end
  return 1
end

function AvgEditorCtrl:GetCharFadeEftResName(nIdx)
  local mapData = self._panel.tbAvgPreset.CharFadeEft[nIdx]
  return mapData[2]
end

function AvgEditorCtrl:GetBgmVolIndex(sName)
  for i, v in ipairs(self._panel.tbAvgPreset.BgmVol) do
    if v[2] == sName then
      return i
    end
  end
  return 1
end

function AvgEditorCtrl:GetBgmVolName(nIdx)
  local mapData = self._panel.tbAvgPreset.BgmVol[nIdx]
  return mapData[2]
end

function AvgEditorCtrl:SetAvgCharId(tr, sAvgCharId)
  GameUIUtils.AvgEditor_SetCharIdName(tr:Find("input_AvgCharId"), self.tbAvgCharId, self.tbAvgCharName, sAvgCharId)
end

function AvgEditorCtrl:GetAvgCharId(tr)
  local input = tr:Find("input_AvgCharId"):GetComponent("InputField")
  return NovaAPI.GetInputFieldText(input)
end

function AvgEditorCtrl:SetResName(tr, sNodeName, tbData, sResName)
  GameUIUtils.AvgEditor_SetResName(tr:Find(sNodeName), tbData, sResName, false)
end

function AvgEditorCtrl:GetResName(tr, sNodeName)
  local input = tr:Find(sNodeName):GetComponent("InputField")
  return NovaAPI.GetInputFieldText(input)
end

function AvgEditorCtrl:SetAvgContactId(tr, sAvgContactId)
  GameUIUtils.AvgEditor_SetContactsIdName(tr:Find("input_AvgContactId"), self.tbAvgContactsId, self.tbAvgContactsName, sAvgContactId)
end

function AvgEditorCtrl:GetAvgContactId(tr)
  local input = tr:Find("input_AvgContactId"):GetComponent("InputField")
  return NovaAPI.GetInputFieldText(input)
end

function AvgEditorCtrl:SetNoteAbsolutePos(tr, sName, nPivotX, nPivotY, nPosX, nPosY)
  nPivotX = nPivotX or "不变"
  nPivotY = nPivotY or "不变"
  nPosX = nPosX or "不变"
  nPosY = nPosY or "不变"
  NovaAPI.SetText(tr:Find(sName):GetComponent("Text"), string.format([[
x':%s
y':%s

x:%s
y:%s]], tostring(nPivotX), tostring(nPivotY), tostring(nPosX), tostring(nPosY)))
end

function AvgEditorCtrl:SetNotePercentPos(tr, sName, nPercentPosX, nPercentPosY)
  local function PosPercentToV2(nX, nY)
    local nPosX, nPosY
    
    if nX == nil then
      nPosX = "不变"
    elseif nX < 0 then
      nPosX = Settings.CURRENT_CANVAS_FULL_RECT_WIDTH * nX - Settings.CURRENT_CANVAS_FULL_RECT_WIDTH * 0.5
    elseif 1 < nX then
      nPosX = Settings.CURRENT_CANVAS_FULL_RECT_WIDTH * (nX - 1) + Settings.CURRENT_CANVAS_FULL_RECT_WIDTH * 0.5
    else
      nPosX = Settings.DESIGN_SCREEN_RESOLUTION_WIDTH * nX - Settings.DESIGN_SCREEN_RESOLUTION_WIDTH * 0.5
    end
    if nY == nil then
      nPosY = "不变"
    elseif nY < 0 then
      nPosY = Settings.CURRENT_CANVAS_FULL_RECT_HEIGHT * nY - Settings.CURRENT_CANVAS_FULL_RECT_HEIGHT * 0.5
    elseif 1 < nY then
      nPosY = Settings.CURRENT_CANVAS_FULL_RECT_HEIGHT * (nY - 1) + Settings.CURRENT_CANVAS_FULL_RECT_HEIGHT * 0.5
    else
      nPosY = Settings.DESIGN_SCREEN_RESOLUTION_HEIGHT * nY - Settings.DESIGN_SCREEN_RESOLUTION_HEIGHT * 0.5
    end
    return nPosX, nPosY
  end
  
  local nPosX, nPosY = PosPercentToV2(nPercentPosX, nPercentPosY)
  NovaAPI.SetText(tr:Find(sName):GetComponent("Text"), string.format([[
x:%s
y:%s]], tostring(nPosX), tostring(nPosY)))
end

function AvgEditorCtrl:SetInputTalkContent(tr, sName, sContent)
  local s = tostring(sContent)
  if string.find(s, "==RT==") ~= nil then
    s = string.gsub(s, "==RT==", "\n")
  end
  NovaAPI.SetInputFieldText(tr:Find(sName):GetComponent("InputField"), s)
end

function AvgEditorCtrl:GetInputTalkContent(tr, sName)
  local txt = tr:Find(sName):GetComponent("InputField")
  local sContent = NovaAPI.GetInputFieldText(txt)
  if string.find(sContent, "\r\n") ~= nil then
    sContent = string.gsub(sContent, "\r\n", "==rn==")
  end
  if string.find(sContent, "\r") ~= nil then
    sContent = string.gsub(sContent, "\r", "==rn==")
  end
  if string.find(sContent, "==rn====W==") ~= nil then
    sContent = string.gsub(sContent, "==rn====W==", "==W==")
  end
  if string.find(sContent, "==rn====B==") ~= nil then
    sContent = string.gsub(sContent, "==rn====B==", "==B==")
  end
  if string.find(sContent, "==rn====P==") ~= nil then
    sContent = string.gsub(sContent, "==rn====P==", "==P==")
  end
  if string.find(sContent, "==rn==") ~= nil then
    sContent = string.gsub(sContent, "==rn==", "==RT==")
  end
  if string.find(sContent, "==RT==") ~= nil then
    sContent = string.gsub(sContent, "==RT==", "\n")
  end
  NovaAPI.SetInputFieldText(txt, sContent)
  if string.find(sContent, "\n") ~= nil then
    sContent = string.gsub(sContent, "\n", "==RT==")
  end
  return sContent
end

function AvgEditorCtrl:SetAvgTalkVoice(tr, voiceName, canSkip)
  local root = tr:Find("goVoice")
  local voiceContent = root:Find("inputContent"):GetComponent("InputField")
  NovaAPI.SetInputFieldText(voiceContent, voiceName)
  local togVoice = root:Find("togSkip"):GetComponent("Toggle")
  NovaAPI.SetToggleIsOn(togVoice, canSkip)
end

function AvgEditorCtrl:GetAvgTalkVoice(tr)
  local root = tr:Find("goVoice")
  local voiceContent = root:Find("inputContent"):GetComponent("InputField")
  local togVoice = root:Find("togSkip"):GetComponent("Toggle")
  return NovaAPI.GetInputFieldText(voiceContent), NovaAPI.GetToggleIsOn(togVoice)
end

function AvgEditorCtrl:Check_SkipChoiceContent(sCmdName, tbParam)
  local nCount = #self.tbChoiceCmdName
  local mapJumpTo = self.mapEnableChoicePreivew[sCmdName]
  if mapJumpTo ~= nil then
    local sGroupId = tostring(tbParam[1])
    local sIdx = tostring(tbParam[2])
    local sEnabledIdx = mapJumpTo[sGroupId] or "1"
    if sCmdName == self.tbChoiceCmdName[nCount] and sGroupId == self.tbChoiceGroupId[nCount] then
      self.tbChoiceEnabled[nCount] = sIdx == sEnabledIdx
    else
      table.insert(self.tbChoiceCmdName, sCmdName)
      table.insert(self.tbChoiceGroupId, sGroupId)
      table.insert(self.tbChoiceEnabled, sIdx == sEnabledIdx)
    end
    return true
  else
    local sLastCmdName = self.tbChoiceCmdName[nCount]
    local sLastGroupId = self.tbChoiceGroupId[nCount]
    local bEnable = self.tbChoiceEnabled[nCount]
    if bEnable == nil then
      bEnable = true
    end
    if sLastCmdName == "SetChoiceJumpTo" and sCmdName == "SetChoiceEnd" and sLastGroupId == tbParam[1] then
      table.remove(self.tbChoiceCmdName, nCount)
      table.remove(self.tbChoiceGroupId, nCount)
      table.remove(self.tbChoiceEnabled, nCount)
      return true
    elseif sLastCmdName == "SetMajorChoiceJumpTo" and sCmdName == "SetMajorChoiceEnd" and sLastGroupId == tbParam[1] then
      table.remove(self.tbChoiceCmdName, nCount)
      table.remove(self.tbChoiceGroupId, nCount)
      table.remove(self.tbChoiceEnabled, nCount)
      return true
    elseif sLastCmdName == "SetPersonalityChoiceJumpTo" and sCmdName == "SetPersonalityChoiceEnd" and sLastGroupId == tbParam[1] then
      table.remove(self.tbChoiceCmdName, nCount)
      table.remove(self.tbChoiceGroupId, nCount)
      table.remove(self.tbChoiceEnabled, nCount)
      return true
    elseif sLastCmdName == "SetPhoneMsgChoiceJumpTo" and sCmdName == "SetPhoneMsgChoiceEnd" and sLastGroupId == tbParam[1] then
      table.remove(self.tbChoiceCmdName, nCount)
      table.remove(self.tbChoiceGroupId, nCount)
      table.remove(self.tbChoiceEnabled, nCount)
      return true
    else
      return bEnable == true
    end
  end
end

function AvgEditorCtrl:GetHistoryData_Stage(bPreview)
  self.tbChoiceCmdName = {}
  self.tbChoiceGroupId = {}
  self.tbChoiceEnabled = {}
  local mapData = {
    [1] = {},
    [2] = {},
    [3] = {},
    [4] = {},
    [5] = {},
    [6] = {},
    [7] = {},
    fo = {
      bMask = false,
      sName = "",
      nPosX = 0.5,
      nPosY = 0.5
    }
  }
  
  local function funcReset(nIndex, _bIn)
    mapData[nIndex] = {
      bRemoveUnloopFx = NovaAPI.GetToggleIsOn(self._mapNode.togRemoveUnloopFx),
      bIn = _bIn,
      bg = {
        sResName = "",
        nPivotX = 0.5,
        nPivotY = 0.5,
        nPosX = 0,
        nPosY = 0,
        nScale = 1,
        nGray = 0,
        nAlpha = 1,
        nBrightness = 1,
        nBlur = 0,
        bEnablePP = false,
        nRotate = 0
      },
      fg = {
        sResName = "",
        nPivotX = 0.5,
        nPivotY = 0.5,
        nPosX = 0,
        nPosY = 0,
        nScale = 1,
        nGray = 0,
        nAlpha = 1,
        nBrightness = 1,
        nBlur = 0,
        nRotate = 0
      },
      stage = {
        nPivotX = 0.5,
        nPivotY = 0.5,
        nPosX = 0,
        nPosY = 0,
        nScale = 1,
        nGray = 0,
        nBrightness = 1,
        nBlur = 0
      },
      bgfx = {},
      fgfx = {},
      topfx = {},
      filterfx = {}
    }
  end
  
  for i = 1, 7 do
    funcReset(i, i == 1)
  end
  if bPreview == false then
    return mapData
  end
  if self.nCurTransformIndex > 0 then
    local bEnable = false
    for i = 1, self.nCurTransformIndex do
      local tbCmdData = self.tbAvgCfg[i]
      local sCmdName = tbCmdData.cmd
      local tbParam = tbCmdData.param
      bEnable = self:Check_SkipChoiceContent(sCmdName, tbParam)
      local nIdx = 0
      if tbParam ~= nil and bEnable == true then
        nIdx = tbParam[1]
        if sCmdName == "SetBg" then
          nIdx = nIdx + 1
          mapData[nIdx].bIn = true
          local data = mapData[nIdx].bg
          if tbParam[8] == 1 then
            data = mapData[nIdx].fg
          end
          data.sResName = tbParam[2]
          data.nPivotX = 0.5
          data.nPivotY = 0.5
          data.nPosX = 0
          data.nPosY = 0
          data.nScale = 1
          data.nGray = 0
          data.nAlpha = 1
          data.nBrightness = 1
          data.nBlur = 0
        elseif sCmdName == "CtrlBg" then
          nIdx = nIdx + 1
          local data = mapData[nIdx].bg
          if tbParam[15] == 1 then
            data = mapData[nIdx].fg
          end
          local v2CurPivot = Vector2(data.nPivotX, data.nPivotY)
          local v2CurPos = Vector2(data.nPosX, data.nPosY)
          data.nPivotX = tbParam[2] or data.nPivotX
          data.nPivotY = tbParam[3] or data.nPivotY
          data.nPosX = v2CurPos.x + (data.nPivotX - v2CurPivot.x) * 2500
          data.nPosY = v2CurPos.y + (data.nPivotY - v2CurPivot.y) * 1800
          data.nPosX = tbParam[4] or data.nPosX
          data.nPosY = tbParam[5] or data.nPosY
          data.nScale = tbParam[6] or data.nScale
          data.nGray = tbParam[7] or data.nGray
          data.nAlpha = tbParam[8] or data.nAlpha
          data.nBrightness = tbParam[9] or data.nBrightness
          data.nBlur = tbParam[10] or data.nBlur
          data.nRotate = tbParam[16] or data.nRotate
        elseif sCmdName == "SetStage" then
          nIdx = nIdx + 2
          local data = mapData[nIdx]
          data.bIn = tbParam[2] % 2 == 0
          if data.bIn == false then
            data = data.stage
            data.nPivotX = 0.5
            data.nPivotY = 0.5
            data.nPosX = 0
            data.nPosY = 0
            data.nScale = 1
            data.nGray = 0
            data.nBrightness = 1
            data.nBlur = 0
          end
        elseif sCmdName == "CtrlStage" then
          nIdx = nIdx + 1
          local data = mapData[nIdx].stage
          local v2CurPivot = Vector2(data.nPivotX, data.nPivotY)
          local v2CurPos = Vector2(data.nPosX, data.nPosY)
          data.nPivotX = tbParam[2] or data.nPivotX
          data.nPivotY = tbParam[3] or data.nPivotY
          data.nPosX = v2CurPos.x + (data.nPivotX - v2CurPivot.x) * 2500
          data.nPosY = v2CurPos.y + (data.nPivotY - v2CurPivot.y) * 1800
          data.nPosX = tbParam[4] or data.nPosX
          data.nPosY = tbParam[5] or data.nPosY
          data.nScale = tbParam[6] or data.nScale
          data.nGray = tbParam[7] or data.nGray
          data.nBrightness = tbParam[8] or data.nBrightness
          data.nBlur = tbParam[9] or data.nBlur
        elseif sCmdName == "SetFx" then
          nIdx = nIdx + 1
          local sFxName = tbParam[2]
          if string.find(sFxName, "_lp") ~= nil or string.find(sFxName, "_loop") ~= nil then
            local data = mapData[nIdx].bgfx
            if tbParam[4] == 1 then
              data = mapData[nIdx].fgfx
            elseif tbParam[4] == 2 then
              data = mapData[nIdx].topfx
            end
            if tbParam[3] == 0 then
              if data[sFxName] == nil then
                data[sFxName] = {}
              end
              table.insert(data[sFxName], {
                x = tbParam[5] or 0,
                y = tbParam[6] or 0,
                s = tbParam[7] or 1,
                bFxEnablePP = tbParam[10] or false,
                r = tbParam[11] or 0
              })
            else
              data[sFxName] = nil
            end
          end
        elseif sCmdName == "SetFrontObj" then
          local data = mapData.fo
          if nIdx == 0 then
            data.bMask = tbParam[2] == 0
            data.sName = tbParam[3]
            data.nPosX = tbParam[4] or 0.5
            data.nPosY = tbParam[5] or 0.5
          else
            data.bMask = false
            data.sName = ""
            data.nPosX = 0.5
            data.nPosY = 0.5
          end
        elseif sCmdName == "SetPP" then
          nIdx = nIdx + 2
          local data = mapData[nIdx]
          data.bg.bEnablePP = tbParam[2] == 1
        end
      end
    end
  end
  return mapData
end

function AvgEditorCtrl:GetHistoryData_Char(bPreview)
  self.tbChoiceCmdName = {}
  self.tbChoiceGroupId = {}
  self.tbChoiceEnabled = {}
  local mapData = {
    [1] = {},
    [2] = {},
    [3] = {},
    [4] = {},
    [5] = {},
    [6] = {}
  }
  
  local function funcGetData(sAvgCharId)
    for i, v in ipairs(mapData) do
      if v.sAvgCharId == sAvgCharId then
        return i
      end
    end
    return -1
  end
  
  local function funcReset(nIndex)
    if mapData[nIndex] == nil then
      return
    end
    mapData[nIndex] = {
      nStageType = 1,
      sAvgCharId = "",
      sBody = "a",
      sFace = "002",
      sEmoji = "none",
      nSortOrder = 1,
      nPosX = 0.5,
      nPosY = 0,
      nScale = 1,
      nGray = 0,
      nBright = 0,
      nAlpha = 1,
      nRotateType = 0,
      nRotate = 0,
      sAnim = "",
      nBlur = 0,
      IsCharHead = false,
      nStagePos = 1,
      nFramePosX = 0,
      nFramePosY = 0,
      nFrameScale = 1,
      nBgType = 0,
      nBlackOffset = 1
    }
  end
  
  local function funcGetCorrectSortOrder(nOrder)
    local n = 0
    for i, v in ipairs(mapData) do
      if v.sAvgCharId ~= "" then
        n = n + 1
      end
    end
    if nOrder > n then
      nOrder = n
    end
    return nOrder
  end
  
  for i = 1, 6 do
    funcReset(i)
  end
  if bPreview == false then
    return mapData
  end
  if self.nCurTransformIndex > 0 then
    local bEnable = false
    for i = 1, self.nCurTransformIndex do
      local tbCmdData = self.tbAvgCfg[i]
      local sCmdName = tbCmdData.cmd
      local tbParam = tbCmdData.param
      bEnable = self:Check_SkipChoiceContent(sCmdName, tbParam)
      if bEnable == true then
        if sCmdName == "SetChar" then
          if tbParam[1] == 0 then
            local data = mapData[funcGetData("")]
            if data ~= nil then
              data.nStageType = tbParam[2] + 1
              local sKey = tbParam[3]
              data.sAvgCharId = AdjustMainRoleAvgCharId(tbParam[4])
              data.sBody = tbParam[5]
              data.sFace = tbParam[6]
              data.sEmoji = tbParam[7]
              data.nSortOrder = funcGetCorrectSortOrder(tbParam[8] or data.nSortOrder)
              if sKey == "none" then
                data.nPosX = tbParam[9] or data.nPosX
                data.nPosY = tbParam[10] or data.nPosY
                data.nScale = tbParam[11] or data.nScale
                data.nGray = tbParam[12] or data.nGray
                data.nBright = tbParam[13] or data.nBright
                data.nAlpha = tbParam[14] or data.nAlpha
                data.nBlur = tbParam[17] or data.nBlur
              else
                local dataPreset
                for i, v in ipairs(self._panel.tbAvgPreset.CharEnter) do
                  if v[1] == sKey then
                    dataPreset = v[2]
                    break
                  end
                end
                if dataPreset ~= nil then
                  data.nPosX = dataPreset.nPosX[2]
                  data.nPosY = dataPreset.nPosY[2]
                  data.nScale = dataPreset.nScale[2]
                  data.nGray = dataPreset.nGray[2]
                  data.nBright = dataPreset.nBright[2]
                  data.nAlpha = dataPreset.nAlpha[2]
                  data.nBlur = dataPreset.nBlur[2]
                end
              end
            end
          else
            local nIndex = funcGetData(AdjustMainRoleAvgCharId(tbParam[4]))
            funcReset(nIndex)
          end
        elseif sCmdName == "CtrlChar" then
          local nIndex = funcGetData(AdjustMainRoleAvgCharId(tbParam[1]))
          local data = mapData[nIndex]
          if data ~= nil then
            if tbParam[17] == true then
              funcReset(nIndex)
            else
              data.sBody = tbParam[2] or data.sBody
              data.sFace = tbParam[3] or data.sFace
              data.sEmoji = tbParam[4] or data.sEmoji
              data.nSortOrder = funcGetCorrectSortOrder(tbParam[5] or data.nSortOrder)
              data.nPosX = tbParam[6] or data.nPosX
              data.nPosY = tbParam[7] or data.nPosY
              data.nScale = tbParam[8] or data.nScale
              data.nGray = tbParam[9] or data.nGray
              data.nBright = tbParam[10] or data.nBright
              data.nAlpha = tbParam[11] or data.nAlpha
              data.nRotateType = tbParam[15] or data.nRotateType
              data.nRotate = tbParam[16] or data.nRotate
              data.nBlur = tbParam[20] or data.nBlur
            end
          end
        elseif sCmdName == "PlayCharAnim" then
          local nIndex = funcGetData(AdjustMainRoleAvgCharId(tbParam[1]))
          local data = mapData[nIndex]
          if data ~= nil then
            if tbParam[3] == true then
              funcReset(nIndex)
            else
              data.sAnim = tbParam[2]
            end
          end
        elseif sCmdName == "SetCharHead" then
          if tbParam[1] == 0 then
            local data = mapData[funcGetData("")]
            if data ~= nil then
              data.nStageType = 1
              data.nPosY = 0.5
              data.sAvgCharId = AdjustMainRoleAvgCharId(tbParam[6])
              data.sBody = tbParam[7]
              data.sFace = tbParam[8]
              data.sEmoji = tbParam[9]
              data.nPosX = tbParam[11] or data.nPosX
              data.nPosY = tbParam[12] or data.nPosY
              data.nScale = tbParam[13] or data.nScale
              data.nGray = tbParam[14] or data.nGray
              data.nBright = tbParam[15] or data.nBright
              data.nAlpha = tbParam[16] or data.nAlpha
              data.nBlur = tbParam[19] or data.nBlur
              data.IsCharHead = true
              data.nStagePos = tbParam[2] + 1
              data.nBgType = tbParam[10]
              data.nFramePosX = tbParam[3] or data.nFramePosX
              data.nFramePosY = tbParam[4] or data.nFramePosY
              data.nFrameScale = tbParam[5] or data.nFrameScale
            end
          else
            local nIndex = funcGetData(AdjustMainRoleAvgCharId(tbParam[6]))
            funcReset(nIndex)
          end
        elseif sCmdName == "CtrlCharHead" then
          local nIndex = funcGetData(AdjustMainRoleAvgCharId(tbParam[4]))
          local data = mapData[nIndex]
          if data ~= nil then
            data.nFramePosX = tbParam[1] or data.nFramePosX
            data.nFramePosY = tbParam[2] or data.nFramePosY
            data.nFrameScale = tbParam[3] or data.nFrameScale
            data.nBgType = tbParam[5]
          end
        elseif sCmdName == "SetTrans" then
          if tbParam[5] == true then
            for i = 1, 6 do
              funcReset(i)
            end
          end
        elseif sCmdName == "Clear" then
          if tbParam[1] == true then
            for i = 1, 6 do
              funcReset(i)
            end
          end
        elseif sCmdName == "PlayGradient2Anim" then
          local nIndex = funcGetData(AdjustMainRoleAvgCharId(tbParam[1]))
          local data = mapData[nIndex]
          if data ~= nil then
            data.nBlackOffset = tbParam[3]
          end
        end
      end
    end
  end
  return mapData
end

function AvgEditorCtrl:GetHistoryData_Trans(bPreview)
  self.tbChoiceCmdName = {}
  self.tbChoiceGroupId = {}
  self.tbChoiceEnabled = {}
  local mapData = {
    nFilmIn = 1,
    bTransIn = 1,
    nTransStyle = 0
  }
  if bPreview == false then
    return mapData
  end
  if 0 < self.nCurTransformIndex then
    local bEnable = false
    for i = 1, self.nCurTransformIndex do
      local tbCmdData = self.tbAvgCfg[i]
      local sCmdName = tbCmdData.cmd
      local tbParam = tbCmdData.param
      bEnable = self:Check_SkipChoiceContent(sCmdName, tbParam)
      if bEnable == true then
        if sCmdName == "SetFilm" then
          mapData.nFilmIn = tbParam[1]
        elseif sCmdName == "SetTrans" then
          local nCloseOpen = tbParam[1]
          if nCloseOpen == 0 then
            mapData.bTransIn = 0
            mapData.nTransStyle = tbParam[2]
          elseif nCloseOpen == 1 then
            mapData.bTransIn = 1
            mapData.nTransStyle = 0
          end
        end
      end
    end
  end
  return mapData
end

function AvgEditorCtrl:GetHistoryData_Talk(bPreview)
  self.tbChoiceCmdName = {}
  self.tbChoiceGroupId = {}
  self.tbChoiceEnabled = {}
  local mapData = {
    nType = -1,
    sAvgCharId = "0",
    sContent = "",
    nClearType = 0,
    sBody = nil,
    sFace = nil,
    sEmoji = nil,
    nMaskVisible = 0
  }
  if bPreview == false then
    return mapData
  end
  if 0 < self.nCurTransformIndex then
    local bEnable = false
    for i = 1, self.nCurTransformIndex do
      local tbCmdData = self.tbAvgCfg[i]
      local sCmdName = tbCmdData.cmd
      local tbParam = tbCmdData.param
      bEnable = self:Check_SkipChoiceContent(sCmdName, tbParam)
      if bEnable == true then
        if sCmdName == "SetTalk" then
          mapData.nClearType = tbParam[4]
          if mapData.nClearType == 0 then
            mapData.nType = -1
            mapData.sAvgCharId = "0"
            mapData.sContent = ""
            mapData.sBody = nil
            mapData.sFace = nil
            mapData.sEmoji = nil
            mapData.nMaskVisible = 0
          else
            mapData.nType = tbParam[1]
            mapData.sAvgCharId = AdjustMainRoleAvgCharId(tbParam[2])
            mapData.sContent = tbParam[3]
          end
        elseif sCmdName == "SetMainRoleTalk" then
          mapData.sAvgCharId = tbParam[9] or "avg3_100"
          if tbParam[1] > 2 then
            mapData.sAvgCharId = "0"
            mapData.sBody = nil
            mapData.sFace = nil
            mapData.sEmoji = nil
            mapData.nMaskVisible = 0
          else
            mapData.nMaskVisible = tbParam[2]
            mapData.sBody = tbParam[6]
            mapData.sFace = tbParam[3]
            mapData.sEmoji = tbParam[4]
          end
        elseif sCmdName == "SetTrans" then
          if tbParam[6] == true then
            mapData.nType = -1
            mapData.sAvgCharId = "0"
            mapData.sContent = ""
            mapData.nClearType = 0
            mapData.sBody = nil
            mapData.sFace = nil
            mapData.sEmoji = nil
            mapData.nMaskVisible = 0
          end
        elseif sCmdName == "Clear" and tbParam[4] == true then
          mapData.nType = -1
          mapData.sAvgCharId = "0"
          mapData.sContent = ""
          mapData.nClearType = 0
          mapData.sBody = nil
          mapData.sFace = nil
          mapData.sEmoji = nil
          mapData.nMaskVisible = 0
        end
      end
    end
  end
  return mapData
end

return AvgEditorCtrl
