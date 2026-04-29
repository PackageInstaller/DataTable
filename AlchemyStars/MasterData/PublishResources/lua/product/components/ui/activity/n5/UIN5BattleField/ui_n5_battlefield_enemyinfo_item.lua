_class("UIN5BattleFieldEnemyInfoItem", UICustomWidget)
UIN5BattleFieldEnemyInfoItem = UIN5BattleFieldEnemyInfoItem

function UIN5BattleFieldEnemyInfoItem:OnShow(uiParams)
  self:_GetComponents()
end

function UIN5BattleFieldEnemyInfoItem:_GetComponents()
  self._indexText = self:GetUIComponent("UILocalizationText", "Index")
  self._militaryExpliot = self:GetUIComponent("UILocalizationText", "MilitaryExpliot")
  self._enemyMsg = self:GetUIComponent("UISelectObjectPath", "Enemy")
  self._animation = self:GetGameObject():GetComponent("Animation")
end

function UIN5BattleFieldEnemyInfoItem:SetData(index, totalIndex, waveId, cfg_conquest_level_wave)
  self._index = index
  self._indexTotal = totalIndex
  self._waveId = waveId
  self._cfg_conquest_level_wave = cfg_conquest_level_wave
  self:_SetEnemyList()
  self:_PlayAnimation()
end

function UIN5BattleFieldEnemyInfoItem:_PlayAnimation()
  self:StartTask(function(TT)
    YIELD(TT, (self._index - 1) * 33)
    self._animation:Play("uieff_N5_Level_Info_Enemy_Item_In")
  end, self)
end

function UIN5BattleFieldEnemyInfoItem:_SetEnemyList()
  self._indexText:SetText(self._index .. "/" .. self._indexTotal)
  self._militaryExpliot:SetText(self._cfg_conquest_level_wave.WaveFirstPassAward[2])
  self._enemyWidget = self._enemyMsg:SpawnObject("UIN5BattleFieldEnemyMsg")
  local monsterIds = self:_GetMonsterIDs()
  self._enemyWidget:SetData(monsterIds, self._index == 1)
end

function UIN5BattleFieldEnemyInfoItem:_GetMonsterIDs()
  local ids = {}
  if self._waveId then
    ids = self:_UniqueBookShowClassId()
  else
    Log.error(string.format("battlefield enemy info error. waveId: %d", self._waveId))
  end
  return ids
end

function UIN5BattleFieldEnemyInfoItem:_UniqueClassIdElementType()
  local classId_elementType = {}
  
  local function callBack(monsterId)
    local cfgMonster = Cfg.cfg_monster[monsterId]
    if cfgMonster ~= nil and cfgMonster.ClassID > 0 then
      if not classId_elementType[cfgMonster.ClassID] then
        classId_elementType[cfgMonster.ClassID] = {}
        if not classId_elementType[cfgMonster.ClassID][cfgMonster.ElementType] then
          classId_elementType[cfgMonster.ClassID][cfgMonster.ElementType] = {}
        end
      end
      classId_elementType[cfgMonster.ClassID][cfgMonster.ElementType] = cfgMonster
    end
  end
  
  local cfgWave = Cfg.cfg_monster_wave[self._waveId]
  if cfgWave then
    local cfgRefresh = Cfg.cfg_refresh[cfgWave.WaveBeginRefreshID]
    local refreshIdList = cfgRefresh.MonsterRefreshIDList
    for key, value in pairs(refreshIdList) do
      local cfgRefreshMonster = Cfg.cfg_refresh_monster[value].MonsterIDList
      if cfgRefreshMonster then
        for key1, value1 in pairs(cfgRefreshMonster) do
          callBack(value1)
        end
      end
    end
  end
  return classId_elementType
end

function UIN5BattleFieldEnemyInfoItem:_UniqueBookShowClassId()
  local monsters = self:_UniqueClassIdElementType()
  local newMonsters = {}
  for key, datas in pairs(monsters) do
    for key, cfg in pairs(datas) do
      table.insert(newMonsters, cfg)
    end
  end
  local newMonsters2 = {}
  local keys = {}
  for index, value in ipairs(newMonsters) do
    local cfg = Cfg.cfg_monster_class[value.ClassID]
    if not newMonsters2[cfg.bookShowClassId] then
      newMonsters2[cfg.bookShowClassId] = value
      table.insert(keys, cfg.bookShowClassId)
    end
  end
  local a = {}
  for key, data in pairs(newMonsters2) do
    table.insert(a, data)
  end
  table.sort(a, function(a, b)
    local classIdA = a.ClassID
    local classIdB = b.ClassID
    local clsA = Cfg.cfg_monster_class[classIdA]
    local clsB = Cfg.cfg_monster_class[classIdB]
    local isBossA = clsA.MonsterType == 2 and 1 or 0
    local isBossB = clsB.MonsterType == 2 and 1 or 0
    if isBossA == isBossB then
      local isBodyAreaA = #clsA.Area
      local isBodyAreaB = #clsB.Area
      if isBodyAreaA == isBodyAreaB then
        return clsA.ID > clsB.ID
      else
        return isBodyAreaA > isBodyAreaB
      end
    else
      return isBossA > isBossB
    end
  end)
  local newMonsterIds = {}
  local count = table.count(newMonsters2)
  if 5 < count then
    count = 5
  end
  for i = 1, count do
    table.insert(newMonsterIds, a[i].ID)
  end
  return newMonsterIds
end
