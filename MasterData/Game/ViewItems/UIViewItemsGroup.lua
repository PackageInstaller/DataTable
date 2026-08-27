local UIViewItemsGroup = class("UIViewItemsGroup", UIBaseNode)
local base = UIBaseNode
local UINBaseItemWithCount = require("Game.CommonUI.Item.UINBaseItemWithCount")

function UIViewItemsGroup:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.ui.baseItemWithCountItem:SetActive(false)
  self.itemPool = UIItemPool.New(UINBaseItemWithCount, self.ui.baseItemWithCountItem)
end

function UIViewItemsGroup:InitGroup(itemGroupData)
  self.typeId = itemGroupData.typeId
  self.itemList = itemGroupData.itemList
  self.ui.tex_Tile:SetIndex(self.typeId - 1)
  self.itemPool:HideAll()
  for index, itemData in ipairs(self.itemList) do
    local item = self.itemPool:GetOne()
    item:InitItemWithCount(itemData.itemCfg, itemData.num, function()
      UIManager:ShowWindowAsync(UIWindowTypeID.GlobalItemDetail, function(win)
        if win ~= nil then
          win:InitListDetail(self.itemList, index)
        end
      end)
    end)
  end
end

function UIViewItemsGroup:OnDelete()
  base.OnDelete(self)
end

return UIViewItemsGroup
