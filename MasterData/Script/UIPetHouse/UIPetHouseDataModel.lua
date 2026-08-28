local DataModel = {}
local PetInfoData = require("UIPetInfo/UIPetInfoDataModel")

local function GetNextLevelFavor(lv)
  local petScoresConfig = PlayerData:GetFactoryData(99900022).petScoresConfig
  local max = #petScoresConfig
  if lv > max then
    return petScoresConfig[max].Favorability
  end
  return petScoresConfig[lv].Favorability
end

local function Init(furniture)
  DataModel.furniture = furniture
  local fCfg = PlayerData:GetFactoryData(furniture.id)
  DataModel.petNum = fCfg.PetNum
  DataModel.houseName = furniture.name == "" and fCfg.name or furniture.name
  DataModel.houseScores = fCfg.petScores
  DataModel.wasteoutput = fCfg.wasteoutput
  DataModel.petList = furniture.house.pets or {}
  DataModel.foodCapacity = fCfg.maxFood
  DataModel.eatNum = 0
  DataModel.interactMax = PlayerData:GetFactoryData(99900022).TouchTimes
  for i = 1, DataModel.petNum do
    DataModel.petList[i] = DataModel.petList[i] or ""
    if DataModel.petList[i] ~= "" then
      local petInfo = PlayerData:GetHomeInfo().pet[DataModel.petList[i]]
      local petId = petInfo.id
      local cfg = PlayerData:GetFactoryData(petId)
      DataModel.eatNum = DataModel.eatNum + cfg.petFoodInt
      DataModel.houseScores = DataModel.houseScores + PetInfoData.CalPetScores(petInfo)
      DataModel.wasteoutput = DataModel.wasteoutput + cfg.wasteoutput
    end
  end
  DataModel.eatNum = DataModel.eatNum * (1 - PlayerData:GetHomeSkillIncrease(EnumDefine.HomeSkillEnum.ReducePetFoodConsume))
  DataModel.eatNum = math.floor(DataModel.eatNum + 1.0E-4)
  DataModel.foodList = {}
  local foodItemList = PlayerData:GetFactoryData(99900022).foodItemList
  for i, v in ipairs(foodItemList) do
    local data = PlayerData:GetMaterials()[tostring(v.id)]
    if data and data.num ~= 0 then
      table.insert(DataModel.foodList, {
        id = data.id,
        num = data.num
      })
    end
  end
  DataModel.UpdateFoodNum(furniture.house.food_num or 0)
  DataModel.lvFavorMax = nil
end

local function GetRoomIdAndPosx(ufid)
  local roomId = -1
  local posx = 0
  local roomList = PlayerData:GetHomeInfo().coach_template
  local furniture = PlayerData:GetHomeInfo().furniture[ufid]
  local coach_store = PlayerData:GetHomeInfo().coach_store
  for i, v in ipairs(roomList) do
    local cfgId = coach_store[v].id
    local coachType = PlayerData:GetFactoryData(cfgId).coachType
    local tagCA = PlayerData:GetFactoryData(coachType)
    if not tagCA.stopCarriage then
      roomId = roomId + 1
      if v == furniture.u_cid then
        posx = HomeManager.rooms[roomId]:GetFurniture(ufid).PosX
        break
      end
    end
  end
  return roomId, posx
end

local function CalPetFurList()
  DataModel.selectIndex = 1
  DataModel.petHouseCount = 0
  DataModel.petFurList = {}
  for k, v in pairs(PlayerData:GetHomeInfo().furniture) do
    local functionType = PlayerData:GetFactoryData(v.id).functionType
    if functionType == 12600464 then
      local data = {u_fid = k}
      table.insert(DataModel.petFurList, data)
      data.roomId, data.posx = DataModel.GetRoomIdAndPosx(k)
      DataModel.petHouseCount = DataModel.petHouseCount + 1
    end
  end
  table.sort(DataModel.petFurList, function(t1, t2)
    if t1.roomId ~= t2.roomId then
      return t1.roomId > t2.roomId
    elseif t1.posx ~= t2.posx then
      return t1.posx > t2.posx
    end
    return tonumber(t1.u_fid) > tonumber(t2.u_fid)
  end)
  for i, v in ipairs(DataModel.petFurList) do
    if v.u_fid == DataModel.ufid then
      DataModel.selectIndex = i
      break
    end
  end
end

local function CalFoodOverflow(foodNum, unitNum)
  return DataModel.nowFoodNum + foodNum - unitNum >= DataModel.foodCapacity
end

local function UpdateFoodNum(num)
  num = num or 0
  if DataModel.foodCapacity and 0 < DataModel.foodCapacity then
    num = math.min(num, DataModel.foodCapacity)
  end
  DataModel.nowFoodNum = num
end

DataModel.Init = Init
DataModel.CalPetFurList = CalPetFurList
DataModel.GetNextLevelFavor = GetNextLevelFavor
DataModel.CalFoodOverflow = CalFoodOverflow
DataModel.UpdateFoodNum = UpdateFoodNum
DataModel.GetRoomIdAndPosx = GetRoomIdAndPosx
return DataModel
