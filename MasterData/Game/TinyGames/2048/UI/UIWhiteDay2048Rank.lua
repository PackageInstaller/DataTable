local UIWhiteDay2048Rank = class("UIWhiteDay2048Rank", UIBaseWindow)
local base = UIBaseWindow
local UINWhiteDay2048RankItem = require("Game.TinyGames.2048.UI.UINWhiteDay2048RankItem")

function UIWhiteDay2048Rank:OnInit()
  UIUtil.SetTopStatus(self, self._OnClickReturn, nil, nil, nil, true)
  UIUtil.AddButtonListener(self.ui.btn_Close, self, self._HideAndBack)
  UIUtil.AddButtonListener(self.ui.btn_background, self, self._HideAndBack)
  self.itemDic = {}
end

function UIWhiteDay2048Rank:Refresh2048RankingData(allFriendData, mineGrade)
  self.allFriendDataList = allFriendData
  local myRank = 0
  for index, data in pairs(self.allFriendDataList) do
    if data == mineGrade then
      myRank = index
    end
  end
  self.ui.tex_Rank:SetIndex(0, tostring(myRank))
  self.ui.tex_Score:SetIndex(0, tostring(mineGrade.score))
  self.ui.loopscroll.onChangeItem = BindCallback(self, self.__OnChangeItem, mineGrade)
  self.ui.loopscroll.onInstantiateItem = BindCallback(self, self.__OnInstantiateItem)
  self.ui.loopscroll.totalCount = #self.allFriendDataList
  self.ui.loopscroll:RefillCells()
end

function UIWhiteDay2048Rank:SetBestScore(bestScore)
  self.ui.tex_BestScore.gameObject:SetActive(true)
  self.ui.tex_BestScore:SetIndex(0, tostring(bestScore or 0))
end

function UIWhiteDay2048Rank:__OnChangeItem(mineGrade, go, index)
  local item = self.itemDic[go]
  local itemData = self.allFriendDataList[index + 1]
  local isMine = mineGrade == itemData
  item:Init2048RankItem(itemData, index + 1, isMine)
end

function UIWhiteDay2048Rank:__OnInstantiateItem(go)
  local item = UINWhiteDay2048RankItem.New()
  item:Init(go)
  self.itemDic[go] = item
end

function UIWhiteDay2048Rank:_OnClickReturn()
  self:Delete()
end

function UIWhiteDay2048Rank:_HideAndBack()
  UIUtil.OnClickBackByUiTab(self)
end

function UIWhiteDay2048Rank:OnDelete()
  base.OnDelete(self)
end

return UIWhiteDay2048Rank
