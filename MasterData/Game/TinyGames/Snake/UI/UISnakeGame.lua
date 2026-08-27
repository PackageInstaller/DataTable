local base = UIBaseWindow
local UISnakeGame = class("UISnakeGame", base)
local cs_DoTween = CS.DG.Tweening.DOTween
local UINBaseItemWithReceived = require("Game.CommonUI.Item.UINBaseItemWithReceived")
local UINSnakeGameLeft = require("Game.TinyGames.Snake.UI.UINSnakeGameLeft")

function UISnakeGame:OnInit()
  UIUtil.AddButtonListener(self.ui.btn_BackPause, self, self._OnBtnGamePause)
  UIUtil.AddButtonListener(self.ui.btn_GiveUp, self, self._OnBtnGiveup)
  UIUtil.AddButtonListener(self.ui.btn_Continue, self, self._OnBtnContinue)
  UIUtil.AddButtonListener(self.ui.btn_Retry, self, self._OnBtnRetry)
  self._snakeLeftNode = UINSnakeGameLeft.New()
  self._snakeLeftNode:Init(self.ui.left)
  UIUtil.SetTopStatus(self, self._OnReturnClick, nil, nil, nil, true)
  self._rewardPool = UIItemPool.New(UINBaseItemWithReceived, self.ui.rewardItem, false)
end

function UISnakeGame:_InitSnakeGameUI(snakeCtrl)
  self._snakeCtrl = snakeCtrl
  self._lastReward = nil
  self:InitSnakeRewardUI()
  self._snakeLeftNode:InitSnakeGameLeft(self._snakeCtrl, self)
end

function UISnakeGame:RefeshSnakeBestScore(bestScore, rankIndex)
  self._snakeLeftNode:RefeshSnakeLeftBestScore(bestScore, rankIndex)
end

function UISnakeGame:InitSnakeRewardUI()
  local snakeGame = self._snakeCtrl:GetSnakeGameData()
  local requireScore, isRewarded = snakeGame:GetSnakeRewardState()
  if self._lastReward == isRewarded then
    return
  end
  self._lastReward = isRewarded
  self.ui.tex_Target:SetIndex(0, tostring(requireScore))
  self._rewardPool:HideAll()
  local itemIds, itemNums = snakeGame:GetSnakeGameReward()
  for index, itemId in pairs(itemIds) do
    local itemNum = itemNums[index]
    local rewardItem = self._rewardPool:GetOne()
    local itemCfg = ConfigData.item[itemId]
    rewardItem:InitItemWithCount(itemCfg, itemNum, nil, isRewarded)
  end
end

function UISnakeGame:EnterSnakeInitStateUI()
  self:EnterSnakePauseUI(false)
  self.ui.resultNode:SetActive(false)
  self._snakeLeftNode:EnterSnakeGameLeftInit()
end

function UISnakeGame:InitSnakePlayUI()
  self.ui.img_Pause:SetActive(true)
  self.ui.img_Back:SetActive(false)
  self.ui.pausetNode:SetActive(false)
  self.ui.resultNode:SetActive(false)
  self._snakeLeftNode:InitSnakeGameLeftPlay()
end

function UISnakeGame:InitSnakeEndUI(score, bestScore, rankIndex)
  self.ui.resultNode:SetActive(true)
  self.ui.img_Pause:SetActive(false)
  self.ui.img_Back:SetActive(true)
  self.ui.pausetNode:SetActive(false)
  self.ui.tex_NowNumber.text = tostring(score)
  self.ui.tex_BestNumber.text = tostring(math.max(score, bestScore))
  self.ui.tex_RankNumber:SetIndex(0, tostring(rankIndex))
  self._snakeLeftNode:InitSnakeGameLeftEnd()
  AudioManager:PlayAudioById(1267)
end

function UISnakeGame:EnterSnakePauseUI(active)
  self.ui.pausetNode:SetActive(active)
end

function UISnakeGame:RefreshSnakeScore(score)
  self._snakeLeftNode:RefreshSnakeLeftScore(score)
end

function UISnakeGame:ShowSnakeReadyUI(callback)
  UIUtil.AddOneCover("UISnakeGame")
  self.ui.readyNode:SetActive(true)
  self.ui.tex_Ready:SetIndex(0)
  local seq = cs_DoTween.Sequence()
  seq:AppendInterval(self.ui.time_Ready1)
  seq:AppendCallback(function()
    self.ui.tex_Ready:SetIndex(1)
  end)
  seq:AppendInterval(self.ui.time_Ready2)
  seq:OnComplete(function()
    self._readySeq = nil
    UIUtil.CloseOneCover("UISnakeGame")
    self.ui.readyNode:SetActive(false)
    if callback ~= nil then
      callback()
    end
  end)
  seq:SetUpdate(true)
  self._readySeq = seq
end

function UISnakeGame:_OnBtnGamePause()
  UIUtil.OnClickBackByUiTab(self)
end

function UISnakeGame:_OnReturnClick()
  return self._snakeCtrl:ClickSnakeGameReturn()
end

function UISnakeGame:_OnBtnGiveup()
  self._snakeCtrl:ClickSnakeGiveup()
end

function UISnakeGame:_OnBtnContinue()
  self._snakeCtrl:ClickSnakeContinue(true)
end

function UISnakeGame:_OnBtnRetry()
  self._snakeCtrl:ClickSnakeRetry()
end

function UISnakeGame:OnDelete()
  UIUtil.CloseOneCover("UISnakeGame")
  if self._readySeq ~= nil then
    self._readySeq = nil
    self._readySeq:Kill()
  end
  base.OnDelete(self)
end

return UISnakeGame
