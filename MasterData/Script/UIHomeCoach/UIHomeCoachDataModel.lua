local mathEx = require("vendor/mathEx")
local HomeDataModel = require("UIMainUI/UIMainUIDataModel")
local TradeDataModel = require("UIHome/UIHomeTradeDataModel")
local DataModel = {
  initParams = nil,
  coachBagTagId = 0,
  init = false,
  floorType = 12600176,
  wallType = 12600182,
  ReceptionID = 12600175,
  oneLevelIndex = 1,
  furnitureType = 12600176,
  wallLock = false,
  floorLock = false,
  roomIndex = 0,
  revertJson = "",
  revertData = {},
  furnitureTypeData = {},
  furnitureData = {},
  furnitureTypeGridData = {},
  furGridData = {},
  themeGridData = {},
  furUseTable = {},
  themeFurnitureGridData = {},
  selectJson = "",
  selectFur = {},
  curGridName = "",
  curGridData = nil,
  characterData = {
    [1] = "{70000010:{false,false}, 70000001:{false,false}, 70000012:{false,false}}",
    [2] = "{70000010:false, 70000001:false, 70000012:false}",
    [3] = "{70000010:false, 70000001:false, 70000012:false}"
  },
  characterIdList = {},
  petData = {},
  specialCharacterData = {
    [12600167] = "{70000031}"
  },
  characterMaxLimit = 18,
  presetGridData = {},
  curPresetIdx = nil,
  curPresetThumbnail = nil,
  curPresetRoomJson = "",
  typeSelectIdx = 0,
  preSelectImg = nil,
  sortRule = {
    default = 1,
    developmentDegree = 2,
    primeAttrType = 3
  },
  sortRuleRecord = {},
  sortDown = true,
  curPlaceType = nil,
  curFurnitureType = nil,
  curPrimeAttrType = nil,
  tempPanel = nil,
  tempFurUfid = nil,
  powerCostRecord = 0,
  powerCostRecordChange = 0,
  petId = 0,
  curDecoFurUFId = ""
}

function DataModel.GetRoomIDByIndex(idx)
  return CommonCoachData.roomID[idx]
end

function DataModel.GetRoomID()
  return CommonCoachData.roomID[DataModel.roomIndex + 1]
end

function DataModel.GetCurRep()
  local index = DataModel.roomIndex + 1
  local furAry = CommonCoachData.roomFurnitureData[index]
  local receptionid = 0
  for i, v in pairs(furAry) do
    local furConfig = PlayerData:GetFactoryData(tonumber(v.id), "HomeFurnitureFactory")
    if furConfig and furConfig.type == DataModel.ReceptionID then
      receptionid = v
    end
  end
  return receptionid
end

function DataModel.LoadRoomFurnitureData(index)
  local furAry = CommonCoachData.roomFurnitureData[index]
  for i, v in pairs(furAry) do
    DataModel.AddFurnitureByID(v.id)
  end
end

function DataModel.CleanRoomFurnitureData(index)
  local furAry = CommonCoachData.roomFurnitureData[index]
  for i, v in pairs(furAry) do
    DataModel.RemoveFurnitureByID(v.ufid)
  end
  CommonCoachData.roomFurnitureData[index] = {}
end

function DataModel.CleanRoomFurnitureDataWithoutRep(index)
  local furAry = CommonCoachData.roomFurnitureData[index]
  local receptionid = 0
  for i, v in pairs(furAry) do
    local furConfig = PlayerData:GetFactoryData(tonumber(v.id), "HomeFurnitureFactory")
    if furConfig.beStored then
      if furConfig.type == DataModel.ReceptionID then
        receptionid = v
      else
        DataModel.RemoveFurnitureByID(v.ufid)
      end
    end
  end
end

function DataModel.GetFurnitureData(id)
  local data = DataModel.furnitureData[tostring(id)] or {
    use = 0,
    max = 0,
    data = {}
  }
  return data
end

function DataModel.AddFurnitureData(id)
  local data = DataModel.furnitureData[tostring(id)] or {
    use = 0,
    max = 0,
    data = {}
  }
  data.use = data.use + 1
  DataModel.furnitureData[id] = data
end

function DataModel.ResetFurnitureTypeData()
  DataModel.furnitureTypeData = {}
  for i, v in pairs(DataModel.furnitureData) do
    local furConfig = PlayerData:GetFactoryData(tonumber(i), "HomeFurnitureFactory")
    if furConfig ~= nil then
      local cur = DataModel.furnitureTypeData[furConfig.type] or {
        use = 0,
        max = 0,
        data = {}
      }
      cur.use = cur.use + v.use
      cur.max = cur.max + v.max
      cur.data = v.data
      DataModel.furnitureTypeData[furConfig.type] = cur
    end
  end
end

function DataModel.RemoveFurniture(json)
  local data = Json.decode(json)
  for i, v in pairs(data) do
    local val = DataModel.furnitureData[tostring(i)] or {
      use = 0,
      max = 0,
      data = {}
    }
    val.use = mathEx.Clamp(val.use + 1, 0, val.max)
    DataModel.furnitureData[i] = val
  end
end

function DataModel.RemoveFurnitureByID(ufid)
  local furniture = CommonCoachData.GetFurData()[ufid]
  if not furniture then
    return
  end
  local furId = furniture.id
  local val = DataModel.furnitureData[furId] or {
    use = 0,
    max = 0,
    data = {}
  }
  if 0 < #val.data then
    for i, v in ipairs(val.data) do
      if ufid == v.server.u_fid then
        v.isUse = false
        break
      end
    end
  end
  val.use = mathEx.Clamp(val.use - 1, 0, val.max)
  DataModel.furnitureData[furId] = val
end

function DataModel.CheckFurnitureUseAble(id)
  local val = DataModel.furnitureData[tostring(id)] or {
    use = 0,
    max = 0,
    data = {}
  }
  return val.use < val.max
end

function DataModel.CheckFurniturePosType(roomIdx, id)
  local roomId = CommonCoachData.roomID[roomIdx + 1]
  local coachCA = PlayerData:GetFactoryData(roomId, "HomeCoachFactory")
  local furCA = PlayerData:GetFactoryData(id, "HomeFurnitureFactory")
  if #furCA.posTypes > 0 then
    for k, v in pairs(furCA.posTypes) do
      for k1, v1 in pairs(coachCA.bayInfos) do
        if v.type == v1.bayType then
          return true
        end
      end
    end
  else
    return true
  end
  CommonTips.OpenTips(80600775)
  return false
end

function DataModel.AddFurnitureByTable(data)
  for i, v in pairs(data) do
    local val = DataModel.furnitureData[tostring(v.id)] or {
      use = 0,
      max = 0,
      data = {}
    }
    if 0 < #val.data then
      for i1, v1 in ipairs(val.data) do
        if v.ufid == v1.server.u_fid then
          v1.isUse = true
          break
        end
      end
    end
    val.use = mathEx.Clamp(val.use + 1, 0, val.max)
    DataModel.furnitureData[v.id] = val
  end
end

function DataModel.AddFurnitureByID(id)
  local ufid
  local val = DataModel.furnitureData[tostring(id)] or {
    use = 0,
    max = 0,
    data = {}
  }
  if 0 < #val.data then
    for i, v in ipairs(val.data) do
      if v.isUse == false then
        v.isUse = true
        ufid = v.server.u_fid
        break
      end
    end
  end
  val.use = mathEx.Clamp(val.use + 1, 0, val.max)
  DataModel.furnitureData[id] = val
  return ufid
end

function DataModel.GetRoomFurnitureData(json)
  local row = {}
  local data = Json.decode(json)
  for i, v in pairs(data) do
    table.insert(row, i)
  end
  return row
end

function DataModel.InitFurniture(furData)
  local isUse = false
  if DataModel.furnitureData[furData.id] then
    DataModel.furnitureData[furData.id].max = DataModel.furnitureData[furData.id].max + 1
    if furData.u_cid ~= "" then
      DataModel.furnitureData[furData.id].use = DataModel.furnitureData[furData.id].use + 1
      isUse = true
    end
  else
    DataModel.furnitureData[furData.id] = {}
    DataModel.furnitureData[furData.id].max = 1
    DataModel.furnitureData[furData.id].data = {}
    if furData.u_cid ~= "" then
      DataModel.furnitureData[furData.id].use = 1
      isUse = true
    else
      DataModel.furnitureData[furData.id].use = 0
    end
  end
  table.insert(DataModel.furnitureData[furData.id].data, {server = furData, isUse = isUse})
end

function DataModel.InitRoomData()
  local furData = CommonCoachData.GetFurData(DataModel.coachBagTagId)
  DataModel.furnitureData = {}
  for i, v in pairs(furData) do
    v.u_fid = i
    DataModel.InitFurniture(v)
  end
end

function DataModel.InitPresetData(presetData)
  local thumbnailTempData = {}
  for i, v in pairs(DataModel.presetGridData) do
    if v.texture ~= nil then
      thumbnailTempData[v.furData] = v.texture
    end
  end
  DataModel.presetGridData = {}
  for i, v in pairs(presetData) do
    local t = {}
    t.name = v.name
    t.furData = v.template
    if thumbnailTempData[t.furData] ~= nil then
      t.texture = thumbnailTempData[t.furData]
    end
    table.insert(DataModel.presetGridData, t)
  end
  thumbnailTempData = nil
end

function DataModel.GetRoomData(index)
  local roomID = DataModel.GetRoomIDByIndex(index)
  local coachData = PlayerData:GetFactoryData(roomID, "HomeCoachFactory")
  local roomFurAry = CommonCoachData.roomFurnitureData[index]
  local roomData = {}
  roomData.name = coachData.name
  roomData.level = coachData.level
  roomData.des = coachData.describe
  roomData.comfort = 0
  roomData.none = 0
  roomData.mainValue = 0
  roomData.electricCost = 0
  for i, v in pairs(roomFurAry) do
    local furnitureConfig = PlayerData:GetFactoryData(v.id, "HomeFurnitureFactory")
    if furnitureConfig ~= nil then
      roomData.comfort = roomData.comfort + furnitureConfig.comfort or 0
      roomData.electricCost = roomData.electricCost + furnitureConfig.electricCost or 0
    end
  end
  return roomData
end

function DataModel.GetRoomInfo()
  return DataModel.GetRoomData(DataModel.roomIndex + 1)
end

function DataModel.PreCheckHomeDecorate()
  if DataModel.powerCostRecordChange > PlayerData.GetMaxElectric() then
    CommonTips.OpenTips(80601248)
    return false
  end
  return true, DataModel.powerCostRecordChange
end

function DataModel.ReCalcHomeElectricData()
  local newData = CommonCoachData.roomFurnitureData[DataModel.roomIndex + 1]
  local oldData = DataModel.revertData
  for k, v in pairs(oldData) do
    if v.id ~= 0 then
      local furCA = PlayerData:GetFactoryData(v.id, "HomeFurnitureFactory")
      PlayerData:GetHomeInfo().electric_used = PlayerData:GetHomeInfo().electric_used - furCA.electricCost
    end
  end
  for k, v in pairs(newData) do
    if v.id ~= 0 then
      local furCA = PlayerData:GetFactoryData(v.id, "HomeFurnitureFactory")
      PlayerData:GetHomeInfo().electric_used = PlayerData:GetHomeInfo().electric_used + furCA.electricCost
    end
  end
end

function DataModel.GeneralHandleFurnitureServerData(serverFur)
  if serverFur == nil then
    return
  end
  local homeFurnitureCA = PlayerData:GetFactoryData(serverFur.id, "HomeFurnitureFactory")
  if homeFurnitureCA ~= nil and homeFurnitureCA.mod ~= "\229\138\159\232\131\189\229\174\182\229\133\183" then
    return
  end
  serverFur.space = nil
  if serverFur.water ~= nil and serverFur.water.fishes ~= nil then
    for k, v in pairs(serverFur.water.fishes) do
      if PlayerData.ServerData.user_home_info.creatures[k] == nil then
        PlayerData.ServerData.user_home_info.creatures[k] = {}
        PlayerData.ServerData.user_home_info.creatures[k].num = 0
      end
      PlayerData.ServerData.user_home_info.creatures[k].num = PlayerData.ServerData.user_home_info.creatures[k].num + v
    end
  end
  serverFur.water = nil
  if serverFur.roles then
    for i, v in pairs(serverFur.roles) do
      if v ~= "" then
        PlayerData.ServerData.roles[v].u_fid = nil
      end
    end
  end
  serverFur.roles = nil
  if serverFur.house then
    for k, v in pairs(serverFur.house.pets) do
      local petServerData = PlayerData:GetHomeInfo().pet[v]
      if petServerData then
        petServerData.u_fid = ""
      end
      serverFur.house.pets[k] = ""
    end
    serverFur.house.food_num = 0
    serverFur.house.food_id = ""
  end
end

function DataModel.CalcCurrentCharacter()
  DataModel.characterData = {}
  local roomCount = table.count(CommonCoachData.roomSkinIds)
  local coach = PlayerData.ServerData.user_home_info.coach
  if PlayerData.visitMode then
    coach = PlayerData.visitInfo.coachData
  end
  for i, v in pairs(coach) do
    local coachCA = PlayerData:GetFactoryData(v.id, "HomeCoachFactory")
    local tagCA = PlayerData:GetFactoryData(coachCA.coachType)
    if tagCA.stopCarriage then
      roomCount = roomCount - 1
    end
  end
  for i = 1, roomCount do
    DataModel.characterData[i] = {}
  end
  local homeConfig = PlayerData:GetFactoryData(99900014, "ConfigFactory")
  local receptionist_id = PlayerData:GetUserInfo().receptionist_id[1]
  local receptionist_homeCharacterId = ""
  local box_homeCharacterId = homeConfig.box
  local yao_homeCharacterId = homeConfig.yao
  local t = {}
  local roles
  if PlayerData.visitMode then
    roles = PlayerData.visitInfo.roles
  else
    roles = PlayerData.ServerData.roles
  end
  for k, v in pairs(roles) do
    local unitCA = PlayerData:GetFactoryData(k, "unitFactory")
    if k == receptionist_id then
      receptionist_homeCharacterId = unitCA.homeCharacter
    elseif unitCA.homeCharacter > 0 and unitCA.homeCharacter ~= yao_homeCharacterId and unitCA.homeCharacter ~= box_homeCharacterId then
      table.insert(t, unitCA.homeCharacter)
    end
  end
  if 0 < box_homeCharacterId then
    table.insert(t, box_homeCharacterId)
  end
  if 0 < yao_homeCharacterId then
    table.insert(t, yao_homeCharacterId)
  end
  DataModel.characterIdList = t
  local tempT = {}
  local count = table.count(t)
  while 0 < count do
    local random = math.random(1, count)
    table.insert(tempT, t[random])
    t[random] = t[count]
    count = count - 1
  end
  t = tempT
  local gender = PlayerData:GetUserInfo().gender or 1
  local conductor = homeConfig.conductorW
  if gender == 1 then
    conductor = homeConfig.conductorM
  end
  table.insert(DataModel.characterIdList, conductor)
  local str = ""
  if not TradeDataModel.GetIsTravel() then
    str = str .. conductor .. ":[false,false],"
  end
  if receptionist_homeCharacterId ~= "" then
    str = str .. receptionist_homeCharacterId .. ":[false,true],"
  end
  str = "{" .. str .. "}"
  DataModel.characterData[1] = str
  local rolesCount = table.count(t)
  local divCount = roomCount - 1
  if divCount <= 0 then
    divCount = 1
  end
  local step = math.ceil(rolesCount / divCount)
  local stepRecord = 1
  for i = 2, roomCount do
    local str = ""
    for j = stepRecord, stepRecord + step - 1 do
      if t[j] then
        str = str .. t[j] .. ":[false,false],"
      end
    end
    stepRecord = stepRecord + step
    str = "{" .. str .. "}"
    DataModel.characterData[i] = str
  end
end

function DataModel.CalcCurrentPet()
  DataModel.petData = {}
  local roomCount = table.count(CommonCoachData.roomSkinIds)
  for i = 1, roomCount do
    DataModel.petData[i] = ""
  end
  local roomPetFurList = {}
  local pets = PlayerData.ServerData.user_home_info.pet
  local coach_store = PlayerData:GetHomeInfo().coach_store
  if PlayerData.visitMode then
    pets = PlayerData.visitInfo.pets
    coach_store = PlayerData.visitInfo.coach_store
  end
  for k, v in pairs(pets) do
    if v.u_fid ~= "" and v.u_fid then
      local roomList = PlayerData:GetHomeInfo().coach_template
      if PlayerData.visitMode then
        roomList = PlayerData.visitInfo.coach_template
      end
      local furniture = CommonCoachData.GetFurData()[v.u_fid]
      local coach_store = coach_store
      local roomId = 0
      for i, v1 in ipairs(roomList) do
        local cfgId = coach_store[v1].id
        local coachType = PlayerData:GetFactoryData(cfgId).coachType
        local tagCA = PlayerData:GetFactoryData(coachType)
        if not tagCA.stopCarriage then
          roomId = roomId + 1
          if v1 == furniture.u_cid then
            if not roomPetFurList[roomId] then
              roomPetFurList[roomId] = {}
              roomPetFurList[roomId][v.u_fid] = i
              break
            end
            roomPetFurList[roomId][v.u_fid] = i
            break
          end
        end
      end
    end
  end
  for k, v in pairs(roomPetFurList) do
    DataModel.petData[k] = ""
    local str = ""
    for k1, v1 in pairs(v) do
      for k2, v2 in pairs(CommonCoachData.GetFurData()[k1].house.pets) do
        local data = pets[v2]
        if data then
          local id = PlayerData:GetFactoryData(data.id).homeCharacter
          str = str .. v2 .. ":" .. id .. ","
        end
      end
    end
    if str ~= "" then
      str = "{" .. str .. "}"
    end
    DataModel.petData[k] = str
  end
  return DataModel.petData
end

function DataModel.RemoveNoEmptyRoomCharacter()
  local roomCount = table.count(CommonCoachData.roomSkinIds)
  for i, v in pairs(PlayerData.ServerData.user_home_info.coach) do
    local coachCA = PlayerData:GetFactoryData(v.id, "HomeCoachFactory")
    local tagCA = PlayerData:GetFactoryData(coachCA.coachType)
    if tagCA.stopCarriage then
      roomCount = roomCount - 1
    end
  end
  for i = 1, roomCount do
    if not PosClickHandler.GetRoomIsHaveEmptyTile(i) then
      DataModel.characterData[i] = "{}"
      DataModel.petData[i] = {}
    end
  end
end

function DataModel.CheckCanPutLiveBed(roomIndex, furId)
  local curLiveNum = 0
  local roomId = CommonCoachData.roomID[roomIndex]
  for _, v in pairs(CommonCoachData.roomFurnitureData[roomIndex]) do
    local furCA = PlayerData:GetFactoryData(v.id, "HomeFurnitureFactory")
    if furCA.functionType == 12600199 then
      curLiveNum = curLiveNum + furCA.characterNum
    end
  end
  local coachCA = PlayerData:GetFactoryData(roomId, "HomeCoachFactory")
  local furCA = PlayerData:GetFactoryData(furId, "HomeFurnitureFactory")
  return curLiveNum + furCA.characterNum <= coachCA.characterNum
end

function DataModel.GetRoomCount()
  local roomCount = table.count(CommonCoachData.roomSkinIds)
  for i, v in pairs(PlayerData.ServerData.user_home_info.coach) do
    local coachCA = PlayerData:GetFactoryData(v.id, "HomeCoachFactory")
    local tagCA = PlayerData:GetFactoryData(coachCA.coachType)
    if tagCA.stopCarriage then
      roomCount = roomCount - 1
    end
  end
  return roomCount
end

return DataModel
