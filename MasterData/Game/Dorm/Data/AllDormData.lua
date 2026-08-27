local AllDormData = class("AllDormData")
local DormHouseData = require("Game.Dorm.Data.DormHouseData")
local DormRoomData = require("Game.Dorm.Data.DormRoomData")

local function houseSortFunc(a, b)
  local houseCfgA = ConfigData.dorm_house[a]
  local houseCfgB = ConfigData.dorm_house[b]
  if houseCfgA.order_id ~= houseCfgB.order_id then
    return houseCfgA.order_id < houseCfgB.order_id
  end
  return houseCfgA.id < houseCfgB.id
end

function AllDormData:ctor()
  self.allBindFntDataDirty = true
end

function AllDormData:InitDormData(dormdata)
  self.comfort = dormdata.comfort
  self.prefabDic = {}
  for uid, room in pairs(dormdata.prefab) do
    local roomData = DormRoomData.New()
    roomData:InitPrefabRoom(uid, room)
    self.prefabDic[uid] = roomData
  end
  self.houseDic = {}
  self.houseIdList = {}
  for k, houseId in ipairs(ConfigData.dorm_house.id_sort_list) do
    local houseData
    local houseMsg = dormdata.house[houseId]
    local houseCfg = ConfigData.dorm_house[houseId]
    if houseMsg then
      houseData = DormHouseData.New()
      houseData:InitHouseData(houseMsg)
    elseif houseCfg.unlock_house_before == 0 or dormdata.house[houseCfg.unlock_house_before] then
      houseData = DormHouseData.CreateNewLockHouse(houseId)
    end
    if houseData ~= nil then
      self.houseDic[houseId] = houseData
      table.insert(self.houseIdList, houseId)
    end
  end
  table.sort(self.houseIdList, houseSortFunc)
  self.__dormHeroTalk = dormdata.heroTalk
end

function AllDormData:AddNewHouse(houseId)
  local ownHouse = self.houseDic[houseId]
  ownHouse:SetDmHouseLock(false)
  local unlockHouseId = ConfigData.dorm_house.dmHouseUnlockPreHouseIdDic[houseId]
  if unlockHouseId == nil then
    return
  end
  local houseData = DormHouseData.CreateNewLockHouse(unlockHouseId)
  self.houseDic[unlockHouseId] = houseData
  table.insert(self.houseIdList, unlockHouseId)
  table.sort(self.houseIdList, houseSortFunc)
end

function AllDormData:RemovePrefabRoom(uid)
  self.prefabDic[uid] = nil
end

function AllDormData:UpdatePrefabRoom(uid, room)
  self:RemovePrefabRoom(uid)
  local roomData = DormRoomData.New()
  roomData:InitPrefabRoom(uid, room)
  self.prefabDic[uid] = roomData
end

function AllDormData:GetFirstHouse()
  if #self.houseIdList == 0 then
    return nil
  end
  return self.houseDic[self.houseIdList[1]]
end

function AllDormData:IsHouseUnlock(id)
  return self.houseDic[id] ~= nil
end

function AllDormData:GetTotalComfort()
  if self.houseDic == nil then
    return 0
  end
  local comfort = 0
  for _, houseData in pairs(self.houseDic) do
    comfort = comfort + houseData:GetComfort()
  end
  return comfort
end

function AllDormData:GetHistoryComfortCfg()
  local curLevel = 1
  for _, level in ipairs(ConfigData.dorm_comfort.level_sort) do
    local comfortCfg = ConfigData.dorm_comfort[level]
    if comfortCfg == nil then
      error("dorm comfort cfg is null,id:" .. tostring(level))
      return nil
    end
    if self.comfort >= comfortCfg.comfort then
      curLevel = level
    else
      break
    end
  end
  return ConfigData.dorm_comfort[curLevel]
end

function AllDormData:GetAllBindFntData()
  if not self.allBindFntDataDirty then
    return self.allBindFntData
  end
  self.allBindFntDataDirty = false
  local allBindFntData = {
    allList = {},
    boundDic = {}
  }
  for houseId, houseData in pairs(self.houseDic) do
    for spos, roomData in pairs(houseData.roomDic) do
      for k, fntData in ipairs(roomData.canBindfntDataList) do
        table.insert(allBindFntData.allList, fntData)
        local heroId = fntData:GetFntParam()
        if 0 < heroId then
          allBindFntData.boundDic[heroId] = fntData
        end
      end
    end
  end
  self.allBindFntData = allBindFntData
  return self.allBindFntData
end

function AllDormData:SetAllBindFntDataDirty()
  self.allBindFntDataDirty = true
end

function AllDormData:IsDormHeroTalked(heroId, talkIndex)
  local talkKey = self.__dormHeroTalk[heroId]
  if talkKey == nil then
    return false
  end
  local sign = 1 << talkIndex - 1
  return 0 < talkKey & sign
end

function AllDormData:AddDormHeroTalked(heroId, talkIndex)
  local talkKey = self.__dormHeroTalk[heroId]
  if talkKey == nil then
    talkKey = 0
  end
  local sign = 1 << talkIndex - 1
  self.__dormHeroTalk[heroId] = talkKey | sign
end

function AllDormData:GetDormHeroTalkKey(heroId)
  local talkKey = self.__dormHeroTalk[heroId]
  if talkKey == nil then
    return 0
  end
  return talkKey
end

function AllDormData:GetDmBindHeroIdFntAllDic()
  local bindHeroIdFntDic = {}
  local fntHeroIdDic = {}
  for houseId, houseData in pairs(self.houseDic) do
    houseData:GetDmHouseBindFntHeroDic(bindHeroIdFntDic, fntHeroIdDic)
  end
  return bindHeroIdFntDic, fntHeroIdDic
end

function AllDormData:IsAnyDmHouseUnlockableUnread()
  for k, houseData in pairs(self.houseDic) do
    if not houseData:IsDmHouseUnlockableReaded() then
      return true
    end
  end
  return false
end

return AllDormData
