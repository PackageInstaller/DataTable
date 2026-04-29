_class("LuckLandBuildDataLevel", Object)
LuckLandBuildDataLevel = LuckLandBuildDataLevel

function LuckLandBuildDataLevel:Constructor(missionID)
  self._drawCount = 4
  self._buildDatas = {}
  self._missionID = missionID
end

function LuckLandBuildDataLevel:_InitBuilds(missionID)
  self._missionCfg = Cfg.cfg_luckland_client_mission[missionID]
  if self._missionCfg and self._missionCfg.BuildList then
    for i = 1, #self._missionCfg.BuildList do
      self:AddBuildData(self._missionCfg.BuildList[i])
    end
  end
end

function LuckLandBuildDataLevel:Cfg()
  return self._missionCfg
end

function LuckLandBuildDataLevel:Reset()
  table.clear(self._buildDatas)
  self:_InitBuilds(self._missionID)
end

function LuckLandBuildDataLevel:AddBuildData(id)
  table.insert(self._buildDatas, LuckLandBuildData:New(id))
end

function LuckLandBuildDataLevel:TotalCount()
  return table.count(self._buildDatas)
end

function LuckLandBuildDataLevel:GetBuildDataByIndex(index)
  return self._buildDatas[index]
end

function LuckLandBuildDataLevel:GetBuildDataByID(id)
  for _, buildData in pairs(self._buildDatas) do
    if buildData:ID() == id then
      return buildData
    end
  end
  return nil
end

function LuckLandBuildDataLevel:MainBuildLevel()
  for _, buildData in pairs(self._buildDatas) do
    if buildData:Type() == LuckLandBuildingType.Main then
      return buildData:GetCurLevel(), buildData
    end
  end
  return 0, nil
end

function LuckLandBuildDataLevel:CampFireBuildLevel()
  for _, buildData in pairs(self._buildDatas) do
    if buildData:Type() == LuckLandBuildingType.CampFire then
      return buildData:GetCurLevel(), buildData
    end
  end
  return 0, nil
end

function LuckLandBuildDataLevel:DrawCards()
  local level, mainBuildData = self:MainBuildLevel()
  if level <= 0 or not mainBuildData then
    return
  end
  local cfg = mainBuildData:Cfg()
  local cardPool = cfg.CardPool
  if not cardPool then
    Log.exception("There is no corresponding card pool for buildings of this level", mainBuildData:ID(), level)
    return
  end
  local resultIDs = {}
  local totalWight = 0
  local wightArray = {}
  for _, cardPoolID in pairs(cardPool) do
    local cardPoolCfg = Cfg.cfg_luckland_client_card_pool[cardPoolID]
    if cardPoolCfg then
      local t = {}
      t.wight = {
        totalWight,
        totalWight + cardPoolCfg.Wight
      }
      t.cards = cardPoolCfg.Cards
      table.insert(wightArray, t)
      totalWight = totalWight + cardPoolCfg.Wight
    end
  end
  for i = 1, self._drawCount do
    local cards
    local randomWight = math.random(1, totalWight)
    for j = 1, #wightArray do
      if randomWight > wightArray[j].wight[1] and randomWight <= wightArray[j].wight[2] then
        cards = wightArray[j].cards
        break
      end
    end
    if cards then
      local tempCards = {}
      local curCardDatas = LuckLandData:GetInstance():CurCardDatas()
      for _, id in pairs(cards) do
        local cfg = Cfg.cfg_luckland_client_card[id]
        if cfg then
          if cfg.IsUnique and cfg.IsUnique == 1 then
            if curCardDatas and not curCardDatas:ContainPet(id) then
              table.insert(tempCards, id)
            end
          else
            table.insert(tempCards, id)
          end
        end
      end
      table.insert(resultIDs, self:_DrawCardInPool(tempCards, resultIDs))
    end
  end
  local tempTable = {}
  for _, cardID in pairs(resultIDs) do
    table.insert(tempTable, UILuckLandCardData:New(nil, cardID))
  end
  return tempTable
end

function LuckLandBuildDataLevel:_DrawCardInPool(IDs, filterIDs)
  if #IDs < self._drawCount then
    Log.fatal("Insufficient card pool")
  end
  
  local function contain(id)
    if filterIDs then
      for _, filterID in pairs(filterIDs) do
        if filterID == id then
          return true
        end
      end
    end
    return false
  end
  
  local t = {}
  for _, ID in pairs(IDs) do
    if not contain(ID) then
      table.insert(t, ID)
    end
  end
  if 1 <= #t then
    return t[math.random(1, #t)]
  end
  return nil
end
