local UINCardSetDiffSelect = class("UINCardSetDiffSelect", UIBaseNode)
local base = UIBaseNode
local UINCardSetDiffItem = require("Game.CardSet.UI.Set.DownNode.UINCardSetDiffItem")

function UINCardSetDiffSelect:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_Close, self, self.Hide)
  UIUtil.AddButtonListener(self.ui.btn_bg, self, self.Hide)
  self.itemPool = UIItemPool.New(UINCardSetDiffItem, self.ui.obj_diffItem)
  self.ui.obj_diffItem.gameObject:SetActive(false)
  self.__onClickDiffItem = BindCallback(self, self.__OnClickDiffItem)
end

function UINCardSetDiffSelect:InitCardDiffSelect(cardSetCtrl)
  self.cardSetCtrl = cardSetCtrl
  self:__RefreshCardSetDiffNode()
end

function UINCardSetDiffSelect:__RefreshCardSetDiffNode()
  local cardSetData = self.cardSetCtrl:GetCardSetData()
  local diffList = cardSetData:GetCardSetDiffDataList()
  self.itemPool:HideAll()
  local existChallenge = cardSetData:IsExistCardSetDiffChanllenge()
  self.ui.mode:SetActive(existChallenge)
  for index, diffdata in ipairs(diffList) do
    local item = self.itemPool:GetOne()
    item:InitCardDiffItem(diffdata, self.__onClickDiffItem, self.cardSetCtrl, existChallenge)
  end
end

function UINCardSetDiffSelect:__OnClickDiffItem(diffData)
  local diffId = diffData:GetCardSetDiffDiffId()
  local cardSetData = self.cardSetCtrl:GetCardSetData()
  local curSelectDiffId = cardSetData:GetCardSetCurDiffId()
  local isSelected = diffData:GetCardSetDiffDiffId() == curSelectDiffId
  if not isSelected then
    cardSetData:SetCardSetCurDiffId(diffId)
    cardSetData:CheckCardSetDiffBan()
    self:__RefreshCardSetDiffNode()
    self.cardSetCtrl:SaveCardSetDiffId(cardSetData)
    MsgCenter:Broadcast(eMsgEventId.OnCardSetDiffChange)
  end
end

function UINCardSetDiffSelect:OnDelete()
  base.OnDelete(self)
end

return UINCardSetDiffSelect
