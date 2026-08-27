local base = UIBaseNode
local UINWarChessMainTop_PressBarItem = class("UINWarChessMainTop_PressBarItem", base)

function UINWarChessMainTop_PressBarItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self._isBigItem = nil
  self._pressLevel = nil
end

function UINWarChessMainTop_PressBarItem:WCInitPressItem(isBig, level, icon)
  self._isBigItem = isBig
  self._pressLevel = level
  if icon ~= nil then
    self.ui.img_Icon.sprite = icon
  end
end

function UINWarChessMainTop_PressBarItem:RefreshPressBarItem(isOver)
  self.ui.img_Item:SetIndex(isOver and 1 or 0)
  if self._isBigItem then
    if isOver then
      self.ui.img_Icon.color = Color.white
    else
      self.ui.img_Icon.color = self.ui.color_unable
    end
  end
end

function UINWarChessMainTop_PressBarItem:PlayBarItemOver()
  self:RefreshPressBarItem(true)
  self.ui.obj_aniGroup:SetActive(true)
end

function UINWarChessMainTop_PressBarItem:WCPressBarGetIsBigItem()
  return self._isBigItem
end

function UINWarChessMainTop_PressBarItem:WCPressBarGetLevel()
  return self._pressLevel
end

return UINWarChessMainTop_PressBarItem
