local base = require("Game.EventAngelaGift.UI.UINEventAngelaGiftSmallNode")
local UINEventAngelaGiftBigNode = class("UINEventAngelaGiftBigNode", base)
local UINBaseItemWithReceived = require("Game.CommonUI.Item.UINBaseItemWithReceived")
local JumpManager = require("Game.Jump.JumpManager")
local emptyString = ""

function UINEventAngelaGiftBigNode:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_buy, self, self.OnClickBtnBuy)
  UIUtil.AddButtonListener(self.ui.btn_viewHero, self, self.JumpToHeroSkin)
  self._rewardItemPool = UIItemPool.New(UINBaseItemWithReceived, self.ui.obj_rewardItem)
  self.ui.obj_rewardItem:SetActive(false)
end

function UINEventAngelaGiftBigNode:_RefreshAngelaGiftNode()
  self._rewardItemPool:HideAll()
  local skinName = emptyString
  for index, rewardId in ipairs(self.rewardIds) do
    local itemCfg = ConfigData.item[rewardId]
    local count = self.rewardCounts[index]
    local rewardItem = self._rewardItemPool:GetOne()
    local isPicked = self.currentState == base.eGiftState.Picked
    rewardItem:InitItemWithCount(itemCfg, count, nil, isPicked)
    if itemCfg.type == eItemType.Skin then
      skinName = itemCfg.name
      self.skinItemCfg = itemCfg
    end
  end
  self.ui.textItem_buy:SetIndex(self.currentState)
  self.ui.btn_buy.interactable = self.currentState == base.eGiftState.CanBuy
  self.ui.textItem_skinName:SetIndex(0, LanguageUtil.GetLocaleText(skinName))
end

function UINEventAngelaGiftBigNode:JumpToHeroSkin()
  if self.skinItemCfg ~= nil then
    JumpManager:Jump(JumpManager.eJumpTarget.HeroSkin, nil, nil, {
      self.skinItemCfg.id,
      require("Game.Skin.SkinEnum").fromWhere.shopOrGift
    }, true)
  end
end

return UINEventAngelaGiftBigNode
