local UIHeadSortNode = class("UIHeadSortNode", UIBaseNode)
local base = UIBaseNode
local UIHeadSortNodeItem = require("Game.User.Dialogs.UIHeadSortNodeItem")

function UIHeadSortNode:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_Close, self, self.CloseWindow)
  self.ui.tog_SortItem:SetActive(false)
  self.itemPool = UIItemPool.New(UIHeadSortNodeItem, self.ui.tog_SortItem)
  self.isHead = true
  self.lastChoose = 0
end

function UIHeadSortNode:InitSortList(showList, lastChoose)
  self.lastChoose = lastChoose
  self.itemPool:HideAll()
  if showList ~= nil then
    self.showList = showList
  end
  self.typeNum = {}
  if self.isHead then
    for k, v in pairs(ConfigData.portrait.types) do
      table.insert(self.typeNum, k)
    end
  else
    for k, v in pairs(ConfigData.portrait_frame.types) do
      table.insert(self.typeNum, k)
    end
  end
  table.sort(self.typeNum, function(a, b)
    return a < b
  end)
  for k, val in ipairs(self.typeNum) do
    if self.isHead and ConfigData.portrait.typeCount[val] > 0 or not self.isHead and ConfigData.portrait_frame.typeCount[val] > 0 then
      local item = self.itemPool:GetOne()
      item:InitNodeItemCId(val, self.isHead)
      item.changeValueFunc = self.changeValueFunc
    end
  end
  for idx, item in pairs(self.itemPool.listItem) do
    if 0 < table.count(self.typeNum) and self.lastChoose == 0 then
      item:SelectActivityTag(0)
      self.lastChoose = 1
    else
      item:SelectActivityTag(self.lastChoose - 1)
    end
  end
end

function UIHeadSortNode:ShowWindow()
  self.gameObject:SetActive(true)
end

function UIHeadSortNode:CloseWindow()
  if self.BackFun ~= nil then
    self.BackFun()
  end
  self.itemPool:HideAll()
  self.gameObject:SetActive(false)
end

function UIHeadSortNode:OnDelete()
  self.itemPool:DeleteAll()
  base.OnDelete(self)
end

return UIHeadSortNode
