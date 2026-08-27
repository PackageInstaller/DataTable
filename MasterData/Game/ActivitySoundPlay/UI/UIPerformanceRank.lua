local base = UIBaseWindow
local UIPerformanceRank = class("UIPerformanceRank", base)
local RankingItem = require("Game.ActivityBrotatoLobby.UI.UINBrotatoRankItem")

function UIPerformanceRank:OnInit()
  UIUtil.SetTopStatus(self, self.Delete)
  UIUtil.AddButtonListener(self.ui.btn_Close, self, self.Delete)
  self.itemDic = {}
  self.ui.rankList.onInstantiateItem = BindCallback(self, self.__OnInstantiateItem)
  self.resloader = CS.ResLoader.Create()
end

function UIPerformanceRank:RefreshPerformanceRank(allFriendData, mineGrade, rankIndex)
  self.allFriendDataList = allFriendData
  self.mineGrade = mineGrade
  self.ui.tex_Rank:SetIndex(0, tostring(rankIndex))
  self.ui.tex_Score:SetIndex(0, tostring(mineGrade.score))
  self.ui.rankList.onChangeItem = BindCallback(self, self.__OnChangeItem, rankIndex)
  self.ui.rankList.totalCount = #self.allFriendDataList
  self.ui.rankList:RefillCells()
end

function UIPerformanceRank:__OnChangeItem(rankIndex, go, index)
  local item = self.itemDic[go]
  local itemData = self.allFriendDataList[index + 1]
  local isMine = rankIndex == index + 1
  item:InitWithRankData(itemData, index + 1, isMine)
end

function UIPerformanceRank:__OnInstantiateItem(go)
  local item = RankingItem.New()
  item:Init(go)
  self.itemDic[go] = item
end

function UIPerformanceRank:_OnClickReturn()
  self:Delete()
end

function UIPerformanceRank:_HideAndBack()
  UIUtil.OnClickBackByUiTab(self)
end

function UIPerformanceRank:OnDelete()
  if self.resloader ~= nil then
    self.resloader:Put2Pool()
    self.resloader = nil
  end
  base.OnDelete(self)
end

return UIPerformanceRank
