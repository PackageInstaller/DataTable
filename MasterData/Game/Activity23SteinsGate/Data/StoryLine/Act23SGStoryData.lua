local Act23SGStoryData = class("Act23SGStoryData")
local Act23SGStoryNodeData = require("Game.Activity23SteinsGate.Data.StoryLine.Act23SGStoryNodeData")
local Act23SGStoryLineData = require("Game.Activity23SteinsGate.Data.StoryLine.Act23SGStoryLineData")
local Act23SteinsGateEnum = require("Game.Activity23SteinsGate.Data.Act23SteinsGateEnum")

function Act23SGStoryData:ctor(sgData)
  self.sgData = sgData
  self.__curStoryStepIndex = nil
  self.__curDiffIndex = nil
  self.__isFirstSelectDiff = false
  self.__diffList = nil
  self.__LineDataList = {}
  self.__NodeDataDic = {}
  self:__GenAllData()
  self:GenAllDiffData()
end

function Act23SGStoryData:__GenAllData()
  for lineIndex, _ in ipairs(ConfigData.activity_23steinsgate_map.lineNodeListDic) do
    local lineData = Act23SGStoryLineData.New(lineIndex)
    self.__LineDataList[lineIndex] = lineData
  end
  for sNodeId, nodeCfg in pairs(ConfigData.activity_23steinsgate_storyline) do
    local sNodeData = Act23SGStoryNodeData.New(sNodeId, nodeCfg, self.sgData)
    self.__NodeDataDic[sNodeId] = sNodeData
    local PosPair = ConfigData.activity_23steinsgate_map.storyId2PosDic[sNodeId]
    if PosPair ~= nil then
      local lineIndex = PosPair.line
      if 0 < lineIndex then
        local lineData = self.__LineDataList[lineIndex]
        if not lineData:Act23GSLN_GetIsLineCouldShow() and sNodeData:Act23GSSN_GetIsChoulShow() then
          lineData:Act23GSLN_SetIsCouldShow(true)
        end
      end
    end
  end
end

function Act23SGStoryData:GenAllDiffData()
  local diffList = {}
  local mainCfg = self.sgData:GetSteinsGateCfg()
  for _, sectorId in pairs(mainCfg.level_sector) do
    local diffCfg = ConfigData.activity_23steinsgate_diff[sectorId]
    if diffCfg == nil then
      error("map sector not as a diff, sectorId:" .. tostring(sectorId))
    end
    table.insert(diffList, diffCfg)
  end
  table.sort(diffList, function(a, b)
    return a.sort < b.sort
  end)
  self.__diffList = diffList
  local defaultDiff
  for _, diffCfg in ipairs(diffList) do
    if CheckCondition.CheckLua(diffCfg.pre_condition, diffCfg.pre_para1, diffCfg.pre_para1) then
      defaultDiff = diffCfg.difficulty_id
      break
    end
  end
  local saveUserData = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData)
  local recordDiffIndex = saveUserData:GetSteinsGateDiff(self.sgData:GetActId())
  self.__curDiffIndex = recordDiffIndex or defaultDiff
  if recordDiffIndex == nil then
    self.__isFirstSelectDiff = true
  end
end

function Act23SGStoryData:Act23SG_UpdateAllData()
  for sNodeId, sNodeData in pairs(self.__NodeDataDic) do
    sNodeData:Act23GSSN_UpdateIsCouldShow()
    local lineindex = sNodeData:Act23GSSN_GetLineIndex()
    local lineData = self.__LineDataList[lineindex]
    if lineData ~= nil and not lineData:Act23GSLN_GetIsLineCouldShow() and sNodeData:Act23GSSN_GetIsChoulShow() then
      lineData:Act23GSLN_SetIsCouldShow(true)
    end
  end
end

function Act23SGStoryData:Act23Gs_GetIsNodeStage(stageId)
  for _, nodeData in pairs(self.__NodeDataDic) do
    local isHave, diff = nodeData:Act23GSSN_GetIsHaveStageId(stageId)
    if isHave then
      return true, nodeData
    end
  end
  return false
end

function Act23SGStoryData:Act23SG_GetNodeData(sNodeId)
  return self.__NodeDataDic[sNodeId]
end

function Act23SGStoryData:Act23SG_GetLineData(lineIndex)
  return self.__LineDataList[lineIndex]
end

function Act23SGStoryData:Act23SG_GetAllNodeData()
  return self.__NodeDataDic
end

function Act23SGStoryData:Act23Gs_GetLineData()
  return self.__LineDataList
end

function Act23SGStoryData:Act23Gs_GetDiffList()
  return self.__diffList
end

function Act23SGStoryData:Act23Gs_SetDiffIndex(diffIndex)
  self.__curDiffIndex = diffIndex
  local saveUserData = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData)
  saveUserData:RecordSteinsGateDiff(self.sgData:GetActId(), diffIndex)
  self.__isFirstSelectDiff = false
end

function Act23SGStoryData:Act23Gs_GetDiffIndex()
  return self.__curDiffIndex
end

function Act23SGStoryData:Act23Gs_GetIsNeedFirstSelectDiff()
  return self.__isFirstSelectDiff
end

function Act23SGStoryData:Act23Gs_SetIsNeedFirstSelectDiff()
  self.__isFirstSelectDiff = false
end

function Act23SGStoryData:GetCurNode()
  local curNodeData
  for _, nodeData in pairs(self:Act23SG_GetAllNodeData()) do
    if nodeData:Act23GSSN_GetIsChoulShow() and nodeData:Act23GSSN_GetIsUnlock() then
      if curNodeData == nil then
        curNodeData = nodeData
      elseif nodeData:Act23GSSN_GetNodeID() > curNodeData:Act23GSSN_GetNodeID() then
        curNodeData = nodeData
      end
    end
  end
  return curNodeData
end

function Act23SGStoryData:GetCurOpenNode()
  local curNodeData
  for _, nodeData in pairs(self:Act23SG_GetAllNodeData()) do
    if nodeData:Act23GSSN_GetIsOpen() then
      if curNodeData == nil then
        curNodeData = nodeData
      elseif nodeData:Act23GSSN_GetNodeID() > curNodeData:Act23GSSN_GetNodeID() then
        curNodeData = nodeData
      end
    end
  end
  return curNodeData
end

function Act23SGStoryData:GetCurNeedBattleNode(diff)
  local curNodeData
  for _, nodeData in pairs(self:Act23SG_GetAllNodeData()) do
    if nodeData:Act23GSSN_GetIsBattleNode() and nodeData:Act23GSSN_GetIsChoulShow() and nodeData:Act23GSSN_GetIsUnlock(diff) then
      if curNodeData == nil then
        curNodeData = nodeData
      elseif nodeData:Act23GSSN_GetNodeID() > curNodeData:Act23GSSN_GetNodeID() then
        curNodeData = nodeData
      end
    end
  end
  return curNodeData
end

return Act23SGStoryData
