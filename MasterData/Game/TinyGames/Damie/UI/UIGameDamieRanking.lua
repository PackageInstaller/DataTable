local UIGameDamieRanking = class("UIGameDamieRanking", UIBaseNode)
local base = UIBaseNode
local RankingItem = require("Game.TinyGames.FlappyBird.UI.UINRankingItem")

function UIGameDamieRanking:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.itemDic = {}
  UIUtil.AddButtonListener(self.ui.btn_Close, self, self.__HideAndBack)
end

function UIGameDamieRanking:RefreshDamieRankingData(allFriendData, mineGrade)
  self.ui.tex_Score:SetIndex(0, tostring(mineGrade.score))
  local curIndex = 1
  for index, v in ipairs(allFriendData) do
    if v == mineGrade then
      curIndex = index
      break
    end
  end
  self.ui.tex_MyRank:SetIndex(0, tostring(curIndex))
  self.allFriendDataList = allFriendData
  self.ui.scroll.onChangeItem = BindCallback(self, self.__OnChangeItem, mineGrade)
  self.ui.scroll.onInstantiateItem = BindCallback(self, self.__OnInstantiateItem)
  self.ui.scroll.totalCount = #self.allFriendDataList
  self.ui.scroll:RefillCells()
end

function UIGameDamieRanking:SetBestScore(bestScore)
  self.ui.tex_BestScore.gameObject:SetActive(true)
  self.ui.tex_BestScore:SetIndex(0, tostring(bestScore))
end

function UIGameDamieRanking:__OnChangeItem(mineGrade, go, index)
  local item = self.itemDic[go]
  local itemData = self.allFriendDataList[index + 1]
  local isMine = mineGrade == itemData
  item:InitWithRankData(itemData, index + 1, isMine)
end

function UIGameDamieRanking:__OnInstantiateItem(go)
  local item = RankingItem.New()
  item:Init(go)
  self.itemDic[go] = item
end

function UIGameDamieRanking:__HideAndBack()
  self:Hide()
end

return UIGameDamieRanking
