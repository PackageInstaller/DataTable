local UINDungeonServerGridItem = class("UINDungeonServerGridItem", UIBaseNode)

function UINDungeonServerGridItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.ui.btn_gridItem.onPressDown:AddListener(BindCallback(self, self.__OnGridLongPress))
  self.ui.btn_gridItem.onPressUp:AddListener(BindCallback(self, self.__OnGridPressUp))
end

function UINDungeonServerGridItem:InitServerGridItem(serverGrid, longPressFunc, pressUpFunc)
  self.serverGrid = serverGrid
  self.ui.img_BuffIcon.sprite = serverGrid:GetGridIconSprite()
  self.longPressFunc = longPressFunc
  self.pressUpFunc = pressUpFunc
end

function UINDungeonServerGridItem:__OnGridLongPress()
  if self.longPressFunc ~= nil then
    self.longPressFunc(self.serverGrid)
  end
end

function UINDungeonServerGridItem:__OnGridPressUp()
  if self.pressUpFunc ~= nil then
    self.pressUpFunc()
  end
end

return UINDungeonServerGridItem
