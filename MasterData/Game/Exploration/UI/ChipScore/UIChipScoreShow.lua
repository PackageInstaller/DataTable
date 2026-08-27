local UIChipScoreShow = class("UIChipScoreShow", UIBaseWindow)
local base = UIBaseWindow
local chipScoreItem = require("Game.Exploration.UI.ChipScore.UINChipScoreItem")

function UIChipScoreShow:OnInit()
  UIUtil.AddButtonListener(self.ui.btn_close, self, self.OnClickCloseBtn)
  UIUtil.AddButtonListener(self.ui.btn_back, self, self.OnClickCloseBtn)
  self.poolChipScoreItem = UIItemPool.New(chipScoreItem, self.ui.obj_item)
  self.ui.obj_item:SetActive(false)
end

function UIChipScoreShow:InitChipScoreShow()
  local totalScore, scoeDic, infiniteCore, isRefinforce
  if ExplorationManager:IsInExploration() then
    totalScore, scoeDic, infiniteCore, isRefinforce = ExplorationManager:GetChipScoreInBattle()
  else
    totalScore, scoeDic, infiniteCore, isRefinforce = ExplorationManager:GetChipScoreByLastData()
  end
  self.poolChipScoreItem:HideAll()
  for showType, v1 in pairs(scoeDic) do
    for level, score in pairs(v1) do
      if 0 < score then
        local buffItem = self.poolChipScoreItem:GetOne()
        buffItem:InitChipScoreItem(showType, level, score)
      end
    end
  end
  self.ui.tex_totalScore.text = tostring(totalScore)
  if 0 < infiniteCore then
    self.ui.tex_scoreAdd:SetIndex(0, tostring(infiniteCore))
  else
    self.ui.obj_scoreAdd:SetActive(false)
  end
  if isRefinforce ~= nil then
    self.ui.tex_des.text = ConfigData:GetTipContent(59022)
  end
end

function UIChipScoreShow:OnClickCloseBtn()
  self:Delete()
end

function UIChipScoreShow:OnDelete()
  self.poolChipScoreItem:DeleteAll()
  base.OnDelete(self)
end

return UIChipScoreShow
