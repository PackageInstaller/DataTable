local UINCSRightDetailInfoList = class("UINCSRightDetailInfoList", UIBaseNode)
local base = UIBaseNode
local CardSetEnum = require("Game.CardSet.Data.CardSetEnum")
local UINCSRightDetailInfoListItem = require("Game.CardSet.UI.Set.RightNode.DetailPanel.UINCSRightDetailInfoListItem")

function UINCSRightDetailInfoList:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.itemPool = UIItemPool.New(UINCSRightDetailInfoListItem, self.ui.item)
  self.ui.item.gameObject:SetActive(false)
end

function UINCSRightDetailInfoList:SetCardSetCtrl(cardSetCtrl)
  self.cardSetCtrl = cardSetCtrl
end

function UINCSRightDetailInfoList:ShowDetailForCardData(cardData)
  local resloader = self.cardSetCtrl:GetCardSetResloader()
  self.itemPool:HideAll()
  local item = self.itemPool:GetOne()
  item:InitCSRDLItemWithCardData(cardData, resloader)
  self.ui.obj_emptyTagItem:SetActive(false)
end

function UINCSRightDetailInfoList:ShowDetailForAllCardData(cardSetData, focusCardData)
  local resloader = self.cardSetCtrl:GetCardSetResloader()
  local focusItem
  local showNum = 0
  self.itemPool:HideAll()
  for _, eCardType in ipairs(CardSetEnum.showOrder) do
    local list = cardSetData:GetSelectedCardListByType(eCardType)
    showNum = showNum + #list
    for _, cardData in ipairs(list) do
      local item = self.itemPool:GetOne()
      item:InitCSRDLItemWithCardData(cardData, resloader)
      if focusCardData == cardData then
        focusItem = item
        item:SetCSRightDetailInfoListItemSelected()
      end
    end
  end
  self.ui.obj_emptyTagItem:SetActive(showNum == 0)
  if focusItem then
    UIUtil.ScrollRectLocation(self.ui.scrollRect, focusItem, true, false, self.ui.layoutGroup)
  end
end

function UINCSRightDetailInfoList:OnDelete()
  self.itemPool:DeleteAll()
  base.OnDelete(self)
end

return UINCSRightDetailInfoList
