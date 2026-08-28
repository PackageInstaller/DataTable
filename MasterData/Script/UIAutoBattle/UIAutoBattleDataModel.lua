local DataModel = {
  sKeepCardNumMax = 12,
  weightPosX = {
    w1 = -290,
    w2 = -145,
    w3 = 0,
    w4 = 145,
    w5 = 290
  },
  DefaultValue = {
    discardType = 1,
    keepCardNum = 0,
    otherCard = 0,
    isLeaderCardOn = true,
    isSpCardOn = false
  },
  CurrentData = {},
  tempCardData = {
    id = -1,
    useType = 1,
    useParam = -1,
    targetType = 0
  },
  Data = {},
  DataIndex = 1,
  IsAutoBattleOn = false,
  IsChanged = false,
  teamKey = "",
  roleList = {},
  defaultColorWeight = {
    Blue = 1,
    Red = 2,
    Green = 3,
    Yellow = 4,
    Purple = 5,
    Orange = 6
  }
}

function DataModel:AddCardBySKillId(curData, skillId, unitId, skillIndex, equipId)
  local cardIdMap = curData.cardIdMap
  local cardList = curData.cardList
  local isChange = false
  local skillCA = PlayerData:GetFactoryData(skillId)
  if skillCA.cardID and skillCA.cardID > 0 then
    local cardId = tostring(skillCA.cardID)
    if DataModel:IsBlackCard(cardId) then
      local deriveCardList = skillCA.ExSkillList
      for i = 1, #deriveCardList do
        local ownerId = deriveCardList[i].isNeturality and 10000001 or unitId
        local rt = DataModel:AddCardBySKillId(curData, deriveCardList[i].ExSkillName, ownerId, nil, equipId)
        if isChange ~= true and rt == true then
          isChange = rt
        end
      end
      return isChange
    end
    if cardIdMap[cardId] == nil then
      table.insert(cardList, {
        skillIndex = skillIndex,
        ownerId = unitId,
        id = cardId,
        skillId = skillId,
        useType = DataModel.tempCardData.useType,
        useParam = DataModel.tempCardData.useParam,
        targetType = DataModel.tempCardData.targetType,
        equipIdList = {equipId}
      })
      cardIdMap[cardId] = 1
    else
      cardIdMap[cardId] = cardIdMap[cardId] + 1
      if equipId ~= nil then
        for i = 1, #cardList do
          if cardList[i].id == cardId then
            if cardList[i].equipIdList == nil then
              cardList[i].equipIdList = {}
            end
            local hasEquip = false
            for j = 1, #cardList[i].equipIdList do
              if cardList[i].equipIdList[j] == equipId then
                hasEquip = true
              end
            end
            if hasEquip ~= true then
              table.insert(cardList[i].equipIdList, equipId)
            else
              cardIdMap[cardId] = cardIdMap[cardId] - 1
            end
          end
        end
      end
    end
    isChange = true
    if cardIdMap[cardId] ~= nil and 50 < cardIdMap[cardId] then
      return isChange
    end
  end
  local deriveCardList = skillCA.ExSkillList
  for i = 1, #deriveCardList do
    local ownerId = deriveCardList[i].isNeturality and 10000001 or unitId
    local rt = DataModel:AddCardBySKillId(curData, deriveCardList[i].ExSkillName, ownerId, nil, equipId)
    if isChange ~= true and rt == true then
      isChange = rt
    end
  end
  return isChange
end

function DataModel:IsBlackCard(cardId)
  local cardCA = PlayerData:GetFactoryData(cardId)
  for i = 1, #cardCA.tagList do
    if tonumber(cardCA.tagList[i].tagId) == 12600037 then
      return true
    end
  end
  return false
end

function DataModel:RemoveCardBySKillId(curData, skillId, equipId, removeAll)
  local cardIdMap = curData.cardIdMap
  local cardList = curData.cardList
  local skillCA = PlayerData:GetFactoryData(skillId)
  if skillCA.cardID and skillCA.cardID > 0 then
    local cardId = tostring(skillCA.cardID)
    if cardIdMap[cardId] ~= nil then
      cardIdMap[cardId] = cardIdMap[cardId] - 1
      if cardIdMap[cardId] <= 0 or removeAll then
        cardIdMap[cardId] = nil
      end
    end
    if equipId then
      for i = 1, #cardList do
        if cardList[i].id == cardId then
          local eidList = cardList[i].equipIdList
          for j = #eidList, 1, -1 do
            if eidList[j] == equipId then
              table.remove(eidList, j)
            end
          end
          break
        end
      end
    end
    if cardIdMap[cardId] == nil then
      for i = 1, #cardList do
        if cardList[i].id == cardId then
          table.remove(cardList, i)
          break
        end
      end
    end
  end
  local deriveCardList = skillCA.ExSkillList
  for i = 1, #deriveCardList do
    DataModel:RemoveCardBySKillId(curData, deriveCardList[i].ExSkillName, equipId, not deriveCardList[i].isNeturality)
  end
end

function DataModel:AddCardsByUnitId(curData, unitId)
  if unitId == nil or unitId <= 0 then
    return
  end
  local skillList = PlayerData:GetCardDes(unitId)
  for i = 1, #skillList do
    local skillId = skillList[i].id
    DataModel:AddCardBySKillId(curData, skillId, unitId, i)
  end
end

function DataModel:RemoveCardsByUnitId(curData, unitId)
  if unitId == nil or unitId <= 0 then
    return
  end
  local skillList = PlayerData:GetCardDes(unitId)
  for i = 1, #skillList do
    local skillId = skillList[i].id
    DataModel:RemoveCardBySKillId(curData, skillId, nil, true)
  end
end

function DataModel:ExchangeSkill(curData, skillIndex, newSkillId, ownerId)
  local newSkillCA = PlayerData:GetFactoryData(newSkillId)
  local newCardId = tostring(newSkillCA.cardID)
  local cardIdMap = curData.cardIdMap
  local cardList = curData.cardList
  local isChange = false
  for i = 1, #cardList do
    if cardList[i].ownerId == ownerId and cardList[i].skillIndex == skillIndex and cardList[i].id ~= newCardId then
      cardIdMap[newCardId] = cardIdMap[cardList[i].id]
      cardIdMap[cardList[i].id] = 0
      cardList[i].id = newCardId
      isChange = true
      break
    end
  end
  return isChange
end

function DataModel:CheckCardList(curData, roleList)
  local cardList = curData.cardList
  local curOwnerMap = {}
  for i = 1, #cardList do
    curOwnerMap[cardList[i].ownerId] = true
  end
  local isChange = false
  local newOwnerMap = {}
  for i = 1, #roleList do
    newOwnerMap[roleList[i]] = true
    if curOwnerMap[roleList[i]] ~= true then
      DataModel:AddCardsByUnitId(curData, roleList[i])
      isChange = true
    end
  end
  for k, v in pairs(curOwnerMap) do
    if k ~= 10000001 and newOwnerMap[k] ~= true then
      DataModel:RemoveCardsByUnitId(curData, k)
      isChange = true
    end
  end
  return isChange
end

function DataModel:CheckEquipCard(curData, roleList)
  local cardList = curData.cardList
  local curEquipMap = {}
  for i = 1, #cardList do
    if cardList[i].equipIdList ~= nil then
      for j = 1, #cardList[i].equipIdList do
        local eId = cardList[i].equipIdList[j]
        curEquipMap[eId] = true
      end
    end
  end
  local isChange = false
  local newEquipMap = {}
  for i = 1, #roleList do
    if DataModel.teamKey == "RandomBattle" then
      local randomBattleDataModel = require("UIRandomLevel/UIRandomLevelDataModel")
      local role = randomBattleDataModel.rbData.choice[tostring(roleList[i])]
      if role.eid ~= nil then
        for k, v in pairs(role.eid) do
          local equipId = k
          newEquipMap[equipId] = true
          if curEquipMap[equipId] ~= true then
            isChange = DataModel:AddCardsByEquipId(curData, equipId, roleList[i])
          end
        end
      end
    else
      local role = PlayerData:GetRoleById(roleList[i])
      if role.equips ~= nil then
        for j = 1, #role.equips do
          if role.equips[j] ~= nil and role.equips[j] ~= "" then
            local equipData = PlayerData.ServerData.equipments.equips[role.equips[j]]
            local equipId = equipData.id
            newEquipMap[equipId] = true
            if curEquipMap[equipId] ~= true then
              isChange = DataModel:AddCardsByEquipId(curData, equipId, roleList[i])
            end
          end
        end
      end
    end
  end
  for k, v in pairs(curEquipMap) do
    if newEquipMap[k] ~= true then
      DataModel:RemoveCardsByEquipId(curData, k)
      isChange = true
    end
  end
  return isChange
end

function DataModel:AddCardsByEquipId(curData, equipId, roleId)
  if equipId == nil or equipId == "" then
    return
  end
  local isChange = false
  local equipCA = PlayerData:GetFactoryData(equipId)
  for i = 1, #equipCA.skillList do
    local skillId = equipCA.skillList[i].skillId
    local rt = DataModel:AddCardBySKillId(curData, skillId, 10000001, nil, equipId)
    if rt == true and isChange ~= true then
      isChange = rt
    end
  end
  return isChange
end

function DataModel:RemoveCardsByEquipId(curData, equipId)
  if equipId == nil or equipId == "" then
    return
  end
  local equipCA = PlayerData:GetFactoryData(equipId)
  for i = 1, #equipCA.skillList do
    local skillId = equipCA.skillList[i].skillId
    DataModel:RemoveCardBySKillId(curData, skillId, equipId)
  end
end

function DataModel:SortCardByColor(curData, colorWeight)
  local cardList = curData.cardList
  local defaultWeight = table.count(colorWeight) + 1
  table.sort(cardList, function(e1, e2)
    local ca1 = PlayerData:GetFactoryData(e1.id)
    local ca2 = PlayerData:GetFactoryData(e2.id)
    local w1 = colorWeight[ca1.color] or defaultWeight
    local w2 = colorWeight[ca2.color] or defaultWeight
    if w1 ~= w2 then
      return w1 < w2
    else
      return e1.id < e2.id
    end
  end)
end

function DataModel:CheckDirtyCard(curData, roleList)
  local cardList = curData.cardList
  local cardMap = {}
  for i = 1, #roleList do
    DataModel:GetCardMapByRoleId(cardMap, roleList[i])
  end
  local isChange = false
  for i = #cardList, 1, -1 do
    local cardData = cardList[i]
    local cardId = cardData.id
    if cardId ~= "10600474" and cardId.ownerId ~= 10000001 and cardMap[cardId] ~= true then
      local cardCA = PlayerData:GetFactoryData(cardId)
      if cardCA.linkCardId ~= nil then
        for j = 1, #cardCA.linkCardId do
          local linkCardId = tostring(cardCA.linkCardId[j].Id)
          if cardMap[linkCardId] == true then
            isChange = true
            cardData.id = linkCardId
            curData.cardIdMap[linkCardId] = curData.cardIdMap[cardId]
            curData.cardIdMap[cardId] = nil
            goto lbl_66
          end
        end
      end
      isChange = true
      curData.cardIdMap[cardId] = nil
      table.remove(cardList, i)
    end
    ::lbl_66::
  end
  return isChange
end

function DataModel:GetCardMapByRoleId(cardMap, unitId)
  if unitId == nil or unitId <= 0 then
    return
  end
  local skillList = PlayerData:GetCardDes(unitId)
  for i = 1, #skillList do
    local skillId = skillList[i].id
    DataModel:GetCardMapBySkillId(cardMap, skillId)
  end
  if DataModel.teamKey == "RandomBattle" then
    local randomBattleDataModel = require("UIRandomLevel/UIRandomLevelDataModel")
    local role = randomBattleDataModel.rbData.choice[tostring(unitId)]
    if role.eid ~= nil then
      for k, v in pairs(role.eid) do
        local equipId = k
        DataModel:GetCardMapByEquipId(cardMap, equipId)
      end
    end
  else
    local role = PlayerData:GetRoleById(unitId)
    if role.equips ~= nil then
      for j = 1, #role.equips do
        if role.equips[j] ~= nil and role.equips[j] ~= "" then
          local equipData = PlayerData.ServerData.equipments.equips[role.equips[j]]
          local equipId = equipData.id
          DataModel:GetCardMapByEquipId(cardMap, equipId)
        end
      end
    end
  end
end

function DataModel:GetCardMapBySkillId(cardMap, skillId)
  local skillCA = PlayerData:GetFactoryData(skillId)
  if skillCA.cardID and skillCA.cardID > 0 then
    local cardId = tostring(skillCA.cardID)
    if cardMap[cardId] == true then
      return
    end
    if not DataModel:IsBlackCard(cardId) then
      cardMap[cardId] = true
      local cardCA = PlayerData:GetFactoryData(cardId)
      if cardCA.linkCardId ~= nil then
        for j = 1, #cardCA.linkCardId do
          local linkCardId = tostring(cardCA.linkCardId[j].Id)
          if cardMap[linkCardId] ~= true and not DataModel:IsBlackCard(cardId) then
            cardMap[linkCardId] = true
          end
        end
      end
    end
  end
  local deriveCardList = skillCA.ExSkillList
  for i = 1, #deriveCardList do
    DataModel:GetCardMapBySkillId(cardMap, deriveCardList[i].ExSkillName)
  end
end

function DataModel:GetCardMapByEquipId(cardMap, equipId)
  if equipId == nil or equipId == "" then
    return
  end
  local equipCA = PlayerData:GetFactoryData(equipId)
  for i = 1, #equipCA.skillList do
    local skillId = equipCA.skillList[i].skillId
    DataModel:GetCardMapBySkillId(cardMap, skillId)
  end
end

return DataModel
