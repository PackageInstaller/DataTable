local UICN7N36ScoreManagerType = {
  one = 8,
  Two = 9,
  Three = 10,
  Four = 11,
  Five = 12,
  Normal = 0
}
_enum("UICN7N36ScoreManagerType", UICN7N36ScoreManagerType)
local UICN7N36ItemBoundery = {
  up = 1,
  down = 2,
  left = 3,
  right = 4
}
_enum("UICN7N36ItemBoundery", UICN7N36ItemBoundery)
_class("UICN7N36ScoreManager", Object)
UICN7N36ScoreManager = UICN7N36ScoreManager

function UICN7N36ScoreManager:Constructor(GridManager, MissionID, MainGridWidth, MainGridHeight)
  self.GridManager = GridManager
  local MissionID = MissionID or 14
  local cfg = Cfg.cfg_season_debris_level[MissionID]
  self.map = cfg.ScoreMatrix
  self.maxX = MainGridHeight
  self.maxY = MainGridWidth
  self.specialID = {
    8,
    9,
    10,
    11,
    12
  }
end

function UICN7N36ScoreManager:GetTotalScore()
  local atomicItemIDMap = self.GridManager:GetMainGridItemMap()
  local valueTable = {}
  local totalScore = 0
  for atomicItemID, value in pairs(atomicItemIDMap) do
    local posTable = value.blockList
    local id = value.itemID
    local score = 0
    if not table.icontains(self.specialID, id) then
      self.cfg = Cfg.cfg_season_debris_item[id]
      score = self.cfg.Score
    else
      local baseScore, extraScore
      baseScore, extraScore = self:_CalculateSpecialItem(id, posTable)
      score = baseScore + extraScore
    end
    table.insert(valueTable, score)
  end
  for _, score in ipairs(valueTable) do
    totalScore = totalScore + score
  end
  return math.floor(totalScore)
end

function UICN7N36ScoreManager:GetItemScore(id, posTable)
  local Id = id
  local score = 0
  if not table.icontains(self.specialID, Id) then
    self.cfg = Cfg.cfg_season_debris_item[Id]
    score = self.cfg.Score
  else
    local baseScore, extraScore
    baseScore, extraScore = self:_CalculateSpecialItem(id, posTable)
    score = baseScore + extraScore
  end
  return math.floor(score)
end

function UICN7N36ScoreManager:GetSpecialItemScore(id, posTable)
  local Id = id
  local baseScore, extraScore
  if not table.icontains(self.specialID, Id) then
    self.cfg = Cfg.cfg_season_debris_item[Id]
    extraScore = nil
  else
    baseScore, extraScore = self:_CalculateSpecialItem(id, posTable)
    extraScore = math.floor(extraScore)
  end
  return extraScore
end

function UICN7N36ScoreManager:_CalculateSpecialItem(id, posTable)
  local allValue = {}
  local extraScore = 0
  self.id = id
  self.cfg = Cfg.cfg_season_debris_item[self.id]
  local baseScore = self.cfg.Score
  self.itemscore = {
    [UICN7N36ScoreManagerType.Three] = {
      [UICN7N36ItemBoundery.up] = false,
      [UICN7N36ItemBoundery.down] = false,
      [UICN7N36ItemBoundery.left] = false,
      [UICN7N36ItemBoundery.right] = false
    },
    [UICN7N36ScoreManagerType.Five] = {
      [UICN7N36ItemBoundery.up] = false,
      [UICN7N36ItemBoundery.down] = false,
      [UICN7N36ItemBoundery.left] = false,
      [UICN7N36ItemBoundery.right] = false
    }
  }
  for _, pos in ipairs(posTable) do
    local x = pos._row
    local y = pos._col
    local ItemValue = self:CalculateScore(x, y)
    table.insert(allValue, ItemValue)
  end
  for index, value in ipairs(allValue) do
    extraScore = extraScore + value
  end
  return baseScore, extraScore
end

function UICN7N36ScoreManager:CalculateScore(x, y)
  self.posX = x
  self.posY = y
  self.item = self.GridManager:GetMainMatrixWidget(self.posX, self.posY)
  self.atomicItemID = self.item:GetAtomicItemID()
  local specialScore = self:GetItemSpecialScore()
  return specialScore, self.itemscore
end

function UICN7N36ScoreManager:GetItemSpecialScore()
  local specialScore = 0
  if self.id == UICN7N36ScoreManagerType.one then
    specialScore = self:GetSpecialOne()
  elseif self.id == UICN7N36ScoreManagerType.Two then
    specialScore = self:GetSpecialTwo()
  elseif self.id == UICN7N36ScoreManagerType.Three then
    specialScore = self:GetSpecialThree()
  elseif self.id == UICN7N36ScoreManagerType.Four then
    specialScore = self:GetSpecialFour()
  elseif self.id == UICN7N36ScoreManagerType.Five then
    specialScore = self:GetSpecialFive()
  end
  return specialScore
end

function UICN7N36ScoreManager:GetSpecialOne()
  local score = 0
  local around = {}
  local x, y = self.posX - 1, self.posY
  if x <= 0 then
  else
    local centerEmpty, edgeEmpty, Occupy, ID, atomicItemID = self:CheckItem(x, y)
    if not centerEmpty and not edgeEmpty and Occupy then
      table.insert(around, atomicItemID)
    end
  end
  x, y = self.posX + 1, self.posY
  if x > self.maxX then
  else
    local centerEmpty, edgeEmpty, Occupy, ID, atomicItemID = self:CheckItem(x, y)
    if not centerEmpty and not edgeEmpty and Occupy and not table.icontains(around, atomicItemID) then
      table.insert(around, atomicItemID)
    end
  end
  x, y = self.posX, self.posY - 1
  if y <= 0 then
  else
    local centerEmpty, edgeEmpty, Occupy, ID, atomicItemID = self:CheckItem(x, y)
    if not centerEmpty and not edgeEmpty and Occupy and not table.icontains(around, atomicItemID) then
      table.insert(around, atomicItemID)
    end
  end
  x, y = self.posX, self.posY + 1
  if y > self.maxY then
  else
    local centerEmpty, edgeEmpty, Occupy, ID, atomicItemID = self:CheckItem(x, y)
    if not centerEmpty and not edgeEmpty and Occupy and not table.icontains(around, atomicItemID) then
      table.insert(around, atomicItemID)
    end
  end
  score = #around
  return score
end

function UICN7N36ScoreManager:GetSpecialTwo()
  local score = 0
  local x, y = self.posX - 1, self.posY
  if x <= 0 then
  else
    local centerEmpty, edgeEmpty, Occupy, ID, atomicItemID = self:CheckItem(x, y)
    if not centerEmpty and not edgeEmpty and not Occupy then
      score = score + 1
    end
  end
  x, y = self.posX + 1, self.posY
  if x > self.maxX then
  else
    local centerEmpty, edgeEmpty, Occupy, ID, atomicItemID = self:CheckItem(x, y)
    if not centerEmpty and not edgeEmpty and not Occupy then
      score = score + 1
    end
  end
  x, y = self.posX, self.posY - 1
  if y <= 0 then
  else
    local centerEmpty, edgeEmpty, Occupy, ID, atomicItemID = self:CheckItem(x, y)
    if not centerEmpty and not edgeEmpty and not Occupy then
      score = score + 1
    end
  end
  x, y = self.posX, self.posY + 1
  if y > self.maxY then
  else
    local centerEmpty, edgeEmpty, Occupy, ID, atomicItemID = self:CheckItem(x, y)
    if not centerEmpty and not edgeEmpty and not Occupy then
      score = score + 1
    end
  end
  return score
end

function UICN7N36ScoreManager:GetSpecialThree()
  local score = 0
  local type = UICN7N36ScoreManagerType.Three
  local x, y = self.posX - 1, self.posY
  local boundery = UICN7N36ItemBoundery.up
  if not self.itemscore[type][boundery] then
    if x <= 0 then
      score = score + 1
      self.itemscore[type][boundery] = true
    else
      local centerEmpty, edgeEmpty, Occupy, ID, atomicItemID = self:CheckItem(x, y)
      if edgeEmpty then
        score = score + 1
        self.itemscore[type][boundery] = true
      end
    end
  end
  x, y = self.posX + 1, self.posY
  local boundery = UICN7N36ItemBoundery.down
  if not self.itemscore[type][boundery] then
    if x > self.maxX then
      score = score + 1
      self.itemscore[type][boundery] = true
    else
      local centerEmpty, edgeEmpty, Occupy, ID, atomicItemID = self:CheckItem(x, y)
      if edgeEmpty then
        score = score + 1
        self.itemscore[type][boundery] = true
      end
    end
  end
  x, y = self.posX, self.posY - 1
  local boundery = UICN7N36ItemBoundery.left
  if not self.itemscore[type][boundery] then
    if y <= 0 then
      score = score + 1
      self.itemscore[type][boundery] = true
    else
      local centerEmpty, edgeEmpty, Occupy, ID, atomicItemID = self:CheckItem(x, y)
      if edgeEmpty then
        score = score + 1
        self.itemscore[type][boundery] = true
      end
    end
  end
  x, y = self.posX, self.posY + 1
  local boundery = UICN7N36ItemBoundery.right
  if not self.itemscore[type][boundery] then
    if y > self.maxY then
      score = score + 1
      self.itemscore[type][boundery] = true
    else
      local centerEmpty, edgeEmpty, Occupy, ID, atomicItemID = self:CheckItem(x, y)
      if edgeEmpty then
        score = score + 1
        self.itemscore[type][boundery] = true
      end
    end
  end
  return score
end

function UICN7N36ScoreManager:GetSpecialFour()
  local score = 0
  local x, y = self.posX - 1, self.posY
  if x <= 0 then
  else
    local centerEmpty, edgeEmpty, Occupy, ID, atomicItemID = self:CheckItem(x, y)
    if not centerEmpty and not edgeEmpty and not Occupy then
      score = score + 1
    end
  end
  x, y = self.posX + 1, self.posY
  if x > self.maxX then
  else
    local centerEmpty, edgeEmpty, Occupy, ID, atomicItemID = self:CheckItem(x, y)
    if not centerEmpty and not edgeEmpty and not Occupy then
      score = score + 1
    end
  end
  x, y = self.posX, self.posY - 1
  if y <= 0 then
  else
    local centerEmpty, edgeEmpty, Occupy, ID, atomicItemID = self:CheckItem(x, y)
    if not centerEmpty and not edgeEmpty and not Occupy then
      score = score + 1
    end
  end
  x, y = self.posX, self.posY + 1
  if y > self.maxY then
  else
    local centerEmpty, edgeEmpty, Occupy, ID, atomicItemID = self:CheckItem(x, y)
    if not centerEmpty and not edgeEmpty and not Occupy then
      score = score + 1
    end
  end
  local otherScore = self:CheckOther()
  return score + otherScore
end

function UICN7N36ScoreManager:GetSpecialFive()
  local score = 0
  local around = {}
  local type = UICN7N36ScoreManagerType.Five
  local x, y = self.posX - 1, self.posY
  local boundery = UICN7N36ItemBoundery.up
  if self.itemscore[type][boundery] or x <= 0 then
  else
    local centerEmpty, edgeEmpty, Occupy, ID, atomicItemID = self:CheckItem(x, y)
    if not centerEmpty and not edgeEmpty and Occupy and ID == UICN7N36ScoreManagerType.Five and self.atomicItemID ~= atomicItemID then
      table.insert(around, atomicItemID)
      self.itemscore[type][boundery] = true
    end
  end
  x, y = self.posX + 1, self.posY
  local boundery = UICN7N36ItemBoundery.down
  if self.itemscore[type][boundery] or x > self.maxX then
  else
    local centerEmpty, edgeEmpty, Occupy, ID, atomicItemID = self:CheckItem(x, y)
    if not centerEmpty and not edgeEmpty and Occupy and ID == UICN7N36ScoreManagerType.Five and self.atomicItemID ~= atomicItemID and not table.icontains(around, atomicItemID) then
      table.insert(around, atomicItemID)
      self.itemscore[type][boundery] = true
    end
  end
  x, y = self.posX, self.posY - 1
  local boundery = UICN7N36ItemBoundery.left
  if self.itemscore[type][boundery] or y <= 0 then
  else
    local centerEmpty, edgeEmpty, Occupy, ID, atomicItemID = self:CheckItem(x, y)
    if not centerEmpty and not edgeEmpty and Occupy and ID == UICN7N36ScoreManagerType.Five and self.atomicItemID ~= atomicItemID and not table.icontains(around, atomicItemID) then
      table.insert(around, atomicItemID)
      self.itemscore[type][boundery] = true
    end
  end
  x, y = self.posX, self.posY + 1
  local boundery = UICN7N36ItemBoundery.right
  if self.itemscore[type][boundery] or y > self.maxY then
  else
    local centerEmpty, edgeEmpty, Occupy, ID, atomicItemID = self:CheckItem(x, y)
    if not centerEmpty and not edgeEmpty and Occupy and ID == UICN7N36ScoreManagerType.Five and self.atomicItemID ~= atomicItemID and not table.icontains(around, atomicItemID) then
      table.insert(around, atomicItemID)
      self.itemscore[type][boundery] = true
    end
  end
  self.cfg = Cfg.cfg_season_debris_item[self.id]
  local baseScore = self.cfg.Score
  local multiple = #around
  if multiple == 0 then
    score = 0
  else
    score = baseScore ^ multiple
  end
  return score
end

function UICN7N36ScoreManager:_GetItemData(x, y)
  local upItem = self.GridManager:GetMainMatrixWidget(x, y)
  local Occupy = upItem:GetIsOccupy()
  local ID = upItem:GetItemID()
  local atomicItemID = upItem:GetAtomicItemID()
  return Occupy, ID, atomicItemID
end

function UICN7N36ScoreManager:CheckItem(x, y)
  local centerEmpty, edgeEmpty = self:CheckItemEmpty(x, y)
  local Occupy, ID, atomicItemID = self:_GetItemData(x, y)
  return centerEmpty, edgeEmpty, Occupy, ID, atomicItemID
end

function UICN7N36ScoreManager:CheckOther()
  local value = 0
  local x, y
  x = self.posX - 1
  y = self.posY - 1
  if 0 < x and 0 < y then
    local Occupy, ID, atomicItemID = self:_GetItemData(x, y)
    local centerEmpty, edgeEmpty = self:CheckItemEmpty(x, y)
    if not centerEmpty and not edgeEmpty and not Occupy then
      value = value + 1
    end
  end
  x = self.posX + 1
  y = self.posY - 1
  if x <= self.maxX and 0 < y then
    local Occupy, ID, atomicItemID = self:_GetItemData(x, y)
    local centerEmpty, edgeEmpty = self:CheckItemEmpty(x, y)
    if not centerEmpty and not edgeEmpty and not Occupy then
      value = value + 1
    end
  end
  x = self.posX - 1
  y = self.posY + 1
  if 0 < x and y <= self.maxY then
    local Occupy, ID, atomicItemID = self:_GetItemData(x, y)
    local centerEmpty, edgeEmpty = self:CheckItemEmpty(x, y)
    if not centerEmpty and not edgeEmpty and not Occupy then
      value = value + 1
    end
  end
  x = self.posX + 1
  y = self.posY + 1
  if x <= self.maxX and y <= self.maxY then
    local Occupy, ID, atomicItemID = self:_GetItemData(x, y)
    local centerEmpty, edgeEmpty = self:CheckItemEmpty(x, y)
    if not centerEmpty and not edgeEmpty and not Occupy then
      value = value + 1
    end
  end
  return value
end

function UICN7N36ScoreManager:CheckItemEmpty(x, y)
  local center = false
  local edge = false
  if self.map[x][y] == 2 then
    center = true
  end
  if self.map[x][y] == 0 then
    edge = true
  end
  return center, edge
end
