local GoldenSpyFloorData = class("GoldenSpyFloorData")

function GoldenSpyFloorData:ctor()
end

function GoldenSpyFloorData:InitData()
  self.tbItem = {}
end

function GoldenSpyFloorData:StartFloor(levelId, floorId)
  self.levelId = levelId
  self.floorId = floorId
  self.floorConfig = ConfigTable.GetData("GoldenSpyFloor", floorId)
  if self.floorConfig == nil then
    return
  end
end

function GoldenSpyFloorData:GetCurFloor()
  return self.floorId
end

function GoldenSpyFloorData:GetFloorConfig()
  return self.floorConfig
end

function GoldenSpyFloorData:SetItem(itemId)
  if self.tbItem[itemId] == nil then
    self.tbItem[itemId] = {itemId = itemId, itemCount = 0}
  end
  self.tbItem[itemId].itemCount = self.tbItem[itemId].itemCount + 1
end

function GoldenSpyFloorData:DeleteItem(itemId, bForce)
  bForce = bForce or false
  if self.tbItem[itemId] == nil then
    return
  end
  self.tbItem[itemId].itemCount = self.tbItem[itemId].itemCount - 1
  if self.tbItem[itemId].itemCount <= 0 then
    self.tbItem[itemId] = nil
  end
  local itemCfg = ConfigTable.GetData("GoldenSpyItem", itemId)
  if itemCfg == nil then
    return
  end
  if itemCfg.ItemType == GameEnum.GoldenSpyItem.BuffItem and not bForce then
    return
  end
  local nCount = 0
  for k, v in pairs(self.tbItem) do
    local itemCfg = ConfigTable.GetData("GoldenSpyItem", k)
    if itemCfg ~= nil and itemCfg.ItemType ~= GameEnum.GoldenSpyItem.Boom then
      nCount = nCount + v.itemCount
    end
  end
  if self.tbItem == nil or nCount <= 0 then
    EventManager.Hit("GoldenSpy_FinishFloor")
  end
end

function GoldenSpyFloorData:GetItems()
  return self.tbItem
end

return GoldenSpyFloorData
