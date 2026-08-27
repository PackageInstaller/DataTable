local UINFlappyResult = class("UINFlappyResult", UIBaseNode)
local base = UIBaseNode
local RankingItem = require("Game.TinyGames.FlappyBird.UI.UINRankingItem")
local FlappyBirdAudioConfig = require("Game.TinyGames.FlappyBird.Config.FlappyBirdAudioConfig")
local cs_DoTween = CS.DG.Tweening.DOTween

function UINFlappyResult:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.rankingItemPool = UIItemPool.New(RankingItem, self.ui.rankingItem)
  UIUtil.AddButtonListener(self.ui.btn_Restart, self, self.OnBack)
end

function UINFlappyResult:InjectRestartAction(back2Start)
  self.__back2Start = back2Start
end

function UINFlappyResult:OnBack()
  AudioManager:PlayAudioById(FlappyBirdAudioConfig.OnClickButton)
  if self.__back2Start ~= nil then
    self.__back2Start()
  end
  self:Hide()
end

function UINFlappyResult:RefreshScore(score, bydRatio, isHistoryOpen, isRemaster)
  score = score or 0
  bydRatio = bydRatio or 0
  self.ui.tex_Score.text = tostring(score)
  self.ui.barGroup:SetActive(not isHistoryOpen and not isRemaster)
  if not isHistoryOpen and not isRemaster then
    self.ui.tex_Result:SetIndex(0, tostring(bydRatio / 100))
    self.ui.bar.value = bydRatio / 10000
  end
end

function UINFlappyResult:RefreshResultRank(resultRankData, mineGrade)
  self.rankingItemPool:HideAll()
  if resultRankData == nil then
    return
  end
  for index, v in ipairs(resultRankData) do
    local item = self.rankingItemPool:GetOne()
    local isMine = mineGrade == v
    item:InitWithRankData(v, v.grade_index, isMine)
  end
end

function UINFlappyResult:OnShow()
  base.OnShow(self)
  self:__InitFlappyResultTween()
end

function UINFlappyResult:__InitFlappyResultTween()
  if self.resultSeq ~= nil then
    self.resultSeq:Restart()
    return
  end
  local seq = cs_DoTween.Sequence()
  seq:Append(self.ui.rect_ranking:DOLocalMoveY(0, 0.6):From())
  seq:Join(self.ui.fade:DOFade(0, 0.35):From())
  seq:SetAutoKill(false)
  self.resultSeq = seq
end

function UINFlappyResult:OnDelete()
  base.OnDelete(self)
  if self.resultSeq ~= nil then
    self.resultSeq:Kill()
    self.resultSeq = nil
  end
  self.rankingItemPool:DeleteAll()
end

return UINFlappyResult
