local DormEditRoomData = class("DormEditRoomData")
local DormEnum = require("Game.Dorm.DormEnum")
local DormUtil = require("Game.Dorm.DormUtil")

function DormEditRoomData:ResetStorateFntData(isInit)
  self.storageFntDic = {}
  if isInit then
    self:__ResetBroadcastDiff()
  end
  local fntItemDic = PlayerDataCenter:GetItemDicByType(eItemType.DormFurniture)
  local fntItemList = {}
  for id, v in pairs(fntItemDic) do
    if not DormUtil.IsDmRoomDefaultDoorId(id) then
      local storageFnt = self:__NewStorateFnt(id, v:GetCount())
      if storageFnt ~= nil then
        self:_AddStorageFnt(storageFnt)
      end
    end
  end
end

function DormEditRoomData:_AddStorageFnt(storageFnt)
  self.storageFntDic[storageFnt.id] = storageFnt
  if storageFnt.fntCfg.is_theme then
    self._hasThemeFntInstallable = true
  end
end

function DormEditRoomData:IsHasAnyDmtThemeFnt()
  return self._hasThemeFntInstallable or PlayerDataCenter.dormBriefData:IsHasAnyDmtThemeFntInstalled()
end

function DormEditRoomData:GetDmStorageFntData(id)
  return self.storageFntDic[id]
end

function DormEditRoomData:__Add2Broadcast(storageFnt, isAdd)
  if isAdd == nil then
    isAdd = false
  end
  self._waitBroadDic = self._waitBroadDic or {}
  self._waitBroadDic[storageFnt] = isAdd
  if self._waitBroadcast == false then
    self._waitBroadcast = true
    self.__BroadcastDiffFunc = self.__BroadcastDiffFunc or BindCallback(self, self.__BroadcastDiff)
    TimerManager:AddLateCommand(self.__BroadcastDiffFunc)
  end
end

function DormEditRoomData:__BroadcastDiff()
  if self._waitBroadcast == false then
    return
  end
  MsgCenter:Broadcast(eMsgEventId.DormRoomEditDataChange, self._waitBroadDic)
  self:__ResetBroadcastDiff()
end

function DormEditRoomData:__ResetBroadcastDiff()
  self._waitAddList = nil
  self._waitRemoveList = nil
  self._waitBroadcast = false
  self._waitBroadDic = nil
end

function DormEditRoomData:InstallFntData(id)
  local storageFnt = self.storageFntDic[id]
  if storageFnt ~= nil then
    storageFnt.count = storageFnt.count - 1
    self:__Add2Broadcast(storageFnt, false)
  end
end

function DormEditRoomData:UninstallFntData(id)
  local isAdd = false
  local storageFnt = self.storageFntDic[id]
  if storageFnt == nil then
    storageFnt = self:__NewStorateFnt(id, 1)
    if storageFnt ~= nil then
      self:_AddStorageFnt(storageFnt)
      isAdd = true
    end
  else
    storageFnt.count = storageFnt.count + 1
  end
  if storageFnt ~= nil then
    self:__Add2Broadcast(storageFnt, isAdd)
  end
end

function DormEditRoomData:OnItemChange(itemUpdate, resourceData)
  if resourceData.backpack == nil then
    return
  end
  for id, v in pairs(resourceData.backpack.updates) do
    local itemCfg = ConfigData.item[id]
    if itemCfg == nil then
      error("Cant get itemCfg, id = " .. tostring(id))
    elseif itemCfg.type == eItemType.DormFurniture then
      local storageFnt = self.storageFntDic[id]
      local isAdd = false
      if storageFnt == nil then
        storageFnt = self:__NewStorateFnt(id, v.count)
        if storageFnt ~= nil then
          self:_AddStorageFnt(storageFnt)
          isAdd = true
        end
      else
        storageFnt.count = v.count
      end
      self:__Add2Broadcast(storageFnt, isAdd)
    end
  end
end

function DormEditRoomData:NewDmStorateFnt(id, count)
  return self:__NewStorateFnt(id, count)
end

function DormEditRoomData:__NewStorateFnt(id, count)
  local fntCfg = ConfigData.dorm_furniture[id]
  if fntCfg == nil then
    error("Can't find dorm_furniture cfg, id = " .. tostring(id))
    return
  end
  local itemCfg = ConfigData.item[id]
  if itemCfg == nil then
    error("Can't find item cfg, id = " .. tostring(id))
    return
  end
  local fnt = {
    id = id,
    fntCfg = fntCfg,
    itemCfg = itemCfg,
    count = count
  }
  return fnt
end

function DormEditRoomData:GetFntWarehouseList()
  local fntWarehouseList = {}
  for k, v in pairs(self.storageFntDic) do
    table.insert(fntWarehouseList, v)
  end
  return fntWarehouseList
end

local DefaultWallData = {
  id = 0,
  isDefaultDmFnt = true,
  name = ConfigData:GetTipContent(2012),
  fntCfg = {
    type = DormEnum.eDormFntType.Wall,
    category = 1
  },
  icon = "ICON_furniture_39",
  itemId = 720039
}
local DefaultFloorData = {
  id = 0,
  isDefaultDmFnt = true,
  name = ConfigData:GetTipContent(2013),
  fntCfg = {
    type = DormEnum.eDormFntType.Floor,
    category = 4
  },
  icon = "ICON_furniture_40",
  itemId = 720040
}

function DormEditRoomData:GetFntWarehouseCatgList()
  local fntCatgList = {}
  local fntList = {}
  fntCatgList[DormEnum.eDormFntCategory.Wall] = fntList
  table.insert(fntList, DefaultWallData)
  local fntList = {}
  fntCatgList[DormEnum.eDormFntCategory.Floor] = fntList
  table.insert(fntList, DefaultFloorData)
  for k, v in pairs(self.storageFntDic) do
    local catgId = v.fntCfg.category
    if fntCatgList[catgId] == nil then
      fntCatgList[catgId] = {}
    end
    local fntList = fntCatgList[catgId]
    table.insert(fntList, v)
  end
  return fntCatgList
end

return DormEditRoomData
