local UINBrotatoRank = class("UINBrotatoRank", UIBaseNode)
local base = UIBaseWindow
local RankingItem = require("Game.ActivityBrotatoLobby.UI.UINBrotatoRankItem")

function UINBrotatoRank:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.itemDic = {}
  UIUtil.AddButtonListener(self.ui.btn_close, self, self.OnClickCloseBtn)
end

function UINBrotatoRank:ShowBrotatoRank(allFrindRank, mineGrade, rankIndex)
  self:Show()
  if mineGrade ~= nil then
    self.ui.tex_Score:SetIndex(0, tostring(mineGrade.score))
    self.ui.tex_UserRank:SetIndex(0, tostring(rankIndex))
  end
  local count = 0
  if allFrindRank ~= nil then
    count = #allFrindRank
  end
  if count == 1 then
    self.ui.obj_empty:SetActive(true)
  else
    self.ui.obj_empty:SetActive(false)
  end
  self.allFriendDataList = allFrindRank
  self.ui.scroll.onChangeItem = BindCallback(self, self.__OnChangeItem, rankIndex)
  self.ui.scroll.onInstantiateItem = BindCallback(self, self.__OnInstantiateItem)
  self.ui.scroll.totalCount = count
  self.ui.scroll:RefillCells()
end

function UINBrotatoRank:__OnChangeItem(mineRank, go, index)
  local item = self.itemDic[go]
  local itemData = self.allFriendDataList[index + 1]
  local isMine = mineRank == index + 1
  item:InitWithRankData(itemData, index + 1, isMine)
end

function UINBrotatoRank:__OnInstantiateItem(go)
  local item = RankingItem.New()
  item:Init(go)
  self.itemDic[go] = item
end

function UINBrotatoRank:OnClickCloseBtn()
  self:Hide()
end

function UINBrotatoRank:OnDelete()
  base.OnDelete(self)
end

return UINBrotatoRank
