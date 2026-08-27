local base = require("Game.ActivitySectorII.MainMap.Data.SectorIISectorLevelData")
local SectorIIISectorLevelData = class("SectorIIISectorIIILevelData", base)
local ExplorationEnum = require("Game.Exploration.ExplorationEnum")

function SectorIIISectorLevelData.GenSectorIIIMapDatas(sectorId)
  local mapDataList = {}
  local isolatedDataList = {}
  local firstLevel
  
  local function Add2List(cfg, isStage)
    local mapData
    if isStage then
      local stageExtra = ConfigData.activity_summer_warchess_pos[sectorId][cfg.id]
      mapData = SectorIIISectorLevelData.CreateSectorIIIEPLevelData(sectorId, cfg, stageExtra)
    else
      local avgExtra = ConfigData.activity_summer_warchess_story_pos[sectorId][cfg.id]
      if avgExtra == nil then
        error(string.format("cant get activity_summer_warchess_story_pos cfg, sectorId:%s, stageId:%s", sectorId, cfg.id))
      end
      mapData = SectorIIISectorLevelData.CreateSectorIIIStoryLevelData(sectorId, cfg, avgExtra)
    end
    if firstLevel == nil then
      firstLevel = mapData
    end
    return mapData
  end
  
  local avgPlayCtrl = ControllerManager:GetController(ControllerTypeId.AvgPlay, true)
  local sectorStageCfg = ConfigData.sector_stage.sectorDiffDic[sectorId][ExplorationEnum.eDifficultType.Normal]
  local lastLevelData
  local levelMapDic = {}
  for _, stageId in ipairs(sectorStageCfg) do
    local stage = ConfigData.sector_stage[stageId]
    local levelMapData = Add2List(stage, true)
    local isIsolated = ConfigData.activity_summer_warchess_pos[sectorId][stageId].is_isolated
    if levelMapData ~= nil then
      levelMapDic[stageId] = levelMapData
      if lastLevelData ~= nil then
        levelMapData:AddAParentSIILevel(lastLevelData)
        lastLevelData:AddAChildSIILevel(levelMapData)
      end
      lastLevelData = levelMapData
    end
  end
  for _, stageId in ipairs(sectorStageCfg) do
    local levelMapData = levelMapDic[stageId]
    if levelMapData ~= nil then
      local para2num = avgPlayCtrl:GetMainAvgPara2Num(stageId, 1)
      for i = 0, para2num - 1 do
        local avgCfg = avgPlayCtrl:TryGetAvgCfg(eAvgTriggerType.MainAvg, stageId, 1, i)
        if avgCfg ~= nil then
          local preLevelMapData = Add2List(avgCfg, false)
          if preLevelMapData ~= nil then
            levelMapData:SwiftParent2SIILevel(preLevelMapData)
            levelMapData:AddAParentSIILevel(preLevelMapData)
            preLevelMapData:AddAChildSIILevel(levelMapData)
          end
        end
      end
      local para2num = avgPlayCtrl:GetMainAvgPara2Num(stageId, 2)
      for i = 0, para2num - 1 do
        local avgCfg = avgPlayCtrl:TryGetAvgCfg(eAvgTriggerType.MainAvg, stageId, 2, i)
        if avgCfg ~= nil then
          local afterLevelMapData = Add2List(avgCfg, false)
          if afterLevelMapData ~= nil then
            local childList = levelMapData:GetSIILevelChildList()
            if childList ~= nil then
              for _, chidLevelData in pairs(levelMapData:GetSIILevelChildList()) do
                chidLevelData:ReplaceSIILevelParent(levelMapData, afterLevelMapData)
                afterLevelMapData:AddAChildSIILevel(chidLevelData)
              end
            end
            afterLevelMapData:AddAParentSIILevel(levelMapData)
            levelMapData:CleanSIILevelChildList()
            levelMapData:AddAChildSIILevel(afterLevelMapData)
          end
        end
      end
    end
  end
  table.insert(mapDataList, firstLevel)
  local curLevelData = firstLevel
  while curLevelData ~= nil do
    local preList = curLevelData:GetSIILevelParentList()
    curLevelData = preList ~= nil and preList[1] or nil
    if curLevelData ~= nil then
      table.insert(mapDataList, 1, curLevelData)
    end
  end
  curLevelData = firstLevel
  while curLevelData ~= nil do
    local lastList = curLevelData:GetSIILevelChildList()
    curLevelData = lastList ~= nil and lastList[1] or nil
    if curLevelData ~= nil then
      table.insert(mapDataList, curLevelData)
    end
  end
  table.insertto(mapDataList, isolatedDataList)
  return mapDataList
end

function SectorIIISectorLevelData.CreateSectorIIIEPLevelData(sectorId, warchessLevelDetailCfg, stageExtrCfg)
  local data = SectorIIISectorLevelData.New()
  data.isBattle = true
  data.stageCfg = warchessLevelDetailCfg
  data.stageId = warchessLevelDetailCfg.id
  data.isClear = false
  data.isUnlock = CheckCondition.CheckLua(data.stageCfg.pre_condition, data.stageCfg.pre_para1, data.stageCfg.pre_para2)
  data.stageExtrCfg = stageExtrCfg
  local posCfg = data.stageExtrCfg.stage_pos
  data.pos = Vector2.New(posCfg[1], posCfg[2])
  data.linePos = Vector2.New(posCfg[1] - 1, posCfg[2] - 31)
  data.is_isolated = data.stageExtrCfg.is_isolated
  data.isSideStage = data.stageExtrCfg.is_side
  return data
end

function SectorIIISectorLevelData.CreateSectorIIIStoryLevelData(sectorId, avgCfg, avgExtrCfg)
  local data = SectorIIISectorLevelData.New()
  data.sectorId = sectorId
  data.isBattle = false
  data.avgCfg = avgCfg
  data.avgId = avgCfg.id
  local avgPlayCtrl = ControllerManager:GetController(ControllerTypeId.AvgPlay)
  data.isClear = avgPlayCtrl:IsAvgPlayed(data.avgId)
  data.isUnlock = avgPlayCtrl:IsAvgUnlock(data.avgId)
  data.avgExtrCfg = avgExtrCfg
  local posCfg = data.avgExtrCfg.story_pos
  data.pos = Vector2.New(posCfg[1], posCfg[2])
  data.linePos = Vector2.New(posCfg[1] - 1, posCfg[2] - 31)
  data.is_isolated = data.avgExtrCfg.is_isolated
  return data
end

function SectorIIISectorLevelData:IsSectorIIIStageIsolated()
  return self.is_isolated
end

return SectorIIISectorLevelData
