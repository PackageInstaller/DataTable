local UINAthListGroup = class("UINAthListGroup", UIBaseNode)
local base = UIBaseNode
local gridWidth = 117
local anchorLeftTop = Vector2.New(0, 1)
local spaceSize = Vector2.New(6, 6)

function UINAthListGroup:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.athItemDic = {}
  self.__onSetLayoutHeight = BindCallback(self, self.__SetLayoutHeight)
end

function UINAthListGroup:InitAthListGroup(returnAthFunc, returnAthMatFunc, groupGridSize)
  self.returnAthFunc = returnAthFunc
  self.returnAthMatFunc = returnAthMatFunc
  self.groupGridSize = groupGridSize
  self:__SetLayoutHeight(0)
end

function UINAthListGroup:AddMatNode2Group(athMatUpNode)
  athMatUpNode.transform:SetParent(self.transform)
  athMatUpNode.transform.anchorMax = anchorLeftTop
  athMatUpNode.transform.anchorMin = anchorLeftTop
  athMatUpNode.transform.anchoredPosition = Vector2.New(athMatUpNode.transform.sizeDelta.x / 2, 0)
  self:__SetLayoutHeight(athMatUpNode.transform.sizeDelta.y)
  athMatUpNode:SetAthMatNodeChangeHeightFunc(self.__onSetLayoutHeight)
  self.athMatUpNode = athMatUpNode
end

function UINAthListGroup:AddAthSuit2Group(athSuitItem, returnAthSuitFunc)
  athSuitItem.transform:SetParent(self.transform)
  athSuitItem.transform.anchorMax = anchorLeftTop
  athSuitItem.transform.anchorMin = anchorLeftTop
  athSuitItem.transform.anchoredPosition = Vector2.New(athSuitItem.transform.sizeDelta.x / 2, -athSuitItem.transform.sizeDelta.y / 2)
  self:__SetLayoutHeight(athSuitItem.transform.sizeDelta.y)
  self.athSuitItem = athSuitItem
  self.returnAthSuitFunc = returnAthSuitFunc
end

function UINAthListGroup:AddAthItem2Group(athItem, gridId)
  self.athItemDic[athItem:GetAthItemData().uid] = athItem
  athItem.transform:SetParent(self.transform)
  local y = math.ceil(gridId / self.groupGridSize.x) - 1
  local x = gridId % self.groupGridSize.x - 1
  if x == -1 then
    x = self.groupGridSize.x - 1
  end
  local posX = x * (gridWidth + spaceSize.x) + athItem.transform.sizeDelta.x / 2
  local posY = -(y * (gridWidth + spaceSize.y) + athItem.transform.sizeDelta.y / 2)
  local pos = Vector2.New(posX, posY)
  athItem.transform.anchoredPosition = pos
  local height = -posY + athItem.transform.sizeDelta.y / 2
  if height > self.ui.layoutElement.preferredHeight then
    self:__SetLayoutHeight(height)
  end
end

function UINAthListGroup:GetAthItemFromAllGroup(uid)
  return self.athItemDic[uid]
end

function UINAthListGroup:HasAthMatNode()
  return self.athMatUpNode ~= nil
end

function UINAthListGroup:ClealAllAthItem()
  for k, athItem in pairs(self.athItemDic) do
    self.returnAthFunc(athItem)
  end
  if self.athMatUpNode ~= nil and self.returnAthMatFunc ~= nil and self.athMatUpNode.transform.parent == self.transform then
    self.athMatUpNode:SetAthMatNodeChangeHeightFunc(nil)
    self.returnAthMatFunc()
    self.athMatUpNode = nil
  end
  if self.athSuitItem ~= nil and self.returnAthSuitFunc ~= nil and self.athSuitItem.transform.parent == self.transform then
    self.returnAthSuitFunc()
    self.athSuitItem = nil
  end
  self.athItemDic = {}
  self:__SetLayoutHeight(0)
end

function UINAthListGroup:__SetLayoutHeight(height)
  self.ui.layoutElement.preferredHeight = height
end

function UINAthListGroup:OnDelete()
  base.OnDelete(self)
end

return UINAthListGroup
