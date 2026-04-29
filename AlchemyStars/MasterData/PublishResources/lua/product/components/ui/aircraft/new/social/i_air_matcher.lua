_class("IAirMatcher", Object)
IAirMatcher = IAirMatcher

function IAirMatcher:Match(pets)
end

_class("InitAreaMatcher", IAirMatcher)
InitAreaMatcher = InitAreaMatcher

function InitAreaMatcher:Match(pets, airMain)
  local areas = {}
  for _, pet in pairs(pets) do
    local area = AirHelper.GetArea(pet, areas, airMain)
    if area then
      area:AddPet(pet:TemplateID(), pet)
    end
  end
  return areas
end

_class("RelationMatcher", IAirMatcher)
RelationMatcher = RelationMatcher

function RelationMatcher:Match(areas)
  if not areas or #areas <= 0 then
    return {}
  end
  local newAreas = {}
  for index, area in ipairs(areas) do
    local pets = area:GetPets()
    local count = table.count(pets)
    if 1 < count then
      local match = true
      local closer, farAwayer = AirHelper.GetCloserAndFarAwayer(pets)
      if count == 2 then
        for petTempId, farPetTempIds in pairs(farAwayer) do
          if 0 < #farPetTempIds then
            match = false
          end
        end
      elseif 3 <= count then
        local graph = graph:New()
        graph:Clear()
        local petTempIds = {}
        for petTempId, value in pairs(pets) do
          graph:AddVertex(petTempId)
          table.insert(petTempIds, petTempId)
        end
        for petTempId, closerPetTempIds in pairs(closer) do
          for index, value in ipairs(closerPetTempIds) do
            if not farAwayer[value] or not table.ikey(farAwayer[value], petTempId) then
              graph:AddDirectedEdge(petTempId, value)
            end
          end
        end
        for i = 1, count do
          local list = graph:BFSTraverse(i)
          local finalCount = #list
          if finalCount == 3 then
            break
          end
          if finalCount == 2 then
            for index, petTempId in ipairs(petTempIds) do
              if not table.ikey(list, petTempId) then
                area:RemovePet(petTempId)
              end
            end
          elseif 3 < finalCount then
            local index = math.random(1, 2)
            local middle = math.floor(finalCount * 0.5)
            if index == 1 then
              for j = middle, finalCount do
                area:RemovePet(list[j])
              end
              break
            elseif index == 2 then
              for j = 1, middle do
                area:RemovePet(list[j])
              end
              break
            end
          end
        end
      end
      if match then
        table.insert(newAreas, area)
      end
    end
  end
  return newAreas
end

_class("AddLibMatcher", IAirMatcher)
AddLibMatcher = AddLibMatcher

function AddLibMatcher:Match(areas, main)
  if not areas or #areas <= 0 then
    return {}
  end
  local newAreas = {}
  for index, area in ipairs(areas) do
    local matchFurniture, pets = self:MatchFurniture(area, main)
    if matchFurniture ~= nil then
      area:AddLib(AirSocialActionType.Furniture)
      area:SetFurniture(matchFurniture, pets)
      table.insert(newAreas, area)
    else
      local pets = area:GetPets()
      local count = table.count(pets)
      if count == 2 then
        area:AddLib(AirSocialActionType.Gather)
        area:AddLib(AirSocialActionType.WalkTalk)
        table.insert(newAreas, area)
      elseif 3 <= count then
        area:AddLib(AirSocialActionType.Gather)
        table.insert(newAreas, area)
      end
    end
  end
  return newAreas
end

function AddLibMatcher:MatchFurniture(area, main)
  local f2Pet = {}
  local pets = area:GetPets()
  for key, pet in pairs(pets) do
    local fs = pet:GetInteractFurnitures()
    for index, data in ipairs(fs) do
      local furnitureType = data[1]
      if not f2Pet[furnitureType] then
        f2Pet[furnitureType] = {}
      end
      table.insert(f2Pet[furnitureType], pet)
    end
  end
  local room = area:GetRoom()
  if not room then
    Log.error("AddLibMatcher:MatchFurniture why no room!!!!!!!!!!!!!")
    return nil
  end
  local fs = main:GetFurnituresBySpace(room:SpaceID())
  local newFurnitureTypes = {}
  for furnitureType, value in pairs(fs) do
    if f2Pet[furnitureType] and 2 <= #f2Pet[furnitureType] then
      table.insert(newFurnitureTypes, furnitureType)
    end
  end
  local filterFurnitures = {}
  for index, furnitureType in ipairs(newFurnitureTypes) do
    local furniture = main:GetFurniture(furnitureType)
    if furniture and 2 <= furniture:AvailableCount() then
      table.insert(filterFurnitures, furniture)
    end
  end
  local count = table.count(filterFurnitures)
  if 1 <= count then
    local r = math.random(1, count)
    local betterFurniture = filterFurnitures[r]
    return betterFurniture, betterFurniture and f2Pet[betterFurniture:Type()] or nil
  else
    return nil, nil, nil
  end
end

_class("FilterLibMatcher", IAirMatcher)
FilterLibMatcher = FilterLibMatcher

function FilterLibMatcher:Match(areas)
  if not areas or #areas <= 0 then
    return {}
  end
  for _, area in ipairs(areas) do
    local libs = area:GetLibs()
    local count = table.count(libs)
    if 1 < count then
      local r = math.random(1, count)
      local keys = table.keys(libs)
      for index = 1, count do
        if index ~= r then
          area:RemoveLib(keys[index])
        end
      end
    end
  end
  return areas
end

_class("FilterLibPetMatcher", IAirMatcher)
FilterLibPetMatcher = FilterLibPetMatcher

function FilterLibPetMatcher:Match(areas)
  if not areas or #areas <= 0 then
    return {}
  end
  for _, area in ipairs(areas) do
    if area:GetFurniture() then
    else
      local pets = area:GetPets()
      local count = table.count(pets)
      if count <= 2 then
      else
        local targetNum = math.random(2, 3)
        local randomTime = count - targetNum
        if 0 < randomTime then
          local r = {}
          while true do
            local d = math.random(1, count)
            if not table.icontains(r, d) then
              table.insert(r, d)
            end
            if #r == randomTime then
              break
            end
          end
          local keys = table.keys(pets)
          for index = 1, count do
            if table.icontains(r, index) then
              area:RemovePet(keys[index])
            end
          end
        end
      end
    end
  end
  return areas
end

_class("FilterAreaMatcher", IAirMatcher)
FilterAreaMatcher = FilterAreaMatcher

function FilterAreaMatcher:Match(areas)
  local filterAreas = {}
  if not areas or #areas == 0 then
    return filterAreas
  end
  local count = #areas
  if 2 < count then
    local _idx1 = math.random(1, count)
    local _idx2 = -1
    while true do
      local r = math.random(1, count)
      if r ~= _idx1 then
        _idx2 = r
        break
      end
    end
    table.insert(filterAreas, areas[_idx1])
    table.insert(filterAreas, areas[_idx2])
    return filterAreas
  else
    filterAreas = areas
  end
  return filterAreas
end

_class("InitLibMakerMatcher", IAirMatcher)
InitLibMakerMatcher = InitLibMakerMatcher

function InitLibMakerMatcher:Match(areas)
  if not areas or #areas <= 0 then
    return {}
  end
  for index, _area in ipairs(areas) do
    local area = _area
    area:InitLibMaker()
  end
  return areas
end
