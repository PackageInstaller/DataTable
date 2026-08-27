local UINCarnivalRank = class("UINCarnivalRank", UIBaseNode)
local base = UIBaseNode
local UINCarnivalRankItem = require("Game.ActivityCarnival.UI.CarnivalMiniGame.UINCarnivalRankItem")

function UINCarnivalRank:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.background, self, self.Hide)
  UIUtil.AddButtonListener(self.ui.btn_Close, self, self.Hide)
  self.itemDic = {}
end

function UINCarnivalRank:BindCarnivalRankFunc(callback)
  self._callback = callback
end

function UINCarnivalRank:InitCarnivalRank(allFriendData, mineGrade, callback)
  self.allFriendDataList = allFriendData
  local myRank = 0
  for index, data in pairs(self.allFriendDataList) do
    if data == mineGrade then
      myRank = index
    end
  end
  self._mineGrade = mineGrade
  self.ui.tex_Rank:SetIndex(0, tostring(myRank))
  self.ui.tex_Score:SetIndex(0, tostring(mineGrade.score))
  self.ui.rankFrame.onChangeItem = BindCallback(self, self.__OnChangeItem)
  self.ui.rankFrame.onInstantiateItem = BindCallback(self, self.__OnInstantiateItem)
  self.ui.rankFrame.totalCount = #self.allFriendDataList
  self.ui.rankFrame:RefillCells()
end

function UINCarnivalRank:SetBestScore(bestScore)
  self.ui.tex_BestScore.gameObject:SetActive(true)
  self.ui.tex_BestScore:SetIndex(0, tostring(bestScore))
end

function UINCarnivalRank:__OnChangeItem(go, index)
  local item = self.itemDic[go]
  local itemData = self.allFriendDataList[index + 1]
  local isMine = self._mineGrade == itemData
  item:InitCarnivalItem(itemData, index + 1, isMine)
end

function UINCarnivalRank:__OnInstantiateItem(go)
  local item = UINCarnivalRankItem.New()
  item:Init(go)
  self.itemDic[go] = item
end

function UINCarnivalRank:OnHide()
  base.OnHide(self)
  if self._callback ~= nil then
    self._callback()
  end
end

return UINCarnivalRank
