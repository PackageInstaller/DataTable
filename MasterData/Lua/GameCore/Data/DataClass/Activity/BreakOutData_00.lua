local BreakOutData_00 = class("BreakOutData_00")

function BreakOutData_00:AddListeners()
end

function BreakOutData_00:RefreshBreakOutData(tableData)
  self.ActEnd = true
  if tableData ~= nil then
    self:CacheAllLevelData(tableData)
  end
end

function BreakOutData_00:CacheAllLevelData(levelListData)
  self.tbLevelDataList = {}
  for _, v in pairs(levelListData) do
    local levelData = {
      nId = v,
      nDifficultyType = ConfigTable.GetData("BreakOutLevel", v).Type,
      nPreLevelId = ConfigTable.GetData("BreakOutLevel", v).PreLevelId
    }
    table.insert(self.tbLevelDataList, levelData)
  end
end

function BreakOutData_00:GetLevelData()
  return self.tbLevelDataList
end

function BreakOutData_00:GetLevelDataById(nId)
  local levelData
  for _, v in pairs(self.tbLevelDataList) do
    if v.nId == nId then
      levelData = v
      break
    end
  end
  return levelData
end

function BreakOutData_00:GetDetailLevelDataById(nId)
  local levelData
  for _, v in pairs(self.tbLevelDataList) do
    if v.nId == nId then
      levelData = ConfigTable.GetData("BreakOutLevel", nId)
      break
    end
  end
  return levelData
end

function BreakOutData_00:GetLevelsByTab(nTabIndex)
  local levelData = {}
  for _, v in pairs(self.tbLevelDataList) do
    if v.nDifficultyType == nTabIndex then
      table.insert(levelData, ConfigTable.GetData("BreakOutLevel", v.nId))
    end
  end
  
  local function sortFunc(a, b)
    local aConfig = ConfigTable.GetData("BreakOutLevel", a.Id)
    local bConfig = ConfigTable.GetData("BreakOutLevel", b.Id)
    return aConfig.Difficulty < bConfig.Difficulty
  end
  
  table.sort(levelData, sortFunc)
  return levelData
end

function BreakOutData_00:GetBreakoutLevelTypeNum()
  local nNum = 0
  for _, _ in pairs(GameEnum.ActivityBreakoutLevelType) do
    nNum = nNum + 1
  end
  return nNum
end

function BreakOutData_00:GetBreakoutPreLevelIdName(nLevelId)
  local LevelData = ConfigTable.GetData("BreakOutLevel", nLevelId)
  if LevelData == nil then
    return
  else
    local nPreLevelId = ConfigTable.GetData("BreakOutLevel", nLevelId).PreLevelId
    local PreLevelIdName = ConfigTable.GetData("BreakOutLevel", nPreLevelId).Name
    return PreLevelIdName
  end
end

function BreakOutData_00:GetBreakoutLevelDifficult(nLevelId)
  local LevelData = ConfigTable.GetData("BreakOutLevel", nLevelId)
  if LevelData == nil then
    return
  else
    return LevelData.Type
  end
end

function BreakOutData_00:IsActTimeEnd()
  local isEnd = false
  local LevelEndTime = CS.ClientManager.Instance:ISO8601StrToTimeStamp(ConfigTable.GetConfigValue("BreakOut_LevelClosed"))
  local nCurTime = CS.ClientManager.Instance.serverTimeStamp
  if LevelEndTime ~= nil then
    return LevelEndTime < nCurTime
  else
    printError("config 表：" .. "BreakOut_LevelClosed" .. " Value数据为空")
  end
  return isEnd
end

function BreakOutData_00:GetLevelStartTime(nLevelId)
  local mapData = self:GetDetailLevelDataById(nLevelId)
  if mapData == nil then
    return nil
  end
  local curTime = CS.ClientManager.Instance.serverTimeStamp
  local openTime = CS.ClientManager.Instance:GetNextRefreshTime(self.nOpenTime) - 86400
  local remainTime = openTime + mapData.DayOpen * 86400 - curTime
  return remainTime
end

return BreakOutData_00
