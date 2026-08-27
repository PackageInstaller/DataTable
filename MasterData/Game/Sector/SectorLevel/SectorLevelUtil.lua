local SectorLevelUtil = {}

function SectorLevelUtil.GenSectorLevels(sectorDiffList)
end

function SectorLevelUtil.GenRoadLayout(cfg, arrangeCfg, stageId, isState, avgPlayCtrl, isMerge, splitPage, preStages, dynInteractArgs)
  local layoutId = arrangeCfg[1].typeId
  local layoutCapacity = #arrangeCfg
  if dynInteractArgs.finalPage == nil then
    dynInteractArgs.finalPage = 1
  end
  if dynInteractArgs.layourDic == nil then
    dynInteractArgs.layourDic = {}
  end
  if isMerge then
    dynInteractArgs.finalPage = dynInteractArgs.finalPage + 1
    if dynInteractArgs.layourDic[layoutId] ~= nil then
      dynInteractArgs.layourDic[layoutId].curPage = dynInteractArgs.finalPage
    end
  end
  if splitPage ~= nil then
    local curPage = splitPage + 1
    if curPage > dynInteractArgs.finalPage then
      dynInteractArgs.finalPage = curPage
    end
    if dynInteractArgs.layourDic[layoutId] ~= nil then
      dynInteractArgs.layourDic[layoutId].curPage = curPage
    else
      dynInteractArgs.layourDic[layoutId] = {
        curPage = curPage,
        data = {
          [curPage] = {}
        }
      }
    end
  end
  local layoutContent = dynInteractArgs.layourDic[layoutId]
  if layoutContent == nil then
    layoutContent = {
      curPage = dynInteractArgs.finalPage,
      data = {
        [dynInteractArgs.finalPage] = {}
      }
    }
    dynInteractArgs.layourDic[layoutId] = layoutContent
  end
  if layoutContent.data[layoutContent.curPage] ~= nil and layoutCapacity <= #layoutContent.data[layoutContent.curPage] then
    layoutContent.curPage = layoutContent.curPage + 1
    layoutContent.data[layoutContent.curPage] = {}
    if layoutContent.curPage > dynInteractArgs.finalPage then
      dynInteractArgs.finalPage = layoutContent.curPage
    end
  end
  local curPage = layoutContent.curPage
  local layoutContentData = layoutContent.data[curPage]
  if layoutContentData == nil then
    layoutContentData = {}
    layoutContent.data[curPage] = layoutContentData
  end
  local tab = {}
  tab.connecId = stageId
  tab.preStages = preStages
  if isState then
    tab.stageCfg = cfg
    dynInteractArgs._sectorStageIdGroupMapping[cfg.id] = curPage
  else
    tab.avgCfg = cfg
    dynInteractArgs._sectorAvgIdGroupMapping[cfg.id] = curPage
  end
  table.insert(layoutContentData, tab)
  if ConfigData.sector_stage.afterMulDic[stageId] ~= nil then
    if dynInteractArgs.splitPointPage == nil then
      dynInteractArgs.splitPointPage = {}
    end
    dynInteractArgs.splitPointPage[stageId] = layoutContent.curPage
  end
  if isState and PlayerDataCenter.sectorStage:IsStageComplete(cfg.id) or not isState and avgPlayCtrl:IsAvgPlayed(cfg.id) then
    dynInteractArgs.lastCompletedStage.groupIndex = curPage
    dynInteractArgs.lastCompletedStage.id = cfg.id
    dynInteractArgs.lastCompletedStage.isState = isState
  end
end

function SectorLevelUtil.GetLevelGroupByNormalMulLine(arrangeCfg, levelList, sectorStageIdGroupMapping, sectorAvgIdGroupMapping)
  local levelGroupDataList = {}
  local lastLocalsDataList = {}
  local dynInteractArgs = {
    splitPointPage = nil,
    finalPage = nil,
    layourDic = nil,
    _sectorStageIdGroupMapping = sectorStageIdGroupMapping,
    _sectorAvgIdGroupMapping = sectorAvgIdGroupMapping,
    lastCompletedStage = {
      groupIndex = nil,
      id = nil,
      isState = nil
    }
  }
  local avgPlayCtrl = ControllerManager:GetController(ControllerTypeId.AvgPlay)
  local sectorStageCfg = levelList
  for k, stageId in ipairs(sectorStageCfg) do
    local stage = ConfigData.sector_stage[stageId]
    local para2num = avgPlayCtrl:GetMainAvgPara2Num(stageId, 1)
    local preStageCount = stage.pre_stage ~= nil and #stage.pre_stage or 0
    local isMerge = 1 < preStageCount
    local splitPage = dynInteractArgs.splitPointPage ~= nil and preStageCount == 1 and dynInteractArgs.splitPointPage[stage.pre_stage[1]] or nil
    local realArrangeCfg = arrangeCfg
    if (stage.special_arrange or 0) ~= 0 and stage.special_arrange ~= realArrangeCfg[1].typeId then
      realArrangeCfg = ConfigData.level_arrange[stage.special_arrange]
    end
    for i = 0, para2num - 1 do
      local avgCfg = avgPlayCtrl:TryGetAvgCfg(eAvgTriggerType.MainAvg, stageId, 1, i)
      if avgCfg ~= nil then
        SectorLevelUtil.GenRoadLayout(avgCfg, realArrangeCfg, stageId, false, avgPlayCtrl, isMerge, splitPage, stage.pre_stage, dynInteractArgs)
        isMerge = false
        splitPage = nil
      end
    end
    SectorLevelUtil.GenRoadLayout(stage, realArrangeCfg, stageId, true, avgPlayCtrl, isMerge, splitPage, stage.pre_stage, dynInteractArgs)
    isMerge = false
    splitPage = nil
    local para2num = avgPlayCtrl:GetMainAvgPara2Num(stageId, 2)
    for i = 0, para2num - 1 do
      local avgCfg = avgPlayCtrl:TryGetAvgCfg(eAvgTriggerType.MainAvg, stageId, 2, i)
      if avgCfg ~= nil then
        SectorLevelUtil.GenRoadLayout(avgCfg, realArrangeCfg, stageId, false, avgPlayCtrl, isMerge, splitPage, {stageId}, dynInteractArgs)
        isMerge = false
        splitPage = nil
      end
    end
  end
  for index = 1, dynInteractArgs.finalPage or 0 do
    local levelLocals = {
      locals = {},
      maxDistance = 0
    }
    local levelGroupData = {}
    local maxDistance = 0
    local tabCount = 0
    for layoutId, content in pairs(dynInteractArgs.layourDic) do
      local levelArrange = ConfigData.level_arrange[layoutId]
      local curTabs = content.data[index]
      if curTabs ~= nil then
        local count = #curTabs
        local arrange = levelArrange[count]
        table.insert(levelLocals.locals, {
          tab = curTabs[count],
          pos = arrange.pos
        })
        if dynInteractArgs.isVertical then
          maxDistance = maxDistance < arrange.pos[2] and maxDistance or arrange.pos[2]
        else
          maxDistance = maxDistance > arrange.pos[1] and maxDistance or arrange.pos[1]
        end
        levelGroupData[layoutId] = curTabs
        tabCount = tabCount + 1
      end
    end
    levelLocals.maxDistance = maxDistance
    table.insert(levelGroupDataList, levelGroupData)
    table.insert(lastLocalsDataList, levelLocals)
  end
  return levelGroupDataList, lastLocalsDataList, dynInteractArgs.lastCompletedStage, dynInteractArgs.finalPage, dynInteractArgs._sectorStageIdGroupMapping, dynInteractArgs._sectorAvgIdGroupMapping
end

function SectorLevelUtil.GenRoadLayoutNoMerge(cfg, arrangeCfg, stageId, preStages, dynInteractArgs)
  local layoutId = arrangeCfg[1].typeId
  local layoutCapacity = #arrangeCfg
  if dynInteractArgs.finalPage == nil then
    dynInteractArgs.finalPage = 1
  end
  if dynInteractArgs.layourDic == nil then
    dynInteractArgs.layourDic = {}
  end
  local layoutContent = dynInteractArgs.layourDic[layoutId]
  if layoutContent == nil then
    layoutContent = {
      curPage = dynInteractArgs.finalPage,
      data = {
        [dynInteractArgs.finalPage] = {}
      }
    }
    dynInteractArgs.layourDic[layoutId] = layoutContent
  end
  if layoutContent.data[layoutContent.curPage] ~= nil and layoutCapacity <= #layoutContent.data[layoutContent.curPage] then
    layoutContent.curPage = layoutContent.curPage + 1
    layoutContent.data[layoutContent.curPage] = {}
    if layoutContent.curPage > dynInteractArgs.finalPage then
      dynInteractArgs.finalPage = layoutContent.curPage
    end
  end
  local curPage = layoutContent.curPage
  local layoutContentData = layoutContent.data[curPage]
  if layoutContentData == nil then
    layoutContentData = {}
    layoutContent.data[curPage] = layoutContentData
  end
  local tab = {}
  tab.connecId = stageId
  tab.preStages = preStages
  tab.stageCfg = cfg
  dynInteractArgs._sectorStageIdGroupMapping[cfg.id] = curPage
  table.insert(layoutContentData, tab)
  if PlayerDataCenter.sectorStage:IsStageComplete(cfg.id) then
    dynInteractArgs.lastCompletedStage.groupIndex = curPage
    dynInteractArgs.lastCompletedStage.id = cfg.id
    dynInteractArgs.lastCompletedStage.isState = true
  end
end

function SectorLevelUtil.GetLevelGroupByOneLineAndNoAvg(arrangeCfg, levelList, sectorStageIdGroupMapping)
  local levelGroupDataList = {}
  local lastLocalsDataList = {}
  local dynInteractArgs = {
    finalPage = nil,
    layourDic = nil,
    _sectorStageIdGroupMapping = sectorStageIdGroupMapping,
    lastCompletedStage = {
      groupIndex = nil,
      id = nil,
      isState = nil
    }
  }
  local sectorStageCfg = levelList
  for k, stageId in ipairs(sectorStageCfg) do
    local stage = ConfigData.sector_stage[stageId]
    SectorLevelUtil.GenRoadLayoutNoMerge(stage, arrangeCfg, stageId, stage.pre_stage, dynInteractArgs)
  end
  for index = 1, dynInteractArgs.finalPage or 0 do
    local levelLocals = {
      locals = {},
      maxDistance = 0
    }
    local levelGroupData = {}
    local maxDistance = 0
    local tabCount = 0
    for layoutId, content in pairs(dynInteractArgs.layourDic) do
      local levelArrange = ConfigData.level_arrange[layoutId]
      local curTabs = content.data[index]
      if curTabs ~= nil then
        local count = #curTabs
        local arrange = levelArrange[count]
        table.insert(levelLocals.locals, {
          tab = curTabs[count],
          pos = arrange.pos
        })
        if dynInteractArgs.isVertical then
          maxDistance = maxDistance < arrange.pos[2] and maxDistance or arrange.pos[2]
        else
          maxDistance = maxDistance > arrange.pos[1] and maxDistance or arrange.pos[1]
        end
        levelGroupData[layoutId] = curTabs
        tabCount = tabCount + 1
      end
    end
    levelLocals.maxDistance = maxDistance
    table.insert(levelGroupDataList, levelGroupData)
    table.insert(lastLocalsDataList, levelLocals)
  end
  return levelGroupDataList, lastLocalsDataList, dynInteractArgs.lastCompletedStage, dynInteractArgs.finalPage, dynInteractArgs._sectorStageIdGroupMapping
end

return SectorLevelUtil
