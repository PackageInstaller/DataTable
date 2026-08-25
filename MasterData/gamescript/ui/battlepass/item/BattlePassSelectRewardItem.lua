local UI_Passport_Choose_RewardResource = require("UI.UIPackages.UI_Passport_Choose_RewardResource")
local System = require("System.System")
local ItemDataUtils = require("Data.ItemDataUtils")
local ItemCfgUtils = require("Data.ItemCfgUtils")
local MainShopDataUtils = require("Data.MainShopDataUtils")
local LT = require("System.LangTable")
local BattlePassSelectRewardItem, Super = System.NewComponent("BattlePassSelectRewardItem")

function BattlePassSelectRewardItem:ctor(uiNode, data)
  Super.ctor(self)
  self.ui = UI_Passport_Choose_RewardResource(uiNode)
  self.tid = data.tid
  self.model = data.model
  self.clickCb = data.clickCb
  self.num = data.num
end

function BattlePassSelectRewardItem:OnBind(binder)
  binder:BindToText(self.ui.Text_Name, function()
    do return LT.Text, ItemDataUtils.GetItemName(self.tid) end
    return LT.Text, ItemDataUtils.GetItemName(self.tid)
  end)
  binder:BindToVisible(self.ui.Image_Select, function()
    return self.tid == self.model.curSelectTid
  end)
  local groupFullText
  if ItemCfgUtils.GetCfgField("Type", self.tid) == CommonDefine.ItemType.Weapon then
    if MainShopDataUtils.IsMaxPotencyByItemId(self.tid) then
      groupFullText = LT.Text("MaxLevelWeaponShopTips")
    elseif ItemDataUtils.GetItemByTid(self.tid) then
      groupFullText = LT.Text("Owned")
    end
  end
  local itemData = {
    itemTid = self.tid,
    clickFunc = function()
      if self.tid == self.model.curSelectTid then
        ItemDataUtils.ShowItemDetailTips(binder, self.ui.UI_Passport_Inventory_Item, nil, self.tid, true)
      end
      self.model.SetCurSelectTid(self.tid)
    end,
    itemCount = self.num,
    groupFullText = groupFullText
  }
  binder:BindComponent(require("UI.Public.Item.CommonIconItemType2")(self.ui.UI_Passport_Inventory_Item, itemData))
end

return BattlePassSelectRewardItem
