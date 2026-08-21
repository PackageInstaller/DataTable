_class("LuckLandModule", Object)
LuckLandModule = LuckLandModule

function LuckLandModule:Constructor()
  self._configMng = LLConfigMng:New()
  self._entityMng = LLEntityMng:New()
  self._buffMng = LLBuffMng:New()
  self._triggerMng = LLTriggerMng:New()
  self._maxHP = 0
  self._curHP = 0
  self._gold = 0
  self._atk = 0
  self._gameRound = 0
  self._posCount = 0
  self._curRound = 0
  self._isRunning = true
  self._drawCardPool = {}
  self._reDrawCount = 0
  self._delCardCount = 0
  self._drawCardResult = {}
  self._roundGold = 0
  self._roundAtk = 0
  self._roundRecover = 0
end

function LuckLandModule:Dispose()
  self._configMng:Dispose()
  self._configMng = nil
  self._entityMng:Dispose()
  self._entityMng = nil
  self._buffMng:Dispose()
  self._buffMng = nil
  self._triggerMng:Dispose()
  self._triggerMng = nil
end

function LuckLandModule:Init(missionID)
  self._configMng:Init(missionID)
  self._entityMng:Init(self)
  local levelCfgData = self._configMng:GetLevelConfigData()
  self._maxHP = levelCfgData:GetInitMaxHP() + self._entityMng:GetBuildingMaxHPIncrease()
  self._curHP = self._maxHP
  self._gold = levelCfgData:GetInitGold()
  self._gameRound = levelCfgData:GetLevelRoundCount()
  self._curRound = 1
  self._posCount = self._entityMng:GetPosCount()
  self._posList = self._entityMng:GetPosList()
  self._affixList = levelCfgData:GetAffixList()
end

function LuckLandModule:GetConfigMng()
  return self._configMng
end

function LuckLandModule:GetEntityMng()
  return self._entityMng
end

function LuckLandModule:GetBuffMng()
  return self._buffMng
end

function LuckLandModule:GetTriggerMng()
  return self._triggerMng
end

function LuckLandModule:RoundStart()
  self._curRound = self._curRound + 1
  self:ClearTmpData()
  local petIDs = self:GenFightPets()
  self:InitFightPets(petIDs)
  self:DoPetLogic()
  self:DoBuildingLogic()
  self:OnProduct()
end

function LuckLandModule:MonsterTurn()
  self:DoMonsterLogic()
end

function LuckLandModule:RoundEnd()
  self:DrawCard()
end

function LuckLandModule:ClearTmpData()
  self._roundGold = 0
  self._roundAtk = 0
  self._roundRecover = 0
  self._entityMng:DestroyEntity()
  self._entityMng:ClearEntityTmpData()
end

function LuckLandModule:GenFightPets()
  local backpackPets = self._entityMng:GetBackpackPets()
  local petIDList = {}
  for _, pet in ipairs(backpackPets) do
    table.insert(petIDList, pet:ID())
  end
  self._posCount = self._entityMng:GetPosCount()
  self._posList = self._entityMng:GetPosList()
  local randomIDResult = {}
  for i = 1, self._posCount do
    if 0 < #petIDList then
      local randVal = math.random(1, #petIDList)
      local randID = petIDList[randVal]
      randomIDResult[#randomIDResult + 1] = randID
      table.removev(petIDList, randID)
    end
  end
  return randomIDResult
end

function LuckLandModule:InitFightPets(petIDs)
  self._entityMng:ClearFightPets()
  for index, petID in ipairs(petIDs) do
    local pet = self._entityMng:GetPetByID(petID)
    pet:SetGenIndex(index)
    self._entityMng:AddFightPet(pet)
    self._triggerMng:Notify(LLNTPetEnter:New(pet))
  end
end

function LuckLandModule:DoPetLogic()
  local entityArray = {}
  table.appendArray(entityArray, self._entityMng:GetFightPets())
  table.appendArray(entityArray, self._entityMng:GetBuildings())
  table.appendArray(entityArray, self._entityMng:GetFightMonsters())
  for _, entity in ipairs(entityArray) do
    self._triggerMng:Notify(LLNTPetTurnStart:New(entity))
  end
  for _, entity in ipairs(entityArray) do
    self._triggerMng:Notify(LLNTPetTurn:New(entity))
  end
  for _, entity in ipairs(entityArray) do
    self._triggerMng:Notify(LLNTPetTurnEnd:New(entity))
  end
  local fightPets = self._entityMng:GetFightPets()
  for _, pet in ipairs(fightPets) do
    if not pet:HasDeleteFlag() then
      pet:CostCountDown()
      if pet:GetCountDown() == 0 then
        self._triggerMng:Notify(LLNTCountDown:New(pet))
        pet:ResetCountDown()
      end
    end
  end
  local backpackPets = self._entityMng:GetBackpackPets()
  local ids = {}
  for _, pet in ipairs(backpackPets) do
    table.insert(ids, pet:ID())
  end
  for _, id in ipairs(ids) do
    local pet = self._entityMng:GetPetByID(id)
    if pet and not pet:IsFight() then
      self._triggerMng:Notify(LLNTBackpackTurn:New(pet))
    end
  end
end

function LuckLandModule:GetAllBuildings()
  local buildList = {}
  local buildings = self._entityMng:GetBuildings()
  for _, entity in ipairs(buildings) do
    local id = entity:GetTemplateID()
    local level = id % 100
    buildList[id] = level
  end
  return buildList
end

function LuckLandModule:DoBuildingLogic()
  local buildings = self._entityMng:GetBuildings()
  for _, entity in ipairs(buildings) do
    self._triggerMng:Notify(LLNTBuildingTurn:New(entity))
  end
  for _, entity in ipairs(buildings) do
    entity:CostCountDown()
    if entity:GetCountDown() == 0 then
      self._triggerMng:Notify(LLNTCountDown:New(entity))
      entity:ResetCountDown()
    end
  end
end

function LuckLandModule:OnProduct()
  local prodEntityArray = {}
  table.appendArray(prodEntityArray, self._entityMng:GetFightPets())
  table.appendArray(prodEntityArray, self._entityMng:GetBuildings())
  for _, entity in ipairs(prodEntityArray) do
    if entity:GetResType() == LuckLandCardResType.Money then
      self._roundGold = self._roundGold + entity:CalculateRes()
    elseif entity:GetResType() == LuckLandCardResType.HP then
      self._roundRecover = self._roundRecover + entity:CalculateRes()
    elseif entity:GetResType() == LuckLandCardResType.Attack then
      self._roundAtk = self._roundAtk + entity:CalculateRes()
    end
    self._roundGold = self._roundGold + entity:GetDirectGold()
  end
  self:AddGold(self._roundGold)
  self:AddHP(self._roundRecover)
  self._atk = self._roundAtk
end

function LuckLandModule:DoPetAttack()
  local fightPets = self._entityMng:GetFightPets()
  local monsters = self._entityMng:GetFightMonsters()
  for _, monster in ipairs(monsters) do
    if not monster:IsDead() then
      local curHP = monster:GetCurHP()
      local subValue = curHP - self._atk
      if subValue < 0 then
        monster:SetCurHP(0)
        monster:SetDead(true)
        self._atk = math.abs(subValue)
        for _, pet in ipairs(fightPets) do
          if not pet:HasDeleteFlag() then
            self._triggerMng:Notify(LLNTDefeatMonster:New(pet, monster))
          end
        end
      else
        monster:SetCurHP(subValue)
        break
      end
    end
  end
end

function LuckLandModule:DoMonsterLogic()
  local monsters = self._entityMng:GetFightMonsters()
  for _, entity in ipairs(monsters) do
    self._triggerMng:Notify(LLNTMonsterTurnStart:New(entity))
  end
  for _, entity in ipairs(monsters) do
    self._triggerMng:Notify(LLNTMonsterTurn:New(entity))
  end
  for _, monster in ipairs(monsters) do
    if not monster:IsDead() then
      if monster:GetDemandRound() > 0 then
        monster:DecreaseDemandRound()
      else
        local money = monster:GetDemandMoney()
        if money <= self._gold then
          monster:DecreaseDemandMoney(money)
          monster:SetDead(true)
          self._gold = self._gold - money
          local nextMonster = self._entityMng:GetNextMonsters()
          self._entityMng:SetFightMonsters({monster, nextMonster}, self._curRound)
        else
          monster:DecreaseDemandMoney(self._gold)
          self._gold = 0
          self:ReduceHP(1)
        end
      end
    end
  end
end

function LuckLandModule:DrawCard()
  if not self._isRunning then
    return
  end
  table.clear(self._drawCardResult)
  local buildDataLevel = LuckLandData:GetInstance():CurBuildingDatas()
  if buildDataLevel then
    self._drawCardResult = buildDataLevel:DrawCards()
  end
end

function LuckLandModule:IsGoldEnough(costVal)
  return costVal <= self._gold
end

function LuckLandModule:AddGold(addVal)
  self._gold = self._gold + addVal
end

function LuckLandModule:CostGold(val)
  if val > self._gold then
    Log.fatal("[LuckLand] Gold is not enough, gold = ", self._gold, ", cost = ", val)
    return false
  end
  self._gold = self._gold - val
  return true
end

function LuckLandModule:GetGold()
  return self._gold
end

function LuckLandModule:GetCurHP()
  return self._curHP, self._maxHP
end

function LuckLandModule:AddMaxHp(addVal)
  self._maxHP = self._maxHP + addVal
end

function LuckLandModule:AddHP(addVal)
  self._curHP = self._curHP + addVal
  if self._curHP > self._maxHP then
    self._curHP = self._maxHP
  end
end

function LuckLandModule:ReduceHP(val)
  self._curHP = self._curHP - val
  if self._curHP < 0 then
    self._curHP = 0
    self._isRunning = false
  end
  return self._curHP
end

function LuckLandModule:CheckHasExtraDrawCard()
  local buildings = self._entityMng:GetBuildings()
  for _, building in ipairs(buildings) do
    if building:GetTempValue(LuckLandConst.BVK_ExtraDrawCard) then
      return true
    end
  end
  return false
end

function LuckLandModule:SelectCard(petTemplateID, pos)
  self._entityMng:SelectCard(petTemplateID, pos)
  if self:CheckHasExtraDrawCard() then
    self:DrawCard()
  else
    self._drawCardPool = {}
  end
end

function LuckLandModule:SkipSelectCard()
  if self:CheckHasExtraDrawCard() then
    self:DrawCard()
  else
    self._drawCardPool = {}
  end
end

function LuckLandModule:ResetReDrawCount()
  self._reDrawCount = 0
end

function LuckLandModule:GetReDrawCost()
  local reDrawCount = self._reDrawCount + 1
  local roundCount = self._curRound
  return self._configMng:GetReDrawCost(reDrawCount, roundCount)
end

function LuckLandModule:ReDrawCard()
  local reDrawCost = self:GetReDrawCost()
  if reDrawCost and self:CostGold(reDrawCost) then
    self._reDrawCount = self._reDrawCount + 1
    self:DrawCard()
  end
end

function LuckLandModule:BuildingUpgrade(buildingID)
  local building = self._entityMng:GetBuildingByID(buildingID)
  local costVal = building:GetUpgradeCost()
  if self:CostGold(costVal) then
    self._entityMng:BuildingUpgrade(building)
    self._triggerMng:Notify(LLNTBuildingUpgrade:New(building))
    local fightPets = self._entityMng:GetFightPets()
    for _, pet in ipairs(fightPets) do
      if not pet:HasDeleteFlag() then
        self._triggerMng:Notify(LLNTBuildingUpgrade:New(pet))
      end
    end
  end
end

function LuckLandModule:BuildingUpgradeDrawCard(buildtype)
  if buildtype == LuckLandBuildingType.Main then
    self:DrawCard()
  end
end

function LuckLandModule:GetDelCardCount()
  return self._delCardCount
end

function LuckLandModule:GetDeleteCardCost()
  local delCount = self._delCardCount + 1
  return self._configMng:GetDeleteCardCost(delCount)
end

function LuckLandModule:DeleteCard(petID)
  local delCost = self:GetDeleteCardCost()
  if delCost and self:CostGold(delCost) then
    self._delCardCount = self._delCardCount + 1
    self._entityMng:DeleteCard(petID)
  end
end

function LuckLandModule:GetDrawCardResult()
  return self._drawCardResult
end

function LuckLandModule:GetRoundProduction()
  return self._roundGold, self._roundAtk, self._roundRecover
end

function LuckLandModule:GetCurRoundCount()
  return self._curRound, self._gameRound
end

function LuckLandModule:PosList()
  return self._posList
end

function LuckLandModule:GetWords()
  return self._affixList
end

function LuckLandModule:RandomCards(poolList, count)
  local resultIDs = {}
  local totalWight = 0
  local wightArray = {}
  for _, cardPoolID in pairs(poolList) do
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
  for i = 1, count do
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
      table.insert(resultIDs, self:_DrawCardInPool(tempCards, resultIDs, count))
    end
  end
  local tempTable = {}
  for _, cardID in pairs(resultIDs) do
    table.insert(tempTable, UILuckLandCardData:New(nil, cardID))
  end
  return tempTable
end

function LuckLandModule:_DrawCardInPool(IDs, filterIDs, count)
  if count > #IDs then
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
