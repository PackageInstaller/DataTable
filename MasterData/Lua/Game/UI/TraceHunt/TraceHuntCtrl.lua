local TraceHuntCtrl = class("TraceHuntCtrl", BaseCtrl)
local LocalSettingData = require("GameCore.Data.LocalSettingData")
local Actor2DManager = require("Game.Actor2D.Actor2DManager")
local BubbleVoiceManager = require("Game.Actor2D.BubbleVoiceManager")
local PlayerVoiceData = PlayerData.Voice
local GameResourceLoader = require("Game.Common.Resource.GameResourceLoader")
local ClientManager = CS.ClientManager.Instance
local WwiseManger = CS.WwiseAudioManager.Instance
TraceHuntCtrl._mapNodeConfig = {
  TopBar = {
    sNodeName = "TopBarPanel",
    sCtrlName = "Game.UI.TopBarEx.TopBarCtrl"
  },
  rawImgActor2D = {
    sNodeName = "----Actor2D----",
    sComponentName = "RawImage"
  },
  trActor2D_PNG = {
    sNodeName = "----Actor2D_PNG----",
    sComponentName = "Transform"
  },
  btnActor = {
    sComponentName = "Button",
    callback = "OnBtnClick_Actor2D"
  },
  goBubbleRoot = {
    sNodeName = "----fixed_bubble----"
  },
  Trace = {sNodeName = "--Trace--"},
  imgPieceOff = {nCount = 5},
  imgPieceOn = {nCount = 5},
  imgPieceIcon = {nCount = 5, sComponentName = "Image"},
  imgTraceProgress = {sComponentName = "Image"},
  txtTraceProgress = {sComponentName = "TMP_Text"},
  txtTraceProgressTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "TraceHunt_TraceProgress"
  },
  aniPiece = {
    nCount = 5,
    sNodeName = "goPiece",
    sComponentName = "Animator"
  },
  MagnifierRoot = {},
  aniMagnifier = {sNodeName = "magnifier", sComponentName = "Animator"},
  Hunt = {sNodeName = "--Hunt--"},
  aniHunt = {sNodeName = "--Hunt--", sComponentName = "Animator"},
  imgFullIcon = {sComponentName = "Image"},
  txtBossName = {nCount = 2, sComponentName = "TMP_Text"},
  txtHuntProgressTitle = {nCount = 2, sComponentName = "TMP_Text"},
  imgHuntProgress = {sComponentName = "Image"},
  txtHuntLeftTime = {sComponentName = "TMP_Text"},
  imgArrested = {},
  imgEscaped = {},
  dbHuntLeftTime = {},
  goNormal = {},
  goHard = {},
  rtAffix = {},
  txtAffix = {nCount = 3, sComponentName = "TMP_Text"},
  goSwitch = {},
  txtSwitchTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "TraceHunt_HardSwitch_Title"
  },
  btnHardInfo = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_HardInfo"
  },
  imgExtraIcon = {sComponentName = "Image"},
  txtExtraCount = {sComponentName = "TMP_Text"},
  txtSwitchLock = {sComponentName = "TMP_Text"},
  goSwitchBtn = {},
  btnSwitch = {
    nCount = 2,
    sComponentName = "UIButton",
    callback = "OnBtnClick_Switch"
  },
  SwitchOn = {
    sComponentName = "TMP_Text",
    sLanguageId = "TraceHunt_HardSwitch_Open"
  },
  SwitchOff = {
    sComponentName = "TMP_Text",
    sLanguageId = "TraceHunt_HardSwitch_Close"
  },
  txtTraceHuntTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "TraceHunt_Board_Title"
  },
  btnShop = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Shop"
  },
  btnHandbook = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Handbook"
  },
  btnHelpFriend = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Help"
  },
  txtBtnShop = {
    sComponentName = "TMP_Text",
    sLanguageId = "TraceHunt_Btn_Shop"
  },
  txtBtnHandbook = {
    sComponentName = "TMP_Text",
    sLanguageId = "TraceHunt_Btn_HandBook"
  },
  txtBtnHelp = {
    sComponentName = "TMP_Text",
    sLanguageId = "TraceHunt_Btn_Help"
  },
  txtRefreshTime = {sComponentName = "TMP_Text"},
  txtHelpCount = {sComponentName = "TMP_Text"},
  iconHelp = {sComponentName = "Image"},
  cgLeft = {
    sNodeName = "---Left---",
    sComponentName = "CanvasGroup"
  },
  btnTrace = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Trace"
  },
  txtBtnTrace = {
    sComponentName = "TMP_Text",
    sLanguageId = "TraceHunt_Btn_Trace"
  },
  imgReqTraceIcon = {sComponentName = "Image"},
  txtReqTraceCount = {sComponentName = "TMP_Text"},
  btnHunt = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Hunt"
  },
  goReqHunt = {},
  txtBtnHunt = {sComponentName = "TMP_Text"},
  imgReqHuntIcon = {sComponentName = "Image"},
  txtReqHuntCount = {sComponentName = "TMP_Text"},
  btnMultiTrace = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_MultiTrace"
  },
  txtBtnMultiTrace = {sComponentName = "TMP_Text"},
  btnSkip = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Skip"
  },
  txtBtnSkip = {
    sComponentName = "TMP_Text",
    sLanguageId = "TraceHunt_Btn_Skip"
  },
  goAutoTips = {},
  txtAutoTips = {sComponentName = "TMP_Text"},
  btnHuntReward = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Reward"
  },
  txtBtnHuntReward = {
    sComponentName = "TMP_Text",
    sLanguageId = "TraceHunt_Btn_Reward"
  },
  txtLevelTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "TraceHunt_HuntLevelTitle"
  },
  txtLevel = {sComponentName = "TMP_Text"},
  btnLevelInfo = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_LevelInfo"
  },
  goExpBar = {
    sCtrlName = "Game.UI.TemplateEx.TemplateExpBarCtrl"
  },
  Content = {sComponentName = "Transform"},
  ScrollView = {sComponentName = "ScrollRect"},
  LogHeight = {sComponentName = "Transform"},
  LogRoot = {},
  goTraceBtn = {},
  goHuntBtn = {},
  goHuntLogEmpty = {},
  goTraceLogEmpty = {},
  txtHuntLogEmpty = {
    sComponentName = "TMP_Text",
    sLanguageId = "TraceHunt_HuntLogEmpty"
  },
  txtTraceLogEmpty = {
    sComponentName = "TMP_Text",
    sLanguageId = "TraceHunt_TraceLogEmpty"
  },
  goResCoin2 = {},
  btnResCoin = {
    nCount = 2,
    sNodeName = "goResCoin",
    sComponentName = "UIButton",
    callback = "OnBtnClick_CoinTips"
  },
  imgResCoin = {nCount = 2, sComponentName = "Image"},
  txtResCount = {nCount = 2, sComponentName = "TMP_Text"},
  goTip = {sNodeName = "--Tips--"},
  btnTipsBg = {
    sComponentName = "Button",
    callback = "OnBtnClick_TipsBg"
  },
  txtTipsName = {sComponentName = "TMP_Text"},
  txtTipsContent = {sComponentName = "TMP_Text"},
  txtDailyCount = {sComponentName = "TMP_Text"},
  txtDailyTime = {sComponentName = "TMP_Text"},
  blur = {
    sNodeName = "t_fullscreen_blur_blue"
  },
  aniBlur = {
    sNodeName = "t_fullscreen_blur_blue",
    sComponentName = "Animator"
  },
  btnBlur = {
    sNodeName = "snapshot",
    sComponentName = "Button",
    callback = "OnBtnClick_ClosePop"
  },
  Update = {sNodeName = "--Update--"},
  aniUpdate = {sNodeName = "--Update--", sComponentName = "Animator"},
  txtDate = {sComponentName = "TMP_Text"},
  txtClickToContinue = {
    sComponentName = "TMP_Text",
    sLanguageId = "Tips_Continue_Refresh"
  },
  Block = {},
  redDotReward = {},
  redDotHelp = {},
  redDotResBar = {}
}
TraceHuntCtrl._mapEventConfig = {
  [EventId.CoinResChange] = "RefreshRes",
  TraceHuntItemChange = "RefreshRes",
  [EventId.UIBackConfirm] = "OnEvent_Back",
  [EventId.UIHomeConfirm] = "OnEvent_Home",
  TraceHuntCurBossExpired = "OnEvent_BossExpired",
  TraceHuntNewControl = "OnEvent_NewControl",
  [EventId.ShowBubbleVoiceText] = "OnEvent_ShowBubbleVoiceText",
  TraceHuntInfoChange = "OnEvent_InfoChange"
}
TraceHuntCtrl._mapRedDotConfig = {
  [RedDotDefine.TraceHunt_Reward_Boss] = {
    sNodeName = "redDotReward"
  },
  [RedDotDefine.TraceHunt_TraceItem] = {
    sNodeName = "redDotResBar"
  },
  [RedDotDefine.TraceHunt_HuntItem] = {sNodeName = "redDotHelp"}
}

function TraceHuntCtrl:RefreshContent()
  self:RefreshControl()
  self:RefreshInfo()
  self:RefreshState()
  self:RefreshRes()
  self:StartTicketsRefreshTimer()
  self:RefreshNPC2D()
end

function TraceHuntCtrl:RefreshConfig()
  self.nTraceItemId = ConfigTable.GetConfigNumber("TraceHuntRequestItemTid")
  local mapCfg = ConfigTable.GetData_Item(self.nTraceItemId)
  self.sTraceItemTitle = mapCfg and mapCfg.Title or ""
  self.nHuntItemId = ConfigTable.GetConfigNumber("TraceHuntPermitItemTid")
  local mapHuntCfg = ConfigTable.GetData_Item(self.nHuntItemId)
  self.sHuntItemTitle = mapHuntCfg and mapHuntCfg.Title or ""
  self.sHuntItemIcon = mapHuntCfg and mapHuntCfg.Icon or ""
  self.tbHuntPieceSuffix = ConfigTable.GetConfigArray("TraceHuntPieceSuffixOrder")
  self.tbPieceNeedProgress = ConfigTable.GetConfigNumberArray("TraceHuntPieceNeedTraceProgress")
  self.nMaxTraceProgress = ConfigTable.GetConfigNumber("TraceHuntMaxTraceProgress")
  self.nMaxMultiTrace = ConfigTable.GetConfigNumber("TraceHuntMaxMultiTrace")
  self.npcId = ConfigTable.GetConfigNumber("TraceHuntNPCId")
  self.nNormalTime = ConfigTable.GetConfigNumber("TraceHuntBossTimeLimit")
  self.nHardTime = ConfigTable.GetConfigNumber("TraceHuntHardBossTimeLimit")
end

function TraceHuntCtrl:RefreshControl()
  self.nControlLeftTime = PlayerData.TraceHunt:GetControlLeftTime()
  if self.timerCountDownControl == nil then
    self.timerCountDownControl = self:AddTimer(0, 1, "RefreshControlTime", false, true, false)
  end
  self.nControlLeftTime = self.nControlLeftTime + 1
  self:RefreshControlTime()
  if self.nControlLeftTime > 0 then
    self.timerCountDownControl:Pause(false)
  end
end

function TraceHuntCtrl:RefreshInfo()
  local nLevel, nExp = PlayerData.TraceHunt:GetTraceHuntLevel()
  local nMaxLevel = PlayerData.TraceHunt:GetTraceHuntMaxLevel()
  local mapLevel = PlayerData.TraceHunt:GetTraceHuntLevelData(nLevel)
  NovaAPI.SetTMPText(self._mapNode.txtLevel, orderedFormat(ConfigTable.GetUIText("TraceHunt_HuntLevel"), nLevel))
  local mapLevelData = {
    nLevel = nLevel,
    nExp = nExp,
    nMaxLevel = nMaxLevel,
    nMaxExp = mapLevel.Exp
  }
  self._mapNode.goExpBar:Refresh(mapLevelData)
  local tbMax = ConfigTable.GetConfigArray("TraceHuntPermitItem")
  local nHasHunt = PlayerData.TraceHunt:GetHuntTokenCount()
  NovaAPI.SetTMPText(self._mapNode.txtHelpCount, self:ThousandsNumber(nHasHunt) .. "/" .. tbMax[3])
  self:SetPngSprite(self._mapNode.iconHelp, self.sHuntItemIcon)
  NovaAPI.SetCanvasGroupInteractable(self._mapNode.cgLeft, true)
  NovaAPI.SetCanvasGroupBlocksRaycasts(self._mapNode.cgLeft, true)
end

function TraceHuntCtrl:RefreshRes()
  local nCount = PlayerData.Item:GetItemCountByID(AllEnum.CoinItemId.TraceHunt)
  self:SetSprite_Coin(self._mapNode.imgResCoin[1], AllEnum.CoinItemId.TraceHunt)
  NovaAPI.SetTMPText(self._mapNode.txtResCount[1], self:ThousandsNumber(nCount))
  self:SetSprite_Coin(self._mapNode.imgResCoin[2], self.nTraceItemId)
  local tbMax = ConfigTable.GetConfigArray("TraceHuntRequestItem")
  local nHasCoin = PlayerData.TraceHunt:GetTraceTokenCount()
  NovaAPI.SetTMPText(self._mapNode.txtResCount[2], self:ThousandsNumber(nHasCoin) .. "/" .. tbMax[3])
end

function TraceHuntCtrl:RefreshControlTime()
  self.nControlLeftTime = self.nControlLeftTime - 1
  if self.nControlLeftTime > 0 then
    local sTime = ""
    if self.nControlLeftTime <= 60 then
      local sec = math.floor(self.nControlLeftTime)
      sTime = orderedFormat(ConfigTable.GetUIText("TraceHunt_ControlRefresh_Sec"), sec)
    elseif self.nControlLeftTime > 60 and self.nControlLeftTime <= 3600 then
      local min = math.floor(self.nControlLeftTime / 60)
      local sec = math.floor(self.nControlLeftTime - min * 60)
      if sec == 0 then
        min = min - 1
        sec = 60
      end
      sTime = orderedFormat(ConfigTable.GetUIText("TraceHunt_ControlRefresh_Min"), min, sec)
    elseif self.nControlLeftTime > 3600 and self.nControlLeftTime <= 86400 then
      local hour = math.floor(self.nControlLeftTime / 3600)
      local min = math.floor((self.nControlLeftTime - hour * 3600) / 60)
      if min == 0 then
        hour = hour - 1
        min = 60
      end
      sTime = orderedFormat(ConfigTable.GetUIText("TraceHunt_ControlRefresh_Hour"), hour, min)
    elseif self.nControlLeftTime > 86400 then
      local day = math.floor(self.nControlLeftTime / 86400)
      local hour = math.floor((self.nControlLeftTime - day * 86400) / 3600)
      if hour == 0 then
        day = day - 1
        hour = 24
      end
      sTime = orderedFormat(ConfigTable.GetUIText("TraceHunt_ControlRefresh_Day"), day, hour)
    end
    NovaAPI.SetTMPText(self._mapNode.txtRefreshTime, sTime)
  else
    NovaAPI.SetTMPText(self._mapNode.txtRefreshTime, orderedFormat(ConfigTable.GetUIText("TraceHunt_ControlRefresh_Sec"), 0))
    self.timerCountDownControl:Pause(true)
  end
end

function TraceHuntCtrl:RefreshState()
  local bMaxTrace = PlayerData.TraceHunt:CheckMaxTrace()
  self._mapNode.Trace:SetActive(not bMaxTrace)
  self._mapNode.goTraceBtn:SetActive(not bMaxTrace)
  self._mapNode.Hunt:SetActive(bMaxTrace)
  self._mapNode.goHuntBtn:SetActive(bMaxTrace)
  if not bMaxTrace then
    self:RefreshTrace()
  elseif bMaxTrace then
    self:RefreshHunt()
  end
  self:PlayEnterStateVoice()
end

function TraceHuntCtrl:ChangeState()
  EventManager.Hit(EventId.TemporaryBlockInput, 2.5)
  self._mapNode.Hunt:SetActive(true)
  self.bChangeState = true
  self.animator:Play("TraceHuntSelectPanel_unlock_synthesis", 0, 0)
  WwiseManger:PostEvent("mode_gongdou_get")
  self:AddTimer(1, 1, function()
    if self._mapNode == nil then
      return
    end
    self:RefreshState()
    self.bChangeState = false
  end, true, true, true)
end

function TraceHuntCtrl:RefreshTrace()
  self:RefreshTraceBoard()
  self:RefreshTraceBtn()
  self:RefreshTraceLog()
end

function TraceHuntCtrl:RefreshTraceBoard()
  local nProgress = PlayerData.TraceHunt:GetTraceProgress()
  local nBossId = PlayerData.TraceHunt:GetBossId()
  local sIcon = ""
  if nBossId ~= 0 then
    local mapBossCfg = ConfigTable.GetData("TraceHuntBoss", nBossId, true)
    sIcon = mapBossCfg and mapBossCfg.ClueIcon or ""
  end
  local nPieceCount = 0
  for i, v in ipairs(self.tbPieceNeedProgress) do
    if v <= nProgress then
      nPieceCount = i
    end
  end
  for i = 1, 5 do
    self._mapNode.imgPieceOff[i]:SetActive(i > nPieceCount)
    self._mapNode.imgPieceOn[i]:SetActive(i <= nPieceCount)
    if i <= nPieceCount and nBossId ~= 0 then
      self:SetPngSprite(self._mapNode.imgPieceIcon[i], sIcon .. self.tbHuntPieceSuffix[i])
    end
  end
  NovaAPI.SetTMPText(self._mapNode.txtTraceProgress, string.format("%.1f%%", nProgress))
  NovaAPI.SetImageFillAmount(self._mapNode.imgTraceProgress, nProgress / 100)
end

function TraceHuntCtrl:PlayTraceBoardAni(nBeforeProgress)
  local nProgress = PlayerData.TraceHunt:GetTraceProgress()
  local nBossId = PlayerData.TraceHunt:GetBossId()
  local sIcon = ""
  if nBossId ~= 0 then
    local mapBossCfg = ConfigTable.GetData("TraceHuntBoss", nBossId, true)
    sIcon = mapBossCfg and mapBossCfg.ClueIcon or ""
  end
  local nPieceCount, nBeforePieceCount = self:GetPieceCount(nBeforeProgress)
  if nBeforePieceCount < nPieceCount then
    self:KillSequenceBoard()
    self.sequenceBoard = DOTween.Sequence()
    for i = nBeforePieceCount + 1, nPieceCount do
      if i <= nPieceCount and nBossId ~= 0 then
        self:SetPngSprite(self._mapNode.imgPieceIcon[i], sIcon .. self.tbHuntPieceSuffix[i])
      end
      self:AddSequence_PieceOn(self.sequenceBoard, i)
    end
    local bMaxTrace = PlayerData.TraceHunt:CheckMaxTrace()
    if bMaxTrace then
      EventManager.Hit(EventId.BlockInput, true)
    end
    local callback = dotween_callback_handler(self, function()
      self:PlayPieceEndAni(bMaxTrace, nBeforePieceCount, nPieceCount)
      if bMaxTrace then
        EventManager.Hit(EventId.BlockInput, false)
        self:ChangeState()
      end
    end)
    self.sequenceBoard:OnComplete(callback)
  end
  local nTextTime = 0.3
  DOTween.To(function()
    return nBeforeProgress
  end, function(v)
    NovaAPI.SetTMPText(self._mapNode.txtTraceProgress, string.format("%.1f%%", v))
  end, nProgress, nTextTime)
  NovaAPI.ImageDoFillAmount(self._mapNode.imgTraceProgress, nProgress / 100, nTextTime, false)
end

function TraceHuntCtrl:PlayTraceAddLog(nNewLogStart, nBeforeProgress)
  self:KillSequenceTraceLog()
  self.sequenceTraceLog = DOTween.Sequence()
  local nPieceCount, nBeforePieceCount = self:GetPieceCount(nBeforeProgress)
  local tbLog = PlayerData.TraceHunt:GetTraceLog()
  local nEmptyLogIndex = nNewLogStart
  local ctrlLogPlaying
  for i = nNewLogStart, self.nTraceLogCount do
    local mapLog = tbLog[i]
    local mapLogCfg = ConfigTable.GetData("TraceHuntLogEntryTemplate", mapLog.nId)
    if not mapLogCfg then
      return
    end
    
    local function log(nWaitTime)
      self.sequenceTraceLog:AppendCallback(function()
        local ctrlLog = self:CreateLog(mapLog)
        nEmptyLogIndex = nEmptyLogIndex + 1
        if ctrlLog then
          ctrlLog:PlayLogAni(false, nWaitTime)
          local nTime = 0.3
          self._mapNode.ScrollView:DOVerticalNormalizedPos(0, nTime):SetEase(Ease.OutQuart)
          ctrlLogPlaying = ctrlLog
        end
      end)
    end
    
    local bWait = mapLogCfg.Type == GameEnum.TraceHuntLogType.Tracing and nBeforePieceCount < nPieceCount
    local nWaitTime = 1
    if bWait then
      log(nWaitTime)
    else
      log()
    end
    self.sequenceTraceLog:AppendInterval(bWait and nWaitTime or 0.5)
  end
  local callback = dotween_callback_handler(self, function()
    if ctrlLogPlaying and ctrlLogPlaying.gameObject and ctrlLogPlaying.gameObject:IsNull() == false then
      ctrlLogPlaying:PlayLogAni(true)
    end
    self:RefreshAddLog(tbLog, nEmptyLogIndex, true)
  end)
  self.sequenceTraceLog:OnComplete(callback)
end

function TraceHuntCtrl:PlayMultiTraceAni(nBeforeProgress, nTraceCount, nNewLogStart)
  self:KillSequenceBoard()
  self:KillSequenceTraceLog()
  self._mapNode.btnSkip.gameObject:SetActive(true)
  self._mapNode.goAutoTips.gameObject:SetActive(true)
  self._mapNode.btnTrace.gameObject:SetActive(false)
  self._mapNode.btnMultiTrace.gameObject:SetActive(false)
  NovaAPI.SetTMPText(self._mapNode.txtAutoTips, orderedFormat(ConfigTable.GetUIText("TraceHunt_AutoCount"), nTraceCount))
  local nBossId = PlayerData.TraceHunt:GetBossId()
  local sIcon = ""
  if nBossId ~= 0 then
    local mapBossCfg = ConfigTable.GetData("TraceHuntBoss", nBossId, true)
    sIcon = mapBossCfg and mapBossCfg.ClueIcon or ""
  end
  local nAimProgress = PlayerData.TraceHunt:GetTraceProgress()
  local nBeforePieceCount, nAimPieceCount = 0, 0
  for i, v in ipairs(self.tbPieceNeedProgress) do
    if nBeforeProgress >= v then
      nBeforePieceCount = i
    end
    if v <= nAimProgress then
      nAimPieceCount = i
    end
  end
  local nProgress = nBeforeProgress
  local nStartPieceCount = nBeforePieceCount
  local nPieceCount = 0
  self.sequenceMulti = DOTween.Sequence()
  local tbLog = PlayerData.TraceHunt:GetTraceLog()
  local nEmptyLogIndex = nNewLogStart
  for i = nNewLogStart, self.nTraceLogCount do
    local mapLog = tbLog[i]
    local mapLogCfg = ConfigTable.GetData("TraceHuntLogEntryTemplate", mapLog.nId)
    if not mapLogCfg then
      return
    end
    
    local function log(nWaitTime)
      self.sequenceMulti:AppendCallback(function()
        local ctrlLog = self:CreateLog(mapLog)
        nEmptyLogIndex = nEmptyLogIndex + 1
        if ctrlLog then
          ctrlLog:PlayLogAni(false, nWaitTime)
          local nTime = 0.3
          self._mapNode.ScrollView:DOVerticalNormalizedPos(0, nTime):SetEase(Ease.OutQuart)
        end
      end)
    end
    
    if mapLogCfg.Type == GameEnum.TraceHuntLogType.Tracing then
      local nAdd = tonumber(mapLog.tbArgs[1]) / self.nMaxTraceProgress * 100
      nProgress = nProgress + nAdd
      if 100 < nProgress then
        nProgress = 100
      end
      for j, v in ipairs(self.tbPieceNeedProgress) do
        if v <= nProgress then
          nPieceCount = j
        end
      end
      local nWaitTime = 1
      if nBeforePieceCount < nPieceCount then
        log(nWaitTime)
      else
        log()
      end
      local nTextTime = 0.3
      local tw1 = DOTween.To(function()
        return nBeforeProgress
      end, function(v)
        NovaAPI.SetTMPText(self._mapNode.txtTraceProgress, string.format("%.1f%%", v))
      end, nProgress, nTextTime)
      local tw2 = NovaAPI.ImageDoFillAmount(self._mapNode.imgTraceProgress, nProgress / 100, nTextTime, false)
      self.sequenceMulti:Join(tw1)
      self.sequenceMulti:Join(tw2)
      self.sequenceMulti:AppendCallback(function()
        nTraceCount = nTraceCount - 1
        nBeforeProgress = nBeforeProgress + nAdd
        NovaAPI.SetTMPText(self._mapNode.txtAutoTips, orderedFormat(ConfigTable.GetUIText("TraceHunt_AutoCount"), nTraceCount))
      end)
      if nBeforePieceCount < nPieceCount then
        for j = nBeforePieceCount + 1, nPieceCount do
          if nPieceCount >= j and nBossId ~= 0 then
            self:SetPngSprite(self._mapNode.imgPieceIcon[j], sIcon .. self.tbHuntPieceSuffix[j])
          end
          self:AddSequence_PieceOn(self.sequenceMulti, j)
        end
        nBeforePieceCount = nPieceCount
      end
    else
      log()
    end
    self.sequenceMulti:AppendInterval(0.3)
  end
  local bMaxTrace = PlayerData.TraceHunt:CheckMaxTrace()
  local callback = dotween_callback_handler(self, function()
    self:PlayPieceEndAni(bMaxTrace, nStartPieceCount, nAimPieceCount)
    self:RefreshAddLog(tbLog, nEmptyLogIndex, true)
    if bMaxTrace then
      self:ChangeState()
    else
      self:RefreshTraceBtn()
    end
  end)
  self.sequenceMulti:OnComplete(callback)
end

function TraceHuntCtrl:AddSequence_PieceOn(sequence, nPiece)
  sequence:AppendCallback(function()
    self._mapNode.MagnifierRoot:SetActive(true)
    self._mapNode.aniMagnifier:Play("TraceHuntSelectPanel_magnifier" .. nPiece, 0, 0)
    WwiseManger:PostEvent("mode_gongdou_finding")
  end)
  local nTime1 = NovaAPI.GetAnimClipLength(self._mapNode.aniMagnifier, {
    "TraceHuntSelectPanel_magnifier" .. nPiece
  }) - 0.2
  sequence:AppendInterval(nTime1)
  sequence:AppendCallback(function()
    self._mapNode.aniPiece[nPiece]:Play("TraceHuntSelectPanel_unlock" .. nPiece, 0, 0)
    WwiseManger:PostEvent("mode_gongdou_found")
    self._mapNode.imgPieceOn[nPiece]:SetActive(true)
  end)
  local nTime2 = NovaAPI.GetAnimClipLength(self._mapNode.aniPiece[nPiece], {
    "TraceHuntSelectPanel_unlock" .. nPiece
  })
  sequence:AppendInterval(nTime2)
  sequence:AppendCallback(function()
    self._mapNode.imgPieceOff[nPiece]:SetActive(false)
    self._mapNode.MagnifierRoot:SetActive(false)
  end)
end

function TraceHuntCtrl:PlayPieceEndAni(bMaxTrace, nStartPiece, nEndPiece)
  self._mapNode.MagnifierRoot:SetActive(false)
  if bMaxTrace then
    for i = nStartPiece + 1, nEndPiece do
      self._mapNode.imgPieceOn[i]:SetActive(true)
      self._mapNode.imgPieceOff[i]:SetActive(false)
      self._mapNode.aniPiece[i]:Play("TraceHuntSelectPanel_unlock" .. i, 0, 1)
    end
  else
    for i = nStartPiece + 1, nEndPiece do
      if self._mapNode.imgPieceOn[i].activeSelf == true then
        self._mapNode.imgPieceOff[i]:SetActive(false)
        self._mapNode.aniPiece[i]:Play("TraceHuntSelectPanel_unlock" .. i, 0, 1)
      else
        self._mapNode.imgPieceOn[i]:SetActive(true)
        self._mapNode.aniPiece[i]:Play("TraceHuntSelectPanel_unlock" .. i, 0, 0)
        WwiseManger:PostEvent("mode_gongdou_found")
        local nTime = NovaAPI.GetAnimClipLength(self._mapNode.aniPiece[i], {
          "TraceHuntSelectPanel_unlock" .. i
        })
        self:AddTimer(1, nTime, function()
          if self._mapNode == nil then
            return
          end
          self._mapNode.imgPieceOff[i]:SetActive(false)
        end, true, true, true)
      end
    end
  end
end

function TraceHuntCtrl:RefreshTraceBtn()
  local nCost = PlayerData.TraceHunt:GetTraceCostCount()
  local nHasCoin = PlayerData.TraceHunt:GetTraceTokenCount()
  self:SetSprite_Coin(self._mapNode.imgReqTraceIcon, self.nTraceItemId)
  NovaAPI.SetTMPText(self._mapNode.txtReqTraceCount, math.ceil(nCost))
  NovaAPI.SetTMPColor(self._mapNode.txtReqTraceCount, nCost <= nHasCoin and Blue_Normal or Red_Unable)
  self._mapNode.btnMultiTrace.gameObject:SetActive(true)
  self._mapNode.btnSkip.gameObject:SetActive(false)
  self._mapNode.goAutoTips.gameObject:SetActive(false)
  self._mapNode.btnTrace.gameObject:SetActive(true)
  if nHasCoin >= 2 * nCost then
    local nCount = math.modf(nHasCoin / nCost)
    if nCount > self.nMaxMultiTrace then
      nCount = self.nMaxMultiTrace
    end
    NovaAPI.SetTMPText(self._mapNode.txtBtnMultiTrace, orderedFormat(ConfigTable.GetUIText("TraceHunt_Btn_MultiTrace"), nCount))
  else
    NovaAPI.SetTMPText(self._mapNode.txtBtnMultiTrace, orderedFormat(ConfigTable.GetUIText("TraceHunt_Btn_MultiTrace"), 2))
  end
end

function TraceHuntCtrl:RefreshTraceLog()
  local tbLog = PlayerData.TraceHunt:GetTraceLog()
  self.nTraceLogCount = #tbLog
  delChildren(self._mapNode.Content)
  self:RefreshLog(tbLog)
  self:RefreshTraceLogEmpty()
end

function TraceHuntCtrl:UpdateTraceLogCount()
  local tbLog = PlayerData.TraceHunt:GetTraceLog()
  local nNewLogStart = self.nTraceLogCount + 1
  self.nTraceLogCount = #tbLog
  self:RefreshTraceLogEmpty()
  return nNewLogStart
end

function TraceHuntCtrl:RefreshTraceLogEmpty()
  self._mapNode.goTraceLogEmpty:SetActive(self.nTraceLogCount == 0)
  self._mapNode.goHuntLogEmpty:SetActive(false)
end

function TraceHuntCtrl:RefreshHunt()
  self:RefreshHuntBoard()
  self:RefreshHuntBoardHard()
  self:RefreshHuntBtn()
  self:RefreshHuntLog()
end

function TraceHuntCtrl:RefreshHuntBoard()
  local nProgress = PlayerData.TraceHunt:GetHuntProgress()
  local nBossId = PlayerData.TraceHunt:GetBossId()
  local mapBossCfg = ConfigTable.GetData("TraceHuntBoss", nBossId, true)
  if not mapBossCfg then
    return
  end
  self:SetPngSprite(self._mapNode.imgFullIcon, mapBossCfg.TargetIcon)
  local mData = ConfigTable.GetData("Monster", mapBossCfg.MonsterId)
  local mSkin = ConfigTable.GetData("MonsterSkin", mData.FAId)
  local mManual = ConfigTable.GetData("MonsterManual", mSkin.MonsterManual)
  local sP = string.format("%.1f", nProgress)
  NovaAPI.SetImageFillAmount(self._mapNode.imgHuntProgress, nProgress / 100)
  for i = 1, 2 do
    NovaAPI.SetTMPText(self._mapNode.txtBossName[i], mManual.Name)
    NovaAPI.SetTMPText(self._mapNode.txtHuntProgressTitle[i], orderedFormat(ConfigTable.GetUIText("TraceHunt_HuntProgress"), sP))
  end
  self.nHuntLeftTime = PlayerData.TraceHunt:GetHuntLeftTime()
  if self.timerCountDownHunt == nil then
    self.timerCountDownHunt = self:AddTimer(0, 1, "RefreshHuntTime", false, true, false)
  end
  self:RefreshHuntTime()
  if self.nHuntLeftTime > 0 then
    self.timerCountDownHunt:Pause(false)
  end
end

function TraceHuntCtrl:RefreshHuntBoardHard()
  local nHard = PlayerData.TraceHunt:GetSelfBossHard()
  self._mapNode.goNormal:SetActive(nHard == 1)
  self._mapNode.goHard:SetActive(1 < nHard)
  self._mapNode.rtAffix:SetActive(1 < nHard)
  if 1 < nHard then
    NovaAPI.SetTMPText(self._mapNode.txtAffix[1], ConfigTable.GetUIText("TraceHunt_HardSwitch_AffixAtk"))
    NovaAPI.SetTMPText(self._mapNode.txtAffix[2], ConfigTable.GetUIText("TraceHunt_HardSwitch_AffixDef"))
    NovaAPI.SetTMPText(self._mapNode.txtAffix[3], orderedFormat(ConfigTable.GetUIText("TraceHunt_HardSwitch_AffixTime"), self.nNormalTime - self.nHardTime))
  end
  local bBlock = PlayerData.TraceHunt:GetControlBlockState()
  local bComplete = PlayerData.TraceHunt:CheckHuntComplete()
  local bInterrupt = PlayerData.TraceHunt:CheckHuntInterrupt()
  self._mapNode.goSwitch:SetActive(not bBlock and not bComplete and not bInterrupt)
  local nHardOpenLevel = PlayerData.TraceHunt:GetHardOpenLevel()
  local nLevel = PlayerData.TraceHunt:GetTraceHuntLevel()
  self._mapNode.goSwitchBtn:SetActive(nHardOpenLevel <= nLevel)
  self._mapNode.txtSwitchLock.gameObject:SetActive(nHardOpenLevel > nLevel)
  NovaAPI.SetTMPText(self._mapNode.txtSwitchLock, orderedFormat(ConfigTable.GetUIText("TraceHunt_HardSwitch_LevelLimit"), nHardOpenLevel))
  self:SetSprite_Coin(self._mapNode.imgExtraIcon, AllEnum.CoinItemId.TraceHunt)
  local mapDifficulty = ConfigTable.GetData("TraceHuntDifficulty", 2)
  NovaAPI.SetTMPText(self._mapNode.txtExtraCount, string.format("+%d%%", mapDifficulty.TokenRate))
  self._mapNode.btnSwitch[1].gameObject:SetActive(nHard == 1)
  self._mapNode.btnSwitch[2].gameObject:SetActive(1 < nHard)
end

function TraceHuntCtrl:RefreshHuntBtn()
  local nHuntCount = PlayerData.TraceHunt:GetSelfHuntCount()
  local nCost = PlayerData.TraceHunt:GetHuntCostCount(true)
  local nHasCoin = PlayerData.TraceHunt:GetHuntTokenCount()
  local bComplete = PlayerData.TraceHunt:CheckHuntComplete()
  local bInterrupt = PlayerData.TraceHunt:CheckHuntInterrupt()
  if bComplete or bInterrupt then
    self._mapNode.btnHunt.gameObject:SetActive(false)
    self._mapNode.btnHuntReward.gameObject:SetActive(true)
    self._mapNode.imgArrested:SetActive(bComplete)
    self._mapNode.imgEscaped:SetActive(bInterrupt)
    self._mapNode.dbHuntLeftTime:SetActive(true)
    NovaAPI.SetTMPText(self._mapNode.txtHuntLeftTime, ConfigTable.GetUIText("TraceHunt_HuntEnd"))
  else
    self._mapNode.btnHunt.gameObject:SetActive(true)
    self._mapNode.btnHuntReward.gameObject:SetActive(false)
    self._mapNode.imgArrested:SetActive(false)
    self._mapNode.imgEscaped:SetActive(false)
    self._mapNode.dbHuntLeftTime:SetActive(0 < nHuntCount)
    if nHuntCount == 0 then
      NovaAPI.SetTMPText(self._mapNode.txtBtnHunt, ConfigTable.GetUIText("TraceHunt_Btn_Hunt"))
    else
      NovaAPI.SetTMPText(self._mapNode.txtBtnHunt, ConfigTable.GetUIText("TraceHunt_Btn_HuntAgain"))
    end
    self._mapNode.goReqHunt:SetActive(0 < nCost)
    if 0 < nCost then
      self:SetSprite_Coin(self._mapNode.imgReqHuntIcon, self.nHuntItemId)
      NovaAPI.SetTMPText(self._mapNode.txtReqHuntCount, math.ceil(nCost))
      NovaAPI.SetTMPColor(self._mapNode.txtReqHuntCount, nCost <= nHasCoin and Blue_Normal or Red_Unable)
    end
  end
end

function TraceHuntCtrl:RefreshHuntLog()
  local tbLog = PlayerData.TraceHunt:GetHuntLog()
  self.nHuntLogCount = #tbLog
  delChildren(self._mapNode.Content)
  self:RefreshLog(tbLog)
  self:RefreshHuntLogEmpty()
end

function TraceHuntCtrl:RefreshHuntLogEmpty()
  self._mapNode.goTraceLogEmpty:SetActive(false)
  self._mapNode.goHuntLogEmpty:SetActive(self.nHuntLogCount == 0)
end

function TraceHuntCtrl:RefreshHuntAddLog()
  local tbLog = PlayerData.TraceHunt:GetHuntLog()
  self:RefreshAddLog(tbLog, self.nHuntLogCount + 1)
  self.nHuntLogCount = #tbLog
  self:RefreshHuntLogEmpty()
end

function TraceHuntCtrl:RefreshLog(tbLog)
  for _, mapLog in ipairs(tbLog) do
    self:CreateLog(mapLog)
  end
  NovaAPI.SetVerticalNormalizedPosition(self._mapNode.ScrollView, 0)
end

function TraceHuntCtrl:RefreshAddLog(tbLog, nStart, bSkip)
  for i = nStart, #tbLog do
    local mapLog = tbLog[i]
    local ctrlLog = self:CreateLog(mapLog)
    if ctrlLog then
      ctrlLog:PlayLogAni(bSkip)
      local nTime = 0.3
      self._mapNode.ScrollView:DOVerticalNormalizedPos(0, nTime):SetEase(Ease.OutQuart)
    end
  end
end

function TraceHuntCtrl:CreateLog(mapLog)
  local mapCfg = ConfigTable.GetData("TraceHuntLogEntryTemplate", mapLog.nId)
  if mapCfg then
    local logPrefab
    local sPrefab = "UI/Play_TraceHuntLevelSelect/LogTemplate/TraceHuntLogTemplate" .. mapCfg.Template .. ".prefab"
    if GameResourceLoader.ExistsAsset(Settings.AB_ROOT_PATH .. sPrefab) == true then
      logPrefab = self:LoadAsset(sPrefab)
    end
    if logPrefab ~= nil then
      local goRoot = instantiate(self._mapNode.LogRoot, self._mapNode.Content)
      local rtRoot = goRoot.transform:GetComponent("RectTransform")
      local goLog = instantiate(logPrefab, self._mapNode.LogHeight)
      local ctrlLog = self:BindCtrlByNode(goLog, "Game.UI.TraceHunt.TraceHuntLogCtrl")
      ctrlLog:Refresh(mapLog)
      local nH = ctrlLog:ForceRebuild()
      rtRoot.sizeDelta = Vector2(rtRoot.sizeDelta.x, nH)
      goLog.transform:SetParent(rtRoot)
      goLog.transform:GetComponent("RectTransform").anchoredPosition = Vector2(0, 0)
      return ctrlLog
    end
  end
  return nil
end

function TraceHuntCtrl:RefreshHuntTime()
  self.nHuntLeftTime = self.nHuntLeftTime - 1
  if self.nHuntLeftTime > 0 then
    local sTime = ""
    if self.nHuntLeftTime <= 60 then
      local sec = math.floor(self.nHuntLeftTime)
      sTime = orderedFormat(ConfigTable.GetUIText("TraceHunt_HuntRefresh_Sec"), sec)
    elseif self.nHuntLeftTime > 60 and self.nHuntLeftTime <= 3600 then
      local min = math.floor(self.nHuntLeftTime / 60)
      local sec = math.floor(self.nHuntLeftTime - min * 60)
      if sec == 0 then
        min = min - 1
        sec = 60
      end
      sTime = orderedFormat(ConfigTable.GetUIText("TraceHunt_HuntRefresh_Min"), min, sec)
    elseif self.nHuntLeftTime > 3600 and self.nHuntLeftTime <= 86400 then
      local hour = math.floor(self.nHuntLeftTime / 3600)
      local min = math.floor((self.nHuntLeftTime - hour * 3600) / 60)
      if min == 0 then
        hour = hour - 1
        min = 60
      end
      sTime = orderedFormat(ConfigTable.GetUIText("TraceHunt_HuntRefresh_Hour"), hour, min)
    end
    NovaAPI.SetTMPText(self._mapNode.txtHuntLeftTime, sTime)
  else
    NovaAPI.SetTMPText(self._mapNode.txtHuntLeftTime, orderedFormat(ConfigTable.GetUIText("TraceHunt_HuntRefresh_Sec"), 0))
    self.timerCountDownHunt:Pause(true)
  end
end

function TraceHuntCtrl:RefreshNPC2D()
  local bUseL2D = LocalSettingData.mapData.UseLive2D
  self._mapNode.rawImgActor2D.transform.localScale = bUseL2D == true and Vector3.one or Vector3.zero
  self._mapNode.trActor2D_PNG.localScale = bUseL2D == true and Vector3.zero or Vector3.one
  NovaAPI.SetButtonInteractable(self._mapNode.btnActor, true)
  local nPanelId = self:GetPanelId()
  if bUseL2D == true then
    Actor2DManager.SetBoardNPC2D(nPanelId, self._mapNode.rawImgActor2D, self.npcId)
  else
    Actor2DManager.SetBoardNPC2D_PNG(self._mapNode.trActor2D_PNG, nPanelId, self.npcId)
  end
end

function TraceHuntCtrl:PlayEnterStateVoice()
  local bMaxTrace = PlayerData.TraceHunt:CheckMaxTrace()
  if bMaxTrace then
    PlayerVoiceData:PlayCharVoice("greet_th_hunt0", self.npcId, nil, true)
  else
    local nProgress = PlayerData.TraceHunt:GetTraceProgress()
    if nProgress <= 50 then
      PlayerVoiceData:PlayCharVoice("greet_th_trace0", self.npcId, nil, true)
    else
      PlayerVoiceData:PlayCharVoice("greet_th_trace1", self.npcId, nil, true)
    end
  end
end

function TraceHuntCtrl:RefreshNewControl(bWait)
  local bNew = PlayerData.TraceHunt:GetNewControl()
  if not bNew then
    return
  end
  
  local function open()
    if self._mapNode == nil then
      return
    end
    self._mapNode.blur:SetActive(true)
    self._mapNode.Update:SetActive(true)
    self._mapNode.aniUpdate:Play("TraceHuntHelpPanel_tips_in")
    EventManager.Hit(EventId.TemporaryBlockInput, 0.3)
    local nEndTime = PlayerData.TraceHunt:GetEndTime()
    local nStartTime = PlayerData.TraceHunt:GetStartTime()
    local nOpenYear = tostring(os.date("%Y", nStartTime))
    local nOpenMonth = tostring(os.date("%m", nStartTime))
    local nOpenDay = tostring(os.date("%d", nStartTime))
    local nOpenHour = tonumber(os.date("%H", nStartTime))
    local nOpenMin = tonumber(os.date("%M", nStartTime))
    local nEndYear = tostring(os.date("%Y", nEndTime))
    local nEndMonth = tostring(os.date("%m", nEndTime))
    local nEndDay = tostring(os.date("%d", nEndTime))
    local nEndHour = tonumber(os.date("%H", nEndTime))
    local nEndMin = tonumber(os.date("%M", nEndTime))
    local strOpenHour = string.format("%02d", nOpenHour)
    local strEndHour = string.format("%02d", nEndHour)
    local strOpenMin = string.format("%02d", nOpenMin)
    local strEndMin = string.format("%02d", nEndMin)
    local dateStr = string.format("%s/%s/%s %s:%s ~ %s/%s/%s %s:%s", nOpenYear, nOpenMonth, nOpenDay, strOpenHour, strOpenMin, nEndYear, nEndMonth, nEndDay, strEndHour, strEndMin)
    NovaAPI.SetTMPText(self._mapNode.txtDate, dateStr)
  end
  
  PlayerData.TraceHunt:SetNewControl(false)
  if bWait then
    EventManager.Hit(EventId.TemporaryBlockInput, 1)
    self:AddTimer(1, 1, open, true, true, true)
  else
    open()
  end
end

function TraceHuntCtrl:GetPieceCount(nBeforeProgress)
  local nProgress = PlayerData.TraceHunt:GetTraceProgress()
  local nPieceCount, nBeforePieceCount = 0, 0
  for i, v in ipairs(self.tbPieceNeedProgress) do
    if v <= nProgress then
      nPieceCount = i
    end
    if v <= nBeforeProgress then
      nBeforePieceCount = i
    end
  end
  return nPieceCount, nBeforePieceCount
end

function TraceHuntCtrl:StartTicketsRefreshTimer()
  if self.ticketRefreshTimer ~= nil then
    self.ticketRefreshTimer:Cancel()
    self.ticketRefreshTimer = nil
  end
  local nCurTime = ClientManager.serverTimeStamp
  local nNextRefreshTime = CS.ClientManager.Instance:GetNextRefreshTime(nCurTime)
  
  local function refreshTime()
    nCurTime = ClientManager.serverTimeStamp
    local nRemainTime = nNextRefreshTime - nCurTime
    local sTime = timeFormat_HMS(nRemainTime)
    NovaAPI.SetTMPText(self._mapNode.txtDailyTime, orderedFormat(ConfigTable.GetUIText("TraceHunt_Coin_Time"), self.sTraceItemTitle, sTime))
  end
  
  refreshTime()
  self.ticketRefreshTimer = self:AddTimer(0, 1, function()
    refreshTime()
  end, true, true, false)
end

function TraceHuntCtrl:PlayTraceInAni(callback)
  self._mapNode.TopBar:SetTitleTxt(ConfigTable.GetUIText("TraceHunt_Topbar_Sub"))
  self.animator:Play("TraceHuntSelectPanel_enlarge", 0, 0)
  NovaAPI.SetButtonInteractable(self._mapNode.btnActor, false)
  NovaAPI.SetCanvasGroupInteractable(self._mapNode.cgLeft, false)
  NovaAPI.SetCanvasGroupBlocksRaycasts(self._mapNode.cgLeft, false)
  WwiseManger:PostEvent("mode_gongdou_board")
  EventManager.Hit(EventId.TemporaryBlockInput, 0.5)
  self:AddTimer(1, 0.5, callback, true, true, true)
end

function TraceHuntCtrl:KillSequence()
  self:KillSequenceBoard()
  self:KillSequenceTraceLog()
  self:KillSequenceMulti()
end

function TraceHuntCtrl:KillSequenceBoard()
  if self.sequenceBoard then
    self.sequenceBoard:Kill(true)
    self.sequenceBoard = nil
  end
end

function TraceHuntCtrl:KillSequenceTraceLog()
  if self.sequenceTraceLog then
    self.sequenceTraceLog:Kill(true)
    self.sequenceTraceLog = nil
  end
end

function TraceHuntCtrl:KillSequenceMulti()
  if self.sequenceMulti then
    self.sequenceMulti:Kill(true)
    self.sequenceMulti = nil
  end
end

function TraceHuntCtrl:ClearTimer()
  if self.ticketRefreshTimer ~= nil then
    self.ticketRefreshTimer:Cancel()
    self.ticketRefreshTimer = nil
  end
  if self.timerCountDownControl ~= nil then
    self.timerCountDownControl:Cancel()
    self.timerCountDownControl = nil
  end
  if self.timerCountDownHunt ~= nil then
    self.timerCountDownHunt:Cancel()
    self.timerCountDownHunt = nil
  end
end

function TraceHuntCtrl:FadeIn()
  if self._panel._nFadeInType == 1 then
    EventManager.Hit(EventId.SetTransition)
    self.animator:Play("TraceHuntSelectPanel_in", 0, 0)
    local nAnimTime = NovaAPI.GetAnimClipLength(self.animator, {
      "TraceHuntSelectPanel_in"
    })
    self._mapNode.Block:SetActive(true)
    self:AddTimer(1, nAnimTime, function()
      self._mapNode.Block:SetActive(false)
    end, true, true, true)
  elseif self._panel._nFadeInType == 2 then
    self.animator:Play("TraceHuntSelectPanel_in", 0, 1)
    self._mapNode.Block:SetActive(false)
  end
end

function TraceHuntCtrl:Awake()
  self.bLarge = false
  self:RefreshConfig()
end

function TraceHuntCtrl:OnEnable()
  self.animator = self.gameObject:GetComponent("Animator")
  PlayerVoiceData:StartBoardFreeTimer(self.npcId)
  self:RefreshContent()
  self:RefreshNewControl(true)
end

function TraceHuntCtrl:OnDisable()
  Actor2DManager.UnsetBoardNPC2D()
  BubbleVoiceManager.StopBubbleAnim()
  PlayerVoiceData:ClearTimer()
  PlayerVoiceData:StopCharVoice()
  self._panel._nFadeInType = 2
  self.bLarge = false
  self.bChangeState = false
  self:ClearTimer()
  self:KillSequence()
end

function TraceHuntCtrl:OnDestroy()
end

function TraceHuntCtrl:OnBtnClick_Shop(btn)
  EventManager.Hit(EventId.OpenPanel, PanelId.ShopPanel, ConfigTable.GetConfigNumber("TraceHuntShopID"))
end

function TraceHuntCtrl:OnBtnClick_Handbook(btn)
  EventManager.Hit(EventId.OpenPanel, PanelId.TraceHuntHandBook)
end

function TraceHuntCtrl:OnBtnClick_Help(btn)
  EventManager.Hit(EventId.OpenPanel, PanelId.TraceHuntHelp)
end

function TraceHuntCtrl:OnBtnClick_Trace(btn)
  local nCost = PlayerData.TraceHunt:GetTraceCostCount()
  local nHasCoin = PlayerData.TraceHunt:GetTraceTokenCount()
  if nCost > nHasCoin then
    EventManager.Hit(EventId.OpenMessageBox, orderedFormat(ConfigTable.GetUIText("TraceHunt_Tips_TraceItemNotEnough"), self.sTraceItemTitle))
    return
  end
  local nBeforeProgress = PlayerData.TraceHunt:GetTraceProgress()
  
  local function trace()
    local function callback()
      self:RefreshTraceBtn()
      
      local nNewLogStart = self:UpdateTraceLogCount()
      self:PlayTraceAddLog(nNewLogStart, nBeforeProgress)
      self:PlayTraceBoardAni(nBeforeProgress)
    end
    
    PlayerData.TraceHunt:SendTraceHuntTraceReq(1, callback)
  end
  
  if not self.bLarge then
    self.bLarge = true
    self:PlayTraceInAni(trace)
  else
    trace()
  end
end

function TraceHuntCtrl:OnBtnClick_MultiTrace(btn)
  local nCost = PlayerData.TraceHunt:GetTraceCostCount()
  local nHasCoin = PlayerData.TraceHunt:GetTraceTokenCount()
  local nCount = math.modf(nHasCoin / nCost)
  if nCount > self.nMaxMultiTrace then
    nCount = self.nMaxMultiTrace
  end
  if nHasCoin < 2 * nCost then
    EventManager.Hit(EventId.OpenMessageBox, orderedFormat(ConfigTable.GetUIText("TraceHunt_Tips_TraceItemNotEnough"), self.sTraceItemTitle))
    return
  end
  local nBeforeProgress = PlayerData.TraceHunt:GetTraceProgress()
  
  local function trace()
    local function callback()
      local nNewLogStart = self:UpdateTraceLogCount()
      
      self:PlayMultiTraceAni(nBeforeProgress, nCount, nNewLogStart)
    end
    
    PlayerData.TraceHunt:SendTraceHuntTraceReq(nCount, callback)
  end
  
  if not self.bLarge then
    self.bLarge = true
    self:PlayTraceInAni(trace)
  else
    trace()
  end
end

function TraceHuntCtrl:OnBtnClick_Hunt(btn)
  local nHuntCount = PlayerData.TraceHunt:GetSelfHuntCount()
  local nCost = PlayerData.TraceHunt:GetHuntCostCount(true)
  local nHasCoin = PlayerData.TraceHunt:GetHuntTokenCount()
  if nCost > nHasCoin then
    EventManager.Hit(EventId.OpenMessageBox, orderedFormat(ConfigTable.GetUIText("TraceHunt_Tips_HuntItemNotEnough"), self.sHuntItemTitle))
    return
  end
  if PlayerData.TraceHunt:GetControlLeftTime() <= 0 then
    EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("TraceHunt_Tips_ControlInterrupt"))
    return
  end
  if PlayerData.TraceHunt:CheckHuntInterrupt() then
    EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("TraceHunt_Tips_HuntInterrupt"))
    return
  end
  
  local function hunt()
    local function OpenPanel()
      local nBossCreateTime = PlayerData.TraceHunt:GetBossCreateTime()
      
      local nBossId = PlayerData.TraceHunt:GetBossId()
      EventManager.Hit(EventId.OpenPanel, PanelId.RegionBossFormation, AllEnum.RegionBossFormationType.TraceHunt, nBossId, {
        PlayerData.Base._nPlayerId,
        nBossCreateTime
      })
    end
    
    EventManager.Hit(EventId.SetTransition, 2, OpenPanel)
  end
  
  local bWarn = PlayerData.TraceHunt:GetHuntWarning()
  if 0 < nHuntCount and bWarn then
    local isSelectAgain = false
    
    local function confirmCallback()
      PlayerData.TraceHunt:SetHuntWarning(not isSelectAgain)
      hunt()
    end
    
    local function againCallback(isSelect)
      isSelectAgain = isSelect
    end
    
    local msg = {
      nType = AllEnum.MessageBox.Confirm,
      sContent = orderedFormat(ConfigTable.GetUIText("TraceHunt_MultiHuntWarning"), self.sHuntItemTitle),
      callbackConfirm = confirmCallback,
      callbackAgain = againCallback,
      sAgain = ConfigTable.GetUIText("MessageBox_LoginWarning"),
      sConfirm = ConfigTable.GetUIText("TraceHunt_Btn_MultiHuntWarningConfirm"),
      sCancel = ConfigTable.GetUIText("TraceHunt_Btn_MultiHuntWarningCancel")
    }
    EventManager.Hit(EventId.OpenMessageBox, msg)
  else
    hunt()
  end
end

function TraceHuntCtrl:OnBtnClick_Reward(btn)
  local function callback(mapBeforeLevel, mapAfterLevel, mapChangeInfo)
    local function ani_end()
      if mapAfterLevel.nLevel > mapBeforeLevel.nLevel then
        local function suc()
          local mapData = {
            nLevel = mapAfterLevel.nLevel,
            
            mapLevel = PlayerData.TraceHunt:GetTraceHuntLevelData(mapAfterLevel.nLevel)
          }
          EventManager.Hit(EventId.OpenPanel, PanelId.TraceHuntSucBar, mapData)
        end
        
        UTILS.OpenReceiveByChangeInfo(mapChangeInfo, suc)
      else
        UTILS.OpenReceiveByChangeInfo(mapChangeInfo)
      end
      self:RefreshContent()
    end
    
    EventManager.Hit(EventId.TemporaryBlockInput, 0.5)
    self:RefreshHuntAddLog()
    self:AddTimer(1, 0.5, function()
      self._mapNode.goExpBar:PlayAni(mapBeforeLevel, mapAfterLevel, ani_end)
    end, true, true, true)
  end
  
  PlayerData.TraceHunt:SendTraceHuntRewardReceiveReq(callback)
end

function TraceHuntCtrl:OnBtnClick_Skip(btn)
  self:KillSequenceMulti()
end

function TraceHuntCtrl:OnBtnClick_LevelInfo(btn)
  EventManager.Hit(EventId.OpenPanel, PanelId.TraceHuntLevel)
end

function TraceHuntCtrl:OnBtnClick_HardInfo(btn)
  local mapData = {
    Title = ConfigTable.GetUIText("TraceHunt_HardSwitch_TipsTitle"),
    Desc = {
      ConfigTable.GetUIText("TraceHunt_HardSwitch_TipsDesc")
    }
  }
  EventManager.Hit(EventId.OpenPanel, PanelId.DescTips, btn.transform, mapData)
end

function TraceHuntCtrl:OnBtnClick_Switch(btn, nIndex)
  local nHard = PlayerData.TraceHunt:GetSelfBossHard()
  nHard = 3 - nHard
  PlayerData.TraceHunt:SetSelfBossHard(nHard)
  self:RefreshHuntBoardHard()
  if nHard == 1 then
    self._mapNode.aniHunt:Play("TraceHuntSelectPanelHunt_ToNormal", 0, 0)
  else
    self._mapNode.aniHunt:Play("TraceHuntSelectPanelHunt_ToHard", 0, 0)
  end
end

function TraceHuntCtrl:OnBtnClick_CoinTips(btn, nIndex)
  if nIndex == 1 then
    UTILS.ClickItemGridWithTips(AllEnum.CoinItemId.TraceHunt, self._mapNode.btnResCoin[1].transform, true, true, false)
  else
    self._mapNode.goTip.gameObject:SetActive(true)
    local sortingOrder = NovaAPI.GetCanvasSortingOrder(self.gameObject:GetComponent("Canvas"))
    NovaAPI.SetButtonInteractable(self._mapNode.btnResCoin[2], false)
    NovaAPI.SetComponentEnableByName(self._mapNode.goResCoin2, "TopGridCanvas", true)
    NovaAPI.SetTopGridCanvasSorting(self._mapNode.goResCoin2, sortingOrder + 1)
    NovaAPI.SetTMPText(self._mapNode.txtTipsName, self.sTraceItemTitle)
    local tbMax = ConfigTable.GetConfigArray("TraceHuntRequestItem")
    NovaAPI.SetTMPText(self._mapNode.txtTipsContent, orderedFormat(ConfigTable.GetUIText("TraceHunt_Coin_Rule"), tbMax[1], self.sTraceItemTitle))
    local nDaily = PlayerData.TraceHunt:GetTraceTokenDailyCount()
    NovaAPI.SetTMPText(self._mapNode.txtDailyCount, orderedFormat(ConfigTable.GetUIText("TraceHunt_Coin_Daily"), nDaily, tbMax[2]))
  end
end

function TraceHuntCtrl:OnBtnClick_TipsBg()
  NovaAPI.SetButtonInteractable(self._mapNode.btnResCoin[2], true)
  NovaAPI.SetComponentEnableByName(self._mapNode.goResCoin2, "TopGridCanvas", false)
  self._mapNode.goTip.gameObject:SetActive(false)
end

function TraceHuntCtrl:OnBtnClick_ClosePop(btn)
  self._mapNode.aniUpdate:Play("TraceHuntHelpPanel_tips_out")
  self._mapNode.aniBlur:SetTrigger("tOut")
  self:AddTimer(1, 0.25, function()
    self._mapNode.blur:SetActive(false)
    self._mapNode.Update:SetActive(false)
  end, true, true, true)
  EventManager.Hit(EventId.TemporaryBlockInput, 0.25)
end

function TraceHuntCtrl:OnBtnClick_Actor2D()
  local bMaxTrace = PlayerData.TraceHunt:CheckMaxTrace()
  if bMaxTrace then
    PlayerVoiceData:PlayBoardNPCClickVoice(self.npcId, 0, "poster_th_hunt0")
  else
    local nProgress = PlayerData.TraceHunt:GetTraceProgress()
    if nProgress <= 50 then
      PlayerVoiceData:PlayBoardNPCClickVoice(self.npcId, 0, "poster_th_trace0")
    else
      PlayerVoiceData:PlayBoardNPCClickVoice(self.npcId, 0, "poster_th_trace1")
    end
  end
end

function TraceHuntCtrl:OnEvent_BossExpired()
  self:RefreshHuntBoard()
  self:RefreshHuntBoardHard()
  self:RefreshHuntBtn()
  self:RefreshHuntAddLog()
end

function TraceHuntCtrl:OnEvent_NewControl()
  self.animator:Play("TraceHuntSelectPanel_in", 0, 1)
  self:RefreshContent()
  self:RefreshNewControl()
end

function TraceHuntCtrl:OnEvent_InfoChange()
  self:RefreshContent()
end

function TraceHuntCtrl:OnEvent_ShowBubbleVoiceText(nNpcId, nId)
  if nNpcId ~= self.npcId then
    return
  end
  local mapVoDirectoryData = ConfigTable.GetData("VoDirectory", nId)
  if mapVoDirectoryData == nil then
    printError("VoDirectory未找到数据id:" .. nId)
    return
  end
  BubbleVoiceManager.PlayFixedBubbleAnim(self._mapNode.goBubbleRoot, mapVoDirectoryData.voResource)
end

function TraceHuntCtrl:OnEvent_Back(nPanelId)
  if self._panel._nPanelId ~= nPanelId then
    return
  end
  if self.bLarge then
    self:KillSequence()
    if self.bChangeState then
      return
    end
    self.bLarge = false
    self._mapNode.TopBar:SetTitleTxt(ConfigTable.GetData("TopBar", "TraceHunt").Title)
    self.animator:Play("TraceHuntSelectPanel_back", 0, 0)
    NovaAPI.SetButtonInteractable(self._mapNode.btnActor, true)
    NovaAPI.SetCanvasGroupInteractable(self._mapNode.cgLeft, true)
    NovaAPI.SetCanvasGroupBlocksRaycasts(self._mapNode.cgLeft, true)
    WwiseManger:PostEvent("mode_gongdou_board_out")
    EventManager.Hit(EventId.TemporaryBlockInput, 0.5)
  else
    EventManager.Hit(EventId.CloesCurPanel)
  end
end

function TraceHuntCtrl:OnEvent_Home(nPanelId)
  if self._panel._nPanelId ~= nPanelId then
    return
  end
  PanelManager.Home()
end

return TraceHuntCtrl
