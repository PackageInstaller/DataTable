local UIActSGMiniGame = class("UIActSGMiniGame", UIBaseWindow)
local base = UIActSGMiniGame
local ActSGMiniGameEnum = require("Game.ActivitySteinsGateMiniGame.Data.ActSGMiniGameEnum")
local UINActSGMiniGameStart = require("Game.ActivitySteinsGateMiniGame.UI.UINActSGMiniGameStart")
local UINActSGMiniGamePlay = require("Game.ActivitySteinsGateMiniGame.UI.UINActSGMiniGamePlay")
local UINActSGMiniGameEnd = require("Game.ActivitySteinsGateMiniGame.UI.UINActSGMiniGameEnd")
local UINActSGMiniGameRank = require("Game.ActivitySteinsGateMiniGame.UI.Rank.UINSteinsGateMiniGameRank")
local UINActSGMiniGameReward = require("Game.ActivitySteinsGateMiniGame.UI.Reward.UINSGMiniGameReward")
local ActivityFrameUtil = require("Game.ActivityFrame.ActivityFrameUtil")
local delayTime = 0.6

function UIActSGMiniGame:OnInit()
  UIUtil.SetTopStatus(self, self.BackAction, nil, nil, nil, true)
  UIUtil.AddButtonListener(self.ui.btn_Back, self, self.OnClickBack)
  UIUtil.AddButtonListener(self.ui.btn_Rank, self, self.OnClickRank)
  UIUtil.AddButtonListener(self.ui.btn_Tip, self, self.OnClickRuleTip)
  UIUtil.AddButtonListener(self.ui.btn_Big, self, self.OnClickBigGame)
  UIUtil.AddButtonListener(self.ui.btn_Small, self, self.OnClickSmallGame)
  self.SGMiniGameStart = UINActSGMiniGameStart.New()
  self.SGMiniGameStart:Init(self.ui.gameStart)
  self.SGMiniGamePlay = UINActSGMiniGamePlay.New()
  self.SGMiniGamePlay:Init(self.ui.gamePlay)
  self.SGMiniGameEnd = UINActSGMiniGameEnd.New()
  self.SGMiniGameEnd:Init(self.ui.gameEnd)
  self.SGMiniGameRank = UINActSGMiniGameRank.New()
  self.SGMiniGameRank:Init(self.ui.rank)
  self.SGMiniGameReward = UINActSGMiniGameReward.New()
  self.SGMiniGameReward:Init(self.ui.obj_reward)
  self.refreshDataCallback = BindCallback(self, self.RefreshSGGameData)
  self.endPlayCallback = BindCallback(self, self.OnPlaySGMiniGameEnd)
  self.rePlayCallback = BindCallback(self, self.RePlaySGMiniGame)
  self.refreshRewardCallback = BindCallback(self, self.RefreshRewardTaskUI)
  MsgCenter:AddListener(eMsgEventId.TaskUpdate, self.refreshRewardCallback)
  MsgCenter:AddListener(eMsgEventId.TaskDelete, self.refreshRewardCallback)
end

function UIActSGMiniGame:InitActSGMiniGame(actId, backCallback)
  self._actId = actId
  local ctrl = ControllerManager:GetController(ControllerTypeId.ActSteinsGateMiniGame)
  if ctrl == nil then
    return
  end
  self.backCallback = backCallback
  self.actData = ctrl:GetSteinsGateMiniGameDataByActId(actId)
  AudioManager:PlayAudioById(3433)
  self:ChangeMiniGameState(ActSGMiniGameEnum.UIState.GameMenuMain)
  self._timerId = TimerManager:StartTimer(1, self.__OnTimeDown, self, false, false)
  self:__OnTimeDown()
end

function UIActSGMiniGame:RefreshRewardTaskUI()
  self.SGMiniGameReward:InitSGMiniGameReward(self.actData)
end

function UIActSGMiniGame:RefreshActSGMiniGameStartUI()
  local _, _, expireTime = ActivityFrameUtil.GetShowEndTimeStr(self.actData)
  self._expireTime = expireTime
  local redDotNum = self.actData:GetSGMiniGameTaskRedDot()
  self.ui.obj_redDot:SetActive(0 < redDotNum)
end

function UIActSGMiniGame:OnClickBigGame()
  self.gameType = ActSGMiniGameEnum.GameType.MashUp
  self.gameData = self.actData:GetSteinsGateTinyGameData(self.gameType)
  self:RefreshSGGameData()
  self:ChangeMiniGameState(ActSGMiniGameEnum.UIState.GameWaiteStart)
end

function UIActSGMiniGame:OnClickSmallGame()
  self.gameType = ActSGMiniGameEnum.GameType.MashDown
  self.gameData = self.actData:GetSteinsGateTinyGameData(self.gameType)
  self:RefreshSGGameData()
  self:ChangeMiniGameState(ActSGMiniGameEnum.UIState.GameWaiteStart)
end

function UIActSGMiniGame:RefreshSGGameData()
  local hisScore = self.gameData:GetTinyGameHistoryScore()
  self.ui.tex_HisScore.text = tostring(hisScore)
  self.ui.tex_HisScoreBk.text = string.format("%09d", hisScore)
end

function UIActSGMiniGame:OnClickBack()
  UIUtil.OnClickBackByUiTab(self)
end

function UIActSGMiniGame:BackAction()
  if self.state == ActSGMiniGameEnum.UIState.GameMenuMain then
    self:Delete()
    if self.backCallback then
      self.backCallback()
      local sectorCtrl = ControllerManager:GetController(ControllerTypeId.SectorController)
      if sectorCtrl ~= nil then
        sectorCtrl:PlaySectorBgm()
      end
    end
    return
  end
  UIUtil.SetTopStatus(self, self.BackAction, nil, nil, nil, true)
  
  local function func()
    if self.state == ActSGMiniGameEnum.UIState.GameWaiteStart then
      self:PlaySGMiniGameLoadingAnim()
    end
    self:ChangeMiniGameState(ActSGMiniGameEnum.UIState.GameMenuMain)
  end
  
  if self.state == ActSGMiniGameEnum.UIState.GamePlay then
    self.SGMiniGamePlay:CheckSGMiniGameExit(BindCallback(self, func))
    return
  end
  func()
end

function UIActSGMiniGame:OnClickRuleTip()
  local tipId, tipContentId = self.actData:GetSGMiniGameTip()
  UIManager:ShowWindowAsync(UIWindowTypeID.CommonInfo, function(window)
    if window == nil then
      return
    end
    window:InitCommonInfo(ConfigData:GetTipContent(tipContentId), ConfigData:GetTipContent(tipId), nil, true)
  end)
end

local StateInitFuncDic = {
  [ActSGMiniGameEnum.UIState.GameMenuMain] = function(self, gameType)
    self.SGMiniGameReward:Hide()
    self.ui.btn_Score:SetActive(false)
    self.ui.obj_gameStart:SetActive(true)
    self.gameType = nil
    self:RefreshActSGMiniGameStartUI()
  end,
  [ActSGMiniGameEnum.UIState.GameWaiteStart] = function(self, gameType)
    self.SGMiniGameStart:Show()
    self.ui.btn_Score:SetActive(true)
    if gameType == ActSGMiniGameEnum.GameType.MashDown then
      self.SGMiniGameReward:Show()
      self:RefreshRewardTaskUI()
    end
    self.SGMiniGameStart:InitActSGMiniGameStart(self.gameType, BindCallback(self, self.EnterPlaySGMiniGame))
    self:PlaySGMiniGameLoadingAnim()
  end,
  [ActSGMiniGameEnum.UIState.GamePlay] = function(self, gameType)
    self.SGMiniGamePlay:Show()
    self.ui.btn_Score:SetActive(true)
    self.SGMiniGamePlay:InitActSGMiniGamePlay(gameType, self.gameData, self.refreshDataCallback, self.endPlayCallback)
  end,
  [ActSGMiniGameEnum.UIState.GamePlayEnd] = function(self, gameType)
    self.SGMiniGameEnd:Show()
    self.ui.btn_Score:SetActive(true)
    self.SGMiniGameEnd:InitActSGMiniGameEnd(gameType, self.gameData, self.rePlayCallback)
  end
}
local StateExitFuncDic = {
  [ActSGMiniGameEnum.UIState.GameMenuMain] = function(self, gameType)
    self.ui.obj_gameStart:SetActive(false)
  end,
  [ActSGMiniGameEnum.UIState.GameWaiteStart] = function(self, gameType)
    self.SGMiniGameStart:BackAction()
  end,
  [ActSGMiniGameEnum.UIState.GamePlay] = function(self, gameType)
    self.SGMiniGamePlay:BackAction()
  end,
  [ActSGMiniGameEnum.UIState.GamePlayEnd] = function(self, gameType)
    self.SGMiniGameEnd:BackAction()
  end
}

function UIActSGMiniGame:ChangeMiniGameState(state)
  if self.state then
    StateExitFuncDic[self.state](self, self.gameType)
  end
  self.state = state
  StateInitFuncDic[self.state](self, self.gameType)
end

function UIActSGMiniGame:OnPlaySGMiniGameEnd()
  self:ChangeMiniGameState(ActSGMiniGameEnum.UIState.GamePlayEnd, self.gameType)
end

function UIActSGMiniGame:EnterPlaySGMiniGame()
  self:ChangeMiniGameState(ActSGMiniGameEnum.UIState.GamePlay, self.gameType)
end

function UIActSGMiniGame:RePlaySGMiniGame()
  self:ChangeMiniGameState(ActSGMiniGameEnum.UIState.GamePlay, self.gameType)
end

function UIActSGMiniGame:OnClickRank()
  self.SGMiniGameRank:Show()
  self.SGMiniGameRank:InitSteinsGateMiniGameRank(self.actData, self.gameType)
end

function UIActSGMiniGame:__OnTimeDown()
  local diffTime = self._expireTime - PlayerDataCenter.timestamp
  diffTime = diffTime < 0 and 0 or diffTime
  local d, h, m = TimeUtil:TimestampToTimeInter(diffTime, false, true)
  local texTime = string.format("%02d:%02d:%02d", d, h, m)
  self.ui.tex_Time.text = texTime
end

function UIActSGMiniGame:StopActTimer()
  if self._timerId then
    TimerManager:StopTimer(self._timerId)
    self._timerId = nil
  end
end

function UIActSGMiniGame:SetMiniGamePause(bool)
  if self.state ~= ActSGMiniGameEnum.UIState.GamePlay then
    return
  end
  self.SGMiniGamePlay:SetSGMiniGamePause(bool)
end

function UIActSGMiniGame:PlaySGMiniGameLoadingAnim()
  self.ui.obj_Loading:SetActive(true)
  if self.waitTimer then
    TimerManager:StopTimer(self.waitTimer)
    self.waitTimer = nil
  end
  self.waitTimer = TimerManager:StartTimer(delayTime, function()
    self.ui.obj_Loading:SetActive(false)
    self.waitTimer = nil
  end, nil, true)
end

function UIActSGMiniGame:OnDelete()
  if self.waitTimer then
    TimerManager:StopTimer(self.waitTimer)
    self.waitTimer = nil
  end
  MsgCenter:RemoveListener(eMsgEventId.TaskUpdate, self.refreshRewardCallback)
  MsgCenter:RemoveListener(eMsgEventId.TaskDelete, self.refreshRewardCallback)
  self:StopActTimer()
  self.SGMiniGamePlay:Delete()
  self.SGMiniGameReward:Delete()
  self.SGMiniGameStart:Delete()
  self.SGMiniGameRank:Delete()
  self.SGMiniGameEnd:Delete()
end

return UIActSGMiniGame
