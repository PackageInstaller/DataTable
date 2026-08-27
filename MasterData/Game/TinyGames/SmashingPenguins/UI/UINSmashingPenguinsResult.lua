local UINSmashingPenguinsResult = class("UINSmashingPenguinsResult", UIBaseNode)
local base = UIBaseNode
local RankingItem = require("Game.TinyGames.FlappyBird.UI.UINRankingItem")

function UINSmashingPenguinsResult:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_Restart, self, self.OnRestartGameBtnClick)
  self.rankingItemPool = UIItemPool.New(RankingItem, self.ui.rankingItem)
end

function UINSmashingPenguinsResult:InitSmashingPenguinsResult(mainController)
  self.mainController = mainController
  self.ui.tex_Score.text = tostring(mainController.currentScore)
end

function UINSmashingPenguinsResult:OnRestartGameBtnClick()
  local mainUI = UIManager:GetWindow(UIWindowTypeID.SmashingPenguins)
  if IsNull(mainUI) then
    return
  end
  mainUI:InitSmashingPenguinsMain()
end

function UINSmashingPenguinsResult:RefreshScore(score, bydRatio, isHide)
  score = score or 0
  bydRatio = bydRatio or 0
  self.ui.tex_Score.text = tostring(score)
  if isHide then
    self.ui.barGroup:SetActive(false)
  else
    self.ui.barGroup:SetActive(true)
    self.ui.tex_Result:SetIndex(0, tostring(bydRatio / 100))
    self.ui.bar.value = bydRatio / 10000
  end
end

function UINSmashingPenguinsResult:RefreshResultRank(resultRankData, mineGrade)
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

return UINSmashingPenguinsResult
