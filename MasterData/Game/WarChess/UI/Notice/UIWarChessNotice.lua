local base = UIBaseWindow
local UIWarChessNotice = class("UIWarChessNotice", base)
local cs_DoTween = CS.DG.Tweening.DOTween
local UINWarChessNoticeShowBuff = require("Game.WarChess.UI.Notice.UINWarChessNoticeShowBuff")
local UINWarChessNoticeRewardTip = require("Game.WarChess.UI.Notice.UINWarChessNoticeRewardTip")

function UIWarChessNotice:OnInit()
  self.__isPlaying = false
  self.__playQueue = {}
  self.ui.obj_turnEnd:SetActive(false)
  self.ui.obj_pressureLvUp:SetActive(false)
  self.ui.obj_gameStart:SetActive(false)
  self.showRewardNode = UINWarChessNoticeRewardTip.New()
  self.showRewardNode:Init(self.ui.obj_rewardNode)
  self.showRewardNode:Hide()
  self:__InitDoTween()
end

function UIWarChessNotice:__InitDoTween()
  local wcCtrl = WarChessManager:GetWarChessCtrl()
  local turnOverQueue = cs_DoTween.Sequence()
  turnOverQueue:AppendCallback(function()
    self.ui.obj_turnEnd:SetActive(true)
  end):Join(self.ui.cg_turn_tipsUILayer:DOFade(0, 0.1):From()):AppendInterval(1.5):AppendCallback(function()
    self.ui.obj_turnEnd:SetActive(false)
    self:__TryPlayNext()
  end):SetAutoKill(false):Pause()
  self.turnOverQueue = turnOverQueue
  local pressUpgradeQueue = cs_DoTween.Sequence()
  pressUpgradeQueue:AppendCallback(function()
    self.ui.obj_pressureLvUp:SetActive(true)
  end):Join(self.ui.cg_press_tipsUILayer:DOFade(0, 0.1):From()):AppendInterval(1.5):AppendCallback(function()
    self.ui.obj_pressureLvUp:SetActive(false)
    self:__TryPlayNext()
    if self.__afterStressUpCallback ~= nil then
      self.__afterStressUpCallback()
      self.__afterStressUpCallback = nil
    end
  end):SetAutoKill(false):Pause()
  self.pressUpgradeQueue = pressUpgradeQueue
  local pressAddQueue = cs_DoTween.Sequence()
  pressAddQueue:AppendCallback(function()
    self.ui.obj_pressurePointUp:SetActive(true)
  end):Join(self.ui.cg_pressAdd_tipsUILayer:DOFade(0, 0.1):From()):AppendInterval(1.5):AppendCallback(function()
    self.ui.obj_pressurePointUp:SetActive(false)
    self:__TryPlayNext()
    if self.__afterStressUpCallback ~= nil then
      self.__afterStressUpCallback()
      self.__afterStressUpCallback = nil
    end
  end):SetAutoKill(false):Pause()
  self.pressAddQueue = pressAddQueue
  local turnStartQueue = cs_DoTween.Sequence()
  turnStartQueue:AppendCallback(function()
    MsgCenter:Broadcast(eMsgEventId.WC_TurnStarTweenOver)
    self.ui.obj_turnStart:SetActive(true)
    local turnNum = wcCtrl.turnCtrl:GetWCTurnNum()
    self.ui.tex_Title:SetIndex(0, tostring(turnNum))
  end):Join(self.ui.cg_turnStart_tipsUILayer:DOFade(0, 0.1):From()):AppendInterval(1.5):AppendCallback(function()
    self.ui.obj_turnStart:SetActive(false)
    self:__TryPlayNext()
  end):SetAutoKill(false):Pause()
  self.turnStartQueue = turnStartQueue
  local returnPoinQueue = cs_DoTween.Sequence()
  returnPoinQueue:AppendCallback(function()
    self.ui.Obj_ReturnPoint:SetActive(true)
    self.ui.tween_ReturnPoint:DOPlayForward()
  end):AppendInterval(2.5):AppendCallback(function()
    self.ui.Obj_ReturnPoint:SetActive(false)
    self:__TryPlayNext()
  end):SetAutoKill(false):Pause()
  self.returnPoinQueue = returnPoinQueue
  local getItemQueue = cs_DoTween.Sequence()
  getItemQueue:AppendCallback(function()
    self.ui.obj_getPoint:SetActive(true)
  end):AppendInterval(1.5):AppendCallback(function()
    self.ui.obj_getPoint:SetActive(false)
    self:__TryPlayNext()
  end):SetAutoKill(false):Pause()
  self.getItemQueue = getItemQueue
  local showRewardQueue = cs_DoTween.Sequence()
  showRewardQueue:AppendCallback(function()
    self.showRewardNode:Show()
    self.showRewardNode.ui.canvasGroup.alpha = 1
  end):Append(self.showRewardNode.ui.canvasGroup:DOFade(0, 0.2):From()):AppendInterval(1):Append(self.showRewardNode.ui.canvasGroup:DOFade(0, 0.2)):AppendCallback(function()
    self.showRewardNode:Hide()
    self:__TryPlayNext()
    if self.__afterShowGetRewardCallback ~= nil then
      self.__afterShowGetRewardCallback()
      self.__afterShowGetRewardCallback = nil
    end
  end):SetAutoKill(false):Pause()
  self.showRewardQueue = showRewardQueue
end

function UIWarChessNotice:OnWCTurnOver()
  table.insert(self.__playQueue, function()
    self.turnOverQueue:Restart()
  end)
  table.insert(self.__playQueue, function()
    self.turnStartQueue:Restart()
  end)
  if not self.__isPlaying then
    self:__TryPlayNext()
  end
end

function UIWarChessNotice:OnWCApIncrease()
  table.insert(self.__playQueue, function()
    self.returnPoinQueue:Restart()
  end)
  if not self.__isPlaying then
    self:__TryPlayNext()
  end
end

function UIWarChessNotice:OnWCStart(callBack, stayTime)
  self.ui.obj_gameStart:SetActive(true)
  local wcLevelCfg = WarChessManager:GetWCLevelCfg()
  self.ui.tex_GameStartDes.text = LanguageUtil.GetLocaleText(wcLevelCfg.victory_long)
  
  local function realCallBack()
    self.ui.obj_gameStart:SetActive(false)
    self:Hide()
    if callBack ~= nil then
      callBack()
    end
  end
  
  stayTime = stayTime or 1.5
  TimerManager:StopTimer(self.startTimer)
  self.startTimer = TimerManager:StartTimer(stayTime, realCallBack, self, true)
end

function UIWarChessNotice:OnWCStressUpgrade(stressCfg, addNum, afterPlayCallback, aniTimeScale)
  aniTimeScale = aniTimeScale or 1
  if stressCfg ~= nil then
    table.insert(self.__playQueue, 1, function()
      self.ui.tex_pressureTitle.text = LanguageUtil.GetLocaleText(stressCfg.name)
      self.ui.tex_pressureLevelDes.text = LanguageUtil.GetLocaleText(stressCfg.describe)
      self.pressUpgradeQueue.timeScale = aniTimeScale
      self.pressUpgradeQueue:Restart()
    end)
  end
  if addNum ~= nil then
    table.insert(self.__playQueue, 1, function()
      self.__afterStressUpCallback = afterPlayCallback
      self.ui.tex_pressurePoint.text = "+" .. tostring(addNum)
      self.pressAddQueue.timeScale = aniTimeScale
      self.pressAddQueue:Restart()
    end)
  end
  if not self.__isPlaying then
    self:__TryPlayNext()
  end
end

function UIWarChessNotice:OnWCGetDeployPoint(itemId, itemNum)
  table.insert(self.__playQueue, 1, function()
    local itemName = ConfigData:GetItemName(itemId)
    self.ui.tex_GetItemDse:SetIndex(0, itemName, tostring(itemNum))
    self.ui.img_ItemIcon.sprite = CRH:GetSpriteByItemId(itemId)
    self.getItemQueue:Restart()
  end)
  if not self.__isPlaying then
    self:__TryPlayNext()
  end
end

function UIWarChessNotice:WCShowGetReward(itemId, itemNum, itemAddNum, isLimitFull, afterPlayCallback, aniTimeScale)
  self.showRewardNode:RefreshWCRewardNotice(itemId, itemNum, itemAddNum, isLimitFull)
  self.__afterShowGetRewardCallback = afterPlayCallback
  if aniTimeScale then
    self.showRewardQueue.timeScale = aniTimeScale
  else
    self.showRewardQueue.timeScale = 1
  end
  self.showRewardQueue:Restart()
end

function UIWarChessNotice:__TryPlayNext()
  if #self.__playQueue > 0 and not WarChessManager.isWCFinish then
    self.__isPlaying = true
    local func = table.remove(self.__playQueue, 1)
    func()
  else
    self.__isPlaying = false
    self:Hide()
  end
end

function UIWarChessNotice:ForceHideWindow()
  self.__isPlaying = false
  self:Hide()
end

function UIWarChessNotice:OnDelete()
  if self.turnOverQueue ~= nil then
    self.turnOverQueue:Kill()
  end
  if self.pressUpgradeQueue ~= nil then
    self.pressUpgradeQueue:Kill()
  end
  if self.turnStartQueue ~= nil then
    self.turnStartQueue:Kill()
  end
  if self.returnPoinQueue ~= nil then
    self.returnPoinQueue:Kill()
  end
  if self.showRewardQueue ~= nil then
    self.showRewardQueue:Kill()
  end
  if self.getItemQueue ~= nil then
    self.getItemQueue:Kill()
  end
  if self.pressAddQueue ~= nil then
    self.pressAddQueue:Kill()
  end
  TimerManager:StopTimer(self.startTimer)
end

return UIWarChessNotice
