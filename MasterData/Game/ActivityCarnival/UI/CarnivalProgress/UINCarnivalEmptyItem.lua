local UINCarnivalEmptyItem = class("UINCarnivalEmptyItem", UIBaseNode)
local base = UIBaseNode
local UINCarnivalLevelItem = require("Game.ActivityCarnival.UI.CarnivalProgress.UINCarnivalLevelItem")
local UINCarnivalLevelCycleItem = require("Game.ActivityCarnival.UI.CarnivalProgress.UINCarnivalLevelCycleItem")

function UINCarnivalEmptyItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
end

function UINCarnivalEmptyItem:InitCarnivalNormalItem(carnivalData, levelData, isPicked, pickRewardFunc, jumpFunc)
  if self._cycleItem ~= nil then
    self._cycleItem:Hide()
  end
  if self._normalItem == nil then
    self._normalItem = UINCarnivalLevelItem.New()
    local gameObj = self.ui.item:Instantiate(self.transform)
    gameObj:SetActive(true)
    self._normalItem:Init(gameObj)
    self._normalItem.transform.anchoredPosition = Vector2.zero
  else
    self._normalItem:Show()
  end
  self._normalItem:InitCarnivalLevelItem(carnivalData, levelData, isPicked, pickRewardFunc, jumpFunc)
  self:__ResetSizeDetail(self._normalItem)
end

function UINCarnivalEmptyItem:InitCarnivalCycleItem(carnivalData, pickRewardFunc)
  if self._normalItem ~= nil then
    self._normalItem:Hide()
  end
  if self._cycleItem == nil then
    self._cycleItem = UINCarnivalLevelCycleItem.New()
    local gameObj = self.ui.finalItem:Instantiate(self.transform)
    gameObj:SetActive(true)
    self._cycleItem:Init(gameObj)
    self._cycleItem.transform.anchoredPosition = Vector2.zero
  else
    self._cycleItem:Show()
  end
  self._cycleItem:InitCarnivalLevelCycleItem(carnivalData, pickRewardFunc)
  self:__ResetSizeDetail(self._cycleItem)
end

function UINCarnivalEmptyItem:__ResetSizeDetail(node)
  self.transform.sizeDelta = node.transform.rect.size
  self.ui.emptyItem.preferredHeight = node.transform.sizeDelta.y
  self.ui.emptyItem.preferredWidth = node.transform.sizeDelta.x
end

function UINCarnivalEmptyItem:OnDelete()
  if self._normalItem ~= nil then
    self._normalItem:Delete()
  end
  if self._cycleItem ~= nil then
    self._cycleItem:Delete()
  end
  base.OnDelete(self)
end

return UINCarnivalEmptyItem
