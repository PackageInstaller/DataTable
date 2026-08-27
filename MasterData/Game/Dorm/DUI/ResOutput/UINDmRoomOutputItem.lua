local UINDmRoomOutputItem = class("UINDmRoomOutputItem", UIBaseNode)
local base = UIBaseNode

function UINDmRoomOutputItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.rootBtn, self, self._OnClickRoot)
end

function UINDmRoomOutputItem:InitUINDmRoomOutputItem(tmProductData, clickFunc)
  self.tmProductData = tmProductData
  self.clickFunc = clickFunc
  local itemCfg = ConfigData.item[tmProductData.itemId]
  if itemCfg == nil then
    return
  end
  self.ui.img_ItemIcon.sprite = CRH:GetSpriteByItemConfig(itemCfg)
  self.ui.tex_ItemNum:SetIndex(0, tostring(tmProductData.realNum))
end

function UINDmRoomOutputItem:_OnClickRoot()
  if self.clickFunc ~= nil then
    self.clickFunc(self.tmProductData, self)
  end
end

function UINDmRoomOutputItem:OnDelete()
  base.OnDelete(self)
end

return UINDmRoomOutputItem
