local DormHouseData = class("DormHouseData")
local DormRoomData = require("Game.Dorm.Data.DormRoomData")
local DormUtil = require("Game.Dorm.DormUtil")
local DormEnum = require("Game.Dorm.DormEnum")

function DormHouseData:ctor()
end

function DormHouseData.CreateNewLockHouse(id)
  local housedata = {id = id}
  local dorm = DormHouseData.New()
  dorm:InitHouseData(housedata)
  dorm:SetDmHouseLock(true)
  return dorm
end

function DormHouseData:InitHouseData(housedata)
  self.id = housedata.id
  self.roomList = {}
  self.roomDic = {}
  self.HasBindHeroCount = 0
  self.houseCfg = ConfigData.dorm_house[self.id]
  if self.houseCfg == nil then
    error("dorm house cfg is null,id:" .. tostring(self.id))
    return
  end
  local r = self:GetRoomHexRange()
  if housedata.data ~= nil then
    for spos, room in pairs(housedata.data) do
      local roomData = DormRoomData.New()
      roomData:InitRoomData(spos, room, self.id, r)
      table.insert(self.roomList, roomData)
      self.roomDic[spos] = roomData
    end
  end
  table.sort(self.roomList, function(x1, x2)
    return x1.spos < x2.spos
  end)
end

function DormHouseData:SetDmHouseLock(isLock)
  self._isLock = isLock
end

function DormHouseData:IsDmHouseLock()
  return self._isLock or false
end

function DormHouseData:IsDefaultUnlockDmHouse()
  return self.houseCfg.unlock_logic == DormEnum.eDmHouseUnlockLogic.BuildingLevel and self.houseCfg.unlock_level == 1
end

function DormHouseData:GetRoomDataByRoomIndex(RoomIndex)
  local r = self:GetRoomHexRange()
  for k, v in pairs(self.roomDic) do
    local x, y = DormUtil.RoomCoordToXY(k)
    local Index = DormUtil.GetRoomIndexByRoomposToxy(x, y, r)
    if Index == RoomIndex then
      return v
    end
  end
end

function DormHouseData:RemoveHouseRoom(spos)
  local oldRoom = self.roomDic[spos]
  if oldRoom ~= nil then
    self.roomDic[spos] = nil
    table.removebyvalue(self.roomList, oldRoom)
  end
end

function DormHouseData:AddHouseRoom(roomData)
  self.roomDic[roomData.spos] = roomData
  table.insert(self.roomList, roomData)
end

function DormHouseData:GetName()
  return LanguageUtil.GetLocaleText(self.houseCfg.name)
end

function DormHouseData:GetRoomCount()
  return #self.roomList
end

function DormHouseData:GetDmHouseRoomList()
  return self.roomList
end

function DormHouseData:GetRoomHexRange()
  return self.houseCfg.type
end

function DormHouseData:GetHouseDefaultRoom()
  return self.houseCfg.default_room
end

function DormHouseData:GetComfortLimit()
  return self.houseCfg.comfort_limit
end

function DormHouseData:GetDormEffectResPath()
  return self.houseCfg.dorm_effect
end

function DormHouseData:IsBigRoomHouse()
  return self.houseCfg.house_roomtype == 1
end

function DormHouseData:IsOnlyOneRoom()
  return #self.roomList <= 1
end

function DormHouseData:GetDmHouseIconIdx()
  return self.houseCfg.icon_index
end

function DormHouseData:GetDmHouseBuyCost()
  return self.houseCfg.unlock_item_id, self.houseCfg.unlock_item_num
end

function DormHouseData:GetComfort()
  local comfort = 0
  for k, v in pairs(self.roomDic) do
    comfort = comfort + v:GetComfort()
  end
  comfort = math.clamp(comfort, 0, self:GetComfortLimit())
  return comfort
end

function DormHouseData:GetHouseBindCount()
  local count = 0
  for k, v in pairs(self.roomDic) do
    count = count + v:GetRoomBindCount()
  end
  return count
end

function DormHouseData:GetHouseBindFntCount()
  local count = 0
  for k, v in pairs(self.roomDic) do
    count = count + v:GetRoomBindCount()
  end
  return count
end

function DormHouseData:IsHeroBindOnElseRoom(HeroId, CurRoomData)
  for k, v in pairs(self.roomDic) do
    if v.spos ~= CurRoomData.spos and v:IsHeroBindOnRoom(HeroId) then
      return true
    end
  end
  return false
end

function DormHouseData:GetHeroOnElseRoomData(HeroId, CurRoomData)
  for k, v in pairs(self.roomDic) do
    if v.spos ~= CurRoomData.spos and v:IsHeroBindOnRoom(HeroId) then
      return v
    end
  end
end

function DormHouseData:GetHouseCanBindFntCount()
  local count = 0
  for k, v in pairs(self.roomDic) do
    count = count + v:GetRoomCanBindFntCount()
  end
  return count
end

function DormHouseData:GetDmHouseBindNum()
  local num = 0
  for k, roomData in ipairs(self.roomList) do
    num = num + roomData:GetRoomBindCount()
  end
  return num
end

function DormHouseData:SwapHousePos(spos1, spos2)
  self.roomDic[spos1], self.roomDic[spos2] = self.roomDic[spos2], self.roomDic[spos1]
end

function DormHouseData:GetDmHouseBindFntHeroDic(bindHeroIdFntDic, fntHeroIdDic)
  for k, v in pairs(self.roomDic) do
    for k2, fntData in ipairs(v:GetRoomCanBindList()) do
      local heroId = fntData:GetFntParam()
      if 0 < heroId then
        bindHeroIdFntDic[heroId] = fntData
      end
      fntHeroIdDic[fntData] = heroId
    end
  end
end

function DormHouseData:GetHouseBindFntDataList()
  local bindList = {}
  local count = 0
  for k, v in pairs(self.roomDic) do
    for k2, ftnData in pairs(v:GetRoomCanBindList()) do
      count = count + 1
      table.insert(bindList, ftnData)
    end
  end
  table.sort(bindList, function(a, b)
    local aBind = a:GetFntParam() ~= 0
    local bBind = b:GetFntParam() ~= 0
    if aBind == bBind then
      return a.id < b.id
    else
      return aBind
    end
  end)
  local list = {}
  for k, v in ipairs(bindList) do
    table.insert(list, v)
  end
  return list
end

function DormHouseData:IsDmHouseUnlockableReaded()
  if not self:IsDmHouseLock() then
    return true
  end
  local saveUserData = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData)
  return saveUserData:GetUnlockableDormHouseReaded(self.id)
end

return DormHouseData
