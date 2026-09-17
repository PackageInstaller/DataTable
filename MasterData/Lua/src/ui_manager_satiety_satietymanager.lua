local this = class("satietyManager")
local foodTpl = L_GameTpl:getFoodTpl()
local homeBuildingTpl = L_GameTpl:getHomeBuildingTpl()

function this:getSatietyPetList(buildingGuid)
  local serverData = L_HomeStore:getHomeBuildingByGuid(buildingGuid)
  if not serverData then
    return {}
  end
  local petList = {}
  local buildingTpl = homeBuildingTpl:getTplById(serverData.build_id)
  local slotNum = homeBuildingTpl:getSlotNumber(buildingTpl)
  local hasFeedingPet = serverData.pet_canteen ~= nil and serverData.pet_canteen.pets ~= nil
  for i = 1, slotNum do
    local isEmpty = true
    if hasFeedingPet then
      local pet = serverData.pet_canteen.pets[i]
      if pet then
        isEmpty = false
        table.insert(petList, {
          petGuid = pet.pet_guid,
          lastTime = pet.last_time,
          isAdd = false,
          buildingGuid = buildingGuid
        })
      end
    end
    if isEmpty then
      table.insert(petList, {isAdd = true, buildingGuid = buildingGuid})
    end
  end
  return petList
end

function this:getFoodList()
  local allItem = C_BagMgr:getAllItem()
  local commonItemTpl = L_GameTpl:getCommonItemTpl()
  local all = {}
  local item
  for _, v in pairs(allItem) do
    local tpl = commonItemTpl:getTplById(v.itemId, true)
    if tpl then
      local type = commonItemTpl:getType(tpl)
      if type == L_BagConst.bagItemType.food then
        local fTpl = foodTpl:getTplById(v.itemId)
        if not fTpl then
          errorf("itemId: " .. v.itemId .. " subId: " .. v.itemId .. " 在food表里面找不到")
        elseif not math.isEmpty(foodTpl:getSatietyScore(fTpl)) then
          item = L_ItemTplManager:getItemConfig(L_Const.resType.commonItem, v.itemId)
          table.insert(all, {
            itemId = v.itemId,
            itemNum = v.itemNum,
            itemName = item.name,
            itemType = L_Const.resType.commonItem,
            itemSubId = v.itemId,
            deadTime = v.deadTime,
            satietyScore = foodTpl:getSatietyScore(fTpl)
          })
        end
      end
    end
  end
  table.sort(all, function(a, b)
    if a.satietyScore == b.satietyScore then
      return a.itemId < b.itemId
    end
    return a.satietyScore > b.satietyScore
  end)
  return all
end

function this:getBuildingSatiety(buildingGuid)
  local serverData = L_HomeStore:getHomeBuildingByGuid(buildingGuid)
  if not serverData then
    return 0, 0
  end
  local tpl = homeBuildingTpl:getTplById(serverData.build_id)
  local maxMangerScore = homeBuildingTpl:getTrough(tpl)
  if serverData.pet_canteen == nil or serverData.pet_canteen.foods == nil then
    return 0, maxMangerScore
  end
  local currentScore = 0
  for _, food in pairs(serverData.pet_canteen.foods) do
    local fTpl = foodTpl:getTplById(food.itemid)
    if not fTpl then
      errorf("itemId: " .. food.itemid .. " subId: " .. food.itemid .. " 在food表里面找不到")
    else
      currentScore = currentScore + foodTpl:getSatietyScore(fTpl) * food.itemnum
    end
  end
  return currentScore, maxMangerScore
end

function this:getMaxFoodCanUse(buildingGuid, itemId)
  if not itemId then
    return 0
  end
  local hadNum = C_BagMgr:getItemNumByItemId(itemId)
  local currentScore, maxScore = self:getBuildingSatiety(buildingGuid)
  local leftScore = maxScore - currentScore
  local fTpl = foodTpl:getTplById(itemId)
  if not fTpl then
    errorf("itemId: " .. food.itemId .. " subId: " .. food.itemId .. " 在food表里面找不到")
    return 0
  else
    local addScore = foodTpl:getSatietyScore(fTpl)
    return math.min(hadNum, math.floor(leftScore / addScore))
  end
end

function this:getMaxFoodCanDelete(buildingGuid, itemId)
  if not itemId then
    return 0
  end
  local serverData = L_HomeStore:getHomeBuildingByGuid(buildingGuid)
  if not (serverData and serverData.pet_canteen) or not serverData.pet_canteen.foods then
    return 0
  end
  for _, food in pairs(serverData.pet_canteen.foods) do
    if food.itemId == itemId then
      return food.itemnum
    end
  end
  return 0
end

function this:getFoodCosume(petGuid)
  local petHomeTalentTpl = L_GameTpl:getPetHomeTalentTpl()
  local petData = L_PetStore:getPetItem(petGuid)
  local talentTpl = petHomeTalentTpl:getTplById(petData.petId)
  return petHomeTalentTpl:getFeedConsume(talentTpl)
end

function this:isBuildingHasPetEating(buildingGuid)
  local serverData = L_HomeStore:getHomeBuildingByGuid(buildingGuid)
  if not serverData then
    return false
  end
  if serverData.pet_canteen == nil or serverData.pet_canteen.pets == nil then
    return false
  end
  for _, pet in ipairs(serverData.pet_canteen.pets) do
    if L_SatietyStore:isEating(pet.pet_guid) then
      return true
    end
  end
  return false
end

function this:getCurTotalSatiety()
  local guidList = L_HomeStore:getHomeBuildingUidsByGroupId(L_HomeConst.HomeBuildGroupID.PET_DINING_TABLE)
  if table.isEmpty(guidList) then
    return 0
  end
  local total = 0
  for _, buildingGuid in ipairs(guidList) do
    local currentScore, maxScore = self:getBuildingSatiety(buildingGuid)
    total = total + currentScore
  end
  return total
end

return this
