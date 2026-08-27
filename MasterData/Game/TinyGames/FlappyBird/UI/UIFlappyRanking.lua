local UIFlappyRanking = class("UIFlappyRanking", UIBaseWindow)
local base = UIBaseWindow
local RankingItem = require("Game.TinyGames.FlappyBird.UI.UINRankingItem")
local FlappyBirdAudioConfig = require("Game.TinyGames.FlappyBird.Config.FlappyBirdAudioConfig")
local cs_DoTween = CS.DG.Tweening.DOTween

function UIFlappyRanking:OnInit()
  UIUtil.AddButtonListener(self.ui.btn_Restart, self, self.HideAndBack)
  self.itemDic = {}
  self:__InitFlappyRankingTween()
end

function UIFlappyRanking:RefreshRankingData(allFriendData, mineGrade, isHistoryOpen, isRemaster)
  self.ui.obj_top:SetActive(not isHistoryOpen and not isRemaster)
  if not isHistoryOpen and not isRemaster then
    self.ui.maxBydProgress:SetIndex(0, tostring(mineGrade.bydProgress / 100))
  end
  if allFriendData == nil or mineGrade == nil then
    return
  end
  self.ui.tex_Score.text = tostring(mineGrade.score)
  self.ui.tex_UserName.text = mineGrade.name
  self.allFriendDataList = allFriendData
  if #self.allFriendDataList <= 1 then
    self.ui.tips.gameObject:SetActive(true)
    self.ui.tips.text = ConfigData:GetTipContent(7106)
  else
    self.ui.tips.gameObject:SetActive(false)
  end
  self.ui.scroll.onChangeItem = BindCallback(self, self.__OnChangeItem, mineGrade)
  self.ui.scroll.onInstantiateItem = BindCallback(self, self.__OnInstantiateItem)
  self.ui.scroll.totalCount = #self.allFriendDataList
  self.ui.scroll:RefillCells()
end

function UIFlappyRanking:SetBestScore(bestScore)
  self.ui.tex_BestScore.gameObject:SetActive(true)
  self.ui.tex_BestScore:SetIndex(0, tostring(bestScore))
end

function UIFlappyRanking:__OnChangeItem(mineGrade, go, index)
  local item = self.itemDic[go]
  local itemData = self.allFriendDataList[index + 1]
  local isMine = mineGrade == itemData
  item:InitWithRankData(itemData, index + 1, isMine)
end

function UIFlappyRanking:__OnInstantiateItem(go)
  local item = RankingItem.New()
  item:Init(go)
  self.itemDic[go] = item
end

function UIFlappyRanking:HideAndBack()
  AudioManager:PlayAudioById(FlappyBirdAudioConfig.OnClickButton)
  local fbMainWin = UIManager:GetWindow(UIWindowTypeID.FlappyBird)
  if fbMainWin ~= nil then
    fbMainWin:SetMainUIShow(true)
    fbMainWin:SetMainPageTween(true)
  end
  self:Delete()
end

function UIFlappyRanking:__InitFlappyRankingTween()
  if self.rankingSeq ~= nil then
    self.rankingSeq:Restart()
    return
  end
  local seq = cs_DoTween.Sequence()
  seq:Append(self.ui.fade_rank:DOFade(0, 0.6):From())
  seq:Join(self.ui.fade_rank.transform:DOAnchorPosY(-100, 0.6):From())
  seq:SetAutoKill(false)
  self.rankingSeq = seq
end

function UIFlappyRanking:OnDelete()
  if self.rankingSeq ~= nil then
    self.rankingSeq:Kill()
    self.rankingSeq = nil
  end
  base.OnDelete(self)
end

return UIFlappyRanking
