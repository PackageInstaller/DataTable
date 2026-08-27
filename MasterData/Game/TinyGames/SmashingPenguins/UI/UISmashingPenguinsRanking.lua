local base = require("Game.TinyGames.FlappyBird.UI.UIFlappyRanking")
local UISmashingPenguinsRanking = class("UISmashingPenguinsRanking", base)
local RankingItem = require("Game.TinyGames.FlappyBird.UI.UINRankingItem")
local cs_DoTween = CS.DG.Tweening.DOTween

function UISmashingPenguinsRanking:RefreshRankingData(allFriendData, mineGrade)
  self.ui.obj_top:SetActive(true)
  self.ui.maxBydProgress:SetIndex(0, tostring(mineGrade.bydProgress / 100))
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

function UISmashingPenguinsRanking:__InitFlappyRankingTween()
end

function UISmashingPenguinsRanking:HideAndBack()
  local mainWin = UIManager:GetWindow(UIWindowTypeID.SmashingPenguins)
  if mainWin ~= nil then
    mainWin:ShowMainWindow()
  end
  self:Delete()
end

return UISmashingPenguinsRanking
