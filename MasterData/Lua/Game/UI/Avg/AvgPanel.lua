local AvgPanel = class("AvgPanel", BasePanel)
local AvgData = PlayerData.Avg
local TimerManager = require("GameCore.Timer.TimerManager")
local WwiseAudioMgr = CS.WwiseAudioManager.Instance
local ModuleManager = require("GameCore.Module.ModuleManager")
local GamepadUIManager = require("GameCore.Module.GamepadUIManager")
AvgPanel._sSortingLayerName = AllEnum.SortingLayerName.UI_Top
AvgPanel._bAddToBackHistory = false
AvgPanel._tbDefine = {
  {
    sPrefabPath = "Avg/Editor/Actor2DEditorAvgPanel.prefab"
  },
  {
    sPrefabPath = "Avg/Avg_0_Stage.prefab",
    sCtrlName = "Game.UI.Avg.Avg_0_Stage"
  },
  {
    sPrefabPath = "Avg/Avg_2_CHAR.prefab",
    sCtrlName = "Game.UI.Avg.Avg_2_CharCtrl"
  },
  {
    sPrefabPath = "Avg/Avg_2_L2D.prefab",
    sCtrlName = "Game.UI.Avg.Avg_2_L2DCtrl"
  },
  {
    sPrefabPath = "Avg/Avg_3_Transition.prefab",
    sCtrlName = "Game.UI.Avg.Avg_3_TransitionCtrl"
  },
  {
    sPrefabPath = "Avg/Avg_4_Talk.prefab",
    sCtrlName = "Game.UI.Avg.Avg_4_TalkCtrl"
  },
  {
    sPrefabPath = "Avg/Avg_5_Phone.prefab",
    sCtrlName = "Game.UI.Avg.Avg_5_PhoneCtrl"
  },
  {
    sPrefabPath = "Avg/Avg_6_Menu.prefab",
    sCtrlName = "Game.UI.Avg.Avg_6_MenuCtrl"
  },
  {
    sPrefabPath = "Avg/Avg_7_Choice.prefab",
    sCtrlName = "Game.UI.Avg.Avg_7_ChoiceCtrl"
  },
  {
    sPrefabPath = "Avg/Avg_7_MajorChoice.prefab",
    sCtrlName = "Game.UI.Avg.Avg_7_MajorChoiceCtrl"
  },
  {
    sPrefabPath = "Avg/Avg_7_PersonalityChoice.prefab",
    sCtrlName = "Game.UI.Avg.Avg_7_PersonalityChoiceCtrl"
  },
  {
    sPrefabPath = "Avg/Avg_8_Log.prefab",
    sCtrlName = "Game.UI.Avg.Avg_8_LogCtrl"
  },
  {
    sPrefabPath = "Avg/Avg_9_Curtain.prefab",
    sCtrlName = "Game.UI.Avg.Avg_9_CurtainCtrl"
  }
}
if RUNNING_ACTOR2D_EDITOR ~= true then
  table.remove(AvgPanel._tbDefine, 1)
end

function AvgPanel:Awake()
  self:EnableGamepad()
  TimerManager.ForceFrameUpdate(true)
  self.sTxtLan = self._tbParam[2]
  self.nCurLanguageIdx = GetLanguageIndex(self.sTxtLan)
  self.sVoLan = self._tbParam[3]
  self.sVoResNameSurfix = ""
  for k, v in pairs(AllEnum.LanguageInfo) do
    if v[1] == self.sVoLan then
      self.sVoResNameSurfix = v[3]
      break
    end
  end
  self.bIsPlayerMale = PlayerData.Base:GetPlayerSex() == true
  self.sPlayerNickName = PlayerData.Base:GetPlayerNickName()
  self.sAvgId = self._tbParam[1]
  self.sRootPath = GetAvgLuaRequireRoot(self.nCurLanguageIdx)
  self.sAvgCfgPath = self.sRootPath .. "Config/" .. self.sAvgId
  self.sAvgCharacterPath = self.sRootPath .. "Preset/AvgCharacter"
  self.sAvgPresetPath = "Game.UI.Avg.AvgPreset"
  self.sAvgContactsPath = self.sRootPath .. "Preset/AvgContacts"
  self.sAvgCfgHead = string.sub(self.sAvgId, 1, 2)
  if self.sAvgCfgHead == "BT" or self.sAvgCfgHead == "DP" or self.sAvgCfgHead == "GD" then
    self.AVG_NO_BG_MODE = true
  end
  self:RequireAndPreProcAvgConfig(self.sAvgCfgPath, self.sAvgCfgHead, self._tbParam[4])
  local tbAvgChar = require(self.sAvgCharacterPath)
  self.tbAvgCharacter = {}
  for i, v in ipairs(tbAvgChar) do
    self.tbAvgCharacter[v.id] = {
      name = v.name,
      reuse = v.reuse,
      color = v.name_bg_color,
      reuseL2DPose = v.reuseL2DPose
    }
  end
  self.tbAvgPreset = require(self.sAvgPresetPath)
  self.nCurIndex = 1
  local nStartIndex = self._tbParam[5]
  if type(nStartIndex) == "number" and 0 < nStartIndex and nStartIndex < #self.tbAvgCfg then
    self.nCurIndex = nStartIndex
  end
  self.nJumpTarget = nil
  self:SetSystemBgm(true)
  CS.AdventureModuleHelper.PauseLogic()
  local tbContacts = require(self.sAvgContactsPath)
  self.tbAvgContacts = {}
  for i, v in ipairs(tbContacts) do
    self.tbAvgContacts[v.id] = {
      name = v.name,
      signature = ProcAvgTextContent(v.signature),
      icon = v.icon
    }
  end
  self.nSpeedRate = 1
  EventManager.Add(EventId.AvgSpeedUp, self, self.OnEvent_AvgSpeedUp)
  self.sExecutingCMDName = nil
  self.tbBEIndex = {}
  AvgData:MarkSkip(false)
end

function AvgPanel:OnEnable()
  self:BindCmdProcFunc()
  EventManager.Add(EventId.AvgSkipCheck, self, self.OnEvent_AvgSkipCheck)
  EventManager.Add(EventId.AvgSkip, self, self.OnEvent_AvgSkip)
  EventManager.Add(EventId.AvgTryResume, self, self.OnEvent_AvgTryResume)
  EventManager.Add(EventId.AvgVoiceDuration, self, self.OnEvent_AvgVoiceDuration)
  if AVG_EDITOR == true then
    self:AddTimer(1, 1, "DelayRunInAvgEditor", true, true, true)
  else
    if self.sAvgCfgHead == "DP" then
      WwiseAudioMgr:PlaySound("ui_dispatch_dialogue_enter")
    end
    self:RUN()
  end
end

function AvgPanel:BindCmdProcFunc()
  self.mapProcFunc = {}
  self.mapProcFunc.SetBg = self:FindCmdProcFunc("Avg_0_Stage", "SetBg")
  self.mapProcFunc.CtrlBg = self:FindCmdProcFunc("Avg_0_Stage", "CtrlBg")
  self.mapProcFunc.SetStage = self:FindCmdProcFunc("Avg_0_Stage", "SetStage")
  self.mapProcFunc.CtrlStage = self:FindCmdProcFunc("Avg_0_Stage", "CtrlStage")
  self.mapProcFunc.SetFx = self:FindCmdProcFunc("Avg_0_Stage", "SetFx")
  self.mapProcFunc.SetFrontObj = self:FindCmdProcFunc("Avg_0_Stage", "SetFrontObj")
  self.mapProcFunc.SetHeartBeat = self:FindCmdProcFunc("Avg_0_Stage", "SetHeartBeat")
  self.mapProcFunc.SetPP = self:FindCmdProcFunc("Avg_0_Stage", "SetPP")
  self.mapProcFunc.SetPPGlobal = self:FindCmdProcFunc("Avg_0_Stage", "SetPPGlobal")
  self.mapProcFunc.SetChar = self:FindCmdProcFunc("Avg_2_CharCtrl", "SetChar")
  self.mapProcFunc.CtrlChar = self:FindCmdProcFunc("Avg_2_CharCtrl", "CtrlChar")
  self.mapProcFunc.PlayCharAnim = self:FindCmdProcFunc("Avg_2_CharCtrl", "PlayCharAnim")
  self.mapProcFunc.SetCharHead = self:FindCmdProcFunc("Avg_2_CharCtrl", "SetCharHead")
  self.mapProcFunc.CtrlCharHead = self:FindCmdProcFunc("Avg_2_CharCtrl", "CtrlCharHead")
  self.mapProcFunc.SetL2D = self:FindCmdProcFunc("Avg_2_L2DCtrl", "SetL2D")
  self.mapProcFunc.CtrlL2D = self:FindCmdProcFunc("Avg_2_L2DCtrl", "CtrlL2D")
  self.mapProcFunc.SetCharL2D = self:FindCmdProcFunc("Avg_2_L2DCtrl", "SetCharL2D")
  self.mapProcFunc.PlayGradient2Anim = self:FindCmdProcFunc("Avg_2_CharCtrl", "PlayGradient2Anim")
  self.mapProcFunc.SetFilm = self:FindCmdProcFunc("Avg_3_TransitionCtrl", "SetFilm")
  self.mapProcFunc.SetTrans = self:FindCmdProcFunc("Avg_3_TransitionCtrl", "SetTrans")
  self.mapProcFunc.SetWordTrans = self:FindCmdProcFunc("Avg_3_TransitionCtrl", "SetWordTrans")
  self.mapProcFunc.PlayVideo = self:FindCmdProcFunc("Avg_3_TransitionCtrl", "PlayVideo")
  self.mapProcFunc.SetTalk = self:FindCmdProcFunc("Avg_4_TalkCtrl", "SetTalk")
  self.mapProcFunc.SetTalkShake = self:FindCmdProcFunc("Avg_4_TalkCtrl", "SetTalkShake")
  self.mapProcFunc.SetGoOn = self:FindCmdProcFunc("Avg_4_TalkCtrl", "SetGoOn")
  self.mapProcFunc.SetMainRoleTalk = self:FindCmdProcFunc("Avg_4_TalkCtrl", "SetMainRoleTalk")
  self.mapProcFunc.SetCameraAperture = self:FindCmdProcFunc("Avg_4_TalkCtrl", "SetCameraAperture")
  self.mapProcFunc.SetPhone = self:FindCmdProcFunc("Avg_5_PhoneCtrl", "SetPhone")
  self.mapProcFunc.SetPhoneMsg = self:FindCmdProcFunc("Avg_5_PhoneCtrl", "SetPhoneMsg")
  self.mapProcFunc.SetPhoneThinking = self:FindCmdProcFunc("Avg_5_PhoneCtrl", "SetPhoneThinking")
  self.mapProcFunc.SetPhoneMsgChoiceBegin = self:FindCmdProcFunc("Avg_5_PhoneCtrl", "SetPhoneMsgChoiceBegin")
  self.mapProcFunc.SetPhoneMsgChoiceJumpTo = self:FindCmdProcFunc("Avg_5_PhoneCtrl", "SetPhoneMsgChoiceJumpTo")
  self.mapProcFunc.SetPhoneMsgChoiceEnd = self:FindCmdProcFunc("Avg_5_PhoneCtrl", "SetPhoneMsgChoiceEnd")
  self.mapProcFunc.SetChoiceBegin = self:FindCmdProcFunc("Avg_7_ChoiceCtrl", "SetChoiceBegin")
  self.mapProcFunc.SetChoiceJumpTo = self:FindCmdProcFunc("Avg_7_ChoiceCtrl", "SetChoiceJumpTo")
  self.mapProcFunc.SetChoiceRollback = self:FindCmdProcFunc("Avg_7_ChoiceCtrl", "SetChoiceRollback")
  self.mapProcFunc.SetChoiceRollover = self:FindCmdProcFunc("Avg_7_ChoiceCtrl", "SetChoiceRollover")
  self.mapProcFunc.SetChoiceEnd = self:FindCmdProcFunc("Avg_7_ChoiceCtrl", "SetChoiceEnd")
  self.mapProcFunc.SetMajorChoice = self:FindCmdProcFunc("Avg_7_MajorChoiceCtrl", "SetMajorChoice")
  self.mapProcFunc.SetMajorChoiceJumpTo = self:FindCmdProcFunc("Avg_7_MajorChoiceCtrl", "SetMajorChoiceJumpTo")
  self.mapProcFunc.SetMajorChoiceRollover = self:FindCmdProcFunc("Avg_7_MajorChoiceCtrl", "SetMajorChoiceRollover")
  self.mapProcFunc.SetMajorChoiceEnd = self:FindCmdProcFunc("Avg_7_MajorChoiceCtrl", "SetMajorChoiceEnd")
  self.mapProcFunc.SetPersonalityChoice = self:FindCmdProcFunc("Avg_7_PersonalityChoiceCtrl", "SetPersonalityChoice")
  self.mapProcFunc.SetPersonalityChoiceJumpTo = self:FindCmdProcFunc("Avg_7_PersonalityChoiceCtrl", "SetPersonalityChoiceJumpTo")
  self.mapProcFunc.SetPersonalityChoiceRollover = self:FindCmdProcFunc("Avg_7_PersonalityChoiceCtrl", "SetPersonalityChoiceRollover")
  self.mapProcFunc.SetPersonalityChoiceEnd = self:FindCmdProcFunc("Avg_7_PersonalityChoiceCtrl", "SetPersonalityChoiceEnd")
  self.mapProcFunc.IfTrue = {
    ctrl = self,
    func = self.IfTrue
  }
  self.mapProcFunc.EndIf = {
    ctrl = self,
    func = self.EndIf
  }
  self.mapProcFunc.GetEvidence = self:FindCmdProcFunc("Avg_7_MajorChoiceCtrl", "GetEvidence")
  self.mapProcFunc.IfUnlock = {
    ctrl = self,
    func = self.IfUnlock
  }
  self.mapProcFunc.IfUnlockElse = {
    ctrl = self,
    func = self.IfUnlockElse
  }
  self.mapProcFunc.IfUnlockEnd = {
    ctrl = self,
    func = self.IfUnlockEnd
  }
  self.mapProcFunc.SetAudio = {
    ctrl = self,
    func = self.SetAudio
  }
  self.mapProcFunc.SetBGM = {
    ctrl = self,
    func = self.SetBGM
  }
  self.mapProcFunc.SetSceneHeading = self:FindCmdProcFunc("Avg_6_MenuCtrl", "SetSceneHeading")
  self.mapProcFunc.SetIntro = self:FindCmdProcFunc("Avg_6_MenuCtrl", "SetIntro")
  self.mapProcFunc.NewCharIntro = self:FindCmdProcFunc("Avg_6_MenuCtrl", "NewCharIntro")
  self.mapProcFunc.Wait = {
    ctrl = self,
    func = self.Wait
  }
  self.mapProcFunc.Jump = {
    ctrl = self,
    func = self.Jump
  }
  self.mapProcFunc.Clear = {
    ctrl = self,
    func = self.Clear
  }
  self.mapProcFunc.End = {
    ctrl = self,
    func = self.End
  }
  self.mapProcFunc.SetGroupId = {
    ctrl = self,
    func = self.SetGroupId
  }
  self.mapProcFunc.Comment = {
    ctrl = self,
    func = self.Comment
  }
  self.mapProcFunc.BadEnding_Check = {
    ctrl = self,
    func = self.BadEnding_Check
  }
  self.mapProcFunc.BadEnding_Mark = {
    ctrl = self,
    func = self.BadEnding_Mark
  }
  self.mapProcFunc.JUMP_AVG_ID = {
    ctrl = self,
    func = self.JUMP_AVG_ID
  }
  self.mapProcFunc.CheckBE = {
    ctrl = self,
    func = self.CheckBE
  }
  self.mapProcFunc.CheckBECase = {
    ctrl = self,
    func = self.CheckBECase
  }
  self.mapProcFunc.CheckBEEnd = {
    ctrl = self,
    func = self.CheckBEEnd
  }
end

function AvgPanel:DelayRunInAvgEditor()
  WwiseAudioMgr.MusicVolume = 10
  if self.sAvgCfgHead == "DP" then
    WwiseAudioMgr:PlaySound("ui_dispatch_dialogue_enter")
  end
  self:RUN()
end

function AvgPanel:OnDisable()
  self.mapProcFunc = nil
  if self.tbAvgCfg ~= nil then
    self.tbAvgCfg = nil
  end
  package.loaded[self.sAvgCfgPath] = nil
  self.sAvgCfgPath = nil
  if self.tbAvgCharacter ~= nil then
    self.tbAvgCharacter = nil
  end
  package.loaded[self.sAvgCharacterPath] = nil
  self.sAvgCharacterPath = nil
  if self.tbAvgPreset ~= nil then
    self.tbAvgPreset = nil
  end
  package.loaded[self.sAvgPresetPath] = nil
  self.sAvgPresetPath = nil
  if self.tbAvgContacts ~= nil then
    self.tbAvgContacts = nil
  end
  package.loaded[self.sAvgContactsPath] = nil
  self.sAvgContactsPath = nil
  CS.AdventureModuleHelper.ResumeLogic()
  TimerManager.ForceFrameUpdate(false)
  self:DisableGamepad()
end

function AvgPanel:RequireAndPreProcAvgConfig(sAvgConfigPath, sHead, _sGroupId)
  local ok, aaa = pcall(require, sAvgConfigPath)
  if not ok then
    printError("AVG 指令配置文件未找到，路径:" .. sAvgConfigPath .. ". error: " .. aaa)
    EventManager.Hit(EventId.OpenMessageBox, "AVG 指令配置文件未找到，路径:" .. sAvgConfigPath)
    EventManager.Hit("StoryDialog_DialogEnd")
    return
  else
    self.tbAvgCfg = aaa
    if type(_sGroupId) == "string" and _sGroupId ~= "" then
      self.tbAvgCfg = self:ParseGroup(aaa, sHead, _sGroupId)
    end
    self.tbPhoneMsgChoiceTarget = {}
    if self.tbChoiceTarget == nil then
      self.tbChoiceTarget = {}
    end
    if self.tbChoiceTarget[self.sAvgId] == nil then
      self.tbChoiceTarget[self.sAvgId] = {}
    end
    local tb = self.tbChoiceTarget[self.sAvgId]
    if self.tbMajorChoiceTarget == nil then
      self.tbMajorChoiceTarget = {}
    end
    if self.tbMajorChoiceTarget[self.sAvgId] == nil then
      self.tbMajorChoiceTarget[self.sAvgId] = {}
    end
    local tbMajor = self.tbMajorChoiceTarget[self.sAvgId]
    if self.tbPersonalityChoiceTarget == nil then
      self.tbPersonalityChoiceTarget = {}
    end
    if self.tbPersonalityChoiceTarget[self.sAvgId] == nil then
      self.tbPersonalityChoiceTarget[self.sAvgId] = {}
    end
    local tbPersonality = self.tbPersonalityChoiceTarget[self.sAvgId]
    if self.tbIfTrueTarget == nil then
      self.tbIfTrueTarget = {}
    end
    if self.tbIfTrueTarget[self.sAvgId] == nil then
      self.tbIfTrueTarget[self.sAvgId] = {}
    end
    local tbIfTrue = self.tbIfTrueTarget[self.sAvgId]
    if self.tbIfUnlockTarget == nil then
      self.tbIfUnlockTarget = {}
    end
    if self.tbIfUnlockTarget[self.sAvgId] == nil then
      self.tbIfUnlockTarget[self.sAvgId] = {}
    end
    local tbIfUnlock = self.tbIfUnlockTarget[self.sAvgId]
    if self.tbCheckBETarget == nil then
      self.tbCheckBETarget = {}
    end
    if self.tbCheckBETarget[self.sAvgId] == nil then
      self.tbCheckBETarget[self.sAvgId] = {}
    end
    local tbCheckBE = self.tbCheckBETarget[self.sAvgId]
    self.END_CMD_ID = nil
    self.BadEndingMarkId = nil
    for i, v in ipairs(self.tbAvgCfg) do
      if v.cmd == "SetChoiceBegin" then
        local sGroupId = v.param[1]
        if tb[sGroupId] == nil then
          tb[sGroupId] = {
            nBeginCmdId = 0,
            nEndCmdId = 0,
            tbTargetCmdId = {}
          }
        end
        tb[sGroupId].nBeginCmdId = i
      elseif v.cmd == "SetChoiceJumpTo" then
        local sGroupId = v.param[1]
        local nIndex = v.param[2]
        if tb[sGroupId] == nil then
          tb[sGroupId] = {
            nBeginCmdId = 0,
            nEndCmdId = 0,
            tbTargetCmdId = {}
          }
        end
        tb[sGroupId].tbTargetCmdId[nIndex] = i
      elseif v.cmd == "SetChoiceEnd" then
        local sGroupId = v.param[1]
        if tb[sGroupId] == nil then
          tb[sGroupId] = {
            nBeginCmdId = 0,
            nEndCmdId = 0,
            tbTargetCmdId = {}
          }
        end
        tb[sGroupId].nEndCmdId = i
      elseif v.cmd == "SetPhoneMsgChoiceBegin" then
        local sGroupId = v.param[1]
        if self.tbPhoneMsgChoiceTarget[sGroupId] == nil then
          self.tbPhoneMsgChoiceTarget[sGroupId] = {
            nBeginCmdId = 0,
            nEndCmdId = 0,
            tbTargetCmdId = {}
          }
        end
        self.tbPhoneMsgChoiceTarget[sGroupId].nBeginCmdId = i
      elseif v.cmd == "SetPhoneMsgChoiceJumpTo" then
        local sGroupId = v.param[1]
        local nIndex = v.param[2]
        if self.tbPhoneMsgChoiceTarget[sGroupId] == nil then
          self.tbPhoneMsgChoiceTarget[sGroupId] = {
            nBeginCmdId = 0,
            nEndCmdId = 0,
            tbTargetCmdId = {}
          }
        end
        self.tbPhoneMsgChoiceTarget[sGroupId].tbTargetCmdId[nIndex] = i
      elseif v.cmd == "SetPhoneMsgChoiceEnd" then
        local sGroupId = v.param[1]
        if self.tbPhoneMsgChoiceTarget[sGroupId] == nil then
          self.tbPhoneMsgChoiceTarget[sGroupId] = {
            nBeginCmdId = 0,
            nEndCmdId = 0,
            tbTargetCmdId = {}
          }
        end
        self.tbPhoneMsgChoiceTarget[sGroupId].nEndCmdId = i
      elseif v.cmd == "End" then
        if self.END_CMD_ID == nil then
          self.END_CMD_ID = i
          break
        end
      elseif v.cmd == "SetMajorChoice" then
        local nGroupId = v.param[1]
        if tbMajor[nGroupId] == nil then
          tbMajor[nGroupId] = {
            nEndCmdId = 0,
            tbTargetCmdId = {}
          }
        end
      elseif v.cmd == "SetMajorChoiceJumpTo" then
        local nGroupId = v.param[1]
        local nIndex = v.param[2]
        if tbMajor[nGroupId] == nil then
          tbMajor[nGroupId] = {
            nEndCmdId = 0,
            tbTargetCmdId = {}
          }
        end
        tbMajor[nGroupId].tbTargetCmdId[nIndex] = i
      elseif v.cmd == "SetMajorChoiceEnd" then
        local nGroupId = v.param[1]
        if tbMajor[nGroupId] == nil then
          tbMajor[nGroupId] = {
            nEndCmdId = 0,
            tbTargetCmdId = {}
          }
        end
        tbMajor[nGroupId].nEndCmdId = i
      elseif v.cmd == "SetPersonalityChoice" then
        local nGroupId = v.param[1]
        if tbPersonality[nGroupId] == nil then
          tbPersonality[nGroupId] = {
            nEndCmdId = 0,
            tbTargetCmdId = {}
          }
        end
      elseif v.cmd == "SetPersonalityChoiceJumpTo" then
        local nGroupId = v.param[1]
        local nIndex = v.param[2]
        if tbPersonality[nGroupId] == nil then
          tbPersonality[nGroupId] = {
            nEndCmdId = 0,
            tbTargetCmdId = {}
          }
        end
        tbPersonality[nGroupId].tbTargetCmdId[nIndex] = i
      elseif v.cmd == "SetPersonalityChoiceEnd" then
        local nGroupId = v.param[1]
        if tbPersonality[nGroupId] == nil then
          tbPersonality[nGroupId] = {
            nEndCmdId = 0,
            tbTargetCmdId = {}
          }
        end
        tbPersonality[nGroupId].nEndCmdId = i
      elseif v.cmd == "IfTrue" or v.cmd == "EndIf" then
        local sGroupId = v.param[1]
        if tbIfTrue[sGroupId] == nil then
          tbIfTrue[sGroupId] = {
            cmdids = {},
            played = {}
          }
        end
        if 0 >= table.indexof(tbIfTrue[sGroupId].cmdids, i) then
          table.insert(tbIfTrue[sGroupId].cmdids, i)
          table.insert(tbIfTrue[sGroupId].played, false)
        end
      elseif v.cmd == "IfUnlock" then
        local sGroupId = v.param[1]
        if tbIfUnlock[sGroupId] == nil then
          tbIfUnlock[sGroupId] = {
            tbCmdId = {},
            nSuccIndex = 0
          }
        end
        table.insert(tbIfUnlock[sGroupId].tbCmdId, i)
      elseif v.cmd == "IfUnlockElse" then
        local sGroupId = v.param[1]
        table.insert(tbIfUnlock[sGroupId].tbCmdId, i)
      elseif v.cmd == "IfUnlockEnd" then
        local sGroupId = v.param[1]
        table.insert(tbIfUnlock[sGroupId].tbCmdId, i)
      elseif v.cmd == "BadEnding_Mark" then
        self.BadEndingMarkId = i
      elseif v.cmd == "CheckBE" then
        local sGroupId = v.param[1]
        if tbCheckBE[sGroupId] == nil then
          tbCheckBE[sGroupId] = {
            [1] = 0,
            [2] = 0,
            [3] = 0,
            [4] = 0,
            CheckBEEnd = 0,
            result = 0
          }
        end
      elseif v.cmd == "CheckBECase" then
        local sGroupId = v.param[1]
        local nCase = v.param[2]
        if type(tbCheckBE[sGroupId]) == "table" then
          tbCheckBE[sGroupId][nCase] = i
        end
      elseif v.cmd == "CheckBEEnd" then
        local sGroupId = v.param[1]
        if type(tbCheckBE[sGroupId]) == "table" then
          tbCheckBE[sGroupId].CheckBEEnd = i
        end
      end
    end
    AvgData:MarkStoryId(self.sAvgId)
  end
end

function AvgPanel:ParseGroup(data, sHead, sGroupId)
  local bMatch = false
  local tbGroupData = {}
  for i, v in ipairs(data) do
    if v.cmd == "SetGroupId" then
      if sHead == "DP" and sGroupId == "PLAY_ALL_PLAY_ALL" then
        bMatch = true
      else
        bMatch = v.param[1] == sGroupId
      end
      if bMatch and sHead == "PM" then
        table.insert(tbGroupData, {
          cmd = "SetPhone",
          param = {
            0,
            1,
            1
          }
        })
      end
    elseif bMatch or v.cmd == "End" then
      table.insert(tbGroupData, v)
    end
  end
  return tbGroupData
end

function AvgPanel:FindCmdProcFunc(sCtrlName, sCmd)
  for i, objCtrl in ipairs(self._tbObjCtrl) do
    if objCtrl.__cname == sCtrlName then
      return {
        ctrl = objCtrl,
        func = objCtrl[sCmd]
      }
    end
  end
end

function AvgPanel:GetAvgCharName(sAvgCharId)
  if sAvgCharId == "avg3_100" or sAvgCharId == "avg3_101" then
    local sName = PlayerData.Base:GetPlayerNickName()
    return sName, "#0ABEC5"
  end
  local tbChar = self.tbAvgCharacter[sAvgCharId]
  if tbChar == nil then
    return sAvgCharId, "#0ABEC5"
  else
    return tbChar.name or sAvgCharId, tbChar.color or "#0ABEC5"
  end
end

function AvgPanel:GetAvgCharReuseRes(sAvgCharId)
  local tbChar = self.tbAvgCharacter[sAvgCharId]
  if tbChar == nil then
    return sAvgCharId
  elseif tbChar.reuse == nil then
    return sAvgCharId
  else
    return AdjustMainRoleAvgCharId(tbChar.reuse)
  end
end

function AvgPanel:AddTimer(nTargetCount, nInterval, sCallbackName, bAutoRun, bDestroyWhenComplete, nScaleType, tbParam)
  local callback = self[sCallbackName]
  if type(callback) == "function" then
    local timer = TimerManager.Add(nTargetCount, nInterval, self, callback, bAutoRun, bDestroyWhenComplete, nScaleType, tbParam)
    return timer
  else
    return nil
  end
end

function AvgPanel:GetBgCgFgResFullPath(sName)
  if sName == "BG_Black" then
    return "ImageAvg/AvgBg/BG_Black"
  elseif table.indexof(self.tbAvgPreset.BgResName, sName) > 0 then
    return "ImageAvg/AvgBg/" .. sName
  elseif 0 < table.indexof(self.tbAvgPreset.CgResName, sName) then
    return "ImageAvg/AvgCG/" .. sName
  elseif 0 < table.indexof(self.tbAvgPreset.FgResName, sName) then
    return "ImageAvg/AvgFg/" .. sName
  elseif 0 < table.indexof(self.tbAvgPreset.DiscResName, sName) then
    local sFolderName = string.gsub(sName, "_B", "")
    return "Disc/" .. sFolderName .. "/" .. sName
  else
    return nil
  end
end

function AvgPanel:GetAvgContactsData(sContactsId)
  local tbContacts = self.tbAvgContacts[sContactsId]
  if tbContacts == nil then
    return sContactsId
  else
    return tbContacts
  end
end

function AvgPanel:GetNextProcFunc(nextIndex)
  if self.nCurIndex ~= nil then
    if nextIndex == nil then
      nextIndex = 1
    end
    return self.tbAvgCfg[self.nCurIndex + nextIndex]
  end
end

function AvgPanel:OnEvent_AvgSkipCheck()
  if self.nCurIndex <= 1 then
    return
  end
  AvgData:MarkSkip(true)
  if self.timerWaiting ~= nil then
    self.timerWaiting:Pause(true)
  end
  local sCmdName, nJumpTo
  for i = self.nCurIndex, self.END_CMD_ID do
    sCmdName = self.tbAvgCfg[i].cmd
    if sCmdName == "BadEnding_Check" then
      self:BadEnding_Check()
      break
    end
  end
  for i = self.nCurIndex, self.END_CMD_ID do
    sCmdName = self.tbAvgCfg[i].cmd
    if sCmdName == "SetIntro" then
      local param = self.tbAvgCfg[i].param
      local objCtrl = self.mapProcFunc[sCmdName].ctrl
      local ProcFunc = self.mapProcFunc[sCmdName].func
      ProcFunc(objCtrl, param)
      break
    end
  end
  for i = self.nCurIndex, self.END_CMD_ID do
    sCmdName = self.tbAvgCfg[i].cmd
    if sCmdName == "SetMajorChoice" then
      nJumpTo = i
      break
    elseif sCmdName == "PlayVideo" then
      nJumpTo = i
      break
    end
  end
  if nJumpTo == nil then
    EventManager.Hit(EventId.AvgSkipCheckIntro)
  else
    WwiseAudioMgr:PostEvent("avg_track1_stop")
    WwiseAudioMgr:PostEvent("avg_track2_stop")
    WwiseAudioMgr:PostEvent("avg_sfx_all_stop")
    if self.timerWaiting ~= nil then
      self.timerWaiting:Cancel()
      self.timerWaiting = nil
    end
    self.nJumpTarget = nJumpTo
    self:RUN()
  end
end

function AvgPanel:OnEvent_AvgSkip()
  local nJumpTo
  local mapConfig = self.tbAvgCfg[self.END_CMD_ID - 1]
  if mapConfig ~= nil then
    if mapConfig.cmd == "JUMP_AVG_ID" then
      nJumpTo = self.END_CMD_ID - 1
    elseif mapConfig.cmd == "IfUnlockEnd" then
      nJumpTo = self:ParseEndJump(mapConfig)
    end
  end
  if nJumpTo ~= nil then
    self.nJumpTarget = nJumpTo
  else
    self.nJumpTarget = self.END_CMD_ID
  end
  self:RUN()
end

function AvgPanel:OnEvent_AvgTryResume()
  if self.timerWaiting ~= nil then
    self.timerWaiting:Pause(false)
  end
end

function AvgPanel:OnEvent_AvgSpeedUp(nRate)
  printLog("Avg加速 AvgPanel " .. nRate)
  self.nSpeedRate = nRate
  DOTween.unscaledTimeScale = nRate
  if self.timerWaiting ~= nil then
    self.timerWaiting:SetSpeed(nRate)
  end
end

function AvgPanel:RUN()
  if type(self.sExecutingCMDName) == "string" then
    printError(string.format("当前指令 %s 尚未执行完成，在一帧里又调用了一次 AvgPanel:RUN() 接口，必须排查此严重错误！！", self.sExecutingCMDName))
    return
  end
  if self.timerWaiting ~= nil then
    self.timerWaiting:Cancel()
    self.timerWaiting = nil
  end
  if self.nCurIndex == nil then
    return
  end
  if self.nJumpTarget ~= nil then
    self.nCurIndex = self.nJumpTarget
    self.nJumpTarget = nil
  end
  local mapConfig = self.tbAvgCfg[self.nCurIndex]
  local sCmd = mapConfig.cmd
  local tbParam = mapConfig.param
  if self.mapProcFunc[sCmd] == nil then
    printError("未找到该指令：" .. sCmd)
    return
  end
  local objCtrl = self.mapProcFunc[sCmd].ctrl
  local ProcFunc = self.mapProcFunc[sCmd].func
  local nWaitTime = 0
  self.sExecutingCMDName = sCmd
  nWaitTime = ProcFunc(objCtrl, tbParam)
  self.sExecutingCMDName = nil
  printLog(string.format("索引:%s指令:%s耗时:%f", self.nCurIndex or "nil", sCmd, nWaitTime))
  if type(self.nCurIndex) == "number" then
    self.nCurIndex = self.nCurIndex + 1
  end
  if nWaitTime < 0 then
    return
  elseif 0 < nWaitTime then
    self:Wait({nWaitTime})
  else
    self:RUN()
  end
end

function AvgPanel:End()
  EventManager.Remove(EventId.AvgSkipCheck, self, self.OnEvent_AvgSkipCheck)
  EventManager.Remove(EventId.AvgSkip, self, self.OnEvent_AvgSkip)
  EventManager.Remove(EventId.AvgTryResume, self, self.OnEvent_AvgTryResume)
  EventManager.Remove(EventId.AvgSpeedUp, self, self.OnEvent_AvgSpeedUp)
  EventManager.Remove(EventId.AvgVoiceDuration, self, self.OnEvent_AvgVoiceDuration)
  EventManager.Hit(EventId.BlockInput, true)
  self.nCurIndex = nil
  local _objCtrl, _ProcFunc
  for i, objCtrl in ipairs(self._tbObjCtrl) do
    if objCtrl.__cname == "Avg_9_CurtainCtrl" then
      _objCtrl = objCtrl
      _ProcFunc = _objCtrl.SetEnd
      break
    end
  end
  if self.AVG_NO_BG_MODE == true then
    self:onEnd()
  else
    local nTime = _ProcFunc(_objCtrl, false)
    self:AddTimer(1, nTime, "onEnd", true, true, true)
  end
  return -1
end

function AvgPanel:onEnd()
  if self.nCurIndex == 1 then
    return
  end
  AVG_EDITOR_PLAYING = nil
  self:SetSystemBgm(false)
  self:OnEvent_AvgSpeedUp(1)
  EventManager.Hit(EventId.BlockInput, false)
  EventManager.Hit("StoryDialog_DialogEnd")
end

function AvgPanel:Jump(tbParam)
  local nIndex = tbParam[1]
  self.nJumpTarget = nIndex
  return 0
end

function AvgPanel:Wait(tbParam)
  local nTime = tbParam[1]
  if 0 < nTime then
    self.timerWaiting = self:AddTimer(1, nTime, "_onWaitComplete", true, true, true)
    self.timerWaiting:SetSpeed(self.nSpeedRate)
  end
  return -1
end

function AvgPanel:_onWaitComplete()
  self.timerWaiting = nil
  self:RUN()
end

function AvgPanel:SetGroupId()
  return 0
end

function AvgPanel:Comment(tbParam)
  return 0
end

function AvgPanel:SetChoiceJumpTo(nGroupId, nIndex)
  local tb = self.tbChoiceTarget[self.sAvgId]
  local tbData = tb[nGroupId]
  if tbData ~= nil then
    self.nCurIndex = tbData.tbTargetCmdId[tostring(nIndex)]
    self:RUN()
  end
end

function AvgPanel:SetChoiceRollback(nGroupId)
  local tb = self.tbChoiceTarget[self.sAvgId]
  local tbData = tb[nGroupId]
  if tbData ~= nil then
    self.nJumpTarget = tbData.nBeginCmdId
  end
end

function AvgPanel:SetChoiceRollover(nGroupId)
  local tb = self.tbChoiceTarget[self.sAvgId]
  local tbData = tb[nGroupId]
  if tbData ~= nil then
    self.nJumpTarget = tbData.nEndCmdId
  end
end

function AvgPanel:SetPhoneMsgChoiceJumpTo(nGroupId, nIndex)
  local tbData = self.tbPhoneMsgChoiceTarget[nGroupId]
  if tbData ~= nil then
    self.nCurIndex = tbData.tbTargetCmdId[tostring(nIndex)]
    self:RUN()
  end
end

function AvgPanel:SetPhoneMsgChoiceEnd(nGroupId)
  local tbData = self.tbPhoneMsgChoiceTarget[tostring(nGroupId)]
  if tbData ~= nil then
    self.nJumpTarget = tbData.nEndCmdId
  end
end

function AvgPanel:SetMajorChoiceJumpTo(nGroupId, nIndex)
  local tbMajor = self.tbMajorChoiceTarget[self.sAvgId]
  local tbMajorData = tbMajor[nGroupId]
  if tbMajorData ~= nil then
    self.nCurIndex = tbMajorData.tbTargetCmdId[nIndex]
    self:RUN()
  end
end

function AvgPanel:SetMajorChoiceRollover(nGroupId)
  local tbMajor = self.tbMajorChoiceTarget[self.sAvgId]
  local tbMajorData = tbMajor[nGroupId]
  if tbMajorData ~= nil then
    self.nJumpTarget = tbMajorData.nEndCmdId
  end
end

function AvgPanel:SetPersonalityChoiceJumpTo(nGroupId, nIndex)
  local tbPersonality = self.tbPersonalityChoiceTarget[self.sAvgId]
  local tbPersonalityData = tbPersonality[nGroupId]
  if tbPersonalityData ~= nil then
    self.nCurIndex = tbPersonalityData.tbTargetCmdId[nIndex]
    self:RUN()
  end
end

function AvgPanel:SetPersonalityChoiceRollover(nGroupId)
  local tbPersonality = self.tbPersonalityChoiceTarget[self.sAvgId]
  local tbPersonalityData = tbPersonality[nGroupId]
  if tbPersonalityData ~= nil then
    self.nJumpTarget = tbPersonalityData.nEndCmdId
  end
end

local tbChoiceABC = {
  "a",
  "b",
  "c"
}

function AvgPanel:IfTrue(tbParam)
  local sIfTrueGroupId = tbParam[1]
  local bIsMajorChoice = tbParam[2] == 0
  local sAvgId = tbParam[3]
  local nChoiceGroupId = tbParam[4]
  local tbParamData = string.split(tbParam[5], "|")
  local bResult, nParamLen, sABC, nCount
  for i, v in ipairs(tbParamData) do
    local tbParamGroupData = string.split(v, "+")
    for ii, vv in ipairs(tbParamGroupData) do
      nParamLen = string.len(vv)
      sABC = string.sub(vv, 1, 1)
      sABC = string.lower(sABC)
      if 1 < nParamLen then
        nCount = tonumber(string.sub(vv, 2)) or 1
      else
        nCount = 1
      end
      bResult = AvgData:CheckIfTrue(bIsMajorChoice, sAvgId, nChoiceGroupId, table.indexof(tbChoiceABC, sABC), nCount)
      if bResult ~= true then
        break
      end
    end
    if bResult == true then
      break
    end
  end
  local tbIfTrueCmdIds = self.tbIfTrueTarget[self.sAvgId][sIfTrueGroupId].cmdids
  local tbPlayed = self.tbIfTrueTarget[self.sAvgId][sIfTrueGroupId].played
  local nIdx = table.indexof(tbIfTrueCmdIds, self.nCurIndex)
  if 1 < nIdx and tbPlayed[nIdx - 1] == true then
    local nNum = #tbIfTrueCmdIds
    self.nJumpTarget = tbIfTrueCmdIds[nNum]
    return 0
  end
  if bResult == true then
    tbPlayed[nIdx] = true
  else
    self.nJumpTarget = tbIfTrueCmdIds[nIdx + 1]
  end
  return 0
end

function AvgPanel:EndIf(tbParam)
  return 0
end

function AvgPanel:IfUnlock(tbParam)
  local sGroupId = tbParam[1]
  local sConditionId = tbParam[2]
  local mapIfUnlock = self.tbIfUnlockTarget[self.sAvgId][sGroupId]
  if mapIfUnlock.nSuccIndex > 0 then
    local n = #mapIfUnlock.tbCmdId
    self.nJumpTarget = mapIfUnlock.tbCmdId[n]
  elseif AvgData:IsUnlock(sConditionId) == true then
    self.tbIfUnlockTarget[self.sAvgId][sGroupId].nSuccIndex = table.indexof(mapIfUnlock.tbCmdId, self.nCurIndex)
  else
    local n = table.indexof(mapIfUnlock.tbCmdId, self.nCurIndex) + 1
    self.nJumpTarget = mapIfUnlock.tbCmdId[n]
  end
  return 0
end

function AvgPanel:IfUnlockElse(tbParam)
  local sGroupId = tbParam[1]
  local mapIfUnlock = self.tbIfUnlockTarget[self.sAvgId][sGroupId]
  if mapIfUnlock.nSuccIndex > 0 then
    local n = #mapIfUnlock.tbCmdId
    self.nJumpTarget = mapIfUnlock.tbCmdId[n]
  else
  end
  return 0
end

function AvgPanel:IfUnlockEnd(tbParam)
  return 0
end

function AvgPanel:CheckBE(tbParam)
  local sGroupId = tbParam[1]
  local nChapterFrom = tbParam[2]
  local nChapterTo = tbParam[3]
  local nValue = tbParam[4]
  nValue = nValue / 100
  local n = AvgData:CheckBE(nChapterFrom, nChapterTo)
  local nIndex = 1
  if n == 0 then
    nIndex = 1
  elseif 0 < n and nValue >= n then
    nIndex = 2
  elseif nValue < n and n < 1 then
    nIndex = 3
  elseif n == 1 then
    nIndex = 4
  end
  self.nJumpTarget = self.tbCheckBETarget[self.sAvgId][sGroupId][nIndex]
  self.tbCheckBETarget[self.sAvgId][sGroupId].result = nIndex
  return 0
end

function AvgPanel:CheckBECase(tbParam)
  local sGroupId = tbParam[1]
  local nCase = tbParam[2]
  if nCase ~= self.tbCheckBETarget[self.sAvgId][sGroupId].result then
    self.nJumpTarget = self.tbCheckBETarget[self.sAvgId][sGroupId].CheckBEEnd
  end
  return 0
end

function AvgPanel:CheckBEEnd(tbParam)
  return 0
end

function AvgPanel:SetBGM(tbParam)
  local nType = tbParam[1]
  local sVolume = tbParam[2]
  local nTrackIndex = tbParam[3] + 1
  local sBgmName = tbParam[4]
  local sFadeTime = tbParam[5]
  local nDuration = tbParam[6]
  local bWait = tbParam[7]
  if nType == 4 then
    WwiseAudioMgr:PostEvent(sVolume)
  else
    local sBaseName = "avg_track" .. tostring(nTrackIndex)
    local sWwiseEventName = sBaseName
    if nType == 0 then
      WwiseAudioMgr:SetState(sBaseName, sBgmName)
      if sFadeTime ~= "none" then
        sWwiseEventName = sWwiseEventName .. "_fadeIn_" .. sFadeTime
      end
    elseif nType == 1 then
      sWwiseEventName = sWwiseEventName .. "_stop"
      if sFadeTime ~= "none" then
        sWwiseEventName = sWwiseEventName .. "_fadeOut_" .. sFadeTime
      end
    elseif nType == 2 then
      sWwiseEventName = sWwiseEventName .. "_pause"
      if sFadeTime ~= "none" then
        sWwiseEventName = sWwiseEventName .. "_fadeOut_" .. sFadeTime
      end
    elseif nType == 3 then
      sWwiseEventName = sWwiseEventName .. "_resume"
      if sFadeTime ~= "none" then
        sWwiseEventName = sWwiseEventName .. "_fadeIn_" .. sFadeTime
      end
    end
    WwiseAudioMgr:PostEvent(sWwiseEventName)
    if nType == 0 then
      WwiseAudioMgr:PostEvent(sVolume)
    end
  end
  if bWait == true and 0 < nDuration then
    return nDuration
  else
    return 0
  end
end

function AvgPanel:SetAudio(tbParam)
  local nType = tbParam[1]
  local sName = tbParam[2]
  local nDuration = tbParam[3]
  local bWait = tbParam[4]
  if sName ~= "" then
    if nType == 0 then
      WwiseAudioMgr:PlaySound(sName)
    elseif nType == 1 then
      WwiseAudioMgr:WwiseVoice_PlayInAVG(sName)
    elseif nType == 2 then
      self.bProcVoiceCallbackEvent = false
      WwiseAudioMgr:WwiseVoice_StopInAVG()
    end
  end
  if bWait == true then
    if 0 < nDuration then
      return nDuration
    elseif nDuration < 0 and nType == 1 then
      self.bProcVoiceCallbackEvent = true
      return -1
    else
      return 0
    end
  else
    return 0
  end
end

function AvgPanel:SetSystemBgm(bPause)
  if bPause == true then
    if ModuleManager.GetIsAdventure() == true then
      WwiseAudioMgr:PostEvent("avg_combat_enter")
    elseif self.sAvgCfgHead ~= "DP" then
      WwiseAudioMgr:PostEvent("avg_enter")
    end
  else
    if ModuleManager.GetIsAdventure() == true then
      WwiseAudioMgr:PostEvent("avg_combat_exit")
    elseif self.sAvgCfgHead ~= "DP" then
      WwiseAudioMgr:PostEvent("avg_exit")
    end
    NovaAPI.UnloadWwiseSoundBank("AVG")
    NovaAPI.UnloadWwiseSoundBank("Music_AVG")
  end
end

function AvgPanel:PlayCharEmojiSound(sEmojiName)
  for i, v in ipairs(self.tbAvgPreset.CharEmoji) do
    if v[3] == sEmojiName then
      local sEmojiSound = v[4]
      if type(sEmojiSound) == "string" and sEmojiSound ~= "" then
        self:SetAudio({0, sEmojiSound})
      end
      break
    end
  end
end

function AvgPanel:PlayFxSound(sFxName, bPlay)
  for _, v in ipairs(self.tbAvgPreset.FxResName) do
    if v[1] == sFxName then
      local sFxSound = v[2]
      if type(sFxSound) == "string" and sFxSound ~= "" then
        if bPlay ~= true then
          sFxSound = sFxSound .. "_stop"
        end
        self:SetAudio({0, sFxSound})
      end
      break
    end
  end
end

function AvgPanel:OnEvent_AvgVoiceDuration(nDuration)
  if self.bProcVoiceCallbackEvent == true then
    self.bProcVoiceCallbackEvent = false
    if 0 < nDuration then
      self:Wait({nDuration})
    else
    end
  end
end

function AvgPanel:Clear(tbParam)
  local bClearChar = tbParam[1]
  local nDuration = tbParam[2]
  local bWait = tbParam[3]
  local bClearTalk = tbParam[4]
  if bClearChar == true then
    EventManager.Hit(EventId.AvgClearAllChar, nDuration)
  end
  if bClearTalk == true then
    EventManager.Hit(EventId.AvgClearTalk)
  end
  if bWait == true and type(nDuration) == "number" and 0 < nDuration then
    return nDuration
  else
    return 0
  end
end

function AvgPanel:GetCharEmojiIndex(sEmoji)
  if self.tbAvgPreset ~= nil then
    for i, v in ipairs(self.tbAvgPreset.CharEmoji) do
      if v[3] == sEmoji then
        return v[1]
      end
    end
  end
  return 0
end

function AvgPanel:BadEnding_Check(tbParam)
  if type(self.BadEndingMarkId) == "number" and self.BadEndingMarkId > self.nCurIndex and self.BadEndingMarkId < self.END_CMD_ID then
    local nRemoveBegin = self.END_CMD_ID - 1
    local nRemoveEnd = self.BadEndingMarkId
    for i = self.END_CMD_ID - 1, self.BadEndingMarkId, -1 do
      table.remove(self.tbAvgCfg, i)
      self.END_CMD_ID = self.END_CMD_ID - 1
    end
    if #self.tbAvgCfg > self.END_CMD_ID then
      table.remove(self.tbAvgCfg, self.END_CMD_ID)
      table.insert(self.tbAvgCfg, {cmd = "End"})
      self.END_CMD_ID = #self.tbAvgCfg
    end
  end
  return 0
end

function AvgPanel:BadEnding_Mark(tbParam)
  return 0
end

function AvgPanel:JUMP_AVG_ID(tbParam)
  local sAvgId = tbParam[1]
  local nCmdId = tbParam[2]
  local sBEs = tbParam[3] or ""
  local tbBE = string.split(sBEs, ",")
  for i, sBE in ipairs(tbBE) do
    local nIdx = 0
    if sBE == "A" then
      nIdx = 1
    elseif sBE == "B" then
      nIdx = 2
    elseif sBE == "C" then
      nIdx = 3
    elseif sBE == "D" then
      nIdx = 4
    end
    if 1 <= nIdx and nIdx <= 4 and 0 >= table.indexof(self.tbBEIndex, nIdx) then
      table.insert(self.tbBEIndex, nIdx)
    end
  end
  if sAvgId == nil then
    return -1
  end
  if nCmdId == nil then
    nCmdId = 1
  end
  EventManager.Hit(EventId.TemporaryBlockInput, 1)
  if self.sAvgCfgPath ~= nil then
    package.loaded[self.sAvgCfgPath] = nil
    self.sAvgCfgPath = nil
  end
  self.sAvgId = sAvgId
  self.sAvgCfgPath = self.sRootPath .. "Config/" .. self.sAvgId
  self:RequireAndPreProcAvgConfig(self.sAvgCfgPath)
  printLog("Jump to AvgId:" .. sAvgId)
  self.nJumpTarget = nCmdId
  return 0
end

function AvgPanel:ParseEndJump(mapConfig)
  local sGroupId = mapConfig.param[1]
  local mapIfUnlock = self.tbIfUnlockTarget[self.sAvgId][sGroupId]
  local nCheckFrom, nCheckTo = 0, 0
  if 0 < mapIfUnlock.nSuccIndex then
    nCheckFrom = mapIfUnlock.tbCmdId[mapIfUnlock.nSuccIndex]
    nCheckTo = mapIfUnlock.tbCmdId[mapIfUnlock.nSuccIndex + 1]
  else
    for i, nCmdId in ipairs(mapIfUnlock.tbCmdId) do
      local mapCmd = self.tbAvgCfg[nCmdId]
      if mapCmd.cmd == "IfUnlock" then
        local sConditionId = mapCmd.param[2]
        if AvgData:IsUnlock(sConditionId) == true then
          nCheckFrom = nCmdId
          nCheckTo = mapIfUnlock.tbCmdId[i + 1]
          break
        end
      elseif mapCmd.cmd == "IfUnlockElse" then
        nCheckFrom = nCmdId
        nCheckTo = mapIfUnlock.tbCmdId[i + 1]
        break
      end
    end
  end
  if 0 < nCheckFrom and nCheckFrom < nCheckTo then
    for i = nCheckFrom, nCheckTo do
      local mapData = self.tbAvgCfg[i]
      if mapData ~= nil and mapData.cmd == "JUMP_AVG_ID" then
        return i
      end
    end
  end
  return nil
end

function AvgPanel:EnableGamepad()
  self.bHasOtherGamepadUI = GamepadUIManager.GetInputState()
  if not self.bHasOtherGamepadUI then
    GamepadUIManager.EnterAdventure(true)
  end
  GamepadUIManager.EnableGamepadUI("AVG", {})
  self.sCurGamepadUI = nil
end

function AvgPanel:DisableGamepad()
  self.sCurGamepadUI = nil
  GamepadUIManager.DisableGamepadUI("AVG")
  if not self.bHasOtherGamepadUI then
    GamepadUIManager.QuitAdventure()
  end
end

return AvgPanel
