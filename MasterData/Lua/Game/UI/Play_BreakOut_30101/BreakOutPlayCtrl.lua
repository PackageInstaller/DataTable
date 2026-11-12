local BreakOutPlayCtrl = class("BreakOutPlayCtrl", BaseCtrl)
local GamepadUIManager = require("GameCore.Module.GamepadUIManager")
local WwiseAudioMgr = CS.WwiseAudioManager.Instance
local DifficultyState = {
  "Entry",
  "Newbie",
  "Advanced",
  "Expert"
}
local colorWhite = Color(1, 1, 1, 1)
local colorRed = Color(0.8470588235294118, 0.3137254901960784, 0.32941176470588235, 1)
BreakOutPlayCtrl._mapNodeConfig = {
  btn_pause = {
    sComponentName = "NaviButton",
    callback = "OnBtnClick_Pause",
    sAction = "Map"
  },
  txt_CurrentTitle = {
    sNodeName = "txt_CurrentTitle",
    sComponentName = "TMP_Text",
    sLanguageId = "BreakOut_Target_Score"
  },
  heartItem = {nCount = 10},
  heartEffItem = {nCount = 10},
  txt_TargetScore = {
    sNodeName = "txt_TargetScore",
    sComponentName = "TMP_Text"
  },
  txt_CurrentScore = {
    sNodeName = "txt_CurrentScore",
    sComponentName = "TMP_Text"
  },
  txt_PlayTime = {
    sNodeName = "TMPChallengeTime",
    sComponentName = "TMP_Text"
  },
  animRoot = {
    sNodeName = "----SafeAreaRoot----",
    sComponentName = "Animator"
  },
  aniPlayTime = {sNodeName = "rtPlayTime", sComponentName = "Animator"},
  aniPlayScore = {
    sNodeName = "txt_CurrentScore",
    sComponentName = "Animator"
  },
  BossHUDPanel = {
    sNodeName = "BossHUDPanel",
    sCtrlName = "Game.UI.Play_BreakOut_30101.BreakOutBossHud.BreakOutBossPanelCtrl"
  },
  btn_dic = {
    sComponentName = "NaviButton",
    callback = "OnBtnClick_OpenDic",
    sAction = "Depot",
    sActionIconType = "Dark"
  },
  txt_dic = {
    nCount = 2,
    sComponentName = "TMP_Text",
    sLanguageId = "Tutorial_DicTitle"
  }
}
BreakOutPlayCtrl._mapEventConfig = {
  BrickBreaker_Time = "OnEvent_Time",
  BrickBreaker_Life = "OnEvent_HPChange",
  BrickBreaker_Scrole = "OnEvent_ScoreChange",
  BrickBreaker_GameEnd_Pre = "OnEvent_GameEnd_Pre",
  BrickBreaker_GameEnd = "OnEvent_FinishGame",
  Brick_Monster = "OnEvent_KillMonster",
  Brick_Wall = "OnEvent_BreakBricks",
  Brick_Drop = "OnEvent_DropCollect",
  BreakOut_Exit_OnClick = "OnEvent_Exit",
  BreakOut_Restart_OnClick = "OnEvent_Restart",
  BreakOut_Continue_OnClick = "OnEvent_Continue",
  BreakOutRestart = "Event_RefreshState",
  LoadLevelRefresh = "OnEvent_LoadLevelRefresh",
  BrickBreaker_Life_LimitFix = "OnEvent_LifeLimitFix",
  InputEnable = "OnEvent_InputEnable",
  BreakOutGMInfiniteMode = "OnEvent_BreakOutGMInfiniteMode",
  [EventId.ClosePanel] = "OnEvent_CloseDic"
}
BreakOutPlayCtrl._mapRedDotConfig = {}

function BreakOutPlayCtrl:Awake()
  local param = self:GetPanelParam()
  if type(param) == "table" then
    self.nActId = param[1]
    self.nLevelId = param[2]
    self.nCharacterNid = param[3]
  end
  self.BreakOutData = PlayerData.Activity:GetActivityDataById(self.nActId)
  self.LevelData = self.BreakOutData:GetDetailLevelDataById(self.nLevelId)
  self.FloorData = self.BreakOutData:GetDetailFloorDataById(self.nLevelId)
  self.nDicId = self.FloorData.DictionaryID
  self.bHasDic = self.BreakOutData.BreakOutLevelData:GetFloorHasDic(self.FloorData.Id)
  self.tbGamepadUINode = self:GetGamepadUINode()
  GamepadUIManager.EnableGamepadUI("BreakOutPlayCtrl", self.tbGamepadUINode)
  self._mapNode.btn_dic.gameObject:SetActive(self.nDicId ~= 0)
end

function BreakOutPlayCtrl:OnEnable()
  self:InitState()
  self.nEndTime = 0.0
  self.AllHeart = 10
  self.bInLockState = false
  self.Canvas = self.gameObject:GetComponent("CanvasGroup")
  NovaAPI.SetCanvasGroupAlpha(self.Canvas, 0)
  GamepadUIManager.AddGamepadUINode("BreakOutPlayCtrl", self.tbGamepadUINode)
end

function BreakOutPlayCtrl:OnDisable()
  for nEventId, sCallbackName in pairs(self._mapEventConfig) do
    local callback = self[sCallbackName]
    if type(callback) == "function" then
      EventManager.Remove(nEventId, self, callback)
    end
  end
end

function BreakOutPlayCtrl:InitState()
  self.MaxHeartNumber = self.FloorData.Heart
  for i = 1, self.MaxHeartNumber do
    self._mapNode.heartItem[i]:SetActive(true)
    local RedHeart = self._mapNode.heartItem[i].transform:Find("RedHeart")
    RedHeart.gameObject:SetActive(true)
    self._mapNode.heartEffItem[i]:SetActive(false)
  end
  for i = self.MaxHeartNumber + 1, #self._mapNode.heartItem do
    self._mapNode.heartItem[i]:SetActive(false)
  end
  self.InitialHeart = self.FloorData.Heart
  self.nRemainHp = self.InitialHeart
  self.nTargetScore = self.FloorData.Score
  self.nCurrentScore = 0
  self.nKillMonster = 0
  self.nBreakBricks = 0
  self.tbDropCollect = self.BreakOutData.BreakOutLevelData:GetCurrentFloorDrops(self.FloorData)
  self.IsGameEnd = false
  NovaAPI.SetTMPText(self._mapNode.txt_TargetScore, "/" .. self.nTargetScore)
  NovaAPI.SetTMPText(self._mapNode.txt_CurrentScore, self.nCurrentScore)
  self:SetCurrentTime(self.FloorData.Time)
end

function BreakOutPlayCtrl:ResumeLogic()
  EventManager.Hit("Event_SetPopPlayTips", true)
  PanelManager.InputEnable()
end

function BreakOutPlayCtrl:PauseLogic()
  EventManager.Hit("Event_SetPopPlayTips", false)
  PanelManager.InputDisable()
end

function BreakOutPlayCtrl:SetCurrentTime(nTime)
  self.nEndTime = nTime
  local nMin = math.floor(nTime / 60)
  local nSec = math.fmod(nTime, 60)
  NovaAPI.SetTMPText(self._mapNode.txt_PlayTime, string.format("%02d:%02d", nMin, nSec))
  if nTime <= 10 then
    NovaAPI.SetTMPColor(self._mapNode.txt_PlayTime, colorRed)
    self._mapNode.aniPlayTime:Play("BossChallengeTime_show")
  else
    NovaAPI.SetTMPColor(self._mapNode.txt_PlayTime, colorWhite)
  end
end

function BreakOutPlayCtrl:Event_RefreshState()
  self:InitState()
end

function BreakOutPlayCtrl:OnEvent_HPChange(curValue)
  if self.bInLockState then
    return
  end
  if curValue < 0 or curValue > self.InitialHeart then
    if curValue < 0 then
      curValue = 0
    else
      curValue = self.InitialHeart
    end
  end
  for i = 1, curValue do
    local RedHeart = self._mapNode.heartItem[i].transform:Find("RedHeart")
    self._mapNode.heartEffItem[i]:SetActive(false)
    RedHeart.gameObject:SetActive(true)
  end
  local nPrevHp = self.nRemainHp
  for i = curValue + 1, nPrevHp do
    local RedHeart = self._mapNode.heartItem[i].transform:Find("RedHeart")
    self._mapNode.heartEffItem[i]:SetActive(true)
    RedHeart.gameObject:SetActive(false)
    WwiseAudioMgr:PostEvent("mode_breakout_ui_dropHeart")
  end
  self.nRemainHp = curValue
end

function BreakOutPlayCtrl:OnEvent_Time(nTime)
  self:SetCurrentTime(nTime)
  if self.nDicId == 0 or self.bHasDic then
    return
  end
  self:OnEvent_OpenDic()
end

function BreakOutPlayCtrl:OnEvent_ScoreChange(currentScore)
  self.nCurrentScore = currentScore
  NovaAPI.SetTMPText(self._mapNode.txt_TargetScore, "/" .. self.nTargetScore)
  NovaAPI.SetTMPText(self._mapNode.txt_CurrentScore, self.nCurrentScore)
  self._mapNode.aniPlayScore:Play("txt_CurrentScore_in", 0, 0)
end

function BreakOutPlayCtrl:OnEvent_KillMonster(id)
  self.nKillMonster = self.nKillMonster + 1
end

function BreakOutPlayCtrl:OnEvent_BreakBricks(id)
  self.nBreakBricks = self.nBreakBricks + 1
end

function BreakOutPlayCtrl:OnEvent_DropCollect(id)
  for _, v in pairs(self.tbDropCollect) do
    if v.Id == id then
      v.Count = v.Count + 1
    end
  end
end

function BreakOutPlayCtrl:OnEvent_InputEnable(bEnable)
  self:ActiveBtnPause(bEnable)
end

function BreakOutPlayCtrl:OnBtnClick_Pause()
  EventManager.Hit("Open_BattlePause")
end

function BreakOutPlayCtrl:OnEvent_GameEnd_Pre(nResult)
  self.IsGameEnd = true
  if self.bInLockState then
    return
  end
  self:ActiveBtnPause(not self.IsGameEnd)
end

function BreakOutPlayCtrl:OnEvent_FinishGame(nResult)
  if not self.BreakOutData.BreakOutLevelData:GetIsBreakOut_Complete() or self.BreakOutData.BreakOutLevelData:GetIsFinishGame() then
    return
  end
  if self.bInLockState then
    return
  end
  if not self.IsGameEnd then
    return
  end
  local bResult = nResult == GameEnum.levelState.Success
  EventManager.Hit("BreakOut_Complete", true)
  
  local function requestCb(mapChangeInfo)
    NovaAPI.SetCanvasGroupAlpha(self.Canvas, 0)
    
    local function cb()
      self:ResumeLogic()
    end
    
    self:OpenBreakOutResultPanel(bResult, cb, mapChangeInfo)
  end
  
  self.BreakOutData:RequestFinishLevel(self:BuildFinishData(bResult), requestCb)
  EventManager.Hit("Close_BattlePause")
end

function BreakOutPlayCtrl:OnEvent_Exit()
  if self.bInLockState then
    NovaAPI.DispatchEventWithData("TGM_SET_BRICKER", nil, {2, 0})
    self.bInLockState = false
  end
  
  local function confirmCallback()
    self.IsGameEnd = true
    EventManager.Hit("Close_BattlePause")
    EventManager.Hit("BreakOut_Complete", true)
    EventManager.Hit("SetBreakOutPlaySkill_Visible", false)
    
    local function requestCb(mapChangeInfo)
      NovaAPI.SetCanvasGroupAlpha(self.Canvas, 0)
      
      local function cb()
        self:ResumeLogic()
      end
      
      self:OpenBreakOutResultPanel(false, cb, mapChangeInfo)
    end
    
    self.BreakOutData:RequestFinishLevel(self:BuildFinishData(false), requestCb)
  end
  
  local sTip = ConfigTable.GetUIText("TowerDef_Exit_Confirm")
  local msg = {
    nType = AllEnum.MessageBox.Confirm,
    sContent = sTip,
    callbackConfirmAfterClose = confirmCallback
  }
  EventManager.Hit(EventId.OpenMessageBox, msg)
end

function BreakOutPlayCtrl:OpenBreakOutResultPanel(Result, cb, mapChangeInfo)
  local sDifficultState = ConfigTable.GetUIText(DifficultyState[self.BreakOutData:GetBreakoutLevelDifficult(self.nLevelId)])
  local sTitle = " " .. sDifficultState
  local sLevelName = self.LevelData.Name .. sTitle
  EventManager.Hit("OpenBreakOutResultPanel", Result, sLevelName, cb, mapChangeInfo)
end

function BreakOutPlayCtrl:OnEvent_Restart()
  if self.IsGameEnd and not self.bInLockState then
    return
  end
  if self.bInLockState then
    self.bInLockState = false
    NovaAPI.DispatchEventWithData("TGM_SET_BRICKER", nil, {2, 0})
  end
  
  local function confirmCallback()
    NovaAPI.DispatchEventWithData("BreakOut_InRestart", nil, {true})
    EventManager.Hit("Close_BattlePause")
    EventManager.Hit("BreakOut_Complete", false)
    NovaAPI.SetCanvasGroupAlpha(self.Canvas, 0)
    EventManager.Hit("OnEvent_ClearState")
    EventManager.Hit("SetBreakOutPlaySkill_Visible", false)
    CS.AdventureModuleHelper.LevelStateChanged(false)
    EventManager.Hit("ResetBossHUD")
  end
  
  local sTip = ConfigTable.GetUIText("TowerDef_Re_Confirm")
  local msg = {
    nType = AllEnum.MessageBox.Confirm,
    sContent = sTip,
    callbackConfirm = confirmCallback
  }
  EventManager.Hit(EventId.OpenMessageBox, msg)
end

function BreakOutPlayCtrl:OnEvent_Continue()
  EventManager.Hit("Close_BattlePause")
end

function BreakOutPlayCtrl:OnEvent_LoadLevelRefresh()
  NovaAPI.SetCanvasGroupAlpha(self.Canvas, 1)
  self._mapNode.animRoot:Play("BreakOutPlayPanel_in", 0, 0)
end

function BreakOutPlayCtrl:OnEvent_LifeLimitFix(addLife)
  if addLife ~= nil then
    self.InitialHeart = self.InitialHeart + addLife <= self.AllHeart and self.InitialHeart + addLife or self.AllHeart
  end
end

function BreakOutPlayCtrl:OnEvent_BreakOutGMInfiniteMode()
  self.bInLockState = true
end

function BreakOutPlayCtrl:OnEvent_OpenDic()
  if not self.bHasDic then
    EventManager.Hit(EventId.BlockInput, false)
  end
  self:PauseLogic()
  EventManager.Hit(EventId.OpenPanel, PanelId.DictionaryEntry, self.nDicId, true)
  self._mapNode.btn_dic.gameObject:SetActive(true)
end

function BreakOutPlayCtrl:OnEvent_CloseDic(panelId)
  if panelId == PanelId.DictionaryEntry then
    self:ResumeLogic()
    self.bHasDic = true
    self.BreakOutData.BreakOutLevelData:OnEvent_SetFloorHasDic(self.FloorData.Id)
  end
end

function BreakOutPlayCtrl:OnBtnClick_OpenDic()
  if self.nDicId == 0 then
    return
  end
  self:PauseLogic()
  EventManager.Hit(EventId.OpenPanel, PanelId.DictionaryEntry, self.nDicId, true)
end

function BreakOutPlayCtrl:BuildFinishData(bWin)
  return {
    ActivityId = self.nActId,
    LevelId = self.nLevelId,
    Seconds = self.FloorData.Time - self.nEndTime,
    MonsterDefeatCount = self.nKillMonster,
    Win = bWin,
    CharId = self.nCharacterNid,
    Count = self.nBreakBricks,
    RemainHP = self.nRemainHp,
    Score = self.nCurrentScore,
    DropCollect = self.tbDropCollect
  }
end

function BreakOutPlayCtrl:ActiveBtnPause(bEnable)
  self._mapNode.btn_pause.interactable = bEnable
end

return BreakOutPlayCtrl
