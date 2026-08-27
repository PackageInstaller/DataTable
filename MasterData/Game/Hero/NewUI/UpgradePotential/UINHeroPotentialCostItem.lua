local UINHeroPotentialCostItem = class("UINHeroPotentialCostItem", UIBaseNode)
local base = UIBaseNode
local UINBaseItem = require("Game.CommonUI.Item.UINBaseItem")

function UINHeroPotentialCostItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.baseItem = UINBaseItem.New()
  self.baseItem:Init(self.ui.obj_uINBaseItem)
  self.__OnClickPotentialItem = BindCallback(self, self.OnClickPotentialItem)
end

function UINHeroPotentialCostItem:InitCostInfo(cfg, needCount)
  self.hasCount = PlayerDataCenter:GetItemCount(cfg.id)
  self.needCount = needCount
  self.baseItem:InitBaseItem(cfg, self.__OnClickPotentialItem)
  local textId = self.hasCount >= self.needCount and 0 or 2
  self.ui.tex_ExtrCount:SetIndex(textId, tostring(self.needCount), tostring(self.hasCount))
end

function UINHeroPotentialCostItem:OnClickPotentialItem()
  UIManager:ShowWindowAsync(UIWindowTypeID.GlobalItemDetail, function(window)
    window:InitCommonItemDetail(self.baseItem.itemCfg, nil)
    window:TryShowGiftJump(self.hasCount < self.needCount)
  end)
end

return UINHeroPotentialCostItem
