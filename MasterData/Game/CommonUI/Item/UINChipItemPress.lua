local UINChipItem = require("Game.CommonUI.Item.UINChipItem")
local base = UINChipItem
local UINChipItemPress = class("UINChipItemPress", base)

function UINChipItemPress:OnInit()
  base.OnInit(self)
  self.ui.btnRoot.enabled = false
  self.ui.btn_RootPlus.enabled = true
  self.ui.btn_RootPlus.onPress:AddListener(BindCallback(self, self.__OnChipLongPress))
  self.ui.btn_RootPlus.onPressUp:AddListener(BindCallback(self, self.__OnChipPressUp))
end

function UINChipItemPress:InitChipItemWithPress(chipData, showCount, longPressFunc, pressUpFunc)
  base.InitChipItem(self, chipData, showCount)
  self.__longPressFunc = longPressFunc
  self.__pressUpFunc = pressUpFunc
end

function UINChipItemPress:__OnChipLongPress()
  if self.__longPressFunc ~= nil then
    self.__longPressFunc(self.chipData, self)
  end
end

function UINChipItemPress:__OnChipPressUp()
  if self.__pressUpFunc ~= nil then
    self.__pressUpFunc(self.chipData, self)
  end
end

return UINChipItemPress
