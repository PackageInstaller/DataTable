local UINSteinsGateVowItem = class("UINSteinsGateVowItem", UIBaseNode)
local base = UIBaseNode

function UINSteinsGateVowItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_item, self, self.__OnClickItem)
end

function UINSteinsGateVowItem:InitItem(itemData, clickFunc)
  self._itemData = itemData
  self._clickFunc = clickFunc
end

function UINSteinsGateVowItem:InitItemSprite(spriteAtlas)
  local itemId = self._itemData.itemId
  local spritePath = "Icon_" .. tostring(itemId)
  self.ui.img_item.sprite = AtlasUtil.GetResldSprite(spriteAtlas, spritePath)
end

function UINSteinsGateVowItem:__OnClickItem()
  if self._clickFunc ~= nil then
    self._clickFunc(self._itemData)
  end
  self.ui.obj_Selected:SetActive(true)
end

function UINSteinsGateVowItem:GetItemData()
  return self._itemData
end

function UINSteinsGateVowItem:SetSelect(flag)
  self.ui.obj_Selected:SetActive(flag)
end

return UINSteinsGateVowItem
