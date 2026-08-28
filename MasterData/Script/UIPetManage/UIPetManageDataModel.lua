local DataModel = {}
local PetConfigId = 99900022

local function GetGoodsNum(itemId)
  local goods = PlayerData:GetGoodsById(itemId)
  if goods then
    return goods.num or 0
  end
  local material = PlayerData:GetMaterials()[tostring(itemId)]
  return material and material.num or 0
end

local function SetGoodsNum(itemId, num)
  local goods = PlayerData:GetGoodsById(itemId)
  if goods then
    goods.num = num
  end
  local material = PlayerData:GetMaterials()[tostring(itemId)]
  if material then
    material.num = num
  end
  if DataModel.foodMap and DataModel.foodMap[tostring(itemId)] then
    DataModel.foodMap[tostring(itemId)].num = num
  end
end

local function RefreshFoodList()
  DataModel.foodList = {}
  DataModel.foodMap = {}
  local foodItemList = PlayerData:GetFactoryData(PetConfigId).foodItemList or {}
  for i, v in ipairs(foodItemList) do
    local itemId = tonumber(v.id) or v.id
    local data = {
      id = itemId,
      num = GetGoodsNum(itemId)
    }
    table.insert(DataModel.foodList, data)
    DataModel.foodMap[tostring(itemId)] = data
  end
end

local function GetHouseData(index)
  local furData = DataModel.petFurList[tonumber(index)]
  if not furData then
    return nil
  end
  local furniture = CommonCoachData.GetFurData()[furData.u_fid]
  if not furniture then
    return nil
  end
  return furniture, furData.u_fid, furData
end

local function GetDefaultFoodId()
  if not DataModel.foodList then
    RefreshFoodList()
  end
  if DataModel.foodList and DataModel.foodList[1] then
    return DataModel.foodList[1].id
  end
  return nil
end

local function GetSelectedFoodId(index)
  index = tonumber(index)
  if not index then
    return GetDefaultFoodId()
  end
  DataModel.foodIdList = DataModel.foodIdList or {}
  DataModel.selectFoodMap = DataModel.selectFoodMap or {}
  local foodId = DataModel.foodIdList[index]
  if foodId then
    return foodId
  end
  local furniture, ufid = GetHouseData(index)
  if not foodId then
    foodId = furniture and furniture.house and furniture.house.food_id
    if not foodId or foodId == "" then
      foodId = GetDefaultFoodId()
    end
    DataModel.foodIdList[index] = foodId
    if ufid then
      DataModel.selectFoodMap[ufid] = foodId
    end
  end
  return foodId
end

local function SetSelectedFoodId(index, foodId)
  index = tonumber(index)
  if not index then
    return
  end
  foodId = tonumber(foodId) or foodId
  DataModel.foodIdList = DataModel.foodIdList or {}
  DataModel.foodIdList[index] = foodId
  local furniture, ufid = GetHouseData(index)
  if not furniture then
    return
  end
  DataModel.selectFoodMap = DataModel.selectFoodMap or {}
  DataModel.selectFoodMap[ufid] = foodId
end

local function InitFoodFeedList()
  RefreshFoodList()
  DataModel.selectFoodMap = {}
  DataModel.foodIdList = {}
  DataModel.changeFoodIndex = nil
  for i, v in ipairs(DataModel.petFurList or {}) do
    local furniture = CommonCoachData.GetFurData()[v.u_fid]
    local foodId = furniture and furniture.house and furniture.house.food_id
    if not foodId or foodId == "" then
      foodId = GetDefaultFoodId()
    end
    DataModel.foodIdList[i] = foodId
    DataModel.selectFoodMap[v.u_fid] = foodId
  end
end

local function CalPetFurList()
  DataModel.petHouseCount = 0
  DataModel.roomCount = 0
  DataModel.petFurList = {}
  local serverFurniture = CommonCoachData.GetFurData()
  for k, v in pairs(serverFurniture) do
    local functionType = PlayerData:GetFactoryData(v.id).functionType
    if functionType == 12600464 and v.u_cid ~= "" then
      local pets = serverFurniture[k].house.pets
      DataModel.roomCount = DataModel.roomCount + PlayerData:GetFactoryData(v.id).PetNum
      local roomId = -1
      local posx = -1
      local fur_exist = false
      local roomList = PlayerData:GetHomeInfo().coach_template
      local coach_store = PlayerData:GetHomeInfo().coach_store
      if PlayerData.visitMode then
        roomList = PlayerData.visitInfo.coach_template
        coach_store = PlayerData.visitInfo.coach_store
      end
      local furniture = serverFurniture[k]
      for i, v1 in ipairs(roomList) do
        local cfgId = coach_store[v1].id
        local coachType = PlayerData:GetFactoryData(cfgId).coachType
        local tagCA = PlayerData:GetFactoryData(coachType)
        if not tagCA.stopCarriage then
          roomId = roomId + 1
          if v1 == furniture.u_cid then
            fur_exist = true
            posx = HomeManager.rooms[roomId]:GetFurniture(k).PosX
            break
          end
        end
      end
      if fur_exist then
        DataModel.petHouseCount = DataModel.petHouseCount + 1
        table.insert(DataModel.petFurList, {
          u_fid = k,
          pets = pets,
          roomId = roomId,
          posx = posx
        })
      end
    end
  end
  table.sort(DataModel.petFurList, function(t1, t2)
    if t1.roomId ~= t2.roomId then
      return t1.roomId < t2.roomId
    end
    return t1.posx < t2.posx
  end)
end

local function Init()
  CalPetFurList()
  local petList = PlayerData:GetHomeInfo().pet and PlayerData:GetHomeInfo().pet or {}
  if PlayerData.visitMode then
    petList = PlayerData.visitInfo.pets
  end
  DataModel.petList = {}
  DataModel.petInRoomCout = 0
  for k, v in pairs(petList) do
    table.insert(DataModel.petList, v)
    v.pet_uid = k
    if v.u_fid ~= "" then
      DataModel.petInRoomCout = DataModel.petInRoomCout + 1
    end
  end
  DataModel.favorUp = true
  DataModel.timeUp = true
  DataModel.favorFirst = {
    "favor",
    "obtain_time"
  }
  DataModel.timeFirst = {
    "obtain_time",
    "favor"
  }
  DataModel.petKindsList = PlayerData:GetFactoryData(99900022).petVarityList or {}
  DataModel.petKindsCount = #DataModel.petKindsList
  DataModel.selectKindList = {count = 0}
  DataModel.now_kinds = nil
  DataModel.SelectSortData(0)
  DataModel.SortData(DataModel.favorFirst)
  InitFoodFeedList()
end

local function SeletctParam(value)
  if value == "favor" then
    return DataModel.favorUp
  elseif value == "obtain_time" then
    return DataModel.timeUp
  end
  print("\229\143\130\230\149\176\228\184\141\229\173\152\229\156\168\239\188\129\239\188\129\239\188\129\239\188\129\239\188\129\239\188\129\239\188\129\239\188\129\239\188\129\239\188\129\239\188\129\239\188\129")
  return false
end

local function SortData(conditionList)
  table.sort(DataModel.sortData, function(t1, t2)
    for i, v in ipairs(conditionList) do
      local param = SeletctParam(v) and 1 or -1
      if t1[v] ~= t2[v] then
        if v == "favor" and t1.lv ~= t2.lv then
          return param * t1.lv > param * t2.lv
        end
        return param * t1[v] > param * t2[v]
      end
    end
    return t1.id > t2.id
  end)
end

local function SelectSortData()
  DataModel.sortData = {}
  local count = DataModel.selectKindList.count
  if count == 0 or count == DataModel.petKindsCount then
    DataModel.sortData = DataModel.petList
  else
    for k, v in pairs(DataModel.petList) do
      local kinds = PlayerData:GetFactoryData(v.id).petVarity
      if DataModel.selectKindList[kinds] then
        table.insert(DataModel.sortData, v)
      end
    end
  end
end

function DataModel.GetServerPetData()
  if PlayerData.visitMode then
    return PlayerData.visitInfo.pets
  end
  return PlayerData:GetHomeInfo().pet
end

DataModel.Init = Init
DataModel.SortData = SortData
DataModel.SelectSortData = SelectSortData
DataModel.RefreshFoodList = RefreshFoodList
DataModel.GetHouseData = GetHouseData
DataModel.GetSelectedFoodId = GetSelectedFoodId
DataModel.SetSelectedFoodId = SetSelectedFoodId
DataModel.InitFoodFeedList = InitFoodFeedList
DataModel.SetGoodsNum = SetGoodsNum
return DataModel
