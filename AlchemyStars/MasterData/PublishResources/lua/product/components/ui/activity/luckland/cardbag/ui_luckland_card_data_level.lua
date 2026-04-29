_class("UILuckLandCardDataLevel", Object)
UILuckLandCardDataLevel = UILuckLandCardDataLevel

function UILuckLandCardDataLevel:Constructor(missionID)
  self._uniqueID = 0
  self._cardDatas = {}
  self._missionID = missionID
end

function UILuckLandCardDataLevel:_InitAllCards(missionID, containBuilding)
  local tempList = {}
  
  local function insertFunc(cardID)
    if not table.icontains(tempList, cardID) then
      table.insert(tempList, cardID)
    end
  end
  
  self._missionCfg = Cfg.cfg_luckland_client_mission[missionID]
  if self._missionCfg then
    if self._missionCfg.InitCardBagList then
      for i = 1, #self._missionCfg.InitCardBagList do
        insertFunc(self._missionCfg.InitCardBagList[i])
      end
    end
    if self._missionCfg.BuildList and containBuilding then
      for _, buildingID in pairs(self._missionCfg.BuildList) do
        local buildingCfg = Cfg.cfg_luckland_client_build[buildingID]
        if buildingCfg and buildingCfg.BuildType == LuckLandBuildingType.Main then
          if buildingCfg.CardPool then
            for _, poolID in pairs(buildingCfg.CardPool) do
              local poolCfg = Cfg.cfg_luckland_client_card_pool[poolID]
              if poolCfg and poolCfg.Cards then
                for _, cardID in pairs(poolCfg.Cards) do
                  insertFunc(cardID)
                end
              end
            end
          end
          local maxLevel = buildingCfg.MaxLevel
          for i = buildingCfg.ID + 1, buildingCfg.ID + maxLevel - 1 do
            buildingCfg = Cfg.cfg_luckland_client_build[i]
            if buildingCfg and buildingCfg.BuildType == LuckLandBuildingType.Main and buildingCfg.CardPool then
              for _, poolID in pairs(buildingCfg.CardPool) do
                local poolCfg = Cfg.cfg_luckland_client_card_pool[poolID]
                if poolCfg and poolCfg.Cards then
                  for _, cardID in pairs(poolCfg.Cards) do
                    insertFunc(cardID)
                  end
                end
              end
            end
          end
        end
      end
    end
  end
  for i = 1, #tempList do
    self:AddCardData(tempList[i])
  end
end

function UILuckLandCardDataLevel:Reset(containBuilding)
  self._uniqueID = 0
  table.clear(self._cardDatas)
  self:_InitAllCards(self._missionID, containBuilding)
end

function UILuckLandCardDataLevel:TotalCount()
  return table.count(self._cardDatas)
end

function UILuckLandCardDataLevel:CurDeleteCost()
  return LuckLandInnerGameHelper.GetDeleteCardCost()
end

function UILuckLandCardDataLevel:GetCardDataByIndex(index)
  return self._cardDatas[index]
end

function UILuckLandCardDataLevel:GetCardDataByUniqueID(uniqueID)
  for _, cardData in pairs(self._cardDatas) do
    if cardData:UniqueID() == uniqueID then
      return cardData
    end
  end
  return nil
end

function UILuckLandCardDataLevel:AddCardData(id, uniqueID, pos)
  if not uniqueID then
    self._uniqueID = self._uniqueID + 1
    uniqueID = self._uniqueID
  end
  if pos then
    table.insert(self._cardDatas, pos, UILuckLandCardData:New(uniqueID, id))
  else
    table.insert(self._cardDatas, UILuckLandCardData:New(uniqueID, id))
  end
end

function UILuckLandCardDataLevel:DeleteCardByID(uniqueID)
  local count = table.count(self._cardDatas)
  if 1 < count then
    for _, cardData in pairs(self._cardDatas) do
      if cardData:UniqueID() == uniqueID then
        table.removev(self._cardDatas, cardData)
        return
      end
    end
  else
    Log.info("UILuckLandCardDataLevel delete card data error, keep at least one card.")
  end
end

function UILuckLandCardDataLevel:IsOnlyOne()
  return table.count(self._cardDatas) == 1
end

function UILuckLandCardDataLevel:DrawCard(datas)
  local function contain(data)
    if datas then
      for _, value in pairs(datas) do
        if value == data then
          return true
        end
      end
    end
    return false
  end
  
  local t = {}
  for _, cardData in pairs(self._cardDatas) do
    if not contain(cardData) then
      table.insert(t, cardData)
    end
  end
  if 1 <= #t then
    return t[math.random(1, #t)]
  end
  return nil
end

function UILuckLandCardDataLevel:Putback(cardDatas)
  if cardDatas then
    for _, cardData in pairs(cardDatas) do
      table.insert(self._cardDatas, cardData)
    end
  end
end

function UILuckLandCardDataLevel:Sort(comp)
  table.sort(self._cardDatas, comp)
end

function UILuckLandCardDataLevel:ResetAllCardDatasFromInnerGame(entityPets)
  table.clear(self._cardDatas)
  if entityPets then
    local count = #entityPets
    if 0 < count then
      for i = 1, count do
        local pet = entityPets[i]
        table.insert(self._cardDatas, UILuckLandCardData:New(pet:ID(), pet:GetTemplateID()))
      end
    end
  end
end

function UILuckLandCardDataLevel:ContainPet(templateID)
  if self._cardDatas then
    for _, data in pairs(self._cardDatas) do
      if data:ID() == templateID then
        return true
      end
    end
  end
  return false
end
