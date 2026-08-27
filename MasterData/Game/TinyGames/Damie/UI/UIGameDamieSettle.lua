local UIGameDamieSettle = class("UIGameDamieSettle", UIBaseNode)
local base = UIBaseNode
local RankingItem = require("Game.TinyGames.FlappyBird.UI.UINRankingItem")
local cs_DoTween = CS.DG.Tweening.DOTween

function UIGameDamieSettle:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.rankingItemPool = UIItemPool.New(RankingItem, self.ui.rankingItem)
  UIUtil.AddButtonListener(self.ui.btn_Restart, self, self.OnBack)
end

function UIGameDamieSettle:InjectRestartAction(back2Start)
  self.__back2Start = back2Start
end

function UIGameDamieSettle:OnBack()
  if self.__back2Start ~= nil then
    self.__back2Start()
  end
  self:Hide()
end

function UIGameDamieSettle:RefreshScore(score, bydRatio, isNew)
  score = score or 0
  self.ui.tex_Score.text = tostring(score)
  self.ui.img_NewScore:SetActive(isNew or false)
end

function UIGameDamieSettle:RefreshDamieResultRank(resultRankData, mineGrade)
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

function UIGameDamieSettle:OnShow()
  base.OnShow(self)
  self:__InitFlappyResultTween()
end

function UIGameDamieSettle:__InitFlappyResultTween()
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

function UIGameDamieSettle:OnDelete()
  base.OnDelete(self)
  if self.resultSeq ~= nil then
    self.resultSeq:Kill()
    self.resultSeq = nil
  end
  self.rankingItemPool:DeleteAll()
end

return UIGameDamieSettle
