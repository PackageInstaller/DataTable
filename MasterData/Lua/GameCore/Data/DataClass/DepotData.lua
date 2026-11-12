local DepotData = class("DepotData")

function DepotData:ctor()
  self.tbConsumables = {}
  self.tbBasicItem = {}
  self.tbMaterial = {}
  self.nConsumablesCount = 0
  self.nBasicItemCount = 0
  self.nMaterialCount = 0
end

function DepotData:Init(nType)
  if nType == nil then
    self:InitConsumables()
    self:InitBasicItem()
    self:InitMaterial()
  elseif nType == GameEnum.packMark.Consumables then
    self:InitConsumables()
  elseif nType == GameEnum.packMark.BasicItem then
    self:InitBasicItem()
  elseif nType == GameEnum.packMark.Material then
    self:InitMaterial()
  end
end

function DepotData:Init()
  self:InitConsumables()
  self:InitBasicItem()
  self:InitMaterial()
end

function DepotData:InitConsumables()
  local tbItem = PlayerData.Item:GetItemsByMark(GameEnum.packMark.Consumables)
  self.tbConsumables = self:InitItemList(tbItem)
  self.nConsumablesCount = #self.tbConsumables
end

function DepotData:InitBasicItem()
  local tbItem = PlayerData.Item:GetItemsByMark(GameEnum.packMark.BasicItem)
  self.tbBasicItem = self:InitItemList(tbItem)
  self.nBasicItemCount = #self.tbBasicItem
end

function DepotData:InitMaterial()
  local tbItem = PlayerData.Item:GetItemsByMark(GameEnum.packMark.Material)
  self.tbMaterial = self:InitItemList(tbItem)
  self.nMaterialCount = #self.tbMaterial
end

function DepotData:InitItemList(tbItem)
  local tbAfter = {}
  local curTime = CS.ClientManager.Instance.serverTimeStamp
  for _, mapItem in ipairs(tbItem) do
    for nExpire, mapExpiresData in pairs(mapItem.mapExpires) do
      if 0 < nExpire and 0 < nExpire - curTime or nExpire == 0 then
        local mapAfter = {
          nTid = mapItem.Tid,
          nId = mapItem.Tid,
          nRarity = ConfigTable.GetData_Item(mapItem.Tid).Rarity,
          sType = ConfigTable.GetData_Item(mapItem.Tid).Stype,
          nExpire = nExpire,
          nCount = mapExpiresData.nTotalCount,
          bDisplay = ConfigTable.GetData_Item(mapItem.Tid).Display
        }
        table.insert(tbAfter, mapAfter)
      end
    end
  end
  return tbAfter
end

function DepotData:GetGridCount(nType)
  local tbItem = {}
  if nType == GameEnum.packMark.Consumables then
    tbItem = self.tbConsumables
  elseif nType == GameEnum.packMark.BasicItem then
    tbItem = self.tbBasicItem
  elseif nType == GameEnum.packMark.Material then
    tbItem = self.tbMaterial
  end
  local tbDisplayItem = self:GetDisplayItemList(tbItem)
  return #tbDisplayItem
end

function DepotData:GetSortedList(nType, mapSort, tbFilter)
  if nType == GameEnum.packMark.Consumables then
    self:GetSortedConsumables()
    return self:GetDisplayItemList(self.tbConsumables)
  elseif nType == GameEnum.packMark.BasicItem then
    self:GetSortedBasicItem()
    return self:GetDisplayItemList(self.tbBasicItem)
  elseif nType == GameEnum.packMark.Material then
    self:GetSortedMaterial()
    return self:GetDisplayItemList(self.tbMaterial)
  end
end

function DepotData:GetSortedConsumables(nSortType, bOrder)
  if nSortType == nil then
    return self:SortItem_Rarity(self.tbConsumables, true)
  end
end

function DepotData:GetSortedBasicItem(nSortType, bOrder)
  if nSortType == nil then
    return self:SortItem_Rarity(self.tbBasicItem, true)
  end
end

function DepotData:GetSortedMaterial(nSortType, bOrder)
  if nSortType == nil then
    return self:SortItem_Rarity(self.tbMaterial, true)
  end
end

function DepotData:SortItem_Rarity(tbItem, bOrder)
  local function comp(a, b)
    if a.nRarity == b.nRarity then
      if a.sType == b.sType then
        if a.nExpire == b.nExpire then
          if bOrder then
            return a.nTid < b.nTid
          else
            return a.nTid > b.nTid
          end
        end
        if a.nExpire == 0 or b.nExpire == 0 then
          if bOrder then
            return a.nExpire > b.nExpire
          else
            return a.nExpire < b.nExpire
          end
        elseif bOrder then
          return a.nExpire < b.nExpire
        else
          return a.nExpire > b.nExpire
        end
      end
      if bOrder then
        return a.sType < b.sType
      else
        return a.sType > b.sType
      end
    end
    if bOrder then
      return a.nRarity < b.nRarity
    else
      return a.nRarity > b.nRarity
    end
  end
  
  table.sort(tbItem, comp)
end

function DepotData:GetDisplayItemList(tbItem)
  local tbShowItem = {}
  for _, v in ipairs(tbItem) do
    if v.bDisplay then
      table.insert(tbShowItem, v)
    end
  end
  return tbShowItem
end

function DepotData:Clear()
  self.tbConsumables = nil
  self.tbBasicItem = nil
  self.tbMaterial = nil
  self.nConsumablesCount = nil
  self.nBasicItemCount = nil
  self.nMaterialCount = nil
end

return DepotData
