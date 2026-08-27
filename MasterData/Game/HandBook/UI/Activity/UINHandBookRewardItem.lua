local UINHandBookRewardItem = class("UINHandBookRewardItem", UIBaseNode)
local base = UIBaseNode
local UINBaseItem = require("Game.CommonUI.Item.UINBaseItem")

function UINHandBookRewardItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self._item = UINBaseItem.New()
  self._item:Init(self.ui.uINBaseItem)
end

function UINHandBookRewardItem:InitHandbookReward(itemId)
  local itemCfg = ConfigData.item[itemId]
  self._item:InitBaseItem(itemCfg)
  self.ui.tex_ItemName.text = LanguageUtil.GetLocaleText(itemCfg.name)
end

function UINHandBookRewardItem:SetHandbookRewardState(showNoGet)
  self.ui.img_NotGet:SetActive(showNoGet)
end

function UINHandBookRewardItem:PlayBookRewarsItemAni(delayTime)
  self.ui.item:DOFade(0, 0.2):From():SetDelay(delayTime)
  self.ui.bottom:DOLocalMoveY(20, 0.2):SetRelative(true):From():SetDelay(delayTime)
end

function UINHandBookRewardItem:OnDelete()
  self.ui.item:DOComplete()
  self.ui.bottom:DOComplete()
  base.OnDelete(self)
end

return UINHandBookRewardItem
