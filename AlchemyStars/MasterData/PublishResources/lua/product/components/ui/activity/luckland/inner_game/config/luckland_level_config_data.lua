_class("LLLevelConfigData", Object)
LLLevelConfigData = LLLevelConfigData

function LLLevelConfigData:Constructor(configMng)
  self._configMng = configMng
end

function LLLevelConfigData:ParseLevelConfig(levelID)
  self._levelID = levelID
  local levelConfigData = Cfg.cfg_luckland_client_mission[levelID]
  if not levelConfigData then
    Log.exception("[LuckLand] ParseLevelConfig not find levelID = ", levelID)
    return
  end
  self._levelRoundCount = levelConfigData.GameRound
  self._initGold = levelConfigData.InitMoney
  self._initMaxHP = levelConfigData.MaxHp
  self._buildingList = levelConfigData.BuildList
  self._backpackPetList = levelConfigData.InitCardBagList
  self._monsterList = self:_ParseMonsters(levelConfigData.EnemyList)
  self._roundHardRateList = levelConfigData.RoundHardRate
  self._reDrawCostRate = levelConfigData.ReDrawCostRate or 1
  self._deleteCostRate = levelConfigData.DeleteCostRate or 1
  self._affixList = levelConfigData.AffixList
end

function LLLevelConfigData:_ParseMonsters(roundMonsterStrArray)
  local monsterList = {}
  for _, strVal in ipairs(roundMonsterStrArray) do
    local strArray = string.split(strVal, "|")
    if #strArray < 3 then
      Log.exception("[LuckLand] ParseRoundMonsters size error, roundMonsters = ", strVal)
      return
    end
    local round = tonumber(strArray[1])
    local monsterID = tonumber(strArray[2])
    local money = tonumber(strArray[3])
    local monsterData = LLLevelConfigMonsterData:New(monsterID, round, money)
    monsterList[#monsterList + 1] = monsterData
  end
  return monsterList
end

function LLLevelConfigData:GetLevelID()
  return self._levelID
end

function LLLevelConfigData:GetLevelRoundCount()
  return self._levelRoundCount
end

function LLLevelConfigData:GetInitGold()
  return self._initGold
end

function LLLevelConfigData:GetInitMaxHP()
  return self._initMaxHP
end

function LLLevelConfigData:GetBuildingList()
  return self._buildingList
end

function LLLevelConfigData:GetBackpackPetList()
  return self._backpackPetList
end

function LLLevelConfigData:GetMonsterList()
  return self._monsterList
end

function LLLevelConfigData:GetHardRateByRound(roundCount)
  local count = #self._roundHardRateList
  if roundCount > count then
    return self._roundHardRateList[count]
  end
  return self._roundHardRateList[roundCount]
end

function LLLevelConfigData:GetReDrawCostRate()
  return self._reDrawCostRate
end

function LLLevelConfigData:GetDeleteCostRate()
  return self._deleteCostRate
end

function LLLevelConfigData:GetAffixList()
  return self._affixList
end

_class("LLLevelConfigMonsterData", Object)
LLLevelConfigMonsterData = LLLevelConfigMonsterData

function LLLevelConfigMonsterData:Constructor(id, round, money)
  self.id = id
  self.round = round
  self.money = money
end
